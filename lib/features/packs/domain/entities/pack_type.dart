import '../../../../core/domain/domain_validation.dart';
import '../../../../core/identifiers/entity_id.dart';

final class PackType {
  PackType({
    required this.id,
    required this.collectionId,
    required this.contentVersionId,
    required String name,
    required String? description,
    required this.frontAssetId,
    required this.backAssetId,
    required int cardCount,
    required int rechargeSeconds,
    required int maxAccumulated,
    required this.isMain,
    required int coinsPerFullRecharge,
    required int sortIndex,
  }) : name = DomainValidation.requireTrimmedNotEmpty(name, 'name'),
       description = DomainValidation.optionalTrimmed(description),
       cardCount = DomainValidation.requirePositive(cardCount, 'cardCount'),
       rechargeSeconds = DomainValidation.requirePositive(
         rechargeSeconds,
         'rechargeSeconds',
       ),
       maxAccumulated = DomainValidation.requirePositive(
         maxAccumulated,
         'maxAccumulated',
       ),
       coinsPerFullRecharge = DomainValidation.requireNonNegative(
         coinsPerFullRecharge,
         'coinsPerFullRecharge',
       ),
       sortIndex = DomainValidation.requireNonNegative(sortIndex, 'sortIndex');

  final PackTypeId id;
  final CollectionId collectionId;
  final ContentVersionId contentVersionId;
  final String name;
  final String? description;
  final MediaAssetId? frontAssetId;
  final MediaAssetId? backAssetId;
  final int cardCount;
  final int rechargeSeconds;
  final int maxAccumulated;
  final bool isMain;
  final int coinsPerFullRecharge;
  final int sortIndex;
}
