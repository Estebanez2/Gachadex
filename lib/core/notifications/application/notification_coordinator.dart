// ignore_for_file: prefer_initializing_formals

import '../../../features/packs/application/pack_recharge_service.dart';
import '../../identifiers/entity_id.dart';
import '../../logging/app_logger.dart';
import '../domain/local_notification_service.dart';
import '../domain/notification_settings_repository.dart';
import 'pack_notification_scheduler.dart';

final class NotificationCoordinator {
  NotificationCoordinator({
    required LocalNotificationService notificationService,
    required NotificationSettingsRepository settingsRepository,
    required PackRechargeService rechargeService,
    required PackNotificationScheduler scheduler,
  }) : _notificationService = notificationService,
       _settingsRepository = settingsRepository,
       _rechargeService = rechargeService,
       _scheduler = scheduler;

  final LocalNotificationService _notificationService;
  final NotificationSettingsRepository _settingsRepository;
  final PackRechargeService _rechargeService;
  final PackNotificationScheduler _scheduler;
  bool _refreshing = false;

  Future<void> initializeAndRefreshAll() async {
    try {
      await _notificationService.initialize();
      await refreshAllAndReschedule();
    } on Object catch (error, stackTrace) {
      AppLogger.warning(
        'Could not initialize pack notifications.',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> refreshAllAndReschedule() async {
    if (_refreshing) {
      return;
    }
    _refreshing = true;
    try {
      await _rechargeService.refreshAllCollections();
      await _scheduler.rescheduleAllCollections();
    } on Object catch (error, stackTrace) {
      AppLogger.warning(
        'Could not refresh pack notifications.',
        error: error,
        stackTrace: stackTrace,
      );
    } finally {
      _refreshing = false;
    }
  }

  Future<void> refreshCollectionAndReschedule(InstalledCollectionId id) async {
    try {
      await _rechargeService.refreshCollection(id);
      await _scheduler.rescheduleCollection(id);
    } on Object catch (error, stackTrace) {
      AppLogger.warning(
        'Could not refresh collection pack notifications.',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> setPackNotificationsEnabled(bool enabled) async {
    try {
      await _settingsRepository.setPackNotificationsEnabled(enabled);
      if (!enabled) {
        return _scheduler.rescheduleAllCollections();
      }
      await _notificationService.requestPermission();
      await refreshAllAndReschedule();
    } on Object catch (error, stackTrace) {
      AppLogger.warning(
        'Could not update pack notification settings.',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> openNotificationSettings() async {
    try {
      await _notificationService.openNotificationSettings();
    } on Object catch (error, stackTrace) {
      AppLogger.warning(
        'Could not open notification settings.',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
