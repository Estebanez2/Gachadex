import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:gachadex/core/domain/domain_enums.dart';
import 'package:gachadex/core/identifiers/entity_id.dart';
import 'package:gachadex/features/cards/domain/entities/card.dart';
import 'package:gachadex/features/packs/domain/entities/pack_card_pool_entry.dart';
import 'package:gachadex/features/packs/domain/entities/pack_configuration.dart';
import 'package:gachadex/features/packs/domain/entities/pack_rarity_probability.dart';
import 'package:gachadex/features/packs/domain/entities/pack_slot_rule.dart';
import 'package:gachadex/features/packs/domain/entities/pack_type.dart';
import 'package:gachadex/features/packs/domain/services/pack_generator.dart';
import 'package:gachadex/features/packs/domain/services/pack_recharge_calculator.dart';
import 'package:gachadex/features/packs/domain/validation/pack_validation.dart';
import 'package:gachadex/features/rarities/domain/entities/rarity.dart';

void main() {
  group('PackGenerator', () {
    test('fixed rarity returns the exact rarity', () {
      final fixture = _Fixture();
      final result = const PackGenerator().generate(
        fixture.context(
          rules: [fixture.fixedRule(slotIndex: 0, rarityId: fixture.common.id)],
        ),
        _SequenceRandom([0]),
      );

      expect(result.single.rarityId, fixture.common.id);
    });

    test('distribution uses injected random and allows repeated cards', () {
      final fixture = _Fixture(cardCount: 2);
      final groupId = ProbabilityGroupId(_uuid(90));
      final context = fixture.context(
        rules: [
          fixture.distributionRule(slotIndex: 0, groupId: groupId),
          fixture.distributionRule(slotIndex: 1, groupId: groupId),
        ],
        probabilities: [
          PackRarityProbability(
            probabilityGroupId: groupId,
            rarityId: fixture.common.id,
            weight: 1,
          ),
          PackRarityProbability(
            probabilityGroupId: groupId,
            rarityId: fixture.rare.id,
            weight: 1,
          ),
        ],
      );

      final result = const PackGenerator().generate(
        context,
        _SequenceRandom([1, 0, 1, 0]),
      );

      expect(result.map((card) => card.id), [
        fixture.rareCard.id,
        fixture.rareCard.id,
      ]);
    });

    test('minimum rarity never returns lower rarities', () {
      final fixture = _Fixture();
      final groupId = ProbabilityGroupId(_uuid(91));

      final result = const PackGenerator().generate(
        fixture.context(
          rules: [
            fixture.minimumRule(
              slotIndex: 0,
              minimumOrder: fixture.rare.orderIndex,
              groupId: groupId,
            ),
          ],
          probabilities: [
            PackRarityProbability(
              probabilityGroupId: groupId,
              rarityId: fixture.common.id,
              weight: 100,
            ),
            PackRarityProbability(
              probabilityGroupId: groupId,
              rarityId: fixture.rare.id,
              weight: 1,
            ),
          ],
        ),
        _SequenceRandom([0, 0]),
      );

      expect(result.single.rarityId, fixture.rare.id);
    });

    test('distribution falls back to lower then higher rarity with cards', () {
      final fixture = _Fixture();
      final groupId = ProbabilityGroupId(_uuid(92));
      final noRareCardContext = fixture.context(
        cards: [fixture.commonCard],
        rules: [fixture.distributionRule(slotIndex: 0, groupId: groupId)],
        probabilities: [
          PackRarityProbability(
            probabilityGroupId: groupId,
            rarityId: fixture.rare.id,
            weight: 1,
          ),
        ],
      );

      final lower = const PackGenerator().generate(
        noRareCardContext,
        _SequenceRandom([0, 0]),
      );

      final higher = const PackGenerator().generate(
        fixture.context(
          cards: [fixture.rareCard],
          rules: [fixture.distributionRule(slotIndex: 0, groupId: groupId)],
          probabilities: [
            PackRarityProbability(
              probabilityGroupId: groupId,
              rarityId: fixture.common.id,
              weight: 1,
            ),
          ],
        ),
        _SequenceRandom([0, 0]),
      );

      expect(lower.single.rarityId, fixture.common.id);
      expect(higher.single.rarityId, fixture.rare.id);
    });

    test('uses base rarity probabilities when slot has no custom weights', () {
      final fixture = _Fixture();
      final groupId = ProbabilityGroupId(_uuid(96));
      final result = const PackGenerator().generate(
        fixture.context(
          rules: [fixture.distributionRule(slotIndex: 0, groupId: groupId)],
        ),
        _SequenceRandom([70, 0]),
      );

      expect(result.single.rarityId, fixture.rare.id);
    });

    test('does not select zero percent rarities from base probabilities', () {
      final fixture = _Fixture(commonProbability: 100, rareProbability: 0);
      final groupId = ProbabilityGroupId(_uuid(97));
      final result = const PackGenerator().generate(
        fixture.context(
          rules: [fixture.distributionRule(slotIndex: 0, groupId: groupId)],
        ),
        _SequenceRandom([99, 0]),
      );

      expect(result.single.rarityId, fixture.common.id);
    });

    test('fixed rarity still ignores base probability', () {
      final fixture = _Fixture(commonProbability: 100, rareProbability: 0);
      final result = const PackGenerator().generate(
        fixture.context(
          rules: [fixture.fixedRule(slotIndex: 0, rarityId: fixture.rare.id)],
        ),
        _SequenceRandom([0]),
      );

      expect(result.single.rarityId, fixture.rare.id);
    });

    test('errors without cards and never returns cards outside the pool', () {
      final fixture = _Fixture();
      final groupId = ProbabilityGroupId(_uuid(93));

      expect(
        () => const PackGenerator().generate(
          fixture.context(
            poolIds: {},
            rules: [fixture.distributionRule(slotIndex: 0, groupId: groupId)],
            probabilities: [
              PackRarityProbability(
                probabilityGroupId: groupId,
                rarityId: fixture.common.id,
                weight: 1,
              ),
            ],
          ),
          _SequenceRandom([0]),
        ),
        throwsA(isA<PackGenerationException>()),
      );

      final result = const PackGenerator().generate(
        fixture.context(
          poolIds: {fixture.commonCard.id},
          cards: [fixture.commonCard, fixture.rareCard],
          rules: [fixture.distributionRule(slotIndex: 0, groupId: groupId)],
          probabilities: [
            PackRarityProbability(
              probabilityGroupId: groupId,
              rarityId: fixture.rare.id,
              weight: 1,
            ),
          ],
        ),
        _SequenceRandom([0, 0]),
      );

      expect(result.single.id, fixture.commonCard.id);
    });
  });

  group('PackValidation', () {
    test('rejects main max below three, empty pool and empty weights', () {
      final fixture = _Fixture(commonProbability: 0, rareProbability: 0);
      final groupId = ProbabilityGroupId(_uuid(94));
      final context = fixture.context(
        poolIds: {},
        rules: [fixture.distributionRule(slotIndex: 0, groupId: groupId)],
      );
      final invalidMain = PackConfiguration(
        packType: PackType(
          id: context.configuration.packType.id,
          collectionId: context.configuration.packType.collectionId,
          contentVersionId: context.configuration.packType.contentVersionId,
          name: context.configuration.packType.name,
          description: null,
          frontAssetId: null,
          backAssetId: null,
          cardCount: 1,
          rechargeSeconds: 3600,
          maxAccumulated: 2,
          isMain: true,
          coinsPerFullRecharge: 0,
          sortIndex: 0,
        ),
        pool: context.configuration.pool,
        slotRules: context.configuration.slotRules,
        probabilities: const [],
      );

      final validation = PackValidation.validateConfiguration(
        configuration: invalidMain,
        cards: [fixture.commonCard],
        rarities: [fixture.common, fixture.rare],
      );

      expect(
        validation.issues,
        containsAll([
          PackValidationIssue.mainPackNeedsThree,
          PackValidationIssue.noEligibleCards,
          PackValidationIssue.missingProbabilityWeight,
        ]),
      );
      expect(validation.canSave, isFalse);
    });
  });

  group('PackRechargeCalculator', () {
    test('accumulates due packs without exceeding the maximum', () {
      final result = const PackRechargeCalculator().calculate(
        availableCount: 1,
        maxAccumulated: 3,
        rechargeSeconds: 3600,
        nextRechargeAtUtc: DateTime.utc(2026, 8, 5, 10),
        currentTimeUtc: DateTime.utc(2026, 8, 5, 13, 30),
      );

      expect(result.availableCount, 3);
      expect(result.generatedCount, 2);
      expect(result.reachedMaximum, isTrue);
      expect(result.nextRechargeAtUtc, DateTime.utc(2026, 8, 5, 12));
    });

    test('keeps independent countdown when no recharge is due', () {
      final result = const PackRechargeCalculator().calculate(
        availableCount: 0,
        maxAccumulated: 3,
        rechargeSeconds: 3600,
        nextRechargeAtUtc: DateTime.utc(2026, 8, 5, 14),
        currentTimeUtc: DateTime.utc(2026, 8, 5, 13, 30),
      );

      expect(result.availableCount, 0);
      expect(result.generatedCount, 0);
      expect(result.nextRechargeAtUtc, DateTime.utc(2026, 8, 5, 14));
    });

    test('preserves overstock and resumes timer only below maximum', () {
      final calculator = const PackRechargeCalculator();
      final result = calculator.calculate(
        availableCount: 5,
        maxAccumulated: 3,
        rechargeSeconds: 3600,
        nextRechargeAtUtc: DateTime.utc(2026, 8, 5, 10),
        currentTimeUtc: DateTime.utc(2026, 8, 5, 13),
      );
      final stillPaused = calculator.nextAfterConsumed(
        previousAvailableCount: 5,
        newAvailableCount: 4,
        maxAccumulated: 3,
        rechargeSeconds: 3600,
        currentNextRechargeAtUtc: DateTime.utc(2026, 8, 5, 10),
        currentTimeUtc: DateTime.utc(2026, 8, 5, 13),
      );
      final resumed = calculator.nextAfterConsumed(
        previousAvailableCount: 3,
        newAvailableCount: 2,
        maxAccumulated: 3,
        rechargeSeconds: 3600,
        currentNextRechargeAtUtc: DateTime.utc(2026, 8, 5, 10),
        currentTimeUtc: DateTime.utc(2026, 8, 5, 13),
      );

      expect(result.availableCount, 5);
      expect(result.generatedCount, 0);
      expect(result.reachedMaximum, isTrue);
      expect(stillPaused, DateTime.utc(2026, 8, 5, 10));
      expect(resumed, DateTime.utc(2026, 8, 5, 14));
    });
  });
}

final class _Fixture {
  _Fixture({
    this.cardCount = 1,
    this.commonProbability = 60,
    this.rareProbability = 40,
  });

  final int cardCount;
  final int commonProbability;
  final int rareProbability;
  final collectionId = CollectionId(_uuid(1));
  final versionId = ContentVersionId(_uuid(2));
  late final common = _rarity(
    RarityId(_uuid(10)),
    'Normal',
    0,
    commonProbability,
  );
  late final rare = _rarity(RarityId(_uuid(11)), 'Rara', 1, rareProbability);
  late final commonCard = _card(CardId(_uuid(20)), common.id, 1);
  late final rareCard = _card(CardId(_uuid(21)), rare.id, 2);

  PackGenerationContext context({
    List<Card>? cards,
    Set<CardId>? poolIds,
    required List<PackSlotRule> rules,
    List<PackRarityProbability> probabilities = const [],
  }) {
    final allCards = cards ?? [commonCard, rareCard];
    final enabledIds = poolIds ?? allCards.map((card) => card.id).toSet();
    final packType = PackType(
      id: PackTypeId(_uuid(30)),
      collectionId: collectionId,
      contentVersionId: versionId,
      name: 'Sobre',
      description: null,
      frontAssetId: null,
      backAssetId: null,
      cardCount: cardCount,
      rechargeSeconds: 3600,
      maxAccumulated: 3,
      isMain: true,
      coinsPerFullRecharge: 0,
      sortIndex: 0,
    );
    return PackGenerationContext(
      configuration: PackConfiguration(
        packType: packType,
        pool: [
          for (final id in enabledIds)
            PackCardPoolEntry(
              packTypeId: packType.id,
              cardId: id,
              isEnabled: true,
            ),
        ],
        slotRules: rules,
        probabilities: probabilities,
      ),
      eligibleCards: allCards,
      rarities: [common, rare],
    );
  }

  PackSlotRule fixedRule({required int slotIndex, required RarityId rarityId}) {
    return PackSlotRule(
      id: PackSlotRuleId(_uuid(40 + slotIndex)),
      packTypeId: PackTypeId(_uuid(30)),
      slotIndex: slotIndex,
      ruleType: PackSlotRuleType.fixedRarity,
      fixedRarityId: rarityId,
      minimumRarityOrder: null,
      probabilityGroupId: null,
    );
  }

  PackSlotRule distributionRule({
    required int slotIndex,
    required ProbabilityGroupId groupId,
  }) {
    return PackSlotRule(
      id: PackSlotRuleId(_uuid(50 + slotIndex)),
      packTypeId: PackTypeId(_uuid(30)),
      slotIndex: slotIndex,
      ruleType: PackSlotRuleType.probabilityDistribution,
      fixedRarityId: null,
      minimumRarityOrder: null,
      probabilityGroupId: groupId,
    );
  }

  PackSlotRule minimumRule({
    required int slotIndex,
    required int minimumOrder,
    required ProbabilityGroupId groupId,
  }) {
    return PackSlotRule(
      id: PackSlotRuleId(_uuid(60 + slotIndex)),
      packTypeId: PackTypeId(_uuid(30)),
      slotIndex: slotIndex,
      ruleType: PackSlotRuleType.minimumRarity,
      fixedRarityId: null,
      minimumRarityOrder: minimumOrder,
      probabilityGroupId: groupId,
    );
  }

  Rarity _rarity(
    RarityId id,
    String name,
    int orderIndex,
    int probabilityWeight,
  ) {
    return Rarity(
      id: id,
      collectionId: collectionId,
      contentVersionId: versionId,
      name: name,
      orderIndex: orderIndex,
      colorValue: 0xFF3366CC,
      iconId: 'spark',
      frameId: 'clean',
      effectId: null,
      sellValue: 10,
      probabilityWeight: probabilityWeight,
      isEnabled: true,
    );
  }

  Card _card(CardId id, RarityId rarityId, int number) {
    return Card(
      id: id,
      collectionId: collectionId,
      contentVersionId: versionId,
      collectionNumber: number,
      name: 'Carta $number',
      health: 100,
      rarityId: rarityId,
      mediaAssetId: MediaAssetId(_uuid(70 + number)),
      mediaType: MediaType.image,
      thumbnailAssetId: null,
      templateId: 'basic',
      frameId: 'clean',
      primaryColor: 0xFF3366CC,
      secondaryColor: 0xFFFFCC33,
      description: null,
      sortIndex: number,
      createdAtUtc: DateTime.utc(2026),
    );
  }
}

final class _SequenceRandom implements Random {
  _SequenceRandom(this.values);

  final List<int> values;
  int _index = 0;

  @override
  bool nextBool() => nextInt(2) == 0;

  @override
  double nextDouble() => nextInt(1000000) / 1000000;

  @override
  int nextInt(int max) {
    final value = values[_index % values.length] % max;
    _index++;
    return value;
  }
}

String _uuid(int value) {
  return '00000000-0000-4000-8000-${value.toString().padLeft(12, '0')}';
}
