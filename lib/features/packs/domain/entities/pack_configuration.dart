import '../../../cards/domain/entities/card.dart';
import '../../../rarities/domain/entities/rarity.dart';
import 'pack_card_pool_entry.dart';
import 'pack_rarity_probability.dart';
import 'pack_slot_rule.dart';
import 'pack_type.dart';

final class PackConfiguration {
  const PackConfiguration({
    required this.packType,
    required this.pool,
    required this.slotRules,
    required this.probabilities,
  });

  final PackType packType;
  final List<PackCardPoolEntry> pool;
  final List<PackSlotRule> slotRules;
  final List<PackRarityProbability> probabilities;
}

final class PackGenerationContext {
  const PackGenerationContext({
    required this.configuration,
    required this.eligibleCards,
    required this.rarities,
  });

  final PackConfiguration configuration;
  final List<Card> eligibleCards;
  final List<Rarity> rarities;
}
