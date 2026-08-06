import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gachadex/core/database/database_providers.dart';
import 'package:gachadex/core/identifiers/uuid_generator.dart';
import 'package:gachadex/core/time/fake_clock.dart';
import 'package:gachadex/features/collection_creator/application/collection_draft_use_case_providers.dart';
import 'package:gachadex/features/collection_creator/domain/validation/collection_draft_validation.dart';
import 'package:gachadex/features/collection_creator/presentation/controllers/collection_draft_controller.dart';

import '../../helpers/database_seed.dart';
import '../../helpers/database_test_utils.dart';

void main() {
  test('debounces quick edits and persists the last value on flush', () async {
    final database = createInMemoryDatabase();
    final clock = FakeClock(testNowUtc());
    final container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
        clockProvider.overrideWithValue(clock),
        uuidGeneratorProvider.overrideWithValue(
          FixedUuidGenerator([testUuid(1), testUuid(2), testUuid(3)]),
        ),
      ],
    );
    addTearDown(container.dispose);
    addTearDown(database.close);

    final projectId = await container
        .read(createCollectionDraftProvider)
        .call();
    final provider = collectionDraftControllerProvider(projectId);
    final subscription = container.listen(provider, (_, _) {});
    addTearDown(subscription.close);

    await _waitForDraft(container, provider);
    final controller = container.read(provider.notifier);

    controller.editName('Primero');
    controller.editName('Definitivo');
    await Future<void>.delayed(const Duration(milliseconds: 120));

    var project = await container
        .read(collectionProjectRepositoryProvider)
        .getById(projectId);
    expect(project.name, isEmpty);

    await controller.flushPendingSave();

    project = await container
        .read(collectionProjectRepositoryProvider)
        .getById(projectId);
    expect(project.name, 'Definitivo');
    expect(
      container.read(provider).asData?.value.saveStatus,
      DraftSaveStatus.saved,
    );
  });

  test(
    'invalid long values keep local state and do not overwrite storage',
    () async {
      final database = createInMemoryDatabase();
      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(database),
          clockProvider.overrideWithValue(FakeClock(testNowUtc())),
          uuidGeneratorProvider.overrideWithValue(
            FixedUuidGenerator([testUuid(11), testUuid(12), testUuid(13)]),
          ),
        ],
      );
      addTearDown(container.dispose);
      addTearDown(database.close);

      final projectId = await container
          .read(createCollectionDraftProvider)
          .call();
      final provider = collectionDraftControllerProvider(projectId);
      final subscription = container.listen(provider, (_, _) {});
      addTearDown(subscription.close);

      await _waitForDraft(container, provider);
      final controller = container.read(provider.notifier);
      final longName = List.filled(
        CollectionDraftValidation.maxNameLength + 1,
        'a',
      ).join();

      controller.editName(longName);
      await controller.flushPendingSave();

      final state = container.read(provider).asData?.value;
      final project = await container
          .read(collectionProjectRepositoryProvider)
          .getById(projectId);

      expect(state?.name, longName);
      expect(state?.saveStatus, DraftSaveStatus.error);
      expect(project.name, isEmpty);
    },
  );
}

Future<void> _waitForDraft(
  ProviderContainer container,
  dynamic provider,
) async {
  for (var attempt = 0; attempt < 20; attempt++) {
    final value =
        container.read(provider) as AsyncValue<CollectionDraftEditorState>;
    if (value.asData != null) {
      return;
    }
    await Future<void>.delayed(const Duration(milliseconds: 25));
  }
  fail('Draft controller did not load.');
}
