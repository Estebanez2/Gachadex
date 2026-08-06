import '../entities/collection_project.dart';
import '../entities/content_version.dart';
import '../value_objects/draft_cover_style.dart';
import '../../../../core/identifiers/entity_id.dart';

typedef CreatedCollectionDraft = ({
  CollectionProject project,
  ContentVersion contentVersion,
});

abstract interface class CollectionProjectRepository {
  Future<CreatedCollectionDraft> createDraft({
    String name = '',
    String? author,
    String? description,
    DraftCoverStyle? draftCoverStyle,
  });

  Future<CollectionProject> getById(CollectionProjectId id);

  Stream<CollectionProject?> watchById(CollectionProjectId id);

  Stream<List<CollectionProject>> watchAllDrafts();

  Future<CollectionProject> updateBasicInformation({
    required CollectionProjectId id,
    required String name,
    String? author,
    String? description,
  });

  Future<CollectionProject> updateDraftCover({
    required CollectionProjectId id,
    required DraftCoverStyle draftCoverStyle,
  });

  Future<CollectionProject> touchUpdatedAt(CollectionProjectId id);

  Future<CollectionProject> markFinalized(CollectionProjectId id);

  Future<void> deleteDraft(CollectionProjectId id);
}
