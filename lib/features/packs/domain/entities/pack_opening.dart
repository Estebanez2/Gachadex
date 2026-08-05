import '../../../../core/domain/domain_enums.dart';
import '../../../../core/domain/domain_validation.dart';
import '../../../../core/identifiers/entity_id.dart';

final class PackOpening {
  PackOpening({
    required this.id,
    required this.installedCollectionId,
    required this.packTypeId,
    required this.status,
    required DateTime generatedAtUtc,
    required DateTime? completedAtUtc,
  }) : generatedAtUtc = DomainValidation.requireUtc(
         generatedAtUtc,
         'generatedAtUtc',
       ),
       completedAtUtc = DomainValidation.optionalUtc(
         completedAtUtc,
         'completedAtUtc',
       );

  final PackOpeningId id;
  final InstalledCollectionId installedCollectionId;
  final PackTypeId packTypeId;
  final PackOpeningStatus status;
  final DateTime generatedAtUtc;
  final DateTime? completedAtUtc;
}
