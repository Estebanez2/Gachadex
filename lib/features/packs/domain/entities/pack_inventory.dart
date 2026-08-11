import '../../../../core/domain/domain_validation.dart';
import '../../../../core/identifiers/entity_id.dart';

final class PackInventory {
  PackInventory({
    required this.installedCollectionId,
    required this.packTypeId,
    required int availableCount,
    required int maxAccumulated,
    required DateTime nextRechargeAtUtc,
    required DateTime lastCalculatedAtUtc,
  }) : availableCount = DomainValidation.requireNonNegative(
         availableCount,
         'availableCount',
       ),
       maxAccumulated = DomainValidation.requirePositive(
         maxAccumulated,
         'maxAccumulated',
       ),
       nextRechargeAtUtc = DomainValidation.requireUtc(
         nextRechargeAtUtc,
         'nextRechargeAtUtc',
       ),
       lastCalculatedAtUtc = DomainValidation.requireUtc(
         lastCalculatedAtUtc,
         'lastCalculatedAtUtc',
       );

  final InstalledCollectionId installedCollectionId;
  final PackTypeId packTypeId;
  final int availableCount;
  final int maxAccumulated;
  final DateTime nextRechargeAtUtc;
  final DateTime lastCalculatedAtUtc;
}
