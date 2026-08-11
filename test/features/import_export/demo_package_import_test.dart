import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gachadex/core/database/app_database.dart';
import 'package:gachadex/core/files/project_media_storage.dart';
import 'package:gachadex/core/identifiers/uuid_generator.dart';
import 'package:gachadex/core/time/fake_clock.dart';
import 'package:gachadex/features/import_export/data/gachadex_package_service.dart';

void main() {
  test('demo package can be previewed and imported', () async {
    final packageFile = File('samples/gachadex_demo_completa.gachadex');
    expect(packageFile.existsSync(), isTrue);

    final importRoot = await Directory.systemTemp.createTemp(
      'gachadex_demo_import_',
    );
    final database = AppDatabase(NativeDatabase.memory());
    try {
      final service = GachadexPackageService(
        database: database,
        mediaStorage: LocalProjectMediaStorage(rootDirectory: importRoot),
        uuidGenerator: FixedUuidGenerator([
          '22222222-2222-4222-8222-222222222001',
        ]),
        clock: FakeClock(DateTime.utc(2026, 8, 11, 13)),
        tempDirectory: importRoot,
      );

      final preview = await service.previewFile(packageFile.path);
      expect(preview.name, 'Gachadex Demo: Mini Fiesta');
      expect(preview.cardCount, 5);
      expect(preview.packTypeCount, 2);
      expect(preview.alreadyInstalled, isFalse);

      final result = await service.importFile(packageFile.path);
      final inventory = await database.playerProgressDao.getPackInventory(
        result.installedCollectionId,
      );
      expect(inventory, hasLength(2));
    } finally {
      await database.close();
      if (await importRoot.exists()) {
        await importRoot.delete(recursive: true);
      }
    }
  });

  test('demo package import recovers from stale partial definition', () async {
    final packageFile = File('samples/gachadex_demo_completa.gachadex');
    expect(packageFile.existsSync(), isTrue);

    final importRoot = await Directory.systemTemp.createTemp(
      'gachadex_demo_stale_import_',
    );
    final database = AppDatabase(NativeDatabase.memory());
    try {
      await database
          .into(database.contentVersions)
          .insert(
            ContentVersionsCompanion.insert(
              id: '11111111-1111-4111-8111-111111111112',
              collectionId: '11111111-1111-4111-8111-111111111111',
              versionNumber: 1,
              formatVersion: 1,
              createdAtUtc: DateTime.utc(2026, 8, 11, 12),
              finalizedAtUtc: Value(DateTime.utc(2026, 8, 11, 12)),
              isCurrent: true,
            ),
          );

      final service = GachadexPackageService(
        database: database,
        mediaStorage: LocalProjectMediaStorage(rootDirectory: importRoot),
        uuidGenerator: FixedUuidGenerator([
          '22222222-2222-4222-8222-222222222002',
        ]),
        clock: FakeClock(DateTime.utc(2026, 8, 11, 13)),
        tempDirectory: importRoot,
      );

      final result = await service.importFile(packageFile.path);
      final installed = await database.installedCollectionsDao.getById(
        result.installedCollectionId,
      );
      expect(installed?.name, 'Gachadex Demo: Mini Fiesta');
    } finally {
      await database.close();
      if (await importRoot.exists()) {
        await importRoot.delete(recursive: true);
      }
    }
  });
}
