import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../../domain/entities/card_field_value.dart';
import '../../domain/value_objects/card_field_type.dart';

extension CardFieldValueRowMapper on CardFieldValueRow {
  CardFieldValue toDomain() {
    return CardFieldValue(
      id: CardFieldValueId(id),
      cardId: CardId(cardId),
      fieldType: CardFieldType.parse(fieldTypeId),
      value: value,
      displayOrder: displayOrder,
    );
  }
}

extension CardFieldValueDomainMapper on CardFieldValue {
  CardFieldValuesCompanion toCompanion() {
    return CardFieldValuesCompanion(
      id: Value(id.value),
      cardId: Value(cardId.value),
      fieldTypeId: Value(fieldType.id),
      value: Value(value),
      displayOrder: Value(displayOrder),
    );
  }
}
