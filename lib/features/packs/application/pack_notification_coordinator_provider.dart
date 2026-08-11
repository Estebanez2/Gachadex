import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/notifications/application/notification_coordinator.dart';
import '../../../core/notifications/application/notification_providers.dart';
import 'pack_providers.dart';

final notificationCoordinatorProvider = Provider<NotificationCoordinator>((
  ref,
) {
  return NotificationCoordinator(
    notificationService: ref.watch(localNotificationServiceProvider),
    settingsRepository: ref.watch(notificationSettingsRepositoryProvider),
    rechargeService: ref.watch(packRechargeServiceProvider),
    scheduler: ref.watch(packNotificationSchedulerProvider),
  );
});
