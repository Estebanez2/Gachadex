import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/domain_enums.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../../../../core/identifiers/uuid_generator.dart';
import '../../../../core/logging/app_logger.dart';
import '../../../../core/time/clock.dart';
import '../../domain/entities/collection_project.dart';
import '../../domain/entities/content_version.dart';
import '../../domain/repositories/collection_project_repository.dart';
import '../mappers/collection_project_mapper.dart';
import '../mappers/content_version_mapper.dart';

final class DriftCollectionProjectRepository
    implements CollectionProjectRepository {
  DriftCollectionProjectRepository({
    required this.database,
    required this.clock,
    required this.uuidGenerator,
  });

  final AppDatabase database;
  final Clock clock;
  final UuidGenerator uuidGenerator;

  @override
  Future<CreatedCollectionDraft> createDraft({
    required String name,
    String? author,
    String? description,
  }) async {
    final now = clock.nowUtc();
    final contentVersion = ContentVersion(
      id: uuidGenerator.contentVersionId(),
      collectionId: uuidGenerator.collectionId(),
      versionNumber: 1,
      formatVersion: 1,
      createdAtUtc: now,
      finalizedAtUtc: null,
      isCurrent: true,
    );
    final project = CollectionProject(
      id: uuidGenerator.collectionProjectId(),
      collectionId: contentVersion.collectionId,
      name: name,
      author: author,
      description: description,
      coverAssetId: null,
      status: CollectionProjectStatus.draft,
      createdAtUtc: now,
      updatedAtUtc: now,
      currentContentVersion: 1,
      currentContentVersionId: contentVersion.id,
      mainPackTypeId: null,
    );

    try {
      await database.collectionProjectsDao.insertProjectAndVersion(
        project: project.toCompanion(),
        contentVersion: contentVersion.toCompanion(),
      );
    } on Object catch (error, stackTrace) {
      AppLogger.error(
        'Failed to create collection draft transaction.',
        error: error,
        stackTrace: stackTrace,
      );
      throw const TransactionFailure(
        'No se pudo crear el borrador de coleccion.',
      );
    }

    return (project: project, contentVersion: contentVersion);
  }

  @override
  Future<CollectionProject> getById(CollectionProjectId id) async {
    final row = await database.collectionProjectsDao.getById(id.value);
    if (row == null) {
      throw const EntityNotFoundFailure('No se encontro el proyecto.');
    }

    return row.toDomain();
  }

  @override
  Stream<List<CollectionProject>> watchAllDrafts() {
    return database.collectionProjectsDao.watchDrafts().map(
      (rows) => rows.map((row) => row.toDomain()).toList(growable: false),
    );
  }

  @override
  Future<CollectionProject> updateBasicInformation({
    required CollectionProjectId id,
    required String name,
    String? author,
    String? description,
  }) async {
    final project = await getById(id);
    if (!project.isDraft) {
      throw const InvalidEntityFailure(
        'No se puede editar un proyecto finalizado.',
      );
    }

    final updated = CollectionProject(
      id: project.id,
      collectionId: project.collectionId,
      name: name,
      author: author,
      description: description,
      coverAssetId: project.coverAssetId,
      status: project.status,
      createdAtUtc: project.createdAtUtc,
      updatedAtUtc: clock.nowUtc(),
      currentContentVersion: project.currentContentVersion,
      currentContentVersionId: project.currentContentVersionId,
      mainPackTypeId: project.mainPackTypeId,
      startingPackCount: project.startingPackCount,
    );

    final replaced = await database.collectionProjectsDao.replaceProject(
      updated.toCompanion(),
    );
    if (!replaced) {
      throw const EntityNotFoundFailure('No se encontro el proyecto.');
    }

    return updated;
  }

  @override
  Future<CollectionProject> markFinalized(CollectionProjectId id) async {
    final project = await getById(id);
    if (!project.isDraft) {
      throw const InvalidEntityFailure('El proyecto ya esta finalizado.');
    }

    final contentVersionId = project.currentContentVersionId;
    if (contentVersionId == null) {
      throw const InvalidEntityFailure(
        'El proyecto no tiene version de contenido.',
      );
    }

    final now = clock.nowUtc();
    final finalized = CollectionProject(
      id: project.id,
      collectionId: project.collectionId,
      name: project.name,
      author: project.author,
      description: project.description,
      coverAssetId: project.coverAssetId,
      status: CollectionProjectStatus.finalized,
      createdAtUtc: project.createdAtUtc,
      updatedAtUtc: now,
      currentContentVersion: project.currentContentVersion,
      currentContentVersionId: contentVersionId,
      mainPackTypeId: project.mainPackTypeId,
      startingPackCount: project.startingPackCount,
    );

    await database.transaction(() async {
      await (database.update(
        database.contentVersions,
      )..where((table) => table.id.equals(contentVersionId.value))).write(
        ContentVersionsCompanion(
          finalizedAtUtc: Value(now),
          isCurrent: const Value(true),
        ),
      );
      await database.collectionProjectsDao.replaceProject(
        finalized.toCompanion(),
      );
    });

    return finalized;
  }

  @override
  Future<void> deleteDraft(CollectionProjectId id) async {
    final project = await getById(id);
    if (!project.isDraft) {
      throw const InvalidEntityFailure(
        'No se puede borrar un proyecto finalizado desde borradores.',
      );
    }

    final contentVersionId = project.currentContentVersionId;
    if (contentVersionId == null) {
      throw const InvalidEntityFailure(
        'El proyecto no tiene version de contenido.',
      );
    }

    final deleted = await database.collectionProjectsDao.deleteDraftGraph(
      projectId: project.id.value,
      collectionId: project.collectionId.value,
      contentVersionId: contentVersionId.value,
    );
    if (deleted == 0) {
      throw const ReferentialIntegrityFailure(
        'No se puede borrar un borrador instalado o protegido.',
      );
    }
  }
}
