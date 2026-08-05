import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart' hide PackInventory;
import '../../../../core/database/mappers/date_time_mapper.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../../../album/domain/entities/owned_card.dart';
import '../../domain/entities/pack_inventory.dart';
import '../../domain/entities/pack_opening.dart';
import '../../domain/entities/pack_opening_card.dart';

extension PackInventoryRowMapper on PackInventoryRow {
  PackInventory toDomain() {
    return PackInventory(
      installedCollectionId: InstalledCollectionId(installedCollectionId),
      packTypeId: PackTypeId(packTypeId),
      availableCount: availableCount,
      maxAccumulated: maxAccumulated,
      nextRechargeAtUtc: fromDatabaseUtc(nextRechargeAtUtc),
      lastCalculatedAtUtc: fromDatabaseUtc(lastCalculatedAtUtc),
    );
  }
}

extension OwnedCardRowMapper on OwnedCardRow {
  OwnedCard toDomain() {
    return OwnedCard(
      installedCollectionId: InstalledCollectionId(installedCollectionId),
      cardId: CardId(cardId),
      quantity: quantity,
      firstObtainedAtUtc: fromDatabaseUtc(firstObtainedAtUtc),
      lastObtainedAtUtc: fromDatabaseUtc(lastObtainedAtUtc),
      isFavorite: isFavorite,
    );
  }
}

extension PackOpeningDomainMapper on PackOpening {
  PackOpeningsCompanion toCompanion() {
    return PackOpeningsCompanion(
      id: Value(id.value),
      installedCollectionId: Value(installedCollectionId.value),
      packTypeId: Value(packTypeId.value),
      status: Value(status),
      generatedAtUtc: Value(toDatabaseUtc(generatedAtUtc)),
      completedAtUtc: Value(
        completedAtUtc == null ? null : toDatabaseUtc(completedAtUtc!),
      ),
    );
  }
}

extension PackOpeningCardDomainMapper on PackOpeningCard {
  PackOpeningCardsCompanion toCompanion() {
    return PackOpeningCardsCompanion(
      openingId: Value(openingId.value),
      cardId: Value(cardId.value),
      slotIndex: Value(slotIndex),
      wasNew: Value(wasNew),
      quantityAfter: Value(quantityAfter),
      revealed: Value(revealed),
    );
  }
}
