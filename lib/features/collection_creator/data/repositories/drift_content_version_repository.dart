import '../../../../core/database/app_database.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../../../../core/identifiers/uuid_generator.dart';
import '../../../../core/time/clock.dart';
import '../../domain/entities/content_version.dart';
import '../../domain/repositories/content_version_repository.dart';
import '../mappers/content_version_mapper.dart';

final class DriftContentVersionRepository implements ContentVersionRepository {
  DriftContentVersionRepository({
    required this.database,
    required this.clock,
    required this.uuidGenerator,
  });

  final AppDatabase database;
  final Clock clock;
  final UuidGenerator uuidGenerator;

  @override
  Future<ContentVersion> createInitialVersion(CollectionId collectionId) async {
    final version = ContentVersion(
      id: uuidGenerator.contentVersionId(),
      collectionId: collectionId,
      versionNumber: 1,
      formatVersion: 1,
      createdAtUtc: clock.nowUtc(),
      finalizedAtUtc: null,
      isCurrent: true,
    );
    await database.contentVersionsDao.insertVersion(version.toCompanion());
    return version;
  }

  @override
  Future<ContentVersion> getCurrentVersion(CollectionId collectionId) async {
    final row = await database.contentVersionsDao.getCurrentVersion(
      collectionId.value,
    );
    if (row == null) {
      throw const EntityNotFoundFailure('No se encontro la version actual.');
    }

    return row.toDomain();
  }

  @override
  Future<List<ContentVersion>> listVersions(CollectionId collectionId) async {
    final rows = await database.contentVersionsDao.listVersions(
      collectionId.value,
    );
    return rows.map((row) => row.toDomain()).toList(growable: false);
  }
}
