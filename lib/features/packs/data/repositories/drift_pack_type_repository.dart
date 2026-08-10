import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../../../../core/time/clock.dart';
import '../../domain/entities/pack_card_pool_entry.dart';
import '../../domain/entities/pack_configuration.dart';
import '../../domain/entities/pack_rarity_probability.dart';
import '../../domain/entities/pack_slot_rule.dart';
import '../../domain/entities/pack_type.dart';
import '../../domain/validation/pack_validation.dart';
import '../../domain/repositories/pack_type_repository.dart';
import '../mappers/pack_rule_mappers.dart';
import '../mappers/pack_type_mapper.dart';

final class DriftPackTypeRepository implements PackTypeRepository {
  DriftPackTypeRepository({required this.database, required this.clock});

  final AppDatabase database;
  final Clock clock;

  @override
  Future<PackType> insert(PackType packType) async {
    return createConfiguration(
      PackConfiguration(
        packType: packType,
        pool: const [],
        slotRules: const [],
        probabilities: const [],
      ),
    ).then((config) => config.packType);
  }

  @override
  Future<PackConfiguration> createConfiguration(
    PackConfiguration config,
  ) async {
    await _validateReferences(config.packType);
    final duplicate = await nameExists(
      collectionId: config.packType.collectionId,
      contentVersionId: config.packType.contentVersionId,
      name: config.packType.name,
    );
    if (duplicate) {
      throw const InvalidEntityFailure('Ya existe un sobre con ese nombre.');
    }

    late PackType saved;
    await database.transaction(() async {
      final existing = await _listPackRows(
        collectionId: config.packType.collectionId,
        contentVersionId: config.packType.contentVersionId,
      );
      final shouldBeMain = config.packType.isMain || existing.isEmpty;
      if (shouldBeMain) {
        await _clearMain(
          collectionId: config.packType.collectionId,
          contentVersionId: config.packType.contentVersionId,
        );
      }
      saved = _copyPackType(
        config.packType,
        isMain: shouldBeMain,
        sortIndex: existing.length,
        maxAccumulated: shouldBeMain && config.packType.maxAccumulated < 3
            ? 3
            : config.packType.maxAccumulated,
      );
      await database.packTypesDao.insertPackType(saved.toCompanion());
      await _replaceCardPool(saved.id, config.pool);
      await _replaceSlotRules(saved.id, config.slotRules, config.probabilities);
      await _touchProject(saved.collectionId, saved.contentVersionId);
    });

    return getFullConfiguration(saved.id);
  }

  @override
  Future<PackType> update(PackType packType) async {
    await getById(packType.id);
    await _validateReferences(packType);
    await database.transaction(() async {
      var saved = packType;
      if (packType.isMain) {
        await _clearMain(
          collectionId: packType.collectionId,
          contentVersionId: packType.contentVersionId,
        );
        if (packType.maxAccumulated < 3) {
          saved = _copyPackType(packType, maxAccumulated: 3);
        }
      } else {
        final current = await getById(packType.id);
        if (current.isMain) {
          saved = _copyPackType(
            packType,
            isMain: true,
            maxAccumulated: packType.maxAccumulated < 3
                ? 3
                : packType.maxAccumulated,
          );
        }
      }
      final replaced = await database.packTypesDao.replacePackType(
        saved.toCompanion(),
      );
      if (!replaced) {
        throw const EntityNotFoundFailure('No se encontro el sobre.');
      }
      await _touchProject(saved.collectionId, saved.contentVersionId);
    });

    return getById(packType.id);
  }

  @override
  Future<PackConfiguration> updateConfiguration(
    PackConfiguration config,
  ) async {
    final current = await getById(config.packType.id);
    await _validateReferences(config.packType);
    final duplicate = await nameExists(
      collectionId: config.packType.collectionId,
      contentVersionId: config.packType.contentVersionId,
      name: config.packType.name,
      excludingPackTypeId: config.packType.id,
    );
    if (duplicate) {
      throw const InvalidEntityFailure('Ya existe un sobre con ese nombre.');
    }

    await database.transaction(() async {
      var packType = config.packType;
      if (packType.isMain) {
        await _clearMain(
          collectionId: packType.collectionId,
          contentVersionId: packType.contentVersionId,
        );
        if (packType.maxAccumulated < 3) {
          packType = _copyPackType(packType, maxAccumulated: 3);
        }
      } else if (current.isMain) {
        packType = _copyPackType(
          packType,
          isMain: true,
          maxAccumulated: packType.maxAccumulated < 3
              ? 3
              : packType.maxAccumulated,
        );
      }

      final replaced = await database.packTypesDao.replacePackType(
        packType.toCompanion(),
      );
      if (!replaced) {
        throw const EntityNotFoundFailure('No se encontro el sobre.');
      }
      await _replaceCardPool(packType.id, config.pool);
      await _replaceSlotRules(
        packType.id,
        config.slotRules,
        config.probabilities,
      );
      await _touchProject(packType.collectionId, packType.contentVersionId);
    });

    return getFullConfiguration(config.packType.id);
  }

  @override
  Future<PackType> getById(PackTypeId id) async {
    final row = await database.packTypesDao.getById(id.value);
    if (row == null) {
      throw const EntityNotFoundFailure('No se encontro el sobre.');
    }

    return row.toDomain();
  }

  @override
  Future<PackConfiguration> getFullConfiguration(PackTypeId id) async {
    final packType = await getById(id);
    final poolRows = await (database.select(
      database.packCardPool,
    )..where((table) => table.packTypeId.equals(id.value))).get();
    final ruleRows =
        await (database.select(database.packSlotRules)
              ..where((table) => table.packTypeId.equals(id.value))
              ..orderBy([(table) => OrderingTerm.asc(table.slotIndex)]))
            .get();
    final groupIds = ruleRows
        .map((row) => row.probabilityGroupId)
        .nonNulls
        .toList(growable: false);
    final probabilityRows = groupIds.isEmpty
        ? <PackRarityProbabilityRow>[]
        : await (database.select(
            database.packRarityProbabilities,
          )..where((table) => table.probabilityGroupId.isIn(groupIds))).get();

    return PackConfiguration(
      packType: packType,
      pool: poolRows.map((row) => row.toDomain()).toList(),
      slotRules: ruleRows.map((row) => row.toDomain()).toList(),
      probabilities: probabilityRows.map((row) => row.toDomain()).toList(),
    );
  }

  @override
  Stream<List<PackType>> watchByCollectionVersion({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
  }) {
    return database.packTypesDao
        .watchByCollectionVersion(
          collectionId: collectionId.value,
          contentVersionId: contentVersionId.value,
        )
        .map((rows) => rows.map((row) => row.toDomain()).toList());
  }

  @override
  Future<void> delete(PackTypeId id) async {
    final pack = await getById(id);
    await database.transaction(() async {
      await _deleteRulesAndProbabilities(id);
      final deleted = await database.packTypesDao.deletePackType(id.value);
      if (deleted == 0) {
        throw const EntityNotFoundFailure('No se encontro el sobre.');
      }
      final remaining = await _listPackRows(
        collectionId: pack.collectionId,
        contentVersionId: pack.contentVersionId,
      );
      for (var index = 0; index < remaining.length; index++) {
        final row = remaining[index];
        final isMain = pack.isMain && index == 0 ? true : row.isMain;
        await database.packTypesDao.replacePackType(
          row.toDomain().toCompanion().copyWith(
            sortIndex: Value(index),
            isMain: Value(isMain),
            maxAccumulated: Value(
              isMain && row.maxAccumulated < 3 ? 3 : row.maxAccumulated,
            ),
          ),
        );
      }
      await _touchProject(pack.collectionId, pack.contentVersionId);
    });
  }

  @override
  Future<void> reorder({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
    required List<PackTypeId> orderedIds,
  }) async {
    await database.transaction(() async {
      final rows = await _listPackRows(
        collectionId: collectionId,
        contentVersionId: contentVersionId,
      );
      final rowsById = {for (final row in rows) row.id: row};
      for (var index = 0; index < orderedIds.length; index++) {
        final row = rowsById[orderedIds[index].value];
        if (row == null) {
          throw const ReferentialIntegrityFailure(
            'El orden contiene un sobre externo.',
          );
        }
        await database.packTypesDao.replacePackType(
          row.toDomain().toCompanion().copyWith(sortIndex: Value(index)),
        );
      }
      await _touchProject(collectionId, contentVersionId);
    });
  }

  @override
  Future<void> setMain(PackTypeId id) async {
    final pack = await getById(id);
    await database.transaction(() async {
      await _clearMain(
        collectionId: pack.collectionId,
        contentVersionId: pack.contentVersionId,
      );
      final mainPack = _copyPackType(
        pack,
        isMain: true,
        maxAccumulated: pack.maxAccumulated < 3 ? 3 : pack.maxAccumulated,
      );
      await database.packTypesDao.replacePackType(mainPack.toCompanion());
      await _touchProject(pack.collectionId, pack.contentVersionId);
    });
  }

  @override
  Future<bool> nameExists({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
    required String name,
    PackTypeId? excludingPackTypeId,
  }) async {
    final normalized = PackValidation.normalizedName(name);
    final rows = await _listPackRows(
      collectionId: collectionId,
      contentVersionId: contentVersionId,
    );
    return rows.any((row) {
      if (excludingPackTypeId != null && row.id == excludingPackTypeId.value) {
        return false;
      }
      return PackValidation.normalizedName(row.name) == normalized;
    });
  }

  @override
  Future<void> replaceCardPool({
    required PackTypeId packTypeId,
    required List<PackCardPoolEntry> entries,
  }) async {
    await database.transaction(() async {
      await _replaceCardPool(packTypeId, entries);
      final pack = await getById(packTypeId);
      await _touchProject(pack.collectionId, pack.contentVersionId);
    });
  }

  @override
  Future<void> replaceSlotRules({
    required PackTypeId packTypeId,
    required List<PackSlotRule> rules,
  }) async {
    await database.transaction(() async {
      await _replaceSlotRules(packTypeId, rules, const []);
      final pack = await getById(packTypeId);
      await _touchProject(pack.collectionId, pack.contentVersionId);
    });
  }

  @override
  Future<void> replaceProbabilityGroup({
    required ProbabilityGroupId probabilityGroupId,
    required List<PackRarityProbability> probabilities,
  }) async {
    await database.transaction(() async {
      await _replaceProbabilityGroup(probabilityGroupId, probabilities);
      final rule =
          await (database.select(database.packSlotRules)..where(
                (table) =>
                    table.probabilityGroupId.equals(probabilityGroupId.value),
              ))
              .getSingleOrNull();
      if (rule != null) {
        final pack = await getById(PackTypeId(rule.packTypeId));
        await _touchProject(pack.collectionId, pack.contentVersionId);
      }
    });
  }

  @override
  Future<PackCardPoolEntry> addCardToPool(PackCardPoolEntry entry) async {
    final pack = await _getPackRow(entry.packTypeId);
    final card = await (database.select(
      database.cards,
    )..where((table) => table.id.equals(entry.cardId.value))).getSingleOrNull();
    if (card == null ||
        card.collectionId != pack.collectionId ||
        card.contentVersionId != pack.contentVersionId) {
      throw const ReferentialIntegrityFailure(
        'La carta no pertenece al sobre.',
      );
    }

    await database.into(database.packCardPool).insert(entry.toCompanion());
    await _touchProject(
      CollectionId(pack.collectionId),
      ContentVersionId(pack.contentVersionId),
    );
    return entry;
  }

  @override
  Future<PackSlotRule> addSlotRule(PackSlotRule rule) async {
    final pack = await _getPackRow(rule.packTypeId);
    final fixedRarityId = rule.fixedRarityId;
    if (fixedRarityId != null) {
      final rarity =
          await (database.select(database.rarities)
                ..where((table) => table.id.equals(fixedRarityId.value)))
              .getSingleOrNull();
      if (rarity == null ||
          rarity.collectionId != pack.collectionId ||
          rarity.contentVersionId != pack.contentVersionId) {
        throw const ReferentialIntegrityFailure(
          'La rareza fija no pertenece al sobre.',
        );
      }
    }

    await database.into(database.packSlotRules).insert(rule.toCompanion());
    await _touchProject(
      CollectionId(pack.collectionId),
      ContentVersionId(pack.contentVersionId),
    );
    return rule;
  }

  @override
  Future<PackRarityProbability> addRarityProbability(
    PackRarityProbability probability,
  ) async {
    final slotRule =
        await (database.select(database.packSlotRules)..where(
              (table) => table.probabilityGroupId.equals(
                probability.probabilityGroupId.value,
              ),
            ))
            .getSingleOrNull();
    if (slotRule == null) {
      throw const EntityNotFoundFailure(
        'No se encontro el grupo de probabilidad.',
      );
    }

    final pack = await _getPackRow(PackTypeId(slotRule.packTypeId));
    final rarity =
        await (database.select(database.rarities)
              ..where((table) => table.id.equals(probability.rarityId.value)))
            .getSingleOrNull();
    if (rarity == null ||
        rarity.collectionId != pack.collectionId ||
        rarity.contentVersionId != pack.contentVersionId) {
      throw const ReferentialIntegrityFailure(
        'La probabilidad apunta a una rareza externa.',
      );
    }

    await database
        .into(database.packRarityProbabilities)
        .insert(probability.toCompanion());
    await _touchProject(
      CollectionId(pack.collectionId),
      ContentVersionId(pack.contentVersionId),
    );
    return probability;
  }

  Future<void> _validateReferences(PackType packType) async {
    final version =
        await (database.select(database.contentVersions)..where(
              (table) => table.id.equals(packType.contentVersionId.value),
            ))
            .getSingleOrNull();
    if (version == null ||
        version.collectionId != packType.collectionId.value) {
      throw const ReferentialIntegrityFailure(
        'El sobre no pertenece a una version valida.',
      );
    }

    for (final assetId in [packType.frontAssetId, packType.backAssetId]) {
      if (assetId == null) {
        continue;
      }
      final asset = await (database.select(
        database.mediaAssets,
      )..where((table) => table.id.equals(assetId.value))).getSingleOrNull();
      if (asset == null || asset.collectionId != packType.collectionId.value) {
        throw const ReferentialIntegrityFailure(
          'El recurso del sobre no pertenece a la coleccion.',
        );
      }
    }
  }

  Future<PackTypeRow> _getPackRow(PackTypeId id) async {
    final pack = await (database.select(
      database.packTypes,
    )..where((table) => table.id.equals(id.value))).getSingleOrNull();
    if (pack == null) {
      throw const EntityNotFoundFailure('No se encontro el sobre.');
    }

    return pack;
  }

  Future<List<PackTypeRow>> _listPackRows({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
  }) {
    return (database.select(database.packTypes)
          ..where(
            (table) =>
                table.collectionId.equals(collectionId.value) &
                table.contentVersionId.equals(contentVersionId.value),
          )
          ..orderBy([(table) => OrderingTerm.asc(table.sortIndex)]))
        .get();
  }

  Future<void> _clearMain({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
  }) async {
    final rows = await _listPackRows(
      collectionId: collectionId,
      contentVersionId: contentVersionId,
    );
    for (final row in rows) {
      if (row.isMain) {
        await database.packTypesDao.replacePackType(
          row.toDomain().toCompanion().copyWith(isMain: const Value(false)),
        );
      }
    }
  }

  Future<void> _replaceCardPool(
    PackTypeId packTypeId,
    List<PackCardPoolEntry> entries,
  ) async {
    for (final entry in entries) {
      if (entry.packTypeId != packTypeId) {
        throw const ReferentialIntegrityFailure(
          'La carta elegible apunta a otro sobre.',
        );
      }
    }
    await (database.delete(
      database.packCardPool,
    )..where((table) => table.packTypeId.equals(packTypeId.value))).go();
    for (final entry in entries) {
      await addCardToPool(entry);
    }
  }

  Future<void> _replaceSlotRules(
    PackTypeId packTypeId,
    List<PackSlotRule> rules,
    List<PackRarityProbability> probabilities,
  ) async {
    for (final rule in rules) {
      if (rule.packTypeId != packTypeId) {
        throw const ReferentialIntegrityFailure(
          'La regla apunta a otro sobre.',
        );
      }
    }
    await _deleteRulesAndProbabilities(packTypeId);
    for (final rule in rules) {
      await addSlotRule(rule);
    }
    final groups = rules
        .map((rule) => rule.probabilityGroupId)
        .nonNulls
        .toSet();
    for (final group in groups) {
      await _replaceProbabilityGroup(
        group,
        probabilities
            .where((probability) => probability.probabilityGroupId == group)
            .toList(),
      );
    }
  }

  Future<void> _replaceProbabilityGroup(
    ProbabilityGroupId probabilityGroupId,
    List<PackRarityProbability> probabilities,
  ) async {
    await (database.delete(database.packRarityProbabilities)..where(
          (table) => table.probabilityGroupId.equals(probabilityGroupId.value),
        ))
        .go();
    for (final probability in probabilities) {
      if (probability.probabilityGroupId != probabilityGroupId) {
        throw const ReferentialIntegrityFailure(
          'La probabilidad apunta a otro grupo.',
        );
      }
      if (probability.weight > 0) {
        await addRarityProbability(probability);
      }
    }
  }

  Future<void> _deleteRulesAndProbabilities(PackTypeId packTypeId) async {
    final rules = await (database.select(
      database.packSlotRules,
    )..where((table) => table.packTypeId.equals(packTypeId.value))).get();
    final groups = rules.map((rule) => rule.probabilityGroupId).nonNulls;
    for (final group in groups) {
      await (database.delete(
        database.packRarityProbabilities,
      )..where((table) => table.probabilityGroupId.equals(group))).go();
    }
    await (database.delete(
      database.packSlotRules,
    )..where((table) => table.packTypeId.equals(packTypeId.value))).go();
  }

  Future<void> _touchProject(
    CollectionId collectionId,
    ContentVersionId contentVersionId,
  ) {
    return (database.update(database.collectionProjects)..where(
          (table) =>
              table.collectionId.equals(collectionId.value) &
              table.currentContentVersionId.equals(contentVersionId.value),
        ))
        .write(
          CollectionProjectsCompanion(updatedAtUtc: Value(clock.nowUtc())),
        );
  }

  PackType _copyPackType(
    PackType packType, {
    bool? isMain,
    int? sortIndex,
    int? maxAccumulated,
  }) {
    return PackType(
      id: packType.id,
      collectionId: packType.collectionId,
      contentVersionId: packType.contentVersionId,
      name: packType.name,
      description: packType.description,
      frontAssetId: packType.frontAssetId,
      backAssetId: packType.backAssetId,
      frontStyle: packType.frontStyle,
      backStyle: packType.backStyle,
      cardCount: packType.cardCount,
      rechargeSeconds: packType.rechargeSeconds,
      maxAccumulated: maxAccumulated ?? packType.maxAccumulated,
      isMain: isMain ?? packType.isMain,
      coinsPerFullRecharge: packType.coinsPerFullRecharge,
      sortIndex: sortIndex ?? packType.sortIndex,
    );
  }
}
