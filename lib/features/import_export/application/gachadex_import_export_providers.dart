// ignore_for_file: prefer_initializing_formals

import 'package:file_selector/file_selector.dart' as selector;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/database/database_providers.dart';
import '../../../core/files/file_providers.dart';
import '../../../core/notifications/application/notification_providers.dart';
import '../data/gachadex_package_service.dart';
import '../domain/gachadex_package_constants.dart';
import '../domain/gachadex_package_failure.dart';

final gachadexPackageServiceProvider = Provider<GachadexPackageService>((ref) {
  return GachadexPackageService(
    database: ref.watch(appDatabaseProvider),
    mediaStorage: ref.watch(projectMediaStorageProvider),
    uuidGenerator: ref.watch(uuidGeneratorProvider),
    clock: ref.watch(clockProvider),
    notificationScheduler: ref.watch(packNotificationSchedulerProvider),
  );
});

final gachadexPackageActionsProvider = Provider<GachadexPackageActions>((ref) {
  return GachadexPackageActions(
    service: ref.watch(gachadexPackageServiceProvider),
  );
});

final class PickedGachadexPackage {
  const PickedGachadexPackage({required this.path, required this.preview});

  final String path;
  final GachadexPackagePreview preview;
}

final class GachadexPackageActions {
  const GachadexPackageActions({required GachadexPackageService service})
    : _service = service;

  static const _typeGroup = selector.XTypeGroup(
    label: 'Gachadex',
    extensions: ['gachadex'],
    mimeTypes: ['application/zip'],
    uniformTypeIdentifiers: ['com.gachadex.collection'],
  );

  final GachadexPackageService _service;

  Future<PickedGachadexPackage> pickForImport() async {
    final file = await selector.openFile(acceptedTypeGroups: [_typeGroup]);
    final path = file?.path;
    if (path == null || path.isEmpty) {
      throw const GachadexPackageCanceled();
    }
    if (!path.toLowerCase().endsWith(gachadexPackageExtension)) {
      throw const GachadexPackageFailure(
        'El archivo debe terminar en .gachadex.',
      );
    }

    return PickedGachadexPackage(
      path: path,
      preview: await _service.previewFile(path),
    );
  }

  Future<GachadexImportResult> importPicked(String path) {
    return _service.importFile(path);
  }

  Future<void> exportAndShare(String installedCollectionId) async {
    final file = await _service.exportInstalledCollection(
      installedCollectionId,
    );
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path)],
        fileNameOverrides: [file.uri.pathSegments.last],
      ),
    );
  }
}
