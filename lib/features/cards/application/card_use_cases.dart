import 'package:flutter/foundation.dart';

import '../../../core/domain/domain_enums.dart';
import '../../../core/errors/app_failure.dart';
import '../../../core/files/project_media_storage.dart';
import '../../../core/identifiers/entity_id.dart';
import '../../../core/identifiers/uuid_generator.dart';
import '../../../core/time/clock.dart';
import '../../../core/value_objects/relative_media_path.dart';
import '../../collection_creator/domain/repositories/collection_project_repository.dart';
import '../domain/entities/card.dart' as domain;
import '../domain/entities/card_field_value.dart';
import '../domain/entities/media_asset.dart';
import '../domain/repositories/card_repository.dart';
import '../domain/validation/card_validation.dart';
import 'card_photo_processor.dart';

final class ImageCardInput {
  const ImageCardInput({
    required this.collectionNumber,
    required this.name,
    required this.health,
    required this.rarityId,
    required this.templateId,
    required this.frameId,
    required this.primaryColor,
    required this.secondaryColor,
    required this.description,
    required this.comicFields,
    required this.photo,
  });

  final int collectionNumber;
  final String name;
  final int health;
  final RarityId rarityId;
  final String templateId;
  final String frameId;
  final int primaryColor;
  final int secondaryColor;
  final String description;
  final List<ComicFieldInput> comicFields;
  final PendingCardPhoto? photo;
}

final class CreateImageCard {
  const CreateImageCard(
    this._cardRepository,
    this._projectRepository,
    this._storage,
    this._uuidGenerator,
    this._clock,
  );

  final CardRepository _cardRepository;
  final CollectionProjectRepository _projectRepository;
  final ProjectMediaStorage _storage;
  final UuidGenerator _uuidGenerator;
  final Clock _clock;

  Future<ImageCardDetails> call({
    required CollectionProjectId projectId,
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
    required ImageCardInput input,
  }) async {
    final duplicate = await _cardRepository.collectionNumberExists(
      collectionId: collectionId,
      contentVersionId: contentVersionId,
      collectionNumber: input.collectionNumber,
    );
    _validate(input: input, duplicate: duplicate);

    final photo = input.photo;
    if (photo == null) {
      throw const InvalidEntityFailure('La fotografia es obligatoria.');
    }

    final cardId = _uuidGenerator.cardId();
    final mediaAssetId = _uuidGenerator.mediaAssetId();
    final thumbnailAssetId = _uuidGenerator.mediaAssetId();
    final imagePath = _storage.cardImagePath(
      projectId: projectId,
      assetId: mediaAssetId,
    );
    final thumbnailPath = _storage.cardThumbnailPath(
      projectId: projectId,
      assetId: thumbnailAssetId,
    );
    final now = _clock.nowUtc();
    final copiedPaths = <RelativeMediaPath>[];

    try {
      await _storage.copyFile(
        sourcePath: photo.imagePath,
        destination: imagePath,
      );
      copiedPaths.add(imagePath);
      await _storage.copyFile(
        sourcePath: photo.thumbnailPath,
        destination: thumbnailPath,
      );
      copiedPaths.add(thumbnailPath);

      final graph = ImageCardGraph(
        card: domain.Card(
          id: cardId,
          collectionId: collectionId,
          contentVersionId: contentVersionId,
          collectionNumber: input.collectionNumber,
          name: input.name,
          health: input.health,
          rarityId: input.rarityId,
          mediaAssetId: mediaAssetId,
          mediaType: MediaType.image,
          thumbnailAssetId: thumbnailAssetId,
          templateId: input.templateId,
          frameId: input.frameId,
          primaryColor: input.primaryColor,
          secondaryColor: input.secondaryColor,
          description: input.description,
          sortIndex: input.collectionNumber,
          createdAtUtc: now,
        ),
        mediaAssets: [
          _asset(
            id: mediaAssetId,
            collectionId: collectionId,
            ownerId: cardId.value,
            relativePath: imagePath,
            fileSize: photo.imageFileSize,
            createdAtUtc: now,
          ),
          _asset(
            id: thumbnailAssetId,
            collectionId: collectionId,
            ownerId: cardId.value,
            relativePath: thumbnailPath,
            fileSize: photo.thumbnailFileSize,
            createdAtUtc: now,
          ),
        ],
        fields: _fieldsFor(cardId, input.comicFields),
      );
      final created = await _cardRepository.createCard(graph);
      await _projectRepository.touchUpdatedAt(projectId);
      return created;
    } catch (_) {
      for (final path in copiedPaths) {
        await _deleteQuietly(path);
      }
      rethrow;
    } finally {
      await _deleteTemps(photo);
    }
  }

  MediaAsset _asset({
    required MediaAssetId id,
    required CollectionId collectionId,
    required String ownerId,
    required RelativeMediaPath relativePath,
    required int fileSize,
    required DateTime createdAtUtc,
  }) {
    return MediaAsset(
      id: id,
      collectionId: collectionId,
      ownerType: MediaOwnerType.card,
      ownerId: ownerId,
      mediaType: MediaType.image,
      relativePath: relativePath,
      thumbnailRelativePath: null,
      mimeType: 'image/webp',
      width: null,
      height: null,
      durationMs: null,
      fileSize: fileSize,
      sha256: null,
      createdAtUtc: createdAtUtc,
    );
  }

  List<CardFieldValue> _fieldsFor(CardId cardId, List<ComicFieldInput> fields) {
    return [
      for (var index = 0; index < fields.length; index++)
        CardFieldValue(
          id: _uuidGenerator.cardFieldValueId(),
          cardId: cardId,
          fieldType: fields[index].type,
          value: fields[index].value,
          displayOrder: index,
        ),
    ];
  }

  void _validate({required ImageCardInput input, required bool duplicate}) {
    if (duplicate) {
      throw const DuplicateEntityFailure('Ese numero ya esta utilizado.');
    }
    final validation = CardValidation.validate(
      hasPhoto: input.photo != null,
      name: input.name,
      health: input.health,
      collectionNumber: input.collectionNumber,
      isDuplicateCollectionNumber: false,
      rarityId: input.rarityId.value,
      templateId: input.templateId,
      frameId: input.frameId,
      description: input.description,
      comicFields: input.comicFields,
    );
    if (!validation.canSave) {
      throw const InvalidEntityFailure('La carta no es valida.');
    }
  }

  Future<void> _deleteTemps(PendingCardPhoto photo) async {
    for (final path in photo.tempPaths) {
      await _storage.deleteAbsolute(path);
    }
  }

  Future<void> _deleteQuietly(RelativeMediaPath path) async {
    try {
      await _storage.delete(path);
    } on Object catch (error, stackTrace) {
      debugPrint('Failed to delete media file $path: $error\n$stackTrace');
    }
  }
}

final class UpdateImageCard {
  const UpdateImageCard(
    this._cardRepository,
    this._projectRepository,
    this._storage,
    this._uuidGenerator,
    this._clock,
  );

  final CardRepository _cardRepository;
  final CollectionProjectRepository _projectRepository;
  final ProjectMediaStorage _storage;
  final UuidGenerator _uuidGenerator;
  final Clock _clock;

  Future<ImageCardDetails> call({
    required CollectionProjectId projectId,
    required CardId cardId,
    required ImageCardInput input,
  }) async {
    final current = await _cardRepository.getImageCardById(cardId);
    final duplicate = await _cardRepository.collectionNumberExists(
      collectionId: current.card.collectionId,
      contentVersionId: current.card.contentVersionId,
      collectionNumber: input.collectionNumber,
      excludingCardId: cardId,
    );
    _validate(input: input, duplicate: duplicate, hasExistingPhoto: true);

    final photo = input.photo;
    final copiedPaths = <RelativeMediaPath>[];
    final obsoletePaths = <RelativeMediaPath>[
      if (photo != null) current.mediaAsset.relativePath,
      if (photo != null && current.thumbnailAsset != null)
        current.thumbnailAsset!.relativePath,
    ];

    final mediaAssetId = photo == null
        ? current.card.mediaAssetId
        : _uuidGenerator.mediaAssetId();
    final thumbnailAssetId = photo == null
        ? current.card.thumbnailAssetId
        : _uuidGenerator.mediaAssetId();
    final now = _clock.nowUtc();

    try {
      final mediaAssets = <MediaAsset>[];
      if (photo != null && thumbnailAssetId != null) {
        final imagePath = _storage.cardImagePath(
          projectId: projectId,
          assetId: mediaAssetId,
        );
        final thumbnailPath = _storage.cardThumbnailPath(
          projectId: projectId,
          assetId: thumbnailAssetId,
        );
        await _storage.copyFile(
          sourcePath: photo.imagePath,
          destination: imagePath,
        );
        copiedPaths.add(imagePath);
        await _storage.copyFile(
          sourcePath: photo.thumbnailPath,
          destination: thumbnailPath,
        );
        copiedPaths.add(thumbnailPath);
        mediaAssets
          ..add(
            _asset(
              id: mediaAssetId,
              collectionId: current.card.collectionId,
              ownerId: cardId.value,
              relativePath: imagePath,
              fileSize: photo.imageFileSize,
              createdAtUtc: now,
            ),
          )
          ..add(
            _asset(
              id: thumbnailAssetId,
              collectionId: current.card.collectionId,
              ownerId: cardId.value,
              relativePath: thumbnailPath,
              fileSize: photo.thumbnailFileSize,
              createdAtUtc: now,
            ),
          );
      } else {
        mediaAssets
          ..add(current.mediaAsset)
          ..addAll([
            if (current.thumbnailAsset != null) current.thumbnailAsset!,
          ]);
      }

      final updated = await _cardRepository.updateCard(
        ImageCardGraph(
          card: domain.Card(
            id: cardId,
            collectionId: current.card.collectionId,
            contentVersionId: current.card.contentVersionId,
            collectionNumber: input.collectionNumber,
            name: input.name,
            health: input.health,
            rarityId: input.rarityId,
            mediaAssetId: mediaAssetId,
            mediaType: MediaType.image,
            thumbnailAssetId: thumbnailAssetId,
            templateId: input.templateId,
            frameId: input.frameId,
            primaryColor: input.primaryColor,
            secondaryColor: input.secondaryColor,
            description: input.description,
            sortIndex: input.collectionNumber,
            createdAtUtc: current.card.createdAtUtc,
          ),
          mediaAssets: mediaAssets,
          fields: _fieldsFor(cardId, input.comicFields),
        ),
      );
      await _projectRepository.touchUpdatedAt(projectId);
      for (final path in obsoletePaths) {
        await _deleteQuietly(path);
      }
      return updated;
    } catch (_) {
      for (final path in copiedPaths) {
        await _deleteQuietly(path);
      }
      rethrow;
    } finally {
      if (photo != null) {
        await _deleteTemps(photo);
      }
    }
  }

  MediaAsset _asset({
    required MediaAssetId id,
    required CollectionId collectionId,
    required String ownerId,
    required RelativeMediaPath relativePath,
    required int fileSize,
    required DateTime createdAtUtc,
  }) {
    return MediaAsset(
      id: id,
      collectionId: collectionId,
      ownerType: MediaOwnerType.card,
      ownerId: ownerId,
      mediaType: MediaType.image,
      relativePath: relativePath,
      thumbnailRelativePath: null,
      mimeType: 'image/webp',
      width: null,
      height: null,
      durationMs: null,
      fileSize: fileSize,
      sha256: null,
      createdAtUtc: createdAtUtc,
    );
  }

  List<CardFieldValue> _fieldsFor(CardId cardId, List<ComicFieldInput> fields) {
    return [
      for (var index = 0; index < fields.length; index++)
        CardFieldValue(
          id: _uuidGenerator.cardFieldValueId(),
          cardId: cardId,
          fieldType: fields[index].type,
          value: fields[index].value,
          displayOrder: index,
        ),
    ];
  }

  void _validate({
    required ImageCardInput input,
    required bool duplicate,
    required bool hasExistingPhoto,
  }) {
    if (duplicate) {
      throw const DuplicateEntityFailure('Ese numero ya esta utilizado.');
    }
    final validation = CardValidation.validate(
      hasPhoto: hasExistingPhoto || input.photo != null,
      name: input.name,
      health: input.health,
      collectionNumber: input.collectionNumber,
      isDuplicateCollectionNumber: false,
      rarityId: input.rarityId.value,
      templateId: input.templateId,
      frameId: input.frameId,
      description: input.description,
      comicFields: input.comicFields,
    );
    if (!validation.canSave) {
      throw const InvalidEntityFailure('La carta no es valida.');
    }
  }

  Future<void> _deleteTemps(PendingCardPhoto photo) async {
    for (final path in photo.tempPaths) {
      await _storage.deleteAbsolute(path);
    }
  }

  Future<void> _deleteQuietly(RelativeMediaPath path) async {
    try {
      await _storage.delete(path);
    } on Object catch (error, stackTrace) {
      debugPrint('Failed to delete media file $path: $error\n$stackTrace');
    }
  }
}

final class DeleteImageCard {
  const DeleteImageCard(
    this._cardRepository,
    this._projectRepository,
    this._storage,
  );

  final CardRepository _cardRepository;
  final CollectionProjectRepository _projectRepository;
  final ProjectMediaStorage _storage;

  Future<void> call({
    required CollectionProjectId projectId,
    required CardId cardId,
  }) async {
    final deleted = await _cardRepository.deleteCard(cardId);
    await _projectRepository.touchUpdatedAt(projectId);
    await _deleteQuietly(deleted.mediaAsset.relativePath);
    final thumbnail = deleted.thumbnailAsset;
    if (thumbnail != null) {
      await _deleteQuietly(thumbnail.relativePath);
    }
  }

  Future<void> _deleteQuietly(RelativeMediaPath path) async {
    try {
      await _storage.delete(path);
    } on Object catch (error, stackTrace) {
      debugPrint('Failed to delete media file $path: $error\n$stackTrace');
    }
  }
}
