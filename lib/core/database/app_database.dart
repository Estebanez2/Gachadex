import 'package:drift/drift.dart';

import '../database/converters/domain_enum_converters.dart';
import '../domain/domain_enums.dart';
import '../logging/app_logger.dart';
import '../../features/collection_creator/domain/catalogs/draft_cover_catalog.dart';
import '../../features/packs/domain/catalogs/pack_visual_catalog.dart';
import 'database_connection.dart';
import 'migrations/migration_strategy.dart';
import 'migrations/schema_versions.dart';

part 'app_database.g.dart';

@TableIndex(
  name: 'idx_collection_projects_collection_id',
  columns: {#collectionId},
  unique: true,
)
@DataClassName('CollectionProjectRow')
class CollectionProjects extends Table {
  TextColumn get id => text()();
  TextColumn get collectionId => text()();
  TextColumn get name => text()();
  TextColumn get author => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get coverAssetId => text()
      .references(MediaAssets, #id, onDelete: KeyAction.setNull)
      .nullable()();
  TextColumn get draftCoverColorId => text().withDefault(
    const Constant(DraftCoverCatalog.defaultBackgroundColorId),
  )();
  TextColumn get draftCoverAccentColorId => text().withDefault(
    const Constant(DraftCoverCatalog.defaultAccentColorId),
  )();
  TextColumn get draftCoverIconId =>
      text().withDefault(const Constant(DraftCoverCatalog.defaultIconId))();
  TextColumn get draftCoverPatternId =>
      text().withDefault(const Constant(DraftCoverCatalog.defaultPatternId))();
  TextColumn get status =>
      text().map(const CollectionProjectStatusConverter())();
  DateTimeColumn get createdAtUtc => dateTime()();
  DateTimeColumn get updatedAtUtc => dateTime()();
  IntColumn get currentContentVersion => integer()();
  TextColumn get currentContentVersionId => text()
      .references(ContentVersions, #id, onDelete: KeyAction.restrict)
      .nullable()();
  TextColumn get mainPackTypeId => text()
      .references(PackTypes, #id, onDelete: KeyAction.setNull)
      .nullable()();
  IntColumn get startingPackCount => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<String> get customConstraints => [
    'CHECK (current_content_version >= 1)',
    'CHECK (starting_pack_count >= 0)',
  ];
}

@TableIndex(
  name: 'idx_content_versions_collection_id',
  columns: {#collectionId},
)
@TableIndex.sql(
  'CREATE UNIQUE INDEX idx_content_versions_current '
  'ON content_versions(collection_id) WHERE is_current = 1',
)
@DataClassName('ContentVersionRow')
class ContentVersions extends Table {
  TextColumn get id => text()();
  TextColumn get collectionId => text()();
  IntColumn get versionNumber => integer()();
  IntColumn get formatVersion => integer()();
  DateTimeColumn get createdAtUtc => dateTime()();
  DateTimeColumn get finalizedAtUtc => dateTime().nullable()();
  BoolColumn get isCurrent => boolean()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {collectionId, versionNumber},
  ];

  @override
  List<String> get customConstraints => [
    'CHECK (version_number >= 1)',
    'CHECK (format_version >= 1)',
  ];
}

@TableIndex(
  name: 'idx_installed_collections_collection_id',
  columns: {#collectionId},
)
@DataClassName('InstalledCollectionRow')
class InstalledCollections extends Table {
  TextColumn get id => text()();
  TextColumn get collectionId => text()();
  TextColumn get contentVersionId =>
      text().references(ContentVersions, #id, onDelete: KeyAction.restrict)();
  TextColumn get name => text()();
  TextColumn get author => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get coverRelativePath => text().nullable()();
  TextColumn get mainPackTypeId => text()
      .references(PackTypes, #id, onDelete: KeyAction.setNull)
      .nullable()();
  DateTimeColumn get installedAtUtc => dateTime()();
  TextColumn get source =>
      text().map(const InstalledCollectionSourceConverter())();
  IntColumn get coins => integer()();
  IntColumn get totalCardCount => integer()();
  IntColumn get distinctOwnedCount => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {collectionId, contentVersionId},
  ];

  @override
  List<String> get customConstraints => [
    'CHECK (coins >= 0)',
    'CHECK (total_card_count >= 0)',
    'CHECK (distinct_owned_count >= 0)',
  ];
}

@TableIndex(
  name: 'idx_rarities_collection_version',
  columns: {#collectionId, #contentVersionId},
)
@DataClassName('RarityRow')
class Rarities extends Table {
  TextColumn get id => text()();
  TextColumn get collectionId => text()();
  TextColumn get contentVersionId =>
      text().references(ContentVersions, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()();
  IntColumn get orderIndex => integer()();
  IntColumn get colorValue => integer()();
  TextColumn get iconId => text()();
  TextColumn get frameId => text()();
  TextColumn get effectId => text().nullable()();
  IntColumn get sellValue => integer()();
  BoolColumn get isEnabled => boolean()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {contentVersionId, orderIndex},
    {contentVersionId, name},
  ];

  @override
  List<String> get customConstraints => [
    'CHECK (order_index >= 0)',
    'CHECK (sell_value >= 0)',
  ];
}

@TableIndex(
  name: 'idx_media_assets_collection_owner',
  columns: {#collectionId, #ownerType, #ownerId},
)
@DataClassName('MediaAssetRow')
class MediaAssets extends Table {
  TextColumn get id => text()();
  TextColumn get collectionId => text()();
  TextColumn get ownerType => text().map(const MediaOwnerTypeConverter())();
  TextColumn get ownerId => text()();
  TextColumn get mediaType => text().map(const MediaTypeConverter())();
  TextColumn get relativePath => text()();
  TextColumn get thumbnailRelativePath => text().nullable()();
  TextColumn get mimeType => text()();
  IntColumn get width => integer().nullable()();
  IntColumn get height => integer().nullable()();
  IntColumn get durationMs => integer().nullable()();
  IntColumn get fileSize => integer()();
  TextColumn get sha256 => text().nullable()();
  DateTimeColumn get createdAtUtc => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<String> get customConstraints => [
    'CHECK (file_size >= 0)',
    'CHECK (width IS NULL OR width > 0)',
    'CHECK (height IS NULL OR height > 0)',
    'CHECK (duration_ms IS NULL OR duration_ms > 0)',
  ];
}

@TableIndex(
  name: 'idx_cards_collection_version',
  columns: {#collectionId, #contentVersionId},
)
@TableIndex(name: 'idx_cards_rarity_id', columns: {#rarityId})
@DataClassName('CardRow')
class Cards extends Table {
  TextColumn get id => text()();
  TextColumn get collectionId => text()();
  TextColumn get contentVersionId =>
      text().references(ContentVersions, #id, onDelete: KeyAction.cascade)();
  IntColumn get collectionNumber => integer()();
  TextColumn get name => text()();
  IntColumn get health => integer()();
  TextColumn get rarityId =>
      text().references(Rarities, #id, onDelete: KeyAction.restrict)();
  @ReferenceName('primaryCards')
  TextColumn get mediaAssetId =>
      text().references(MediaAssets, #id, onDelete: KeyAction.restrict)();
  TextColumn get mediaType => text().map(const MediaTypeConverter())();
  @ReferenceName('thumbnailCards')
  TextColumn get thumbnailAssetId => text()
      .references(MediaAssets, #id, onDelete: KeyAction.setNull)
      .nullable()();
  TextColumn get templateId => text()();
  TextColumn get frameId => text()();
  IntColumn get primaryColor => integer()();
  IntColumn get secondaryColor => integer()();
  TextColumn get description => text().nullable()();
  IntColumn get sortIndex => integer()();
  DateTimeColumn get createdAtUtc => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {contentVersionId, collectionNumber},
  ];

  @override
  List<String> get customConstraints => [
    'CHECK (collection_number > 0)',
    'CHECK (health BETWEEN 1 AND 9999)',
    'CHECK (sort_index >= 0)',
  ];
}

@TableIndex(name: 'idx_card_field_values_card_id', columns: {#cardId})
@DataClassName('CardFieldValueRow')
class CardFieldValues extends Table {
  TextColumn get id => text()();
  TextColumn get cardId =>
      text().references(Cards, #id, onDelete: KeyAction.cascade)();
  TextColumn get fieldTypeId => text()();
  TextColumn get value => text()();
  IntColumn get displayOrder => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {cardId, fieldTypeId},
  ];

  @override
  List<String> get customConstraints => [
    'CHECK (display_order >= 0)',
    "CHECK (field_type_id IN ('nickname', 'special_ability', 'attack', "
        "'weakness', 'famous_quote', 'danger_level', "
        "'embarrassment_level', 'intelligence', 'luck', 'resistance', "
        "'charisma', 'punctuality', 'secret_power', 'favorite_object', "
        "'legendary_moment', 'team', 'location', 'custom_description'))",
  ];
}

@TableIndex(
  name: 'idx_pack_types_collection_version',
  columns: {#collectionId, #contentVersionId},
)
@TableIndex.sql(
  'CREATE UNIQUE INDEX idx_pack_types_main '
  'ON pack_types(content_version_id) WHERE is_main = 1',
)
@DataClassName('PackTypeRow')
class PackTypes extends Table {
  TextColumn get id => text()();
  TextColumn get collectionId => text()();
  TextColumn get contentVersionId =>
      text().references(ContentVersions, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  @ReferenceName('frontPackTypes')
  TextColumn get frontAssetId => text()
      .references(MediaAssets, #id, onDelete: KeyAction.setNull)
      .nullable()();
  @ReferenceName('backPackTypes')
  TextColumn get backAssetId => text()
      .references(MediaAssets, #id, onDelete: KeyAction.setNull)
      .nullable()();
  TextColumn get frontColorId =>
      text().withDefault(const Constant(PackVisualCatalog.defaultColorId))();
  TextColumn get frontAccentColorId => text().withDefault(
    const Constant(PackVisualCatalog.defaultAccentColorId),
  )();
  TextColumn get frontIconId =>
      text().withDefault(const Constant(PackVisualCatalog.defaultIconId))();
  TextColumn get frontPatternId =>
      text().withDefault(const Constant(PackVisualCatalog.defaultPatternId))();
  TextColumn get backColorId => text().withDefault(const Constant('ink'))();
  TextColumn get backAccentColorId =>
      text().withDefault(const Constant('rose'))();
  TextColumn get backIconId => text().withDefault(const Constant('cards'))();
  TextColumn get backPatternId => text().withDefault(const Constant('dots'))();
  IntColumn get cardCount => integer()();
  IntColumn get rechargeSeconds => integer()();
  IntColumn get maxAccumulated => integer()();
  BoolColumn get isMain => boolean()();
  IntColumn get coinsPerFullRecharge => integer()();
  IntColumn get sortIndex => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {contentVersionId, name},
    {contentVersionId, sortIndex},
  ];

  @override
  List<String> get customConstraints => [
    'CHECK (card_count > 0)',
    'CHECK (recharge_seconds > 0)',
    'CHECK (max_accumulated > 0)',
    'CHECK (coins_per_full_recharge >= 0)',
    'CHECK (sort_index >= 0)',
  ];
}

@TableIndex(name: 'idx_pack_card_pool_card_id', columns: {#cardId})
@DataClassName('PackCardPoolRow')
class PackCardPool extends Table {
  TextColumn get packTypeId =>
      text().references(PackTypes, #id, onDelete: KeyAction.cascade)();
  TextColumn get cardId =>
      text().references(Cards, #id, onDelete: KeyAction.cascade)();
  BoolColumn get isEnabled => boolean()();

  @override
  Set<Column<Object>> get primaryKey => {packTypeId, cardId};
}

@TableIndex(name: 'idx_pack_slot_rules_pack_type_id', columns: {#packTypeId})
@DataClassName('PackSlotRuleRow')
class PackSlotRules extends Table {
  TextColumn get id => text()();
  TextColumn get packTypeId =>
      text().references(PackTypes, #id, onDelete: KeyAction.cascade)();
  IntColumn get slotIndex => integer()();
  TextColumn get ruleType => text().map(const PackSlotRuleTypeConverter())();
  TextColumn get fixedRarityId => text()
      .references(Rarities, #id, onDelete: KeyAction.restrict)
      .nullable()();
  IntColumn get minimumRarityOrder => integer().nullable()();
  TextColumn get probabilityGroupId => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {packTypeId, slotIndex},
  ];

  @override
  List<String> get customConstraints => [
    'CHECK (slot_index >= 0)',
    'CHECK (minimum_rarity_order IS NULL OR minimum_rarity_order >= 0)',
    "CHECK ((rule_type = 'fixedRarity' AND fixed_rarity_id IS NOT NULL "
        'AND minimum_rarity_order IS NULL AND probability_group_id IS NULL) OR '
        "(rule_type = 'probabilityDistribution' "
        'AND fixed_rarity_id IS NULL AND minimum_rarity_order IS NULL '
        'AND probability_group_id IS NOT NULL) OR '
        "(rule_type = 'minimumRarity' AND fixed_rarity_id IS NULL "
        'AND minimum_rarity_order IS NOT NULL '
        'AND probability_group_id IS NOT NULL))',
  ];
}

@TableIndex(
  name: 'idx_pack_rarity_probabilities_rarity_id',
  columns: {#rarityId},
)
@DataClassName('PackRarityProbabilityRow')
class PackRarityProbabilities extends Table {
  TextColumn get probabilityGroupId => text()();
  TextColumn get rarityId =>
      text().references(Rarities, #id, onDelete: KeyAction.restrict)();
  IntColumn get weight => integer()();

  @override
  Set<Column<Object>> get primaryKey => {probabilityGroupId, rarityId};

  @override
  List<String> get customConstraints => ['CHECK (weight > 0)'];
}

@TableIndex(
  name: 'idx_pack_inventory_installed_collection_id',
  columns: {#installedCollectionId},
)
@DataClassName('PackInventoryRow')
class PackInventory extends Table {
  TextColumn get installedCollectionId => text().references(
    InstalledCollections,
    #id,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get packTypeId =>
      text().references(PackTypes, #id, onDelete: KeyAction.restrict)();
  IntColumn get availableCount => integer()();
  IntColumn get maxAccumulated => integer()();
  DateTimeColumn get nextRechargeAtUtc => dateTime()();
  DateTimeColumn get lastCalculatedAtUtc => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {installedCollectionId, packTypeId};

  @override
  List<String> get customConstraints => [
    'CHECK (available_count >= 0)',
    'CHECK (max_accumulated > 0)',
    'CHECK (available_count <= max_accumulated)',
  ];
}

@TableIndex(
  name: 'idx_owned_cards_installed_collection_id',
  columns: {#installedCollectionId},
)
@DataClassName('OwnedCardRow')
class OwnedCards extends Table {
  TextColumn get installedCollectionId => text().references(
    InstalledCollections,
    #id,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get cardId =>
      text().references(Cards, #id, onDelete: KeyAction.restrict)();
  IntColumn get quantity => integer()();
  DateTimeColumn get firstObtainedAtUtc => dateTime()();
  DateTimeColumn get lastObtainedAtUtc => dateTime()();
  BoolColumn get isFavorite => boolean()();

  @override
  Set<Column<Object>> get primaryKey => {installedCollectionId, cardId};

  @override
  List<String> get customConstraints => ['CHECK (quantity >= 1)'];
}

@TableIndex(
  name: 'idx_pack_openings_installed_collection_id',
  columns: {#installedCollectionId},
)
@DataClassName('PackOpeningRow')
class PackOpenings extends Table {
  TextColumn get id => text()();
  TextColumn get installedCollectionId => text().references(
    InstalledCollections,
    #id,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get packTypeId =>
      text().references(PackTypes, #id, onDelete: KeyAction.restrict)();
  TextColumn get status => text().map(const PackOpeningStatusConverter())();
  DateTimeColumn get generatedAtUtc => dateTime()();
  DateTimeColumn get completedAtUtc => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@TableIndex(name: 'idx_pack_opening_cards_card_id', columns: {#cardId})
@DataClassName('PackOpeningCardRow')
class PackOpeningCards extends Table {
  TextColumn get openingId =>
      text().references(PackOpenings, #id, onDelete: KeyAction.cascade)();
  TextColumn get cardId =>
      text().references(Cards, #id, onDelete: KeyAction.restrict)();
  IntColumn get slotIndex => integer()();
  BoolColumn get wasNew => boolean()();
  IntColumn get quantityAfter => integer()();
  BoolColumn get revealed => boolean()();

  @override
  Set<Column<Object>> get primaryKey => {openingId, slotIndex};

  @override
  List<String> get customConstraints => [
    'CHECK (slot_index >= 0)',
    'CHECK (quantity_after >= 1)',
  ];
}

@TableIndex(
  name: 'idx_coin_transactions_installed_collection_id',
  columns: {#installedCollectionId},
)
@DataClassName('CoinTransactionRow')
class CoinTransactions extends Table {
  TextColumn get id => text()();
  TextColumn get installedCollectionId => text().references(
    InstalledCollections,
    #id,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get transactionType =>
      text().map(const CoinTransactionTypeConverter())();
  IntColumn get amount => integer()();
  IntColumn get balanceAfter => integer()();
  TextColumn get relatedCardId =>
      text().references(Cards, #id, onDelete: KeyAction.setNull).nullable()();
  TextColumn get relatedPackTypeId => text()
      .references(PackTypes, #id, onDelete: KeyAction.setNull)
      .nullable()();
  DateTimeColumn get createdAtUtc => dateTime()();
  TextColumn get metadataJson => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['CHECK (balance_after >= 0)'];
}

@DriftDatabase(
  tables: [
    CollectionProjects,
    ContentVersions,
    InstalledCollections,
    Rarities,
    Cards,
    CardFieldValues,
    MediaAssets,
    PackTypes,
    PackCardPool,
    PackSlotRules,
    PackRarityProbabilities,
    PackInventory,
    OwnedCards,
    PackOpenings,
    PackOpeningCards,
    CoinTransactions,
  ],
  daos: [
    CollectionProjectsDao,
    ContentVersionsDao,
    RaritiesDao,
    CardsDao,
    PackTypesDao,
    InstalledCollectionsDao,
    PlayerProgressDao,
  ],
)
final class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? openGachadexDatabaseConnection());

  @override
  int get schemaVersion => currentDatabaseSchemaVersion;

  @override
  MigrationStrategy get migration => createMigrationStrategy(this);

  @override
  Future<void> close() {
    AppLogger.info('Closing local database.');
    return super.close();
  }
}

@DriftAccessor(
  tables: [
    CollectionProjects,
    ContentVersions,
    InstalledCollections,
    MediaAssets,
    Rarities,
    PackRarityProbabilities,
  ],
)
class CollectionProjectsDao extends DatabaseAccessor<AppDatabase>
    with _$CollectionProjectsDaoMixin {
  CollectionProjectsDao(super.db);

  Future<void> insertProjectAndVersion({
    required CollectionProjectsCompanion project,
    required ContentVersionsCompanion contentVersion,
  }) {
    return transaction(() async {
      await into(contentVersions).insert(contentVersion);
      await into(collectionProjects).insert(project);
    });
  }

  Future<CollectionProjectRow?> getById(String id) {
    return (select(
      collectionProjects,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
  }

  Stream<List<CollectionProjectRow>> watchDrafts() {
    final query = select(collectionProjects)
      ..where(
        (table) => table.status.equalsValue(CollectionProjectStatus.draft),
      )
      ..orderBy([(table) => OrderingTerm.desc(table.updatedAtUtc)]);

    return query.watch();
  }

  Stream<CollectionProjectRow?> watchById(String id) {
    return (select(
      collectionProjects,
    )..where((table) => table.id.equals(id))).watchSingleOrNull();
  }

  Future<bool> replaceProject(CollectionProjectsCompanion project) async {
    return update(collectionProjects).replace(project);
  }

  Future<int> deleteDraftGraph({
    required String projectId,
    required String collectionId,
    required String contentVersionId,
  }) {
    return transaction(() async {
      final installedCount =
          await (select(installedCollections)..where(
                (table) =>
                    table.collectionId.equals(collectionId) &
                    table.contentVersionId.equals(contentVersionId),
              ))
              .get()
              .then((rows) => rows.length);
      if (installedCount > 0) {
        return 0;
      }

      await customStatement(
        'DELETE FROM pack_rarity_probabilities '
        'WHERE rarity_id IN ('
        'SELECT id FROM rarities WHERE content_version_id = ?'
        ')',
        [contentVersionId],
      );
      await (delete(
        collectionProjects,
      )..where((table) => table.id.equals(projectId))).go();
      final deletedVersions = await (delete(
        contentVersions,
      )..where((table) => table.id.equals(contentVersionId))).go();
      await (delete(
        mediaAssets,
      )..where((table) => table.collectionId.equals(collectionId))).go();

      return deletedVersions;
    });
  }
}

@DriftAccessor(tables: [ContentVersions])
class ContentVersionsDao extends DatabaseAccessor<AppDatabase>
    with _$ContentVersionsDaoMixin {
  ContentVersionsDao(super.db);

  Future<int> insertVersion(ContentVersionsCompanion version) {
    return into(contentVersions).insert(version);
  }

  Future<ContentVersionRow?> getCurrentVersion(String collectionId) {
    return (select(contentVersions)..where(
          (table) =>
              table.collectionId.equals(collectionId) &
              table.isCurrent.equals(true),
        ))
        .getSingleOrNull();
  }

  Future<List<ContentVersionRow>> listVersions(String collectionId) {
    final query = select(contentVersions)
      ..where((table) => table.collectionId.equals(collectionId))
      ..orderBy([(table) => OrderingTerm.asc(table.versionNumber)]);

    return query.get();
  }
}

@DriftAccessor(tables: [Rarities])
class RaritiesDao extends DatabaseAccessor<AppDatabase>
    with _$RaritiesDaoMixin {
  RaritiesDao(super.db);

  Future<int> insertRarity(RaritiesCompanion rarity) {
    return into(rarities).insert(rarity);
  }

  Future<RarityRow?> getById(String id) {
    return (select(
      rarities,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
  }

  Stream<List<RarityRow>> watchByCollectionVersion({
    required String collectionId,
    required String contentVersionId,
  }) {
    final query = select(rarities)
      ..where(
        (table) =>
            table.collectionId.equals(collectionId) &
            table.contentVersionId.equals(contentVersionId),
      )
      ..orderBy([(table) => OrderingTerm.asc(table.orderIndex)]);

    return query.watch();
  }

  Future<bool> replaceRarity(RaritiesCompanion rarity) {
    return update(rarities).replace(rarity);
  }

  Future<int> deleteRarity(String id) {
    return (delete(rarities)..where((table) => table.id.equals(id))).go();
  }
}

@DriftAccessor(tables: [Cards, Rarities, MediaAssets, CardFieldValues])
class CardsDao extends DatabaseAccessor<AppDatabase> with _$CardsDaoMixin {
  CardsDao(super.db);

  Future<int> insertCard(CardsCompanion card) {
    return into(cards).insert(card);
  }

  Future<CardRow?> getById(String id) {
    return (select(
      cards,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
  }

  Stream<List<CardRow>> watchByCollectionVersion({
    required String collectionId,
    required String contentVersionId,
  }) {
    final query = select(cards)
      ..where(
        (table) =>
            table.collectionId.equals(collectionId) &
            table.contentVersionId.equals(contentVersionId),
      )
      ..orderBy([(table) => OrderingTerm.asc(table.sortIndex)]);

    return query.watch();
  }

  Future<bool> replaceCard(CardsCompanion card) {
    return update(cards).replace(card);
  }

  Future<int> deleteCard(String id) {
    return (delete(cards)..where((table) => table.id.equals(id))).go();
  }

  Future<int> countByRarity(String rarityId) {
    final count = cards.id.count();
    return (selectOnly(cards)
          ..addColumns([count])
          ..where(cards.rarityId.equals(rarityId)))
        .map((row) => row.read(count) ?? 0)
        .getSingle();
  }
}

@DriftAccessor(tables: [PackTypes])
class PackTypesDao extends DatabaseAccessor<AppDatabase>
    with _$PackTypesDaoMixin {
  PackTypesDao(super.db);

  Future<int> insertPackType(PackTypesCompanion packType) {
    return into(packTypes).insert(packType);
  }

  Future<PackTypeRow?> getById(String id) {
    return (select(
      packTypes,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
  }

  Stream<List<PackTypeRow>> watchByCollectionVersion({
    required String collectionId,
    required String contentVersionId,
  }) {
    final query = select(packTypes)
      ..where(
        (table) =>
            table.collectionId.equals(collectionId) &
            table.contentVersionId.equals(contentVersionId),
      )
      ..orderBy([(table) => OrderingTerm.asc(table.sortIndex)]);

    return query.watch();
  }

  Future<bool> replacePackType(PackTypesCompanion packType) {
    return update(packTypes).replace(packType);
  }

  Future<int> deletePackType(String id) {
    return (delete(packTypes)..where((table) => table.id.equals(id))).go();
  }
}

@DriftAccessor(tables: [InstalledCollections])
class InstalledCollectionsDao extends DatabaseAccessor<AppDatabase>
    with _$InstalledCollectionsDaoMixin {
  InstalledCollectionsDao(super.db);

  Future<int> insertInstalledCollection(
    InstalledCollectionsCompanion collection,
  ) {
    return into(installedCollections).insert(collection);
  }

  Future<InstalledCollectionRow?> getByCollectionId(String collectionId) {
    return (select(installedCollections)
          ..where((table) => table.collectionId.equals(collectionId)))
        .getSingleOrNull();
  }

  Stream<List<InstalledCollectionRow>> watchAll() {
    final query = select(installedCollections)
      ..orderBy([(table) => OrderingTerm.desc(table.installedAtUtc)]);

    return query.watch();
  }

  Future<int> deleteWithProgress(String installedCollectionId) {
    return (delete(
      installedCollections,
    )..where((table) => table.id.equals(installedCollectionId))).go();
  }
}

@DriftAccessor(
  tables: [
    PackInventory,
    OwnedCards,
    CoinTransactions,
    PackOpenings,
    PackOpeningCards,
  ],
)
class PlayerProgressDao extends DatabaseAccessor<AppDatabase>
    with _$PlayerProgressDaoMixin {
  PlayerProgressDao(super.db);

  Future<List<OwnedCardRow>> getOwnedCards(String installedCollectionId) {
    return (select(ownedCards)..where(
          (table) => table.installedCollectionId.equals(installedCollectionId),
        ))
        .get();
  }

  Future<List<PackInventoryRow>> getPackInventory(
    String installedCollectionId,
  ) {
    return (select(packInventory)..where(
          (table) => table.installedCollectionId.equals(installedCollectionId),
        ))
        .get();
  }

  Future<int> getCoinBalance(String installedCollectionId) async {
    final collection =
        await (select(installedCollections)
              ..where((table) => table.id.equals(installedCollectionId)))
            .getSingleOrNull();

    return collection?.coins ?? 0;
  }
}
