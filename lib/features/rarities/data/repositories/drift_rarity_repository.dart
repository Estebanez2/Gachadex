import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../../../cards/domain/repositories/card_repository.dart';
import '../../domain/entities/rarity.dart';
import '../../domain/repositories/rarity_repository.dart';
import '../mappers/rarity_mapper.dart';

final class DriftRarityRepository implements RarityRepository {
  DriftRarityRepository({required this.database, required this.cardRepository});

  final AppDatabase database;
  final CardRepository cardRepository;

  @override
  Future<Rarity> insert(Rarity rarity) async {
    await _ensureContentVersion(rarity.collectionId, rarity.contentVersionId);
    await database.raritiesDao.insertRarity(rarity.toCompanion());
    return rarity;
  }

  @override
  Future<Rarity> update(Rarity rarity) async {
    await getById(rarity.id);
    await _ensureContentVersion(rarity.collectionId, rarity.contentVersionId);
    final replaced = await database.raritiesDao.replaceRarity(
      rarity.toCompanion(),
    );
    if (!replaced) {
      throw const EntityNotFoundFailure('No se encontro la rareza.');
    }

    return rarity;
  }

  @override
  Future<Rarity> getById(RarityId id) async {
    final row = await database.raritiesDao.getById(id.value);
    if (row == null) {
      throw const EntityNotFoundFailure('No se encontro la rareza.');
    }

    return row.toDomain();
  }

  @override
  Stream<List<Rarity>> watchByCollectionVersion({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
  }) {
    return database.raritiesDao
        .watchByCollectionVersion(
          collectionId: collectionId.value,
          contentVersionId: contentVersionId.value,
        )
        .map((rows) => rows.map((row) => row.toDomain()).toList());
  }

  @override
  Future<bool> existsWithNormalizedName({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
    required String normalizedName,
    RarityId? excludingId,
  }) async {
    final rows =
        await (database.select(database.rarities)..where(
              (table) =>
                  table.collectionId.equals(collectionId.value) &
                  table.contentVersionId.equals(contentVersionId.value),
            ))
            .get();
    final target = _normalizeName(normalizedName);

    return rows.any((row) {
      if (excludingId != null && row.id == excludingId.value) {
        return false;
      }

      return _normalizeName(row.name) == target;
    });
  }

  @override
  Future<int> countByCollectionVersion({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
  }) {
    final count = database.rarities.id.count();
    return (database.selectOnly(database.rarities)
          ..addColumns([count])
          ..where(
            database.rarities.collectionId.equals(collectionId.value) &
                database.rarities.contentVersionId.equals(
                  contentVersionId.value,
                ),
          ))
        .map((row) => row.read(count) ?? 0)
        .getSingle();
  }

  @override
  Future<int> countCardsUsingRarity(RarityId rarityId) {
    return cardRepository.countByRarity(rarityId);
  }

  @override
  Future<void> delete(RarityId id) async {
    final count = await cardRepository.countByRarity(id);
    if (count > 0) {
      throw const ReferentialIntegrityFailure(
        'No se puede borrar una rareza usada por cartas.',
      );
    }

    final deleted = await database.raritiesDao.deleteRarity(id.value);
    if (deleted == 0) {
      throw const EntityNotFoundFailure('No se encontro la rareza.');
    }
  }

  @override
  Future<List<Rarity>> reorder({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
    required List<RarityId> orderedIds,
  }) {
    return database.transaction(() async {
      final currentRows =
          await (database.select(database.rarities)..where(
                (table) =>
                    table.collectionId.equals(collectionId.value) &
                    table.contentVersionId.equals(contentVersionId.value),
              ))
              .get();
      final currentIds = currentRows.map((row) => row.id).toSet();
      final orderedValues = orderedIds.map((id) => id.value).toList();
      final orderedSet = orderedValues.toSet();

      if (orderedValues.length != orderedSet.length ||
          currentIds.length != orderedSet.length ||
          !currentIds.containsAll(orderedSet)) {
        throw const InvalidEntityFailure(
          'El nuevo orden de rarezas no coincide con la version actual.',
        );
      }

      for (var index = 0; index < orderedIds.length; index++) {
        await (database.update(database.rarities)
              ..where((table) => table.id.equals(orderedIds[index].value)))
            .write(RaritiesCompanion(orderIndex: Value(1000000 + index)));
      }

      for (var index = 0; index < orderedIds.length; index++) {
        await (database.update(database.rarities)
              ..where((table) => table.id.equals(orderedIds[index].value)))
            .write(RaritiesCompanion(orderIndex: Value(index)));
      }

      final rows =
          await (database.select(database.rarities)
                ..where(
                  (table) =>
                      table.collectionId.equals(collectionId.value) &
                      table.contentVersionId.equals(contentVersionId.value),
                )
                ..orderBy([(table) => OrderingTerm.asc(table.orderIndex)]))
              .get();
      return rows.map((row) => row.toDomain()).toList(growable: false);
    });
  }

  String _normalizeName(String value) {
    return value.trim().toLowerCase();
  }

  Future<void> _ensureContentVersion(
    CollectionId collectionId,
    ContentVersionId contentVersionId,
  ) async {
    final row =
        await (database.select(database.contentVersions)
              ..where((table) => table.id.equals(contentVersionId.value)))
            .getSingleOrNull();
    if (row == null || row.collectionId != collectionId.value) {
      throw const ReferentialIntegrityFailure(
        'La version no pertenece a la coleccion.',
      );
    }
  }
}
