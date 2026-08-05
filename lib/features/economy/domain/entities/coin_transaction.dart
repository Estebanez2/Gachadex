import '../../../../core/domain/domain_enums.dart';
import '../../../../core/domain/domain_validation.dart';
import '../../../../core/identifiers/entity_id.dart';

final class CoinTransaction {
  CoinTransaction({
    required this.id,
    required this.installedCollectionId,
    required this.transactionType,
    required this.amount,
    required int balanceAfter,
    required this.relatedCardId,
    required this.relatedPackTypeId,
    required DateTime createdAtUtc,
    required String? metadataJson,
  }) : balanceAfter = DomainValidation.requireNonNegative(
         balanceAfter,
         'balanceAfter',
       ),
       createdAtUtc = DomainValidation.requireUtc(createdAtUtc, 'createdAtUtc'),
       metadataJson = DomainValidation.optionalTrimmed(metadataJson);

  final CoinTransactionId id;
  final InstalledCollectionId installedCollectionId;
  final CoinTransactionType transactionType;
  final int amount;
  final int balanceAfter;
  final CardId? relatedCardId;
  final PackTypeId? relatedPackTypeId;
  final DateTime createdAtUtc;
  final String? metadataJson;
}
