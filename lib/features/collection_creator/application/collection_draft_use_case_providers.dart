import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_providers.dart';
import 'collection_draft_use_cases.dart';

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
