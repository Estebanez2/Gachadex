import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/mappers/date_time_mapper.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../../../../core/value_objects/relative_media_path.dart';
import '../../domain/entities/media_asset.dart';

extension MediaAssetRowMapper on MediaAssetRow {
  MediaAsset toDomain() {
    return MediaAsset(
      id: MediaAssetId(id),
      collectionId: CollectionId(collectionId),
      ownerType: ownerType,
      ownerId: ownerId,
      mediaType: mediaType,
      relativePath: RelativeMediaPath(relativePath),
      thumbnailRelativePath: thumbnailRelativePath == null
          ? null
          : RelativeMediaPath(thumbnailRelativePath!),
      mimeType: mimeType,
      width: width,
      height: height,
      durationMs: durationMs,
      fileSize: fileSize,
      sha256: sha256,
      createdAtUtc: fromDatabaseUtc(createdAtUtc),
    );
  }
}

extension MediaAssetDomainMapper on MediaAsset {
  MediaAssetsCompanion toCompanion() {
    return MediaAssetsCompanion(
      id: Value(id.value),
      collectionId: Value(collectionId.value),
      ownerType: Value(ownerType),
      ownerId: Value(ownerId),
      mediaType: Value(mediaType),
      relativePath: Value(relativePath.value),
      thumbnailRelativePath: Value(thumbnailRelativePath?.value),
      mimeType: Value(mimeType),
      width: Value(width),
      height: Value(height),
      durationMs: Value(durationMs),
      fileSize: Value(fileSize),
      sha256: Value(sha256),
      createdAtUtc: Value(toDatabaseUtc(createdAtUtc)),
    );
  }
}
