// ignore_for_file: prefer_initializing_formals

import 'dart:math' as math;

import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/domain/domain_enums.dart';
import '../../../core/errors/app_failure.dart';
import '../../../core/identifiers/entity_id.dart';
import '../../../core/notifications/application/pack_notification_scheduler.dart';
import '../../../core/identifiers/uuid_generator.dart';
import '../../../core/time/clock.dart';

final class SellDuplicateCardsResult {
  const SellDuplicateCardsResult({
    required this.quantityAfter,
    required this.gachacoinReceived,
    required this.balanceAfter,
  });

  final int quantityAfter;
  final int gachacoinReceived;
  final int balanceAfter;
}

final class SellDuplicateCards {
  const SellDuplicateCards({
    required AppDatabase database,
    required UuidGenerator uuidGenerator,
    required Clock clock,
  }) : _database = database,
       _uuidGenerator = uuidGenerator,
       _clock = clock;

  final AppDatabase _database;
  final UuidGenerator _uuidGenerator;
  final Clock _clock;

  Future<SellDuplicateCardsResult> call({
    required InstalledCollectionId installedCollectionId,
    required CardId cardId,
    required int quantityToSell,
  }) {
    if (quantityToSell <= 0) {
      throw const InvalidEntityFailure('Cantidad invalida.');
    }

    return _database.transaction(() async {
      final installed = await _installedOrThrow(installedCollectionId);
      final owned =
          await (_database.select(_database.ownedCards)..where(
                (table) =>
                    table.installedCollectionId.equals(
                      installedCollectionId.value,
                    ) &
                    table.cardId.equals(cardId.value),
              ))
              .getSingleOrNull();
      if (owned == null) {
        throw const InvalidEntityFailure('Todavia no tienes esta carta.');
      }
      if (owned.quantity - quantityToSell < 1) {
        throw const InvalidEntityFailure('No puedes vender la ultima copia.');
      }

      final card = await (_database.select(
        _database.cards,
      )..where((table) => table.id.equals(cardId.value))).getSingleOrNull();
      if (card == null ||
          card.collectionId != installed.collectionId ||
          card.contentVersionId != installed.contentVersionId) {
        throw const ReferentialIntegrityFailure(
          'La carta no pertenece a esta coleccion.',
        );
      }
      final rarity = await (_database.select(
        _database.rarities,
      )..where((table) => table.id.equals(card.rarityId))).getSingleOrNull();
      if (rarity == null || rarity.sellValue < 0) {
        throw const InvalidEntityFailure('Rareza no valida.');
      }

      final quantityAfter = owned.quantity - quantityToSell;
      final income = quantityToSell * rarity.sellValue;
      final balanceAfter = installed.coins + income;
      await (_database.update(_database.ownedCards)..where(
            (table) =>
                table.installedCollectionId.equals(
                  installedCollectionId.value,
                ) &
                table.cardId.equals(cardId.value),
          ))
          .write(OwnedCardsCompanion(quantity: Value(quantityAfter)));
      await (_database.update(_database.installedCollections)
            ..where((table) => table.id.equals(installedCollectionId.value)))
          .write(InstalledCollectionsCompanion(coins: Value(balanceAfter)));
      await _database
          .into(_database.coinTransactions)
          .insert(
            CoinTransactionsCompanion.insert(
              id: _uuidGenerator.generate(),
              installedCollectionId: installedCollectionId.value,
              transactionType: CoinTransactionType.sellDuplicate,
              amount: income,
              balanceAfter: balanceAfter,
              relatedCardId: Value(cardId.value),
              relatedPackTypeId: const Value(null),
              createdAtUtc: _clock.nowUtc(),
              metadataJson: const Value(null),
            ),
          );

      return SellDuplicateCardsResult(
        quantityAfter: quantityAfter,
        gachacoinReceived: income,
        balanceAfter: balanceAfter,
      );
    });
  }

  Future<InstalledCollectionRow> _installedOrThrow(
    InstalledCollectionId id,
  ) async {
    final installed = await (_database.select(
      _database.installedCollections,
    )..where((table) => table.id.equals(id.value))).getSingleOrNull();
    if (installed == null) {
      throw const EntityNotFoundFailure(
        'No se encontro la coleccion instalada.',
      );
    }
    return installed;
  }
}

final class AccelerationOption {
  const AccelerationOption({
    required this.cycles,
    required this.cost,
    required this.resultingAvailableCount,
    required this.balanceAfter,
    required this.canAfford,
  });

  final int cycles;
  final int cost;
  final int resultingAvailableCount;
  final int balanceAfter;
  final bool canAfford;
}

final class AccelerationPlan {
  const AccelerationPlan({
    required this.options,
    required this.isFull,
    required this.balance,
  });

  final List<AccelerationOption> options;
  final bool isFull;
  final int balance;
}

final class AccelerationCalculator {
  const AccelerationCalculator();

  static const int maxVisiblePurchaseOptions = 20;

  AccelerationPlan plan({
    required int availableCount,
    required int maxAccumulated,
    required int rechargeSeconds,
    required int coinsPerFullRecharge,
    required DateTime nextRechargeAtUtc,
    required DateTime nowUtc,
    required int balance,
  }) {
    if (rechargeSeconds <= 0 ||
        maxAccumulated <= 0 ||
        availableCount < 0 ||
        coinsPerFullRecharge < 0) {
      throw ArgumentError('Invalid acceleration input.');
    }
    final available = availableCount < 0 ? 0 : availableCount;

    final now = nowUtc.toUtc();
    final next = nextRechargeAtUtc.toUtc();
    final timerIsActive = available < maxAccumulated;
    final remainingSeconds = timerIsActive
        ? math.max(0, next.difference(now).inSeconds)
        : 0;
    final firstCost = !timerIsActive
        ? coinsPerFullRecharge
        : remainingSeconds == 0
        ? 0
        : _ceilDiv(coinsPerFullRecharge * remainingSeconds, rechargeSeconds);
    final normalizedFirstCost = remainingSeconds > 0 && coinsPerFullRecharge > 0
        ? math.max(1, firstCost)
        : firstCost;

    final options = <AccelerationOption>[];
    var total = 0;
    for (var cycles = 1; cycles <= maxVisiblePurchaseOptions; cycles += 1) {
      final cycleCost = cycles == 1 && timerIsActive
          ? normalizedFirstCost
          : coinsPerFullRecharge;
      total += cycleCost;
      if (total > balance && options.isNotEmpty) {
        break;
      }
      options.add(
        AccelerationOption(
          cycles: cycles,
          cost: total,
          resultingAvailableCount: available + cycles,
          balanceAfter: balance - total,
          canAfford: balance >= total,
        ),
      );
    }
    return AccelerationPlan(
      options: options,
      isFull: options.isEmpty,
      balance: balance,
    );
  }

  int _ceilDiv(int numerator, int denominator) {
    if (denominator <= 0) {
      throw ArgumentError.value(denominator, 'denominator');
    }
    return (numerator + denominator - 1) ~/ denominator;
  }
}

final class AcceleratePackRechargeResult {
  const AcceleratePackRechargeResult({
    required this.generatedPacks,
    required this.cost,
    required this.balanceAfter,
    required this.availableCount,
  });

  final int generatedPacks;
  final int cost;
  final int balanceAfter;
  final int availableCount;
}

final class AcceleratePackRecharge {
  const AcceleratePackRecharge({
    required AppDatabase database,
    required UuidGenerator uuidGenerator,
    required Clock clock,
    AccelerationCalculator calculator = const AccelerationCalculator(),
    PackNotificationScheduler? notificationScheduler,
  }) : _database = database,
       _uuidGenerator = uuidGenerator,
       _clock = clock,
       _calculator = calculator,
       _notificationScheduler = notificationScheduler;

  final AppDatabase _database;
  final UuidGenerator _uuidGenerator;
  final Clock _clock;
  final AccelerationCalculator _calculator;
  final PackNotificationScheduler? _notificationScheduler;

  Future<AcceleratePackRechargeResult> call({
    required InstalledCollectionId installedCollectionId,
    required PackTypeId packTypeId,
    required int cycles,
  }) async {
    if (cycles <= 0) {
      throw const InvalidEntityFailure('Cantidad invalida.');
    }
    final result = await _database.transaction(() async {
      final installed =
          await (_database.select(
                _database.installedCollections,
              )..where((table) => table.id.equals(installedCollectionId.value)))
              .getSingleOrNull();
      if (installed == null) {
        throw const EntityNotFoundFailure(
          'No se encontro la coleccion instalada.',
        );
      }
      final pack = await (_database.select(
        _database.packTypes,
      )..where((table) => table.id.equals(packTypeId.value))).getSingleOrNull();
      if (pack == null ||
          pack.collectionId != installed.collectionId ||
          pack.contentVersionId != installed.contentVersionId) {
        throw const ReferentialIntegrityFailure(
          'El sobre no pertenece a esta coleccion.',
        );
      }
      final inventory =
          await (_database.select(_database.packInventory)..where(
                (table) =>
                    table.installedCollectionId.equals(
                      installedCollectionId.value,
                    ) &
                    table.packTypeId.equals(packTypeId.value),
              ))
              .getSingleOrNull();
      if (inventory == null) {
        throw const EntityNotFoundFailure('Inventario no encontrado.');
      }
      final plan = _calculator.plan(
        availableCount: inventory.availableCount,
        maxAccumulated: inventory.maxAccumulated,
        rechargeSeconds: pack.rechargeSeconds,
        coinsPerFullRecharge: pack.coinsPerFullRecharge,
        nextRechargeAtUtc: inventory.nextRechargeAtUtc,
        nowUtc: _clock.nowUtc(),
        balance: installed.coins,
      );
      AccelerationOption? option;
      for (final candidate in plan.options) {
        if (candidate.cycles == cycles) {
          option = candidate;
          break;
        }
      }
      if (option == null) {
        throw const InvalidEntityFailure('Cantidad invalida.');
      }
      if (!option.canAfford) {
        throw const InvalidEntityFailure('No tienes suficientes gachacoin.');
      }

      final now = _clock.nowUtc();
      final nextRechargeAtUtc = now.add(
        Duration(seconds: pack.rechargeSeconds),
      );
      await (_database.update(_database.packInventory)..where(
            (table) =>
                table.installedCollectionId.equals(
                  installedCollectionId.value,
                ) &
                table.packTypeId.equals(packTypeId.value),
          ))
          .write(
            PackInventoryCompanion(
              availableCount: Value(option.resultingAvailableCount),
              nextRechargeAtUtc: Value(nextRechargeAtUtc),
              lastCalculatedAtUtc: Value(now),
            ),
          );
      await (_database.update(
        _database.installedCollections,
      )..where((table) => table.id.equals(installedCollectionId.value))).write(
        InstalledCollectionsCompanion(coins: Value(option.balanceAfter)),
      );
      await _database
          .into(_database.coinTransactions)
          .insert(
            CoinTransactionsCompanion.insert(
              id: _uuidGenerator.generate(),
              installedCollectionId: installedCollectionId.value,
              transactionType: CoinTransactionType.accelerateTimer,
              amount: -option.cost,
              balanceAfter: option.balanceAfter,
              relatedCardId: const Value(null),
              relatedPackTypeId: Value(packTypeId.value),
              createdAtUtc: now,
              metadataJson: const Value(null),
            ),
          );

      return AcceleratePackRechargeResult(
        generatedPacks: cycles,
        cost: option.cost,
        balanceAfter: option.balanceAfter,
        availableCount: option.resultingAvailableCount,
      );
    });
    await _notificationScheduler?.tryReschedulePack(
      installedCollectionId: installedCollectionId,
      packTypeId: packTypeId,
    );
    return result;
  }
}
