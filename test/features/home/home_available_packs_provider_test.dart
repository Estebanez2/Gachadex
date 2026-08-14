import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gachadex/core/database/app_database.dart';
import 'package:gachadex/core/database/database_providers.dart';
import 'package:gachadex/features/home/application/home_providers.dart';

import '../../helpers/database_seed.dart';
import '../../helpers/database_test_utils.dart';

void main() {
  test('returns empty list when no packs are available', () async {
    final database = createInMemoryDatabase();
    addTearDown(database.close);
    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(database)],
    );
    addTearDown(container.dispose);

    final packs = await container.read(homeAvailablePacksProvider.future);

    expect(packs, isEmpty);
  });

  test('returns one item per available pack type with its quantity', () async {
    final database = createInMemoryDatabase();
    addTearDown(database.close);
    final definition = await seedDefinition(database, seed: 1);
    final installedCollectionId = await seedInstalledCollection(
      database,
      definition,
    );
    await _seedInventory(
      database,
      installedCollectionId: installedCollectionId,
      packTypeId: definition.packTypeId,
      availableCount: 2,
    );
    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(database)],
    );
    addTearDown(container.dispose);

    final packs = await container.read(homeAvailablePacksProvider.future);

    expect(packs, hasLength(1));
    expect(packs.single.packName, 'Sobre 1');
    expect(packs.single.availableCount, 2);
    expect(packs.single.maxAccumulated, 3);
  });

  test('includes pack types with no available packs', () async {
    final database = createInMemoryDatabase();
    addTearDown(database.close);
    final definition = await seedDefinition(database, seed: 3);
    final installedCollectionId = await seedInstalledCollection(
      database,
      definition,
      seed: 53,
    );
    await _seedInventory(
      database,
      installedCollectionId: installedCollectionId,
      packTypeId: definition.packTypeId,
      availableCount: 0,
    );
    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(database)],
    );
    addTearDown(container.dispose);

    final packs = await container.read(homeAvailablePacksProvider.future);

    expect(packs, hasLength(1));
    expect(packs.single.availableCount, 0);
    expect(packs.single.maxAccumulated, 3);
  });

  test('combines available packs from two collections', () async {
    final database = createInMemoryDatabase();
    addTearDown(database.close);
    final first = await seedDefinition(database, seed: 1);
    final second = await seedDefinition(database, seed: 2);
    final firstInstalled = await seedInstalledCollection(
      database,
      first,
      seed: 51,
    );
    final secondInstalled = await seedInstalledCollection(
      database,
      second,
      seed: 52,
    );
    await _renameInstalledCollection(database, firstInstalled, 'Amigos');
    await _renameInstalledCollection(database, secondInstalled, 'Viaje');
    await _seedInventory(
      database,
      installedCollectionId: firstInstalled,
      packTypeId: first.packTypeId,
      availableCount: 2,
    );
    await _seedInventory(
      database,
      installedCollectionId: secondInstalled,
      packTypeId: second.packTypeId,
      availableCount: 1,
    );
    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(database)],
    );
    addTearDown(container.dispose);

    final packs = await container.read(homeAvailablePacksProvider.future);

    expect(packs, hasLength(2));
    expect(packs.map((pack) => pack.collectionName), ['Amigos', 'Viaje']);
    expect(packs.fold<int>(0, (total, pack) => total + pack.availableCount), 3);
  });
}

Future<void> _seedInventory(
  AppDatabase database, {
  required String installedCollectionId,
  required String packTypeId,
  required int availableCount,
}) async {
  await database
      .into(database.packInventory)
      .insert(
        PackInventoryCompanion(
          installedCollectionId: Value(installedCollectionId),
          packTypeId: Value(packTypeId),
          availableCount: Value(availableCount),
          maxAccumulated: const Value(3),
          nextRechargeAtUtc: Value(testNowUtc(10)),
          lastCalculatedAtUtc: Value(testNowUtc(5)),
        ),
      );
}

Future<void> _renameInstalledCollection(
  AppDatabase database,
  String installedCollectionId,
  String name,
) async {
  await (database.update(database.installedCollections)
        ..where((table) => table.id.equals(installedCollectionId)))
      .write(InstalledCollectionsCompanion(name: Value(name)));
}
