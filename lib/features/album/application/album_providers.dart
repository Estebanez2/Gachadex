import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_providers.dart';
import '../../../core/identifiers/entity_id.dart';
import '../domain/entities/album_card_entry.dart';

typedef AlbumCardsArgs = ({
  InstalledCollectionId installedCollectionId,
  AlbumQuery query,
});

final albumQueryProvider = NotifierProvider<AlbumQueryController, AlbumQuery>(
  AlbumQueryController.new,
);

final class AlbumQueryController extends Notifier<AlbumQuery> {
  @override
  AlbumQuery build() => AlbumQuery.initial;

  void setStatus(AlbumStatusFilter value) {
    state = state.copyWith(status: value);
  }

  void setSort(AlbumSort value) {
    state = state.copyWith(sort: value);
  }

  void setRarity(RarityId? value) {
    state = value == null
        ? state.copyWith(clearRarity: true)
        : state.copyWith(rarityId: value);
  }

  void setMedia(AlbumMediaFilter value) {
    state = state.copyWith(media: value);
  }
}

final albumCardsProvider = StreamProvider.autoDispose
    .family<List<AlbumCardEntry>, AlbumCardsArgs>((ref, args) {
      return ref
          .watch(albumRepositoryProvider)
          .watchCards(
            installedCollectionId: args.installedCollectionId,
            query: args.query,
          );
    });

final albumRaritiesProvider = StreamProvider.autoDispose
    .family<List<AlbumRarityOption>, InstalledCollectionId>((ref, id) {
      return ref.watch(albumRepositoryProvider).watchRarities(id);
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
