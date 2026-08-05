import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../../domain/entities/pack_type.dart';

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
      cardCount: Value(cardCount),
      rechargeSeconds: Value(rechargeSeconds),
      maxAccumulated: Value(maxAccumulated),
      isMain: Value(isMain),
      coinsPerFullRecharge: Value(coinsPerFullRecharge),
      sortIndex: Value(sortIndex),
    );
  }
}
