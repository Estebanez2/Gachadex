import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/mappers/date_time_mapper.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../../domain/entities/economy_transaction_entry.dart';

final class DriftEconomyRepository {
  DriftEconomyRepository({required this.database});

  final AppDatabase database;

  Stream<List<EconomyTransactionEntry>> watchTransactions(
    InstalledCollectionId installedCollectionId,
  ) {
    final query =
        database.select(database.coinTransactions).join([
            leftOuterJoin(
              database.cards,
              database.cards.id.equalsExp(
                database.coinTransactions.relatedCardId,
              ),
            ),
            leftOuterJoin(
              database.packTypes,
              database.packTypes.id.equalsExp(
                database.coinTransactions.relatedPackTypeId,
              ),
            ),
          ])
          ..where(
            database.coinTransactions.installedCollectionId.equals(
              installedCollectionId.value,
            ),
          )
          ..orderBy([
            OrderingTerm.desc(database.coinTransactions.createdAtUtc),
          ]);

    return query.watch().map((rows) {
      return rows
          .map((row) {
            final transaction = row.readTable(database.coinTransactions);
            final card = row.readTableOrNull(database.cards);
            final pack = row.readTableOrNull(database.packTypes);
            return EconomyTransactionEntry(
              id: CoinTransactionId(transaction.id),
              transactionType: transaction.transactionType,
              amount: transaction.amount,
              balanceAfter: transaction.balanceAfter,
              relatedCardId: transaction.relatedCardId == null
                  ? null
                  : CardId(transaction.relatedCardId!),
              relatedCardName: card?.name,
              relatedPackTypeId: transaction.relatedPackTypeId == null
                  ? null
                  : PackTypeId(transaction.relatedPackTypeId!),
              relatedPackTypeName: pack?.name,
              createdAtUtc: fromDatabaseUtc(transaction.createdAtUtc),
            );
          })
          .toList(growable: false);
    });
  }
}
