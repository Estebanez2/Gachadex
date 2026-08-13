import '../../../../core/identifiers/entity_id.dart';
import '../entities/pack_inventory.dart';

abstract interface class PackInventoryRepository {
  Future<List<PackInventory>> getAll();

  Stream<List<PackInventory>> watchAll();

  Future<List<PackInventory>> getByInstalledCollection(
    InstalledCollectionId installedCollectionId,
  );

  Stream<List<PackInventory>> watchByInstalledCollection(
    InstalledCollectionId installedCollectionId,
  );

  Future<void> replaceAllForInstalledCollection({
    required InstalledCollectionId installedCollectionId,
    required List<PackInventory> inventories,
  });

  Future<void> update(PackInventory inventory);
}
