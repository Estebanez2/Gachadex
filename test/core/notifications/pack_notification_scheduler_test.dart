import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gachadex/core/database/app_database.dart';
import 'package:gachadex/core/identifiers/entity_id.dart';
import 'package:gachadex/core/notifications/application/pack_notification_scheduler.dart';
import 'package:gachadex/core/notifications/domain/local_notification_service.dart';
import 'package:gachadex/core/notifications/domain/notification_id_generator.dart';
import 'package:gachadex/core/notifications/domain/notification_settings_repository.dart';
import 'package:gachadex/core/notifications/domain/pack_notification_payload.dart';
import 'package:gachadex/core/time/fake_clock.dart';
import 'package:gachadex/features/collections/data/repositories/drift_installed_collection_repository.dart';
import 'package:gachadex/features/packs/data/repositories/drift_pack_inventory_repository.dart';
import 'package:gachadex/features/packs/data/repositories/drift_pack_type_repository.dart';

import '../../helpers/database_seed.dart';
import '../../helpers/database_test_utils.dart';

void main() {
  group('PackNotificationScheduler', () {
    late AppDatabase database;
    late FakeClock clock;
    late SeededDefinition definition;
    late InstalledCollectionId installedCollectionId;
    late _FakeLocalNotificationService notificationService;
    late _FakeNotificationSettingsRepository settingsRepository;
    late PackNotificationScheduler scheduler;

    setUp(() async {
      database = createInMemoryDatabase();
      clock = FakeClock(testNowUtc(11));
      definition = await seedDefinition(database, seed: 11);
      installedCollectionId = InstalledCollectionId(
        await seedInstalledCollection(database, definition, seed: 11),
      );
      notificationService = _FakeLocalNotificationService();
      settingsRepository = _FakeNotificationSettingsRepository(enabled: true);
      scheduler = PackNotificationScheduler(
        notificationService: notificationService,
        settingsRepository: settingsRepository,
        installedCollectionRepository: DriftInstalledCollectionRepository(
          database: database,
        ),
        packInventoryRepository: DriftPackInventoryRepository(
          database: database,
        ),
        packTypeRepository: DriftPackTypeRepository(
          database: database,
          clock: clock,
        ),
        clock: clock,
      );
    });

    tearDown(() async {
      await database.close();
    });

    test('schedules the next recharge when inventory is below cap', () async {
      final next = clock.nowUtc().add(const Duration(minutes: 45));
      await insertInventory(
        database: database,
        installedCollectionId: installedCollectionId,
        packTypeId: definition.packTypeId,
        availableCount: 1,
        nextRechargeAtUtc: next,
        lastCalculatedAtUtc: clock.nowUtc(),
      );

      await scheduler.reschedulePack(
        installedCollectionId: installedCollectionId,
        packTypeId: PackTypeId(definition.packTypeId),
      );

      expect(notificationService.canceledIds, hasLength(1));
      expect(notificationService.scheduled, hasLength(1));
      expect(notificationService.scheduled.single.scheduledAtUtc, next);
      _expectStableNotificationId(
        notification: notificationService.scheduled.single,
        installedCollectionId: installedCollectionId,
        packTypeId: PackTypeId(definition.packTypeId),
      );
      expect(
        notificationService.scheduled.single.payload.installedCollectionId,
        installedCollectionId,
      );
      expect(notificationService.scheduled.single.body, contains('Sobre 11'));
    });

    test('cancels and skips scheduling while inventory is full', () async {
      await insertInventory(
        database: database,
        installedCollectionId: installedCollectionId,
        packTypeId: definition.packTypeId,
        availableCount: 3,
        nextRechargeAtUtc: clock.nowUtc().add(const Duration(minutes: 45)),
        lastCalculatedAtUtc: clock.nowUtc(),
      );

      await scheduler.reschedulePack(
        installedCollectionId: installedCollectionId,
        packTypeId: PackTypeId(definition.packTypeId),
      );

      expect(notificationService.canceledIds, hasLength(1));
      expect(notificationService.scheduled, isEmpty);
    });

    test('cancels and skips scheduling while inventory is over cap', () async {
      await insertInventory(
        database: database,
        installedCollectionId: installedCollectionId,
        packTypeId: definition.packTypeId,
        availableCount: 5,
        nextRechargeAtUtc: clock.nowUtc().add(const Duration(minutes: 45)),
        lastCalculatedAtUtc: clock.nowUtc(),
      );

      await scheduler.reschedulePack(
        installedCollectionId: installedCollectionId,
        packTypeId: PackTypeId(definition.packTypeId),
      );

      expect(notificationService.canceledIds, hasLength(1));
      expect(notificationService.scheduled, isEmpty);
    });

    test(
      'does not schedule when preference or system permission is disabled',
      () async {
        await insertInventory(
          database: database,
          installedCollectionId: installedCollectionId,
          packTypeId: definition.packTypeId,
          availableCount: 1,
          nextRechargeAtUtc: clock.nowUtc().add(const Duration(minutes: 45)),
          lastCalculatedAtUtc: clock.nowUtc(),
        );
        settingsRepository.enabled = false;

        await scheduler.reschedulePack(
          installedCollectionId: installedCollectionId,
          packTypeId: PackTypeId(definition.packTypeId),
        );
        expect(notificationService.scheduled, isEmpty);

        settingsRepository.enabled = true;
        notificationService.allowed = false;
        await scheduler.reschedulePack(
          installedCollectionId: installedCollectionId,
          packTypeId: PackTypeId(definition.packTypeId),
        );
        expect(notificationService.scheduled, isEmpty);
      },
    );
  });
}

Future<void> insertInventory({
  required AppDatabase database,
  required InstalledCollectionId installedCollectionId,
  required String packTypeId,
  required int availableCount,
  required DateTime nextRechargeAtUtc,
  required DateTime lastCalculatedAtUtc,
}) {
  return database
      .into(database.packInventory)
      .insert(
        PackInventoryCompanion(
          installedCollectionId: Value(installedCollectionId.value),
          packTypeId: Value(packTypeId),
          availableCount: Value(availableCount),
          maxAccumulated: const Value(3),
          nextRechargeAtUtc: Value(nextRechargeAtUtc),
          lastCalculatedAtUtc: Value(lastCalculatedAtUtc),
        ),
      );
}

final class _FakeLocalNotificationService implements LocalNotificationService {
  final scheduled = <_ScheduledNotification>[];
  final canceledIds = <int>[];
  final _selections = StreamController<PackNotificationPayload>.broadcast();
  var allowed = true;

  @override
  Stream<PackNotificationPayload> get selections => _selections.stream;

  @override
  Future<bool> areNotificationsAllowed() async => allowed;

  @override
  Future<void> cancelPackNotification(int notificationId) async {
    canceledIds.add(notificationId);
  }

  @override
  Future<void> initialize() async {}

  @override
  Future<void> openNotificationSettings() async {}

  @override
  Future<NotificationPermissionStatus> requestPermission() async {
    return allowed
        ? NotificationPermissionStatus.granted
        : NotificationPermissionStatus.denied;
  }

  @override
  Future<void> schedulePackAvailable({
    required int notificationId,
    required DateTime scheduledAtUtc,
    required String title,
    required String body,
    required PackNotificationPayload payload,
  }) async {
    scheduled.add(
      _ScheduledNotification(
        notificationId: notificationId,
        scheduledAtUtc: scheduledAtUtc,
        title: title,
        body: body,
        payload: payload,
      ),
    );
  }
}

final class _ScheduledNotification {
  const _ScheduledNotification({
    required this.notificationId,
    required this.scheduledAtUtc,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int notificationId;
  final DateTime scheduledAtUtc;
  final String title;
  final String body;
  final PackNotificationPayload payload;
}

final class _FakeNotificationSettingsRepository
    implements NotificationSettingsRepository {
  _FakeNotificationSettingsRepository({required this.enabled});

  bool enabled;

  @override
  Future<bool> arePackNotificationsEnabled() async => enabled;

  @override
  Future<void> setPackNotificationsEnabled(bool enabled) async {
    this.enabled = enabled;
  }

  @override
  Stream<bool> watchPackNotificationsEnabled() => Stream.value(enabled);
}

void _expectStableNotificationId({
  required _ScheduledNotification notification,
  required InstalledCollectionId installedCollectionId,
  required PackTypeId packTypeId,
}) {
  expect(
    notification.notificationId,
    const NotificationIdGenerator().packAvailable(
      installedCollectionId: installedCollectionId,
      packTypeId: packTypeId,
    ),
  );
}
