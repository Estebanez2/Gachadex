import '../../../../core/identifiers/entity_id.dart';
import '../entities/installed_collection.dart';

abstract interface class InstalledCollectionRepository {
  Future<InstalledCollection> insert(InstalledCollection collection);

  Future<InstalledCollection> getByCollectionId(CollectionId collectionId);

  Stream<List<InstalledCollection>> watchAll();

  Future<void> deleteWithProgress(InstalledCollectionId id);
}
