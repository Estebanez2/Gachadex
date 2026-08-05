import '../../../../core/domain/domain_validation.dart';
import '../../../../core/identifiers/entity_id.dart';

final class ContentVersion {
  ContentVersion({
    required this.id,
    required this.collectionId,
    required int versionNumber,
    int formatVersion = 1,
    required DateTime createdAtUtc,
    required DateTime? finalizedAtUtc,
    required this.isCurrent,
  }) : versionNumber = DomainValidation.requirePositive(
         versionNumber,
         'versionNumber',
       ),
       formatVersion = DomainValidation.requirePositive(
         formatVersion,
         'formatVersion',
       ),
       createdAtUtc = DomainValidation.requireUtc(createdAtUtc, 'createdAtUtc'),
       finalizedAtUtc = DomainValidation.optionalUtc(
         finalizedAtUtc,
         'finalizedAtUtc',
       );

  final ContentVersionId id;
  final CollectionId collectionId;
  final int versionNumber;
  final int formatVersion;
  final DateTime createdAtUtc;
  final DateTime? finalizedAtUtc;
  final bool isCurrent;
}
