import '../../../../core/domain/domain_validation.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../catalogs/pack_visual_catalog.dart';
import '../value_objects/pack_visual_style.dart';

final class PackType {
  PackType({
    required this.id,
    required this.collectionId,
    required this.contentVersionId,
    required String name,
    required String? description,
    required this.frontAssetId,
    required this.backAssetId,
    PackVisualStyle? frontStyle,
    PackVisualStyle? backStyle,
    required int cardCount,
    required int rechargeSeconds,
    required int maxAccumulated,
    required this.isMain,
    required int coinsPerFullRecharge,
    required int sortIndex,
  }) : name = DomainValidation.requireTrimmedNotEmpty(name, 'name'),
       description = DomainValidation.optionalTrimmed(description),
       frontStyle = frontStyle ?? PackVisualCatalog.defaultFrontStyle,
       backStyle = backStyle ?? PackVisualCatalog.defaultBackStyle,
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
  final PackVisualStyle frontStyle;
  final PackVisualStyle backStyle;
  final int cardCount;
  final int rechargeSeconds;
  final int maxAccumulated;
  final bool isMain;
  final int coinsPerFullRecharge;
  final int sortIndex;
}
