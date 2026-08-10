import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_providers.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../../../../core/logging/app_logger.dart';
import '../../../cards/domain/entities/card.dart' as card_domain;
import '../../../packs/domain/entities/pack_type.dart';
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
    required this.cardCount,
    required this.packCount,
    required this.completeness,
  });

  final CollectionProject project;
  final int rarityCount;
  final int cardCount;
  final int packCount;
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
    required this.cardCount,
    required this.packCount,
    required this.saveStatus,
    required this.infoErrors,
    required this.saveError,
  });

  factory CollectionDraftEditorState.fromProject({
    required CollectionProject project,
    required List<Rarity> rarities,
    required int cardCount,
    required int packCount,
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
      cardCount: cardCount,
      packCount: packCount,
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
  final int cardCount;
  final int packCount;
  final DraftSaveStatus saveStatus;
  final CollectionDraftInfoErrors infoErrors;
  final Object? saveError;

  CollectionDraftCompleteness get completeness {
    return CollectionDraftValidation.completeness(
      name: name,
      coverStyle: draftCoverStyle,
      rarityCount: rarities.length,
      cardCount: cardCount,
      packCount: packCount,
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
    int? cardCount,
    int? packCount,
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
      cardCount: cardCount ?? this.cardCount,
      packCount: packCount ?? this.packCount,
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
      final cardRepository = ref.watch(cardRepositoryProvider);
      final packRepository = ref.watch(packTypeRepositoryProvider);

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
          final cardCount = contentVersionId == null
              ? 0
              : await cardRepository
                    .watchByCollectionVersion(
                      collectionId: project.collectionId,
                      contentVersionId: contentVersionId,
                    )
                    .first
                    .then((cards) => cards.length);
          final packCount = contentVersionId == null
              ? 0
              : await packRepository
                    .watchByCollectionVersion(
                      collectionId: project.collectionId,
                      contentVersionId: contentVersionId,
                    )
                    .first
                    .then((packs) => packs.length);
          final errors = CollectionDraftValidation.validateInfo(
            name: project.name,
            author: project.author ?? '',
            description: project.description ?? '',
          );
          final completeness = CollectionDraftValidation.completeness(
            name: project.name,
            coverStyle: project.draftCoverStyle,
            rarityCount: rarityCount,
            cardCount: cardCount,
            packCount: packCount,
            infoErrors: errors,
          );
          summaries.add(
            CollectionDraftSummary(
              project: project,
              rarityCount: rarityCount,
              cardCount: cardCount,
              packCount: packCount,
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
  StreamSubscription<List<card_domain.Card>>? _cardSubscription;
  StreamSubscription<List<PackType>>? _packSubscription;
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
      final cards = await ref
          .read(cardRepositoryProvider)
          .watchByCollectionVersion(
            collectionId: project.collectionId,
            contentVersionId: contentVersionId,
          )
          .first;
      final packs = await ref
          .read(packTypeRepositoryProvider)
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
          cardCount: cards.length,
          packCount: packs.length,
        ),
      );
      _listenForDeletion();
      _listenForRarities(
        collectionId: project.collectionId,
        contentVersionId: contentVersionId,
      );
      _listenForCards(
        collectionId: project.collectionId,
        contentVersionId: contentVersionId,
      );
      _listenForPacks(
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

  void _listenForCards({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
  }) {
    _cardSubscription?.cancel();
    _cardSubscription = ref
        .read(cardRepositoryProvider)
        .watchByCollectionVersion(
          collectionId: collectionId,
          contentVersionId: contentVersionId,
        )
        .listen((cards) {
          if (_disposed) {
            return;
          }
          final current = state.asData?.value;
          if (current == null) {
            return;
          }
          state = AsyncData(current.copyWith(cardCount: cards.length));
        });
  }

  void _listenForPacks({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
  }) {
    _packSubscription?.cancel();
    _packSubscription = ref
        .read(packTypeRepositoryProvider)
        .watchByCollectionVersion(
          collectionId: collectionId,
          contentVersionId: contentVersionId,
        )
        .listen((packs) {
          if (_disposed) {
            return;
          }
          final current = state.asData?.value;
          if (current == null) {
            return;
          }
          state = AsyncData(current.copyWith(packCount: packs.length));
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
    _cardSubscription?.cancel();
    _packSubscription?.cancel();
  }
}
