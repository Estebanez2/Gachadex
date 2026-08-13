import 'dart:math';

import '../../../core/domain/domain_enums.dart';
import '../../../core/identifiers/entity_id.dart';
import '../../../core/identifiers/uuid_generator.dart';
import '../../cards/domain/entities/card.dart';
import '../../rarities/domain/entities/rarity.dart';
import '../domain/catalogs/pack_visual_catalog.dart';
import '../domain/entities/pack_card_pool_entry.dart';
import '../domain/entities/pack_configuration.dart';
import '../domain/entities/pack_rarity_probability.dart';
import '../domain/entities/pack_slot_rule.dart';
import '../domain/entities/pack_type.dart';
import '../domain/repositories/pack_type_repository.dart';
import '../domain/services/pack_generator.dart';
import '../domain/validation/pack_validation.dart';
import '../domain/value_objects/pack_visual_style.dart';

final class PackSlotRuleInput {
  const PackSlotRuleInput({
    required this.ruleType,
    this.fixedRarityId,
    this.minimumRarityOrder,
    required this.weights,
  });

  final PackSlotRuleType ruleType;
  final RarityId? fixedRarityId;
  final int? minimumRarityOrder;
  final Map<RarityId, int> weights;
}

final class PackInput {
  const PackInput({
    required this.name,
    required this.description,
    required this.frontStyle,
    required this.backStyle,
    required this.cardCount,
    required this.rechargeSeconds,
    required this.maxAccumulated,
    required this.isMain,
    required this.coinsPerFullRecharge,
    required this.enabledCardIds,
    required this.slotRules,
  });

  factory PackInput.defaults(List<Rarity> rarities, List<Card> cards) {
    return PackInput(
      name: '',
      description: '',
      frontStyle: PackVisualCatalog.defaultFrontStyle,
      backStyle: PackVisualCatalog.defaultBackStyle,
      cardCount: 5,
      rechargeSeconds: const Duration(hours: 12).inSeconds,
      maxAccumulated: 3,
      isMain: true,
      coinsPerFullRecharge: 0,
      enabledCardIds: cards.map((card) => card.id).toSet(),
      slotRules: List.generate(
        5,
        (_) => PackSlotRuleInput(
          ruleType: PackSlotRuleType.probabilityDistribution,
          weights: const {},
        ),
      ),
    );
  }

  final String name;
  final String description;
  final PackVisualStyle frontStyle;
  final PackVisualStyle backStyle;
  final int cardCount;
  final int rechargeSeconds;
  final int maxAccumulated;
  final bool isMain;
  final int coinsPerFullRecharge;
  final Set<CardId> enabledCardIds;
  final List<PackSlotRuleInput> slotRules;

  PackInput copyWith({
    String? name,
    String? description,
    PackVisualStyle? frontStyle,
    PackVisualStyle? backStyle,
    int? cardCount,
    int? rechargeSeconds,
    int? maxAccumulated,
    bool? isMain,
    int? coinsPerFullRecharge,
    Set<CardId>? enabledCardIds,
    List<PackSlotRuleInput>? slotRules,
  }) {
    return PackInput(
      name: name ?? this.name,
      description: description ?? this.description,
      frontStyle: frontStyle ?? this.frontStyle,
      backStyle: backStyle ?? this.backStyle,
      cardCount: cardCount ?? this.cardCount,
      rechargeSeconds: rechargeSeconds ?? this.rechargeSeconds,
      maxAccumulated: maxAccumulated ?? this.maxAccumulated,
      isMain: isMain ?? this.isMain,
      coinsPerFullRecharge: coinsPerFullRecharge ?? this.coinsPerFullRecharge,
      enabledCardIds: enabledCardIds ?? this.enabledCardIds,
      slotRules: slotRules ?? this.slotRules,
    );
  }
}

final class PackEditorUseCases {
  const PackEditorUseCases({
    required this.repository,
    required this.uuidGenerator,
  });

  final PackTypeRepository repository;
  final UuidGenerator uuidGenerator;

  Future<PackConfiguration> create({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
    required int sortIndex,
    required PackInput input,
  }) {
    final packTypeId = uuidGenerator.packTypeId();
    return repository.createConfiguration(
      _configurationFromInput(
        collectionId: collectionId,
        contentVersionId: contentVersionId,
        packTypeId: packTypeId,
        sortIndex: sortIndex,
        input: input,
      ),
    );
  }

  Future<PackConfiguration> update({
    required PackTypeId packTypeId,
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
    required int sortIndex,
    required PackInput input,
  }) {
    return repository.updateConfiguration(
      _configurationFromInput(
        collectionId: collectionId,
        contentVersionId: contentVersionId,
        packTypeId: packTypeId,
        sortIndex: sortIndex,
        input: input,
      ),
    );
  }

  Future<void> delete(PackTypeId packTypeId) {
    return repository.delete(packTypeId);
  }

  Future<void> setMain(PackTypeId packTypeId) {
    return repository.setMain(packTypeId);
  }

  Future<void> reorder({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
    required List<PackTypeId> orderedIds,
  }) {
    return repository.reorder(
      collectionId: collectionId,
      contentVersionId: contentVersionId,
      orderedIds: orderedIds,
    );
  }

  List<Card> simulate({
    required PackConfiguration configuration,
    required List<Card> cards,
    required List<Rarity> rarities,
    required Random random,
  }) {
    return const PackGenerator().generate(
      PackGenerationContext(
        configuration: configuration,
        eligibleCards: cards,
        rarities: rarities,
      ),
      random,
    );
  }

  PackValidationResult validate({
    required PackConfiguration configuration,
    required List<Card> cards,
    required List<Rarity> rarities,
    required bool hasDuplicateName,
  }) {
    return PackValidation.validateConfiguration(
      configuration: configuration,
      cards: cards,
      rarities: rarities,
      hasDuplicateName: hasDuplicateName,
    );
  }

  PackConfiguration _configurationFromInput({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
    required PackTypeId packTypeId,
    required int sortIndex,
    required PackInput input,
  }) {
    final pack = PackType(
      id: packTypeId,
      collectionId: collectionId,
      contentVersionId: contentVersionId,
      name: input.name,
      description: input.description,
      frontAssetId: null,
      backAssetId: null,
      frontStyle: input.frontStyle,
      backStyle: input.backStyle,
      cardCount: input.cardCount,
      rechargeSeconds: input.rechargeSeconds,
      maxAccumulated: input.maxAccumulated,
      isMain: input.isMain,
      coinsPerFullRecharge: input.coinsPerFullRecharge,
      sortIndex: sortIndex,
    );
    final pool = input.enabledCardIds
        .map(
          (cardId) => PackCardPoolEntry(
            packTypeId: packTypeId,
            cardId: cardId,
            isEnabled: true,
          ),
        )
        .toList();
    final rules = <PackSlotRule>[];
    final probabilities = <PackRarityProbability>[];
    for (var index = 0; index < input.cardCount; index++) {
      final slotInput = input.slotRules[index];
      final groupId = slotInput.ruleType == PackSlotRuleType.fixedRarity
          ? null
          : uuidGenerator.probabilityGroupId();
      if (groupId != null) {
        for (final entry in slotInput.weights.entries) {
          if (entry.value > 0) {
            probabilities.add(
              PackRarityProbability(
                probabilityGroupId: groupId,
                rarityId: entry.key,
                weight: entry.value,
              ),
            );
          }
        }
      }
      rules.add(
        PackSlotRule(
          id: uuidGenerator.packSlotRuleId(),
          packTypeId: packTypeId,
          slotIndex: index,
          ruleType: slotInput.ruleType,
          fixedRarityId: slotInput.ruleType == PackSlotRuleType.fixedRarity
              ? slotInput.fixedRarityId
              : null,
          minimumRarityOrder:
              slotInput.ruleType == PackSlotRuleType.minimumRarity
              ? slotInput.minimumRarityOrder
              : null,
          probabilityGroupId: groupId,
        ),
      );
    }

    return PackConfiguration(
      packType: pack,
      pool: pool,
      slotRules: rules,
      probabilities: probabilities,
    );
  }
}
