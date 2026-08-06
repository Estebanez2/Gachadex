import 'package:drift/drift.dart';

import '../../../features/collection_creator/domain/catalogs/draft_cover_catalog.dart';
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
      if (from > 3 || to > currentDatabaseSchemaVersion) {
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
