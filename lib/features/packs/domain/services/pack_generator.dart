import 'dart:math';

import '../../../../core/domain/domain_enums.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../../../cards/domain/entities/card.dart';
import '../../../rarities/domain/entities/rarity.dart';
import '../entities/pack_configuration.dart';
import '../entities/pack_rarity_probability.dart';
import '../entities/pack_slot_rule.dart';

final class PackGenerationException implements Exception {
  const PackGenerationException(this.message);

  final String message;

  @override
  String toString() => message;
}

final class PackGenerator {
  const PackGenerator();

  List<Card> generate(PackGenerationContext context, Random random) {
    final pack = context.configuration.packType;
    final rulesBySlot = {
      for (final rule in context.configuration.slotRules) rule.slotIndex: rule,
    };
    final rarities = [...context.rarities]
      ..sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
    final rarityById = {for (final rarity in rarities) rarity.id: rarity};
    final cardsByRarity = <RarityId, List<Card>>{};
    final poolIds = context.configuration.pool
        .where((entry) => entry.isEnabled)
        .map((entry) => entry.cardId)
        .toSet();

    for (final card in context.eligibleCards) {
      if (card.collectionId != pack.collectionId ||
          card.contentVersionId != pack.contentVersionId ||
          !poolIds.contains(card.id)) {
        continue;
      }
      cardsByRarity.putIfAbsent(card.rarityId, () => []).add(card);
    }

    if (cardsByRarity.values.every((cards) => cards.isEmpty)) {
      throw const PackGenerationException('No hay cartas elegibles.');
    }

    final result = <Card>[];
    for (var index = 0; index < pack.cardCount; index++) {
      final rule = rulesBySlot[index];
      if (rule == null) {
        throw PackGenerationException('Falta regla para la posicion $index.');
      }

      final rarity = _selectRarity(
        rule: rule,
        probabilities: context.configuration.probabilities,
        rarities: rarities,
        rarityById: rarityById,
        cardsByRarity: cardsByRarity,
        random: random,
      );
      final cards = cardsByRarity[rarity.id] ?? const <Card>[];
      if (cards.isEmpty) {
        throw PackGenerationException(
          'La posicion $index no puede generar cartas.',
        );
      }
      result.add(cards[random.nextInt(cards.length)]);
    }

    return result;
  }

  Rarity _selectRarity({
    required PackSlotRule rule,
    required List<PackRarityProbability> probabilities,
    required List<Rarity> rarities,
    required Map<RarityId, Rarity> rarityById,
    required Map<RarityId, List<Card>> cardsByRarity,
    required Random random,
  }) {
    switch (rule.ruleType) {
      case PackSlotRuleType.fixedRarity:
        final rarity = rarityById[rule.fixedRarityId];
        if (rarity == null || (cardsByRarity[rarity.id]?.isEmpty ?? true)) {
          throw const PackGenerationException(
            'La rareza fija no tiene cartas elegibles.',
          );
        }
        return rarity;
      case PackSlotRuleType.probabilityDistribution:
        final rarity = _weightedRarity(
          groupId: rule.probabilityGroupId,
          probabilities: probabilities,
          rarities: rarities,
          random: random,
        );
        return _fallbackRarity(
          selected: rarity,
          rarities: rarities,
          cardsByRarity: cardsByRarity,
        );
      case PackSlotRuleType.minimumRarity:
        final minimum = rule.minimumRarityOrder;
        if (minimum == null) {
          throw const PackGenerationException('Falta rareza minima.');
        }
        final allowed = rarities
            .where((rarity) => rarity.orderIndex >= minimum)
            .toList();
        if (allowed.isEmpty) {
          throw const PackGenerationException('Rareza minima invalida.');
        }
        final rarity = _weightedRarity(
          groupId: rule.probabilityGroupId,
          probabilities: probabilities,
          rarities: allowed,
          random: random,
        );
        return _fallbackRarity(
          selected: rarity,
          rarities: allowed,
          cardsByRarity: cardsByRarity,
          allowLower: false,
        );
    }
  }

  Rarity _weightedRarity({
    required ProbabilityGroupId? groupId,
    required List<PackRarityProbability> probabilities,
    required List<Rarity> rarities,
    required Random random,
  }) {
    if (groupId == null) {
      throw const PackGenerationException('Falta grupo de probabilidad.');
    }
    final allowedIds = rarities.map((rarity) => rarity.id).toSet();
    final configuredWeights = probabilities
        .where(
          (probability) =>
              probability.probabilityGroupId == groupId &&
              allowedIds.contains(probability.rarityId),
        )
        .toList();
    final weights = configuredWeights.isEmpty
        ? {
            for (final rarity in rarities)
              if (rarity.probabilityWeight > 0)
                rarity.id: rarity.probabilityWeight,
          }
        : {
            for (final probability in configuredWeights)
              if (probability.weight > 0)
                probability.rarityId: probability.weight,
          };
    final total = weights.values.fold<int>(0, (sum, weight) => sum + weight);
    if (total <= 0) {
      throw const PackGenerationException('La distribucion no tiene pesos.');
    }

    var roll = random.nextInt(total);
    for (final entry in weights.entries) {
      if (roll < entry.value) {
        return rarities.firstWhere((rarity) => rarity.id == entry.key);
      }
      roll -= entry.value;
    }

    return rarities.firstWhere((rarity) => rarity.id == weights.keys.last);
  }

  Rarity _fallbackRarity({
    required Rarity selected,
    required List<Rarity> rarities,
    required Map<RarityId, List<Card>> cardsByRarity,
    bool allowLower = true,
  }) {
    if (cardsByRarity[selected.id]?.isNotEmpty ?? false) {
      return selected;
    }

    // Distribution fallback prefers the closest lower rarity with cards, then
    // the closest higher one. Minimum-rarity rules disable the lower side.
    final lower = allowLower
        ? rarities
              .where((rarity) => rarity.orderIndex < selected.orderIndex)
              .where((rarity) => cardsByRarity[rarity.id]?.isNotEmpty ?? false)
              .toList()
        : <Rarity>[];
    if (lower.isNotEmpty) {
      return lower.last;
    }

    final higher = rarities
        .where((rarity) => rarity.orderIndex > selected.orderIndex)
        .where((rarity) => cardsByRarity[rarity.id]?.isNotEmpty ?? false)
        .toList();
    if (higher.isNotEmpty) {
      return higher.first;
    }

    throw const PackGenerationException(
      'Ninguna rareza ponderada tiene cartas elegibles.',
    );
  }
}
