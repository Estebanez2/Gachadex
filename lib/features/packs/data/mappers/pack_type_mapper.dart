import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../../domain/entities/pack_type.dart';
import '../../domain/value_objects/pack_visual_style.dart';

extension PackTypeRowMapper on PackTypeRow {
  PackType toDomain() {
    return PackType(
      id: PackTypeId(id),
      collectionId: CollectionId(collectionId),
      contentVersionId: ContentVersionId(contentVersionId),
      name: name,
      description: description,
      frontAssetId: frontAssetId == null ? null : MediaAssetId(frontAssetId!),
      backAssetId: backAssetId == null ? null : MediaAssetId(backAssetId!),
      frontStyle: PackVisualStyle(
        colorId: frontColorId,
        accentColorId: frontAccentColorId,
        iconId: frontIconId,
        patternId: frontPatternId,
      ),
      backStyle: PackVisualStyle(
        colorId: backColorId,
        accentColorId: backAccentColorId,
        iconId: backIconId,
        patternId: backPatternId,
      ),
      cardCount: cardCount,
      rechargeSeconds: rechargeSeconds,
      maxAccumulated: maxAccumulated,
      isMain: isMain,
      coinsPerFullRecharge: coinsPerFullRecharge,
      sortIndex: sortIndex,
    );
  }
}

extension PackTypeDomainMapper on PackType {
  PackTypesCompanion toCompanion() {
    return PackTypesCompanion(
      id: Value(id.value),
      collectionId: Value(collectionId.value),
      contentVersionId: Value(contentVersionId.value),
      name: Value(name),
      description: Value(description),
      frontAssetId: Value(frontAssetId?.value),
      backAssetId: Value(backAssetId?.value),
      frontColorId: Value(frontStyle.colorId),
      frontAccentColorId: Value(frontStyle.accentColorId),
      frontIconId: Value(frontStyle.iconId),
      frontPatternId: Value(frontStyle.patternId),
      backColorId: Value(backStyle.colorId),
      backAccentColorId: Value(backStyle.accentColorId),
      backIconId: Value(backStyle.iconId),
      backPatternId: Value(backStyle.patternId),
      cardCount: Value(cardCount),
      rechargeSeconds: Value(rechargeSeconds),
      maxAccumulated: Value(maxAccumulated),
      isMain: Value(isMain),
      coinsPerFullRecharge: Value(coinsPerFullRecharge),
      sortIndex: Value(sortIndex),
    );
  }
}
