import '../../../../core/domain/domain_validation.dart';
import '../../../../core/identifiers/entity_id.dart';

final class Rarity {
  Rarity({
    required this.id,
    required this.collectionId,
    required this.contentVersionId,
    required String name,
    required int orderIndex,
    required this.colorValue,
    required String iconId,
    required String frameId,
    required String? effectId,
    required int sellValue,
    required this.isEnabled,
  }) : name = DomainValidation.requireTrimmedNotEmpty(name, 'name'),
       orderIndex = DomainValidation.requireNonNegative(
         orderIndex,
         'orderIndex',
       ),
       iconId = DomainValidation.requireTrimmedNotEmpty(iconId, 'iconId'),
       frameId = DomainValidation.requireTrimmedNotEmpty(frameId, 'frameId'),
       effectId = DomainValidation.optionalTrimmed(effectId),
       sellValue = DomainValidation.requireNonNegative(sellValue, 'sellValue');

  final RarityId id;
  final CollectionId collectionId;
  final ContentVersionId contentVersionId;
  final String name;
  final int orderIndex;
  final int colorValue;
  final String iconId;
  final String frameId;
  final String? effectId;
  final int sellValue;
  final bool isEnabled;

  Rarity copyWith({
    String? name,
    int? orderIndex,
    int? colorValue,
    String? iconId,
    String? frameId,
    String? effectId,
    int? sellValue,
    bool? isEnabled,
  }) {
    return Rarity(
      id: id,
      collectionId: collectionId,
      contentVersionId: contentVersionId,
      name: name ?? this.name,
      orderIndex: orderIndex ?? this.orderIndex,
      colorValue: colorValue ?? this.colorValue,
      iconId: iconId ?? this.iconId,
      frameId: frameId ?? this.frameId,
      effectId: effectId ?? this.effectId,
      sellValue: sellValue ?? this.sellValue,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}
