import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/mappers/date_time_mapper.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../../domain/entities/content_version.dart';

extension ContentVersionRowMapper on ContentVersionRow {
  ContentVersion toDomain() {
    return ContentVersion(
      id: ContentVersionId(id),
      collectionId: CollectionId(collectionId),
      versionNumber: versionNumber,
      formatVersion: formatVersion,
      createdAtUtc: fromDatabaseUtc(createdAtUtc),
      finalizedAtUtc: finalizedAtUtc == null
          ? null
          : fromDatabaseUtc(finalizedAtUtc!),
      isCurrent: isCurrent,
    );
  }
}

extension ContentVersionDomainMapper on ContentVersion {
  ContentVersionsCompanion toCompanion() {
    return ContentVersionsCompanion(
      id: Value(id.value),
      collectionId: Value(collectionId.value),
      versionNumber: Value(versionNumber),
      formatVersion: Value(formatVersion),
      createdAtUtc: Value(toDatabaseUtc(createdAtUtc)),
      finalizedAtUtc: Value(
        finalizedAtUtc == null ? null : toDatabaseUtc(finalizedAtUtc!),
      ),
      isCurrent: Value(isCurrent),
    );
  }
}
