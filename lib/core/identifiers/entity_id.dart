abstract base class EntityId {
  EntityId(String value) : value = _normalize(value);

  final String value;

  String toJson() => value;

  @override
  String toString() => value;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == runtimeType &&
        other is EntityId &&
        other.value == value;
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  static final RegExp _uuidPattern = RegExp(
    r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
  );

  static String _normalize(String rawValue) {
    final value = rawValue.trim().toLowerCase();
    if (value.isEmpty) {
      throw FormatException('UUID must not be empty.');
    }

    if (value == '00000000-0000-0000-0000-000000000000') {
      throw FormatException('UUID must not be nil.');
    }

    if (!_uuidPattern.hasMatch(value)) {
      throw FormatException('Invalid UUID: $rawValue');
    }

    return value;
  }
}

final class CollectionId extends EntityId {
  CollectionId(super.value);
}

final class CollectionProjectId extends EntityId {
  CollectionProjectId(super.value);
}

final class ContentVersionId extends EntityId {
  ContentVersionId(super.value);
}

final class InstalledCollectionId extends EntityId {
  InstalledCollectionId(super.value);
}

final class RarityId extends EntityId {
  RarityId(super.value);
}

final class CardId extends EntityId {
  CardId(super.value);
}

final class CardFieldValueId extends EntityId {
  CardFieldValueId(super.value);
}

final class MediaAssetId extends EntityId {
  MediaAssetId(super.value);
}

final class PackTypeId extends EntityId {
  PackTypeId(super.value);
}

final class PackSlotRuleId extends EntityId {
  PackSlotRuleId(super.value);
}

final class ProbabilityGroupId extends EntityId {
  ProbabilityGroupId(super.value);
}

final class PackOpeningId extends EntityId {
  PackOpeningId(super.value);
}

final class CoinTransactionId extends EntityId {
  CoinTransactionId(super.value);
}
