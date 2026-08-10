import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/mappers/date_time_mapper.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../../../../core/value_objects/relative_media_path.dart';
import '../../domain/entities/album_card_entry.dart';
import '../../domain/repositories/album_repository.dart';

final class DriftAlbumRepository implements AlbumRepository {
  DriftAlbumRepository({required this.database});

  final AppDatabase database;

  @override
  Stream<List<AlbumCardEntry>> watchCards({
    required InstalledCollectionId installedCollectionId,
    required AlbumFilter filter,
    required AlbumSort sort,
  }) {
    return _collectionVersion(installedCollectionId).asStream().asyncExpand((
      version,
    ) {
      final query = _albumQuery(
        installedCollectionId: installedCollectionId,
        collectionId: version.collectionId,
        contentVersionId: version.contentVersionId,
      );
      return query.watch().map((rows) {
        final entries = rows.map(_entryFromRow).where((entry) {
          return switch (filter) {
            AlbumFilter.all => true,
            AlbumFilter.owned => entry.isOwned,
            AlbumFilter.missing => !entry.isOwned,
            AlbumFilter.favorites => entry.isFavorite,
          };
        }).toList();
        entries.sort((a, b) {
          return switch (sort) {
            AlbumSort.number => a.collectionNumber.compareTo(
              b.collectionNumber,
            ),
            AlbumSort.name => (a.name ?? '').compareTo(b.name ?? ''),
            AlbumSort.rarity => a.rarityOrder.compareTo(b.rarityOrder),
            AlbumSort.quantity => b.quantity.compareTo(a.quantity),
          };
        });
        return entries;
      });
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
    return _entryFromRow(row);
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

  AlbumCardEntry _entryFromRow(TypedResult row) {
    final card = row.readTable(database.cards);
    final rarity = row.readTable(database.rarities);
    final media = row.readTable(database.mediaAssets);
    final owned = row.readTableOrNull(database.ownedCards);
    final isOwned = owned != null;
    return AlbumCardEntry(
      cardId: CardId(card.id),
      collectionNumber: card.collectionNumber,
      name: isOwned ? card.name : null,
      rarityName: isOwned ? rarity.name : null,
      rarityOrder: rarity.orderIndex,
      thumbnailRelativePath: isOwned
          ? RelativeMediaPath(media.thumbnailRelativePath ?? media.relativePath)
          : null,
      imageRelativePath: isOwned ? RelativeMediaPath(media.relativePath) : null,
      quantity: owned?.quantity ?? 0,
      isFavorite: owned?.isFavorite ?? false,
      firstObtainedAtUtc: owned == null
          ? null
          : fromDatabaseUtc(owned.firstObtainedAtUtc),
    );
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
