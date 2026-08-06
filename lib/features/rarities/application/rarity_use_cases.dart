import '../../../core/errors/app_failure.dart';
import '../../../core/identifiers/entity_id.dart';
import '../../../core/identifiers/uuid_generator.dart';
import '../../collection_creator/domain/repositories/collection_project_repository.dart';
import '../domain/catalogs/rarity_visual_catalog.dart';
import '../domain/entities/rarity.dart';
import '../domain/repositories/rarity_repository.dart';
import '../domain/validation/rarity_validation.dart';

final class RarityInput {
  const RarityInput({
    required this.name,
    required this.colorValue,
    required this.iconId,
    required this.frameId,
    required this.effectId,
    required this.sellValue,
    required this.isEnabled,
  });

  factory RarityInput.defaults() {
    return const RarityInput(
      name: '',
      colorValue: RarityVisualCatalog.defaultColorValue,
      iconId: RarityVisualCatalog.defaultIconId,
      frameId: RarityVisualCatalog.defaultFrameId,
      effectId: RarityVisualCatalog.defaultEffectId,
      sellValue: 0,
      isEnabled: true,
    );
  }

  final String name;
  final int colorValue;
  final String iconId;
  final String frameId;
  final String effectId;
  final int sellValue;
  final bool isEnabled;
}

final class CreateRarity {
  const CreateRarity({
    required this.rarityRepository,
    required this.projectRepository,
    required this.uuidGenerator,
  });

  final RarityRepository rarityRepository;
  final CollectionProjectRepository projectRepository;
  final UuidGenerator uuidGenerator;

  Future<Rarity> call({
    required CollectionProjectId projectId,
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
    required RarityInput input,
  }) async {
    await _ensureValidInput(
      repository: rarityRepository,
      collectionId: collectionId,
      contentVersionId: contentVersionId,
      input: input,
    );
    final orderIndex = await rarityRepository.countByCollectionVersion(
      collectionId: collectionId,
      contentVersionId: contentVersionId,
    );
    final rarity = Rarity(
      id: uuidGenerator.rarityId(),
      collectionId: collectionId,
      contentVersionId: contentVersionId,
      name: input.name,
      orderIndex: orderIndex,
      colorValue: input.colorValue,
      iconId: input.iconId,
      frameId: input.frameId,
      effectId: input.effectId,
      sellValue: input.sellValue,
      isEnabled: input.isEnabled,
    );

    final inserted = await rarityRepository.insert(rarity);
    await projectRepository.touchUpdatedAt(projectId);
    return inserted;
  }
}

final class UpdateRarity {
  const UpdateRarity({
    required this.rarityRepository,
    required this.projectRepository,
  });

  final RarityRepository rarityRepository;
  final CollectionProjectRepository projectRepository;

  Future<Rarity> call({
    required CollectionProjectId projectId,
    required RarityId rarityId,
    required RarityInput input,
  }) async {
    final current = await rarityRepository.getById(rarityId);
    await _ensureValidInput(
      repository: rarityRepository,
      collectionId: current.collectionId,
      contentVersionId: current.contentVersionId,
      input: input,
      excludingId: rarityId,
    );

    final updated = await rarityRepository.update(
      current.copyWith(
        name: input.name,
        colorValue: input.colorValue,
        iconId: input.iconId,
        frameId: input.frameId,
        effectId: input.effectId,
        sellValue: input.sellValue,
        isEnabled: input.isEnabled,
      ),
    );
    await projectRepository.touchUpdatedAt(projectId);
    return updated;
  }
}

final class ReorderRarities {
  const ReorderRarities({
    required this.rarityRepository,
    required this.projectRepository,
  });

  final RarityRepository rarityRepository;
  final CollectionProjectRepository projectRepository;

  Future<List<Rarity>> call({
    required CollectionProjectId projectId,
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
    required List<RarityId> orderedIds,
  }) async {
    final rarities = await rarityRepository.reorder(
      collectionId: collectionId,
      contentVersionId: contentVersionId,
      orderedIds: orderedIds,
    );
    await projectRepository.touchUpdatedAt(projectId);
    return rarities;
  }
}

final class DeleteRarity {
  const DeleteRarity({
    required this.rarityRepository,
    required this.projectRepository,
  });

  final RarityRepository rarityRepository;
  final CollectionProjectRepository projectRepository;

  Future<void> call({
    required CollectionProjectId projectId,
    required RarityId rarityId,
  }) async {
    final rarity = await rarityRepository.getById(rarityId);
    await rarityRepository.delete(rarityId);
    final remaining = await rarityRepository
        .watchByCollectionVersion(
          collectionId: rarity.collectionId,
          contentVersionId: rarity.contentVersionId,
        )
        .first;
    await rarityRepository.reorder(
      collectionId: rarity.collectionId,
      contentVersionId: rarity.contentVersionId,
      orderedIds: remaining.map((item) => item.id).toList(growable: false),
    );
    await projectRepository.touchUpdatedAt(projectId);
  }
}

Future<void> _ensureValidInput({
  required RarityRepository repository,
  required CollectionId collectionId,
  required ContentVersionId contentVersionId,
  required RarityInput input,
  RarityId? excludingId,
}) async {
  final duplicate = await repository.existsWithNormalizedName(
    collectionId: collectionId,
    contentVersionId: contentVersionId,
    normalizedName: RarityValidation.normalizedName(input.name),
    excludingId: excludingId,
  );
  final validation = RarityValidation.validate(
    name: input.name,
    isDuplicateName: duplicate,
    colorValue: input.colorValue,
    iconId: input.iconId,
    frameId: input.frameId,
    effectId: input.effectId,
    sellValue: input.sellValue,
  );

  if (!validation.canSave) {
    throw const InvalidEntityFailure('La rareza no es valida.');
  }
}
