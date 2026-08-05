import '../../../../core/domain/domain_enums.dart';
import '../../../../core/domain/domain_validation.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../../../../core/value_objects/relative_media_path.dart';

final class MediaAsset {
  MediaAsset({
    required this.id,
    required this.collectionId,
    required this.ownerType,
    required String ownerId,
    required this.mediaType,
    required this.relativePath,
    required this.thumbnailRelativePath,
    required String mimeType,
    required int? width,
    required int? height,
    required int? durationMs,
    required int fileSize,
    required String? sha256,
    required DateTime createdAtUtc,
  }) : ownerId = DomainValidation.requireTrimmedNotEmpty(ownerId, 'ownerId'),
       mimeType = DomainValidation.requireTrimmedNotEmpty(mimeType, 'mimeType'),
       width = _optionalPositive(width, 'width'),
       height = _optionalPositive(height, 'height'),
       durationMs = _validateDuration(durationMs, mediaType),
       fileSize = DomainValidation.requireNonNegative(fileSize, 'fileSize'),
       sha256 = DomainValidation.optionalTrimmed(sha256),
       createdAtUtc = DomainValidation.requireUtc(createdAtUtc, 'createdAtUtc');

  final MediaAssetId id;
  final CollectionId collectionId;
  final MediaOwnerType ownerType;
  final String ownerId;
  final MediaType mediaType;
  final RelativeMediaPath relativePath;
  final RelativeMediaPath? thumbnailRelativePath;
  final String mimeType;
  final int? width;
  final int? height;
  final int? durationMs;
  final int fileSize;
  final String? sha256;
  final DateTime createdAtUtc;

  static int? _optionalPositive(int? value, String fieldName) {
    if (value == null) {
      return null;
    }

    return DomainValidation.requirePositive(value, fieldName);
  }

  static int? _validateDuration(int? value, MediaType mediaType) {
    if (value == null) {
      return null;
    }

    final duration = DomainValidation.requirePositive(value, 'durationMs');
    if (mediaType == MediaType.image) {
      throw ArgumentError.value(
        value,
        'durationMs',
        'Images have no duration.',
      );
    }

    return duration;
  }
}
