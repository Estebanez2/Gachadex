import 'package:flutter/material.dart';

import '../value_objects/pack_visual_style.dart';

final class PackColorOption {
  const PackColorOption({required this.id, required this.colorValue});

  final String id;
  final int colorValue;
}

final class PackIconOption {
  const PackIconOption({required this.id});

  final String id;
}

final class PackPatternOption {
  const PackPatternOption({required this.id});

  final String id;
}

abstract final class PackVisualCatalog {
  static const defaultColorId = 'teal';
  static const defaultAccentColorId = 'amber';
  static const defaultIconId = 'spark';
  static const defaultPatternId = 'diagonal';

  static final defaultFrontStyle = PackVisualStyle(
    colorId: defaultColorId,
    accentColorId: defaultAccentColorId,
    iconId: defaultIconId,
    patternId: defaultPatternId,
  );

  static final defaultBackStyle = PackVisualStyle(
    colorId: 'ink',
    accentColorId: 'rose',
    iconId: 'cards',
    patternId: 'dots',
  );

  static const colors = [
    PackColorOption(id: 'teal', colorValue: 0xFF00796B),
    PackColorOption(id: 'amber', colorValue: 0xFFF9A825),
    PackColorOption(id: 'rose', colorValue: 0xFFC2185B),
    PackColorOption(id: 'indigo', colorValue: 0xFF3949AB),
    PackColorOption(id: 'ink', colorValue: 0xFF263238),
    PackColorOption(id: 'lime', colorValue: 0xFF689F38),
  ];

  static const icons = [
    PackIconOption(id: 'spark'),
    PackIconOption(id: 'cards'),
    PackIconOption(id: 'star'),
    PackIconOption(id: 'bolt'),
  ];

  static const patterns = [
    PackPatternOption(id: 'diagonal'),
    PackPatternOption(id: 'dots'),
    PackPatternOption(id: 'frame'),
  ];

  static int colorValueForId(String id) {
    return colors
        .firstWhere((option) => option.id == id, orElse: () => colors.first)
        .colorValue;
  }

  static IconData iconForId(String id) {
    return switch (id) {
      'cards' => Icons.style_outlined,
      'star' => Icons.star_outline,
      'bolt' => Icons.bolt_outlined,
      _ => Icons.auto_awesome_outlined,
    };
  }
}
