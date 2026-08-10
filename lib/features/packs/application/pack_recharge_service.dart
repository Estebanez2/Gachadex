// ignore_for_file: prefer_initializing_formals

import '../../../core/identifiers/entity_id.dart';
import '../../../core/time/clock.dart';
import '../../collections/domain/repositories/installed_collection_repository.dart';
import '../domain/entities/pack_inventory.dart';
import '../domain/repositories/pack_inventory_repository.dart';
import '../domain/repositories/pack_type_repository.dart';
import '../domain/services/pack_recharge_calculator.dart';

final class PackRechargeService {
  PackRechargeService({
    required InstalledCollectionRepository installedCollectionRepository,
    required PackInventoryRepository packInventoryRepository,
    required PackTypeRepository packTypeRepository,
    required Clock clock,
    PackRechargeCalculator calculator = const PackRechargeCalculator(),
  }) : _installedCollectionRepository = installedCollectionRepository,
       _packInventoryRepository = packInventoryRepository,
       _packTypeRepository = packTypeRepository,
       _clock = clock,
       _calculator = calculator;

  final InstalledCollectionRepository _installedCollectionRepository;
  final PackInventoryRepository _packInventoryRepository;
  final PackTypeRepository _packTypeRepository;
  final Clock _clock;
  final PackRechargeCalculator _calculator;
  bool _refreshing = false;

  Future<void> refreshAllCollections() async {
    if (_refreshing) {
      return;
    }
    _refreshing = true;
    try {
      final collections = await _installedCollectionRepository.watchAll().first;
      for (final collection in collections) {
        await refreshCollection(collection.id);
      }
    } finally {
      _refreshing = false;
    }
  }

  Future<void> refreshCollection(InstalledCollectionId id) async {
    final inventories = await _packInventoryRepository.getByInstalledCollection(
      id,
    );
    for (final inventory in inventories) {
      await refreshPack(inventory.packTypeId);
    }
  }

  Future<void> refreshPack(PackTypeId packTypeId) async {
    final now = _clock.nowUtc();
    final packType = await _packTypeRepository.getById(packTypeId);
    final collections = await _installedCollectionRepository.watchAll().first;
    for (final collection in collections.where(
      (collection) => collection.contentVersionId == packType.contentVersionId,
    )) {
      final inventories = await _packInventoryRepository
          .getByInstalledCollection(collection.id);
      PackInventory? inventory;
      for (final candidate in inventories) {
        if (candidate.packTypeId == packTypeId) {
          inventory = candidate;
          break;
        }
      }
      if (inventory == null) {
        continue;
      }
      final result = _calculator.calculate(
        availableCount: inventory.availableCount,
        maxAccumulated: inventory.maxAccumulated,
        rechargeSeconds: packType.rechargeSeconds,
        nextRechargeAtUtc: inventory.nextRechargeAtUtc,
        currentTimeUtc: now,
      );
      if (!result.changedFrom(
        previousAvailableCount: inventory.availableCount,
        previousNextRechargeAtUtc: inventory.nextRechargeAtUtc,
      )) {
        continue;
      }
      await _packInventoryRepository.update(
        PackInventory(
          installedCollectionId: inventory.installedCollectionId,
          packTypeId: inventory.packTypeId,
          availableCount: result.availableCount,
          maxAccumulated: inventory.maxAccumulated,
          nextRechargeAtUtc: result.nextRechargeAtUtc,
          lastCalculatedAtUtc: now,
        ),
      );
    }
  }
}
