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
      } else {
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
