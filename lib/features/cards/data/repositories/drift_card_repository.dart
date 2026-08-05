import '../../../../core/database/app_database.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../../domain/entities/card.dart' as domain;
import '../../domain/repositories/card_repository.dart';
import '../mappers/card_mapper.dart';

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
  Future<domain.Card> getById(CardId id) async {
    final row = await database.cardsDao.getById(id.value);
    if (row == null) {
      throw const EntityNotFoundFailure('No se encontro la carta.');
    }

    return row.toDomain();
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
  Future<void> delete(CardId id) async {
    final deleted = await database.cardsDao.deleteCard(id.value);
    if (deleted == 0) {
      throw const EntityNotFoundFailure('No se encontro la carta.');
    }
  }

  @override
  Future<int> countByRarity(RarityId rarityId) {
    return database.cardsDao.countByRarity(rarityId.value);
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
