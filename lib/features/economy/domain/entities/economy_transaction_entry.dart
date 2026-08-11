import '../../../../core/domain/domain_enums.dart';
import '../../../../core/identifiers/entity_id.dart';

final class EconomyTransactionEntry {
  const EconomyTransactionEntry({
    required this.id,
    required this.transactionType,
    required this.amount,
    required this.balanceAfter,
    required this.relatedCardId,
    required this.relatedCardName,
    required this.relatedPackTypeId,
    required this.relatedPackTypeName,
    required this.createdAtUtc,
  });

  final CoinTransactionId id;
  final CoinTransactionType transactionType;
  final int amount;
  final int balanceAfter;
  final CardId? relatedCardId;
  final String? relatedCardName;
  final PackTypeId? relatedPackTypeId;
  final String? relatedPackTypeName;
  final DateTime createdAtUtc;
}
