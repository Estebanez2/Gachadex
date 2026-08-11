// ignore_for_file: prefer_initializing_formals

import '../../database/app_database.dart';
import '../../database/mappers/date_time_mapper.dart';
import '../../time/clock.dart';
import '../domain/notification_settings_repository.dart';

final class DriftNotificationSettingsRepository
    implements NotificationSettingsRepository {
  const DriftNotificationSettingsRepository({
    required AppDatabase database,
    required Clock clock,
  }) : _database = database,
       _clock = clock;

  static const _packNotificationsKey = 'pack_notifications_enabled';

  final AppDatabase _database;
  final Clock _clock;

  @override
  Stream<bool> watchPackNotificationsEnabled() {
    return (_database.select(_database.appSettings)
          ..where((table) => table.key.equals(_packNotificationsKey)))
        .watchSingleOrNull()
        .map((row) => _decode(row?.value));
  }

  @override
  Future<bool> arePackNotificationsEnabled() async {
    final row =
        await (_database.select(_database.appSettings)
              ..where((table) => table.key.equals(_packNotificationsKey)))
            .getSingleOrNull();
    return _decode(row?.value);
  }

  @override
  Future<void> setPackNotificationsEnabled(bool enabled) async {
    await _database
        .into(_database.appSettings)
        .insertOnConflictUpdate(
          AppSettingsCompanion.insert(
            key: _packNotificationsKey,
            value: enabled ? 'true' : 'false',
            updatedAtUtc: toDatabaseUtc(_clock.nowUtc()),
          ),
        );
  }

  bool _decode(String? value) => value == 'true';
}
