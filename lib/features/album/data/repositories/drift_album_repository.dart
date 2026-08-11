import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/mappers/date_time_mapper.dart';
import '../../../../core/domain/domain_enums.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../../../../core/value_objects/relative_media_path.dart';
import '../../../cards/domain/catalogs/card_template_catalog.dart';
import '../../../cards/domain/value_objects/card_field_type.dart';
import '../../domain/entities/album_card_entry.dart';
import '../../domain/repositories/album_repository.dart';

final class DriftAlbumRepository implements AlbumRepository {
  DriftAlbumRepository({required this.database});

  final AppDatabase database;

  @override
  Stream<List<AlbumCardEntry>> watchCards({
    required InstalledCollectionId installedCollectionId,
    required AlbumQuery query,
  }) {
    return _collectionVersion(installedCollectionId).asStream().asyncExpand((
      version,
    ) {
      final albumQuery = _albumQuery(
        installedCollectionId: installedCollectionId,
        collectionId: version.collectionId,
        contentVersionId: version.contentVersionId,
      );
      return albumQuery.watch().map((rows) {
        final entries = rows.map(_entryFromRow).where((entry) {
          final statusMatches = switch (query.status) {
            AlbumStatusFilter.all => true,
            AlbumStatusFilter.owned => entry.isOwned,
            AlbumStatusFilter.missing => !entry.isOwned,
            AlbumStatusFilter.repeated => entry.isRepeated,
            AlbumStatusFilter.favorites => entry.isFavorite,
          };
          final rarityMatches =
              query.rarityId == null || entry.rarityId == query.rarityId;
          final mediaMatches = switch (query.media) {
            AlbumMediaFilter.all => true,
            AlbumMediaFilter.image => entry.mediaType == MediaType.image,
            AlbumMediaFilter.video => entry.mediaType == MediaType.video,
          };
          return statusMatches && rarityMatches && mediaMatches;
        }).toList();
        entries.sort((a, b) {
          return switch (query.sort) {
            AlbumSort.number => a.collectionNumber.compareTo(
              b.collectionNumber,
            ),
            AlbumSort.name => (a.name ?? '').compareTo(b.name ?? ''),
            AlbumSort.rarity => a.rarityOrder.compareTo(b.rarityOrder),
            AlbumSort.firstObtained => _compareObtainedDate(a, b),
            AlbumSort.quantity => b.quantity.compareTo(a.quantity),
          };
        });
        return entries;
      });
    });
  }

  @override
  Stream<List<AlbumRarityOption>> watchRarities(
    InstalledCollectionId installedCollectionId,
  ) {
    return _collectionVersion(installedCollectionId).asStream().asyncExpand((
      version,
    ) {
      final query = database.select(database.rarities)
        ..where(
          (table) =>
              table.collectionId.equals(version.collectionId.value) &
              table.contentVersionId.equals(version.contentVersionId.value),
        )
        ..orderBy([(table) => OrderingTerm.asc(table.orderIndex)]);
      return query.watch().map(
        (rows) => rows
            .map(
              (row) => AlbumRarityOption(id: RarityId(row.id), name: row.name),
            )
            .toList(),
      );
    });
  }

  @override
  Stream<AlbumStats> watchStats(InstalledCollectionId installedCollectionId) {
    return _collectionVersion(installedCollectionId).asStream().asyncExpand((
      version,
    ) {
      final query = _albumQuery(
        installedCollectionId: installedCollectionId,
        collectionId: version.collectionId,
        contentVersionId: version.contentVersionId,
      );
      return query.watch().map((rows) {
        var distinctOwned = 0;
        var totalCopies = 0;
        var favorites = 0;
        for (final row in rows) {
          final owned = row.readTableOrNull(database.ownedCards);
          if (owned == null) {
            continue;
          }
          distinctOwned += 1;
          totalCopies += owned.quantity;
          if (owned.isFavorite) {
            favorites += 1;
          }
        }
        return AlbumStats(
          distinctOwnedCount: distinctOwned,
          totalCardCount: rows.length,
          totalCopies: totalCopies,
          favoriteCount: favorites,
        );
      });
    });
  }

  @override
  Future<AlbumCardEntry> getCard({
    required InstalledCollectionId installedCollectionId,
    required CardId cardId,
  }) async {
    final version = await _collectionVersion(installedCollectionId);
    final row = await (_albumQuery(
      installedCollectionId: installedCollectionId,
      collectionId: version.collectionId,
      contentVersionId: version.contentVersionId,
    )..where(database.cards.id.equals(cardId.value))).getSingleOrNull();
    if (row == null) {
      throw const EntityNotFoundFailure('No se encontro la carta.');
    }
    return _entryFromRow(
      row,
      fieldValues: await _fieldEntriesFor(cardId.value),
    );
  }

  @override
  Future<void> toggleFavorite({
    required InstalledCollectionId installedCollectionId,
    required CardId cardId,
  }) async {
    final owned =
        await (database.select(database.ownedCards)..where(
              (table) =>
                  table.installedCollectionId.equals(
                    installedCollectionId.value,
                  ) &
                  table.cardId.equals(cardId.value),
            ))
            .getSingleOrNull();
    if (owned == null) {
      throw const InvalidEntityFailure(
        'Solo puedes marcar favoritas cartas obtenidas.',
      );
    }
    await (database.update(database.ownedCards)..where(
          (table) =>
              table.installedCollectionId.equals(installedCollectionId.value) &
              table.cardId.equals(cardId.value),
        ))
        .write(OwnedCardsCompanion(isFavorite: Value(!owned.isFavorite)));
  }

  Future<_CollectionVersion> _collectionVersion(
    InstalledCollectionId installedCollectionId,
  ) async {
    final installed =
        await (database.select(database.installedCollections)
              ..where((table) => table.id.equals(installedCollectionId.value)))
            .getSingleOrNull();
    if (installed == null) {
      throw const EntityNotFoundFailure(
        'No se encontro la coleccion instalada.',
      );
    }
    return _CollectionVersion(
      collectionId: CollectionId(installed.collectionId),
      contentVersionId: ContentVersionId(installed.contentVersionId),
    );
  }

  JoinedSelectStatement<HasResultSet, dynamic> _albumQuery({
    required InstalledCollectionId installedCollectionId,
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
  }) {
    return database.select(database.cards).join([
      innerJoin(
        database.rarities,
        database.rarities.id.equalsExp(database.cards.rarityId),
      ),
      innerJoin(
        database.mediaAssets,
        database.mediaAssets.id.equalsExp(database.cards.mediaAssetId),
      ),
      leftOuterJoin(
        database.ownedCards,
        database.ownedCards.cardId.equalsExp(database.cards.id) &
            database.ownedCards.installedCollectionId.equals(
              installedCollectionId.value,
            ),
      ),
    ])..where(
      database.cards.collectionId.equals(collectionId.value) &
          database.cards.contentVersionId.equals(contentVersionId.value),
    );
  }

  AlbumCardEntry _entryFromRow(
    TypedResult row, {
    List<AlbumCardFieldEntry> fieldValues = const [],
  }) {
    final card = row.readTable(database.cards);
    final rarity = row.readTable(database.rarities);
    final media = row.readTable(database.mediaAssets);
    final owned = row.readTableOrNull(database.ownedCards);
    final isOwned = owned != null;
    return AlbumCardEntry(
      cardId: CardId(card.id),
      rarityId: RarityId(card.rarityId),
      collectionNumber: card.collectionNumber,
      name: isOwned ? card.name : null,
      health: isOwned ? card.health : null,
      rarityName: isOwned ? rarity.name : null,
      rarityOrder: rarity.orderIndex,
      sellValue: isOwned ? rarity.sellValue : null,
      mediaType: card.mediaType,
      thumbnailRelativePath: isOwned
          ? RelativeMediaPath(media.thumbnailRelativePath ?? media.relativePath)
          : null,
      imageRelativePath: isOwned ? RelativeMediaPath(media.relativePath) : null,
      description: isOwned ? card.description : null,
      templateId: isOwned ? _templateName(card.templateId) : null,
      frameId: isOwned ? _frameName(card.frameId) : null,
      fieldValues: isOwned ? fieldValues : const [],
      quantity: owned?.quantity ?? 0,
      isFavorite: owned?.isFavorite ?? false,
      firstObtainedAtUtc: owned == null
          ? null
          : fromDatabaseUtc(owned.firstObtainedAtUtc),
    );
  }

  Future<List<AlbumCardFieldEntry>> _fieldEntriesFor(String cardId) async {
    final rows =
        await (database.select(database.cardFieldValues)
              ..where((table) => table.cardId.equals(cardId))
              ..orderBy([(table) => OrderingTerm.asc(table.displayOrder)]))
            .get();
    return rows
        .map(
          (row) => AlbumCardFieldEntry(
            label: CardTemplateCatalog.labelForField(
              CardFieldType.parse(row.fieldTypeId),
            ),
            value: row.value,
          ),
        )
        .toList();
  }

  static int _compareObtainedDate(AlbumCardEntry a, AlbumCardEntry b) {
    final aDate = a.firstObtainedAtUtc;
    final bDate = b.firstObtainedAtUtc;
    if (aDate == null && bDate == null) {
      return a.collectionNumber.compareTo(b.collectionNumber);
    }
    if (aDate == null) {
      return 1;
    }
    if (bDate == null) {
      return -1;
    }
    return aDate.compareTo(bDate);
  }

  static String _templateName(String id) {
    return CardTemplateCatalog.templateById(id).name;
  }

  static String _frameName(String id) {
    return CardTemplateCatalog.frames
        .firstWhere(
          (frame) => frame.id == id,
          orElse: () => CardTemplateCatalog.frames.first,
        )
        .name;
  }
}

final class _CollectionVersion {
  const _CollectionVersion({
    required this.collectionId,
    required this.contentVersionId,
  });

  final CollectionId collectionId;
  final ContentVersionId contentVersionId;
}
