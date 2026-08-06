import '../../../../core/identifiers/entity_id.dart';
import '../entities/card.dart';
import '../entities/card_field_value.dart';
import '../entities/media_asset.dart';

final class ImageCardDetails {
  const ImageCardDetails({
    required this.card,
    required this.mediaAsset,
    required this.thumbnailAsset,
    required this.fields,
  });

  final Card card;
  final MediaAsset mediaAsset;
  final MediaAsset? thumbnailAsset;
  final List<CardFieldValue> fields;
}

final class ImageCardGraph {
  const ImageCardGraph({
    required this.card,
    required this.mediaAssets,
    required this.fields,
  });

  final Card card;
  final List<MediaAsset> mediaAssets;
  final List<CardFieldValue> fields;
}

abstract interface class CardRepository {
  Future<Card> insert(Card card);

  Future<ImageCardDetails> createCard(ImageCardGraph graph);

  Future<Card> update(Card card);

  Future<ImageCardDetails> updateCard(ImageCardGraph graph);

  Future<Card> getById(CardId id);

  Future<ImageCardDetails> getImageCardById(CardId id);

  Stream<List<Card>> watchByCollectionVersion({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
  });

  Stream<List<ImageCardDetails>> watchImageCardsByCollectionVersion({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
  });

  Future<void> delete(CardId id);

  Future<ImageCardDetails> deleteCard(CardId id);

  Future<bool> collectionNumberExists({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
    required int collectionNumber,
    CardId? excludingCardId,
  });

  Future<int> countByRarity(RarityId rarityId);
}
