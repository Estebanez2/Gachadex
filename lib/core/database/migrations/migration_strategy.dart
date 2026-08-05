import 'package:drift/drift.dart';

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
      throw AppException(
        code: 'migration_not_implemented',
        safeMessage: 'No se puede actualizar la base de datos todavia.',
      );
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
