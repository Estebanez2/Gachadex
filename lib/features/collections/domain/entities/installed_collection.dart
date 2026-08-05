import '../../../../core/domain/domain_enums.dart';
import '../../../../core/domain/domain_validation.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../../../../core/value_objects/relative_media_path.dart';

final class InstalledCollection {
  InstalledCollection({
    required this.id,
    required this.collectionId,
    required this.contentVersionId,
    required String name,
    required String? author,
    required String? description,
    required this.coverRelativePath,
    required this.mainPackTypeId,
    required DateTime installedAtUtc,
    required this.source,
    required int coins,
    required int totalCardCount,
    required int distinctOwnedCount,
  }) : name = DomainValidation.requireTrimmedNotEmpty(name, 'name'),
       author = DomainValidation.optionalTrimmed(author),
       description = DomainValidation.optionalTrimmed(description),
       installedAtUtc = DomainValidation.requireUtc(
         installedAtUtc,
         'installedAtUtc',
       ),
       coins = DomainValidation.requireNonNegative(coins, 'coins'),
       totalCardCount = DomainValidation.requireNonNegative(
         totalCardCount,
         'totalCardCount',
       ),
       distinctOwnedCount = DomainValidation.requireNonNegative(
         distinctOwnedCount,
         'distinctOwnedCount',
       );

  final InstalledCollectionId id;
  final CollectionId collectionId;
  final ContentVersionId contentVersionId;
  final String name;
  final String? author;
  final String? description;
  final RelativeMediaPath? coverRelativePath;
  final PackTypeId? mainPackTypeId;
  final DateTime installedAtUtc;
  final InstalledCollectionSource source;
  final int coins;
  final int totalCardCount;
  final int distinctOwnedCount;
}
