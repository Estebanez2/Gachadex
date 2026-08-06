import '../value_objects/card_field_type.dart';

final class CardTemplate {
  const CardTemplate({
    required this.id,
    required this.name,
    required this.aspectRatioWidth,
    required this.aspectRatioHeight,
    required this.maxComicFields,
    required this.maxComicFieldLength,
  });

  final String id;
  final String name;
  final double aspectRatioWidth;
  final double aspectRatioHeight;
  final int maxComicFields;
  final int maxComicFieldLength;

  double get aspectRatio => aspectRatioWidth / aspectRatioHeight;
}

final class CardFrame {
  const CardFrame({required this.id, required this.name});

  final String id;
  final String name;
}

final class CardColorOption {
  const CardColorOption({required this.id, required this.value});

  final String id;
  final int value;
}

final class CardFieldOption {
  const CardFieldOption({required this.type, required this.label});

  final CardFieldType type;
  final String label;
}

abstract final class CardTemplateCatalog {
  static const maxNameLength = 60;
  static const maxDescriptionLength = 500;
  static const defaultTemplateId = 'classic';
  static const defaultFrameId = 'clean';
  static const defaultPrimaryColor = 0xFF0F766E;
  static const defaultSecondaryColor = 0xFFF59E0B;

  static const templates = [
    CardTemplate(
      id: 'classic',
      name: 'Clasica',
      aspectRatioWidth: 2.5,
      aspectRatioHeight: 3.5,
      maxComicFields: 4,
      maxComicFieldLength: 48,
    ),
    CardTemplate(
      id: 'comic',
      name: 'Comica',
      aspectRatioWidth: 2.5,
      aspectRatioHeight: 3.5,
      maxComicFields: 5,
      maxComicFieldLength: 42,
    ),
    CardTemplate(
      id: 'minimal',
      name: 'Minimalista',
      aspectRatioWidth: 2.5,
      aspectRatioHeight: 3.5,
      maxComicFields: 3,
      maxComicFieldLength: 56,
    ),
    CardTemplate(
      id: 'impact',
      name: 'Impacto',
      aspectRatioWidth: 2.5,
      aspectRatioHeight: 3.5,
      maxComicFields: 3,
      maxComicFieldLength: 40,
    ),
  ];

  static const frames = [
    CardFrame(id: 'clean', name: 'Limpio'),
    CardFrame(id: 'badge', name: 'Insignia'),
    CardFrame(id: 'comic_lines', name: 'Lineas comicas'),
    CardFrame(id: 'snapshot', name: 'Instantanea'),
  ];

  static const colors = [
    CardColorOption(id: 'teal', value: 0xFF0F766E),
    CardColorOption(id: 'coral', value: 0xFFE11D48),
    CardColorOption(id: 'gold', value: 0xFFF59E0B),
    CardColorOption(id: 'indigo', value: 0xFF4F46E5),
    CardColorOption(id: 'lime', value: 0xFF65A30D),
    CardColorOption(id: 'graphite', value: 0xFF334155),
  ];

  static const fieldOptions = [
    CardFieldOption(type: CardFieldType.nickname, label: 'Apodo'),
    CardFieldOption(
      type: CardFieldType.specialAbility,
      label: 'Habilidad especial',
    ),
    CardFieldOption(type: CardFieldType.attack, label: 'Ataque'),
    CardFieldOption(type: CardFieldType.weakness, label: 'Debilidad'),
    CardFieldOption(type: CardFieldType.famousQuote, label: 'Frase celebre'),
    CardFieldOption(type: CardFieldType.dangerLevel, label: 'Nivel de peligro'),
    CardFieldOption(
      type: CardFieldType.embarrassmentLevel,
      label: 'Nivel de verguenza',
    ),
    CardFieldOption(type: CardFieldType.intelligence, label: 'Inteligencia'),
    CardFieldOption(type: CardFieldType.luck, label: 'Suerte'),
    CardFieldOption(type: CardFieldType.resistance, label: 'Resistencia'),
    CardFieldOption(type: CardFieldType.charisma, label: 'Carisma'),
    CardFieldOption(type: CardFieldType.punctuality, label: 'Puntualidad'),
    CardFieldOption(type: CardFieldType.secretPower, label: 'Poder secreto'),
    CardFieldOption(
      type: CardFieldType.favoriteObject,
      label: 'Objeto favorito',
    ),
    CardFieldOption(
      type: CardFieldType.legendaryMoment,
      label: 'Momento legendario',
    ),
    CardFieldOption(type: CardFieldType.team, label: 'Equipo'),
    CardFieldOption(type: CardFieldType.location, label: 'Lugar'),
    CardFieldOption(
      type: CardFieldType.customDescription,
      label: 'Descripcion personalizada',
    ),
  ];

  static CardTemplate templateById(String id) {
    return templates.firstWhere(
      (template) => template.id == id,
      orElse: () => templates.first,
    );
  }

  static bool containsTemplate(String id) {
    return templates.any((template) => template.id == id);
  }

  static bool containsFrame(String id) {
    return frames.any((frame) => frame.id == id);
  }

  static String labelForField(CardFieldType type) {
    return fieldOptions.firstWhere((option) => option.type == type).label;
  }
}
