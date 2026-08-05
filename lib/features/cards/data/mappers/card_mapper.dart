import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/mappers/date_time_mapper.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../../domain/entities/card.dart' as domain;

extension CardRowMapper on CardRow {
  domain.Card toDomain() {
    return domain.Card(
      id: CardId(id),
      collectionId: CollectionId(collectionId),
      contentVersionId: ContentVersionId(contentVersionId),
      collectionNumber: collectionNumber,
      name: name,
      health: health,
      rarityId: RarityId(rarityId),
      mediaAssetId: MediaAssetId(mediaAssetId),
      mediaType: mediaType,
      thumbnailAssetId: thumbnailAssetId == null
          ? null
          : MediaAssetId(thumbnailAssetId!),
      templateId: templateId,
      frameId: frameId,
      primaryColor: primaryColor,
      secondaryColor: secondaryColor,
      description: description,
      sortIndex: sortIndex,
      createdAtUtc: fromDatabaseUtc(createdAtUtc),
    );
  }
}

extension CardDomainMapper on domain.Card {
  CardsCompanion toCompanion() {
    return CardsCompanion(
      id: Value(id.value),
      collectionId: Value(collectionId.value),
      contentVersionId: Value(contentVersionId.value),
      collectionNumber: Value(collectionNumber),
      name: Value(name),
      health: Value(health),
      rarityId: Value(rarityId.value),
      mediaAssetId: Value(mediaAssetId.value),
      mediaType: Value(mediaType),
      thumbnailAssetId: Value(thumbnailAssetId?.value),
      templateId: Value(templateId),
      frameId: Value(frameId),
      primaryColor: Value(primaryColor),
      secondaryColor: Value(secondaryColor),
      description: Value(description),
      sortIndex: Value(sortIndex),
      createdAtUtc: Value(toDatabaseUtc(createdAtUtc)),
    );
  }
}
