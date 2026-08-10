import '../../../../core/domain/domain_enums.dart';
import '../../../../core/domain/domain_validation.dart';
import '../../../../core/identifiers/entity_id.dart';

final class PackSlotRule {
  PackSlotRule({
    required this.id,
    required this.packTypeId,
    required int slotIndex,
    required this.ruleType,
    required this.fixedRarityId,
    required int? minimumRarityOrder,
    required this.probabilityGroupId,
  }) : slotIndex = DomainValidation.requireNonNegative(slotIndex, 'slotIndex'),
       minimumRarityOrder = _validateConfiguration(
         ruleType: ruleType,
         fixedRarityId: fixedRarityId,
         minimumRarityOrder: minimumRarityOrder,
         probabilityGroupId: probabilityGroupId,
       );

  final PackSlotRuleId id;
  final PackTypeId packTypeId;
  final int slotIndex;
  final PackSlotRuleType ruleType;
  final RarityId? fixedRarityId;
  final int? minimumRarityOrder;
  final ProbabilityGroupId? probabilityGroupId;

  static int? _validateConfiguration({
    required PackSlotRuleType ruleType,
    required RarityId? fixedRarityId,
    required int? minimumRarityOrder,
    required ProbabilityGroupId? probabilityGroupId,
  }) {
    switch (ruleType) {
      case PackSlotRuleType.fixedRarity:
        if (fixedRarityId == null ||
            minimumRarityOrder != null ||
            probabilityGroupId != null) {
          throw ArgumentError(
            'fixedRarity requires only fixedRarityId to be set.',
          );
        }
        return null;
      case PackSlotRuleType.probabilityDistribution:
        if (probabilityGroupId == null ||
            fixedRarityId != null ||
            minimumRarityOrder != null) {
          throw ArgumentError(
            'probabilityDistribution requires only probabilityGroupId.',
          );
        }
        return null;
      case PackSlotRuleType.minimumRarity:
        if (minimumRarityOrder == null ||
            fixedRarityId != null ||
            probabilityGroupId == null) {
          throw ArgumentError(
            'minimumRarity requires minimumRarityOrder and probabilityGroupId.',
          );
        }

        return DomainValidation.requireNonNegative(
          minimumRarityOrder,
          'minimumRarityOrder',
        );
    }
  }
}
