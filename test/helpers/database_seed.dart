import 'package:drift/drift.dart';
import 'package:gachadex/core/database/app_database.dart';
import 'package:gachadex/core/domain/domain_enums.dart';

DateTime testNowUtc([int minutes = 0]) {
  return DateTime.utc(2026, 8, 5, 12, minutes);
}

String testUuid(int value) {
  return '00000000-0000-4000-8000-${value.toString().padLeft(12, '0')}';
}

final class SeededDefinition {
  const SeededDefinition({
    required this.collectionId,
    required this.contentVersionId,
    required this.rarityId,
    required this.mediaAssetId,
    required this.cardId,
    required this.packTypeId,
  });

  final String collectionId;
  final String contentVersionId;
  final String rarityId;
  final String mediaAssetId;
  final String cardId;
  final String packTypeId;
}

Future<SeededDefinition> seedDefinition(
  AppDatabase database, {
  required int seed,
  int collectionNumber = 1,
}) async {
  final collectionId = testUuid(seed * 100 + 1);
  final contentVersionId = testUuid(seed * 100 + 2);
  final rarityId = testUuid(seed * 100 + 3);
  final mediaAssetId = testUuid(seed * 100 + 4);
  final cardId = testUuid(seed * 100 + 5);
  final packTypeId = testUuid(seed * 100 + 6);
  final now = testNowUtc(seed);

  await database
      .into(database.contentVersions)
      .insert(
        ContentVersionsCompanion(
          id: Value(contentVersionId),
          collectionId: Value(collectionId),
          versionNumber: const Value(1),
          formatVersion: const Value(1),
          createdAtUtc: Value(now),
          finalizedAtUtc: const Value(null),
          isCurrent: const Value(true),
        ),
      );
  await database
      .into(database.rarities)
      .insert(
        RaritiesCompanion(
          id: Value(rarityId),
          collectionId: Value(collectionId),
          contentVersionId: Value(contentVersionId),
          name: Value('Rareza $seed'),
          orderIndex: const Value(0),
          colorValue: const Value(0xFF3366CC),
          iconId: const Value('spark'),
          frameId: const Value('clean'),
          effectId: const Value(null),
          sellValue: const Value(10),
          isEnabled: const Value(true),
        ),
      );
  await database
      .into(database.mediaAssets)
      .insert(
        MediaAssetsCompanion(
          id: Value(mediaAssetId),
          collectionId: Value(collectionId),
          ownerType: const Value(MediaOwnerType.card),
          ownerId: Value(cardId),
          mediaType: const Value(MediaType.image),
          relativePath: Value('collections/$collectionId/cards/$cardId.webp'),
          thumbnailRelativePath: Value(
            'collections/$collectionId/cards/$cardId-thumb.webp',
          ),
          mimeType: const Value('image/webp'),
          width: const Value(720),
          height: const Value(960),
          durationMs: const Value(null),
          fileSize: const Value(2048),
          sha256: const Value(null),
          createdAtUtc: Value(now),
        ),
      );
  await database
      .into(database.cards)
      .insert(
        CardsCompanion(
          id: Value(cardId),
          collectionId: Value(collectionId),
          contentVersionId: Value(contentVersionId),
          collectionNumber: Value(collectionNumber),
          name: Value('Carta $seed'),
          health: const Value(100),
          rarityId: Value(rarityId),
          mediaAssetId: Value(mediaAssetId),
          mediaType: const Value(MediaType.image),
          thumbnailAssetId: const Value(null),
          templateId: const Value('basic'),
          frameId: const Value('clean'),
          primaryColor: const Value(0xFF3366CC),
          secondaryColor: const Value(0xFFFFCC33),
          description: const Value('Descripcion de prueba'),
          sortIndex: Value(collectionNumber),
          createdAtUtc: Value(now),
        ),
      );
  await database
      .into(database.packTypes)
      .insert(
        PackTypesCompanion(
          id: Value(packTypeId),
          collectionId: Value(collectionId),
          contentVersionId: Value(contentVersionId),
          name: Value('Sobre $seed'),
          description: const Value(null),
          frontAssetId: const Value(null),
          backAssetId: const Value(null),
          cardCount: const Value(3),
          rechargeSeconds: const Value(3600),
          maxAccumulated: const Value(3),
          isMain: const Value(true),
          coinsPerFullRecharge: const Value(0),
          sortIndex: const Value(0),
        ),
      );

  return SeededDefinition(
    collectionId: collectionId,
    contentVersionId: contentVersionId,
    rarityId: rarityId,
    mediaAssetId: mediaAssetId,
    cardId: cardId,
    packTypeId: packTypeId,
  );
}

Future<String> seedInstalledCollection(
  AppDatabase database,
  SeededDefinition definition, {
  int seed = 50,
}) async {
  final installedCollectionId = testUuid(seed * 100 + 7);
  await database
      .into(database.installedCollections)
      .insert(
        InstalledCollectionsCompanion(
          id: Value(installedCollectionId),
          collectionId: Value(definition.collectionId),
          contentVersionId: Value(definition.contentVersionId),
          name: const Value('Coleccion instalada'),
          author: const Value('Autor'),
          description: const Value(null),
          coverRelativePath: const Value(null),
          mainPackTypeId: Value(definition.packTypeId),
          installedAtUtc: Value(testNowUtc(seed)),
          source: const Value(InstalledCollectionSource.createdLocally),
          coins: const Value(0),
          totalCardCount: const Value(1),
          distinctOwnedCount: const Value(0),
        ),
      );

  return installedCollectionId;
}
