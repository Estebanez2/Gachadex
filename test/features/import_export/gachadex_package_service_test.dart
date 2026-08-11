import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:gachadex/core/database/app_database.dart';
import 'package:gachadex/core/domain/domain_enums.dart';
import 'package:gachadex/core/errors/app_failure.dart';
import 'package:gachadex/core/files/project_media_storage.dart';
import 'package:gachadex/core/identifiers/uuid_generator.dart';
import 'package:gachadex/core/time/fake_clock.dart';
import 'package:gachadex/features/import_export/data/gachadex_package_service.dart';
import 'package:gachadex/features/import_export/domain/gachadex_package_constants.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/database_seed.dart';

void main() {
  late Directory exportRoot;
  late Directory importRoot;
  late AppDatabase exportDatabase;
  late AppDatabase importDatabase;

  setUp(() async {
    exportRoot = await Directory.systemTemp.createTemp('gachadex_export_');
    importRoot = await Directory.systemTemp.createTemp('gachadex_import_');
    exportDatabase = AppDatabase(NativeDatabase.memory());
    importDatabase = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await exportDatabase.close();
    await importDatabase.close();
    if (await exportRoot.exists()) {
      await exportRoot.delete(recursive: true);
    }
    if (await importRoot.exists()) {
      await importRoot.delete(recursive: true);
    }
  });

  test(
    'exports and imports a .gachadex package without player progress',
    () async {
      final definition = await seedDefinition(exportDatabase, seed: 9);
      await _seedPlayablePack(exportDatabase, definition);
      final installedCollectionId = await seedInstalledCollection(
        exportDatabase,
        definition,
        seed: 9,
      );
      await _writeMediaFiles(exportRoot, definition);

      final exportService = GachadexPackageService(
        database: exportDatabase,
        mediaStorage: LocalProjectMediaStorage(rootDirectory: exportRoot),
        uuidGenerator: FixedUuidGenerator([testUuid(9001)]),
        clock: FakeClock(DateTime.utc(2026, 8, 11, 10)),
        tempDirectory: exportRoot,
      );
      final importService = GachadexPackageService(
        database: importDatabase,
        mediaStorage: LocalProjectMediaStorage(rootDirectory: importRoot),
        uuidGenerator: FixedUuidGenerator([testUuid(9002)]),
        clock: FakeClock(DateTime.utc(2026, 8, 11, 11)),
        tempDirectory: importRoot,
      );

      final packageFile = await exportService.exportInstalledCollection(
        installedCollectionId,
      );

      expect(packageFile.path, endsWith(gachadexPackageExtension));

      final preview = await importService.previewFile(packageFile.path);
      expect(preview.name, 'Coleccion instalada');
      expect(preview.cardCount, 1);
      expect(preview.alreadyInstalled, isFalse);

      final result = await importService.importFile(packageFile.path);
      final installed = await importDatabase.installedCollectionsDao.getById(
        result.installedCollectionId,
      );
      final inventory = await importDatabase.playerProgressDao.getPackInventory(
        result.installedCollectionId,
      );
      final ownedCards = await importDatabase.playerProgressDao.getOwnedCards(
        result.installedCollectionId,
      );

      expect(installed?.source, InstalledCollectionSource.imported);
      expect(installed?.distinctOwnedCount, 0);
      expect(inventory.single.availableCount, gachadexStartingPackCount);
      expect(ownedCards, isEmpty);
      expect(
        File(
          '${importRoot.path}/collections/${definition.collectionId}/cards/'
          '${definition.cardId}.webp',
        ).existsSync(),
        isTrue,
      );
    },
  );

  test('rejects importing the same collection twice', () async {
    final definition = await seedDefinition(exportDatabase, seed: 10);
    await _seedPlayablePack(exportDatabase, definition);
    final installedCollectionId = await seedInstalledCollection(
      exportDatabase,
      definition,
      seed: 10,
    );
    await _writeMediaFiles(exportRoot, definition);

    final exportService = GachadexPackageService(
      database: exportDatabase,
      mediaStorage: LocalProjectMediaStorage(rootDirectory: exportRoot),
      uuidGenerator: FixedUuidGenerator([testUuid(10001)]),
      clock: FakeClock(DateTime.utc(2026, 8, 11, 10)),
      tempDirectory: exportRoot,
    );
    final importService = GachadexPackageService(
      database: importDatabase,
      mediaStorage: LocalProjectMediaStorage(rootDirectory: importRoot),
      uuidGenerator: FixedUuidGenerator([testUuid(10002)]),
      clock: FakeClock(DateTime.utc(2026, 8, 11, 11)),
      tempDirectory: importRoot,
    );
    final packageFile = await exportService.exportInstalledCollection(
      installedCollectionId,
    );

    await importService.importFile(packageFile.path);

    expect(
      () => importService.importFile(packageFile.path),
      throwsA(isA<GachadexPackageFailure>()),
    );
  });
}

Future<void> _seedPlayablePack(
  AppDatabase database,
  SeededDefinition definition,
) async {
  await database
      .into(database.packCardPool)
      .insert(
        PackCardPoolCompanion(
          packTypeId: Value(definition.packTypeId),
          cardId: Value(definition.cardId),
          isEnabled: const Value(true),
        ),
      );
  for (var index = 0; index < 3; index += 1) {
    await database
        .into(database.packSlotRules)
        .insert(
          PackSlotRulesCompanion(
            id: Value(testUuid(90000 + index)),
            packTypeId: Value(definition.packTypeId),
            slotIndex: Value(index),
            ruleType: const Value(PackSlotRuleType.fixedRarity),
            fixedRarityId: Value(definition.rarityId),
            minimumRarityOrder: const Value(null),
            probabilityGroupId: const Value(null),
          ),
        );
  }
}

Future<void> _writeMediaFiles(
  Directory root,
  SeededDefinition definition,
) async {
  final card = File(
    '${root.path}/collections/${definition.collectionId}/cards/'
    '${definition.cardId}.webp',
  );
  await card.parent.create(recursive: true);
  await card.writeAsBytes(List<int>.generate(2048, (index) => index % 255));

  final thumbnail = File(
    '${root.path}/collections/${definition.collectionId}/cards/'
    '${definition.cardId}-thumb.webp',
  );
  await thumbnail.writeAsBytes(List<int>.filled(128, 7));
}
