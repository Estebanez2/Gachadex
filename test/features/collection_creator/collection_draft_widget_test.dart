import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gachadex/app/localization/app_localizations.dart';
import 'package:gachadex/app/theme/app_theme.dart';
import 'package:gachadex/core/database/database_providers.dart';
import 'package:gachadex/core/domain/domain_enums.dart';
import 'package:gachadex/core/errors/app_failure.dart';
import 'package:gachadex/core/identifiers/entity_id.dart';
import 'package:gachadex/core/identifiers/uuid_generator.dart';
import 'package:gachadex/core/time/clock.dart';
import 'package:gachadex/core/time/fake_clock.dart';
import 'package:gachadex/features/cards/domain/entities/card.dart'
    as card_domain;
import 'package:gachadex/features/cards/domain/repositories/card_repository.dart';
import 'package:gachadex/features/collection_creator/application/collection_draft_use_case_providers.dart';
import 'package:gachadex/features/collection_creator/domain/entities/collection_project.dart';
import 'package:gachadex/features/collection_creator/domain/entities/content_version.dart';
import 'package:gachadex/features/collection_creator/domain/repositories/collection_project_repository.dart';
import 'package:gachadex/features/collection_creator/domain/value_objects/draft_cover_style.dart';
import 'package:gachadex/features/collection_creator/presentation/pages/collection_draft_editor_page.dart';
import 'package:gachadex/features/creator/presentation/creator_page.dart';
import 'package:gachadex/features/rarities/domain/entities/rarity.dart';
import 'package:gachadex/features/rarities/domain/repositories/rarity_repository.dart';
import 'package:gachadex/features/rarities/domain/validation/rarity_validation.dart';

import '../../helpers/database_seed.dart';

void main() {
  testWidgets('draft library shows empty and loaded states', (tester) async {
    final fakes = _Phase3Fakes(uuids: [testUuid(1), testUuid(2), testUuid(3)]);
    final container = ProviderContainer(overrides: [...fakes.overrides]);

    try {
      await _pumpPhase3Widget(
        tester,
        const CreatorPage(),
        container: container,
      );
      expect(
        find.text('Todavía no has creado ninguna colección'),
        findsOneWidget,
      );

      final projectId = await container
          .read(createCollectionDraftProvider)
          .call();
      await container
          .read(updateCollectionDraftInfoProvider)
          .call(
            id: projectId,
            name: 'Viaje',
            author: 'Grupo',
            description: 'Recuerdos',
          );

      await _pump(tester);
      expect(find.text('Viaje'), findsWidgets);
      expect(find.text('Grupo'), findsOneWidget);
      expect(find.text('Borrador'), findsWidgets);
    } finally {
      await _disposePhase3Widget(tester, container);
      await fakes.dispose();
    }
  });

  testWidgets('editor rarity sheet validates and creates a rarity', (
    tester,
  ) async {
    final fakes = _Phase3Fakes(
      uuids: [testUuid(10), testUuid(11), testUuid(12), testUuid(13)],
    );
    final container = ProviderContainer(overrides: [...fakes.overrides]);

    try {
      final projectId = await container
          .read(createCollectionDraftProvider)
          .call();

      await _pumpPhase3Widget(
        tester,
        CollectionDraftEditorPage(projectId: projectId),
        container: container,
        wrapScaffold: false,
      );

      await _pumpUntilFound(tester, find.text('Rarezas'));
      await tester.tap(find.text('Rarezas').last);
      await _pump(tester);
      await _pumpUntilFound(tester, find.text('Añadir rareza'));
      await tester.ensureVisible(find.text('Añadir rareza').first);
      await tester.pump();
      await tester.tap(find.text('Añadir rareza').first, warnIfMissed: false);
      await _pump(tester);
      await _tapSave(tester);
      await _pump(tester);
      expect(find.text('Escribe un nombre para la rareza'), findsOneWidget);

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Nombre'),
        'Normal',
      );
      await _tapSave(tester);
      await _pump(tester);

      expect(find.text('Normal'), findsWidgets);
      expect(find.text('Rareza guardada'), findsOneWidget);
    } finally {
      await _disposePhase3Widget(tester, container);
      await fakes.dispose();
    }
  });

  testWidgets('editor cards section shows the empty state', (tester) async {
    final fakes = _Phase3Fakes(
      uuids: [testUuid(20), testUuid(21), testUuid(22)],
    );
    final container = ProviderContainer(overrides: [...fakes.overrides]);

    try {
      final projectId = await container
          .read(createCollectionDraftProvider)
          .call();

      await _pumpPhase3Widget(
        tester,
        CollectionDraftEditorPage(projectId: projectId),
        container: container,
        wrapScaffold: false,
      );

      await _pumpUntilFound(tester, find.text('Cartas'));
      await tester.tap(find.widgetWithText(ListTile, 'Cartas'));
      await _pump(tester);

      expect(find.text('TodavÃ­a no hay cartas'), findsOneWidget);
      expect(
        find.text('Crea la primera carta de esta colecciÃ³n.'),
        findsOneWidget,
      );
      final addCardButton = tester.widget<FilledButton>(
        find.widgetWithText(FilledButton, 'AÃ±adir carta').first,
      );
      expect(addCardButton.onPressed, isNotNull);
    } finally {
      await _disposePhase3Widget(tester, container);
      await fakes.dispose();
    }
  });
}

final class _Phase3Fakes {
  _Phase3Fakes({required List<String> uuids})
    : uuidGenerator = FixedUuidGenerator(uuids),
      clock = FakeClock(testNowUtc()) {
    projectRepository = _InMemoryCollectionProjectRepository(
      clock: clock,
      uuidGenerator: uuidGenerator,
    );
    rarityRepository = _InMemoryRarityRepository();
    cardRepository = _InMemoryCardRepository();
  }

  final FixedUuidGenerator uuidGenerator;
  final FakeClock clock;
  late final _InMemoryCollectionProjectRepository projectRepository;
  late final _InMemoryRarityRepository rarityRepository;
  late final _InMemoryCardRepository cardRepository;

  List<dynamic> get overrides => [
    clockProvider.overrideWithValue(clock),
    uuidGeneratorProvider.overrideWithValue(uuidGenerator),
    collectionProjectRepositoryProvider.overrideWithValue(projectRepository),
    rarityRepositoryProvider.overrideWithValue(rarityRepository),
    cardRepositoryProvider.overrideWithValue(cardRepository),
  ];

  Future<void> dispose() async {
    await projectRepository.close();
    await rarityRepository.close();
    await cardRepository.close();
  }
}

final class _InMemoryCollectionProjectRepository
    implements CollectionProjectRepository {
  _InMemoryCollectionProjectRepository({
    required this.clock,
    required this.uuidGenerator,
  });

  final Clock clock;
  final UuidGenerator uuidGenerator;
  final Map<CollectionProjectId, CollectionProject> _projects = {};
  final Map<ContentVersionId, ContentVersion> _versions = {};
  final _changes = StreamController<void>.broadcast();

  @override
  Future<CreatedCollectionDraft> createDraft({
    String name = '',
    String? author,
    String? description,
    DraftCoverStyle? draftCoverStyle,
  }) async {
    final now = clock.nowUtc();
    final version = ContentVersion(
      id: uuidGenerator.contentVersionId(),
      collectionId: uuidGenerator.collectionId(),
      versionNumber: 1,
      createdAtUtc: now,
      finalizedAtUtc: null,
      isCurrent: true,
    );
    final project = CollectionProject(
      id: uuidGenerator.collectionProjectId(),
      collectionId: version.collectionId,
      name: name,
      author: author,
      description: description,
      coverAssetId: null,
      draftCoverStyle: draftCoverStyle ?? DraftCoverStyle.defaultStyle(),
      status: CollectionProjectStatus.draft,
      createdAtUtc: now,
      updatedAtUtc: now,
      currentContentVersion: version.versionNumber,
      currentContentVersionId: version.id,
      mainPackTypeId: null,
    );

    _versions[version.id] = version;
    _projects[project.id] = project;
    _changes.add(null);
    return (project: project, contentVersion: version);
  }

  @override
  Future<void> deleteDraft(CollectionProjectId id) async {
    final project = await getById(id);
    if (!project.isDraft) {
      throw const InvalidEntityFailure('Project is not a draft.');
    }
    _projects.remove(id);
    final contentVersionId = project.currentContentVersionId;
    if (contentVersionId != null) {
      _versions.remove(contentVersionId);
    }
    _changes.add(null);
  }

  @override
  Future<CollectionProject> getById(CollectionProjectId id) async {
    final project = _projects[id];
    if (project == null) {
      throw const EntityNotFoundFailure('Project not found.');
    }
    return project;
  }

  @override
  Future<CollectionProject> markFinalized(CollectionProjectId id) async {
    final project = await getById(id);
    final finalized = project.copyWith(
      status: CollectionProjectStatus.finalized,
      updatedAtUtc: clock.nowUtc(),
    );
    _projects[id] = finalized;
    _changes.add(null);
    return finalized;
  }

  @override
  Future<CollectionProject> touchUpdatedAt(CollectionProjectId id) async {
    final project = await getById(id);
    final updated = project.copyWith(updatedAtUtc: clock.nowUtc());
    _projects[id] = updated;
    _changes.add(null);
    return updated;
  }

  @override
  Future<CollectionProject> updateBasicInformation({
    required CollectionProjectId id,
    required String name,
    String? author,
    String? description,
  }) async {
    final project = await getById(id);
    final updated = CollectionProject(
      id: project.id,
      collectionId: project.collectionId,
      name: name,
      author: author,
      description: description,
      coverAssetId: project.coverAssetId,
      draftCoverStyle: project.draftCoverStyle,
      status: project.status,
      createdAtUtc: project.createdAtUtc,
      updatedAtUtc: clock.nowUtc(),
      currentContentVersion: project.currentContentVersion,
      currentContentVersionId: project.currentContentVersionId,
      mainPackTypeId: project.mainPackTypeId,
      startingPackCount: project.startingPackCount,
    );
    _projects[id] = updated;
    _changes.add(null);
    return updated;
  }

  @override
  Future<CollectionProject> updateDraftCover({
    required CollectionProjectId id,
    required DraftCoverStyle draftCoverStyle,
  }) async {
    final project = await getById(id);
    final updated = project.copyWith(
      draftCoverStyle: draftCoverStyle,
      updatedAtUtc: clock.nowUtc(),
    );
    _projects[id] = updated;
    _changes.add(null);
    return updated;
  }

  @override
  Stream<List<CollectionProject>> watchAllDrafts() async* {
    yield _drafts();
    yield* _changes.stream.map((_) => _drafts());
  }

  @override
  Stream<CollectionProject?> watchById(CollectionProjectId id) async* {
    yield _projects[id];
    yield* _changes.stream.map((_) => _projects[id]);
  }

  List<CollectionProject> _drafts() {
    final drafts =
        _projects.values
            .where((project) => project.isDraft)
            .toList(growable: false)
          ..sort((a, b) => b.updatedAtUtc.compareTo(a.updatedAtUtc));
    return drafts;
  }

  Future<void> close() => _changes.close();
}

final class _InMemoryRarityRepository implements RarityRepository {
  final Map<RarityId, Rarity> _rarities = {};
  final _changes = StreamController<void>.broadcast();

  @override
  Future<Rarity> insert(Rarity rarity) async {
    _rarities[rarity.id] = rarity;
    _changes.add(null);
    return rarity;
  }

  @override
  Future<Rarity> update(Rarity rarity) async {
    if (!_rarities.containsKey(rarity.id)) {
      throw const EntityNotFoundFailure('Rarity not found.');
    }
    _rarities[rarity.id] = rarity;
    _changes.add(null);
    return rarity;
  }

  @override
  Future<void> delete(RarityId id) async {
    _rarities.remove(id);
    _changes.add(null);
  }

  @override
  Future<Rarity> getById(RarityId id) async {
    final rarity = _rarities[id];
    if (rarity == null) {
      throw const EntityNotFoundFailure('Rarity not found.');
    }
    return rarity;
  }

  @override
  Future<int> countByCollectionVersion({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
  }) async {
    return _byVersion(collectionId, contentVersionId).length;
  }

  @override
  Future<int> countCardsUsingRarity(RarityId rarityId) async {
    return 0;
  }

  @override
  Future<bool> existsWithNormalizedName({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
    required String normalizedName,
    RarityId? excludingId,
  }) async {
    return _byVersion(collectionId, contentVersionId).any((rarity) {
      if (rarity.id == excludingId) {
        return false;
      }
      return RarityValidation.normalizedName(rarity.name) == normalizedName;
    });
  }

  @override
  Future<List<Rarity>> reorder({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
    required List<RarityId> orderedIds,
  }) async {
    final current = _byVersion(collectionId, contentVersionId);
    if (current.length != orderedIds.length ||
        !current.every((rarity) => orderedIds.contains(rarity.id))) {
      throw const InvalidEntityFailure('Invalid rarity order.');
    }

    final reordered = <Rarity>[];
    for (var index = 0; index < orderedIds.length; index += 1) {
      final rarity = await getById(orderedIds[index]);
      final updated = rarity.copyWith(orderIndex: index);
      _rarities[rarity.id] = updated;
      reordered.add(updated);
    }
    _changes.add(null);
    return reordered;
  }

  @override
  Stream<List<Rarity>> watchByCollectionVersion({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
  }) async* {
    yield _byVersion(collectionId, contentVersionId);
    yield* _changes.stream.map(
      (_) => _byVersion(collectionId, contentVersionId),
    );
  }

  List<Rarity> _byVersion(
    CollectionId collectionId,
    ContentVersionId contentVersionId,
  ) {
    final items =
        _rarities.values
            .where(
              (rarity) =>
                  rarity.collectionId == collectionId &&
                  rarity.contentVersionId == contentVersionId,
            )
            .toList(growable: false)
          ..sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
    return items;
  }

  Future<void> close() => _changes.close();
}

final class _InMemoryCardRepository implements CardRepository {
  final _changes = StreamController<void>.broadcast();

  @override
  Future<ImageCardDetails> createCard(ImageCardGraph graph) {
    throw UnimplementedError();
  }

  @override
  Future<void> delete(CardId id) {
    throw UnimplementedError();
  }

  @override
  Future<ImageCardDetails> deleteCard(CardId id) {
    throw UnimplementedError();
  }

  @override
  Future<card_domain.Card> getById(CardId id) {
    throw UnimplementedError();
  }

  @override
  Future<ImageCardDetails> getImageCardById(CardId id) {
    throw UnimplementedError();
  }

  @override
  Future<card_domain.Card> insert(card_domain.Card card) {
    throw UnimplementedError();
  }

  @override
  Future<card_domain.Card> update(card_domain.Card card) {
    throw UnimplementedError();
  }

  @override
  Future<ImageCardDetails> updateCard(ImageCardGraph graph) {
    throw UnimplementedError();
  }

  @override
  Future<bool> collectionNumberExists({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
    required int collectionNumber,
    CardId? excludingCardId,
  }) async {
    return false;
  }

  @override
  Future<int> countByRarity(RarityId rarityId) async {
    return 0;
  }

  @override
  Stream<List<card_domain.Card>> watchByCollectionVersion({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
  }) async* {
    yield const [];
    yield* _changes.stream.map((_) => const <card_domain.Card>[]);
  }

  @override
  Stream<List<ImageCardDetails>> watchImageCardsByCollectionVersion({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
  }) async* {
    yield const [];
    yield* _changes.stream.map((_) => const <ImageCardDetails>[]);
  }

  Future<void> close() => _changes.close();
}

Future<void> _pumpPhase3Widget(
  WidgetTester tester,
  Widget child, {
  required ProviderContainer container,
  bool wrapScaffold = true,
}) async {
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('es'),
        home: wrapScaffold ? Scaffold(body: child) : child,
      ),
    ),
  );
  await _pump(tester);
}

Future<void> _pump(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 600));
}

Future<void> _pumpUntilFound(
  WidgetTester tester,
  Finder finder, {
  int attempts = 10,
}) async {
  for (var attempt = 0; attempt < attempts; attempt += 1) {
    await _pump(tester);
    if (finder.evaluate().isNotEmpty) {
      return;
    }
  }

  final visibleTexts = tester
      .widgetList<Text>(find.byType(Text))
      .map((widget) => widget.data)
      .whereType<String>()
      .join(' | ');
  fail('Expected finder was not found. Visible text: $visibleTexts');
}

Future<void> _tapSave(WidgetTester tester) async {
  final saveButton = find.widgetWithText(FilledButton, 'Guardar').last;
  await tester.ensureVisible(saveButton);
  await tester.pump();
  await tester.drag(
    find.byType(SingleChildScrollView).last,
    const Offset(0, -220),
  );
  await tester.pump();
  await tester.tap(saveButton, warnIfMissed: false);
}

Future<void> _disposePhase3Widget(
  WidgetTester tester,
  ProviderContainer container,
) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump(const Duration(milliseconds: 1));
  container.dispose();
  await tester.pump(const Duration(milliseconds: 1));
}
