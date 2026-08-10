import '../../../../core/identifiers/entity_id.dart';
import '../entities/pack_opening_details.dart';

abstract interface class PackOpeningRepository {
  Future<PackOpeningDetails> getById(PackOpeningId id);

  Future<PackOpeningDetails?> getActive(InstalledCollectionId id);

  Stream<PackOpeningDetails?> watchActive(InstalledCollectionId id);

  Future<void> markRevealing(PackOpeningId id);

  Future<void> revealCard({
    required PackOpeningId openingId,
    required int slotIndex,
  });

  Future<void> complete(PackOpeningId id);
}
