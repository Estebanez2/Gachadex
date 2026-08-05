import 'package:uuid/uuid.dart';

import 'entity_id.dart';

abstract interface class UuidGenerator {
  String generate();
}

final class SystemUuidGenerator implements UuidGenerator {
  const SystemUuidGenerator();

  static const _uuid = Uuid();

  @override
  String generate() => _uuid.v4();
}

final class FixedUuidGenerator implements UuidGenerator {
  FixedUuidGenerator(Iterable<String> values) : _values = values.iterator;

  final Iterator<String> _values;

  @override
  String generate() {
    if (!_values.moveNext()) {
      throw StateError('No UUID values left in FixedUuidGenerator.');
    }

    return _values.current;
  }
}

extension UuidGeneratorEntityIds on UuidGenerator {
  CollectionId collectionId() => CollectionId(generate());

  CollectionProjectId collectionProjectId() => CollectionProjectId(generate());

  ContentVersionId contentVersionId() => ContentVersionId(generate());

  InstalledCollectionId installedCollectionId() =>
      InstalledCollectionId(generate());

  RarityId rarityId() => RarityId(generate());

  CardId cardId() => CardId(generate());

  CardFieldValueId cardFieldValueId() => CardFieldValueId(generate());

  MediaAssetId mediaAssetId() => MediaAssetId(generate());

  PackTypeId packTypeId() => PackTypeId(generate());

  PackSlotRuleId packSlotRuleId() => PackSlotRuleId(generate());

  ProbabilityGroupId probabilityGroupId() => ProbabilityGroupId(generate());

  PackOpeningId packOpeningId() => PackOpeningId(generate());

  CoinTransactionId coinTransactionId() => CoinTransactionId(generate());
}
