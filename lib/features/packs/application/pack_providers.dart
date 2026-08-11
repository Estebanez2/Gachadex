import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_providers.dart';
import '../../../core/identifiers/entity_id.dart';
import '../../../core/notifications/application/notification_providers.dart';
import '../domain/entities/pack_configuration.dart';
import '../domain/entities/pack_opening_details.dart';
import '../domain/repositories/pack_type_repository.dart';
import 'pack_opening_use_cases.dart';
import 'pack_recharge_service.dart';
import 'pack_use_cases.dart';

typedef PacksByVersionArgs = ({
  CollectionId collectionId,
  ContentVersionId contentVersionId,
});

final packsByVersionProvider = StreamProvider.autoDispose
    .family<List<PackConfiguration>, PacksByVersionArgs>((ref, args) {
      final repository = ref.watch(packTypeRepositoryProvider);
      return repository
          .watchByCollectionVersion(
            collectionId: args.collectionId,
            contentVersionId: args.contentVersionId,
          )
          .asyncMap((packs) async {
            final configurations = <PackConfiguration>[];
            for (final pack in packs) {
              configurations.add(
                await repository.getFullConfiguration(pack.id),
              );
            }
            return configurations;
          });
    });

final packEditorUseCasesProvider = Provider<PackEditorUseCases>((ref) {
  return PackEditorUseCases(
    repository: ref.watch(packTypeRepositoryProvider),
    uuidGenerator: ref.watch(uuidGeneratorProvider),
  );
});

final packRepositoryProvider = Provider<PackTypeRepository>((ref) {
  return ref.watch(packTypeRepositoryProvider);
});

final packRechargeServiceProvider = Provider<PackRechargeService>((ref) {
  return PackRechargeService(
    installedCollectionRepository: ref.watch(
      installedCollectionRepositoryProvider,
    ),
    packInventoryRepository: ref.watch(packInventoryRepositoryProvider),
    packTypeRepository: ref.watch(packTypeRepositoryProvider),
    clock: ref.watch(clockProvider),
  );
});

final activePackOpeningProvider = StreamProvider.autoDispose
    .family<PackOpeningDetails?, InstalledCollectionId>((ref, id) {
      return ref.watch(packOpeningRepositoryProvider).watchActive(id);
    });

final packOpeningDetailsProvider = FutureProvider.autoDispose
    .family<PackOpeningDetails, PackOpeningId>((ref, id) {
      return ref.watch(packOpeningRepositoryProvider).getById(id);
    });

final openPackProvider = Provider<OpenPack>((ref) {
  return OpenPack(
    database: ref.watch(appDatabaseProvider),
    installedCollectionRepository: ref.watch(
      installedCollectionRepositoryProvider,
    ),
    cardRepository: ref.watch(cardRepositoryProvider),
    rarityRepository: ref.watch(rarityRepositoryProvider),
    packTypeRepository: ref.watch(packTypeRepositoryProvider),
    packOpeningRepository: ref.watch(packOpeningRepositoryProvider),
    rechargeService: ref.watch(packRechargeServiceProvider),
    uuidGenerator: ref.watch(uuidGeneratorProvider),
    clock: ref.watch(clockProvider),
    notificationScheduler: ref.watch(packNotificationSchedulerProvider),
  );
});

final resumePackOpeningProvider = Provider<ResumePackOpening>((ref) {
  return ResumePackOpening(ref.watch(packOpeningRepositoryProvider));
});

final startRevealingPackOpeningProvider = Provider<StartRevealingPackOpening>((
  ref,
) {
  return StartRevealingPackOpening(ref.watch(packOpeningRepositoryProvider));
});

final revealOpeningCardProvider = Provider<RevealOpeningCard>((ref) {
  return RevealOpeningCard(ref.watch(packOpeningRepositoryProvider));
});

final completePackOpeningProvider = Provider<CompletePackOpening>((ref) {
  return CompletePackOpening(ref.watch(packOpeningRepositoryProvider));
});
