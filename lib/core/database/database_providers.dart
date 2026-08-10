import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/album/data/repositories/drift_album_repository.dart';
import '../../features/album/domain/repositories/album_repository.dart';
import '../../features/album/data/repositories/drift_player_progress_repository.dart';
import '../../features/album/domain/repositories/player_progress_repository.dart';
import '../../features/cards/data/repositories/drift_card_repository.dart';
import '../../features/cards/domain/repositories/card_repository.dart';
import '../../features/collection_creator/data/repositories/drift_collection_project_repository.dart';
import '../../features/collection_creator/data/repositories/drift_content_version_repository.dart';
import '../../features/collection_creator/domain/repositories/collection_project_repository.dart';
import '../../features/collection_creator/domain/repositories/content_version_repository.dart';
import '../../features/collections/data/repositories/drift_installed_collection_repository.dart';
import '../../features/collections/domain/repositories/installed_collection_repository.dart';
import '../../features/packs/data/repositories/drift_pack_inventory_repository.dart';
import '../../features/packs/data/repositories/drift_pack_opening_repository.dart';
import '../../features/packs/data/repositories/drift_pack_type_repository.dart';
import '../../features/packs/domain/repositories/pack_inventory_repository.dart';
import '../../features/packs/domain/repositories/pack_opening_repository.dart';
import '../../features/packs/domain/repositories/pack_type_repository.dart';
import '../../features/rarities/data/repositories/drift_rarity_repository.dart';
import '../../features/rarities/domain/repositories/rarity_repository.dart';
import '../identifiers/uuid_generator.dart';
import '../time/clock.dart';
import '../time/system_clock.dart';
import 'app_database.dart';

final clockProvider = Provider<Clock>((ref) => const SystemClock());

final uuidGeneratorProvider = Provider<UuidGenerator>(
  (ref) => const SystemUuidGenerator(),
);

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
});

final collectionProjectRepositoryProvider =
    Provider<CollectionProjectRepository>((ref) {
      return DriftCollectionProjectRepository(
        database: ref.watch(appDatabaseProvider),
        clock: ref.watch(clockProvider),
        uuidGenerator: ref.watch(uuidGeneratorProvider),
      );
    });

final contentVersionRepositoryProvider = Provider<ContentVersionRepository>((
  ref,
) {
  return DriftContentVersionRepository(
    database: ref.watch(appDatabaseProvider),
    clock: ref.watch(clockProvider),
    uuidGenerator: ref.watch(uuidGeneratorProvider),
  );
});

final cardRepositoryProvider = Provider<CardRepository>((ref) {
  return DriftCardRepository(database: ref.watch(appDatabaseProvider));
});

final rarityRepositoryProvider = Provider<RarityRepository>((ref) {
  return DriftRarityRepository(
    database: ref.watch(appDatabaseProvider),
    cardRepository: ref.watch(cardRepositoryProvider),
  );
});

final packTypeRepositoryProvider = Provider<PackTypeRepository>((ref) {
  return DriftPackTypeRepository(
    database: ref.watch(appDatabaseProvider),
    clock: ref.watch(clockProvider),
  );
});

final packInventoryRepositoryProvider = Provider<PackInventoryRepository>((
  ref,
) {
  return DriftPackInventoryRepository(database: ref.watch(appDatabaseProvider));
});

final packOpeningRepositoryProvider = Provider<PackOpeningRepository>((ref) {
  return DriftPackOpeningRepository(
    database: ref.watch(appDatabaseProvider),
    cardRepository: ref.watch(cardRepositoryProvider),
    clock: ref.watch(clockProvider),
  );
});

final installedCollectionRepositoryProvider =
    Provider<InstalledCollectionRepository>((ref) {
      return DriftInstalledCollectionRepository(
        database: ref.watch(appDatabaseProvider),
      );
    });

final playerProgressRepositoryProvider = Provider<PlayerProgressRepository>((
  ref,
) {
  return DriftPlayerProgressRepository(
    database: ref.watch(appDatabaseProvider),
  );
});

final albumRepositoryProvider = Provider<AlbumRepository>((ref) {
  return DriftAlbumRepository(database: ref.watch(appDatabaseProvider));
});
