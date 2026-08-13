import '../catalogs/rarity_visual_catalog.dart';

enum RarityValidationIssue {
  emptyName,
  nameTooLong,
  duplicateName,
  negativeSellValue,
  sellValueTooHigh,
  negativeProbabilityWeight,
  probabilityWeightTooHigh,
  colorNotAllowed,
  iconNotAllowed,
  frameNotAllowed,
  effectNotAllowed,
}

final class RarityValidationResult {
  const RarityValidationResult(this.issues);

  final Set<RarityValidationIssue> issues;

  bool get canSave => issues.isEmpty;
}

abstract final class RarityValidation {
  static String normalizedName(String value) {
    return value.trim().toLowerCase();
  }

  static RarityValidationResult validate({
    required String name,
    required bool isDuplicateName,
    required int colorValue,
    required String iconId,
    required String frameId,
    required String effectId,
    required int sellValue,
    required int probabilityWeight,
  }) {
    final issues = <RarityValidationIssue>{};
    final normalized = normalizedName(name);

    if (normalized.isEmpty) {
      issues.add(RarityValidationIssue.emptyName);
    }
    if (name.length > RarityVisualCatalog.maxNameLength) {
      issues.add(RarityValidationIssue.nameTooLong);
    }
    if (isDuplicateName) {
      issues.add(RarityValidationIssue.duplicateName);
    }
    if (sellValue < 0) {
      issues.add(RarityValidationIssue.negativeSellValue);
    }
    if (sellValue > RarityVisualCatalog.maxSellValue) {
      issues.add(RarityValidationIssue.sellValueTooHigh);
    }
    if (probabilityWeight < 0) {
      issues.add(RarityValidationIssue.negativeProbabilityWeight);
    }
    if (probabilityWeight > 100) {
      issues.add(RarityValidationIssue.probabilityWeightTooHigh);
    }
    if (!RarityVisualCatalog.isColorValue(colorValue)) {
      issues.add(RarityValidationIssue.colorNotAllowed);
    }
    if (!RarityVisualCatalog.isIconId(iconId)) {
      issues.add(RarityValidationIssue.iconNotAllowed);
    }
    if (!RarityVisualCatalog.isFrameId(frameId)) {
      issues.add(RarityValidationIssue.frameNotAllowed);
    }
    if (!RarityVisualCatalog.isEffectId(effectId)) {
      issues.add(RarityValidationIssue.effectNotAllowed);
    }

    return RarityValidationResult(issues);
  }
}
