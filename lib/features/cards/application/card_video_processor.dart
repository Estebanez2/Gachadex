import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/files/project_media_storage.dart';

const maxCardVideoClipDuration = Duration(seconds: 15);
const maxCardVideoSourceDuration = Duration(minutes: 1);
const maxCardVideoDuration = maxCardVideoClipDuration;

typedef VideoTrimSelector =
    Future<CardVideoTrim?> Function(VideoTrimSelectionRequest request);

final class CardVideoTrim {
  const CardVideoTrim({required this.start, required this.duration});

  final Duration start;
  final Duration duration;

  Duration get end => start + duration;
}

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

enum CardVideoCompressionPlatform { android, standard }

final class CardVideoCompressionArguments {
  const CardVideoCompressionArguments({
    required this.startTimeSeconds,
    required this.durationSeconds,
  });

  final int startTimeSeconds;

  /// This follows `video_compress` naming. On Android the plugin forwards this
  /// value to Transcoder as "trim from end", while other platforms use it as
  /// clip duration.
  final int durationSeconds;
}

bool cardVideoNeedsTrim(Duration sourceDuration) {
  return sourceDuration > maxCardVideoClipDuration;
}

Duration clampCardVideoTrimStart({
  required Duration sourceDuration,
  required Duration requestedStart,
  Duration clipDuration = maxCardVideoClipDuration,
}) {
  final latestStart = sourceDuration - clipDuration;
  if (requestedStart <= Duration.zero) {
    return Duration.zero;
  }
  if (latestStart <= Duration.zero || requestedStart > latestStart) {
    return latestStart <= Duration.zero ? Duration.zero : latestStart;
  }
  return requestedStart;
}

CardVideoTrim normalizeCardVideoTrim({
  required Duration sourceDuration,
  required CardVideoTrim requestedTrim,
}) {
  final requestedDuration = requestedTrim.duration <= Duration.zero
      ? maxCardVideoClipDuration
      : requestedTrim.duration;
  final trimDuration = _minDuration(
    _minDuration(requestedDuration, maxCardVideoClipDuration),
    sourceDuration,
  );
  final trimStart = clampCardVideoTrimStart(
    sourceDuration: sourceDuration,
    requestedStart: requestedTrim.start,
    clipDuration: trimDuration,
  );
  final remainingDuration = sourceDuration - trimStart;
  return CardVideoTrim(
    start: trimStart,
    duration: _minDuration(trimDuration, remainingDuration),
  );
}

CardVideoCompressionArguments cardVideoCompressionArguments({
  required Duration sourceDuration,
  required CardVideoTrim trim,
  required CardVideoCompressionPlatform platform,
}) {
  final startTimeSeconds = _floorWholeSeconds(trim.start);
  final durationSeconds = platform == CardVideoCompressionPlatform.android
      ? _ceilWholeSeconds(sourceDuration - trim.end)
      : _ceilWholeSeconds(trim.duration);
  return CardVideoCompressionArguments(
    startTimeSeconds: startTimeSeconds,
    durationSeconds: durationSeconds,
  );
}

Duration _minDuration(Duration first, Duration second) {
  return first <= second ? first : second;
}

int _floorWholeSeconds(Duration duration) {
  if (duration <= Duration.zero) {
    return 0;
  }
  return duration.inMilliseconds ~/ Duration.millisecondsPerSecond;
}

int _ceilWholeSeconds(Duration duration) {
  if (duration <= Duration.zero) {
    return 0;
  }
  return (duration.inMilliseconds + Duration.millisecondsPerSecond - 1) ~/
      Duration.millisecondsPerSecond;
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
    var keepPendingFiles = false;
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
      CardVideoTrim? trim;
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
        trim = normalizeCardVideoTrim(
          sourceDuration: sourceDuration,
          requestedTrim: selected,
        );
      }

      final compressionArguments = trim == null
          ? null
          : cardVideoCompressionArguments(
              sourceDuration: sourceDuration,
              trim: trim,
              platform: Platform.isAndroid
                  ? CardVideoCompressionPlatform.android
                  : CardVideoCompressionPlatform.standard,
            );
      final compressed = await VideoCompress.compressVideo(
        sourceTemp.path,
        quality: VideoQuality.Res1280x720Quality,
        deleteOrigin: false,
        startTime: compressionArguments?.startTimeSeconds,
        duration: compressionArguments?.durationSeconds,
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
      final pending = PendingCardVideo(
        videoPath: compressedPath,
        thumbnailPath: thumbnailPath,
        videoFileSize: await File(compressedPath).length(),
        thumbnailFileSize: await File(thumbnailPath).length(),
        width: finalInfo.width ?? sourceInfo.width,
        height: finalInfo.height ?? sourceInfo.height,
        duration: _processedVideoDuration(
          finalDurationMs: finalInfo.duration,
          trim: trim,
          sourceDuration: sourceDuration,
        ),
      );
      keepPendingFiles = true;
      return pending;
    } finally {
      if (sourceTempPath != null) {
        await _storage.deleteAbsolute(sourceTempPath);
      }
      if (thumbnailSourcePath != null && thumbnailSourcePath != thumbnailPath) {
        await _storage.deleteAbsolute(thumbnailSourcePath);
      }
      if (!keepPendingFiles && compressedPath != null) {
        await _storage.deleteAbsolute(compressedPath);
      }
      if (!keepPendingFiles && thumbnailPath != null) {
        await _storage.deleteAbsolute(thumbnailPath);
      }
    }
  }

  Duration _processedVideoDuration({
    required double? finalDurationMs,
    required CardVideoTrim? trim,
    required Duration sourceDuration,
  }) {
    final fallback = trim?.duration ?? sourceDuration;
    final mediaDurationMs = finalDurationMs?.round() ?? 0;
    if (mediaDurationMs <= 0) {
      return fallback;
    }
    final mediaDuration = Duration(milliseconds: mediaDurationMs);
    if (trim != null && mediaDuration > maxCardVideoClipDuration) {
      return maxCardVideoClipDuration;
    }
    return mediaDuration;
  }
}
