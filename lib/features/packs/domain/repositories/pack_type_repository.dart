import '../../../../core/identifiers/entity_id.dart';
import '../entities/pack_card_pool_entry.dart';
import '../entities/pack_rarity_probability.dart';
import '../entities/pack_slot_rule.dart';
import '../entities/pack_type.dart';

abstract interface class PackTypeRepository {
  Future<PackType> insert(PackType packType);

  Future<PackType> update(PackType packType);

  Future<PackType> getById(PackTypeId id);

  Stream<List<PackType>> watchByCollectionVersion({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
  });

  Future<void> delete(PackTypeId id);

  Future<PackCardPoolEntry> addCardToPool(PackCardPoolEntry entry);

  Future<PackSlotRule> addSlotRule(PackSlotRule rule);

  Future<PackRarityProbability> addRarityProbability(
    PackRarityProbability probability,
  );
}
