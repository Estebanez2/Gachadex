import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../identifiers/entity_id.dart';
import '../value_objects/relative_media_path.dart';

abstract interface class ProjectMediaStorage {
  RelativeMediaPath cardImagePath({
    required CollectionProjectId projectId,
    required MediaAssetId assetId,
  });

  RelativeMediaPath cardVideoPath({
    required CollectionProjectId projectId,
    required MediaAssetId assetId,
  });

  RelativeMediaPath cardThumbnailPath({
    required CollectionProjectId projectId,
    required MediaAssetId assetId,
  });

  Future<File> copyFile({
    required String sourcePath,
    required RelativeMediaPath destination,
  });

  Future<File> createTempCopy(String sourcePath);

  Future<String> createTempPath({required String extension});

  Future<File> resolve(RelativeMediaPath path);

  Future<bool> exists(RelativeMediaPath path);

  Future<void> delete(RelativeMediaPath path);

  Future<void> deleteAbsolute(String path);
}

final class LocalProjectMediaStorage implements ProjectMediaStorage {
  const LocalProjectMediaStorage({this.rootDirectory});

  final Directory? rootDirectory;

  @override
  RelativeMediaPath cardImagePath({
    required CollectionProjectId projectId,
    required MediaAssetId assetId,
  }) {
    return RelativeMediaPath(
      'projects/${projectId.value}/cards/images/${assetId.value}.webp',
    );
  }

  @override
  RelativeMediaPath cardVideoPath({
    required CollectionProjectId projectId,
    required MediaAssetId assetId,
  }) {
    return RelativeMediaPath(
      'projects/${projectId.value}/cards/videos/${assetId.value}.mp4',
    );
  }

  @override
  RelativeMediaPath cardThumbnailPath({
    required CollectionProjectId projectId,
    required MediaAssetId assetId,
  }) {
    return RelativeMediaPath(
      'projects/${projectId.value}/cards/thumbnails/${assetId.value}.webp',
    );
  }

  @override
  Future<File> copyFile({
    required String sourcePath,
    required RelativeMediaPath destination,
  }) async {
    final target = await resolve(destination);
    await target.parent.create(recursive: true);
    return File(sourcePath).copy(target.path);
  }

  @override
  Future<File> createTempCopy(String sourcePath) async {
    final tempPath = await createTempPath(extension: p.extension(sourcePath));
    final target = File(tempPath);
    await target.parent.create(recursive: true);
    return File(sourcePath).copy(target.path);
  }

  @override
  Future<String> createTempPath({required String extension}) async {
    final tempDirectory = await getTemporaryDirectory();
    final safeExtension = extension.startsWith('.') ? extension : '.$extension';
    final millis = DateTime.now().microsecondsSinceEpoch;
    return p.join(tempDirectory.path, 'gachadex-card-$millis$safeExtension');
  }

  @override
  Future<File> resolve(RelativeMediaPath path) async {
    final root = rootDirectory ?? await getApplicationSupportDirectory();
    return File(p.joinAll([root.path, ...path.value.split('/')]));
  }

  @override
  Future<bool> exists(RelativeMediaPath path) async {
    return (await resolve(path)).exists();
  }

  @override
  Future<void> delete(RelativeMediaPath path) async {
    final file = await resolve(path);
    if (await file.exists()) {
      await file.delete();
    }
  }

  @override
  Future<void> deleteAbsolute(String path) async {
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
