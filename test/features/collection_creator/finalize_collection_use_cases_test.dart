import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gachadex/core/database/app_database.dart';
import 'package:gachadex/core/domain/domain_enums.dart';
import 'package:gachadex/core/files/project_media_storage.dart';
import 'package:gachadex/core/identifiers/entity_id.dart';
import 'package:gachadex/core/identifiers/uuid_generator.dart';
import 'package:gachadex/core/time/fake_clock.dart';
import 'package:gachadex/features/cards/data/repositories/drift_card_repository.dart';
import 'package:gachadex/features/collection_creator/application/finalize_collection_use_cases.dart';
import 'package:gachadex/features/collection_creator/data/repositories/drift_collection_project_repository.dart';
import 'package:gachadex/features/collections/data/repositories/drift_installed_collection_repository.dart';
import 'package:gachadex/features/packs/data/repositories/drift_pack_type_repository.dart';
import 'package:gachadex/features/packs/domain/entities/pack_card_pool_entry.dart';
import 'package:gachadex/features/packs/domain/entities/pack_configuration.dart';
import 'package:gachadex/features/packs/domain/entities/pack_slot_rule.dart';
import 'package:gachadex/features/packs/domain/entities/pack_type.dart';
import 'package:gachadex/features/rarities/data/repositories/drift_rarity_repository.dart';

import '../../helpers/database_seed.dart';
import '../../helpers/database_test_utils.dart';

void main() {
  group('FinalizeCollection', () {
    late AppDatabase database;
    late Directory mediaRoot;
    late FakeClock clock;

    setUp(() async {
      database = createInMemoryDatabase();
      mediaRoot = await Directory.systemTemp.createTemp(
        'gachadex_finalization_',
      );
      clock = FakeClock(testNowUtc(90));
    });

    tearDown(() async {
      await database.close();
      if (mediaRoot.existsSync()) {
        mediaRoot.deleteSync(recursive: true);
      }
    });

    test('installs a valid draft once and creates pack inventories', () async {
      final definition = await seedDefinition(database, seed: 90);
      await _insertProject(database, definition);
      await _createStoredMediaFile(mediaRoot, definition);

      final cardRepository = DriftCardRepository(database: database);
      final rarityRepository = DriftRarityRepository(
        database: database,
        cardRepository: cardRepository,
      );
      final packTypeRepository = DriftPackTypeRepository(
        database: database,
        clock: clock,
      );
      final projectRepository = DriftCollectionProjectRepository(
        database: database,
        clock: clock,
        uuidGenerator: FixedUuidGenerator(const []),
      );
      final installedRepository = DriftInstalledCollectionRepository(
        database: database,
      );
      await _completeMainPack(packTypeRepository, definition);
      final secondaryPackId = await _createSecondaryPack(
        packTypeRepository,
        definition,
      );
      final validator = ValidateCollectionForFinalization(
        projectRepository: projectRepository,
        rarityRepository: rarityRepository,
        cardRepository: cardRepository,
        packTypeRepository: packTypeRepository,
        mediaStorage: LocalProjectMediaStorage(rootDirectory: mediaRoot),
      );
      final useCase = FinalizeCollection(
        database: database,
        projectRepository: projectRepository,
        installedCollectionRepository: installedRepository,
        cardRepository: cardRepository,
        packTypeRepository: packTypeRepository,
        validator: validator,
        uuidGenerator: FixedUuidGenerator([testUuid(9900)]),
        clock: clock,
      );

      final report = await validator(CollectionProjectId(testUuid(9007)));
      final installed = await useCase(CollectionProjectId(testUuid(9007)));
      final repeated = await useCase(CollectionProjectId(testUuid(9007)));
      final project = await projectRepository.getById(
        CollectionProjectId(testUuid(9007)),
      );
      final version =
          await (database.select(
                database.contentVersions,
              )..where((table) => table.id.equals(definition.contentVersionId)))
              .getSingleOrNull();
      final inventories = await database.playerProgressDao.getPackInventory(
        installed.id.value,
      );

      expect(report.canFinalize, isTrue);
      expect(installed.id, InstalledCollectionId(testUuid(9900)));
      expect(repeated.id, installed.id);
      expect(project.status, CollectionProjectStatus.finalized);
      expect(project.mainPackTypeId, PackTypeId(definition.packTypeId));
      expect(version?.finalizedAtUtc?.toUtc(), testNowUtc(90));
      expect(inventories, hasLength(2));
      expect(
        inventories
            .singleWhere((row) => row.packTypeId == definition.packTypeId)
            .availableCount,
        3,
      );
      expect(
        inventories
            .singleWhere((row) => row.packTypeId == secondaryPackId.value)
            .availableCount,
        0,
      );
      expect(
        await database.select(database.installedCollections).get(),
        hasLength(1),
      );
    });
  });
}

Future<void> _insertProject(AppDatabase database, SeededDefinition definition) {
  return database
      .into(database.collectionProjects)
      .insert(
        CollectionProjectsCompanion(
          id: Value(testUuid(9007)),
          collectionId: Value(definition.collectionId),
          name: const Value('Coleccion finalizable'),
          author: const Value('Grupo'),
          description: const Value('Lista para jugar localmente.'),
          coverAssetId: const Value(null),
          status: const Value(CollectionProjectStatus.draft),
          createdAtUtc: Value(testNowUtc(90)),
          updatedAtUtc: Value(testNowUtc(90)),
          currentContentVersion: const Value(1),
          currentContentVersionId: Value(definition.contentVersionId),
          mainPackTypeId: const Value(null),
          startingPackCount: const Value(3),
        ),
      );
}

Future<void> _createStoredMediaFile(
  Directory root,
  SeededDefinition definition,
) async {
  final file = File(
    [
      root.path,
      'collections',
      definition.collectionId,
      'cards',
      '${definition.cardId}.webp',
    ].join(Platform.pathSeparator),
  );
  await file.parent.create(recursive: true);
  await file.writeAsBytes([1, 2, 3]);
}

Future<void> _completeMainPack(
  DriftPackTypeRepository repository,
  SeededDefinition definition,
) async {
  final packTypeId = PackTypeId(definition.packTypeId);
  await repository.addCardToPool(
    PackCardPoolEntry(
      packTypeId: packTypeId,
      cardId: CardId(definition.cardId),
      isEnabled: true,
    ),
  );
  for (var index = 0; index < 3; index++) {
    await repository.addSlotRule(
      PackSlotRule(
        id: PackSlotRuleId(testUuid(9100 + index)),
        packTypeId: packTypeId,
        slotIndex: index,
        ruleType: PackSlotRuleType.fixedRarity,
        fixedRarityId: RarityId(definition.rarityId),
        minimumRarityOrder: null,
        probabilityGroupId: null,
      ),
    );
  }
}

Future<PackTypeId> _createSecondaryPack(
  DriftPackTypeRepository repository,
  SeededDefinition definition,
) async {
  final packTypeId = PackTypeId(testUuid(9200));
  await repository.createConfiguration(
    PackConfiguration(
      packType: PackType(
        id: packTypeId,
        collectionId: CollectionId(definition.collectionId),
        contentVersionId: ContentVersionId(definition.contentVersionId),
        name: 'Sobre secundario',
        description: null,
        frontAssetId: null,
        backAssetId: null,
        cardCount: 1,
        rechargeSeconds: 7200,
        maxAccumulated: 2,
        isMain: false,
        coinsPerFullRecharge: 0,
        sortIndex: 1,
      ),
      pool: [
        PackCardPoolEntry(
          packTypeId: packTypeId,
          cardId: CardId(definition.cardId),
          isEnabled: true,
        ),
      ],
      slotRules: [
        PackSlotRule(
          id: PackSlotRuleId(testUuid(9201)),
          packTypeId: packTypeId,
          slotIndex: 0,
          ruleType: PackSlotRuleType.fixedRarity,
          fixedRarityId: RarityId(definition.rarityId),
          minimumRarityOrder: null,
          probabilityGroupId: null,
        ),
      ],
      probabilities: const [],
    ),
  );
  return packTypeId;
}
