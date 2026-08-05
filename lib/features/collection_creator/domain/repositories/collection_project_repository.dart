import '../entities/collection_project.dart';
import '../entities/content_version.dart';
import '../../../../core/identifiers/entity_id.dart';

typedef CreatedCollectionDraft = ({
  CollectionProject project,
  ContentVersion contentVersion,
});

abstract interface class CollectionProjectRepository {
  Future<CreatedCollectionDraft> createDraft({
    required String name,
    String? author,
    String? description,
  });

  Future<CollectionProject> getById(CollectionProjectId id);

  Stream<List<CollectionProject>> watchAllDrafts();

  Future<CollectionProject> updateBasicInformation({
    required CollectionProjectId id,
    required String name,
    String? author,
    String? description,
  });

  Future<CollectionProject> markFinalized(CollectionProjectId id);

  Future<void> deleteDraft(CollectionProjectId id);
}
