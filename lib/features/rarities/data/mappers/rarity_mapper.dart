import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../../domain/entities/rarity.dart';

extension RarityRowMapper on RarityRow {
  Rarity toDomain() {
    return Rarity(
      id: RarityId(id),
      collectionId: CollectionId(collectionId),
      contentVersionId: ContentVersionId(contentVersionId),
      name: name,
      orderIndex: orderIndex,
      colorValue: colorValue,
      iconId: iconId,
      frameId: frameId,
      effectId: effectId,
      sellValue: sellValue,
      probabilityWeight: probabilityWeight,
      isEnabled: isEnabled,
    );
  }
}

extension RarityDomainMapper on Rarity {
  RaritiesCompanion toCompanion() {
    return RaritiesCompanion(
      id: Value(id.value),
      collectionId: Value(collectionId.value),
      contentVersionId: Value(contentVersionId.value),
      name: Value(name),
      orderIndex: Value(orderIndex),
      colorValue: Value(colorValue),
      iconId: Value(iconId),
      frameId: Value(frameId),
      effectId: Value(effectId),
      sellValue: Value(sellValue),
      probabilityWeight: Value(probabilityWeight),
      isEnabled: Value(isEnabled),
    );
  }
}
