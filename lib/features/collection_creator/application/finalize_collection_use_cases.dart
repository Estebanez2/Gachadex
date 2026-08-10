// ignore_for_file: prefer_initializing_formals

import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart' hide PackInventory;
import '../../../core/domain/domain_enums.dart';
import '../../../core/errors/app_failure.dart';
import '../../../core/files/project_media_storage.dart';
import '../../../core/identifiers/entity_id.dart';
import '../../../core/identifiers/uuid_generator.dart';
import '../../../core/time/clock.dart';
import '../../cards/domain/repositories/card_repository.dart';
import '../../collections/data/mappers/installed_collection_mapper.dart';
import '../../collections/domain/entities/installed_collection.dart';
import '../../collections/domain/repositories/installed_collection_repository.dart';
import '../../packs/data/mappers/progress_mappers.dart';
import '../../packs/domain/entities/pack_configuration.dart';
import '../../packs/domain/entities/pack_inventory.dart';
import '../../packs/domain/repositories/pack_type_repository.dart';
import '../../packs/domain/validation/pack_validation.dart';
import '../../rarities/domain/repositories/rarity_repository.dart';
import '../domain/entities/collection_project.dart';
import '../domain/repositories/collection_project_repository.dart';
import '../domain/validation/collection_draft_validation.dart';
import '../domain/validation/collection_finalization_validation.dart';

final class ValidateCollectionForFinalization {
  const ValidateCollectionForFinalization({
    required CollectionProjectRepository projectRepository,
    required RarityRepository rarityRepository,
    required CardRepository cardRepository,
    required PackTypeRepository packTypeRepository,
    required ProjectMediaStorage mediaStorage,
  }) : _projectRepository = projectRepository,
       _rarityRepository = rarityRepository,
       _cardRepository = cardRepository,
       _packTypeRepository = packTypeRepository,
       _mediaStorage = mediaStorage;

  final CollectionProjectRepository _projectRepository;
  final RarityRepository _rarityRepository;
  final CardRepository _cardRepository;
  final PackTypeRepository _packTypeRepository;
  final ProjectMediaStorage _mediaStorage;

  Future<CollectionFinalizationReport> call(
    CollectionProjectId projectId,
  ) async {
    final issues = <CollectionFinalizationIssue>[];
    final project = await _projectRepository.getById(projectId);
    final contentVersionId = project.currentContentVersionId;
    if (contentVersionId == null) {
      return const CollectionFinalizationReport([
        CollectionFinalizationIssue(
          section: FinalizationSection.information,
          message: 'El borrador no tiene version de contenido.',
        ),
      ]);
    }

    final infoErrors = CollectionDraftValidation.validateInfo(
      name: project.name,
      author: project.author ?? '',
      description: project.description ?? '',
    );
    if (!CollectionDraftValidation.isNameComplete(project.name) ||
        !infoErrors.canSave) {
      issues.add(
        const CollectionFinalizationIssue(
          section: FinalizationSection.information,
          message: 'La informacion de la coleccion esta incompleta.',
        ),
      );
    }

    final rarities = await _rarityRepository
        .watchByCollectionVersion(
          collectionId: project.collectionId,
          contentVersionId: contentVersionId,
        )
        .first;
    if (rarities.isEmpty) {
      issues.add(
        const CollectionFinalizationIssue(
          section: FinalizationSection.rarities,
          message: 'Debe existir al menos una rareza.',
        ),
      );
    }

    final cardDetails = await _cardRepository
        .watchImageCardsByCollectionVersion(
          collectionId: project.collectionId,
          contentVersionId: contentVersionId,
        )
        .first;
    final cards = cardDetails.map((details) => details.card).toList();
    if (cards.isEmpty) {
      issues.add(
        const CollectionFinalizationIssue(
          section: FinalizationSection.cards,
          message: 'Debe existir al menos una carta.',
        ),
      );
    }
    final numbers = <int>{};
    for (final details in cardDetails) {
      if (!numbers.add(details.card.collectionNumber)) {
        issues.add(
          CollectionFinalizationIssue(
            section: FinalizationSection.cards,
            message:
                'El numero ${details.card.collectionNumber} esta repetido.',
          ),
        );
      }
      if (!rarities.any((rarity) => rarity.id == details.card.rarityId)) {
        issues.add(
          CollectionFinalizationIssue(
            section: FinalizationSection.cards,
            message: 'La carta "${details.card.name}" no tiene rareza valida.',
          ),
        );
      }
      if (!await _mediaStorage.exists(details.mediaAsset.relativePath)) {
        issues.add(
          CollectionFinalizationIssue(
            section: FinalizationSection.cards,
            message: 'Falta el archivo de imagen de "${details.card.name}".',
          ),
        );
      }
    }

    final packs = await _packConfigurations(project, contentVersionId);
    if (packs.isEmpty) {
      issues.add(
        const CollectionFinalizationIssue(
          section: FinalizationSection.packs,
          message: 'Debe existir al menos un sobre.',
        ),
      );
    }
    final mainPacks = packs.where((config) => config.packType.isMain).toList();
    if (mainPacks.length != 1) {
      issues.add(
        const CollectionFinalizationIssue(
          section: FinalizationSection.packs,
          message: 'Debe existir exactamente un sobre principal.',
        ),
      );
    } else if (mainPacks.single.packType.maxAccumulated < 3) {
      issues.add(
        const CollectionFinalizationIssue(
          section: FinalizationSection.packs,
          message: 'El sobre principal debe acumular al menos tres.',
        ),
      );
    }

    for (final config in packs) {
      final validation = PackValidation.validateConfiguration(
        configuration: config,
        cards: cards,
        rarities: rarities,
      );
      if (!validation.canSave) {
        issues.add(
          CollectionFinalizationIssue(
            section: FinalizationSection.packs,
            message: 'El sobre "${config.packType.name}" esta incompleto.',
          ),
        );
      }
    }

    return CollectionFinalizationReport(issues);
  }

  Future<List<PackConfiguration>> _packConfigurations(
    CollectionProject project,
    ContentVersionId contentVersionId,
  ) async {
    final packs = await _packTypeRepository
        .watchByCollectionVersion(
          collectionId: project.collectionId,
          contentVersionId: contentVersionId,
        )
        .first;
    final configs = <PackConfiguration>[];
    for (final pack in packs) {
      configs.add(await _packTypeRepository.getFullConfiguration(pack.id));
    }
    return configs;
  }
}

final class FinalizeCollection {
  const FinalizeCollection({
    required AppDatabase database,
    required CollectionProjectRepository projectRepository,
    required InstalledCollectionRepository installedCollectionRepository,
    required CardRepository cardRepository,
    required PackTypeRepository packTypeRepository,
    required ValidateCollectionForFinalization validator,
    required UuidGenerator uuidGenerator,
    required Clock clock,
  }) : _database = database,
       _projectRepository = projectRepository,
       _installedCollectionRepository = installedCollectionRepository,
       _cardRepository = cardRepository,
       _packTypeRepository = packTypeRepository,
       _validator = validator,
       _uuidGenerator = uuidGenerator,
       _clock = clock;

  final AppDatabase _database;
  final CollectionProjectRepository _projectRepository;
  final InstalledCollectionRepository _installedCollectionRepository;
  final CardRepository _cardRepository;
  final PackTypeRepository _packTypeRepository;
  final ValidateCollectionForFinalization _validator;
  final UuidGenerator _uuidGenerator;
  final Clock _clock;

  Future<InstalledCollection> call(CollectionProjectId projectId) async {
    final project = await _projectRepository.getById(projectId);
    final contentVersionId = project.currentContentVersionId;
    if (contentVersionId == null) {
      throw const InvalidEntityFailure(
        'El proyecto no tiene version de contenido.',
      );
    }
    final existing = await _installedCollectionRepository
        .getByCollectionVersion(
          collectionId: project.collectionId,
          contentVersionId: contentVersionId,
        );
    if (existing != null) {
      return existing;
    }
    if (!project.isDraft) {
      throw const InvalidEntityFailure('El proyecto ya esta finalizado.');
    }

    final report = await _validator(projectId);
    if (!report.canFinalize) {
      throw const InvalidEntityFailure('No se puede finalizar la coleccion.');
    }

    final now = _clock.nowUtc();
    final cards = await _cardRepository
        .watchByCollectionVersion(
          collectionId: project.collectionId,
          contentVersionId: contentVersionId,
        )
        .first;
    final packs = await _packTypeRepository
        .watchByCollectionVersion(
          collectionId: project.collectionId,
          contentVersionId: contentVersionId,
        )
        .first;
    final mainPack = packs.singleWhere((pack) => pack.isMain);
    final installed = InstalledCollection(
      id: _uuidGenerator.installedCollectionId(),
      collectionId: project.collectionId,
      contentVersionId: contentVersionId,
      name: project.name,
      author: project.author,
      description: project.description,
      coverRelativePath: null,
      mainPackTypeId: mainPack.id,
      installedAtUtc: now,
      source: InstalledCollectionSource.createdLocally,
      coins: 0,
      totalCardCount: cards.length,
      distinctOwnedCount: 0,
    );

    await _database.transaction(() async {
      final duplicate = await _installedCollectionRepository
          .getByCollectionVersion(
            collectionId: project.collectionId,
            contentVersionId: contentVersionId,
          );
      if (duplicate != null) {
        return;
      }
      await (_database.update(
        _database.contentVersions,
      )..where((table) => table.id.equals(contentVersionId.value))).write(
        ContentVersionsCompanion(
          finalizedAtUtc: Value(now),
          isCurrent: const Value(true),
        ),
      );
      await (_database.update(
        _database.collectionProjects,
      )..where((table) => table.id.equals(project.id.value))).write(
        CollectionProjectsCompanion(
          status: const Value(CollectionProjectStatus.finalized),
          updatedAtUtc: Value(now),
          mainPackTypeId: Value(mainPack.id.value),
        ),
      );
      await _database
          .into(_database.installedCollections)
          .insert(installed.toCompanion());
      for (final pack in packs) {
        final initialCount = pack.isMain ? project.startingPackCount : 0;
        final availableCount = initialCount
            .clamp(0, pack.maxAccumulated)
            .toInt();
        await _database
            .into(_database.packInventory)
            .insert(
              PackInventory(
                installedCollectionId: installed.id,
                packTypeId: pack.id,
                availableCount: availableCount,
                maxAccumulated: pack.maxAccumulated,
                nextRechargeAtUtc: now.add(
                  Duration(seconds: pack.rechargeSeconds),
                ),
                lastCalculatedAtUtc: now,
              ).toCompanion(),
            );
      }
    });

    return _installedCollectionRepository
        .getByCollectionVersion(
          collectionId: project.collectionId,
          contentVersionId: contentVersionId,
        )
        .then((value) => value ?? installed);
  }
}
