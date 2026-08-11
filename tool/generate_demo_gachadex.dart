import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:crypto/crypto.dart';
import 'package:gachadex/features/import_export/domain/gachadex_package_constants.dart';
import 'package:path/path.dart' as p;

Future<void> main() async {
  final outputDir = Directory(p.join(Directory.current.path, 'samples'));
  await outputDir.create(recursive: true);

  const collectionId = '11111111-1111-4111-8111-111111111111';
  const contentVersionId = '11111111-1111-4111-8111-111111111112';
  const mainPackId = '11111111-1111-4111-8111-111111111501';
  const now = '2026-08-11T12:00:00.000Z';

  final rarities = [
    _rarity(
      id: '11111111-1111-4111-8111-111111111201',
      collectionId: collectionId,
      contentVersionId: contentVersionId,
      name: 'Normalita',
      orderIndex: 0,
      colorValue: 0xFF4B6BFB,
      iconId: 'spark',
      frameId: 'clean',
      effectId: null,
      sellValue: 5,
    ),
    _rarity(
      id: '11111111-1111-4111-8111-111111111202',
      collectionId: collectionId,
      contentVersionId: contentVersionId,
      name: 'Rara rara',
      orderIndex: 1,
      colorValue: 0xFF13A76B,
      iconId: 'star',
      frameId: 'bold',
      effectId: 'softGlow',
      sellValue: 15,
    ),
    _rarity(
      id: '11111111-1111-4111-8111-111111111203',
      collectionId: collectionId,
      contentVersionId: contentVersionId,
      name: 'Legendaria de grupo',
      orderIndex: 2,
      colorValue: 0xFFE14D72,
      iconId: 'crown',
      frameId: 'double',
      effectId: 'holographic',
      sellValue: 40,
    ),
  ];

  final cardSeeds = [
    _CardSeed(
      id: '11111111-1111-4111-8111-111111111301',
      assetId: '11111111-1111-4111-8111-111111111401',
      number: 1,
      name: 'El que siempre llega tarde',
      rarityId: rarities[0]['id']! as String,
      rarityOrder: 0,
      health: 90,
      primaryColor: 0xFF243B6B,
      secondaryColor: 0xFFE7EFFA,
      description: 'Aparece cuando la partida ya ha empezado.',
      fields: const {
        'nickname': 'Cinco minutos',
        'weakness': 'Quedar a una hora concreta',
      },
    ),
    _CardSeed(
      id: '11111111-1111-4111-8111-111111111302',
      assetId: '11111111-1111-4111-8111-111111111402',
      number: 2,
      name: 'La estratega del grupo',
      rarityId: rarities[1]['id']! as String,
      rarityOrder: 1,
      health: 140,
      primaryColor: 0xFF0F7A5A,
      secondaryColor: 0xFFFFD166,
      description: 'Convierte cualquier plan improvisado en una mision.',
      fields: const {
        'special_ability': 'Plan B infinito',
        'intelligence': '11/10',
      },
    ),
    _CardSeed(
      id: '11111111-1111-4111-8111-111111111303',
      assetId: '11111111-1111-4111-8111-111111111403',
      number: 3,
      name: 'Momento historico',
      rarityId: rarities[2]['id']! as String,
      rarityOrder: 2,
      health: 220,
      primaryColor: 0xFF8E24AA,
      secondaryColor: 0xFF26C6DA,
      description: 'Nadie sabe como paso, pero todos lo recuerdan.',
      fields: const {
        'legendary_moment': 'La foto que no necesitaba contexto',
        'famous_quote': 'Yo controlo',
      },
    ),
    _CardSeed(
      id: '11111111-1111-4111-8111-111111111304',
      assetId: '11111111-1111-4111-8111-111111111404',
      number: 4,
      name: 'Objeto sagrado',
      rarityId: rarities[0]['id']! as String,
      rarityOrder: 0,
      health: 70,
      primaryColor: 0xFF6D4C41,
      secondaryColor: 0xFFAED581,
      description: 'Siempre aparece en todas las quedadas.',
      fields: const {
        'favorite_object': 'La mochila misteriosa',
        'luck': 'Variable',
      },
    ),
    _CardSeed(
      id: '11111111-1111-4111-8111-111111111305',
      assetId: '11111111-1111-4111-8111-111111111405',
      number: 5,
      name: 'Caos controlado',
      rarityId: rarities[1]['id']! as String,
      rarityOrder: 1,
      health: 160,
      primaryColor: 0xFFD7263D,
      secondaryColor: 0xFF1B998B,
      description: 'Si algo puede salir raro, sale memorable.',
      fields: const {
        'danger_level': 'Moderado pero gracioso',
        'team': 'Equipo improvisado',
      },
    ),
  ];

  final mediaAssets = <Map<String, Object?>>[];
  final cards = <Map<String, Object?>>[];
  final cardFields = <Map<String, Object?>>[];
  final assetFiles = <_PackageFile>[];

  for (final card in cardSeeds) {
    final relativePath = 'collections/$collectionId/cards/${card.id}.webp';
    final thumbnailPath =
        'collections/$collectionId/cards/${card.id}-thumb.webp';
    mediaAssets.add({
      'id': card.assetId,
      'collectionId': collectionId,
      'ownerType': 'card',
      'ownerId': card.id,
      'mediaType': 'image',
      'relativePath': relativePath,
      'thumbnailRelativePath': thumbnailPath,
      'mimeType': 'image/webp',
      'width': 1,
      'height': 1,
      'durationMs': null,
      'fileSize': _demoPng.length,
      'sha256': null,
      'createdAtUtc': now,
    });
    cards.add({
      'id': card.id,
      'collectionId': collectionId,
      'contentVersionId': contentVersionId,
      'collectionNumber': card.number,
      'name': card.name,
      'health': card.health,
      'rarityId': card.rarityId,
      'mediaAssetId': card.assetId,
      'mediaType': 'image',
      'thumbnailAssetId': null,
      'templateId': 'basic',
      'frameId': 'clean',
      'primaryColor': card.primaryColor,
      'secondaryColor': card.secondaryColor,
      'description': card.description,
      'sortIndex': card.number - 1,
      'createdAtUtc': now,
    });

    var fieldIndex = 0;
    for (final field in card.fields.entries) {
      cardFields.add({
        'id': '11111111-1111-4111-8111-11111112${card.number}00$fieldIndex',
        'cardId': card.id,
        'fieldTypeId': field.key,
        'value': field.value,
        'displayOrder': fieldIndex,
      });
      fieldIndex += 1;
    }

    assetFiles.add(_PackageFile('assets/$relativePath', _demoPng));
    assetFiles.add(_PackageFile('assets/$thumbnailPath', _demoPng));
  }

  final packTypes = [
    _pack(
      id: mainPackId,
      collectionId: collectionId,
      contentVersionId: contentVersionId,
      name: 'Sobre de prueba',
      description: 'Mezcla rapida con tres cartas.',
      cardCount: 3,
      rechargeSeconds: 3600,
      maxAccumulated: 3,
      isMain: true,
      coinsPerFullRecharge: 10,
      sortIndex: 0,
      frontColorId: 'teal',
      frontAccentColorId: 'rose',
    ),
    _pack(
      id: '11111111-1111-4111-8111-111111111502',
      collectionId: collectionId,
      contentVersionId: contentVersionId,
      name: 'Sobre con brillo',
      description: 'Mas caro y con ultima carta especial.',
      cardCount: 5,
      rechargeSeconds: 7200,
      maxAccumulated: 2,
      isMain: false,
      coinsPerFullRecharge: 25,
      sortIndex: 1,
      frontColorId: 'ink',
      frontAccentColorId: 'amber',
    ),
  ];

  final pools = <Map<String, Object?>>[];
  for (final card in cardSeeds) {
    pools.add({'packTypeId': mainPackId, 'cardId': card.id, 'isEnabled': true});
    if (card.rarityOrder >= 1) {
      pools.add({
        'packTypeId': packTypes[1]['id'],
        'cardId': card.id,
        'isEnabled': true,
      });
    }
  }

  final rules = <Map<String, Object?>>[];
  final probabilities = <Map<String, Object?>>[];
  _addRules(
    rules: rules,
    probabilities: probabilities,
    packTypeId: mainPackId,
    cardCount: 3,
    rarities: rarities,
    finalMinimumRare: false,
    rulePrefix: '11111111-1111-4111-8111-11111111210',
  );
  _addRules(
    rules: rules,
    probabilities: probabilities,
    packTypeId: packTypes[1]['id']! as String,
    cardCount: 5,
    rarities: rarities,
    finalMinimumRare: true,
    rulePrefix: '11111111-1111-4111-8111-11111111220',
  );

  final collectionJson = _prettyJson({
    'collectionVersion': {
      'id': contentVersionId,
      'collectionId': collectionId,
      'versionNumber': 1,
      'formatVersion': 1,
      'createdAtUtc': now,
      'finalizedAtUtc': now,
      'isCurrent': true,
    },
    'name': 'Gachadex Demo: Mini Fiesta',
    'author': 'Gachadex',
    'description':
        'Coleccion pequena para probar importacion, sobres, album, rarezas, repetidas y gachacoin.',
    'coverRelativePath': null,
    'rarities': rarities,
    'mediaAssets': mediaAssets,
    'cards': cards,
    'cardFields': cardFields,
    'packTypes': packTypes,
    'packCardPool': pools,
    'packSlotRules': rules,
    'packRarityProbabilities': probabilities,
  });
  final collectionBytes = utf8.encode(collectionJson);

  final files = <Map<String, Object?>>[
    _manifestFile('collection.json', collectionBytes),
    for (final file in assetFiles) _manifestFile(file.path, file.bytes),
  ];
  final totalBytes = files.fold<int>(
    0,
    (total, file) => total + (file['size']! as int),
  );
  final manifestJson = _prettyJson({
    'format': gachadexPackageFormat,
    'formatVersion': gachadexPackageFormatVersion,
    'collectionId': collectionId,
    'contentVersionId': contentVersionId,
    'contentVersion': 1,
    'name': 'Gachadex Demo: Mini Fiesta',
    'author': 'Gachadex',
    'mainPackTypeId': mainPackId,
    'startingPacks': gachadexStartingPackCount,
    'createdAt': now,
    'cardCount': cards.length,
    'videoCount': 0,
    'rarityCount': rarities.length,
    'packTypeCount': packTypes.length,
    'totalBytes': totalBytes,
    'files': files,
  });

  final archive = Archive()
    ..addFile(
      ArchiveFile(
        'manifest.json',
        utf8.encode(manifestJson).length,
        utf8.encode(manifestJson),
      ),
    )
    ..addFile(
      ArchiveFile('collection.json', collectionBytes.length, collectionBytes),
    );
  for (final file in assetFiles) {
    archive.addFile(ArchiveFile(file.path, file.bytes.length, file.bytes));
  }

  final target = File(
    p.join(outputDir.path, 'gachadex_demo_completa.gachadex'),
  );
  if (await target.exists()) {
    await target.delete();
  }
  await target.writeAsBytes(ZipEncoder().encode(archive), flush: true);
  stdout.writeln(target.path);
}

Map<String, Object?> _rarity({
  required String id,
  required String collectionId,
  required String contentVersionId,
  required String name,
  required int orderIndex,
  required int colorValue,
  required String iconId,
  required String frameId,
  required String? effectId,
  required int sellValue,
}) {
  return {
    'id': id,
    'collectionId': collectionId,
    'contentVersionId': contentVersionId,
    'name': name,
    'orderIndex': orderIndex,
    'colorValue': colorValue,
    'iconId': iconId,
    'frameId': frameId,
    'effectId': effectId,
    'sellValue': sellValue,
    'isEnabled': true,
  };
}

Map<String, Object?> _pack({
  required String id,
  required String collectionId,
  required String contentVersionId,
  required String name,
  required String description,
  required int cardCount,
  required int rechargeSeconds,
  required int maxAccumulated,
  required bool isMain,
  required int coinsPerFullRecharge,
  required int sortIndex,
  required String frontColorId,
  required String frontAccentColorId,
}) {
  return {
    'id': id,
    'collectionId': collectionId,
    'contentVersionId': contentVersionId,
    'name': name,
    'description': description,
    'frontAssetId': null,
    'backAssetId': null,
    'frontColorId': frontColorId,
    'frontAccentColorId': frontAccentColorId,
    'frontIconId': 'cards',
    'frontPatternId': 'rays',
    'backColorId': 'ink',
    'backAccentColorId': 'mint',
    'backIconId': 'spark',
    'backPatternId': 'dots',
    'cardCount': cardCount,
    'rechargeSeconds': rechargeSeconds,
    'maxAccumulated': maxAccumulated,
    'isMain': isMain,
    'coinsPerFullRecharge': coinsPerFullRecharge,
    'sortIndex': sortIndex,
  };
}

void _addRules({
  required List<Map<String, Object?>> rules,
  required List<Map<String, Object?>> probabilities,
  required String packTypeId,
  required int cardCount,
  required List<Map<String, Object?>> rarities,
  required bool finalMinimumRare,
  required String rulePrefix,
}) {
  for (var slot = 0; slot < cardCount; slot += 1) {
    final groupId = '$packTypeId-slot-$slot';
    final isFinal = slot == cardCount - 1;
    rules.add({
      'id': '$rulePrefix$slot',
      'packTypeId': packTypeId,
      'slotIndex': slot,
      'ruleType': finalMinimumRare && isFinal
          ? 'minimumRarity'
          : 'probabilityDistribution',
      'fixedRarityId': null,
      'minimumRarityOrder': finalMinimumRare && isFinal ? 1 : null,
      'probabilityGroupId': groupId,
    });
    for (final rarity in rarities) {
      final order = rarity['orderIndex']! as int;
      if (finalMinimumRare && isFinal && order == 0) {
        continue;
      }
      final weight = switch (order) {
        0 => 70,
        1 => finalMinimumRare && isFinal ? 65 : 25,
        _ => finalMinimumRare && isFinal ? 35 : 5,
      };
      probabilities.add({
        'probabilityGroupId': groupId,
        'rarityId': rarity['id'],
        'weight': weight,
      });
    }
  }
}

Map<String, Object?> _manifestFile(String path, List<int> bytes) {
  return {
    'path': path,
    'size': bytes.length,
    'sha256': sha256.convert(bytes).toString(),
  };
}

String _prettyJson(Map<String, Object?> value) {
  return const JsonEncoder.withIndent('  ').convert(value);
}

final class _CardSeed {
  const _CardSeed({
    required this.id,
    required this.assetId,
    required this.number,
    required this.name,
    required this.rarityId,
    required this.rarityOrder,
    required this.health,
    required this.primaryColor,
    required this.secondaryColor,
    required this.description,
    required this.fields,
  });

  final String id;
  final String assetId;
  final int number;
  final String name;
  final String rarityId;
  final int rarityOrder;
  final int health;
  final int primaryColor;
  final int secondaryColor;
  final String description;
  final Map<String, String> fields;
}

final class _PackageFile {
  const _PackageFile(this.path, this.bytes);

  final String path;
  final List<int> bytes;
}

final _demoPng = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMB'
  '/gL+XkQAAAAASUVORK5CYII=',
);
