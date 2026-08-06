import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_providers.dart';
import 'rarity_use_cases.dart';

final createRarityProvider = Provider<CreateRarity>((ref) {
  return CreateRarity(
    rarityRepository: ref.watch(rarityRepositoryProvider),
    projectRepository: ref.watch(collectionProjectRepositoryProvider),
    uuidGenerator: ref.watch(uuidGeneratorProvider),
  );
});

final updateRarityProvider = Provider<UpdateRarity>((ref) {
  return UpdateRarity(
    rarityRepository: ref.watch(rarityRepositoryProvider),
    projectRepository: ref.watch(collectionProjectRepositoryProvider),
  );
});

final reorderRaritiesProvider = Provider<ReorderRarities>((ref) {
  return ReorderRarities(
    rarityRepository: ref.watch(rarityRepositoryProvider),
    projectRepository: ref.watch(collectionProjectRepositoryProvider),
  );
});

final deleteRarityProvider = Provider<DeleteRarity>((ref) {
  return DeleteRarity(
    rarityRepository: ref.watch(rarityRepositoryProvider),
    projectRepository: ref.watch(collectionProjectRepositoryProvider),
  );
});
