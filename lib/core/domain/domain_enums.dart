enum CollectionProjectStatus {
  draft('draft'),
  finalized('finalized');

  const CollectionProjectStatus(this.storageValue);

  final String storageValue;

  static CollectionProjectStatus fromStorage(String value) => switch (value) {
    'draft' => draft,
    'finalized' => finalized,
    _ => throw FormatException('Unknown collection project status: $value'),
  };
}

enum InstalledCollectionSource {
  createdLocally('createdLocally'),
  imported('imported');

  const InstalledCollectionSource(this.storageValue);

  final String storageValue;

  static InstalledCollectionSource fromStorage(String value) => switch (value) {
    'createdLocally' => createdLocally,
    'imported' => imported,
    _ => throw FormatException('Unknown installed collection source: $value'),
  };
}

enum MediaType {
  image('image'),
  video('video');

  const MediaType(this.storageValue);

  final String storageValue;

  static MediaType fromStorage(String value) => switch (value) {
    'image' => image,
    'video' => video,
    _ => throw FormatException('Unknown media type: $value'),
  };
}

enum MediaOwnerType {
  collectionProject('collectionProject'),
  card('card'),
  packType('packType');

  const MediaOwnerType(this.storageValue);

  final String storageValue;

  static MediaOwnerType fromStorage(String value) => switch (value) {
    'collectionProject' => collectionProject,
    'card' => card,
    'packType' => packType,
    _ => throw FormatException('Unknown media owner type: $value'),
  };
}

enum PackSlotRuleType {
  fixedRarity('fixedRarity'),
  probabilityDistribution('probabilityDistribution'),
  minimumRarity('minimumRarity');

  const PackSlotRuleType(this.storageValue);

  final String storageValue;

  static PackSlotRuleType fromStorage(String value) => switch (value) {
    'fixedRarity' => fixedRarity,
    'probabilityDistribution' => probabilityDistribution,
    'minimumRarity' => minimumRarity,
    _ => throw FormatException('Unknown pack slot rule type: $value'),
  };
}

enum PackOpeningStatus {
  generated('generated'),
  revealing('revealing'),
  completed('completed');

  const PackOpeningStatus(this.storageValue);

  final String storageValue;

  static PackOpeningStatus fromStorage(String value) => switch (value) {
    'generated' => generated,
    'revealing' => revealing,
    'completed' => completed,
    _ => throw FormatException('Unknown pack opening status: $value'),
  };
}

enum CoinTransactionType {
  sellDuplicate('sellDuplicate'),
  accelerateTimer('accelerateTimer'),
  migration('migration'),
  manualAdjustment('manualAdjustment');

  const CoinTransactionType(this.storageValue);

  final String storageValue;

  static CoinTransactionType fromStorage(String value) => switch (value) {
    'sellDuplicate' => sellDuplicate,
    'accelerateTimer' => accelerateTimer,
    'migration' => migration,
    'manualAdjustment' => manualAdjustment,
    _ => throw FormatException('Unknown coin transaction type: $value'),
  };
}
