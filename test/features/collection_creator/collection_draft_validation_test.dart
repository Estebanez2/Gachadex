import 'package:flutter_test/flutter_test.dart';
import 'package:gachadex/features/collection_creator/domain/catalogs/draft_cover_catalog.dart';
import 'package:gachadex/features/collection_creator/domain/validation/collection_draft_validation.dart';
import 'package:gachadex/features/collection_creator/domain/value_objects/draft_cover_style.dart';
import 'package:gachadex/features/rarities/domain/catalogs/rarity_visual_catalog.dart';
import 'package:gachadex/features/rarities/domain/validation/rarity_validation.dart';

void main() {
  group('Collection draft validation', () {
    test('allows incomplete names to be saved but not completed', () {
      final errors = CollectionDraftValidation.validateInfo(
        name: '   ',
        author: '',
        description: '',
      );
      final completeness = CollectionDraftValidation.completeness(
        name: '   ',
        coverStyle: DraftCoverStyle.defaultStyle(),
        rarityCount: 0,
        cardCount: 0,
        packCount: 0,
        infoErrors: errors,
      );

      expect(errors.canSave, isTrue);
      expect(completeness.info, DraftSectionCompletion.notStarted);
      expect(completeness.rarities, DraftSectionCompletion.notStarted);
      expect(completeness.completeForThisPhase, isFalse);
    });

    test('rejects fields longer than the phase limits', () {
      final errors = CollectionDraftValidation.validateInfo(
        name: List.filled(61, 'a').join(),
        author: List.filled(61, 'b').join(),
        description: List.filled(501, 'c').join(),
      );

      expect(errors.nameTooLong, isTrue);
      expect(errors.authorTooLong, isTrue);
      expect(errors.descriptionTooLong, isTrue);
      expect(errors.canSave, isFalse);
    });

    test(
      'marks information, rarities, cards and packs complete for this phase',
      () {
        final errors = CollectionDraftValidation.validateInfo(
          name: 'Viaje',
          author: 'Grupo',
          description: 'Momentos del viaje',
        );
        final completeness = CollectionDraftValidation.completeness(
          name: 'Viaje',
          coverStyle: DraftCoverStyle.defaultStyle(),
          rarityCount: 1,
          cardCount: 1,
          packCount: 1,
          infoErrors: errors,
        );

        expect(completeness.infoComplete, isTrue);
        expect(completeness.raritiesComplete, isTrue);
        expect(completeness.cardsComplete, isTrue);
        expect(completeness.packsComplete, isTrue);
        expect(completeness.completeForThisPhase, isTrue);
        expect(completeness.hasFuturePendingWork, isTrue);
      },
    );

    test('validates draft cover identifiers against the catalog', () {
      final style = DraftCoverStyle(
        backgroundColorId: DraftCoverCatalog.defaultBackgroundColorId,
        accentColorId: DraftCoverCatalog.defaultAccentColorId,
        iconId: DraftCoverCatalog.defaultIconId,
        patternId: DraftCoverCatalog.defaultPatternId,
      );

      expect(style, DraftCoverStyle.defaultStyle());
      expect(
        () => DraftCoverStyle(
          backgroundColorId: 'missing',
          accentColorId: DraftCoverCatalog.defaultAccentColorId,
          iconId: DraftCoverCatalog.defaultIconId,
          patternId: DraftCoverCatalog.defaultPatternId,
        ),
        throwsArgumentError,
      );
    });
  });

  group('Rarity validation', () {
    test('validates required name, duplicates and visual catalog ids', () {
      final validation = RarityValidation.validate(
        name: '  ',
        isDuplicateName: true,
        colorValue: 0xFFFFFFFF,
        iconId: 'missing_icon',
        frameId: 'missing_frame',
        effectId: 'missing_effect',
        sellValue: -1,
      );

      expect(
        validation.issues,
        containsAll([
          RarityValidationIssue.emptyName,
          RarityValidationIssue.duplicateName,
          RarityValidationIssue.negativeSellValue,
          RarityValidationIssue.colorNotAllowed,
          RarityValidationIssue.iconNotAllowed,
          RarityValidationIssue.frameNotAllowed,
          RarityValidationIssue.effectNotAllowed,
        ]),
      );
      expect(validation.canSave, isFalse);
    });

    test('normalizes duplicate names ignoring case and surrounding spaces', () {
      expect(
        RarityValidation.normalizedName(' Legendaria '),
        RarityValidation.normalizedName('legendaria'),
      );
    });

    test('accepts maximum sell value and rejects values above it', () {
      final accepted = RarityValidation.validate(
        name: 'Legendaria',
        isDuplicateName: false,
        colorValue: RarityVisualCatalog.defaultColorValue,
        iconId: RarityVisualCatalog.defaultIconId,
        frameId: RarityVisualCatalog.defaultFrameId,
        effectId: RarityVisualCatalog.defaultEffectId,
        sellValue: RarityVisualCatalog.maxSellValue,
      );
      final rejected = RarityValidation.validate(
        name: 'Legendaria',
        isDuplicateName: false,
        colorValue: RarityVisualCatalog.defaultColorValue,
        iconId: RarityVisualCatalog.defaultIconId,
        frameId: RarityVisualCatalog.defaultFrameId,
        effectId: RarityVisualCatalog.defaultEffectId,
        sellValue: RarityVisualCatalog.maxSellValue + 1,
      );

      expect(accepted.canSave, isTrue);
      expect(rejected.issues, contains(RarityValidationIssue.sellValueTooHigh));
    });
  });
}
