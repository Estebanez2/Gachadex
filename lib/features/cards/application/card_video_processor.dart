import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/files/project_media_storage.dart';

const maxCardVideoDuration = Duration(seconds: 15);

final class PendingCardVideo {
  const PendingCardVideo({
    required this.videoPath,
    required this.thumbnailPath,
    required this.videoFileSize,
    required this.thumbnailFileSize,
    required this.width,
    required this.height,
    required this.duration,
  });

  final String videoPath;
  final String thumbnailPath;
  final int videoFileSize;
  final int thumbnailFileSize;
  final int? width;
  final int? height;
  final Duration duration;

  List<String> get tempPaths => [videoPath, thumbnailPath];
}

abstract interface class CardVideoProcessor {
  Future<PendingCardVideo?> pickFromGallery();
}

final class PluginCardVideoProcessor implements CardVideoProcessor {
  PluginCardVideoProcessor(this._storage, {ImagePicker? imagePicker})
    : _imagePicker = imagePicker ?? ImagePicker();

  final ProjectMediaStorage _storage;
  final ImagePicker _imagePicker;

  @override
  Future<PendingCardVideo?> pickFromGallery() async {
    final picked = await _imagePicker.pickVideo(source: ImageSource.gallery);
    if (picked == null) {
      return null;
    }

    String? sourceTempPath;
    String? compressedPath;
    String? thumbnailSourcePath;
    String? thumbnailPath;
    try {
      final sourceTemp = await _storage.createTempCopy(picked.path);
      sourceTempPath = sourceTemp.path;
      final sourceInfo = await VideoCompress.getMediaInfo(sourceTemp.path);
      final durationMs = (sourceInfo.duration ?? 0).round();
      if (durationMs <= 0) {
        throw const InvalidEntityFailure('El video no tiene duracion valida.');
      }
      if (durationMs > maxCardVideoDuration.inMilliseconds) {
        throw const InvalidEntityFailure(
          'El video supera la duracion maxima de 15 segundos.',
        );
      }

      final compressed = await VideoCompress.compressVideo(
        sourceTemp.path,
        quality: VideoQuality.Res1280x720Quality,
        deleteOrigin: false,
        includeAudio: true,
      );
      compressedPath = compressed?.path;
      if (compressedPath == null || !await File(compressedPath).exists()) {
        throw const InvalidEntityFailure('No se ha podido procesar el video.');
      }

      final thumbnail = await VideoCompress.getFileThumbnail(
        compressedPath,
        quality: 75,
        position: 0,
      );
      thumbnailSourcePath = thumbnail.path;
      thumbnailPath = await _storage.createTempPath(extension: '.webp');
      await thumbnail.copy(thumbnailPath);

      final finalInfo = await VideoCompress.getMediaInfo(compressedPath);
      return PendingCardVideo(
        videoPath: compressedPath,
        thumbnailPath: thumbnailPath,
        videoFileSize: await File(compressedPath).length(),
        thumbnailFileSize: await File(thumbnailPath).length(),
        width: finalInfo.width ?? sourceInfo.width,
        height: finalInfo.height ?? sourceInfo.height,
        duration: Duration(
          milliseconds: (finalInfo.duration ?? sourceInfo.duration ?? 0)
              .round(),
        ),
      );
    } finally {
      if (sourceTempPath != null) {
        await _storage.deleteAbsolute(sourceTempPath);
      }
      if (thumbnailSourcePath != null && thumbnailSourcePath != thumbnailPath) {
        await _storage.deleteAbsolute(thumbnailSourcePath);
      }
    }
  }
}
