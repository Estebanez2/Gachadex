import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_providers.dart';
import '../../../core/identifiers/entity_id.dart';
import '../domain/entities/album_card_entry.dart';

typedef AlbumCardsArgs = ({
  InstalledCollectionId installedCollectionId,
  AlbumFilter filter,
  AlbumSort sort,
});

final albumFilterProvider =
    NotifierProvider<AlbumFilterController, AlbumFilter>(
      AlbumFilterController.new,
    );

final albumSortProvider = NotifierProvider<AlbumSortController, AlbumSort>(
  AlbumSortController.new,
);

final class AlbumFilterController extends Notifier<AlbumFilter> {
  @override
  AlbumFilter build() => AlbumFilter.all;

  void setFilter(AlbumFilter value) => state = value;
}

final class AlbumSortController extends Notifier<AlbumSort> {
  @override
  AlbumSort build() => AlbumSort.number;

  void setSort(AlbumSort value) => state = value;
}

final albumCardsProvider = StreamProvider.autoDispose
    .family<List<AlbumCardEntry>, AlbumCardsArgs>((ref, args) {
      return ref
          .watch(albumRepositoryProvider)
          .watchCards(
            installedCollectionId: args.installedCollectionId,
            filter: args.filter,
            sort: args.sort,
          );
    });

final albumStatsProvider = StreamProvider.autoDispose
    .family<AlbumStats, InstalledCollectionId>((ref, id) {
      return ref.watch(albumRepositoryProvider).watchStats(id);
    });

final albumCardProvider = FutureProvider.autoDispose
    .family<AlbumCardEntry, ({InstalledCollectionId id, CardId cardId})>((
      ref,
      args,
    ) {
      return ref
          .watch(albumRepositoryProvider)
          .getCard(installedCollectionId: args.id, cardId: args.cardId);
    });

final toggleFavoriteCardProvider = Provider((ref) {
  return ref.watch(albumRepositoryProvider).toggleFavorite;
});
