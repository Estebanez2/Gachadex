import '../../../../core/identifiers/entity_id.dart';
import '../entities/album_card_entry.dart';

abstract interface class AlbumRepository {
  Stream<List<AlbumCardEntry>> watchCards({
    required InstalledCollectionId installedCollectionId,
    required AlbumQuery query,
  });

  Stream<List<AlbumRarityOption>> watchRarities(
    InstalledCollectionId installedCollectionId,
  );

  Stream<AlbumStats> watchStats(InstalledCollectionId installedCollectionId);

  Future<AlbumCardEntry> getCard({
    required InstalledCollectionId installedCollectionId,
    required CardId cardId,
  });

  Future<void> toggleFavorite({
    required InstalledCollectionId installedCollectionId,
    required CardId cardId,
  });
}
