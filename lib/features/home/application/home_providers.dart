import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_providers.dart';
import '../../../core/identifiers/entity_id.dart';
import '../../packs/application/pack_providers.dart';
import '../../packs/domain/entities/pack_inventory.dart';
import '../../packs/domain/value_objects/pack_visual_style.dart';

final homeAvailablePacksProvider =
    FutureProvider.autoDispose<List<HomeAvailablePack>>((ref) async {
      final installedCollectionRepository = ref.watch(
        installedCollectionRepositoryProvider,
      );
      final packInventoryRepository = ref.watch(
        packInventoryRepositoryProvider,
      );
      final packTypeRepository = ref.watch(packRepositoryProvider);

      final collections = await installedCollectionRepository.getAll();
      final inventories = await packInventoryRepository.getAll();
      final collectionsById = {
        for (final collection in collections) collection.id: collection,
      };
      final packs = <HomeAvailablePack>[];

      for (final inventory in inventories.where(_isAvailable)) {
        final collection = collectionsById[inventory.installedCollectionId];
        if (collection == null) {
          continue;
        }
        final packType = await packTypeRepository.getById(inventory.packTypeId);
        packs.add(
          HomeAvailablePack(
            installedCollectionId: collection.id,
            collectionName: collection.name,
            packTypeId: packType.id,
            packName: packType.name,
            availableCount: inventory.availableCount,
            maxAccumulated: inventory.maxAccumulated,
            isMain: packType.isMain,
            sortIndex: packType.sortIndex,
            nextRechargeAtUtc: inventory.nextRechargeAtUtc,
            visualStyle: packType.frontStyle,
          ),
        );
      }

      packs.sort(_compareHomePacks);
      return packs;
    });

bool _isAvailable(PackInventory inventory) => inventory.availableCount > 0;

int _compareHomePacks(HomeAvailablePack a, HomeAvailablePack b) {
  final collectionCompare = a.collectionName.toLowerCase().compareTo(
    b.collectionName.toLowerCase(),
  );
  if (collectionCompare != 0) {
    return collectionCompare;
  }
  if (a.isMain != b.isMain) {
    return a.isMain ? -1 : 1;
  }
  final sortCompare = a.sortIndex.compareTo(b.sortIndex);
  if (sortCompare != 0) {
    return sortCompare;
  }
  return a.packName.toLowerCase().compareTo(b.packName.toLowerCase());
}

final class HomeAvailablePack {
  const HomeAvailablePack({
    required this.installedCollectionId,
    required this.collectionName,
    required this.packTypeId,
    required this.packName,
    required this.availableCount,
    required this.maxAccumulated,
    required this.isMain,
    required this.sortIndex,
    required this.nextRechargeAtUtc,
    required this.visualStyle,
  });

  final InstalledCollectionId installedCollectionId;
  final String collectionName;
  final PackTypeId packTypeId;
  final String packName;
  final int availableCount;
  final int maxAccumulated;
  final bool isMain;
  final int sortIndex;
  final DateTime nextRechargeAtUtc;
  final PackVisualStyle visualStyle;
}
