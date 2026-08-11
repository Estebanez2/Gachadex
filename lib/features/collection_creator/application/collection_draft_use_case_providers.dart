import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_providers.dart';
import '../../../core/files/file_providers.dart';
import '../../../core/identifiers/entity_id.dart';
import '../../../core/notifications/application/notification_providers.dart';
import 'collection_draft_use_cases.dart';
import 'finalize_collection_use_cases.dart';

final createCollectionDraftProvider = Provider<CreateCollectionDraft>((ref) {
  return CreateCollectionDraft(ref.watch(collectionProjectRepositoryProvider));
});

final updateCollectionDraftInfoProvider = Provider<UpdateCollectionDraftInfo>((
  ref,
) {
  return UpdateCollectionDraftInfo(
    ref.watch(collectionProjectRepositoryProvider),
  );
});

final updateDraftCoverProvider = Provider<UpdateDraftCover>((ref) {
  return UpdateDraftCover(ref.watch(collectionProjectRepositoryProvider));
});

final deleteCollectionDraftProvider = Provider<DeleteCollectionDraft>((ref) {
  return DeleteCollectionDraft(ref.watch(collectionProjectRepositoryProvider));
});

final validateCollectionForFinalizationProvider =
    Provider<ValidateCollectionForFinalization>((ref) {
      return ValidateCollectionForFinalization(
        projectRepository: ref.watch(collectionProjectRepositoryProvider),
        rarityRepository: ref.watch(rarityRepositoryProvider),
        cardRepository: ref.watch(cardRepositoryProvider),
        packTypeRepository: ref.watch(packTypeRepositoryProvider),
        mediaStorage: ref.watch(projectMediaStorageProvider),
      );
    });

final collectionFinalizationReportProvider = FutureProvider.autoDispose.family((
  ref,
  CollectionProjectId projectId,
) {
  return ref.watch(validateCollectionForFinalizationProvider).call(projectId);
});

final finalizeCollectionProvider = Provider<FinalizeCollection>((ref) {
  final validator = ref.watch(validateCollectionForFinalizationProvider);
  return FinalizeCollection(
    database: ref.watch(appDatabaseProvider),
    projectRepository: ref.watch(collectionProjectRepositoryProvider),
    installedCollectionRepository: ref.watch(
      installedCollectionRepositoryProvider,
    ),
    cardRepository: ref.watch(cardRepositoryProvider),
    packTypeRepository: ref.watch(packTypeRepositoryProvider),
    validator: validator,
    uuidGenerator: ref.watch(uuidGeneratorProvider),
    clock: ref.watch(clockProvider),
    notificationScheduler: ref.watch(packNotificationSchedulerProvider),
  );
});
