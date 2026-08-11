import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../domain/local_notification_service.dart';
import '../domain/pack_notification_payload.dart';

final class FlutterLocalNotificationService
    implements LocalNotificationService {
  FlutterLocalNotificationService({FlutterLocalNotificationsPlugin? plugin})
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  static const _androidChannelId = 'pack_recharge';
  static const _androidChannelName = 'Sobres';
  static const _androidChannelDescription =
      'Avisos cuando un sobre vuelve a estar disponible.';

  final FlutterLocalNotificationsPlugin _plugin;
  final _selections = StreamController<PackNotificationPayload>.broadcast();
  bool _initialized = false;

  @override
  Stream<PackNotificationPayload> get selections => _selections.stream;

  @override
  Future<void> initialize() async {
    if (_initialized) {
      return;
    }
    tzdata.initializeTimeZones();
    tz.setLocalLocation(tz.UTC);

    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('ic_notification'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
    );
    await _plugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: _handleResponse,
      onDidReceiveBackgroundNotificationResponse:
          _handleBackgroundNotificationResponse,
    );
    final launchDetails = await _plugin.getNotificationAppLaunchDetails();
    final response = launchDetails?.notificationResponse;
    if (launchDetails?.didNotificationLaunchApp == true) {
      _emitPayload(response?.payload);
    }
    _initialized = true;
  }

  @override
  Future<NotificationPermissionStatus> requestPermission() async {
    await initialize();
    if (defaultTargetPlatform == TargetPlatform.android) {
      final granted = await _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
      return granted == true
          ? NotificationPermissionStatus.granted
          : NotificationPermissionStatus.denied;
    }

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final granted = await _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      return granted == true
          ? NotificationPermissionStatus.granted
          : NotificationPermissionStatus.denied;
    }

    return NotificationPermissionStatus.granted;
  }

  @override
  Future<bool> areNotificationsAllowed() async {
    await initialize();
    if (defaultTargetPlatform == TargetPlatform.android) {
      return await _plugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >()
              ?.areNotificationsEnabled() ??
          true;
    }
    return true;
  }

  @override
  Future<void> openNotificationSettings() async {
    await initialize();
    await _plugin.openAppNotificationSettings();
  }

  @override
  Future<void> schedulePackAvailable({
    required int notificationId,
    required DateTime scheduledAtUtc,
    required String title,
    required String body,
    required PackNotificationPayload payload,
  }) async {
    await initialize();
    await _plugin.zonedSchedule(
      id: notificationId,
      title: title,
      body: body,
      scheduledDate: tz.TZDateTime.from(scheduledAtUtc.toUtc(), tz.UTC),
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          _androidChannelId,
          _androidChannelName,
          channelDescription: _androidChannelDescription,
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      payload: payload.encode(),
    );
  }

  @override
  Future<void> cancelPackNotification(int notificationId) async {
    await initialize();
    await _plugin.cancel(id: notificationId);
  }

  void _handleResponse(NotificationResponse response) {
    _emitPayload(response.payload);
  }

  void _emitPayload(String? rawPayload) {
    final payload = PackNotificationPayload.tryDecode(rawPayload);
    if (payload != null) {
      _selections.add(payload);
    }
  }
}

@pragma('vm:entry-point')
void _handleBackgroundNotificationResponse(NotificationResponse response) {}
