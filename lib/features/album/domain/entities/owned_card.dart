import '../../../../core/domain/domain_validation.dart';
import '../../../../core/identifiers/entity_id.dart';

final class OwnedCard {
  OwnedCard({
    required this.installedCollectionId,
    required this.cardId,
    required int quantity,
    required DateTime firstObtainedAtUtc,
    required DateTime lastObtainedAtUtc,
    required this.isFavorite,
  }) : quantity = DomainValidation.requirePositive(quantity, 'quantity'),
       firstObtainedAtUtc = DomainValidation.requireUtc(
         firstObtainedAtUtc,
         'firstObtainedAtUtc',
       ),
       lastObtainedAtUtc = DomainValidation.requireUtc(
         lastObtainedAtUtc,
         'lastObtainedAtUtc',
       );

  final InstalledCollectionId installedCollectionId;
  final CardId cardId;
  final int quantity;
  final DateTime firstObtainedAtUtc;
  final DateTime lastObtainedAtUtc;
  final bool isFavorite;
}
