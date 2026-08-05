import '../../../../core/database/app_database.dart' show AppDatabase;
import '../../../../core/identifiers/entity_id.dart';
import '../../../packs/data/mappers/progress_mappers.dart';
import '../../../packs/domain/entities/pack_inventory.dart';
import '../../domain/entities/owned_card.dart';
import '../../domain/repositories/player_progress_repository.dart';

final class DriftPlayerProgressRepository implements PlayerProgressRepository {
  DriftPlayerProgressRepository({required this.database});

  final AppDatabase database;

  @override
  Future<List<OwnedCard>> getOwnedCards(
    InstalledCollectionId installedCollectionId,
  ) async {
    final rows = await database.playerProgressDao.getOwnedCards(
      installedCollectionId.value,
    );
    return rows.map((row) => row.toDomain()).toList(growable: false);
  }

  @override
  Future<List<PackInventory>> getPackInventory(
    InstalledCollectionId installedCollectionId,
  ) async {
    final rows = await database.playerProgressDao.getPackInventory(
      installedCollectionId.value,
    );
    return rows.map((row) => row.toDomain()).toList(growable: false);
  }

  @override
  Future<int> getCoinBalance(InstalledCollectionId installedCollectionId) {
    return database.playerProgressDao.getCoinBalance(
      installedCollectionId.value,
    );
  }
}
