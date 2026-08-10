import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_providers.dart';
import '../../../core/identifiers/entity_id.dart';
import '../../packs/domain/entities/pack_inventory.dart';
import '../domain/entities/installed_collection.dart';

final installedCollectionsProvider =
    StreamProvider.autoDispose<List<InstalledCollection>>((ref) {
      return ref.watch(installedCollectionRepositoryProvider).watchAll();
    });

final installedCollectionProvider = FutureProvider.autoDispose
    .family<InstalledCollection, InstalledCollectionId>((ref, id) {
      return ref.watch(installedCollectionRepositoryProvider).getById(id);
    });

final packInventoryProvider = StreamProvider.autoDispose
    .family<List<PackInventory>, InstalledCollectionId>((ref, id) {
      return ref
          .watch(packInventoryRepositoryProvider)
          .watchByInstalledCollection(id);
    });
