import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gachadex/core/database/app_database.dart';
import 'package:gachadex/core/errors/app_failure.dart';
import 'package:gachadex/core/files/project_media_storage.dart';
import 'package:gachadex/core/identifiers/entity_id.dart';
import 'package:gachadex/core/identifiers/uuid_generator.dart';
import 'package:gachadex/core/time/fake_clock.dart';
import 'package:gachadex/features/cards/application/card_photo_processor.dart';
import 'package:gachadex/features/cards/application/card_use_cases.dart';
import 'package:gachadex/features/cards/data/repositories/drift_card_repository.dart';
import 'package:gachadex/features/cards/domain/catalogs/card_template_catalog.dart';
import 'package:gachadex/features/cards/domain/validation/card_validation.dart';
import 'package:gachadex/features/cards/domain/value_objects/card_field_type.dart';
import 'package:gachadex/features/collection_creator/data/repositories/drift_collection_project_repository.dart';
import 'package:gachadex/features/rarities/domain/catalogs/rarity_visual_catalog.dart';

import '../../helpers/database_seed.dart';
import '../../helpers/database_test_utils.dart';

void main() {
  group('Card validation', () {
    test('rejects invalid required values and duplicate number', () {
      final validation = CardValidation.validate(
        hasPhoto: false,
        name: '   ',
        health: 10000,
        collectionNumber: 0,
        isDuplicateCollectionNumber: true,
        rarityId: null,
        templateId: 'missing',
        frameId: 'missing',
        description: List.filled(501, 'a').join(),
        comicFields: const [],
      );

      expect(
        validation.issues,
        containsAll([
          CardValidationIssue.photoRequired,
          CardValidationIssue.emptyName,
          CardValidationIssue.invalidHealth,
          CardValidationIssue.invalidCollectionNumber,
          CardValidationIssue.duplicateCollectionNumber,
          CardValidationIssue.rarityRequired,
          CardValidationIssue.invalidTemplate,
          CardValidationIssue.invalidFrame,
          CardValidationIssue.descriptionTooLong,
        ]),
      );
      expect(validation.canSave, isFalse);
    });

    test('accepts a valid image card form', () {
      final validation = CardValidation.validate(
        hasPhoto: true,
        name: 'Cumple sorpresa',
        health: 120,
        collectionNumber: 7,
        isDuplicateCollectionNumber: false,
        rarityId: testUuid(1),
        templateId: CardTemplateCatalog.defaultTemplateId,
        frameId: CardTemplateCatalog.defaultFrameId,
        description: 'Momento del grupo',
        comicFields: const [
          ComicFieldInput(
            type: CardFieldType.famousQuote,
            value: 'Hoy se cena fuerte',
          ),
        ],
      );

      expect(validation.canSave, isTrue);
    });
  });

  group('Image card use cases', () {
    late Directory tempDir;
    late Directory storageDir;
    late AppDatabase database;
    late DriftCardRepository cardRepository;
    late DriftCollectionProjectRepository projectRepository;
    late LocalProjectMediaStorage storage;
    late FakeClock clock;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('gachadex_card_test_');
      storageDir = Directory('${tempDir.path}${Platform.pathSeparator}media');
      database = createFileDatabase(
        File('${tempDir.path}${Platform.pathSeparator}db.sqlite'),
      );
      cardRepository = DriftCardRepository(database: database);
      clock = FakeClock(testNowUtc());
      projectRepository = DriftCollectionProjectRepository(
        database: database,
        clock: clock,
        uuidGenerator: FixedUuidGenerator([
          testUuid(1001),
          testUuid(1002),
          testUuid(1003),
        ]),
      );
      storage = LocalProjectMediaStorage(rootDirectory: storageDir);
    });

    tearDown(() async {
      await database.close();
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    test(
      'creates, persists, updates and deletes a card with private files',
      () async {
        final createdDraft = await projectRepository.createDraft(name: 'Viaje');
        final rarityId = RarityId(testUuid(2001));
        await _insertRarity(
          database,
          collectionId: createdDraft.project.collectionId,
          contentVersionId: createdDraft.contentVersion.id,
          rarityId: rarityId,
        );
        final photo = _writePendingPhoto(tempDir, 'first');
        final useCase = CreateImageCard(
          cardRepository,
          projectRepository,
          storage,
          FixedUuidGenerator([
            testUuid(3001),
            testUuid(3002),
            testUuid(3003),
            testUuid(3004),
          ]),
          clock,
        );

        final created = await useCase.call(
          projectId: createdDraft.project.id,
          collectionId: createdDraft.project.collectionId,
          contentVersionId: createdDraft.contentVersion.id,
          input: _input(rarityId: rarityId, photo: photo),
        );

        expect(created.card.name, 'Carta valida');
        expect(created.mediaAsset.relativePath.value, endsWith('.webp'));
        expect(created.thumbnailAsset?.relativePath.value, endsWith('.webp'));
        expect(await storage.exists(created.mediaAsset.relativePath), isTrue);
        expect(
          await storage.exists(created.thumbnailAsset!.relativePath),
          isTrue,
        );
        expect(File(photo.imagePath).existsSync(), isFalse);

        await database.close();
        database = createFileDatabase(
          File('${tempDir.path}${Platform.pathSeparator}db.sqlite'),
        );
        cardRepository = DriftCardRepository(database: database);
        projectRepository = DriftCollectionProjectRepository(
          database: database,
          clock: clock,
          uuidGenerator: FixedUuidGenerator(const []),
        );
        final reopened = await cardRepository.getImageCardById(created.card.id);

        expect(reopened.card.id, created.card.id);
        expect(await storage.exists(reopened.mediaAsset.relativePath), isTrue);

        final update = UpdateImageCard(
          cardRepository,
          projectRepository,
          storage,
          FixedUuidGenerator([testUuid(4001), testUuid(4002), testUuid(4003)]),
          clock,
        );
        final updated = await update.call(
          projectId: createdDraft.project.id,
          cardId: created.card.id,
          input: _input(
            rarityId: rarityId,
            collectionNumber: 8,
            name: 'Carta editada',
            photo: null,
          ),
        );

        expect(updated.card.id, created.card.id);
        expect(updated.card.name, 'Carta editada');
        expect(
          await cardRepository.collectionNumberExists(
            collectionId: createdDraft.project.collectionId,
            contentVersionId: createdDraft.contentVersion.id,
            collectionNumber: 8,
            excludingCardId: created.card.id,
          ),
          isFalse,
        );

        await DeleteImageCard(
          cardRepository,
          projectRepository,
          storage,
        ).call(projectId: createdDraft.project.id, cardId: created.card.id);

        expect(await database.select(database.cards).get(), isEmpty);
        expect(await database.select(database.mediaAssets).get(), isEmpty);
        expect(await storage.exists(updated.mediaAsset.relativePath), isFalse);
      },
    );

    test(
      'keeps the old photo when replacing image fails in database',
      () async {
        final createdDraft = await projectRepository.createDraft(name: 'Grupo');
        final rarityId = RarityId(testUuid(5001));
        await _insertRarity(
          database,
          collectionId: createdDraft.project.collectionId,
          contentVersionId: createdDraft.contentVersion.id,
          rarityId: rarityId,
        );
        final created =
            await CreateImageCard(
              cardRepository,
              projectRepository,
              storage,
              FixedUuidGenerator([
                testUuid(5101),
                testUuid(5102),
                testUuid(5103),
                testUuid(5104),
              ]),
              clock,
            ).call(
              projectId: createdDraft.project.id,
              collectionId: createdDraft.project.collectionId,
              contentVersionId: createdDraft.contentVersion.id,
              input: _input(
                rarityId: rarityId,
                photo: _writePendingPhoto(tempDir, 'ok'),
              ),
            );
        final replacement = _writePendingPhoto(tempDir, 'replacement');

        await expectLater(
          UpdateImageCard(
            cardRepository,
            projectRepository,
            storage,
            FixedUuidGenerator([
              testUuid(5201),
              testUuid(5202),
              testUuid(5203),
            ]),
            clock,
          ).call(
            projectId: createdDraft.project.id,
            cardId: created.card.id,
            input: _input(
              rarityId: RarityId(testUuid(9999)),
              photo: replacement,
            ),
          ),
          throwsA(isA<ReferentialIntegrityFailure>()),
        );

        expect(await storage.exists(created.mediaAsset.relativePath), isTrue);
        expect(File(replacement.imagePath).existsSync(), isFalse);
        expect(
          await storage.exists(
            storage.cardImagePath(
              projectId: createdDraft.project.id,
              assetId: MediaAssetId(testUuid(5201)),
            ),
          ),
          isFalse,
        );
      },
    );
  });
}

ImageCardInput _input({
  required RarityId rarityId,
  required PendingCardPhoto? photo,
  int collectionNumber = 1,
  String name = 'Carta valida',
}) {
  return ImageCardInput(
    collectionNumber: collectionNumber,
    name: name,
    health: 100,
    rarityId: rarityId,
    templateId: CardTemplateCatalog.defaultTemplateId,
    frameId: CardTemplateCatalog.defaultFrameId,
    primaryColor: CardTemplateCatalog.defaultPrimaryColor,
    secondaryColor: CardTemplateCatalog.defaultSecondaryColor,
    description: 'Descripcion',
    comicFields: const [
      ComicFieldInput(type: CardFieldType.nickname, value: 'Capitan'),
    ],
    photo: photo,
  );
}

PendingCardPhoto _writePendingPhoto(Directory directory, String name) {
  final image = File('${directory.path}${Platform.pathSeparator}$name.webp');
  final thumb = File(
    '${directory.path}${Platform.pathSeparator}$name-thumb.webp',
  );
  image.writeAsBytesSync([1, 2, 3, 4]);
  thumb.writeAsBytesSync([1, 2]);
  return PendingCardPhoto(
    imagePath: image.path,
    thumbnailPath: thumb.path,
    imageFileSize: image.lengthSync(),
    thumbnailFileSize: thumb.lengthSync(),
  );
}

Future<void> _insertRarity(
  AppDatabase database, {
  required CollectionId collectionId,
  required ContentVersionId contentVersionId,
  required RarityId rarityId,
}) {
  return database
      .into(database.rarities)
      .insert(
        RaritiesCompanion(
          id: Value(rarityId.value),
          collectionId: Value(collectionId.value),
          contentVersionId: Value(contentVersionId.value),
          name: const Value('Normal'),
          orderIndex: const Value(0),
          colorValue: const Value(RarityVisualCatalog.defaultColorValue),
          iconId: const Value(RarityVisualCatalog.defaultIconId),
          frameId: const Value(RarityVisualCatalog.defaultFrameId),
          effectId: const Value(RarityVisualCatalog.defaultEffectId),
          sellValue: const Value(1),
          isEnabled: const Value(true),
        ),
      );
}
