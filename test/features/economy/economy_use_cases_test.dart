import 'dart:io';

import 'package:drift/drift.dart' hide isNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:gachadex/core/database/app_database.dart';
import 'package:gachadex/core/domain/domain_enums.dart';
import 'package:gachadex/core/errors/app_failure.dart';
import 'package:gachadex/core/identifiers/entity_id.dart';
import 'package:gachadex/core/identifiers/uuid_generator.dart';
import 'package:gachadex/core/time/fake_clock.dart';
import 'package:gachadex/features/economy/application/economy_use_cases.dart';

import '../../helpers/database_seed.dart';
import '../../helpers/database_test_utils.dart';

void main() {
  group('SellDuplicateCards', () {
    late AppDatabase database;
    late FakeClock clock;
    late SeededDefinition definition;
    late InstalledCollectionId installedCollectionId;
    late SellDuplicateCards sellDuplicateCards;

    setUp(() async {
      database = createInMemoryDatabase();
      clock = FakeClock(testNowUtc(20));
      definition = await seedDefinition(database, seed: 20);
      installedCollectionId = InstalledCollectionId(
        await seedInstalledCollection(database, definition, seed: 20),
      );
      sellDuplicateCards = SellDuplicateCards(
        database: database,
        uuidGenerator: FixedUuidGenerator([testUuid(20001), testUuid(20002)]),
        clock: clock,
      );
    });

    tearDown(() async {
      await database.close();
    });

    test('does not sell the only copy', () async {
      await _insertOwned(
        database,
        definition,
        installedCollectionId,
        quantity: 1,
      );

      await expectLater(
        sellDuplicateCards.call(
          installedCollectionId: installedCollectionId,
          cardId: CardId(definition.cardId),
          quantityToSell: 1,
        ),
        throwsA(isA<InvalidEntityFailure>()),
      );

      final owned = await database.playerProgressDao.getOwnedCards(
        installedCollectionId.value,
      );
      final installed = await database.installedCollectionsDao.getById(
        installedCollectionId.value,
      );
      expect(owned.single.quantity, 1);
      expect(installed?.coins, 0);
      expect(await database.select(database.coinTransactions).get(), isEmpty);
    });

    test('sells one duplicate using rarity sell value', () async {
      await _insertOwned(
        database,
        definition,
        installedCollectionId,
        quantity: 2,
      );

      final result = await sellDuplicateCards.call(
        installedCollectionId: installedCollectionId,
        cardId: CardId(definition.cardId),
        quantityToSell: 1,
      );

      final owned = await database.playerProgressDao.getOwnedCards(
        installedCollectionId.value,
      );
      final installed = await database.installedCollectionsDao.getById(
        installedCollectionId.value,
      );
      final transactions = await database
          .select(database.coinTransactions)
          .get();

      expect(result.quantityAfter, 1);
      expect(result.gachacoinReceived, 10);
      expect(owned.single.quantity, 1);
      expect(installed?.coins, 10);
      expect(
        transactions.single.transactionType,
        CoinTransactionType.sellDuplicate,
      );
      expect(transactions.single.amount, 10);
      expect(transactions.single.balanceAfter, 10);
    });

    test('conflicting validation prevents over-selling', () async {
      await _insertOwned(
        database,
        definition,
        installedCollectionId,
        quantity: 2,
      );

      await sellDuplicateCards.call(
        installedCollectionId: installedCollectionId,
        cardId: CardId(definition.cardId),
        quantityToSell: 1,
      );
      await expectLater(
        sellDuplicateCards.call(
          installedCollectionId: installedCollectionId,
          cardId: CardId(definition.cardId),
          quantityToSell: 1,
        ),
        throwsA(isA<InvalidEntityFailure>()),
      );

      final owned = await database.playerProgressDao.getOwnedCards(
        installedCollectionId.value,
      );
      expect(owned.single.quantity, 1);
      expect(
        await database.select(database.coinTransactions).get(),
        hasLength(1),
      );
    });
  });

  group('AccelerationCalculator', () {
    const calculator = AccelerationCalculator();

    test('calculates partial and multiple cycle costs', () {
      final plan = calculator.plan(
        availableCount: 0,
        maxAccumulated: 5,
        rechargeSeconds: 3600,
        coinsPerFullRecharge: 100,
        nextRechargeAtUtc: testNowUtc(0).add(const Duration(minutes: 30)),
        nowUtc: testNowUtc(0),
        balance: 500,
      );

      expect(plan.options.map((option) => option.cost), [
        50,
        150,
        250,
        350,
        450,
      ]);
      expect(plan.options.last.canAfford, isTrue);
    });

    test('rounds up partial cycle and handles zero full cost', () {
      final rounded = calculator.plan(
        availableCount: 0,
        maxAccumulated: 1,
        rechargeSeconds: 3600,
        coinsPerFullRecharge: 100,
        nextRechargeAtUtc: testNowUtc(0).add(const Duration(seconds: 1)),
        nowUtc: testNowUtc(0),
        balance: 1,
      );
      final free = calculator.plan(
        availableCount: 0,
        maxAccumulated: 1,
        rechargeSeconds: 3600,
        coinsPerFullRecharge: 0,
        nextRechargeAtUtc: testNowUtc(0).add(const Duration(seconds: 100)),
        nowUtc: testNowUtc(0),
        balance: 0,
      );

      expect(rounded.options.single.cost, 1);
      expect(free.options.first.cost, 0);
      expect(free.options.every((option) => option.canAfford), isTrue);
    });

    test('offers purchases above maximum and marks unaffordable options', () {
      final full = calculator.plan(
        availableCount: 1,
        maxAccumulated: 3,
        rechargeSeconds: 3600,
        coinsPerFullRecharge: 10,
        nextRechargeAtUtc: testNowUtc(0).add(const Duration(hours: 1)),
        nowUtc: testNowUtc(0),
        balance: 40,
      );
      final poor = calculator.plan(
        availableCount: 0,
        maxAccumulated: 2,
        rechargeSeconds: 3600,
        coinsPerFullRecharge: 100,
        nextRechargeAtUtc: testNowUtc(0).add(const Duration(hours: 1)),
        nowUtc: testNowUtc(0),
        balance: 50,
      );

      expect(full.isFull, isFalse);
      expect(full.options.map((option) => option.cost), [10, 20, 30, 40]);
      expect(full.options.map((option) => option.resultingAvailableCount), [
        2,
        3,
        4,
        5,
      ]);
      expect(full.options.map((option) => option.canAfford), [
        true,
        true,
        true,
        true,
      ]);
      expect(poor.options.map((option) => option.canAfford), [false]);
    });
  });

  group('AcceleratePackRecharge', () {
    late AppDatabase database;
    late FakeClock clock;
    late SeededDefinition definition;
    late InstalledCollectionId installedCollectionId;
    late AcceleratePackRecharge accelerate;

    setUp(() async {
      database = createInMemoryDatabase();
      clock = FakeClock(testNowUtc(40));
      definition = await seedDefinition(database, seed: 40);
      installedCollectionId = InstalledCollectionId(
        await seedInstalledCollection(database, definition, seed: 40),
      );
      await _prepareAccelerationInventory(
        database,
        definition,
        installedCollectionId,
        now: clock.nowUtc(),
        balance: 250,
      );
      accelerate = AcceleratePackRecharge(
        database: database,
        uuidGenerator: FixedUuidGenerator([testUuid(40001)]),
        clock: clock,
      );
    });

    tearDown(() async {
      await database.close();
    });

    test('spends gachacoin, adds packs and records transaction', () async {
      final result = await accelerate.call(
        installedCollectionId: installedCollectionId,
        packTypeId: PackTypeId(definition.packTypeId),
        cycles: 2,
      );

      final inventory = await database.playerProgressDao.getPackInventory(
        installedCollectionId.value,
      );
      final installed = await database.installedCollectionsDao.getById(
        installedCollectionId.value,
      );
      final transactions = await database
          .select(database.coinTransactions)
          .get();

      expect(result.cost, 150);
      expect(result.availableCount, 2);
      expect(installed?.coins, 100);
      expect(inventory.single.availableCount, 2);
      expect(
        inventory.single.nextRechargeAtUtc.toUtc(),
        clock.nowUtc().add(const Duration(hours: 1)),
      );
      expect(
        transactions.single.transactionType,
        CoinTransactionType.accelerateTimer,
      );
      expect(transactions.single.amount, -150);
    });

    test(
      'allows purchases above maximum and rejects insufficient balance',
      () async {
        await (database.update(database.packInventory)..where(
              (table) =>
                  table.installedCollectionId.equals(
                    installedCollectionId.value,
                  ) &
                  table.packTypeId.equals(definition.packTypeId),
            ))
            .write(const PackInventoryCompanion(availableCount: Value(5)));

        final overstock = await accelerate.call(
          installedCollectionId: installedCollectionId,
          packTypeId: PackTypeId(definition.packTypeId),
          cycles: 1,
        );
        expect(overstock.availableCount, 6);

        await (database.update(database.packInventory)..where(
              (table) =>
                  table.installedCollectionId.equals(
                    installedCollectionId.value,
                  ) &
                  table.packTypeId.equals(definition.packTypeId),
            ))
            .write(const PackInventoryCompanion(availableCount: Value(0)));
        await (database.update(database.installedCollections)
              ..where((table) => table.id.equals(installedCollectionId.value)))
            .write(const InstalledCollectionsCompanion(coins: Value(10)));

        await expectLater(
          accelerate.call(
            installedCollectionId: installedCollectionId,
            packTypeId: PackTypeId(definition.packTypeId),
            cycles: 1,
          ),
          throwsA(isA<InvalidEntityFailure>()),
        );

        expect(
          await database.select(database.coinTransactions).get(),
          hasLength(1),
        );
      },
    );
  });

  test('economy persists quantity, balance, inventory and history', () async {
    final tempDir = await Directory.systemTemp.createTemp('gachadex_economy_');
    final databaseFile = File('${tempDir.path}/economy.sqlite');
    var database = createFileDatabase(databaseFile);
    final clock = FakeClock(testNowUtc(50));
    final definition = await seedDefinition(database, seed: 50);
    final installedCollectionId = InstalledCollectionId(
      await seedInstalledCollection(database, definition, seed: 50),
    );
    await _insertOwned(
      database,
      definition,
      installedCollectionId,
      quantity: 3,
    );
    await _prepareAccelerationInventory(
      database,
      definition,
      installedCollectionId,
      now: clock.nowUtc(),
      balance: 250,
    );

    await SellDuplicateCards(
      database: database,
      uuidGenerator: FixedUuidGenerator([testUuid(50001)]),
      clock: clock,
    ).call(
      installedCollectionId: installedCollectionId,
      cardId: CardId(definition.cardId),
      quantityToSell: 1,
    );
    await AcceleratePackRecharge(
      database: database,
      uuidGenerator: FixedUuidGenerator([testUuid(50002)]),
      clock: clock,
    ).call(
      installedCollectionId: installedCollectionId,
      packTypeId: PackTypeId(definition.packTypeId),
      cycles: 1,
    );
    await database.close();

    database = createFileDatabase(databaseFile);

    final owned = await database.playerProgressDao.getOwnedCards(
      installedCollectionId.value,
    );
    final installed = await database.installedCollectionsDao.getById(
      installedCollectionId.value,
    );
    final inventory = await database.playerProgressDao.getPackInventory(
      installedCollectionId.value,
    );
    final transactions = await database.select(database.coinTransactions).get();

    expect(owned.single.quantity, 2);
    expect(installed?.coins, 210);
    expect(inventory.single.availableCount, 1);
    expect(transactions, hasLength(2));
    await database.close();
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });
}

Future<void> _insertOwned(
  AppDatabase database,
  SeededDefinition definition,
  InstalledCollectionId installedCollectionId, {
  required int quantity,
}) async {
  await database
      .into(database.ownedCards)
      .insert(
        OwnedCardsCompanion.insert(
          installedCollectionId: installedCollectionId.value,
          cardId: definition.cardId,
          quantity: quantity,
          firstObtainedAtUtc: testNowUtc(1),
          lastObtainedAtUtc: testNowUtc(2),
          isFavorite: false,
        ),
      );
  await (database.update(database.installedCollections)
        ..where((table) => table.id.equals(installedCollectionId.value)))
      .write(const InstalledCollectionsCompanion(distinctOwnedCount: Value(1)));
}

Future<void> _prepareAccelerationInventory(
  AppDatabase database,
  SeededDefinition definition,
  InstalledCollectionId installedCollectionId, {
  required DateTime now,
  required int balance,
}) async {
  await (database.update(
    database.packTypes,
  )..where((table) => table.id.equals(definition.packTypeId))).write(
    const PackTypesCompanion(
      rechargeSeconds: Value(3600),
      maxAccumulated: Value(5),
      coinsPerFullRecharge: Value(100),
    ),
  );
  await (database.update(database.installedCollections)
        ..where((table) => table.id.equals(installedCollectionId.value)))
      .write(InstalledCollectionsCompanion(coins: Value(balance)));
  await database
      .into(database.packInventory)
      .insert(
        PackInventoryCompanion.insert(
          installedCollectionId: installedCollectionId.value,
          packTypeId: definition.packTypeId,
          availableCount: 0,
          maxAccumulated: 5,
          nextRechargeAtUtc: now.add(const Duration(minutes: 30)),
          lastCalculatedAtUtc: now,
        ),
      );
}
