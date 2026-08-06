final class CardFieldType {
  const CardFieldType._(this.id);

  final String id;

  static const nickname = CardFieldType._('nickname');
  static const specialAbility = CardFieldType._('special_ability');
  static const attack = CardFieldType._('attack');
  static const weakness = CardFieldType._('weakness');
  static const famousQuote = CardFieldType._('famous_quote');
  static const dangerLevel = CardFieldType._('danger_level');
  static const embarrassmentLevel = CardFieldType._('embarrassment_level');
  static const intelligence = CardFieldType._('intelligence');
  static const luck = CardFieldType._('luck');
  static const resistance = CardFieldType._('resistance');
  static const charisma = CardFieldType._('charisma');
  static const punctuality = CardFieldType._('punctuality');
  static const secretPower = CardFieldType._('secret_power');
  static const favoriteObject = CardFieldType._('favorite_object');
  static const legendaryMoment = CardFieldType._('legendary_moment');
  static const team = CardFieldType._('team');
  static const location = CardFieldType._('location');
  static const customDescription = CardFieldType._('custom_description');

  static const List<CardFieldType> values = [
    nickname,
    specialAbility,
    attack,
    weakness,
    famousQuote,
    dangerLevel,
    embarrassmentLevel,
    intelligence,
    luck,
    resistance,
    charisma,
    punctuality,
    secretPower,
    favoriteObject,
    legendaryMoment,
    team,
    location,
    customDescription,
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
