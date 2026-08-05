import '../../../../core/database/app_database.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../../domain/entities/pack_card_pool_entry.dart';
import '../../domain/entities/pack_rarity_probability.dart';
import '../../domain/entities/pack_slot_rule.dart';
import '../../domain/entities/pack_type.dart';
import '../../domain/repositories/pack_type_repository.dart';
import '../mappers/pack_rule_mappers.dart';
import '../mappers/pack_type_mapper.dart';

final class DriftPackTypeRepository implements PackTypeRepository {
  DriftPackTypeRepository({required this.database});

  final AppDatabase database;

  @override
  Future<PackType> insert(PackType packType) async {
    await _validateReferences(packType);
    await database.packTypesDao.insertPackType(packType.toCompanion());
    return packType;
  }

  @override
  Future<PackType> update(PackType packType) async {
    await getById(packType.id);
    await _validateReferences(packType);
    final replaced = await database.packTypesDao.replacePackType(
      packType.toCompanion(),
    );
    if (!replaced) {
      throw const EntityNotFoundFailure('No se encontro el sobre.');
    }

    return packType;
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
    final deleted = await database.packTypesDao.deletePackType(id.value);
    if (deleted == 0) {
      throw const EntityNotFoundFailure('No se encontro el sobre.');
    }
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
}
