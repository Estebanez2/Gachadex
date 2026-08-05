import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../logging/app_logger.dart';

const String gachadexDatabaseName = 'gachadex';
const String gachadexDatabaseFileName = '$gachadexDatabaseName.sqlite';

DatabaseConnection openGachadexDatabaseConnection() {
  AppLogger.info('Opening local database.');
  return driftDatabase(
    name: gachadexDatabaseName,
    native: DriftNativeOptions(
      databaseDirectory: getApplicationSupportDirectory,
    ),
  );
}
