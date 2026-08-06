import '../../../../core/identifiers/entity_id.dart';
import '../entities/rarity.dart';

abstract interface class RarityRepository {
  Future<Rarity> insert(Rarity rarity);

  Future<Rarity> update(Rarity rarity);

  Future<Rarity> getById(RarityId id);

  Stream<List<Rarity>> watchByCollectionVersion({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
  });

  Future<bool> existsWithNormalizedName({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
    required String normalizedName,
    RarityId? excludingId,
  });

  Future<int> countByCollectionVersion({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
  });

  Future<int> countCardsUsingRarity(RarityId rarityId);

  Future<void> delete(RarityId id);

  Future<List<Rarity>> reorder({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
    required List<RarityId> orderedIds,
  });
}
