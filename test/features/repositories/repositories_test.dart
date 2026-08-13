import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gachadex/core/database/app_database.dart';
import 'package:gachadex/core/domain/domain_enums.dart';
import 'package:gachadex/core/errors/app_failure.dart';
import 'package:gachadex/core/identifiers/entity_id.dart';
import 'package:gachadex/core/identifiers/uuid_generator.dart';
import 'package:gachadex/core/time/fake_clock.dart';
import 'package:gachadex/core/value_objects/relative_media_path.dart';
import 'package:gachadex/features/album/data/repositories/drift_player_progress_repository.dart';
import 'package:gachadex/features/cards/data/repositories/drift_card_repository.dart';
import 'package:gachadex/features/cards/domain/entities/card.dart' as domain;
import 'package:gachadex/features/collection_creator/data/repositories/drift_collection_project_repository.dart';
import 'package:gachadex/features/collection_creator/domain/catalogs/draft_cover_catalog.dart';
import 'package:gachadex/features/collection_creator/domain/value_objects/draft_cover_style.dart';
import 'package:gachadex/features/collections/data/repositories/drift_installed_collection_repository.dart';
import 'package:gachadex/features/collections/domain/entities/installed_collection.dart';
import 'package:gachadex/features/packs/data/repositories/drift_pack_type_repository.dart';
import 'package:gachadex/features/packs/domain/entities/pack_card_pool_entry.dart';
import 'package:gachadex/features/packs/domain/entities/pack_configuration.dart';
import 'package:gachadex/features/packs/domain/entities/pack_rarity_probability.dart';
import 'package:gachadex/features/packs/domain/entities/pack_slot_rule.dart';
import 'package:gachadex/features/packs/domain/entities/pack_type.dart';
import 'package:gachadex/features/rarities/data/repositories/drift_rarity_repository.dart';
import 'package:gachadex/features/rarities/domain/catalogs/rarity_visual_catalog.dart';
import 'package:gachadex/features/rarities/domain/entities/rarity.dart';

import '../../helpers/database_seed.dart';
import '../../helpers/database_test_utils.dart';

void main() {
  group('CollectionProjectRepository', () {
    late AppDatabase database;
    late FakeClock clock;

    setUp(() {
      database = createInMemoryDatabase();
      clock = FakeClock(testNowUtc());
    });

    tearDown(() async {
      await database.close();
    });

    DriftCollectionProjectRepository repositoryWith(
      Iterable<String> uuidValues,
    ) {
      return DriftCollectionProjectRepository(
        database: database,
        clock: clock,
        uuidGenerator: FixedUuidGenerator(uuidValues),
      );
    }

    test('creates project and version 1 transactionally', () async {
      final repository = repositoryWith([
        testUuid(1),
        testUuid(2),
        testUuid(3),
      ]);

      final created = await repository.createDraft(
        name: 'Amigos',
        author: 'Ale',
      );

      expect(created.project.id, CollectionProjectId(testUuid(3)));
      expect(created.project.collectionId, CollectionId(testUuid(2)));
      expect(created.contentVersion.id, ContentVersionId(testUuid(1)));
      expect(created.contentVersion.versionNumber, 1);
      expect(
        await database.select(database.collectionProjects).get(),
        hasLength(1),
      );
      expect(
        await database.select(database.contentVersions).get(),
        hasLength(1),
      );
    });

    test(
      'creates unnamed drafts and updates provisional cover style',
      () async {
        final repository = repositoryWith([
          testUuid(40),
          testUuid(41),
          testUuid(42),
        ]);
        final watched = repository.watchById(CollectionProjectId(testUuid(42)));

        final created = await repository.createDraft();
        final emitted = await watched.firstWhere((project) => project != null);
        final style = DraftCoverStyle(
          backgroundColorId: 'cover_rose',
          accentColorId: DraftCoverCatalog.defaultAccentColorId,
          iconId: 'cover_icon_group',
          patternId: 'cover_pattern_dots',
        );

        clock.advance(const Duration(minutes: 2));
        final updated = await repository.updateDraftCover(
          id: created.project.id,
          draftCoverStyle: style,
        );

        expect(created.project.name, isEmpty);
        expect(emitted?.id, created.project.id);
        expect(updated.draftCoverStyle, style);
        expect(
          updated.updatedAtUtc,
          testNowUtc().add(const Duration(minutes: 2)),
        );
      },
    );

    test('retrieves, watches, updates and finalizes drafts', () async {
      final repository = repositoryWith([
        testUuid(10),
        testUuid(11),
        testUuid(12),
      ]);
      final watched = repository.watchAllDrafts().firstWhere(
        (projects) => projects.isNotEmpty,
      );

      final created = await repository.createDraft(name: 'Inicial');
      final emitted = await watched;

      expect(emitted.single.id, created.project.id);

      clock.advance(const Duration(minutes: 5));
      final updated = await repository.updateBasicInformation(
        id: created.project.id,
        name: 'Actualizada',
        author: 'Grupo',
      );

      expect(updated.name, 'Actualizada');
      expect(
        updated.updatedAtUtc,
        testNowUtc().add(const Duration(minutes: 5)),
      );

      final finalized = await repository.markFinalized(created.project.id);
      final fetched = await repository.getById(created.project.id);

      expect(finalized.status, CollectionProjectStatus.finalized);
      expect(fetched.status, CollectionProjectStatus.finalized);
      await expectLater(
        repository.updateBasicInformation(
          id: created.project.id,
          name: 'Bloqueado',
        ),
        throwsA(isA<InvalidEntityFailure>()),
      );
    });

    test('deletes a draft and leaves no content or project rows', () async {
      final repository = repositoryWith([
        testUuid(20),
        testUuid(21),
        testUuid(22),
      ]);
      final created = await repository.createDraft(name: 'Borrador');

      await repository.deleteDraft(created.project.id);

      expect(await database.select(database.collectionProjects).get(), isEmpty);
      expect(await database.select(database.contentVersions).get(), isEmpty);
    });

    test('rolls back initial content when project insert fails', () async {
      final repository = repositoryWith([
        testUuid(30),
        testUuid(31),
        testUuid(32),
        testUuid(33),
        testUuid(34),
        testUuid(32),
      ]);

      await repository.createDraft(name: 'Primero');

      await expectLater(
        repository.createDraft(name: 'Falla'),
        throwsA(isA<TransactionFailure>()),
      );
      final versions = await database.select(database.contentVersions).get();

      expect(versions.map((row) => row.id), isNot(contains(testUuid(33))));
      expect(versions, hasLength(1));
    });
  });

  group('Definition repositories', () {
    late AppDatabase database;
    late DriftCardRepository cardRepository;
    late DriftRarityRepository rarityRepository;
    late DriftPackTypeRepository packTypeRepository;

    setUp(() {
      database = createInMemoryDatabase();
      cardRepository = DriftCardRepository(database: database);
      rarityRepository = DriftRarityRepository(
        database: database,
        cardRepository: cardRepository,
      );
      packTypeRepository = DriftPackTypeRepository(
        database: database,
        clock: FakeClock(DateTime.utc(2026, 1, 1)),
      );
    });

    tearDown(() async {
      await database.close();
    });

    test(
      'inserts, updates, reorders and protects rarities used by cards',
      () async {
        final definition = await seedDefinition(database, seed: 1);
        final secondRarity = Rarity(
          id: RarityId(testUuid(1200)),
          collectionId: CollectionId(definition.collectionId),
          contentVersionId: ContentVersionId(definition.contentVersionId),
          name: 'Legendaria',
          orderIndex: 1,
          colorValue: 0xFFFFCC33,
          iconId: 'star',
          frameId: 'foil',
          effectId: null,
          sellValue: 50,
          probabilityWeight: 40,
          isEnabled: true,
        );

        await rarityRepository.insert(secondRarity);
        final updated = await rarityRepository.update(
          secondRarity.copyWith(
            name: 'Mitica',
            sellValue: 60,
            probabilityWeight: 45,
          ),
        );
        final reordered = await rarityRepository.reorder(
          collectionId: CollectionId(definition.collectionId),
          contentVersionId: ContentVersionId(definition.contentVersionId),
          orderedIds: [secondRarity.id, RarityId(definition.rarityId)],
        );

        expect(updated.name, 'Mitica');
        expect(updated.probabilityWeight, 45);
        expect(reordered.first.id, secondRarity.id);
        await expectLater(
          rarityRepository.delete(RarityId(definition.rarityId)),
          throwsA(isA<ReferentialIntegrityFailure>()),
        );

        await rarityRepository.delete(secondRarity.id);
        expect(await database.select(database.rarities).get(), hasLength(1));
      },
    );

    test(
      'counts rarities and detects duplicate names after normalization',
      () async {
        final definition = await seedDefinition(database, seed: 10);
        final collectionId = CollectionId(definition.collectionId);
        final contentVersionId = ContentVersionId(definition.contentVersionId);
        final secondRarity = Rarity(
          id: RarityId(testUuid(1001)),
          collectionId: collectionId,
          contentVersionId: contentVersionId,
          name: 'Legendaria',
          orderIndex: 1,
          colorValue: RarityVisualCatalog.defaultColorValue,
          iconId: RarityVisualCatalog.defaultIconId,
          frameId: RarityVisualCatalog.defaultFrameId,
          effectId: RarityVisualCatalog.defaultEffectId,
          sellValue: 100,
          probabilityWeight: 20,
          isEnabled: true,
        );

        await rarityRepository.insert(secondRarity);

        expect(
          await rarityRepository.countByCollectionVersion(
            collectionId: collectionId,
            contentVersionId: contentVersionId,
          ),
          2,
        );
        expect(
          await rarityRepository.existsWithNormalizedName(
            collectionId: collectionId,
            contentVersionId: contentVersionId,
            normalizedName: ' legendaria ',
          ),
          isTrue,
        );
        await expectLater(
          rarityRepository.reorder(
            collectionId: collectionId,
            contentVersionId: contentVersionId,
            orderedIds: [secondRarity.id],
          ),
          throwsA(isA<InvalidEntityFailure>()),
        );
      },
    );

    test(
      'rejects cards with rarity or media from another collection',
      () async {
        final first = await seedDefinition(database, seed: 2);
        final second = await seedDefinition(database, seed: 3);
        await _insertMedia(
          database,
          collectionId: first.collectionId,
          mediaAssetId: testUuid(2500),
          ownerId: testUuid(2501),
        );

        final card = _domainCard(
          collectionId: first.collectionId,
          contentVersionId: first.contentVersionId,
          rarityId: second.rarityId,
          mediaAssetId: testUuid(2500),
          cardId: testUuid(2501),
        );

        await expectLater(
          cardRepository.insert(card),
          throwsA(isA<ReferentialIntegrityFailure>()),
        );
      },
    );

    test(
      'adds pack definitions only when content belongs to the same version',
      () async {
        final first = await seedDefinition(database, seed: 4);
        final second = await seedDefinition(database, seed: 5);

        await expectLater(
          packTypeRepository.addCardToPool(
            PackCardPoolEntry(
              packTypeId: PackTypeId(first.packTypeId),
              cardId: CardId(second.cardId),
              isEnabled: true,
            ),
          ),
          throwsA(isA<ReferentialIntegrityFailure>()),
        );

        final entry = await packTypeRepository.addCardToPool(
          PackCardPoolEntry(
            packTypeId: PackTypeId(first.packTypeId),
            cardId: CardId(first.cardId),
            isEnabled: true,
          ),
        );
        final groupId = ProbabilityGroupId(testUuid(4600));
        await packTypeRepository.addSlotRule(
          PackSlotRule(
            id: PackSlotRuleId(testUuid(4601)),
            packTypeId: PackTypeId(first.packTypeId),
            slotIndex: 0,
            ruleType: PackSlotRuleType.probabilityDistribution,
            fixedRarityId: null,
            minimumRarityOrder: null,
            probabilityGroupId: groupId,
          ),
        );

        await expectLater(
          packTypeRepository.addRarityProbability(
            PackRarityProbability(
              probabilityGroupId: groupId,
              rarityId: RarityId(second.rarityId),
              weight: 1,
            ),
          ),
          throwsA(isA<ReferentialIntegrityFailure>()),
        );

        final probability = await packTypeRepository.addRarityProbability(
          PackRarityProbability(
            probabilityGroupId: groupId,
            rarityId: RarityId(first.rarityId),
            weight: 10,
          ),
        );

        expect(entry.cardId, CardId(first.cardId));
        expect(probability.weight, 10);
      },
    );

    test('keeps a single main pack and returns full configuration', () async {
      final definition = await seedDefinition(database, seed: 8);
      final packId = PackTypeId(testUuid(8600));
      final groupId = ProbabilityGroupId(testUuid(8601));
      final ruleId = PackSlotRuleId(testUuid(8602));

      final created = await packTypeRepository.createConfiguration(
        PackConfiguration(
          packType: PackType(
            id: packId,
            collectionId: CollectionId(definition.collectionId),
            contentVersionId: ContentVersionId(definition.contentVersionId),
            name: 'Segundo sobre',
            description: 'Tematico',
            frontAssetId: null,
            backAssetId: null,
            cardCount: 1,
            rechargeSeconds: 7200,
            maxAccumulated: 3,
            isMain: true,
            coinsPerFullRecharge: 5,
            sortIndex: 1,
          ),
          pool: [
            PackCardPoolEntry(
              packTypeId: packId,
              cardId: CardId(definition.cardId),
              isEnabled: true,
            ),
          ],
          slotRules: [
            PackSlotRule(
              id: ruleId,
              packTypeId: packId,
              slotIndex: 0,
              ruleType: PackSlotRuleType.probabilityDistribution,
              fixedRarityId: null,
              minimumRarityOrder: null,
              probabilityGroupId: groupId,
            ),
          ],
          probabilities: [
            PackRarityProbability(
              probabilityGroupId: groupId,
              rarityId: RarityId(definition.rarityId),
              weight: 10,
            ),
          ],
        ),
      );

      final packs = await packTypeRepository
          .watchByCollectionVersion(
            collectionId: CollectionId(definition.collectionId),
            contentVersionId: ContentVersionId(definition.contentVersionId),
          )
          .first;
      final full = await packTypeRepository.getFullConfiguration(packId);

      expect(created.packType.isMain, isTrue);
      expect(packs.where((pack) => pack.isMain), hasLength(1));
      expect(packs.singleWhere((pack) => pack.id == packId).sortIndex, 1);
      expect(full.pool, hasLength(1));
      expect(full.slotRules, hasLength(1));
      expect(full.probabilities.single.weight, 10);

      await packTypeRepository.delete(packId);
      final remaining = await packTypeRepository
          .watchByCollectionVersion(
            collectionId: CollectionId(definition.collectionId),
            contentVersionId: ContentVersionId(definition.contentVersionId),
          )
          .first;

      expect(remaining, hasLength(1));
      expect(remaining.single.isMain, isTrue);
      expect(remaining.single.sortIndex, 0);
    });

    test(
      'inserts, watches and deletes installed collections with progress',
      () async {
        final definition = await seedDefinition(database, seed: 6);
        final installedRepository = DriftInstalledCollectionRepository(
          database: database,
        );
        final progressRepository = DriftPlayerProgressRepository(
          database: database,
        );
        final installed = InstalledCollection(
          id: InstalledCollectionId(testUuid(6700)),
          collectionId: CollectionId(definition.collectionId),
          contentVersionId: ContentVersionId(definition.contentVersionId),
          name: 'Instalada',
          author: null,
          description: null,
          coverRelativePath: RelativeMediaPath('covers/main.webp'),
          mainPackTypeId: PackTypeId(definition.packTypeId),
          installedAtUtc: testNowUtc(6),
          source: InstalledCollectionSource.createdLocally,
          coins: 5,
          totalCardCount: 1,
          distinctOwnedCount: 0,
        );
        final watched = installedRepository.watchAll().firstWhere(
          (collections) => collections.isNotEmpty,
        );

        await installedRepository.insert(installed);
        final emitted = await watched;

        expect(emitted.single.id, installed.id);
        await expectLater(
          installedRepository.insert(installed),
          throwsA(isA<DuplicateEntityFailure>()),
        );

        await database
            .into(database.ownedCards)
            .insert(
              OwnedCardsCompanion(
                installedCollectionId: Value(installed.id.value),
                cardId: Value(definition.cardId),
                quantity: const Value(1),
                firstObtainedAtUtc: Value(testNowUtc(7)),
                lastObtainedAtUtc: Value(testNowUtc(7)),
                isFavorite: const Value(false),
              ),
            );
        await database
            .into(database.packInventory)
            .insert(
              PackInventoryCompanion(
                installedCollectionId: Value(installed.id.value),
                packTypeId: Value(definition.packTypeId),
                availableCount: const Value(1),
                maxAccumulated: const Value(3),
                nextRechargeAtUtc: Value(testNowUtc(8)),
                lastCalculatedAtUtc: Value(testNowUtc(8)),
              ),
            );

        expect(
          await progressRepository.getOwnedCards(installed.id),
          hasLength(1),
        );
        expect(
          await progressRepository.getPackInventory(installed.id),
          hasLength(1),
        );
        expect(await progressRepository.getCoinBalance(installed.id), 5);

        await installedRepository.deleteWithProgress(installed.id);

        expect(
          await database.select(database.installedCollections).get(),
          isEmpty,
        );
        expect(await database.select(database.ownedCards).get(), isEmpty);
        expect(await database.select(database.cards).get(), hasLength(1));
      },
    );
  });

  test(
    'persists collection draft and rarity order after reopening file database',
    () async {
      final tempDir = await Directory.systemTemp.createTemp(
        'gachadex_phase3_repo_',
      );
      final file = File(
        '${tempDir.path}${Platform.pathSeparator}phase3.sqlite',
      );
      final coverStyle = DraftCoverStyle(
        backgroundColorId: 'cover_sky',
        accentColorId: 'cover_gold',
        iconId: 'cover_icon_trophy',
        patternId: 'cover_pattern_split',
      );

      try {
        final firstDatabase = createFileDatabase(file);
        final firstClock = FakeClock(testNowUtc());
        final projectRepository = DriftCollectionProjectRepository(
          database: firstDatabase,
          clock: firstClock,
          uuidGenerator: FixedUuidGenerator([
            testUuid(7001),
            testUuid(7002),
            testUuid(7003),
          ]),
        );
        final cardRepository = DriftCardRepository(database: firstDatabase);
        final rarityRepository = DriftRarityRepository(
          database: firstDatabase,
          cardRepository: cardRepository,
        );

        final created = await projectRepository.createDraft();
        firstClock.advance(const Duration(minutes: 1));
        await projectRepository.updateBasicInformation(
          id: created.project.id,
          name: 'Viaje',
          author: 'Grupo',
          description: 'Tres dias memorables',
        );
        firstClock.advance(const Duration(minutes: 1));
        await projectRepository.updateDraftCover(
          id: created.project.id,
          draftCoverStyle: coverStyle,
        );
        final rarities = [
          Rarity(
            id: RarityId(testUuid(7101)),
            collectionId: created.project.collectionId,
            contentVersionId: created.contentVersion.id,
            name: 'Normal',
            orderIndex: 0,
            colorValue: RarityVisualCatalog.defaultColorValue,
            iconId: RarityVisualCatalog.defaultIconId,
            frameId: RarityVisualCatalog.defaultFrameId,
            effectId: RarityVisualCatalog.defaultEffectId,
            sellValue: 1,
            probabilityWeight: 60,
            isEnabled: true,
          ),
          Rarity(
            id: RarityId(testUuid(7102)),
            collectionId: created.project.collectionId,
            contentVersionId: created.contentVersion.id,
            name: 'Rara',
            orderIndex: 1,
            colorValue: 0xFF2F6FA8,
            iconId: 'rarity_icon_diamond',
            frameId: 'rarity_frame_double',
            effectId: 'rarity_effect_spark',
            sellValue: 20,
            probabilityWeight: 30,
            isEnabled: true,
          ),
          Rarity(
            id: RarityId(testUuid(7103)),
            collectionId: created.project.collectionId,
            contentVersionId: created.contentVersion.id,
            name: 'Legendaria',
            orderIndex: 2,
            colorValue: 0xFFE2B844,
            iconId: 'rarity_icon_crown',
            frameId: 'rarity_frame_neon',
            effectId: 'rarity_effect_holo',
            sellValue: 100,
            probabilityWeight: 10,
            isEnabled: true,
          ),
        ];
        for (final rarity in rarities) {
          await rarityRepository.insert(rarity);
        }
        await rarityRepository.reorder(
          collectionId: created.project.collectionId,
          contentVersionId: created.contentVersion.id,
          orderedIds: [rarities[0].id, rarities[2].id, rarities[1].id],
        );
        await firstDatabase.close();

        final secondDatabase = createFileDatabase(file);
        try {
          final reopenedProjectRepository = DriftCollectionProjectRepository(
            database: secondDatabase,
            clock: FakeClock(testNowUtc(10)),
            uuidGenerator: FixedUuidGenerator(const []),
          );
          final reopenedRarityRepository = DriftRarityRepository(
            database: secondDatabase,
            cardRepository: DriftCardRepository(database: secondDatabase),
          );
          final project = await reopenedProjectRepository.getById(
            created.project.id,
          );
          final reopenedRarities = await reopenedRarityRepository
              .watchByCollectionVersion(
                collectionId: created.project.collectionId,
                contentVersionId: created.contentVersion.id,
              )
              .first;

          expect(project.name, 'Viaje');
          expect(project.author, 'Grupo');
          expect(project.description, 'Tres dias memorables');
          expect(project.draftCoverStyle, coverStyle);
          expect(
            project.updatedAtUtc,
            testNowUtc().add(const Duration(minutes: 2)),
          );
          expect(reopenedRarities.map((rarity) => rarity.name), [
            'Normal',
            'Legendaria',
            'Rara',
          ]);
          expect(reopenedRarities.map((rarity) => rarity.orderIndex), [
            0,
            1,
            2,
          ]);
        } finally {
          await secondDatabase.close();
        }
      } finally {
        if (tempDir.existsSync()) {
          tempDir.deleteSync(recursive: true);
        }
      }
    },
  );
}

Future<void> _insertMedia(
  AppDatabase database, {
  required String collectionId,
  required String mediaAssetId,
  required String ownerId,
}) {
  return database
      .into(database.mediaAssets)
      .insert(
        MediaAssetsCompanion(
          id: Value(mediaAssetId),
          collectionId: Value(collectionId),
          ownerType: const Value(MediaOwnerType.card),
          ownerId: Value(ownerId),
          mediaType: const Value(MediaType.image),
          relativePath: Value('collections/$collectionId/cards/$ownerId.webp'),
          thumbnailRelativePath: const Value(null),
          mimeType: const Value('image/webp'),
          width: const Value(640),
          height: const Value(480),
          durationMs: const Value(null),
          fileSize: const Value(1024),
          sha256: const Value(null),
          createdAtUtc: Value(testNowUtc(12)),
        ),
      );
}

domain.Card _domainCard({
  required String collectionId,
  required String contentVersionId,
  required String rarityId,
  required String mediaAssetId,
  required String cardId,
}) {
  return domain.Card(
    id: CardId(cardId),
    collectionId: CollectionId(collectionId),
    contentVersionId: ContentVersionId(contentVersionId),
    collectionNumber: 99,
    name: 'Nueva',
    health: 100,
    rarityId: RarityId(rarityId),
    mediaAssetId: MediaAssetId(mediaAssetId),
    mediaType: MediaType.image,
    thumbnailAssetId: null,
    templateId: 'basic',
    frameId: 'clean',
    primaryColor: 0xFF000000,
    secondaryColor: 0xFFFFFFFF,
    description: null,
    sortIndex: 99,
    createdAtUtc: testNowUtc(13),
  );
}
