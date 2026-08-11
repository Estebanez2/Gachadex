import '../../../../core/identifiers/entity_id.dart';
import '../../../../core/value_objects/relative_media_path.dart';
import '../../../../core/domain/domain_enums.dart';

enum AlbumStatusFilter { all, owned, missing, repeated, favorites }

enum AlbumSort { number, name, rarity, firstObtained, quantity }

enum AlbumMediaFilter { all, image, video }

final class AlbumQuery {
  const AlbumQuery({
    required this.status,
    required this.sort,
    required this.rarityId,
    required this.media,
  });

  final AlbumStatusFilter status;
  final AlbumSort sort;
  final RarityId? rarityId;
  final AlbumMediaFilter media;

  AlbumQuery copyWith({
    AlbumStatusFilter? status,
    AlbumSort? sort,
    RarityId? rarityId,
    bool clearRarity = false,
    AlbumMediaFilter? media,
  }) {
    return AlbumQuery(
      status: status ?? this.status,
      sort: sort ?? this.sort,
      rarityId: clearRarity ? null : rarityId ?? this.rarityId,
      media: media ?? this.media,
    );
  }

  static const initial = AlbumQuery(
    status: AlbumStatusFilter.all,
    sort: AlbumSort.number,
    rarityId: null,
    media: AlbumMediaFilter.all,
  );
}

final class AlbumCardEntry {
  const AlbumCardEntry({
    required this.cardId,
    required this.rarityId,
    required this.collectionNumber,
    required this.name,
    required this.health,
    required this.rarityName,
    required this.rarityOrder,
    required this.rarityColorValue,
    required this.rarityEffectId,
    required this.sellValue,
    required this.mediaType,
    required this.thumbnailRelativePath,
    required this.imageRelativePath,
    required this.description,
    required this.templateId,
    required this.frameId,
    required this.fieldValues,
    required this.quantity,
    required this.isFavorite,
    required this.firstObtainedAtUtc,
  });

  final CardId cardId;
  final RarityId rarityId;
  final int collectionNumber;
  final String? name;
  final int? health;
  final String? rarityName;
  final int rarityOrder;
  final int? rarityColorValue;
  final String? rarityEffectId;
  final int? sellValue;
  final MediaType mediaType;
  final RelativeMediaPath? thumbnailRelativePath;
  final RelativeMediaPath? imageRelativePath;
  final String? description;
  final String? templateId;
  final String? frameId;
  final List<AlbumCardFieldEntry> fieldValues;
  final int quantity;
  final bool isFavorite;
  final DateTime? firstObtainedAtUtc;

  bool get isOwned => quantity > 0;
  bool get isRepeated => quantity > 1;
  int get sellableCopies => quantity > 1 ? quantity - 1 : 0;
}

final class AlbumCardFieldEntry {
  const AlbumCardFieldEntry({required this.label, required this.value});

  final String label;
  final String value;
}

final class AlbumRarityOption {
  const AlbumRarityOption({required this.id, required this.name});

  final RarityId id;
  final String name;
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
