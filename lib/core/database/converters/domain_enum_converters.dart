import 'package:drift/drift.dart';

import '../../domain/domain_enums.dart';

final class CollectionProjectStatusConverter
    extends TypeConverter<CollectionProjectStatus, String> {
  const CollectionProjectStatusConverter();

  @override
  CollectionProjectStatus fromSql(String fromDb) {
    return CollectionProjectStatus.fromStorage(fromDb);
  }

  @override
  String toSql(CollectionProjectStatus value) => value.storageValue;
}

final class InstalledCollectionSourceConverter
    extends TypeConverter<InstalledCollectionSource, String> {
  const InstalledCollectionSourceConverter();

  @override
  InstalledCollectionSource fromSql(String fromDb) {
    return InstalledCollectionSource.fromStorage(fromDb);
  }

  @override
  String toSql(InstalledCollectionSource value) => value.storageValue;
}

final class MediaTypeConverter extends TypeConverter<MediaType, String> {
  const MediaTypeConverter();

  @override
  MediaType fromSql(String fromDb) => MediaType.fromStorage(fromDb);

  @override
  String toSql(MediaType value) => value.storageValue;
}

final class MediaOwnerTypeConverter
    extends TypeConverter<MediaOwnerType, String> {
  const MediaOwnerTypeConverter();

  @override
  MediaOwnerType fromSql(String fromDb) => MediaOwnerType.fromStorage(fromDb);

  @override
  String toSql(MediaOwnerType value) => value.storageValue;
}

final class PackSlotRuleTypeConverter
    extends TypeConverter<PackSlotRuleType, String> {
  const PackSlotRuleTypeConverter();

  @override
  PackSlotRuleType fromSql(String fromDb) {
    return PackSlotRuleType.fromStorage(fromDb);
  }

  @override
  String toSql(PackSlotRuleType value) => value.storageValue;
}

final class PackOpeningStatusConverter
    extends TypeConverter<PackOpeningStatus, String> {
  const PackOpeningStatusConverter();

  @override
  PackOpeningStatus fromSql(String fromDb) {
    return PackOpeningStatus.fromStorage(fromDb);
  }

  @override
  String toSql(PackOpeningStatus value) => value.storageValue;
}

final class CoinTransactionTypeConverter
    extends TypeConverter<CoinTransactionType, String> {
  const CoinTransactionTypeConverter();

  @override
  CoinTransactionType fromSql(String fromDb) {
    return CoinTransactionType.fromStorage(fromDb);
  }

  @override
  String toSql(CoinTransactionType value) => value.storageValue;
}
