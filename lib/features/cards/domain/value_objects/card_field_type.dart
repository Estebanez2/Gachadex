final class CardFieldType {
  const CardFieldType._(this.id);

  final String id;

  static const attackName = CardFieldType._('attackName');
  static const attackDescription = CardFieldType._('attackDescription');
  static const favoriteSnack = CardFieldType._('favoriteSnack');
  static const catchphrase = CardFieldType._('catchphrase');
  static const insideJoke = CardFieldType._('insideJoke');
  static const weakness = CardFieldType._('weakness');
  static const resistance = CardFieldType._('resistance');
  static const specialSkill = CardFieldType._('specialSkill');

  static const List<CardFieldType> values = [
    attackName,
    attackDescription,
    favoriteSnack,
    catchphrase,
    insideJoke,
    weakness,
    resistance,
    specialSkill,
  ];

  static CardFieldType parse(String id) {
    for (final value in values) {
      if (value.id == id) {
        return value;
      }
    }

    throw FormatException('Unknown card field type: $id');
  }

  @override
  String toString() => id;

  @override
  bool operator ==(Object other) {
    return other is CardFieldType && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
