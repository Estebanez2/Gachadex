import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/mappers/date_time_mapper.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../../../../core/value_objects/relative_media_path.dart';
import '../../domain/entities/installed_collection.dart';

extension InstalledCollectionRowMapper on InstalledCollectionRow {
  InstalledCollection toDomain() {
    return InstalledCollection(
      id: InstalledCollectionId(id),
      collectionId: CollectionId(collectionId),
      contentVersionId: ContentVersionId(contentVersionId),
      name: name,
      author: author,
      description: description,
      coverRelativePath: coverRelativePath == null
          ? null
          : RelativeMediaPath(coverRelativePath!),
      mainPackTypeId: mainPackTypeId == null
          ? null
          : PackTypeId(mainPackTypeId!),
      installedAtUtc: fromDatabaseUtc(installedAtUtc),
      source: source,
      coins: coins,
      totalCardCount: totalCardCount,
      distinctOwnedCount: distinctOwnedCount,
    );
  }
}

extension InstalledCollectionDomainMapper on InstalledCollection {
  InstalledCollectionsCompanion toCompanion() {
    return InstalledCollectionsCompanion(
      id: Value(id.value),
      collectionId: Value(collectionId.value),
      contentVersionId: Value(contentVersionId.value),
      name: Value(name),
      author: Value(author),
      description: Value(description),
      coverRelativePath: Value(coverRelativePath?.value),
      mainPackTypeId: Value(mainPackTypeId?.value),
      installedAtUtc: Value(toDatabaseUtc(installedAtUtc)),
      source: Value(source),
      coins: Value(coins),
      totalCardCount: Value(totalCardCount),
      distinctOwnedCount: Value(distinctOwnedCount),
    );
  }
}
