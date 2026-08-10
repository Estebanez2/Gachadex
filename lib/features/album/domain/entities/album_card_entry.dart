import '../../../../core/identifiers/entity_id.dart';
import '../../../../core/value_objects/relative_media_path.dart';

enum AlbumFilter { all, owned, missing, favorites }

enum AlbumSort { number, name, rarity, quantity }

final class AlbumCardEntry {
  const AlbumCardEntry({
    required this.cardId,
    required this.collectionNumber,
    required this.name,
    required this.rarityName,
    required this.rarityOrder,
    required this.thumbnailRelativePath,
    required this.imageRelativePath,
    required this.quantity,
    required this.isFavorite,
    required this.firstObtainedAtUtc,
  });

  final CardId cardId;
  final int collectionNumber;
  final String? name;
  final String? rarityName;
  final int rarityOrder;
  final RelativeMediaPath? thumbnailRelativePath;
  final RelativeMediaPath? imageRelativePath;
  final int quantity;
  final bool isFavorite;
  final DateTime? firstObtainedAtUtc;

  bool get isOwned => quantity > 0;
}

final class AlbumStats {
  const AlbumStats({
    required this.distinctOwnedCount,
    required this.totalCardCount,
    required this.totalCopies,
    required this.favoriteCount,
  });

  final int distinctOwnedCount;
  final int totalCardCount;
  final int totalCopies;
  final int favoriteCount;

  double get completionRatio {
    if (totalCardCount == 0) {
      return 0;
    }
    return distinctOwnedCount / totalCardCount;
  }
}
