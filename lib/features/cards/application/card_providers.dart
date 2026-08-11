import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_providers.dart';
import '../../../core/files/file_providers.dart';
import '../../../core/identifiers/entity_id.dart';
import '../domain/repositories/card_repository.dart';
import 'card_photo_processor.dart';
import 'card_use_cases.dart';
import 'card_video_processor.dart';

typedef CardsByVersionArgs = ({
  CollectionId collectionId,
  ContentVersionId contentVersionId,
});

final imageCardsProvider = StreamProvider.autoDispose
    .family<List<ImageCardDetails>, CardsByVersionArgs>((ref, args) {
      return ref
          .watch(cardRepositoryProvider)
          .watchImageCardsByCollectionVersion(
            collectionId: args.collectionId,
            contentVersionId: args.contentVersionId,
          );
    });

final imageCardDetailsProvider = FutureProvider.autoDispose
    .family<ImageCardDetails, CardId>((ref, cardId) {
      return ref.watch(cardRepositoryProvider).getImageCardById(cardId);
    });

final cardPhotoProcessorProvider = Provider<CardPhotoProcessor>((ref) {
  return PluginCardPhotoProcessor(ref.watch(projectMediaStorageProvider));
});

final cardVideoProcessorProvider = Provider<CardVideoProcessor>((ref) {
  return PluginCardVideoProcessor(ref.watch(projectMediaStorageProvider));
});

final createImageCardProvider = Provider<CreateImageCard>((ref) {
  return CreateImageCard(
    ref.watch(cardRepositoryProvider),
    ref.watch(collectionProjectRepositoryProvider),
    ref.watch(projectMediaStorageProvider),
    ref.watch(uuidGeneratorProvider),
    ref.watch(clockProvider),
  );
});

final updateImageCardProvider = Provider<UpdateImageCard>((ref) {
  return UpdateImageCard(
    ref.watch(cardRepositoryProvider),
    ref.watch(collectionProjectRepositoryProvider),
    ref.watch(projectMediaStorageProvider),
    ref.watch(uuidGeneratorProvider),
    ref.watch(clockProvider),
  );
});

final deleteImageCardProvider = Provider<DeleteImageCard>((ref) {
  return DeleteImageCard(
    ref.watch(cardRepositoryProvider),
    ref.watch(collectionProjectRepositoryProvider),
    ref.watch(projectMediaStorageProvider),
  );
});
