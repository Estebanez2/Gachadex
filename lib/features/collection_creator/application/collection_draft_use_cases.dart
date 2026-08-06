import '../../../core/errors/app_failure.dart';
import '../../../core/identifiers/entity_id.dart';
import '../domain/entities/collection_project.dart';
import '../domain/repositories/collection_project_repository.dart';
import '../domain/validation/collection_draft_validation.dart';
import '../domain/value_objects/draft_cover_style.dart';

final class CreateCollectionDraft {
  const CreateCollectionDraft(this._repository);

  final CollectionProjectRepository _repository;

  Future<CollectionProjectId> call() async {
    final created = await _repository.createDraft(
      draftCoverStyle: DraftCoverStyle.defaultStyle(),
    );
    return created.project.id;
  }
}

final class UpdateCollectionDraftInfo {
  const UpdateCollectionDraftInfo(this._repository);

  final CollectionProjectRepository _repository;

  Future<CollectionProject> call({
    required CollectionProjectId id,
    required String name,
    required String author,
    required String description,
  }) {
    final errors = CollectionDraftValidation.validateInfo(
      name: name,
      author: author,
      description: description,
    );
    if (!errors.canSave) {
      throw const InvalidEntityFailure(
        'Hay campos del borrador que no se pueden guardar.',
      );
    }

    return _repository.updateBasicInformation(
      id: id,
      name: name,
      author: author,
      description: description,
    );
  }
}

final class UpdateDraftCover {
  const UpdateDraftCover(this._repository);

  final CollectionProjectRepository _repository;

  Future<CollectionProject> call({
    required CollectionProjectId id,
    required DraftCoverStyle draftCoverStyle,
  }) {
    return _repository.updateDraftCover(
      id: id,
      draftCoverStyle: draftCoverStyle,
    );
  }
}

final class DeleteCollectionDraft {
  const DeleteCollectionDraft(this._repository);

  final CollectionProjectRepository _repository;

  Future<void> call(CollectionProjectId id) {
    return _repository.deleteDraft(id);
  }
}
