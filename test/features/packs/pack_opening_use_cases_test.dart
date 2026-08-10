import 'package:drift/drift.dart' hide isNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:gachadex/core/database/app_database.dart';
import 'package:gachadex/core/database/mappers/date_time_mapper.dart';
import 'package:gachadex/core/domain/domain_enums.dart';
import 'package:gachadex/core/errors/app_failure.dart';
import 'package:gachadex/core/identifiers/entity_id.dart';
import 'package:gachadex/core/identifiers/uuid_generator.dart';
import 'package:gachadex/core/time/fake_clock.dart';
import 'package:gachadex/features/album/data/repositories/drift_album_repository.dart';
import 'package:gachadex/features/album/domain/entities/album_card_entry.dart';
import 'package:gachadex/features/cards/data/repositories/drift_card_repository.dart';
import 'package:gachadex/features/collections/data/repositories/drift_installed_collection_repository.dart';
import 'package:gachadex/features/packs/application/pack_opening_use_cases.dart';
import 'package:gachadex/features/packs/application/pack_recharge_service.dart';
import 'package:gachadex/features/packs/data/repositories/drift_pack_inventory_repository.dart';
import 'package:gachadex/features/packs/data/repositories/drift_pack_opening_repository.dart';
import 'package:gachadex/features/packs/data/repositories/drift_pack_type_repository.dart';
import 'package:gachadex/features/packs/domain/entities/pack_card_pool_entry.dart';
import 'package:gachadex/features/packs/domain/entities/pack_slot_rule.dart';
import 'package:gachadex/features/rarities/data/repositories/drift_rarity_repository.dart';

import '../../helpers/database_seed.dart';
import '../../helpers/database_test_utils.dart';

void main() {
  group('OpenPack', () {
    late AppDatabase database;
    late FakeClock clock;
    late SeededDefinition definition;
    late InstalledCollectionId installedCollectionId;
    late DriftCardRepository cardRepository;
    late DriftRarityRepository rarityRepository;
    late DriftInstalledCollectionRepository installedRepository;
    late DriftPackTypeRepository packTypeRepository;
    late DriftPackInventoryRepository inventoryRepository;
    late DriftPackOpeningRepository openingRepository;
    late DriftAlbumRepository albumRepository;
    late OpenPack Function(FixedUuidGenerator uuidGenerator) openPack;

    setUp(() async {
      database = createInMemoryDatabase();
      clock = FakeClock(testNowUtc(30));
      definition = await seedDefinition(database, seed: 30);
      installedCollectionId = InstalledCollectionId(
        await seedInstalledCollection(database, definition, seed: 30),
      );
      await _insertMissingCard(database, definition);
      await (database.update(database.installedCollections)
            ..where((table) => table.id.equals(installedCollectionId.value)))
          .write(const InstalledCollectionsCompanion(totalCardCount: Value(2)));
      cardRepository = DriftCardRepository(database: database);
      rarityRepository = DriftRarityRepository(
        database: database,
        cardRepository: cardRepository,
      );
      installedRepository = DriftInstalledCollectionRepository(
        database: database,
      );
      packTypeRepository = DriftPackTypeRepository(
        database: database,
        clock: clock,
      );
      inventoryRepository = DriftPackInventoryRepository(database: database);
      openingRepository = DriftPackOpeningRepository(
        database: database,
        cardRepository: cardRepository,
        clock: clock,
      );
      albumRepository = DriftAlbumRepository(database: database);
      await _completeMainPack(packTypeRepository, definition);
      await _insertInventory(database, definition, installedCollectionId, 3);
      openPack = (uuidGenerator) {
        return OpenPack(
          database: database,
          installedCollectionRepository: installedRepository,
          cardRepository: cardRepository,
          rarityRepository: rarityRepository,
          packTypeRepository: packTypeRepository,
          packOpeningRepository: openingRepository,
          rechargeService: PackRechargeService(
            installedCollectionRepository: installedRepository,
            packInventoryRepository: inventoryRepository,
            packTypeRepository: packTypeRepository,
            clock: clock,
          ),
          uuidGenerator: uuidGenerator,
          clock: clock,
        );
      };
    });

    tearDown(() async {
      await database.close();
    });

    test('consumes one pack and records repeated cards atomically', () async {
      final useCase = openPack(FixedUuidGenerator([testUuid(3900)]));

      final opening = await useCase.call(
        installedCollectionId: installedCollectionId,
        packTypeId: PackTypeId(definition.packTypeId),
      );
      final inventory = await database.playerProgressDao.getPackInventory(
        installedCollectionId.value,
      );
      final owned = await database.playerProgressDao.getOwnedCards(
        installedCollectionId.value,
      );
      final installed = await installedRepository.getById(
        installedCollectionId,
      );

      expect(opening.cards, hasLength(3));
      expect(opening.cards.map((card) => card.result.wasNew), [
        true,
        false,
        false,
      ]);
      expect(opening.cards.map((card) => card.result.quantityAfter), [1, 2, 3]);
      expect(inventory.single.availableCount, 2);
      expect(
        fromDatabaseUtc(inventory.single.nextRechargeAtUtc),
        testNowUtc(30).add(const Duration(hours: 1)),
      );
      expect(owned.single.quantity, 3);
      expect(installed.distinctOwnedCount, 1);
    });

    test('fails without inventory and rolls back progress', () async {
      await (database.update(database.packInventory)..where(
            (table) =>
                table.installedCollectionId.equals(
                  installedCollectionId.value,
                ) &
                table.packTypeId.equals(definition.packTypeId),
          ))
          .write(const PackInventoryCompanion(availableCount: Value(0)));
      final useCase = openPack(FixedUuidGenerator([testUuid(3901)]));

      await expectLater(
        useCase.call(
          installedCollectionId: installedCollectionId,
          packTypeId: PackTypeId(definition.packTypeId),
        ),
        throwsA(isA<InvalidEntityFailure>()),
      );

      expect(await database.select(database.packOpenings).get(), isEmpty);
      expect(await database.select(database.ownedCards).get(), isEmpty);
    });

    test(
      'resumes opening, completes it and exposes album stats/favorites',
      () async {
        final useCase = openPack(FixedUuidGenerator([testUuid(3902)]));
        final opening = await useCase.call(
          installedCollectionId: installedCollectionId,
          packTypeId: PackTypeId(definition.packTypeId),
        );

        await openingRepository.markRevealing(opening.opening.id);
        await openingRepository.revealCard(
          openingId: opening.opening.id,
          slotIndex: 0,
        );
        final resumed = await openingRepository.getActive(
          installedCollectionId,
        );
        await openingRepository.complete(opening.opening.id);
        final activeAfterComplete = await openingRepository.getActive(
          installedCollectionId,
        );
        final stats = await albumRepository
            .watchStats(installedCollectionId)
            .first;
        await albumRepository.toggleFavorite(
          installedCollectionId: installedCollectionId,
          cardId: CardId(definition.cardId),
        );
        final favorites = await albumRepository
            .watchCards(
              installedCollectionId: installedCollectionId,
              query: AlbumQuery.initial.copyWith(
                status: AlbumStatusFilter.favorites,
                sort: AlbumSort.quantity,
              ),
            )
            .first;
        final missing = await albumRepository
            .watchCards(
              installedCollectionId: installedCollectionId,
              query: AlbumQuery.initial.copyWith(
                status: AlbumStatusFilter.missing,
              ),
            )
            .first;
        final repeated = await albumRepository
            .watchCards(
              installedCollectionId: installedCollectionId,
              query: AlbumQuery.initial.copyWith(
                status: AlbumStatusFilter.repeated,
                rarityId: RarityId(definition.rarityId),
                media: AlbumMediaFilter.image,
                sort: AlbumSort.firstObtained,
              ),
            )
            .first;

        expect(resumed?.opening.id, opening.opening.id);
        expect(resumed?.cards.first.result.revealed, isTrue);
        expect(activeAfterComplete, isNull);
        expect(stats.distinctOwnedCount, 1);
        expect(stats.totalCardCount, 2);
        expect(stats.totalCopies, 3);
        expect(favorites.single.cardId, CardId(definition.cardId));
        expect(favorites.single.isFavorite, isTrue);
        expect(missing.single.name, isNull);
        expect(missing.single.thumbnailRelativePath, isNull);
        expect(repeated.single.quantity, 3);
      },
    );
  });
}

Future<void> _insertMissingCard(
  AppDatabase database,
  SeededDefinition definition,
) async {
  final cardId = testUuid(3910);
  final mediaAssetId = testUuid(3911);
  await database
      .into(database.mediaAssets)
      .insert(
        MediaAssetsCompanion(
          id: Value(mediaAssetId),
          collectionId: Value(definition.collectionId),
          ownerType: const Value(MediaOwnerType.card),
          ownerId: Value(cardId),
          mediaType: const Value(MediaType.image),
          relativePath: Value(
            'collections/${definition.collectionId}/cards/$cardId.webp',
          ),
          thumbnailRelativePath: Value(
            'collections/${definition.collectionId}/cards/$cardId-thumb.webp',
          ),
          mimeType: const Value('image/webp'),
          width: const Value(720),
          height: const Value(960),
          durationMs: const Value(null),
          fileSize: const Value(1024),
          sha256: const Value(null),
          createdAtUtc: Value(testNowUtc(32)),
        ),
      );
  await database
      .into(database.cards)
      .insert(
        CardsCompanion(
          id: Value(cardId),
          collectionId: Value(definition.collectionId),
          contentVersionId: Value(definition.contentVersionId),
          collectionNumber: const Value(2),
          name: const Value('Carta oculta'),
          health: const Value(90),
          rarityId: Value(definition.rarityId),
          mediaAssetId: Value(mediaAssetId),
          mediaType: const Value(MediaType.image),
          thumbnailAssetId: const Value(null),
          templateId: const Value('classic'),
          frameId: const Value('clean'),
          primaryColor: const Value(0xFF3366CC),
          secondaryColor: const Value(0xFFFFCC33),
          description: const Value('No debe verse hasta obtenerla'),
          sortIndex: const Value(2),
          createdAtUtc: Value(testNowUtc(32)),
        ),
      );
}

Future<void> _completeMainPack(
  DriftPackTypeRepository repository,
  SeededDefinition definition,
) async {
  final packTypeId = PackTypeId(definition.packTypeId);
  await repository.addCardToPool(
    PackCardPoolEntry(
      packTypeId: packTypeId,
      cardId: CardId(definition.cardId),
      isEnabled: true,
    ),
  );
  for (var index = 0; index < 3; index++) {
    await repository.addSlotRule(
      PackSlotRule(
        id: PackSlotRuleId(testUuid(3903 + index)),
        packTypeId: packTypeId,
        slotIndex: index,
        ruleType: PackSlotRuleType.fixedRarity,
        fixedRarityId: RarityId(definition.rarityId),
        minimumRarityOrder: null,
        probabilityGroupId: null,
      ),
    );
  }
}

Future<void> _insertInventory(
  AppDatabase database,
  SeededDefinition definition,
  InstalledCollectionId installedCollectionId,
  int availableCount,
) {
  return database
      .into(database.packInventory)
      .insert(
        PackInventoryCompanion(
          installedCollectionId: Value(installedCollectionId.value),
          packTypeId: Value(definition.packTypeId),
          availableCount: Value(availableCount),
          maxAccumulated: const Value(3),
          nextRechargeAtUtc: Value(testNowUtc(31)),
          lastCalculatedAtUtc: Value(testNowUtc(30)),
        ),
      );
}
