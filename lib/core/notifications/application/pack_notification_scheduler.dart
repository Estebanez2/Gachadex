// ignore_for_file: prefer_initializing_formals

import '../../identifiers/entity_id.dart';
import '../../logging/app_logger.dart';
import '../../time/clock.dart';
import '../../../features/collections/domain/repositories/installed_collection_repository.dart';
import '../../../features/packs/domain/entities/pack_inventory.dart';
import '../../../features/packs/domain/entities/pack_type.dart';
import '../../../features/packs/domain/repositories/pack_inventory_repository.dart';
import '../../../features/packs/domain/repositories/pack_type_repository.dart';
import '../domain/local_notification_service.dart';
import '../domain/notification_id_generator.dart';
import '../domain/notification_settings_repository.dart';
import '../domain/pack_notification_payload.dart';

final class PackNotificationScheduler {
  const PackNotificationScheduler({
    required LocalNotificationService notificationService,
    required NotificationSettingsRepository settingsRepository,
    required InstalledCollectionRepository installedCollectionRepository,
    required PackInventoryRepository packInventoryRepository,
    required PackTypeRepository packTypeRepository,
    required Clock clock,
    NotificationIdGenerator idGenerator = const NotificationIdGenerator(),
  }) : _notificationService = notificationService,
       _settingsRepository = settingsRepository,
       _installedCollectionRepository = installedCollectionRepository,
       _packInventoryRepository = packInventoryRepository,
       _packTypeRepository = packTypeRepository,
       _clock = clock,
       _idGenerator = idGenerator;

  final LocalNotificationService _notificationService;
  final NotificationSettingsRepository _settingsRepository;
  final InstalledCollectionRepository _installedCollectionRepository;
  final PackInventoryRepository _packInventoryRepository;
  final PackTypeRepository _packTypeRepository;
  final Clock _clock;
  final NotificationIdGenerator _idGenerator;

  Future<void> rescheduleAllCollections() async {
    final collections = await _installedCollectionRepository.watchAll().first;
    for (final collection in collections) {
      await rescheduleCollection(collection.id);
    }
  }

  Future<void> rescheduleCollection(InstalledCollectionId id) async {
    final inventories = await _packInventoryRepository
        .watchByInstalledCollection(id)
        .first;
    for (final inventory in inventories) {
      await reschedulePack(
        installedCollectionId: id,
        packTypeId: inventory.packTypeId,
      );
    }
  }

  Future<void> reschedulePack({
    required InstalledCollectionId installedCollectionId,
    required PackTypeId packTypeId,
  }) async {
    final notificationId = _idGenerator.packAvailable(
      installedCollectionId: installedCollectionId,
      packTypeId: packTypeId,
    );
    await _notificationService.cancelPackNotification(notificationId);

    if (!await _settingsRepository.arePackNotificationsEnabled()) {
      return;
    }
    if (!await _notificationService.areNotificationsAllowed()) {
      return;
    }

    final inventories = await _packInventoryRepository
        .watchByInstalledCollection(installedCollectionId)
        .first;
    PackInventory? inventory;
    for (final candidate in inventories) {
      if (candidate.packTypeId == packTypeId) {
        inventory = candidate;
        break;
      }
    }
    if (inventory == null ||
        inventory.availableCount >= inventory.maxAccumulated) {
      return;
    }
    final scheduledAtUtc = inventory.nextRechargeAtUtc.toUtc();
    if (!scheduledAtUtc.isAfter(_clock.nowUtc())) {
      return;
    }

    final pack = await _packTypeRepository.getById(packTypeId);
    await _notificationService.schedulePackAvailable(
      notificationId: notificationId,
      scheduledAtUtc: scheduledAtUtc,
      title: 'Sobre listo',
      body: 'Ya puedes abrir ${_packDisplayName(pack)}.',
      payload: PackNotificationPayload(
        installedCollectionId: installedCollectionId,
        packTypeId: packTypeId,
      ),
    );
  }

  Future<void> cancelCollection(InstalledCollectionId id) async {
    final inventories = await _packInventoryRepository
        .watchByInstalledCollection(id)
        .first;
    for (final inventory in inventories) {
      final notificationId = _idGenerator.packAvailable(
        installedCollectionId: id,
        packTypeId: inventory.packTypeId,
      );
      await _notificationService.cancelPackNotification(notificationId);
    }
  }

  Future<void> tryRescheduleCollection(InstalledCollectionId id) async {
    try {
      await rescheduleCollection(id);
    } on Object catch (error, stackTrace) {
      AppLogger.warning(
        'Could not reschedule pack notifications for collection.',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> tryReschedulePack({
    required InstalledCollectionId installedCollectionId,
    required PackTypeId packTypeId,
  }) async {
    try {
      await reschedulePack(
        installedCollectionId: installedCollectionId,
        packTypeId: packTypeId,
      );
    } on Object catch (error, stackTrace) {
      AppLogger.warning(
        'Could not reschedule pack notification.',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  String _packDisplayName(PackType pack) => pack.name;
}
