import '../../../../core/identifiers/entity_id.dart';
import '../entities/installed_collection.dart';

abstract interface class InstalledCollectionRepository {
  Future<List<InstalledCollection>> getAll();

  Future<InstalledCollection> insert(InstalledCollection collection);

  Future<InstalledCollection> getByCollectionId(CollectionId collectionId);

  Future<InstalledCollection> getById(InstalledCollectionId id);

  Future<InstalledCollection?> getByCollectionVersion({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
  });

  Stream<List<InstalledCollection>> watchAll();

  Future<void> deleteWithProgress(InstalledCollectionId id);
}
