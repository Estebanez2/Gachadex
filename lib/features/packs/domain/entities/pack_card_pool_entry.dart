import '../../../../core/identifiers/entity_id.dart';

final class PackCardPoolEntry {
  const PackCardPoolEntry({
    required this.packTypeId,
    required this.cardId,
    required this.isEnabled,
  });

  final PackTypeId packTypeId;
  final CardId cardId;
  final bool isEnabled;
}
