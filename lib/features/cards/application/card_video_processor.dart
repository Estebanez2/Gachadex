import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/files/project_media_storage.dart';

const maxCardVideoClipDuration = Duration(seconds: 15);
const maxCardVideoSourceDuration = Duration(minutes: 1);
const maxCardVideoDuration = maxCardVideoClipDuration;

typedef VideoTrimSelector =
    Future<Duration?> Function(VideoTrimSelectionRequest request);

final class VideoTrimSelectionRequest {
  const VideoTrimSelectionRequest({
    required this.videoPath,
    required this.sourceDuration,
    required this.clipDuration,
  });

  final String videoPath;
  final Duration sourceDuration;
  final Duration clipDuration;

  Duration get latestStart => sourceDuration - clipDuration;
}

bool cardVideoNeedsTrim(Duration sourceDuration) {
  return sourceDuration > maxCardVideoClipDuration;
}

Duration clampCardVideoTrimStart({
  required Duration sourceDuration,
  required Duration requestedStart,
}) {
  final latestStart = sourceDuration - maxCardVideoClipDuration;
  if (requestedStart <= Duration.zero) {
    return Duration.zero;
  }
  if (latestStart <= Duration.zero || requestedStart > latestStart) {
    return latestStart <= Duration.zero ? Duration.zero : latestStart;
  }
  return requestedStart;
}

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
  Future<PendingCardVideo?> pickFromGallery({VideoTrimSelector? selectTrim});
}

final class PluginCardVideoProcessor implements CardVideoProcessor {
  PluginCardVideoProcessor(this._storage, {ImagePicker? imagePicker})
    : _imagePicker = imagePicker ?? ImagePicker();

  final ProjectMediaStorage _storage;
  final ImagePicker _imagePicker;

  @override
  Future<PendingCardVideo?> pickFromGallery({
    VideoTrimSelector? selectTrim,
  }) async {
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
      final sourceDuration = Duration(milliseconds: durationMs);
      if (sourceDuration > maxCardVideoSourceDuration) {
        throw const InvalidEntityFailure(
          'El video supera la duracion maxima de 1 minuto.',
        );
      }
      Duration? trimStart;
      if (cardVideoNeedsTrim(sourceDuration)) {
        final selected = await selectTrim?.call(
          VideoTrimSelectionRequest(
            videoPath: sourceTemp.path,
            sourceDuration: sourceDuration,
            clipDuration: maxCardVideoClipDuration,
          ),
        );
        if (selected == null) {
          return null;
        }
        trimStart = clampCardVideoTrimStart(
          sourceDuration: sourceDuration,
          requestedStart: selected,
        );
      }

      final compressed = await VideoCompress.compressVideo(
        sourceTemp.path,
        quality: VideoQuality.Res1280x720Quality,
        deleteOrigin: false,
        startTime: trimStart?.inSeconds,
        duration: trimStart == null ? null : maxCardVideoClipDuration.inSeconds,
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
