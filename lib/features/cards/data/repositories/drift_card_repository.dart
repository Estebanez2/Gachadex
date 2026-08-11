import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/domain_enums.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../../domain/entities/card.dart' as domain;
import '../../domain/repositories/card_repository.dart';
import '../mappers/card_mapper.dart';
import '../mappers/card_field_value_mapper.dart';
import '../mappers/media_asset_mapper.dart';
import '../../../rarities/data/mappers/rarity_mapper.dart';

final class DriftCardRepository implements CardRepository {
  DriftCardRepository({required this.database});

  final AppDatabase database;

  @override
  Future<domain.Card> insert(domain.Card card) async {
    await _validateReferences(card);
    await database.cardsDao.insertCard(card.toCompanion());
    return card;
  }

  @override
  Future<ImageCardDetails> createCard(ImageCardGraph graph) async {
    await database.transaction(() async {
      for (final mediaAsset in graph.mediaAssets) {
        await database
            .into(database.mediaAssets)
            .insert(mediaAsset.toCompanion());
      }
      await _validateReferences(graph.card);
      await database.cardsDao.insertCard(graph.card.toCompanion());
      for (final field in graph.fields) {
        await database
            .into(database.cardFieldValues)
            .insert(field.toCompanion());
      }
    });

    return getImageCardById(graph.card.id);
  }

  @override
  Future<domain.Card> update(domain.Card card) async {
    await getById(card.id);
    await _validateReferences(card);
    final replaced = await database.cardsDao.replaceCard(card.toCompanion());
    if (!replaced) {
      throw const EntityNotFoundFailure('No se encontro la carta.');
    }

    return card;
  }

  @override
  Future<ImageCardDetails> updateCard(ImageCardGraph graph) async {
    await getById(graph.card.id);
    await database.transaction(() async {
      for (final mediaAsset in graph.mediaAssets) {
        await database
            .into(database.mediaAssets)
            .insertOnConflictUpdate(mediaAsset.toCompanion());
      }
      await _validateReferences(graph.card);
      final replaced = await database.cardsDao.replaceCard(
        graph.card.toCompanion(),
      );
      if (!replaced) {
        throw const EntityNotFoundFailure('No se encontro la carta.');
      }
      final retainedAssetIds = graph.mediaAssets
          .map((asset) => asset.id.value)
          .toList(growable: false);
      await (database.delete(database.mediaAssets)..where(
            (table) =>
                table.ownerType.equalsValue(MediaOwnerType.card) &
                table.ownerId.equals(graph.card.id.value) &
                table.id.isNotIn(retainedAssetIds),
          ))
          .go();
      await (database.delete(
        database.cardFieldValues,
      )..where((table) => table.cardId.equals(graph.card.id.value))).go();
      for (final field in graph.fields) {
        await database
            .into(database.cardFieldValues)
            .insert(field.toCompanion());
      }
    });

    return getImageCardById(graph.card.id);
  }

  @override
  Future<domain.Card> getById(CardId id) async {
    final row = await database.cardsDao.getById(id.value);
    if (row == null) {
      throw const EntityNotFoundFailure('No se encontro la carta.');
    }

    return row.toDomain();
  }

  @override
  Future<ImageCardDetails> getImageCardById(CardId id) async {
    final card = await getById(id);
    return _detailsForCard(card);
  }

  @override
  Stream<List<domain.Card>> watchByCollectionVersion({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
  }) {
    return database.cardsDao
        .watchByCollectionVersion(
          collectionId: collectionId.value,
          contentVersionId: contentVersionId.value,
        )
        .map((rows) => rows.map((row) => row.toDomain()).toList());
  }

  @override
  Stream<List<ImageCardDetails>> watchImageCardsByCollectionVersion({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
  }) {
    return watchByCollectionVersion(
      collectionId: collectionId,
      contentVersionId: contentVersionId,
    ).asyncMap((cards) async {
      final details = <ImageCardDetails>[];
      for (final card in cards) {
        details.add(await _detailsForCard(card));
      }
      return details;
    });
  }

  @override
  Future<void> delete(CardId id) async {
    final deleted = await database.cardsDao.deleteCard(id.value);
    if (deleted == 0) {
      throw const EntityNotFoundFailure('No se encontro la carta.');
    }
  }

  @override
  Future<ImageCardDetails> deleteCard(CardId id) async {
    final details = await getImageCardById(id);
    await database.transaction(() async {
      await (database.delete(
        database.cardFieldValues,
      )..where((table) => table.cardId.equals(id.value))).go();
      await database.cardsDao.deleteCard(id.value);
      for (final asset in [
        details.mediaAsset,
        if (details.thumbnailAsset != null) details.thumbnailAsset!,
      ]) {
        await (database.delete(
          database.mediaAssets,
        )..where((table) => table.id.equals(asset.id.value))).go();
      }
    });
    return details;
  }

  @override
  Future<bool> collectionNumberExists({
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
    required int collectionNumber,
    CardId? excludingCardId,
  }) async {
    final count = database.cards.id.count();
    final query = database.selectOnly(database.cards)..addColumns([count]);
    query.where(
      database.cards.collectionId.equals(collectionId.value) &
          database.cards.contentVersionId.equals(contentVersionId.value) &
          database.cards.collectionNumber.equals(collectionNumber),
    );
    if (excludingCardId != null) {
      query.where(database.cards.id.equals(excludingCardId.value).not());
    }
    final total = await query.map((row) => row.read(count) ?? 0).getSingle();
    return total > 0;
  }

  @override
  Future<int> countByRarity(RarityId rarityId) {
    return database.cardsDao.countByRarity(rarityId.value);
  }

  Future<ImageCardDetails> _detailsForCard(domain.Card card) async {
    final rarityRow =
        await (database.select(database.rarities)
              ..where((table) => table.id.equals(card.rarityId.value)))
            .getSingleOrNull();
    if (rarityRow == null) {
      throw const ReferentialIntegrityFailure(
        'La carta no tiene rareza valida.',
      );
    }
    final mediaRow =
        await (database.select(database.mediaAssets)
              ..where((table) => table.id.equals(card.mediaAssetId.value)))
            .getSingleOrNull();
    if (mediaRow == null) {
      throw const ReferentialIntegrityFailure(
        'La carta no tiene imagen principal valida.',
      );
    }
    final thumbnailAssetId = card.thumbnailAssetId;
    final thumbnailRow = thumbnailAssetId == null
        ? null
        : await (database.select(database.mediaAssets)
                ..where((table) => table.id.equals(thumbnailAssetId.value)))
              .getSingleOrNull();
    final fieldRows =
        await (database.select(database.cardFieldValues)
              ..where((table) => table.cardId.equals(card.id.value))
              ..orderBy([(table) => OrderingTerm.asc(table.displayOrder)]))
            .get();

    return ImageCardDetails(
      card: card,
      rarity: rarityRow.toDomain(),
      mediaAsset: mediaRow.toDomain(),
      thumbnailAsset: thumbnailRow?.toDomain(),
      fields: fieldRows.map((row) => row.toDomain()).toList(),
    );
  }

  Future<void> _validateReferences(domain.Card card) async {
    final version =
        await (database.select(database.contentVersions)
              ..where((table) => table.id.equals(card.contentVersionId.value)))
            .getSingleOrNull();
    if (version == null || version.collectionId != card.collectionId.value) {
      throw const ReferentialIntegrityFailure(
        'La carta no pertenece a una version valida.',
      );
    }

    final rarity =
        await (database.select(database.rarities)
              ..where((table) => table.id.equals(card.rarityId.value)))
            .getSingleOrNull();
    if (rarity == null ||
        rarity.collectionId != card.collectionId.value ||
        rarity.contentVersionId != card.contentVersionId.value) {
      throw const ReferentialIntegrityFailure(
        'La rareza no pertenece a la carta.',
      );
    }

    final media =
        await (database.select(database.mediaAssets)
              ..where((table) => table.id.equals(card.mediaAssetId.value)))
            .getSingleOrNull();
    if (media == null ||
        media.collectionId != card.collectionId.value ||
        media.mediaType != card.mediaType) {
      throw const ReferentialIntegrityFailure(
        'El recurso multimedia no pertenece a la carta.',
      );
    }

    final thumbnailAssetId = card.thumbnailAssetId;
    if (thumbnailAssetId != null) {
      final thumbnail =
          await (database.select(database.mediaAssets)
                ..where((table) => table.id.equals(thumbnailAssetId.value)))
              .getSingleOrNull();
      if (thumbnail == null ||
          thumbnail.collectionId != card.collectionId.value) {
        throw const ReferentialIntegrityFailure(
          'La miniatura no pertenece a la coleccion.',
        );
      }
    }
  }
}
