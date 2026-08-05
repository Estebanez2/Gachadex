import '../../../../core/domain/domain_validation.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../value_objects/card_field_type.dart';

final class CardFieldValue {
  CardFieldValue({
    required this.id,
    required this.cardId,
    required this.fieldType,
    required String value,
    required int displayOrder,
  }) : value = DomainValidation.requireTrimmedNotEmpty(value, 'value'),
       displayOrder = DomainValidation.requireNonNegative(
         displayOrder,
         'displayOrder',
       );

  final CardFieldValueId id;
  final CardId cardId;
  final CardFieldType fieldType;
  final String value;
  final int displayOrder;
}
