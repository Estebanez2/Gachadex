import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_providers.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../../../../core/logging/app_logger.dart';
import '../../../rarities/domain/entities/rarity.dart';
import '../../application/collection_draft_use_case_providers.dart';
import '../../domain/entities/collection_project.dart';
import '../../domain/validation/collection_draft_validation.dart';
import '../../domain/value_objects/draft_cover_style.dart';

enum DraftSaveStatus { saved, pending, saving, error }

final class CollectionDraftSummary {
  const CollectionDraftSummary({
    required this.project,
    required this.rarityCount,
    required this.completeness,
  });

  final CollectionProject project;
  final int rarityCount;
  final CollectionDraftCompleteness completeness;
}

final class CollectionDraftEditorState {
  const CollectionDraftEditorState({
    required this.project,
    required this.name,
    required this.author,
    required this.description,
    required this.draftCoverStyle,
    required this.rarities,
    required this.saveStatus,
    required this.infoErrors,
    required this.saveError,
  });

  factory CollectionDraftEditorState.fromProject({
    required CollectionProject project,
    required List<Rarity> rarities,
  }) {
    final author = project.author ?? '';
    final description = project.description ?? '';
    final errors = CollectionDraftValidation.validateInfo(
      name: project.name,
      author: author,
      description: description,
    );

    return CollectionDraftEditorState(
      project: project,
      name: project.name,
      author: author,
      description: description,
      draftCoverStyle: project.draftCoverStyle,
      rarities: rarities,
      saveStatus: DraftSaveStatus.saved,
      infoErrors: errors,
      saveError: null,
    );
  }

  final CollectionProject project;
  final String name;
  final String author;
  final String description;
  final DraftCoverStyle draftCoverStyle;
  final List<Rarity> rarities;
  final DraftSaveStatus saveStatus;
  final CollectionDraftInfoErrors infoErrors;
  final Object? saveError;

  CollectionDraftCompleteness get completeness {
    return CollectionDraftValidation.completeness(
      name: name,
      coverStyle: draftCoverStyle,
      rarityCount: rarities.length,
      infoErrors: infoErrors,
    );
  }

  bool get canPersistInfo => infoErrors.canSave;

  CollectionDraftEditorState copyWith({
    CollectionProject? project,
    String? name,
    String? author,
    String? description,
    DraftCoverStyle? draftCoverStyle,
    List<Rarity>? rarities,
    DraftSaveStatus? saveStatus,
    CollectionDraftInfoErrors? infoErrors,
    Object? saveError,
    bool clearSaveError = false,
  }) {
    return CollectionDraftEditorState(
      project: project ?? this.project,
      name: name ?? this.name,
      author: author ?? this.author,
      description: description ?? this.description,
      draftCoverStyle: draftCoverStyle ?? this.draftCoverStyle,
      rarities: rarities ?? this.rarities,
      saveStatus: saveStatus ?? this.saveStatus,
      infoErrors: infoErrors ?? this.infoErrors,
      saveError: clearSaveError ? null : saveError ?? this.saveError,
    );
  }
}

final collectionDraftSummariesProvider =
    StreamProvider.autoDispose<List<CollectionDraftSummary>>((ref) {
      final projectRepository = ref.watch(collectionProjectRepositoryProvider);
      final rarityRepository = ref.watch(rarityRepositoryProvider);

      return projectRepository.watchAllDrafts().asyncMap((projects) async {
        final summaries = <CollectionDraftSummary>[];
        for (final project in projects) {
          final contentVersionId = project.currentContentVersionId;
          final rarityCount = contentVersionId == null
              ? 0
              : await rarityRepository.countByCollectionVersion(
                  collectionId: project.collectionId,
                  contentVersionId: contentVersionId,
                );
          final errors = CollectionDraftValidation.validateInfo(
            name: project.name,
            author: project.author ?? '',
            description: project.description ?? '',
          );
          final completeness = CollectionDraftValidation.completeness(
            name: project.name,
            coverStyle: project.draftCoverStyle,
            rarityCount: rarityCount,
            infoErrors: errors,
          );
          summaries.add(
            CollectionDraftSummary(
              project: project,
              rarityCount: rarityCount,
              completeness: completeness,
            ),
          );
        }

        return summaries;
      });
    });

final createDraftControllerProvider =
    NotifierProvider.autoDispose<
      CreateDraftController,
      AsyncValue<CollectionProjectId?>
    >(CreateDraftController.new);

final collectionDraftControllerProvider = NotifierProvider.autoDispose
    .family<
      CollectionDraftController,
      AsyncValue<CollectionDraftEditorState>,
      CollectionProjectId
    >(CollectionDraftController.new);

final class CreateDraftController
    extends Notifier<AsyncValue<CollectionProjectId?>> {
  @override
  AsyncValue<CollectionProjectId?> build() {
    return const AsyncData(null);
  }

  Future<CollectionProjectId?> create() async {
    if (state.isLoading) {
      return null;
    }

    state = const AsyncLoading();
    try {
      final projectId = await ref.read(createCollectionDraftProvider).call();
      state = AsyncData(projectId);
      return projectId;
    } on Object catch (error, stackTrace) {
      AppLogger.error(
        'Failed to create draft from UI.',
        error: error,
        stackTrace: stackTrace,
      );
      state = AsyncError(error, stackTrace);
      return null;
    }
  }
}

final class CollectionDraftController
    extends Notifier<AsyncValue<CollectionDraftEditorState>> {
  CollectionDraftController(this._projectId);

  static const debounceDuration = Duration(milliseconds: 550);

  final CollectionProjectId _projectId;

  Timer? _debounceTimer;
  StreamSubscription<CollectionProject?>? _projectSubscription;
  StreamSubscription<List<Rarity>>? _raritySubscription;
  int _revision = 0;
  bool _disposed = false;

  @override
  AsyncValue<CollectionDraftEditorState> build() {
    ref.onDispose(_dispose);
    _load();
    return const AsyncLoading();
  }

  void editName(String value) {
    _editInfo(name: value);
  }

  void editAuthor(String value) {
    _editInfo(author: value);
  }

  void editDescription(String value) {
    _editInfo(description: value);
  }

  void editCover(DraftCoverStyle draftCoverStyle) {
    final current = state.asData?.value;
    if (current == null || current.draftCoverStyle == draftCoverStyle) {
      return;
    }

    _revision++;
    final updated = current.copyWith(
      draftCoverStyle: draftCoverStyle,
      saveStatus: DraftSaveStatus.pending,
      clearSaveError: true,
    );
    state = AsyncData(updated);
    _scheduleSave();
  }

  Future<void> retrySave() {
    return flushPendingSave();
  }

  Future<void> flushPendingSave() async {
    _debounceTimer?.cancel();
    _debounceTimer = null;
    await _saveCurrentRevision();
  }

  void _editInfo({String? name, String? author, String? description}) {
    final current = state.asData?.value;
    if (current == null) {
      return;
    }

    final nextName = name ?? current.name;
    final nextAuthor = author ?? current.author;
    final nextDescription = description ?? current.description;
    final errors = CollectionDraftValidation.validateInfo(
      name: nextName,
      author: nextAuthor,
      description: nextDescription,
    );
    _revision++;

    state = AsyncData(
      current.copyWith(
        name: nextName,
        author: nextAuthor,
        description: nextDescription,
        infoErrors: errors,
        saveStatus: errors.canSave
            ? DraftSaveStatus.pending
            : DraftSaveStatus.error,
        clearSaveError: true,
      ),
    );

    if (errors.canSave) {
      _scheduleSave();
    } else {
      _debounceTimer?.cancel();
      _debounceTimer = null;
    }
  }

  Future<void> _load() async {
    try {
      final project = await ref
          .read(collectionProjectRepositoryProvider)
          .getById(_projectId);
      final contentVersionId = project.currentContentVersionId;
      if (contentVersionId == null) {
        throw const InvalidEntityFailure(
          'El borrador no tiene version de contenido.',
        );
      }

      final rarities = await ref
          .read(rarityRepositoryProvider)
          .watchByCollectionVersion(
            collectionId: project.collectionId,
            contentVersionId: contentVersionId,
          )
          .first;

      if (_disposed) {
        return;
      }

      state = AsyncData(
        CollectionDraftEditorState.fromProject(
          project: project,
          rarities: rarities,
        ),
      );
      _listenForDeletion();
      _listenForRarities(
        collectionId: project.collectionId,
        contentVersionId: contentVersionId,
      );
    } on Object catch (error, stackTrace) {
      if (_disposed) {
        return;
      }
      state = AsyncError(error, stackTrace);
    }
  }

  void _listenForDeletion() {
    _projectSubscription?.cancel();
    _projectSubscription = ref
        .read(collectionProjectRepositoryProvider)
        .watchById(_projectId)
        .listen((project) {
          if (_disposed) {
            return;
          }
          if (project == null) {
            state = const AsyncError(
              EntityNotFoundFailure('No se encontro el proyecto.'),
              StackTrace.empty,
            );
          }
        });
  }

  void _listenForRarities({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
  }) {
    _raritySubscription?.cancel();
    _raritySubscription = ref
        .read(rarityRepositoryProvider)
        .watchByCollectionVersion(
          collectionId: collectionId,
          contentVersionId: contentVersionId,
        )
        .listen((rarities) {
          if (_disposed) {
            return;
          }
          final current = state.asData?.value;
          if (current == null) {
            return;
          }
          state = AsyncData(current.copyWith(rarities: rarities));
        });
  }

  void _scheduleSave() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(debounceDuration, () {
      _saveCurrentRevision();
    });
  }

  Future<void> _saveCurrentRevision() async {
    final current = state.asData?.value;
    if (current == null || !current.canPersistInfo) {
      return;
    }

    final targetRevision = _revision;
    state = AsyncData(
      current.copyWith(
        saveStatus: DraftSaveStatus.saving,
        clearSaveError: true,
      ),
    );

    try {
      var project = await ref
          .read(updateCollectionDraftInfoProvider)
          .call(
            id: current.project.id,
            name: current.name,
            author: current.author,
            description: current.description,
          );
      if (project.draftCoverStyle != current.draftCoverStyle) {
        project = await ref
            .read(updateDraftCoverProvider)
            .call(
              id: current.project.id,
              draftCoverStyle: current.draftCoverStyle,
            );
      }

      if (_disposed || targetRevision != _revision) {
        return;
      }

      final latest = state.asData?.value;
      if (latest == null) {
        return;
      }

      state = AsyncData(
        latest.copyWith(
          project: project,
          saveStatus: DraftSaveStatus.saved,
          clearSaveError: true,
        ),
      );
    } on Object catch (error, stackTrace) {
      AppLogger.error(
        'Failed to autosave collection draft.',
        error: error,
        stackTrace: stackTrace,
      );
      if (_disposed || targetRevision != _revision) {
        return;
      }
      final latest = state.asData?.value;
      if (latest != null) {
        state = AsyncData(
          latest.copyWith(saveStatus: DraftSaveStatus.error, saveError: error),
        );
      } else {
        state = AsyncError(error, stackTrace);
      }
    }
  }

  void _dispose() {
    _disposed = true;
    _debounceTimer?.cancel();
    _projectSubscription?.cancel();
    _raritySubscription?.cancel();
  }
}
