import '../../../../core/domain/domain_validation.dart';
import '../../../../core/identifiers/entity_id.dart';

final class PackOpeningCard {
  PackOpeningCard({
    required this.openingId,
    required this.cardId,
    required int slotIndex,
    required this.wasNew,
    required int quantityAfter,
    required this.revealed,
  }) : slotIndex = DomainValidation.requireNonNegative(slotIndex, 'slotIndex'),
       quantityAfter = DomainValidation.requirePositive(
         quantityAfter,
         'quantityAfter',
       );

  final PackOpeningId openingId;
  final CardId cardId;
  final int slotIndex;
  final bool wasNew;
  final int quantityAfter;
  final bool revealed;
}
