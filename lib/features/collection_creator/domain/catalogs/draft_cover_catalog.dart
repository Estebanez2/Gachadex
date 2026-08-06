final class DraftCoverColorOption {
  const DraftCoverColorOption({
    required this.id,
    required this.colorValue,
    required this.prefersDarkText,
  });

  final String id;
  final int colorValue;
  final bool prefersDarkText;
}

final class DraftCoverIconOption {
  const DraftCoverIconOption({required this.id});

  final String id;
}

final class DraftCoverPatternOption {
  const DraftCoverPatternOption({required this.id});

  final String id;
}

abstract final class DraftCoverCatalog {
  static const defaultBackgroundColorId = 'cover_teal';
  static const defaultAccentColorId = 'cover_gold';
  static const defaultIconId = 'cover_icon_spark';
  static const defaultPatternId = 'cover_pattern_solid';

  static const colors = [
    DraftCoverColorOption(
      id: 'cover_teal',
      colorValue: 0xFF008577,
      prefersDarkText: false,
    ),
    DraftCoverColorOption(
      id: 'cover_coral',
      colorValue: 0xFFB45A4D,
      prefersDarkText: false,
    ),
    DraftCoverColorOption(
      id: 'cover_gold',
      colorValue: 0xFFE4B83F,
      prefersDarkText: true,
    ),
    DraftCoverColorOption(
      id: 'cover_lilac',
      colorValue: 0xFF7E6AAE,
      prefersDarkText: false,
    ),
    DraftCoverColorOption(
      id: 'cover_sky',
      colorValue: 0xFF3B82B8,
      prefersDarkText: false,
    ),
    DraftCoverColorOption(
      id: 'cover_mint',
      colorValue: 0xFF6BAA75,
      prefersDarkText: true,
    ),
    DraftCoverColorOption(
      id: 'cover_rose',
      colorValue: 0xFFC05A87,
      prefersDarkText: false,
    ),
    DraftCoverColorOption(
      id: 'cover_graphite',
      colorValue: 0xFF30353A,
      prefersDarkText: false,
    ),
  ];

  static const icons = [
    DraftCoverIconOption(id: 'cover_icon_spark'),
    DraftCoverIconOption(id: 'cover_icon_cards'),
    DraftCoverIconOption(id: 'cover_icon_laugh'),
    DraftCoverIconOption(id: 'cover_icon_camera'),
    DraftCoverIconOption(id: 'cover_icon_group'),
    DraftCoverIconOption(id: 'cover_icon_trophy'),
  ];

  static const patterns = [
    DraftCoverPatternOption(id: 'cover_pattern_solid'),
    DraftCoverPatternOption(id: 'cover_pattern_diagonal'),
    DraftCoverPatternOption(id: 'cover_pattern_dots'),
    DraftCoverPatternOption(id: 'cover_pattern_split'),
  ];

  static bool isColorId(String id) {
    return colors.any((option) => option.id == id);
  }

  static bool isIconId(String id) {
    return icons.any((option) => option.id == id);
  }

  static bool isPatternId(String id) {
    return patterns.any((option) => option.id == id);
  }

  static DraftCoverColorOption colorById(String id) {
    return colors.firstWhere(
      (option) => option.id == id,
      orElse: () => throw ArgumentError.value(id, 'id', 'Unknown color id.'),
    );
  }

  static String requireColorId(String id, String fieldName) {
    final trimmed = id.trim();
    if (!isColorId(trimmed)) {
      throw ArgumentError.value(id, fieldName, 'Unknown cover color id.');
    }

    return trimmed;
  }

  static String requireIconId(String id, String fieldName) {
    final trimmed = id.trim();
    if (!isIconId(trimmed)) {
      throw ArgumentError.value(id, fieldName, 'Unknown cover icon id.');
    }

    return trimmed;
  }

  static String requirePatternId(String id, String fieldName) {
    final trimmed = id.trim();
    if (!isPatternId(trimmed)) {
      throw ArgumentError.value(id, fieldName, 'Unknown cover pattern id.');
    }

    return trimmed;
  }
}
