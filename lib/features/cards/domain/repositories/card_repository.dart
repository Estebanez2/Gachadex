import '../../../../core/identifiers/entity_id.dart';
import '../entities/card.dart';

abstract interface class CardRepository {
  Future<Card> insert(Card card);

  Future<Card> update(Card card);

  Future<Card> getById(CardId id);

  Stream<List<Card>> watchByCollectionVersion({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
  });

  Future<void> delete(CardId id);

  Future<int> countByRarity(RarityId rarityId);
}
