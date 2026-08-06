final class RarityColorOption {
  const RarityColorOption({
    required this.id,
    required this.colorValue,
    required this.prefersDarkText,
  });

  final String id;
  final int colorValue;
  final bool prefersDarkText;
}

final class RarityIconOption {
  const RarityIconOption({required this.id});

  final String id;
}

final class RarityFrameOption {
  const RarityFrameOption({required this.id});

  final String id;
}

final class RarityEffectOption {
  const RarityEffectOption({required this.id});

  final String id;
}

abstract final class RarityVisualCatalog {
  static const maxNameLength = 30;
  static const maxSellValue = 999999;

  static const defaultColorValue = 0xFF7A8087;
  static const defaultIconId = 'rarity_icon_star';
  static const defaultFrameId = 'rarity_frame_simple';
  static const defaultEffectId = 'rarity_effect_none';

  static const colors = [
    RarityColorOption(
      id: 'rarity_color_gray',
      colorValue: 0xFF7A8087,
      prefersDarkText: false,
    ),
    RarityColorOption(
      id: 'rarity_color_green',
      colorValue: 0xFF3E8E5B,
      prefersDarkText: false,
    ),
    RarityColorOption(
      id: 'rarity_color_blue',
      colorValue: 0xFF2F6FA8,
      prefersDarkText: false,
    ),
    RarityColorOption(
      id: 'rarity_color_purple',
      colorValue: 0xFF7B5AB6,
      prefersDarkText: false,
    ),
    RarityColorOption(
      id: 'rarity_color_red',
      colorValue: 0xFFBA4E55,
      prefersDarkText: false,
    ),
    RarityColorOption(
      id: 'rarity_color_orange',
      colorValue: 0xFFD77B32,
      prefersDarkText: true,
    ),
    RarityColorOption(
      id: 'rarity_color_pink',
      colorValue: 0xFFC45A92,
      prefersDarkText: false,
    ),
    RarityColorOption(
      id: 'rarity_color_gold',
      colorValue: 0xFFE2B844,
      prefersDarkText: true,
    ),
    RarityColorOption(
      id: 'rarity_color_turquoise',
      colorValue: 0xFF189C9A,
      prefersDarkText: false,
    ),
    RarityColorOption(
      id: 'rarity_color_graphite',
      colorValue: 0xFF2F3437,
      prefersDarkText: false,
    ),
  ];

  static const icons = [
    RarityIconOption(id: 'rarity_icon_star'),
    RarityIconOption(id: 'rarity_icon_crown'),
    RarityIconOption(id: 'rarity_icon_diamond'),
    RarityIconOption(id: 'rarity_icon_fire'),
    RarityIconOption(id: 'rarity_icon_bolt'),
    RarityIconOption(id: 'rarity_icon_rocket'),
    RarityIconOption(id: 'rarity_icon_glasses'),
    RarityIconOption(id: 'rarity_icon_trophy'),
    RarityIconOption(id: 'rarity_icon_ghost'),
    RarityIconOption(id: 'rarity_icon_footprint'),
    RarityIconOption(id: 'rarity_icon_smile'),
    RarityIconOption(id: 'rarity_icon_burst'),
    RarityIconOption(id: 'rarity_icon_heart'),
    RarityIconOption(id: 'rarity_icon_moon'),
    RarityIconOption(id: 'rarity_icon_sun'),
  ];

  static const frames = [
    RarityFrameOption(id: 'rarity_frame_simple'),
    RarityFrameOption(id: 'rarity_frame_rounded'),
    RarityFrameOption(id: 'rarity_frame_double'),
    RarityFrameOption(id: 'rarity_frame_metallic'),
    RarityFrameOption(id: 'rarity_frame_neon'),
    RarityFrameOption(id: 'rarity_frame_comic'),
    RarityFrameOption(id: 'rarity_frame_elegant'),
    RarityFrameOption(id: 'rarity_frame_pixel'),
  ];

  static const effects = [
    RarityEffectOption(id: 'rarity_effect_none'),
    RarityEffectOption(id: 'rarity_effect_soft_glow'),
    RarityEffectOption(id: 'rarity_effect_spark'),
    RarityEffectOption(id: 'rarity_effect_gradient'),
    RarityEffectOption(id: 'rarity_effect_holo'),
    RarityEffectOption(id: 'rarity_effect_pulse'),
  ];

  static bool isColorValue(int colorValue) {
    return colors.any((option) => option.colorValue == colorValue);
  }

  static bool isIconId(String id) {
    return icons.any((option) => option.id == id);
  }

  static bool isFrameId(String id) {
    return frames.any((option) => option.id == id);
  }

  static bool isEffectId(String id) {
    return effects.any((option) => option.id == id);
  }

  static RarityColorOption colorByValue(int colorValue) {
    return colors.firstWhere(
      (option) => option.colorValue == colorValue,
      orElse: () => throw ArgumentError.value(
        colorValue,
        'colorValue',
        'Unknown rarity color.',
      ),
    );
  }
}
