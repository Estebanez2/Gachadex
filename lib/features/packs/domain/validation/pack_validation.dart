import '../../../../core/domain/domain_enums.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../../../cards/domain/entities/card.dart';
import '../../../rarities/domain/entities/rarity.dart';
import '../entities/pack_configuration.dart';

enum PackValidationIssue {
  emptyName,
  nameTooLong,
  duplicateName,
  cardCountOutOfRange,
  rechargeSecondsMissing,
  maxAccumulatedMissing,
  mainPackNeedsThree,
  noEligibleCards,
  wrongSlotRuleCount,
  missingProbabilityWeight,
  invalidFixedRarity,
  invalidMinimumRarity,
  slotCannotGenerateCard,
}

final class PackValidationResult {
  const PackValidationResult(this.issues);

  final Set<PackValidationIssue> issues;

  bool get canSave => issues.isEmpty;
}

abstract final class PackValidation {
  static const maxNameLength = 60;
  static const minCardCount = 1;
  static const maxCardCount = 10;

  static String normalizedName(String value) => value.trim().toLowerCase();

  static PackValidationResult validateConfiguration({
    required PackConfiguration configuration,
    required List<Card> cards,
    required List<Rarity> rarities,
    bool hasDuplicateName = false,
  }) {
    final issues = <PackValidationIssue>{};
    final pack = configuration.packType;
    if (pack.name.trim().isEmpty) {
      issues.add(PackValidationIssue.emptyName);
    }
    if (pack.name.trim().length > maxNameLength) {
      issues.add(PackValidationIssue.nameTooLong);
    }
    if (hasDuplicateName) {
      issues.add(PackValidationIssue.duplicateName);
    }
    if (pack.cardCount < minCardCount || pack.cardCount > maxCardCount) {
      issues.add(PackValidationIssue.cardCountOutOfRange);
    }
    if (pack.rechargeSeconds <= 0) {
      issues.add(PackValidationIssue.rechargeSecondsMissing);
    }
    if (pack.maxAccumulated <= 0) {
      issues.add(PackValidationIssue.maxAccumulatedMissing);
    }
    if (pack.isMain && pack.maxAccumulated < 3) {
      issues.add(PackValidationIssue.mainPackNeedsThree);
    }

    final enabledCardIds = configuration.pool
        .where((entry) => entry.isEnabled)
        .map((entry) => entry.cardId)
        .toSet();
    final eligibleCards = cards
        .where(
          (card) =>
              enabledCardIds.contains(card.id) &&
              card.collectionId == pack.collectionId &&
              card.contentVersionId == pack.contentVersionId,
        )
        .toList();
    if (eligibleCards.isEmpty) {
      issues.add(PackValidationIssue.noEligibleCards);
    }

    final rulesBySlot = {
      for (final rule in configuration.slotRules) rule.slotIndex: rule,
    };
    if (rulesBySlot.length != pack.cardCount) {
      issues.add(PackValidationIssue.wrongSlotRuleCount);
    }

    final rarityById = {for (final rarity in rarities) rarity.id: rarity};
    final cardsByRarity = <RarityId, List<Card>>{};
    for (final card in eligibleCards) {
      cardsByRarity.putIfAbsent(card.rarityId, () => []).add(card);
    }

    for (var index = 0; index < pack.cardCount; index++) {
      final rule = rulesBySlot[index];
      if (rule == null) {
        issues.add(PackValidationIssue.wrongSlotRuleCount);
        continue;
      }
      switch (rule.ruleType) {
        case PackSlotRuleType.fixedRarity:
          final fixedId = rule.fixedRarityId;
          if (fixedId == null ||
              !rarityById.containsKey(fixedId) ||
              (cardsByRarity[fixedId]?.isEmpty ?? true)) {
            issues.add(PackValidationIssue.invalidFixedRarity);
            issues.add(PackValidationIssue.slotCannotGenerateCard);
          }
        case PackSlotRuleType.probabilityDistribution:
          if (!_hasPositiveWeight(configuration, rule.probabilityGroupId)) {
            issues.add(PackValidationIssue.missingProbabilityWeight);
          }
          if (eligibleCards.isEmpty) {
            issues.add(PackValidationIssue.slotCannotGenerateCard);
          }
        case PackSlotRuleType.minimumRarity:
          final groupId = rule.probabilityGroupId;
          final minimum = rule.minimumRarityOrder;
          final hasAnyAllowedCard =
              minimum != null &&
              eligibleCards.any((card) {
                final rarity = rarityById[card.rarityId];
                return rarity != null && rarity.orderIndex >= minimum;
              });
          if (minimum == null || groupId == null || !hasAnyAllowedCard) {
            issues.add(PackValidationIssue.invalidMinimumRarity);
            issues.add(PackValidationIssue.slotCannotGenerateCard);
          }
          if (!_hasPositiveWeight(configuration, groupId)) {
            issues.add(PackValidationIssue.missingProbabilityWeight);
          }
      }
    }

    return PackValidationResult(issues);
  }

  static bool _hasPositiveWeight(
    PackConfiguration configuration,
    ProbabilityGroupId? probabilityGroupId,
  ) {
    if (probabilityGroupId == null) {
      return false;
    }

    return configuration.probabilities.any(
      (probability) =>
          probability.probabilityGroupId == probabilityGroupId &&
          probability.weight > 0,
    );
  }
}
