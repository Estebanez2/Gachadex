import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_providers.dart';
import '../../../core/identifiers/entity_id.dart';
import '../domain/entities/pack_configuration.dart';
import '../domain/repositories/pack_type_repository.dart';
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
