import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/mappers/date_time_mapper.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../../domain/entities/collection_project.dart';
import '../../domain/value_objects/draft_cover_style.dart';

extension CollectionProjectRowMapper on CollectionProjectRow {
  CollectionProject toDomain() {
    return CollectionProject(
      id: CollectionProjectId(id),
      collectionId: CollectionId(collectionId),
      name: name,
      author: author,
      description: description,
      coverAssetId: coverAssetId == null ? null : MediaAssetId(coverAssetId!),
      draftCoverStyle: DraftCoverStyle(
        backgroundColorId: draftCoverColorId,
        accentColorId: draftCoverAccentColorId,
        iconId: draftCoverIconId,
        patternId: draftCoverPatternId,
      ),
      status: status,
      createdAtUtc: fromDatabaseUtc(createdAtUtc),
      updatedAtUtc: fromDatabaseUtc(updatedAtUtc),
      currentContentVersion: currentContentVersion,
      currentContentVersionId: currentContentVersionId == null
          ? null
          : ContentVersionId(currentContentVersionId!),
      mainPackTypeId: mainPackTypeId == null
          ? null
          : PackTypeId(mainPackTypeId!),
      startingPackCount: startingPackCount,
    );
  }
}

extension CollectionProjectDomainMapper on CollectionProject {
  CollectionProjectsCompanion toCompanion() {
    return CollectionProjectsCompanion(
      id: Value(id.value),
      collectionId: Value(collectionId.value),
      name: Value(name),
      author: Value(author),
      description: Value(description),
      coverAssetId: Value(coverAssetId?.value),
      draftCoverColorId: Value(draftCoverStyle.backgroundColorId),
      draftCoverAccentColorId: Value(draftCoverStyle.accentColorId),
      draftCoverIconId: Value(draftCoverStyle.iconId),
      draftCoverPatternId: Value(draftCoverStyle.patternId),
      status: Value(status),
      createdAtUtc: Value(toDatabaseUtc(createdAtUtc)),
      updatedAtUtc: Value(toDatabaseUtc(updatedAtUtc)),
      currentContentVersion: Value(currentContentVersion),
      currentContentVersionId: Value(currentContentVersionId?.value),
      mainPackTypeId: Value(mainPackTypeId?.value),
      startingPackCount: Value(startingPackCount),
    );
  }
}
