import '../../../../core/identifiers/entity_id.dart';
import '../../../packs/domain/entities/pack_inventory.dart';
import '../entities/owned_card.dart';

abstract interface class PlayerProgressRepository {
  Future<List<OwnedCard>> getOwnedCards(
    InstalledCollectionId installedCollectionId,
  );

  Future<List<PackInventory>> getPackInventory(
    InstalledCollectionId installedCollectionId,
  );

  Future<int> getCoinBalance(InstalledCollectionId installedCollectionId);
}
