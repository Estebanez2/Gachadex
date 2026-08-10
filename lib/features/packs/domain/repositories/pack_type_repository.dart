import '../../../../core/identifiers/entity_id.dart';
import '../entities/pack_card_pool_entry.dart';
import '../entities/pack_configuration.dart';
import '../entities/pack_rarity_probability.dart';
import '../entities/pack_slot_rule.dart';
import '../entities/pack_type.dart';

abstract interface class PackTypeRepository {
  Future<PackType> insert(PackType packType);

  Future<PackConfiguration> createConfiguration(PackConfiguration config);

  Future<PackType> update(PackType packType);

  Future<PackConfiguration> updateConfiguration(PackConfiguration config);

  Future<PackType> getById(PackTypeId id);

  Future<PackConfiguration> getFullConfiguration(PackTypeId id);

  Stream<List<PackType>> watchByCollectionVersion({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
  });

  Future<void> delete(PackTypeId id);

  Future<void> reorder({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
    required List<PackTypeId> orderedIds,
  });

  Future<void> setMain(PackTypeId id);

  Future<bool> nameExists({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
    required String name,
    PackTypeId? excludingPackTypeId,
  });

  Future<void> replaceCardPool({
    required PackTypeId packTypeId,
    required List<PackCardPoolEntry> entries,
  });

  Future<void> replaceSlotRules({
    required PackTypeId packTypeId,
    required List<PackSlotRule> rules,
  });

  Future<void> replaceProbabilityGroup({
    required ProbabilityGroupId probabilityGroupId,
    required List<PackRarityProbability> probabilities,
  });

  Future<PackCardPoolEntry> addCardToPool(PackCardPoolEntry entry);

  Future<PackSlotRule> addSlotRule(PackSlotRule rule);

  Future<PackRarityProbability> addRarityProbability(
    PackRarityProbability probability,
  );
}
