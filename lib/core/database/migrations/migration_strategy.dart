import 'package:drift/drift.dart';

import '../../../features/collection_creator/domain/catalogs/draft_cover_catalog.dart';
import '../../../features/packs/domain/catalogs/pack_visual_catalog.dart';
import '../../errors/app_exception.dart';
import '../../logging/app_logger.dart';
import 'schema_versions.dart';

MigrationStrategy createMigrationStrategy(GeneratedDatabase database) {
  return MigrationStrategy(
    onCreate: (migrator) async {
      AppLogger.info(
        'Creating database schema v$currentDatabaseSchemaVersion.',
      );
      await migrator.createAll();
      AppLogger.info('Database schema created.');
    },
    onUpgrade: (migrator, from, to) async {
      AppLogger.info('Migrating database schema from v$from to v$to.');
      if (from == 1 && to >= 2) {
        await database.customStatement(
          'ALTER TABLE collection_projects ADD COLUMN draft_cover_color_id '
          "TEXT NOT NULL DEFAULT '${DraftCoverCatalog.defaultBackgroundColorId}'",
        );
        await database.customStatement(
          'ALTER TABLE collection_projects ADD COLUMN draft_cover_accent_color_id '
          "TEXT NOT NULL DEFAULT '${DraftCoverCatalog.defaultAccentColorId}'",
        );
        await database.customStatement(
          'ALTER TABLE collection_projects ADD COLUMN draft_cover_icon_id '
          "TEXT NOT NULL DEFAULT '${DraftCoverCatalog.defaultIconId}'",
        );
        await database.customStatement(
          'ALTER TABLE collection_projects ADD COLUMN draft_cover_pattern_id '
          "TEXT NOT NULL DEFAULT '${DraftCoverCatalog.defaultPatternId}'",
        );
      }
      if (from <= 2 && to >= 3) {
        await _migrateCardFieldValuesToFixedComicCatalog(database);
      }
      if (from <= 3 && to >= 4) {
        await _migratePackConfigurationSchema(database);
      }
      if (from <= 4 && to >= 5) {
        await _migratePackInventoryAllowsOverflow(database);
      }
      if (from <= 5 && to >= 6) {
        await database.customStatement('''
CREATE TABLE app_settings (
  key TEXT NOT NULL PRIMARY KEY,
  value TEXT NOT NULL,
  updated_at_utc INTEGER NOT NULL
)
''');
      }
      if (from > 6 || to > currentDatabaseSchemaVersion) {
        throw AppException(
          code: 'migration_not_implemented',
          safeMessage: 'No se puede actualizar la base de datos todavia.',
        );
      }
    },
    beforeOpen: (details) async {
      await database.customStatement('PRAGMA foreign_keys = ON');
      AppLogger.debug(
        'Database opened at schema v${details.versionNow}; '
        'created=${details.wasCreated}.',
      );
    },
  );
}

Future<void> _migratePackInventoryAllowsOverflow(
  GeneratedDatabase database,
) async {
  await database.customStatement(
    'ALTER TABLE pack_inventory RENAME TO pack_inventory_old',
  );
  await database.customStatement('''
CREATE TABLE pack_inventory (
  installed_collection_id TEXT NOT NULL REFERENCES installed_collections(id) ON DELETE CASCADE,
  pack_type_id TEXT NOT NULL REFERENCES pack_types(id) ON DELETE RESTRICT,
  available_count INTEGER NOT NULL,
  max_accumulated INTEGER NOT NULL,
  next_recharge_at_utc INTEGER NOT NULL,
  last_calculated_at_utc INTEGER NOT NULL,
  PRIMARY KEY(installed_collection_id, pack_type_id),
  CHECK (available_count >= 0),
  CHECK (max_accumulated > 0)
)
''');
  await database.customStatement('''
INSERT INTO pack_inventory (
  installed_collection_id,
  pack_type_id,
  available_count,
  max_accumulated,
  next_recharge_at_utc,
  last_calculated_at_utc
)
SELECT
  installed_collection_id,
  pack_type_id,
  available_count,
  max_accumulated,
  next_recharge_at_utc,
  last_calculated_at_utc
FROM pack_inventory_old
''');
  await database.customStatement('DROP TABLE pack_inventory_old');
  await database.customStatement(
    'CREATE INDEX idx_pack_inventory_installed_collection_id '
    'ON pack_inventory(installed_collection_id)',
  );
}

Future<void> _migratePackConfigurationSchema(GeneratedDatabase database) async {
  await database.customStatement(
    'ALTER TABLE pack_types ADD COLUMN front_color_id TEXT NOT NULL '
    "DEFAULT '${PackVisualCatalog.defaultColorId}'",
  );
  await database.customStatement(
    'ALTER TABLE pack_types ADD COLUMN front_accent_color_id TEXT NOT NULL '
    "DEFAULT '${PackVisualCatalog.defaultAccentColorId}'",
  );
  await database.customStatement(
    'ALTER TABLE pack_types ADD COLUMN front_icon_id TEXT NOT NULL '
    "DEFAULT '${PackVisualCatalog.defaultIconId}'",
  );
  await database.customStatement(
    'ALTER TABLE pack_types ADD COLUMN front_pattern_id TEXT NOT NULL '
    "DEFAULT '${PackVisualCatalog.defaultPatternId}'",
  );
  await database.customStatement(
    "ALTER TABLE pack_types ADD COLUMN back_color_id TEXT NOT NULL DEFAULT 'ink'",
  );
  await database.customStatement(
    "ALTER TABLE pack_types ADD COLUMN back_accent_color_id TEXT NOT NULL DEFAULT 'rose'",
  );
  await database.customStatement(
    "ALTER TABLE pack_types ADD COLUMN back_icon_id TEXT NOT NULL DEFAULT 'cards'",
  );
  await database.customStatement(
    "ALTER TABLE pack_types ADD COLUMN back_pattern_id TEXT NOT NULL DEFAULT 'dots'",
  );
  await database.customStatement(
    'ALTER TABLE pack_slot_rules RENAME TO pack_slot_rules_old',
  );
  await database.customStatement('''
CREATE TABLE pack_slot_rules (
  id TEXT NOT NULL PRIMARY KEY,
  pack_type_id TEXT NOT NULL REFERENCES pack_types(id) ON DELETE CASCADE,
  slot_index INTEGER NOT NULL,
  rule_type TEXT NOT NULL,
  fixed_rarity_id TEXT REFERENCES rarities(id) ON DELETE RESTRICT,
  minimum_rarity_order INTEGER,
  probability_group_id TEXT,
  UNIQUE(pack_type_id, slot_index),
  CHECK (slot_index >= 0),
  CHECK (minimum_rarity_order IS NULL OR minimum_rarity_order >= 0),
  CHECK ((rule_type = 'fixedRarity' AND fixed_rarity_id IS NOT NULL
    AND minimum_rarity_order IS NULL AND probability_group_id IS NULL) OR
    (rule_type = 'probabilityDistribution' AND fixed_rarity_id IS NULL
    AND minimum_rarity_order IS NULL AND probability_group_id IS NOT NULL) OR
    (rule_type = 'minimumRarity' AND fixed_rarity_id IS NULL
    AND minimum_rarity_order IS NOT NULL AND probability_group_id IS NOT NULL))
)
''');
  await database.customStatement('''
INSERT INTO pack_slot_rules (
  id,
  pack_type_id,
  slot_index,
  rule_type,
  fixed_rarity_id,
  minimum_rarity_order,
  probability_group_id
)
SELECT
  id,
  pack_type_id,
  slot_index,
  rule_type,
  fixed_rarity_id,
  minimum_rarity_order,
  CASE
    WHEN rule_type = 'minimumRarity' THEN id
    ELSE probability_group_id
  END
FROM pack_slot_rules_old
''');
  await database.customStatement('DROP TABLE pack_slot_rules_old');
  await database.customStatement(
    'CREATE INDEX idx_pack_slot_rules_pack_type_id '
    'ON pack_slot_rules(pack_type_id)',
  );
}

Future<void> _migrateCardFieldValuesToFixedComicCatalog(
  GeneratedDatabase database,
) async {
  await database.customStatement(
    'ALTER TABLE card_field_values RENAME TO card_field_values_old',
  );
  await database.customStatement('''
CREATE TABLE card_field_values (
  id TEXT NOT NULL PRIMARY KEY,
  card_id TEXT NOT NULL REFERENCES cards(id) ON DELETE CASCADE,
  field_type_id TEXT NOT NULL,
  value TEXT NOT NULL,
  display_order INTEGER NOT NULL,
  UNIQUE(card_id, field_type_id),
  CHECK (display_order >= 0),
  CHECK (field_type_id IN ('nickname', 'special_ability', 'attack',
    'weakness', 'famous_quote', 'danger_level', 'embarrassment_level',
    'intelligence', 'luck', 'resistance', 'charisma', 'punctuality',
    'secret_power', 'favorite_object', 'legendary_moment', 'team',
    'location', 'custom_description'))
)
''');
  await database.customStatement('''
INSERT OR IGNORE INTO card_field_values (
  id,
  card_id,
  field_type_id,
  value,
  display_order
)
SELECT
  id,
  card_id,
  CASE field_type_id
    WHEN 'attackName' THEN 'attack'
    WHEN 'attackDescription' THEN 'custom_description'
    WHEN 'favoriteSnack' THEN 'favorite_object'
    WHEN 'catchphrase' THEN 'famous_quote'
    WHEN 'insideJoke' THEN 'legendary_moment'
    WHEN 'specialSkill' THEN 'special_ability'
    ELSE field_type_id
  END,
  value,
  display_order
FROM card_field_values_old
WHERE field_type_id IN (
  'attackName',
  'attackDescription',
  'favoriteSnack',
  'catchphrase',
  'insideJoke',
  'weakness',
  'resistance',
  'specialSkill'
)
''');
  await database.customStatement('DROP TABLE card_field_values_old');
  await database.customStatement(
    'CREATE INDEX idx_card_field_values_card_id '
    'ON card_field_values(card_id)',
  );
}
