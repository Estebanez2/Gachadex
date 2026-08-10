import '../../../../core/domain/domain_validation.dart';

final class PackVisualStyle {
  PackVisualStyle({
    required String colorId,
    required String accentColorId,
    required String iconId,
    required String patternId,
  }) : colorId = DomainValidation.requireTrimmedNotEmpty(colorId, 'colorId'),
       accentColorId = DomainValidation.requireTrimmedNotEmpty(
         accentColorId,
         'accentColorId',
       ),
       iconId = DomainValidation.requireTrimmedNotEmpty(iconId, 'iconId'),
       patternId = DomainValidation.requireTrimmedNotEmpty(
         patternId,
         'patternId',
       );

  final String colorId;
  final String accentColorId;
  final String iconId;
  final String patternId;

  PackVisualStyle copyWith({
    String? colorId,
    String? accentColorId,
    String? iconId,
    String? patternId,
  }) {
    return PackVisualStyle(
      colorId: colorId ?? this.colorId,
      accentColorId: accentColorId ?? this.accentColorId,
      iconId: iconId ?? this.iconId,
      patternId: patternId ?? this.patternId,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PackVisualStyle &&
        other.colorId == colorId &&
        other.accentColorId == accentColorId &&
        other.iconId == iconId &&
        other.patternId == patternId;
  }

  @override
  int get hashCode => Object.hash(colorId, accentColorId, iconId, patternId);
}
