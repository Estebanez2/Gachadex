import 'package:flutter_test/flutter_test.dart';
import 'package:gachadex/core/domain/domain_enums.dart';
import 'package:gachadex/core/identifiers/entity_id.dart';
import 'package:gachadex/core/identifiers/uuid_generator.dart';
import 'package:gachadex/core/time/fake_clock.dart';
import 'package:gachadex/core/value_objects/relative_media_path.dart';
import 'package:gachadex/features/album/domain/entities/owned_card.dart';
import 'package:gachadex/features/cards/domain/entities/card.dart' as domain;
import 'package:gachadex/features/cards/domain/entities/card_field_value.dart';
import 'package:gachadex/features/cards/domain/entities/media_asset.dart';
import 'package:gachadex/features/cards/domain/value_objects/card_field_type.dart';
import 'package:gachadex/features/collection_creator/domain/entities/collection_project.dart';
import 'package:gachadex/features/collection_creator/domain/entities/content_version.dart';
import 'package:gachadex/features/economy/domain/entities/coin_transaction.dart';
import 'package:gachadex/features/packs/domain/entities/pack_inventory.dart';
import 'package:gachadex/features/packs/domain/entities/pack_slot_rule.dart';
import 'package:gachadex/features/packs/domain/entities/pack_type.dart';
import 'package:gachadex/features/rarities/domain/entities/rarity.dart';

import '../../helpers/database_seed.dart';

void main() {
  group('EntityId', () {
    test('validates and compares typed UUID values', () {
      final value = testUuid(1);

      expect(CollectionId(value), CollectionId(value.toUpperCase()));
      expect(CollectionId(value), isNot(CardId(value)));
      expect(CollectionId(value).toJson(), value);
    });

    test('rejects invalid, empty and nil UUID values', () {
      expect(() => CollectionId(''), throwsFormatException);
      expect(() => CollectionId('not-a-uuid'), throwsFormatException);
      expect(
        () => CollectionId('00000000-0000-0000-0000-000000000000'),
        throwsFormatException,
      );
    });
  });

  group('UuidGenerator and Clock', () {
    test('can be injected for deterministic tests', () {
      final generator = FixedUuidGenerator([testUuid(10), testUuid(11)]);
      final clock = FakeClock(DateTime.utc(2026, 8, 5, 10));

      expect(generator.collectionId(), CollectionId(testUuid(10)));
      expect(generator.cardId(), CardId(testUuid(11)));
      expect(clock.nowUtc(), DateTime.utc(2026, 8, 5, 10));

      clock.advance(const Duration(minutes: 5));

      expect(clock.nowUtc(), DateTime.utc(2026, 8, 5, 10, 5));
    });
  });

  group('RelativeMediaPath', () {
    test('accepts normalized relative paths', () {
      expect(
        RelativeMediaPath('collections/a/cards/card.webp').value,
        'collections/a/cards/card.webp',
      );
    });

    test('rejects absolute, parent and URI-like paths', () {
      expect(() => RelativeMediaPath('/tmp/card.webp'), throwsArgumentError);
      expect(
        () => RelativeMediaPath('cards/../card.webp'),
        throwsArgumentError,
      );
      expect(() => RelativeMediaPath(r'cards\card.webp'), throwsArgumentError);
      expect(
        () => RelativeMediaPath('file:///tmp/card.webp'),
        throwsArgumentError,
      );
      expect(() => RelativeMediaPath('C:/tmp/card.webp'), throwsArgumentError);
    });
  });

  group('Enums and fixed catalogs', () {
    test('serialize and parse stable values', () {
      expect(
        CollectionProjectStatus.fromStorage('draft'),
        CollectionProjectStatus.draft,
      );
      expect(MediaType.fromStorage('video'), MediaType.video);
      expect(CardFieldType.parse('attack'), CardFieldType.attack);
    });

    test('reject unknown values instead of silently converting them', () {
      expect(
        () => PackOpeningStatus.fromStorage('unknown'),
        throwsFormatException,
      );
      expect(
        () => CardFieldType.parse('customFreeText'),
        throwsFormatException,
      );
    });
  });

  group('Domain entities', () {
    test('accept valid CollectionProject', () {
      final now = DateTime.utc(2026, 8, 5);

      final project = CollectionProject(
        id: CollectionProjectId(testUuid(1)),
        collectionId: CollectionId(testUuid(2)),
        name: '  Amigos  ',
        author: ' Autor ',
        description: null,
        coverAssetId: null,
        status: CollectionProjectStatus.draft,
        createdAtUtc: now,
        updatedAtUtc: now,
        currentContentVersion: 1,
        currentContentVersionId: ContentVersionId(testUuid(3)),
        mainPackTypeId: null,
      );

      expect(project.name, 'Amigos');
      expect(project.author, 'Autor');
      expect(project.startingPackCount, 3);
    });

    test('enforces core numeric and UTC rules', () {
      final now = DateTime.utc(2026, 8, 5);

      expect(
        () => ContentVersion(
          id: ContentVersionId(testUuid(1)),
          collectionId: CollectionId(testUuid(2)),
          versionNumber: 0,
          createdAtUtc: now,
          finalizedAtUtc: null,
          isCurrent: true,
        ),
        throwsArgumentError,
      );
      expect(
        () => Rarity(
          id: RarityId(testUuid(3)),
          collectionId: CollectionId(testUuid(2)),
          contentVersionId: ContentVersionId(testUuid(1)),
          name: 'Comun',
          orderIndex: 0,
          colorValue: 0xFFFFFFFF,
          iconId: 'spark',
          frameId: 'basic',
          effectId: null,
          sellValue: -1,
          isEnabled: true,
        ),
        throwsArgumentError,
      );
      expect(
        () => CollectionProject(
          id: CollectionProjectId(testUuid(4)),
          collectionId: CollectionId(testUuid(2)),
          name: 'Amigos',
          author: null,
          description: null,
          coverAssetId: null,
          status: CollectionProjectStatus.draft,
          createdAtUtc: DateTime(2026, 8, 5),
          updatedAtUtc: now,
          currentContentVersion: 1,
          currentContentVersionId: ContentVersionId(testUuid(1)),
          mainPackTypeId: null,
        ),
        throwsArgumentError,
      );
    });

    test('enforces card, media and custom field rules', () {
      final now = DateTime.utc(2026, 8, 5);

      expect(
        () => domain.Card(
          id: CardId(testUuid(1)),
          collectionId: CollectionId(testUuid(2)),
          contentVersionId: ContentVersionId(testUuid(3)),
          collectionNumber: -1,
          name: 'Carta',
          health: 100,
          rarityId: RarityId(testUuid(4)),
          mediaAssetId: MediaAssetId(testUuid(5)),
          mediaType: MediaType.image,
          thumbnailAssetId: null,
          templateId: 'basic',
          frameId: 'clean',
          primaryColor: 0xFFFFFFFF,
          secondaryColor: 0xFF000000,
          description: null,
          sortIndex: 0,
          createdAtUtc: now,
        ),
        throwsArgumentError,
      );
      expect(
        () => domain.Card(
          id: CardId(testUuid(1)),
          collectionId: CollectionId(testUuid(2)),
          contentVersionId: ContentVersionId(testUuid(3)),
          collectionNumber: 1,
          name: 'Carta',
          health: 0,
          rarityId: RarityId(testUuid(4)),
          mediaAssetId: MediaAssetId(testUuid(5)),
          mediaType: MediaType.image,
          thumbnailAssetId: null,
          templateId: 'basic',
          frameId: 'clean',
          primaryColor: 0xFFFFFFFF,
          secondaryColor: 0xFF000000,
          description: null,
          sortIndex: 0,
          createdAtUtc: now,
        ),
        throwsArgumentError,
      );
      expect(
        () => MediaAsset(
          id: MediaAssetId(testUuid(5)),
          collectionId: CollectionId(testUuid(2)),
          ownerType: MediaOwnerType.card,
          ownerId: testUuid(1),
          mediaType: MediaType.image,
          relativePath: RelativeMediaPath('cards/card.webp'),
          thumbnailRelativePath: null,
          mimeType: 'image/webp',
          width: 100,
          height: 100,
          durationMs: 1000,
          fileSize: 1,
          sha256: null,
          createdAtUtc: now,
        ),
        throwsArgumentError,
      );
      expect(
        () => CardFieldValue(
          id: CardFieldValueId(testUuid(6)),
          cardId: CardId(testUuid(1)),
          fieldType: CardFieldType.famousQuote,
          value: '',
          displayOrder: 0,
        ),
        throwsArgumentError,
      );
    });

    test('enforces pack and progress rules', () {
      final now = DateTime.utc(2026, 8, 5);

      expect(
        () => PackType(
          id: PackTypeId(testUuid(1)),
          collectionId: CollectionId(testUuid(2)),
          contentVersionId: ContentVersionId(testUuid(3)),
          name: 'Sobre',
          description: null,
          frontAssetId: null,
          backAssetId: null,
          cardCount: 0,
          rechargeSeconds: 3600,
          maxAccumulated: 3,
          isMain: true,
          coinsPerFullRecharge: 0,
          sortIndex: 0,
        ),
        throwsArgumentError,
      );
      expect(
        () => PackSlotRule(
          id: PackSlotRuleId(testUuid(4)),
          packTypeId: PackTypeId(testUuid(1)),
          slotIndex: 0,
          ruleType: PackSlotRuleType.fixedRarity,
          fixedRarityId: null,
          minimumRarityOrder: null,
          probabilityGroupId: null,
        ),
        throwsArgumentError,
      );
      expect(
        () => PackInventory(
          installedCollectionId: InstalledCollectionId(testUuid(5)),
          packTypeId: PackTypeId(testUuid(1)),
          availableCount: 4,
          maxAccumulated: 3,
          nextRechargeAtUtc: now,
          lastCalculatedAtUtc: now,
        ),
        throwsArgumentError,
      );
      expect(
        () => OwnedCard(
          installedCollectionId: InstalledCollectionId(testUuid(5)),
          cardId: CardId(testUuid(6)),
          quantity: 0,
          firstObtainedAtUtc: now,
          lastObtainedAtUtc: now,
          isFavorite: false,
        ),
        throwsArgumentError,
      );
      expect(
        () => CoinTransaction(
          id: CoinTransactionId(testUuid(7)),
          installedCollectionId: InstalledCollectionId(testUuid(5)),
          transactionType: CoinTransactionType.manualAdjustment,
          amount: -1,
          balanceAfter: -1,
          relatedCardId: null,
          relatedPackTypeId: null,
          createdAtUtc: now,
          metadataJson: null,
        ),
        throwsArgumentError,
      );
    });
  });
}
