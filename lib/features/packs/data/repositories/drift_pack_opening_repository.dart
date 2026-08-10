import '../../../../core/database/app_database.dart'
    show AppDatabase, PackOpeningRow;
import '../../../../core/errors/app_failure.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../../../../core/time/clock.dart';
import '../../../cards/domain/repositories/card_repository.dart';
import '../../domain/entities/pack_opening_details.dart';
import '../../domain/repositories/pack_opening_repository.dart';
import '../mappers/progress_mappers.dart';

final class DriftPackOpeningRepository implements PackOpeningRepository {
  DriftPackOpeningRepository({
    required this.database,
    required this.cardRepository,
    required this.clock,
  });

  final AppDatabase database;
  final CardRepository cardRepository;
  final Clock clock;

  @override
  Future<PackOpeningDetails> getById(PackOpeningId id) async {
    final row = await database.playerProgressDao.getOpeningById(id.value);
    if (row == null) {
      throw const EntityNotFoundFailure('No se encontro la apertura.');
    }
    return _details(row);
  }

  @override
  Future<PackOpeningDetails?> getActive(InstalledCollectionId id) async {
    final row = await database.playerProgressDao.getActiveOpening(id.value);
    if (row == null) {
      return null;
    }
    final details = await _details(row);
    if (details.cards.every((card) => card.result.revealed)) {
      await complete(details.opening.id);
      return null;
    }
    return details;
  }

  @override
  Stream<PackOpeningDetails?> watchActive(InstalledCollectionId id) {
    return database.playerProgressDao.watchActiveOpening(id.value).asyncMap((
      row,
    ) async {
      if (row == null) {
        return null;
      }
      return _details(row);
    });
  }

  @override
  Future<void> markRevealing(PackOpeningId id) {
    return database.playerProgressDao.markOpeningRevealing(id.value);
  }

  @override
  Future<void> revealCard({
    required PackOpeningId openingId,
    required int slotIndex,
  }) {
    return database.playerProgressDao.revealOpeningCard(
      openingId: openingId.value,
      slotIndex: slotIndex,
    );
  }

  @override
  Future<void> complete(PackOpeningId id) {
    return database.playerProgressDao.completeOpening(
      openingId: id.value,
      completedAtUtc: clock.nowUtc(),
    );
  }

  Future<PackOpeningDetails> _details(PackOpeningRow row) async {
    final opening = row.toDomain();
    final cardRows = await database.playerProgressDao.getOpeningCards(
      opening.id.value,
    );
    final cards = <PackOpeningCardDetails>[];
    for (final cardRow in cardRows) {
      final result = cardRow.toDomain();
      cards.add(
        PackOpeningCardDetails(
          result: result,
          card: await cardRepository.getImageCardById(result.cardId),
        ),
      );
    }
    return PackOpeningDetails(opening: opening, cards: cards);
  }
}
