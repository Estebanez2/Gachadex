import 'dart:async';

import 'pack_notification_payload.dart';

enum NotificationPermissionStatus { granted, denied, notDetermined }

abstract interface class LocalNotificationService {
  Stream<PackNotificationPayload> get selections;

  Future<void> initialize();

  Future<NotificationPermissionStatus> requestPermission();

  Future<bool> areNotificationsAllowed();

  Future<void> openNotificationSettings();

  Future<void> schedulePackAvailable({
    required int notificationId,
    required DateTime scheduledAtUtc,
    required String title,
    required String body,
    required PackNotificationPayload payload,
  });

  Future<void> cancelPackNotification(int notificationId);
}
