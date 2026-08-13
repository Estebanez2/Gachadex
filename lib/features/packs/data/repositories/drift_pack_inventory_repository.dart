import '../../../../core/database/app_database.dart' hide PackInventory;
import '../../../../core/identifiers/entity_id.dart';
import '../../domain/entities/pack_inventory.dart';
import '../../domain/repositories/pack_inventory_repository.dart';
import '../mappers/progress_mappers.dart';

final class DriftPackInventoryRepository implements PackInventoryRepository {
  DriftPackInventoryRepository({required this.database});

  final AppDatabase database;

  @override
  Future<List<PackInventory>> getAll() async {
    final rows = await database.select(database.packInventory).get();
    return rows.map((row) => row.toDomain()).toList(growable: false);
  }

  @override
  Future<List<PackInventory>> getByInstalledCollection(
    InstalledCollectionId installedCollectionId,
  ) async {
    final rows = await database.playerProgressDao.getPackInventory(
      installedCollectionId.value,
    );
    return rows.map((row) => row.toDomain()).toList(growable: false);
  }

  @override
  Stream<List<PackInventory>> watchByInstalledCollection(
    InstalledCollectionId installedCollectionId,
  ) {
    return database.playerProgressDao
        .watchPackInventory(installedCollectionId.value)
        .map((rows) => rows.map((row) => row.toDomain()).toList());
  }

  @override
  Future<void> replaceAllForInstalledCollection({
    required InstalledCollectionId installedCollectionId,
    required List<PackInventory> inventories,
  }) {
    return database.transaction(() async {
      await (database.delete(database.packInventory)..where(
            (table) =>
                table.installedCollectionId.equals(installedCollectionId.value),
          ))
          .go();
      for (final inventory in inventories) {
        await database
            .into(database.packInventory)
            .insert(inventory.toCompanion());
      }
    });
  }

  @override
  Future<void> update(PackInventory inventory) async {
    await database
        .into(database.packInventory)
        .insertOnConflictUpdate(inventory.toCompanion());
  }
}
