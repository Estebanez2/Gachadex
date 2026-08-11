import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../database/database_providers.dart';
import '../data/drift_notification_settings_repository.dart';
import '../data/flutter_local_notification_service.dart';
import '../domain/local_notification_service.dart';
import '../domain/notification_settings_repository.dart';
import 'pack_notification_scheduler.dart';

final localNotificationServiceProvider = Provider<LocalNotificationService>((
  ref,
) {
  return FlutterLocalNotificationService();
});

final notificationSettingsRepositoryProvider =
    Provider<NotificationSettingsRepository>((ref) {
      return DriftNotificationSettingsRepository(
        database: ref.watch(appDatabaseProvider),
        clock: ref.watch(clockProvider),
      );
    });

final packNotificationsEnabledProvider = StreamProvider<bool>((ref) {
  return ref
      .watch(notificationSettingsRepositoryProvider)
      .watchPackNotificationsEnabled();
});

final packNotificationSchedulerProvider = Provider<PackNotificationScheduler>((
  ref,
) {
  return PackNotificationScheduler(
    notificationService: ref.watch(localNotificationServiceProvider),
    settingsRepository: ref.watch(notificationSettingsRepositoryProvider),
    installedCollectionRepository: ref.watch(
      installedCollectionRepositoryProvider,
    ),
    packInventoryRepository: ref.watch(packInventoryRepositoryProvider),
    packTypeRepository: ref.watch(packTypeRepositoryProvider),
    clock: ref.watch(clockProvider),
  );
});
