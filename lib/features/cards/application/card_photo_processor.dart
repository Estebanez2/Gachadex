import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/files/project_media_storage.dart';
import '../domain/catalogs/card_template_catalog.dart';

final class PendingCardPhoto {
  const PendingCardPhoto({
    required this.imagePath,
    required this.thumbnailPath,
    required this.imageFileSize,
    required this.thumbnailFileSize,
  });

  final String imagePath;
  final String thumbnailPath;
  final int imageFileSize;
  final int thumbnailFileSize;

  List<String> get tempPaths => [imagePath, thumbnailPath];
}

abstract interface class CardPhotoProcessor {
  Future<PendingCardPhoto?> pickFromGallery({
    required CardTemplate template,
    required BuildContext context,
  });
}

final class PluginCardPhotoProcessor implements CardPhotoProcessor {
  PluginCardPhotoProcessor(
    this._storage, {
    ImagePicker? imagePicker,
    ImageCropper? imageCropper,
  }) : _imagePicker = imagePicker ?? ImagePicker(),
       _imageCropper = imageCropper ?? ImageCropper();

  final ProjectMediaStorage _storage;
  final ImagePicker _imagePicker;
  final ImageCropper _imageCropper;

  @override
  Future<PendingCardPhoto?> pickFromGallery({
    required CardTemplate template,
    required BuildContext context,
  }) async {
    final picked = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (picked == null) {
      return null;
    }

    String? sourceTempPath;
    String? croppedPath;
    String? mainPath;
    String? thumbnailPath;
    try {
      final sourceTemp = await _storage.createTempCopy(picked.path);
      sourceTempPath = sourceTemp.path;
      final cropped = await _imageCropper.cropImage(
        sourcePath: sourceTemp.path,
        aspectRatio: CropAspectRatio(
          ratioX: template.aspectRatioWidth,
          ratioY: template.aspectRatioHeight,
        ),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Recortar fotografia',
            lockAspectRatio: true,
            hideBottomControls: false,
          ),
          IOSUiSettings(
            title: 'Recortar fotografia',
            aspectRatioLockEnabled: true,
            resetAspectRatioEnabled: false,
          ),
        ],
      );
      if (cropped == null) {
        return null;
      }

      croppedPath = cropped.path;
      mainPath = await _storage.createTempPath(extension: '.webp');
      thumbnailPath = await _storage.createTempPath(extension: '.webp');

      final main = await FlutterImageCompress.compressAndGetFile(
        cropped.path,
        mainPath,
        minWidth: 1440,
        minHeight: 1440,
        quality: 82,
        format: CompressFormat.webp,
        autoCorrectionAngle: true,
      );
      if (main == null) {
        throw const FileSystemException('No se pudo crear la imagen WebP.');
      }

      final thumbnail = await FlutterImageCompress.compressAndGetFile(
        main.path,
        thumbnailPath,
        minWidth: 480,
        minHeight: 480,
        quality: 75,
        format: CompressFormat.webp,
        autoCorrectionAngle: true,
      );
      if (thumbnail == null) {
        throw const FileSystemException('No se pudo crear la miniatura WebP.');
      }

      return PendingCardPhoto(
        imagePath: main.path,
        thumbnailPath: thumbnail.path,
        imageFileSize: await File(main.path).length(),
        thumbnailFileSize: await File(thumbnail.path).length(),
      );
    } finally {
      if (sourceTempPath != null) {
        await _storage.deleteAbsolute(sourceTempPath);
      }
      if (croppedPath != null && croppedPath != mainPath) {
        await _storage.deleteAbsolute(croppedPath);
      }
    }
  }
}
