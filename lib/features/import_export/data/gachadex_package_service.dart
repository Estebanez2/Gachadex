// ignore_for_file: prefer_initializing_formals

import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../../core/database/app_database.dart';
import '../../../core/domain/domain_enums.dart';
import '../../../core/files/project_media_storage.dart';
import '../../../core/identifiers/uuid_generator.dart';
import '../../../core/time/clock.dart';
import '../../../core/value_objects/relative_media_path.dart';
import '../domain/gachadex_package_constants.dart';
import '../domain/gachadex_package_failure.dart';

final class GachadexPackagePreview {
  const GachadexPackagePreview({
    required this.collectionId,
    required this.contentVersionId,
    required this.name,
    required this.author,
    required this.cardCount,
    required this.videoCount,
    required this.packTypeCount,
    required this.totalBytes,
    required this.alreadyInstalled,
  });

  final String collectionId;
  final String contentVersionId;
  final String name;
  final String? author;
  final int cardCount;
  final int videoCount;
  final int packTypeCount;
  final int totalBytes;
  final bool alreadyInstalled;
}

final class GachadexImportResult {
  const GachadexImportResult({required this.installedCollectionId});

  final String installedCollectionId;
}

final class GachadexPackageService {
  const GachadexPackageService({
    required AppDatabase database,
    required ProjectMediaStorage mediaStorage,
    required UuidGenerator uuidGenerator,
    required Clock clock,
    Directory? tempDirectory,
  }) : _database = database,
       _mediaStorage = mediaStorage,
       _uuidGenerator = uuidGenerator,
       _clock = clock,
       _tempDirectory = tempDirectory;

  static const _manifestPath = 'manifest.json';
  static const _collectionPath = 'collection.json';
  static const _maxFileCount = 1000;
  static const _maxJsonBytes = 5 * 1024 * 1024;
  static const _maxPackageBytes = 500 * 1024 * 1024;
  static const _maxMediaBytes = 150 * 1024 * 1024;

  final AppDatabase _database;
  final ProjectMediaStorage _mediaStorage;
  final UuidGenerator _uuidGenerator;
  final Clock _clock;
  final Directory? _tempDirectory;

  Future<File> exportInstalledCollection(String installedCollectionId) async {
    final installed =
        await (_database.select(_database.installedCollections)
              ..where((table) => table.id.equals(installedCollectionId)))
            .getSingleOrNull();
    if (installed == null) {
      throw const GachadexPackageFailure('Coleccion no encontrada.');
    }
    if (installed.mainPackTypeId == null) {
      throw const GachadexPackageFailure(
        'La coleccion no tiene sobre principal.',
      );
    }

    final package = await _readDefinition(
      collectionId: installed.collectionId,
      contentVersionId: installed.contentVersionId,
    );

    final tempDir = _tempDirectory ?? await getTemporaryDirectory();
    final fileName = '${_slug(installed.name)}$gachadexPackageExtension';
    final output = File(p.join(tempDir.path, fileName));
    if (await output.exists()) {
      await output.delete();
    }

    final encoder = ZipFileEncoder();
    encoder.create(output.path, level: DeflateLevel.none);
    final tempFiles = <File>[];
    try {
      final assetFiles = <_ExportAssetFile>[];
      for (final asset in package.mediaAssets) {
        for (final relativePath in _mediaPathsForAsset(asset)) {
          final assetPath = RelativeMediaPath(relativePath);
          final source = await _mediaStorage.resolve(assetPath);
          if (!await source.exists()) {
            throw GachadexPackageFailure(
              'Falta el archivo multimedia $relativePath.',
            );
          }
          assetFiles.add(
            _ExportAssetFile(
              relativePath: relativePath,
              file: source,
              size: await source.length(),
              sha256: await _sha256File(source),
            ),
          );
        }
      }

      final collectionFile = await _writeTempJson(
        tempDir: tempDir,
        name: _collectionPath,
        jsonMap: package.toJson(),
      );
      final manifest = _buildManifest(
        installed: installed,
        package: package,
        collectionSize: await collectionFile.length(),
        collectionSha256: await _sha256File(collectionFile),
        assetFiles: assetFiles,
      );
      final manifestFile = await _writeTempJson(
        tempDir: tempDir,
        name: _manifestPath,
        jsonMap: manifest,
      );
      tempFiles.addAll([collectionFile, manifestFile]);

      await encoder.addFile(
        manifestFile,
        _manifestPath,
        DeflateLevel.bestSpeed,
      );
      await encoder.addFile(
        collectionFile,
        _collectionPath,
        DeflateLevel.bestSpeed,
      );

      for (final asset in assetFiles) {
        await encoder.addFile(
          asset.file,
          _assetArchivePath(asset.relativePath),
          DeflateLevel.none,
        );
      }
    } finally {
      await encoder.close();
      for (final file in tempFiles) {
        if (await file.exists()) {
          await file.delete();
        }
      }
    }

    return output;
  }

  Future<GachadexPackagePreview> previewFile(String packagePath) async {
    final archive = await _decodePackage(packagePath);
    final manifest = _readManifest(archive);
    final duplicate = await _isInstalled(
      collectionId: manifest.collectionId,
      contentVersionId: manifest.contentVersionId,
    );
    return GachadexPackagePreview(
      collectionId: manifest.collectionId,
      contentVersionId: manifest.contentVersionId,
      name: manifest.name,
      author: manifest.author,
      cardCount: manifest.cardCount,
      videoCount: manifest.videoCount,
      packTypeCount: manifest.packTypeCount,
      totalBytes: manifest.totalBytes,
      alreadyInstalled: duplicate,
    );
  }

  Future<GachadexImportResult> importFile(String packagePath) async {
    final archive = await _decodePackage(packagePath);
    final manifest = _readManifest(archive);
    final collection = _readCollection(archive);

    if (manifest.collectionId != collection.collectionVersion.collectionId ||
        manifest.contentVersionId != collection.collectionVersion.id) {
      throw const GachadexPackageFailure(
        'El manifiesto no coincide con la coleccion.',
      );
    }
    if (await _isInstalled(
      collectionId: manifest.collectionId,
      contentVersionId: manifest.contentVersionId,
    )) {
      throw const GachadexPackageFailure('Esta coleccion ya esta instalada.');
    }

    _validateRelations(collection);
    _verifyManifestFiles(archive, manifest);

    final copiedFiles = <File>[];
    final now = _clock.nowUtc();
    final installedCollectionId = _uuidGenerator.generate();
    try {
      for (final relativePath in _mediaPaths(collection)) {
        final targetPath = RelativeMediaPath(relativePath);
        final target = await _mediaStorage.resolve(targetPath);
        await target.parent.create(recursive: true);
        final archiveFile = _requiredFile(
          archive,
          _assetArchivePath(relativePath),
        );
        await target.writeAsBytes(archiveFile.content, flush: true);
        copiedFiles.add(target);
      }

      await _database.transaction(() async {
        if (await _isInstalled(
          collectionId: manifest.collectionId,
          contentVersionId: manifest.contentVersionId,
        )) {
          throw const GachadexPackageFailure(
            'Esta coleccion ya esta instalada.',
          );
        }

        await _database
            .into(_database.contentVersions)
            .insert(collection.collectionVersion.toCompanion(false));
        for (final rarity in collection.rarities) {
          await _database
              .into(_database.rarities)
              .insert(rarity.toCompanion(false));
        }
        for (final asset in collection.mediaAssets) {
          await _database
              .into(_database.mediaAssets)
              .insert(asset.toCompanion(false));
        }
        for (final card in collection.cards) {
          await _database.into(_database.cards).insert(card.toCompanion(false));
        }
        for (final field in collection.cardFields) {
          await _database
              .into(_database.cardFieldValues)
              .insert(field.toCompanion(false));
        }
        for (final pack in collection.packTypes) {
          await _database
              .into(_database.packTypes)
              .insert(pack.toCompanion(false));
        }
        for (final pool in collection.packCardPool) {
          await _database
              .into(_database.packCardPool)
              .insert(pool.toCompanion(false));
        }
        for (final rule in collection.packSlotRules) {
          await _database
              .into(_database.packSlotRules)
              .insert(rule.toCompanion(false));
        }
        for (final probability in collection.packRarityProbabilities) {
          await _database
              .into(_database.packRarityProbabilities)
              .insert(probability.toCompanion(false));
        }

        await _database
            .into(_database.installedCollections)
            .insert(
              InstalledCollectionsCompanion(
                id: Value(installedCollectionId),
                collectionId: Value(manifest.collectionId),
                contentVersionId: Value(manifest.contentVersionId),
                name: Value(manifest.name),
                author: Value(manifest.author),
                description: Value(collection.description),
                coverRelativePath: Value(collection.coverRelativePath),
                mainPackTypeId: Value(manifest.mainPackTypeId),
                installedAtUtc: Value(now),
                source: const Value(InstalledCollectionSource.imported),
                coins: const Value(0),
                totalCardCount: Value(collection.cards.length),
                distinctOwnedCount: const Value(0),
              ),
            );

        for (final pack in collection.packTypes) {
          final initial = pack.id == manifest.mainPackTypeId
              ? gachadexStartingPackCount
              : 0;
          await _database
              .into(_database.packInventory)
              .insert(
                PackInventoryCompanion(
                  installedCollectionId: Value(installedCollectionId),
                  packTypeId: Value(pack.id),
                  availableCount: Value(initial.clamp(0, pack.maxAccumulated)),
                  maxAccumulated: Value(pack.maxAccumulated),
                  nextRechargeAtUtc: Value(
                    now.add(Duration(seconds: pack.rechargeSeconds)),
                  ),
                  lastCalculatedAtUtc: Value(now),
                ),
              );
        }
      });
    } on Object {
      for (final file in copiedFiles) {
        if (await file.exists()) {
          await file.delete();
        }
      }
      rethrow;
    }

    return GachadexImportResult(installedCollectionId: installedCollectionId);
  }

  Future<_PackageDefinition> _readDefinition({
    required String collectionId,
    required String contentVersionId,
  }) async {
    final version =
        await (_database.select(_database.contentVersions)..where(
              (table) =>
                  table.collectionId.equals(collectionId) &
                  table.id.equals(contentVersionId),
            ))
            .getSingleOrNull();
    if (version == null) {
      throw const GachadexPackageFailure('Version de contenido no encontrada.');
    }

    final rarities =
        await (_database.select(_database.rarities)..where(
              (table) =>
                  table.collectionId.equals(collectionId) &
                  table.contentVersionId.equals(contentVersionId),
            ))
            .get();
    final assets = await (_database.select(
      _database.mediaAssets,
    )..where((table) => table.collectionId.equals(collectionId))).get();
    final cards =
        await (_database.select(_database.cards)..where(
              (table) =>
                  table.collectionId.equals(collectionId) &
                  table.contentVersionId.equals(contentVersionId),
            ))
            .get();
    final cardFields = await (_database.select(
      _database.cardFieldValues,
    )..where((table) => table.cardId.isIn(cards.map((card) => card.id)))).get();
    final packs =
        await (_database.select(_database.packTypes)..where(
              (table) =>
                  table.collectionId.equals(collectionId) &
                  table.contentVersionId.equals(contentVersionId),
            ))
            .get();
    final packIds = packs.map((pack) => pack.id).toList();
    final pool = await (_database.select(
      _database.packCardPool,
    )..where((table) => table.packTypeId.isIn(packIds))).get();
    final rules = await (_database.select(
      _database.packSlotRules,
    )..where((table) => table.packTypeId.isIn(packIds))).get();
    final probabilities = rules.isEmpty
        ? <PackRarityProbabilityRow>[]
        : await (_database.select(_database.packRarityProbabilities)..where(
                (table) => table.probabilityGroupId.isIn(
                  rules
                      .map((rule) => rule.probabilityGroupId)
                      .whereType<String>(),
                ),
              ))
              .get();
    final installed =
        await (_database.select(_database.installedCollections)
              ..where(
                (table) => table.contentVersionId.equals(contentVersionId),
              )
              ..limit(1))
            .getSingleOrNull();

    return _PackageDefinition(
      collectionVersion: version,
      name: installed?.name ?? 'Coleccion',
      author: installed?.author,
      description: installed?.description,
      coverRelativePath: installed?.coverRelativePath,
      rarities: rarities,
      mediaAssets: assets,
      cards: cards,
      cardFields: cardFields,
      packTypes: packs,
      packCardPool: pool,
      packSlotRules: rules,
      packRarityProbabilities: probabilities,
    );
  }

  Map<String, Object?> _buildManifest({
    required InstalledCollectionRow installed,
    required _PackageDefinition package,
    required int collectionSize,
    required String collectionSha256,
    required List<_ExportAssetFile> assetFiles,
  }) {
    var totalBytes = collectionSize;
    final files = <Map<String, Object?>>[];
    files.add({
      'path': _collectionPath,
      'size': collectionSize,
      'sha256': collectionSha256,
    });
    for (final asset in assetFiles) {
      totalBytes += asset.size;
      files.add({
        'path': _assetArchivePath(asset.relativePath),
        'size': asset.size,
        'sha256': asset.sha256,
      });
    }

    return {
      'format': gachadexPackageFormat,
      'formatVersion': gachadexPackageFormatVersion,
      'collectionId': installed.collectionId,
      'contentVersionId': installed.contentVersionId,
      'contentVersion': package.collectionVersion.versionNumber,
      'name': installed.name,
      'author': installed.author,
      'mainPackTypeId': installed.mainPackTypeId,
      'startingPacks': gachadexStartingPackCount,
      'createdAt': _clock.nowUtc().toIso8601String(),
      'cardCount': package.cards.length,
      'videoCount': package.cards
          .where((card) => card.mediaType == MediaType.video)
          .length,
      'rarityCount': package.rarities.length,
      'packTypeCount': package.packTypes.length,
      'totalBytes': totalBytes,
      'files': files,
    };
  }

  Future<File> _writeTempJson({
    required Directory tempDir,
    required String name,
    required Map<String, Object?> jsonMap,
  }) async {
    final file = File(
      p.join(
        tempDir.path,
        'gachadex-${DateTime.now().microsecondsSinceEpoch}-$name',
      ),
    );
    await file.writeAsString(jsonEncode(jsonMap), flush: true);
    return file;
  }

  Future<String> _sha256File(File file) async {
    final digest = await sha256.bind(file.openRead()).first;
    return digest.toString();
  }

  Future<Archive> _decodePackage(String packagePath) async {
    if (!packagePath.toLowerCase().endsWith(gachadexPackageExtension)) {
      throw const GachadexPackageFailure(
        'El archivo debe terminar en .gachadex.',
      );
    }
    final file = File(packagePath);
    if (!await file.exists()) {
      throw const GachadexPackageFailure('Archivo no encontrado.');
    }
    final size = await file.length();
    if (size > _maxPackageBytes) {
      throw const GachadexPackageFailure('El paquete es demasiado grande.');
    }

    try {
      final archive = ZipDecoder().decodeBytes(await file.readAsBytes());
      _validateArchiveLayout(archive);
      return archive;
    } on GachadexPackageFailure {
      rethrow;
    } on Object {
      throw const GachadexPackageFailure(
        'No se pudo leer el paquete .gachadex.',
      );
    }
  }

  void _validateArchiveLayout(Archive archive) {
    if (archive.length > _maxFileCount) {
      throw const GachadexPackageFailure(
        'El paquete contiene demasiados archivos.',
      );
    }
    final names = <String>{};
    for (final entry in archive) {
      if (!entry.isFile) {
        throw const GachadexPackageFailure(
          'El paquete contiene entradas no validas.',
        );
      }
      final name = entry.name;
      _validateArchivePath(name);
      if (!names.add(name)) {
        throw const GachadexPackageFailure(
          'El paquete contiene archivos duplicados.',
        );
      }
      if (entry.size > _maxMediaBytes) {
        throw const GachadexPackageFailure(
          'Un archivo del paquete es demasiado grande.',
        );
      }
    }
  }

  _PackageManifest _readManifest(Archive archive) {
    final entry = _requiredFile(archive, _manifestPath);
    if (entry.size > _maxJsonBytes) {
      throw const GachadexPackageFailure('El manifiesto es demasiado grande.');
    }
    final map = _decodeJsonMap(entry.content);
    return _PackageManifest.fromJson(map);
  }

  _PackageDefinition _readCollection(Archive archive) {
    final entry = _requiredFile(archive, _collectionPath);
    if (entry.size > _maxJsonBytes) {
      throw const GachadexPackageFailure('El contenido es demasiado grande.');
    }
    final map = _decodeJsonMap(entry.content);
    return _PackageDefinition.fromJson(map);
  }

  ArchiveFile _requiredFile(Archive archive, String path) {
    for (final entry in archive) {
      if (entry.name == path && entry.isFile) {
        return entry;
      }
    }
    throw GachadexPackageFailure('Falta $path en el paquete.');
  }

  Map<String, Object?> _decodeJsonMap(Uint8List bytes) {
    try {
      final decoded = jsonDecode(utf8.decode(bytes));
      if (decoded is Map<String, Object?>) {
        return decoded;
      }
    } on Object {
      throw const GachadexPackageFailure('El JSON del paquete no es valido.');
    }
    throw const GachadexPackageFailure('El JSON del paquete no es un objeto.');
  }

  void _verifyManifestFiles(Archive archive, _PackageManifest manifest) {
    final declared = <String>{};
    for (final file in manifest.files) {
      _validateArchivePath(file.path);
      if (!declared.add(file.path)) {
        throw const GachadexPackageFailure(
          'El manifiesto declara archivos duplicados.',
        );
      }
      final entry = _requiredFile(archive, file.path);
      if (entry.size != file.size) {
        throw const GachadexPackageFailure(
          'El tamano de un archivo no coincide.',
        );
      }
      final hash = sha256.convert(entry.content).toString();
      if (hash != file.sha256) {
        throw const GachadexPackageFailure(
          'El hash de un archivo no coincide.',
        );
      }
    }
  }

  Future<bool> _isInstalled({
    required String collectionId,
    required String contentVersionId,
  }) async {
    final row =
        await (_database.select(_database.installedCollections)
              ..where((table) => table.collectionId.equals(collectionId)))
            .getSingleOrNull();
    return row != null;
  }

  void _validateRelations(_PackageDefinition collection) {
    final version = collection.collectionVersion;
    final collectionId = version.collectionId;
    final contentVersionId = version.id;
    final rarityIds = collection.rarities.map((row) => row.id).toSet();
    final cardIds = collection.cards.map((row) => row.id).toSet();
    final assetIds = collection.mediaAssets.map((row) => row.id).toSet();
    final packIds = collection.packTypes.map((row) => row.id).toSet();
    final mainPacks = collection.packTypes.where((row) => row.isMain).toList();

    if (collection.cards.isEmpty ||
        collection.rarities.isEmpty ||
        collection.packTypes.isEmpty ||
        mainPacks.length != 1 ||
        mainPacks.single.maxAccumulated < gachadexStartingPackCount) {
      throw const GachadexPackageFailure('La coleccion esta incompleta.');
    }

    for (final row in collection.rarities) {
      _requireSameVersion(
        row.collectionId,
        row.contentVersionId,
        collectionId,
        contentVersionId,
      );
    }
    for (final row in collection.mediaAssets) {
      if (row.collectionId != collectionId || !assetIds.contains(row.id)) {
        throw const GachadexPackageFailure('Activo multimedia no valido.');
      }
      RelativeMediaPath(row.relativePath);
      if (row.thumbnailRelativePath != null) {
        RelativeMediaPath(row.thumbnailRelativePath!);
      }
    }
    for (final row in collection.cards) {
      _requireSameVersion(
        row.collectionId,
        row.contentVersionId,
        collectionId,
        contentVersionId,
      );
      if (!rarityIds.contains(row.rarityId) ||
          !assetIds.contains(row.mediaAssetId) ||
          (row.thumbnailAssetId != null &&
              !assetIds.contains(row.thumbnailAssetId))) {
        throw const GachadexPackageFailure('Carta con referencias no validas.');
      }
    }
    for (final row in collection.cardFields) {
      if (!cardIds.contains(row.cardId)) {
        throw const GachadexPackageFailure('Campo de carta no valido.');
      }
    }
    for (final row in collection.packTypes) {
      _requireSameVersion(
        row.collectionId,
        row.contentVersionId,
        collectionId,
        contentVersionId,
      );
      if ((row.frontAssetId != null && !assetIds.contains(row.frontAssetId)) ||
          (row.backAssetId != null && !assetIds.contains(row.backAssetId))) {
        throw const GachadexPackageFailure('Sobre con referencias no validas.');
      }
    }
    for (final row in collection.packCardPool) {
      if (!packIds.contains(row.packTypeId) || !cardIds.contains(row.cardId)) {
        throw const GachadexPackageFailure('Pool de sobre no valido.');
      }
    }
    for (final row in collection.packSlotRules) {
      if (!packIds.contains(row.packTypeId) ||
          (row.fixedRarityId != null &&
              !rarityIds.contains(row.fixedRarityId))) {
        throw const GachadexPackageFailure('Regla de sobre no valida.');
      }
    }
    for (final row in collection.packRarityProbabilities) {
      if (!rarityIds.contains(row.rarityId)) {
        throw const GachadexPackageFailure('Probabilidad de rareza no valida.');
      }
    }
  }

  void _requireSameVersion(
    String rowCollectionId,
    String rowContentVersionId,
    String collectionId,
    String contentVersionId,
  ) {
    if (rowCollectionId != collectionId ||
        rowContentVersionId != contentVersionId) {
      throw const GachadexPackageFailure(
        'La coleccion contiene datos cruzados.',
      );
    }
  }

  void _validateArchivePath(String value) {
    RelativeMediaPath(value);
    if (value.startsWith('assets/') ||
        value == _manifestPath ||
        value == _collectionPath) {
      return;
    }
    throw const GachadexPackageFailure(
      'El paquete contiene una ruta no permitida.',
    );
  }

  String _assetArchivePath(String relativePath) => 'assets/$relativePath';

  List<String> _mediaPaths(_PackageDefinition collection) {
    return collection.mediaAssets.expand(_mediaPathsForAsset).toSet().toList();
  }

  List<String> _mediaPathsForAsset(MediaAssetRow asset) {
    final paths = <String>[asset.relativePath];
    final thumbnail = asset.thumbnailRelativePath;
    if (thumbnail != null) {
      paths.add(thumbnail);
    }
    return paths;
  }

  String _slug(String input) {
    final normalized = input
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
        .replaceAll(RegExp(r'_+'), '_')
        .replaceAll(RegExp(r'^_|_$'), '');
    return normalized.isEmpty ? 'coleccion' : normalized;
  }
}

final class _PackageManifest {
  const _PackageManifest({
    required this.collectionId,
    required this.contentVersionId,
    required this.name,
    required this.author,
    required this.mainPackTypeId,
    required this.cardCount,
    required this.videoCount,
    required this.packTypeCount,
    required this.totalBytes,
    required this.files,
  });

  final String collectionId;
  final String contentVersionId;
  final String name;
  final String? author;
  final String mainPackTypeId;
  final int cardCount;
  final int videoCount;
  final int packTypeCount;
  final int totalBytes;
  final List<_ManifestFile> files;

  factory _PackageManifest.fromJson(Map<String, Object?> json) {
    if (json['format'] != gachadexPackageFormat ||
        json['formatVersion'] != gachadexPackageFormatVersion ||
        json['startingPacks'] != gachadexStartingPackCount) {
      throw const GachadexPackageFailure(
        'Version de paquete .gachadex no soportada.',
      );
    }
    return _PackageManifest(
      collectionId: _string(json, 'collectionId'),
      contentVersionId: _string(json, 'contentVersionId'),
      name: _string(json, 'name'),
      author: json['author'] as String?,
      mainPackTypeId: _string(json, 'mainPackTypeId'),
      cardCount: _int(json, 'cardCount'),
      videoCount: _int(json, 'videoCount'),
      packTypeCount: _int(json, 'packTypeCount'),
      totalBytes: _int(json, 'totalBytes'),
      files: _list(
        json,
        'files',
      ).map((value) => _ManifestFile.fromJson(_asMap(value))).toList(),
    );
  }
}

final class _ManifestFile {
  const _ManifestFile({
    required this.path,
    required this.size,
    required this.sha256,
  });

  final String path;
  final int size;
  final String sha256;

  factory _ManifestFile.fromJson(Map<String, Object?> json) {
    return _ManifestFile(
      path: _string(json, 'path'),
      size: _int(json, 'size'),
      sha256: _string(json, 'sha256'),
    );
  }
}

final class _PackageDefinition {
  const _PackageDefinition({
    required this.collectionVersion,
    required this.name,
    required this.author,
    required this.description,
    required this.coverRelativePath,
    required this.rarities,
    required this.mediaAssets,
    required this.cards,
    required this.cardFields,
    required this.packTypes,
    required this.packCardPool,
    required this.packSlotRules,
    required this.packRarityProbabilities,
  });

  final ContentVersionRow collectionVersion;
  final String name;
  final String? author;
  final String? description;
  final String? coverRelativePath;
  final List<RarityRow> rarities;
  final List<MediaAssetRow> mediaAssets;
  final List<CardRow> cards;
  final List<CardFieldValueRow> cardFields;
  final List<PackTypeRow> packTypes;
  final List<PackCardPoolRow> packCardPool;
  final List<PackSlotRuleRow> packSlotRules;
  final List<PackRarityProbabilityRow> packRarityProbabilities;

  Map<String, Object?> toJson() {
    return {
      'collectionVersion': _versionToJson(collectionVersion),
      'name': name,
      'author': author,
      'description': description,
      'coverRelativePath': coverRelativePath,
      'rarities': rarities.map(_rarityToJson).toList(),
      'mediaAssets': mediaAssets.map(_assetToJson).toList(),
      'cards': cards.map(_cardToJson).toList(),
      'cardFields': cardFields.map(_cardFieldToJson).toList(),
      'packTypes': packTypes.map(_packToJson).toList(),
      'packCardPool': packCardPool.map(_poolToJson).toList(),
      'packSlotRules': packSlotRules.map(_ruleToJson).toList(),
      'packRarityProbabilities': packRarityProbabilities
          .map(_probabilityToJson)
          .toList(),
    };
  }

  factory _PackageDefinition.fromJson(Map<String, Object?> json) {
    return _PackageDefinition(
      collectionVersion: _versionFromJson(_asMap(json['collectionVersion'])),
      name: _string(json, 'name'),
      author: json['author'] as String?,
      description: json['description'] as String?,
      coverRelativePath: json['coverRelativePath'] as String?,
      rarities: _list(
        json,
        'rarities',
      ).map((value) => _rarityFromJson(_asMap(value))).toList(),
      mediaAssets: _list(
        json,
        'mediaAssets',
      ).map((value) => _assetFromJson(_asMap(value))).toList(),
      cards: _list(
        json,
        'cards',
      ).map((value) => _cardFromJson(_asMap(value))).toList(),
      cardFields: _list(
        json,
        'cardFields',
      ).map((value) => _cardFieldFromJson(_asMap(value))).toList(),
      packTypes: _list(
        json,
        'packTypes',
      ).map((value) => _packFromJson(_asMap(value))).toList(),
      packCardPool: _list(
        json,
        'packCardPool',
      ).map((value) => _poolFromJson(_asMap(value))).toList(),
      packSlotRules: _list(
        json,
        'packSlotRules',
      ).map((value) => _ruleFromJson(_asMap(value))).toList(),
      packRarityProbabilities: _list(
        json,
        'packRarityProbabilities',
      ).map((value) => _probabilityFromJson(_asMap(value))).toList(),
    );
  }
}

Map<String, Object?> _versionToJson(ContentVersionRow row) => {
  'id': row.id,
  'collectionId': row.collectionId,
  'versionNumber': row.versionNumber,
  'formatVersion': row.formatVersion,
  'createdAtUtc': row.createdAtUtc.toIso8601String(),
  'finalizedAtUtc': row.finalizedAtUtc?.toIso8601String(),
  'isCurrent': row.isCurrent,
};

ContentVersionRow _versionFromJson(Map<String, Object?> json) =>
    ContentVersionRow(
      id: _string(json, 'id'),
      collectionId: _string(json, 'collectionId'),
      versionNumber: _int(json, 'versionNumber'),
      formatVersion: _int(json, 'formatVersion'),
      createdAtUtc: _date(json, 'createdAtUtc'),
      finalizedAtUtc: _nullableDate(json, 'finalizedAtUtc'),
      isCurrent: _bool(json, 'isCurrent'),
    );

Map<String, Object?> _rarityToJson(RarityRow row) => {
  'id': row.id,
  'collectionId': row.collectionId,
  'contentVersionId': row.contentVersionId,
  'name': row.name,
  'orderIndex': row.orderIndex,
  'colorValue': row.colorValue,
  'iconId': row.iconId,
  'frameId': row.frameId,
  'effectId': row.effectId,
  'sellValue': row.sellValue,
  'isEnabled': row.isEnabled,
};

RarityRow _rarityFromJson(Map<String, Object?> json) => RarityRow(
  id: _string(json, 'id'),
  collectionId: _string(json, 'collectionId'),
  contentVersionId: _string(json, 'contentVersionId'),
  name: _string(json, 'name'),
  orderIndex: _int(json, 'orderIndex'),
  colorValue: _int(json, 'colorValue'),
  iconId: _string(json, 'iconId'),
  frameId: _string(json, 'frameId'),
  effectId: json['effectId'] as String?,
  sellValue: _int(json, 'sellValue'),
  isEnabled: _bool(json, 'isEnabled'),
);

Map<String, Object?> _assetToJson(MediaAssetRow row) => {
  'id': row.id,
  'collectionId': row.collectionId,
  'ownerType': row.ownerType.storageValue,
  'ownerId': row.ownerId,
  'mediaType': row.mediaType.storageValue,
  'relativePath': row.relativePath,
  'thumbnailRelativePath': row.thumbnailRelativePath,
  'mimeType': row.mimeType,
  'width': row.width,
  'height': row.height,
  'durationMs': row.durationMs,
  'fileSize': row.fileSize,
  'sha256': row.sha256,
  'createdAtUtc': row.createdAtUtc.toIso8601String(),
};

MediaAssetRow _assetFromJson(Map<String, Object?> json) => MediaAssetRow(
  id: _string(json, 'id'),
  collectionId: _string(json, 'collectionId'),
  ownerType: MediaOwnerType.fromStorage(_string(json, 'ownerType')),
  ownerId: _string(json, 'ownerId'),
  mediaType: MediaType.fromStorage(_string(json, 'mediaType')),
  relativePath: _string(json, 'relativePath'),
  thumbnailRelativePath: json['thumbnailRelativePath'] as String?,
  mimeType: _string(json, 'mimeType'),
  width: json['width'] as int?,
  height: json['height'] as int?,
  durationMs: json['durationMs'] as int?,
  fileSize: _int(json, 'fileSize'),
  sha256: json['sha256'] as String?,
  createdAtUtc: _date(json, 'createdAtUtc'),
);

Map<String, Object?> _cardToJson(CardRow row) => {
  'id': row.id,
  'collectionId': row.collectionId,
  'contentVersionId': row.contentVersionId,
  'collectionNumber': row.collectionNumber,
  'name': row.name,
  'health': row.health,
  'rarityId': row.rarityId,
  'mediaAssetId': row.mediaAssetId,
  'mediaType': row.mediaType.storageValue,
  'thumbnailAssetId': row.thumbnailAssetId,
  'templateId': row.templateId,
  'frameId': row.frameId,
  'primaryColor': row.primaryColor,
  'secondaryColor': row.secondaryColor,
  'description': row.description,
  'sortIndex': row.sortIndex,
  'createdAtUtc': row.createdAtUtc.toIso8601String(),
};

CardRow _cardFromJson(Map<String, Object?> json) => CardRow(
  id: _string(json, 'id'),
  collectionId: _string(json, 'collectionId'),
  contentVersionId: _string(json, 'contentVersionId'),
  collectionNumber: _int(json, 'collectionNumber'),
  name: _string(json, 'name'),
  health: _int(json, 'health'),
  rarityId: _string(json, 'rarityId'),
  mediaAssetId: _string(json, 'mediaAssetId'),
  mediaType: MediaType.fromStorage(_string(json, 'mediaType')),
  thumbnailAssetId: json['thumbnailAssetId'] as String?,
  templateId: _string(json, 'templateId'),
  frameId: _string(json, 'frameId'),
  primaryColor: _int(json, 'primaryColor'),
  secondaryColor: _int(json, 'secondaryColor'),
  description: json['description'] as String?,
  sortIndex: _int(json, 'sortIndex'),
  createdAtUtc: _date(json, 'createdAtUtc'),
);

Map<String, Object?> _cardFieldToJson(CardFieldValueRow row) => {
  'id': row.id,
  'cardId': row.cardId,
  'fieldTypeId': row.fieldTypeId,
  'value': row.value,
  'displayOrder': row.displayOrder,
};

CardFieldValueRow _cardFieldFromJson(Map<String, Object?> json) =>
    CardFieldValueRow(
      id: _string(json, 'id'),
      cardId: _string(json, 'cardId'),
      fieldTypeId: _string(json, 'fieldTypeId'),
      value: _string(json, 'value'),
      displayOrder: _int(json, 'displayOrder'),
    );

Map<String, Object?> _packToJson(PackTypeRow row) => {
  'id': row.id,
  'collectionId': row.collectionId,
  'contentVersionId': row.contentVersionId,
  'name': row.name,
  'description': row.description,
  'frontAssetId': row.frontAssetId,
  'backAssetId': row.backAssetId,
  'frontColorId': row.frontColorId,
  'frontAccentColorId': row.frontAccentColorId,
  'frontIconId': row.frontIconId,
  'frontPatternId': row.frontPatternId,
  'backColorId': row.backColorId,
  'backAccentColorId': row.backAccentColorId,
  'backIconId': row.backIconId,
  'backPatternId': row.backPatternId,
  'cardCount': row.cardCount,
  'rechargeSeconds': row.rechargeSeconds,
  'maxAccumulated': row.maxAccumulated,
  'isMain': row.isMain,
  'coinsPerFullRecharge': row.coinsPerFullRecharge,
  'sortIndex': row.sortIndex,
};

PackTypeRow _packFromJson(Map<String, Object?> json) => PackTypeRow(
  id: _string(json, 'id'),
  collectionId: _string(json, 'collectionId'),
  contentVersionId: _string(json, 'contentVersionId'),
  name: _string(json, 'name'),
  description: json['description'] as String?,
  frontAssetId: json['frontAssetId'] as String?,
  backAssetId: json['backAssetId'] as String?,
  frontColorId: _string(json, 'frontColorId'),
  frontAccentColorId: _string(json, 'frontAccentColorId'),
  frontIconId: _string(json, 'frontIconId'),
  frontPatternId: _string(json, 'frontPatternId'),
  backColorId: _string(json, 'backColorId'),
  backAccentColorId: _string(json, 'backAccentColorId'),
  backIconId: _string(json, 'backIconId'),
  backPatternId: _string(json, 'backPatternId'),
  cardCount: _int(json, 'cardCount'),
  rechargeSeconds: _int(json, 'rechargeSeconds'),
  maxAccumulated: _int(json, 'maxAccumulated'),
  isMain: _bool(json, 'isMain'),
  coinsPerFullRecharge: _int(json, 'coinsPerFullRecharge'),
  sortIndex: _int(json, 'sortIndex'),
);

Map<String, Object?> _poolToJson(PackCardPoolRow row) => {
  'packTypeId': row.packTypeId,
  'cardId': row.cardId,
  'isEnabled': row.isEnabled,
};

PackCardPoolRow _poolFromJson(Map<String, Object?> json) => PackCardPoolRow(
  packTypeId: _string(json, 'packTypeId'),
  cardId: _string(json, 'cardId'),
  isEnabled: _bool(json, 'isEnabled'),
);

Map<String, Object?> _ruleToJson(PackSlotRuleRow row) => {
  'id': row.id,
  'packTypeId': row.packTypeId,
  'slotIndex': row.slotIndex,
  'ruleType': row.ruleType.storageValue,
  'fixedRarityId': row.fixedRarityId,
  'minimumRarityOrder': row.minimumRarityOrder,
  'probabilityGroupId': row.probabilityGroupId,
};

PackSlotRuleRow _ruleFromJson(Map<String, Object?> json) => PackSlotRuleRow(
  id: _string(json, 'id'),
  packTypeId: _string(json, 'packTypeId'),
  slotIndex: _int(json, 'slotIndex'),
  ruleType: PackSlotRuleType.fromStorage(_string(json, 'ruleType')),
  fixedRarityId: json['fixedRarityId'] as String?,
  minimumRarityOrder: json['minimumRarityOrder'] as int?,
  probabilityGroupId: json['probabilityGroupId'] as String?,
);

Map<String, Object?> _probabilityToJson(PackRarityProbabilityRow row) => {
  'probabilityGroupId': row.probabilityGroupId,
  'rarityId': row.rarityId,
  'weight': row.weight,
};

PackRarityProbabilityRow _probabilityFromJson(Map<String, Object?> json) =>
    PackRarityProbabilityRow(
      probabilityGroupId: _string(json, 'probabilityGroupId'),
      rarityId: _string(json, 'rarityId'),
      weight: _int(json, 'weight'),
    );

Map<String, Object?> _asMap(Object? value) {
  if (value is Map) {
    return Map<String, Object?>.from(value);
  }
  throw const GachadexPackageFailure('El JSON del paquete no es valido.');
}

List<Object?> _list(Map<String, Object?> json, String key) {
  final value = json[key];
  if (value is List) {
    return List<Object?>.from(value);
  }
  throw const GachadexPackageFailure('El JSON del paquete no es valido.');
}

String _string(Map<String, Object?> json, String key) {
  final value = json[key];
  if (value is String && value.isNotEmpty) {
    return value;
  }
  throw const GachadexPackageFailure('El JSON del paquete no es valido.');
}

int _int(Map<String, Object?> json, String key) {
  final value = json[key];
  if (value is int) {
    return value;
  }
  throw const GachadexPackageFailure('El JSON del paquete no es valido.');
}

bool _bool(Map<String, Object?> json, String key) {
  final value = json[key];
  if (value is bool) {
    return value;
  }
  throw const GachadexPackageFailure('El JSON del paquete no es valido.');
}

DateTime _date(Map<String, Object?> json, String key) {
  final value = DateTime.tryParse(_string(json, key));
  if (value == null) {
    throw const GachadexPackageFailure('El JSON del paquete no es valido.');
  }
  return value.toUtc();
}

DateTime? _nullableDate(Map<String, Object?> json, String key) {
  final value = json[key];
  if (value == null) {
    return null;
  }
  if (value is String) {
    final parsed = DateTime.tryParse(value);
    if (parsed != null) {
      return parsed.toUtc();
    }
  }
  throw const GachadexPackageFailure('El JSON del paquete no es valido.');
}

final class _ExportAssetFile {
  const _ExportAssetFile({
    required this.relativePath,
    required this.file,
    required this.size,
    required this.sha256,
  });

  final String relativePath;
  final File file;
  final int size;
  final String sha256;
}
