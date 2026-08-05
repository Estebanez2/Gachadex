import '../../../../core/domain/domain_enums.dart';
import '../../../../core/domain/domain_validation.dart';
import '../../../../core/identifiers/entity_id.dart';

final class Card {
  Card({
    required this.id,
    required this.collectionId,
    required this.contentVersionId,
    required int collectionNumber,
    required String name,
    required int health,
    required this.rarityId,
    required this.mediaAssetId,
    required this.mediaType,
    required this.thumbnailAssetId,
    required String templateId,
    required String frameId,
    required this.primaryColor,
    required this.secondaryColor,
    required String? description,
    required int sortIndex,
    required DateTime createdAtUtc,
  }) : collectionNumber = DomainValidation.requireNonNegative(
         collectionNumber,
         'collectionNumber',
       ),
       name = DomainValidation.requireTrimmedNotEmpty(name, 'name'),
       health = DomainValidation.requireMax(
         DomainValidation.requirePositive(health, 'health'),
         9999,
         'health',
       ),
       templateId = DomainValidation.requireTrimmedNotEmpty(
         templateId,
         'templateId',
       ),
       frameId = DomainValidation.requireTrimmedNotEmpty(frameId, 'frameId'),
       description = DomainValidation.optionalTrimmed(description),
       sortIndex = DomainValidation.requireNonNegative(sortIndex, 'sortIndex'),
       createdAtUtc = DomainValidation.requireUtc(createdAtUtc, 'createdAtUtc');

  final CardId id;
  final CollectionId collectionId;
  final ContentVersionId contentVersionId;
  final int collectionNumber;
  final String name;
  final int health;
  final RarityId rarityId;
  final MediaAssetId mediaAssetId;
  final MediaType mediaType;
  final MediaAssetId? thumbnailAssetId;
  final String templateId;
  final String frameId;
  final int primaryColor;
  final int secondaryColor;
  final String? description;
  final int sortIndex;
  final DateTime createdAtUtc;
}
