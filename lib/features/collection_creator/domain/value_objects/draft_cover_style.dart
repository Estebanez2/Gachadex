import '../catalogs/draft_cover_catalog.dart';

final class DraftCoverStyle {
  DraftCoverStyle({
    required String backgroundColorId,
    required String accentColorId,
    required String iconId,
    required String patternId,
  }) : backgroundColorId = DraftCoverCatalog.requireColorId(
         backgroundColorId,
         'backgroundColorId',
       ),
       accentColorId = DraftCoverCatalog.requireColorId(
         accentColorId,
         'accentColorId',
       ),
       iconId = DraftCoverCatalog.requireIconId(iconId, 'iconId'),
       patternId = DraftCoverCatalog.requirePatternId(patternId, 'patternId');

  factory DraftCoverStyle.defaultStyle() {
    return DraftCoverStyle(
      backgroundColorId: DraftCoverCatalog.defaultBackgroundColorId,
      accentColorId: DraftCoverCatalog.defaultAccentColorId,
      iconId: DraftCoverCatalog.defaultIconId,
      patternId: DraftCoverCatalog.defaultPatternId,
    );
  }

  final String backgroundColorId;
  final String accentColorId;
  final String iconId;
  final String patternId;

  DraftCoverStyle copyWith({
    String? backgroundColorId,
    String? accentColorId,
    String? iconId,
    String? patternId,
  }) {
    return DraftCoverStyle(
      backgroundColorId: backgroundColorId ?? this.backgroundColorId,
      accentColorId: accentColorId ?? this.accentColorId,
      iconId: iconId ?? this.iconId,
      patternId: patternId ?? this.patternId,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is DraftCoverStyle &&
            other.backgroundColorId == backgroundColorId &&
            other.accentColorId == accentColorId &&
            other.iconId == iconId &&
            other.patternId == patternId;
  }

  @override
  int get hashCode =>
      Object.hash(backgroundColorId, accentColorId, iconId, patternId);
}
