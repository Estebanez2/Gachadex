// ignore_for_file: prefer_initializing_formals

import '../../../core/identifiers/entity_id.dart';
import '../../../core/logging/app_logger.dart';
import '../../../core/notifications/application/pack_notification_scheduler.dart';
import '../domain/repositories/installed_collection_repository.dart';

final class DeleteInstalledCollection {
  const DeleteInstalledCollection({
    required InstalledCollectionRepository repository,
    required PackNotificationScheduler notificationScheduler,
  }) : _repository = repository,
       _notificationScheduler = notificationScheduler;

  final InstalledCollectionRepository _repository;
  final PackNotificationScheduler _notificationScheduler;

  Future<void> call(InstalledCollectionId id) async {
    try {
      await _notificationScheduler.cancelCollection(id);
    } on Object catch (error, stackTrace) {
      AppLogger.warning(
        'Could not cancel pack notifications before deleting collection.',
        error: error,
        stackTrace: stackTrace,
      );
    }
    await _repository.deleteWithProgress(id);
  }
}
