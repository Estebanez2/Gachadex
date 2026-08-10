// ignore_for_file: prefer_initializing_formals

import 'dart:math';

import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/mappers/date_time_mapper.dart';
import '../../../core/domain/domain_enums.dart';
import '../../../core/errors/app_failure.dart';
import '../../../core/identifiers/entity_id.dart';
import '../../../core/identifiers/uuid_generator.dart';
import '../../../core/time/clock.dart';
import '../../cards/domain/repositories/card_repository.dart';
import '../../collections/domain/repositories/installed_collection_repository.dart';
import '../../rarities/domain/repositories/rarity_repository.dart';
import '../domain/entities/pack_configuration.dart';
import '../domain/entities/pack_opening_details.dart';
import '../domain/repositories/pack_opening_repository.dart';
import '../domain/repositories/pack_type_repository.dart';
import '../domain/services/pack_generator.dart';
import '../domain/services/pack_recharge_calculator.dart';
import '../domain/validation/pack_validation.dart';
import 'pack_recharge_service.dart';

final class OpenPack {
  OpenPack({
    required AppDatabase database,
    required InstalledCollectionRepository installedCollectionRepository,
    required CardRepository cardRepository,
    required RarityRepository rarityRepository,
    required PackTypeRepository packTypeRepository,
    required PackOpeningRepository packOpeningRepository,
    required PackRechargeService rechargeService,
    required UuidGenerator uuidGenerator,
    required Clock clock,
    PackGenerator generator = const PackGenerator(),
    PackRechargeCalculator rechargeCalculator = const PackRechargeCalculator(),
    Random? random,
  }) : _database = database,
       _installedCollectionRepository = installedCollectionRepository,
       _cardRepository = cardRepository,
       _rarityRepository = rarityRepository,
       _packTypeRepository = packTypeRepository,
       _packOpeningRepository = packOpeningRepository,
       _rechargeService = rechargeService,
       _uuidGenerator = uuidGenerator,
       _clock = clock,
       _generator = generator,
       _rechargeCalculator = rechargeCalculator,
       _random = random ?? Random();

  final AppDatabase _database;
  final InstalledCollectionRepository _installedCollectionRepository;
  final CardRepository _cardRepository;
  final RarityRepository _rarityRepository;
  final PackTypeRepository _packTypeRepository;
  final PackOpeningRepository _packOpeningRepository;
  final PackRechargeService _rechargeService;
  final UuidGenerator _uuidGenerator;
  final Clock _clock;
  final PackGenerator _generator;
  final PackRechargeCalculator _rechargeCalculator;
  final Random _random;

  Future<PackOpeningDetails> call({
    required InstalledCollectionId installedCollectionId,
    required PackTypeId packTypeId,
  }) async {
    await _rechargeService.refreshCollection(installedCollectionId);
    final existing = await _packOpeningRepository.getActive(
      installedCollectionId,
    );
    if (existing != null) {
      return existing;
    }

    final installed = await _installedCollectionRepository.getById(
      installedCollectionId,
    );
    final config = await _packTypeRepository.getFullConfiguration(packTypeId);
    if (config.packType.collectionId != installed.collectionId ||
        config.packType.contentVersionId != installed.contentVersionId) {
      throw const ReferentialIntegrityFailure(
        'El sobre no pertenece a esta coleccion.',
      );
    }

    final cards = await _cardRepository
        .watchByCollectionVersion(
          collectionId: installed.collectionId,
          contentVersionId: installed.contentVersionId,
        )
        .first;
    final rarities = await _rarityRepository
        .watchByCollectionVersion(
          collectionId: installed.collectionId,
          contentVersionId: installed.contentVersionId,
        )
        .first;
    final validation = PackValidation.validateConfiguration(
      configuration: config,
      cards: cards,
      rarities: rarities,
    );
    if (!validation.canSave) {
      throw const InvalidEntityFailure(
        'La configuracion del sobre no es valida.',
      );
    }
    final generated = _generator.generate(
      PackGenerationContext(
        configuration: config,
        eligibleCards: cards,
        rarities: rarities,
      ),
      _random,
    );

    final openingId = _uuidGenerator.packOpeningId();
    final now = _clock.nowUtc();
    await _database.transaction(() async {
      final active = await _database.playerProgressDao.getActiveOpening(
        installedCollectionId.value,
      );
      if (active != null) {
        throw const InvalidEntityFailure('Ya hay una apertura en curso.');
      }
      final inventory =
          await (_database.select(_database.packInventory)..where(
                (table) =>
                    table.installedCollectionId.equals(
                      installedCollectionId.value,
                    ) &
                    table.packTypeId.equals(packTypeId.value),
              ))
              .getSingleOrNull();
      if (inventory == null || inventory.availableCount <= 0) {
        throw const InvalidEntityFailure('No tienes sobres disponibles.');
      }

      final newAvailableCount = inventory.availableCount - 1;
      final nextRechargeAtUtc = _rechargeCalculator.nextAfterConsumed(
        previousAvailableCount: inventory.availableCount,
        newAvailableCount: newAvailableCount,
        maxAccumulated: inventory.maxAccumulated,
        rechargeSeconds: config.packType.rechargeSeconds,
        currentTimeUtc: now,
        currentNextRechargeAtUtc: fromDatabaseUtc(inventory.nextRechargeAtUtc),
      );
      await (_database.update(_database.packInventory)..where(
            (table) =>
                table.installedCollectionId.equals(
                  installedCollectionId.value,
                ) &
                table.packTypeId.equals(packTypeId.value),
          ))
          .write(
            PackInventoryCompanion(
              availableCount: Value(newAvailableCount),
              nextRechargeAtUtc: Value(toDatabaseUtc(nextRechargeAtUtc)),
              lastCalculatedAtUtc: Value(toDatabaseUtc(now)),
            ),
          );
      await _database
          .into(_database.packOpenings)
          .insert(
            PackOpeningsCompanion(
              id: Value(openingId.value),
              installedCollectionId: Value(installedCollectionId.value),
              packTypeId: Value(packTypeId.value),
              status: const Value(PackOpeningStatus.generated),
              generatedAtUtc: Value(toDatabaseUtc(now)),
              completedAtUtc: const Value(null),
            ),
          );

      var newDistinctCards = 0;
      final quantities = <CardId, int>{};
      for (var index = 0; index < generated.length; index++) {
        final card = generated[index];
        final current =
            quantities[card.id] ??
            await _loadCurrentQuantity(installedCollectionId, card.id);
        final quantityAfter = current + 1;
        final wasNew = current == 0;
        quantities[card.id] = quantityAfter;
        if (wasNew) {
          newDistinctCards += 1;
          await _database
              .into(_database.ownedCards)
              .insert(
                OwnedCardsCompanion(
                  installedCollectionId: Value(installedCollectionId.value),
                  cardId: Value(card.id.value),
                  quantity: const Value(1),
                  firstObtainedAtUtc: Value(toDatabaseUtc(now)),
                  lastObtainedAtUtc: Value(toDatabaseUtc(now)),
                  isFavorite: const Value(false),
                ),
              );
        } else {
          await (_database.update(_database.ownedCards)..where(
                (table) =>
                    table.installedCollectionId.equals(
                      installedCollectionId.value,
                    ) &
                    table.cardId.equals(card.id.value),
              ))
              .write(
                OwnedCardsCompanion(
                  quantity: Value(quantityAfter),
                  lastObtainedAtUtc: Value(toDatabaseUtc(now)),
                ),
              );
        }
        await _database
            .into(_database.packOpeningCards)
            .insert(
              PackOpeningCardsCompanion(
                openingId: Value(openingId.value),
                cardId: Value(card.id.value),
                slotIndex: Value(index),
                wasNew: Value(wasNew),
                quantityAfter: Value(quantityAfter),
                revealed: const Value(false),
              ),
            );
      }
      if (newDistinctCards > 0) {
        await (_database.update(_database.installedCollections)
              ..where((table) => table.id.equals(installedCollectionId.value)))
            .write(
              InstalledCollectionsCompanion(
                distinctOwnedCount: Value(
                  installed.distinctOwnedCount + newDistinctCards,
                ),
              ),
            );
      }
    });

    return _packOpeningRepository.getById(openingId);
  }

  Future<int> _loadCurrentQuantity(
    InstalledCollectionId installedCollectionId,
    CardId cardId,
  ) async {
    final row =
        await (_database.select(_database.ownedCards)..where(
              (table) =>
                  table.installedCollectionId.equals(
                    installedCollectionId.value,
                  ) &
                  table.cardId.equals(cardId.value),
            ))
            .getSingleOrNull();
    return row?.quantity ?? 0;
  }
}

final class ResumePackOpening {
  const ResumePackOpening(this._repository);

  final PackOpeningRepository _repository;

  Future<PackOpeningDetails?> call(InstalledCollectionId id) {
    return _repository.getActive(id);
  }
}

final class StartRevealingPackOpening {
  const StartRevealingPackOpening(this._repository);

  final PackOpeningRepository _repository;

  Future<void> call(PackOpeningId id) => _repository.markRevealing(id);
}

final class RevealOpeningCard {
  const RevealOpeningCard(this._repository);

  final PackOpeningRepository _repository;

  Future<void> call({
    required PackOpeningId openingId,
    required int slotIndex,
  }) {
    return _repository.revealCard(openingId: openingId, slotIndex: slotIndex);
  }
}

final class CompletePackOpening {
  const CompletePackOpening(this._repository);

  final PackOpeningRepository _repository;

  Future<void> call(PackOpeningId id) => _repository.complete(id);
}
