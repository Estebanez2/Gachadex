import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/pack_card_pool_entry.dart';
import '../../domain/entities/pack_rarity_probability.dart';
import '../../domain/entities/pack_slot_rule.dart';

extension PackCardPoolEntryDomainMapper on PackCardPoolEntry {
  PackCardPoolCompanion toCompanion() {
    return PackCardPoolCompanion(
      packTypeId: Value(packTypeId.value),
      cardId: Value(cardId.value),
      isEnabled: Value(isEnabled),
    );
  }
}

extension PackSlotRuleDomainMapper on PackSlotRule {
  PackSlotRulesCompanion toCompanion() {
    return PackSlotRulesCompanion(
      id: Value(id.value),
      packTypeId: Value(packTypeId.value),
      slotIndex: Value(slotIndex),
      ruleType: Value(ruleType),
      fixedRarityId: Value(fixedRarityId?.value),
      minimumRarityOrder: Value(minimumRarityOrder),
      probabilityGroupId: Value(probabilityGroupId?.value),
    );
  }
}

extension PackRarityProbabilityDomainMapper on PackRarityProbability {
  PackRarityProbabilitiesCompanion toCompanion() {
    return PackRarityProbabilitiesCompanion(
      probabilityGroupId: Value(probabilityGroupId.value),
      rarityId: Value(rarityId.value),
      weight: Value(weight),
    );
  }
}
