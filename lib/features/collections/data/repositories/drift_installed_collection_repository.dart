import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../../domain/entities/installed_collection.dart';
import '../../domain/repositories/installed_collection_repository.dart';
import '../mappers/installed_collection_mapper.dart';

final class DriftInstalledCollectionRepository
    implements InstalledCollectionRepository {
  DriftInstalledCollectionRepository({required this.database});

  final AppDatabase database;

  @override
  Future<List<InstalledCollection>> getAll() async {
    final rows = await (database.select(
      database.installedCollections,
    )..orderBy([(table) => OrderingTerm.desc(table.installedAtUtc)])).get();
    return rows.map((row) => row.toDomain()).toList(growable: false);
  }

  @override
  Future<InstalledCollection> insert(InstalledCollection collection) async {
    await _validateReferences(collection);
    final duplicate =
        await (database.select(database.installedCollections)..where(
              (table) =>
                  table.collectionId.equals(collection.collectionId.value) &
                  table.contentVersionId.equals(
                    collection.contentVersionId.value,
                  ),
            ))
            .getSingleOrNull();
    if (duplicate != null) {
      throw const DuplicateEntityFailure(
        'La coleccion ya esta instalada en esta version.',
      );
    }

    await database.installedCollectionsDao.insertInstalledCollection(
      collection.toCompanion(),
    );
    return collection;
  }

  @override
  Future<InstalledCollection> getByCollectionId(
    CollectionId collectionId,
  ) async {
    final row = await database.installedCollectionsDao.getByCollectionId(
      collectionId.value,
    );
    if (row == null) {
      throw const EntityNotFoundFailure(
        'No se encontro la coleccion instalada.',
      );
    }

    return row.toDomain();
  }

  @override
  Future<InstalledCollection> getById(InstalledCollectionId id) async {
    final row = await database.installedCollectionsDao.getById(id.value);
    if (row == null) {
      throw const EntityNotFoundFailure(
        'No se encontro la coleccion instalada.',
      );
    }

    return row.toDomain();
  }

  @override
  Future<InstalledCollection?> getByCollectionVersion({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
  }) async {
    final row = await database.installedCollectionsDao.getByCollectionVersion(
      collectionId: collectionId.value,
      contentVersionId: contentVersionId.value,
    );
    return row?.toDomain();
  }

  @override
  Stream<List<InstalledCollection>> watchAll() {
    return database.installedCollectionsDao.watchAll().map(
      (rows) => rows.map((row) => row.toDomain()).toList(growable: false),
    );
  }

  @override
  Future<void> deleteWithProgress(InstalledCollectionId id) async {
    final deleted = await database.installedCollectionsDao.deleteWithProgress(
      id.value,
    );
    if (deleted == 0) {
      throw const EntityNotFoundFailure(
        'No se encontro la coleccion instalada.',
      );
    }
  }

  Future<void> _validateReferences(InstalledCollection collection) async {
    final version =
        await (database.select(database.contentVersions)..where(
              (table) => table.id.equals(collection.contentVersionId.value),
            ))
            .getSingleOrNull();
    if (version == null ||
        version.collectionId != collection.collectionId.value) {
      throw const ReferentialIntegrityFailure(
        'La version instalada no pertenece a la coleccion.',
      );
    }

    final mainPackTypeId = collection.mainPackTypeId;
    if (mainPackTypeId != null) {
      final pack =
          await (database.select(database.packTypes)
                ..where((table) => table.id.equals(mainPackTypeId.value)))
              .getSingleOrNull();
      if (pack == null ||
          pack.collectionId != collection.collectionId.value ||
          pack.contentVersionId != collection.contentVersionId.value) {
        throw const ReferentialIntegrityFailure(
          'El sobre principal no pertenece a la coleccion instalada.',
        );
      }
    }
  }
}
