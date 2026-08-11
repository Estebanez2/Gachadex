import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_providers.dart';
import '../../../core/identifiers/entity_id.dart';
import '../data/repositories/drift_economy_repository.dart';
import '../domain/entities/economy_transaction_entry.dart';
import 'economy_use_cases.dart';

final economyRepositoryProvider = Provider<DriftEconomyRepository>((ref) {
  return DriftEconomyRepository(database: ref.watch(appDatabaseProvider));
});

final economyTransactionsProvider = StreamProvider.autoDispose
    .family<List<EconomyTransactionEntry>, InstalledCollectionId>((ref, id) {
      return ref.watch(economyRepositoryProvider).watchTransactions(id);
    });

final sellDuplicateCardsProvider = Provider<SellDuplicateCards>((ref) {
  return SellDuplicateCards(
    database: ref.watch(appDatabaseProvider),
    uuidGenerator: ref.watch(uuidGeneratorProvider),
    clock: ref.watch(clockProvider),
  );
});

final accelerationCalculatorProvider = Provider<AccelerationCalculator>((ref) {
  return const AccelerationCalculator();
});

final acceleratePackRechargeProvider = Provider<AcceleratePackRecharge>((ref) {
  return AcceleratePackRecharge(
    database: ref.watch(appDatabaseProvider),
    uuidGenerator: ref.watch(uuidGeneratorProvider),
    clock: ref.watch(clockProvider),
    calculator: ref.watch(accelerationCalculatorProvider),
  );
});
