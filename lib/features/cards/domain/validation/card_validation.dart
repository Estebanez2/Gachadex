import '../catalogs/card_template_catalog.dart';
import '../value_objects/card_field_type.dart';

enum CardValidationIssue {
  photoRequired,
  emptyName,
  nameTooLong,
  invalidHealth,
  invalidCollectionNumber,
  duplicateCollectionNumber,
  rarityRequired,
  invalidTemplate,
  invalidFrame,
  descriptionTooLong,
  tooManyComicFields,
  comicFieldTooLong,
  duplicateComicField,
}

final class CardValidationResult {
  const CardValidationResult(this.issues);

  final Set<CardValidationIssue> issues;

  bool get canSave => issues.isEmpty;

  bool has(CardValidationIssue issue) => issues.contains(issue);
}

final class ComicFieldInput {
  const ComicFieldInput({required this.type, required this.value});

  final CardFieldType type;
  final String value;
}

abstract final class CardValidation {
  static CardValidationResult validate({
    required bool hasPhoto,
    required String name,
    required int? health,
    required int? collectionNumber,
    required bool isDuplicateCollectionNumber,
    required String? rarityId,
    required String templateId,
    required String frameId,
    required String description,
    required List<ComicFieldInput> comicFields,
  }) {
    final issues = <CardValidationIssue>{};
    final template = CardTemplateCatalog.templateById(templateId);

    if (!hasPhoto) {
      issues.add(CardValidationIssue.photoRequired);
    }
    if (name.trim().isEmpty) {
      issues.add(CardValidationIssue.emptyName);
    }
    if (name.trim().length > CardTemplateCatalog.maxNameLength) {
      issues.add(CardValidationIssue.nameTooLong);
    }
    if (health == null || health < 1 || health > 9999) {
      issues.add(CardValidationIssue.invalidHealth);
    }
    if (collectionNumber == null || collectionNumber < 1) {
      issues.add(CardValidationIssue.invalidCollectionNumber);
    }
    if (isDuplicateCollectionNumber) {
      issues.add(CardValidationIssue.duplicateCollectionNumber);
    }
    if (rarityId == null || rarityId.trim().isEmpty) {
      issues.add(CardValidationIssue.rarityRequired);
    }
    if (!CardTemplateCatalog.containsTemplate(templateId)) {
      issues.add(CardValidationIssue.invalidTemplate);
    }
    if (!CardTemplateCatalog.containsFrame(frameId)) {
      issues.add(CardValidationIssue.invalidFrame);
    }
    if (description.trim().length > CardTemplateCatalog.maxDescriptionLength) {
      issues.add(CardValidationIssue.descriptionTooLong);
    }
    if (comicFields.length > template.maxComicFields) {
      issues.add(CardValidationIssue.tooManyComicFields);
    }

    final seenFields = <CardFieldType>{};
    for (final field in comicFields) {
      if (!seenFields.add(field.type)) {
        issues.add(CardValidationIssue.duplicateComicField);
      }
      if (field.value.trim().length > template.maxComicFieldLength) {
        issues.add(CardValidationIssue.comicFieldTooLong);
      }
    }

    return CardValidationResult(issues);
  }
}
