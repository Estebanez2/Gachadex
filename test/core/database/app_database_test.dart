import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gachadex/core/database/app_database.dart';
import 'package:gachadex/core/domain/domain_enums.dart';
import 'package:gachadex/features/cards/data/mappers/card_mapper.dart';

import '../../helpers/database_seed.dart';
import '../../helpers/database_test_utils.dart';

void main() {
  group('AppDatabase schema', () {
    late AppDatabase database;

    setUp(() {
      database = createInMemoryDatabase();
    });

    tearDown(() async {
      await database.close();
    });

    test(
      'creates current schema with expected tables and foreign keys',
      () async {
        final tables = await database
            .customSelect(
              "SELECT name FROM sqlite_master WHERE type = 'table' "
              "AND name NOT LIKE 'sqlite_%' ORDER BY name",
            )
            .map((row) => row.read<String>('name'))
            .get();

        expect(
          tables,
          containsAll(<String>[
            'collection_projects',
            'content_versions',
            'installed_collections',
            'rarities',
            'cards',
            'card_field_values',
            'media_assets',
            'pack_types',
            'pack_card_pool',
            'pack_slot_rules',
            'pack_rarity_probabilities',
            'pack_inventory',
            'owned_cards',
            'pack_openings',
            'pack_opening_cards',
            'coin_transactions',
          ]),
        );
        expect(database.schemaVersion, 4);

        final foreignKeys = await database
            .customSelect('PRAGMA foreign_keys')
            .get();
        expect(foreignKeys.single.read<int>('foreign_keys'), 1);
      },
    );

    test('creates draft cover columns with safe defaults', () async {
      final columns = await database
          .customSelect('PRAGMA table_info(collection_projects)')
          .map((row) => row.read<String>('name'))
          .get();

      expect(columns, contains('draft_cover_color_id'));
      expect(columns, contains('draft_cover_accent_color_id'));
      expect(columns, contains('draft_cover_icon_id'));
      expect(columns, contains('draft_cover_pattern_id'));
    });

    test('preserves UTC dates through mappers', () async {
      final definition = await seedDefinition(database, seed: 1);
      final row = await (database.select(
        database.cards,
      )..where((table) => table.id.equals(definition.cardId))).getSingle();

      final card = row.toDomain();

      expect(card.createdAtUtc.isUtc, isTrue);
      expect(card.createdAtUtc, testNowUtc(1));
    });

    test('enforces unique card numbers only inside one version', () async {
      final first = await seedDefinition(
        database,
        seed: 1,
        collectionNumber: 7,
      );
      await _insertMedia(
        database,
        collectionId: first.collectionId,
        mediaAssetId: testUuid(700),
        ownerId: testUuid(701),
      );

      await expectLater(
        database
            .into(database.cards)
            .insert(
              _cardCompanion(
                collectionId: first.collectionId,
                contentVersionId: first.contentVersionId,
                rarityId: first.rarityId,
                mediaAssetId: testUuid(700),
                cardId: testUuid(701),
                collectionNumber: 7,
              ),
            ),
        throwsA(isA<Object>()),
      );

      final second = await seedDefinition(
        database,
        seed: 2,
        collectionNumber: 7,
      );

      expect(second.collectionId, isNot(first.collectionId));
      expect(await database.select(database.cards).get(), hasLength(2));
    });

    test(
      'enforces pack pool, owned card and pack inventory restrictions',
      () async {
        final definition = await seedDefinition(database, seed: 3);
        final installedCollectionId = await seedInstalledCollection(
          database,
          definition,
        );

        await database
            .into(database.packCardPool)
            .insert(
              PackCardPoolCompanion(
                packTypeId: Value(definition.packTypeId),
                cardId: Value(definition.cardId),
                isEnabled: const Value(true),
              ),
            );
        await expectLater(
          database
              .into(database.packCardPool)
              .insert(
                PackCardPoolCompanion(
                  packTypeId: Value(definition.packTypeId),
                  cardId: Value(definition.cardId),
                  isEnabled: const Value(true),
                ),
              ),
          throwsA(isA<Object>()),
        );

        await database
            .into(database.ownedCards)
            .insert(
              OwnedCardsCompanion(
                installedCollectionId: Value(installedCollectionId),
                cardId: Value(definition.cardId),
                quantity: const Value(1),
                firstObtainedAtUtc: Value(testNowUtc(1)),
                lastObtainedAtUtc: Value(testNowUtc(1)),
                isFavorite: const Value(false),
              ),
            );
        await expectLater(
          database
              .into(database.ownedCards)
              .insert(
                OwnedCardsCompanion(
                  installedCollectionId: Value(installedCollectionId),
                  cardId: Value(definition.cardId),
                  quantity: const Value(1),
                  firstObtainedAtUtc: Value(testNowUtc(1)),
                  lastObtainedAtUtc: Value(testNowUtc(1)),
                  isFavorite: const Value(false),
                ),
              ),
          throwsA(isA<Object>()),
        );

        await expectLater(
          database
              .into(database.packInventory)
              .insert(
                PackInventoryCompanion(
                  installedCollectionId: Value(installedCollectionId),
                  packTypeId: Value(definition.packTypeId),
                  availableCount: const Value(4),
                  maxAccumulated: const Value(3),
                  nextRechargeAtUtc: Value(testNowUtc(2)),
                  lastCalculatedAtUtc: Value(testNowUtc(2)),
                ),
              ),
          throwsA(isA<Object>()),
        );
      },
    );

    test('enforces pack opening relations and slot uniqueness', () async {
      final definition = await seedDefinition(database, seed: 4);
      final installedCollectionId = await seedInstalledCollection(
        database,
        definition,
        seed: 51,
      );
      final openingId = testUuid(900);

      await database
          .into(database.packOpenings)
          .insert(
            PackOpeningsCompanion(
              id: Value(openingId),
              installedCollectionId: Value(installedCollectionId),
              packTypeId: Value(definition.packTypeId),
              status: const Value(PackOpeningStatus.generated),
              generatedAtUtc: Value(testNowUtc(3)),
              completedAtUtc: const Value(null),
            ),
          );
      await database
          .into(database.packOpeningCards)
          .insert(
            PackOpeningCardsCompanion(
              openingId: Value(openingId),
              cardId: Value(definition.cardId),
              slotIndex: const Value(0),
              wasNew: const Value(true),
              quantityAfter: const Value(1),
              revealed: const Value(false),
            ),
          );

      await expectLater(
        database
            .into(database.packOpeningCards)
            .insert(
              PackOpeningCardsCompanion(
                openingId: Value(openingId),
                cardId: Value(definition.cardId),
                slotIndex: const Value(0),
                wasNew: const Value(false),
                quantityAfter: const Value(2),
                revealed: const Value(true),
              ),
            ),
        throwsA(isA<Object>()),
      );

      expect(
        await database.select(database.packOpeningCards).get(),
        hasLength(1),
      );
    });

    test('rejects progress pointing to missing cards', () async {
      final definition = await seedDefinition(database, seed: 5);
      final installedCollectionId = await seedInstalledCollection(
        database,
        definition,
        seed: 52,
      );

      await expectLater(
        database
            .into(database.ownedCards)
            .insert(
              OwnedCardsCompanion(
                installedCollectionId: Value(installedCollectionId),
                cardId: Value(testUuid(999)),
                quantity: const Value(1),
                firstObtainedAtUtc: Value(testNowUtc(4)),
                lastObtainedAtUtc: Value(testNowUtc(4)),
                isFavorite: const Value(false),
              ),
            ),
        throwsA(isA<Object>()),
      );
    });

    test(
      'deleting an installed collection cascades local progress only',
      () async {
        final definition = await seedDefinition(database, seed: 6);
        final installedCollectionId = await seedInstalledCollection(
          database,
          definition,
          seed: 53,
        );
        await database
            .into(database.packInventory)
            .insert(
              PackInventoryCompanion(
                installedCollectionId: Value(installedCollectionId),
                packTypeId: Value(definition.packTypeId),
                availableCount: const Value(1),
                maxAccumulated: const Value(3),
                nextRechargeAtUtc: Value(testNowUtc(5)),
                lastCalculatedAtUtc: Value(testNowUtc(5)),
              ),
            );
        await database
            .into(database.ownedCards)
            .insert(
              OwnedCardsCompanion(
                installedCollectionId: Value(installedCollectionId),
                cardId: Value(definition.cardId),
                quantity: const Value(1),
                firstObtainedAtUtc: Value(testNowUtc(5)),
                lastObtainedAtUtc: Value(testNowUtc(5)),
                isFavorite: const Value(false),
              ),
            );

        await (database.delete(
          database.installedCollections,
        )..where((table) => table.id.equals(installedCollectionId))).go();

        expect(await database.select(database.packInventory).get(), isEmpty);
        expect(await database.select(database.ownedCards).get(), isEmpty);
        expect(await database.select(database.cards).get(), hasLength(1));
      },
    );
  });

  test('persists data when a file database is closed and reopened', () async {
    final tempDir = await Directory.systemTemp.createTemp('gachadex_db_test_');
    final file = File('${tempDir.path}${Platform.pathSeparator}test.sqlite');

    try {
      final firstDatabase = createFileDatabase(file);
      await seedDefinition(firstDatabase, seed: 7);
      await firstDatabase.close();

      final secondDatabase = createFileDatabase(file);
      try {
        expect(
          await secondDatabase.select(secondDatabase.cards).get(),
          hasLength(1),
        );
      } finally {
        await secondDatabase.close();
      }
    } finally {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    }
  });
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
          createdAtUtc: Value(testNowUtc(10)),
        ),
      );
}

CardsCompanion _cardCompanion({
  required String collectionId,
  required String contentVersionId,
  required String rarityId,
  required String mediaAssetId,
  required String cardId,
  required int collectionNumber,
}) {
  return CardsCompanion(
    id: Value(cardId),
    collectionId: Value(collectionId),
    contentVersionId: Value(contentVersionId),
    collectionNumber: Value(collectionNumber),
    name: Value('Carta duplicada $collectionNumber'),
    health: const Value(100),
    rarityId: Value(rarityId),
    mediaAssetId: Value(mediaAssetId),
    mediaType: const Value(MediaType.image),
    thumbnailAssetId: const Value(null),
    templateId: const Value('basic'),
    frameId: const Value('clean'),
    primaryColor: const Value(0xFF000000),
    secondaryColor: const Value(0xFFFFFFFF),
    description: const Value(null),
    sortIndex: Value(collectionNumber),
    createdAtUtc: Value(testNowUtc(11)),
  );
}
