import '../../../../core/identifiers/entity_id.dart';
import '../entities/content_version.dart';

abstract interface class ContentVersionRepository {
  Future<ContentVersion> createInitialVersion(CollectionId collectionId);

  Future<ContentVersion> getCurrentVersion(CollectionId collectionId);

  Future<List<ContentVersion>> listVersions(CollectionId collectionId);
}
