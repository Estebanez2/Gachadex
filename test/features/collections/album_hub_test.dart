import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gachadex/app/router/app_routes.dart';
import 'package:gachadex/core/database/app_database.dart';
import 'package:gachadex/core/database/database_providers.dart';
import 'package:gachadex/core/domain/domain_enums.dart';
import 'package:gachadex/core/identifiers/entity_id.dart';
import 'package:gachadex/features/collections/application/album_collection_summary_providers.dart';
import 'package:gachadex/features/economy/application/economy_providers.dart';

import '../../helpers/database_seed.dart';
import '../../helpers/database_test_utils.dart';

void main() {
  test(
    'album summaries keep progress, packs and coins per collection',
    () async {
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
      await _updateInstalledCollection(
        database,
        firstInstalled,
        name: 'Amigos',
        totalCardCount: 5,
        distinctOwnedCount: 2,
        coins: 125,
      );
      await _updateInstalledCollection(
        database,
        secondInstalled,
        name: 'Viaje',
        totalCardCount: 8,
        distinctOwnedCount: 1,
        coins: 30,
      );
      await _seedInventory(
        database,
        installedCollectionId: firstInstalled,
        packTypeId: first.packTypeId,
        availableCount: 3,
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
      final subscription = container.listen(
        albumCollectionSummariesProvider,
        (_, _) {},
      );
      addTearDown(subscription.close);

      final summaries = await container.read(
        albumCollectionSummariesProvider.future,
      );

      expect(summaries.map((summary) => summary.name), ['Viaje', 'Amigos']);
      final amigos = summaries.singleWhere(
        (summary) => summary.name == 'Amigos',
      );
      final viaje = summaries.singleWhere((summary) => summary.name == 'Viaje');
      expect(amigos.distinctOwnedCount, 2);
      expect(amigos.totalCardCount, 5);
      expect(amigos.totalAvailablePacks, 3);
      expect(amigos.coins, 125);
      expect(viaje.distinctOwnedCount, 1);
      expect(viaje.totalCardCount, 8);
      expect(viaje.totalAvailablePacks, 1);
      expect(viaje.coins, 30);
    },
  );

  test('movement provider keeps descending order and signed amounts', () async {
    final database = createInMemoryDatabase();
    addTearDown(database.close);
    final definition = await seedDefinition(database, seed: 3);
    final installedCollectionId = await seedInstalledCollection(
      database,
      definition,
      seed: 53,
    );
    await _seedTransaction(
      database,
      id: testUuid(9001),
      installedCollectionId: installedCollectionId,
      transactionType: CoinTransactionType.sellDuplicate,
      amount: 40,
      balanceAfter: 140,
      createdAtUtc: testNowUtc(1),
    );
    await _seedTransaction(
      database,
      id: testUuid(9002),
      installedCollectionId: installedCollectionId,
      transactionType: CoinTransactionType.accelerateTimer,
      amount: -10,
      balanceAfter: 130,
      createdAtUtc: testNowUtc(2),
    );
    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(database)],
    );
    addTearDown(container.dispose);
    final movementsProvider = economyTransactionsProvider(
      InstalledCollectionId(installedCollectionId),
    );
    final subscription = container.listen(movementsProvider, (_, _) {});
    addTearDown(subscription.close);

    final movements = await container.read(movementsProvider.future);

    expect(movements.map((movement) => movement.amount), [-10, 40]);
    expect(movements.first.balanceAfter, 130);
  });

  test('collection routes point to the album hub and cards tab', () {
    final id = testUuid(7001);

    expect(AppRoutes.installedCollectionPath(id), '/album/$id');
    expect(AppRoutes.installedCollectionAlbumPath(id), '/album/$id?tab=cards');
  });
}

Future<void> _updateInstalledCollection(
  AppDatabase database,
  String installedCollectionId, {
  required String name,
  required int totalCardCount,
  required int distinctOwnedCount,
  required int coins,
}) async {
  await (database.update(
    database.installedCollections,
  )..where((table) => table.id.equals(installedCollectionId))).write(
    InstalledCollectionsCompanion(
      name: Value(name),
      totalCardCount: Value(totalCardCount),
      distinctOwnedCount: Value(distinctOwnedCount),
      coins: Value(coins),
    ),
  );
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

Future<void> _seedTransaction(
  AppDatabase database, {
  required String id,
  required String installedCollectionId,
  required CoinTransactionType transactionType,
  required int amount,
  required int balanceAfter,
  required DateTime createdAtUtc,
}) async {
  await database
      .into(database.coinTransactions)
      .insert(
        CoinTransactionsCompanion(
          id: Value(id),
          installedCollectionId: Value(installedCollectionId),
          transactionType: Value(transactionType),
          amount: Value(amount),
          balanceAfter: Value(balanceAfter),
          relatedCardId: const Value(null),
          relatedPackTypeId: const Value(null),
          createdAtUtc: Value(createdAtUtc),
          metadataJson: const Value(null),
        ),
      );
}
