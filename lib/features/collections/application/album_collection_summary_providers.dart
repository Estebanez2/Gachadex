import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_providers.dart';
import '../../../core/identifiers/entity_id.dart';
import '../../../core/value_objects/relative_media_path.dart';
import '../../packs/domain/entities/pack_inventory.dart';
import '../domain/entities/installed_collection.dart';

final albumCollectionSummariesProvider =
    StreamProvider.autoDispose<List<AlbumCollectionSummary>>((ref) {
      final collections = ref.watch(installedCollectionRepositoryProvider);
      final inventories = ref.watch(packInventoryRepositoryProvider);
      return _combineLatest(
        collections.watchAll(),
        inventories.watchAll(),
        _buildSummaries,
      );
    });

final class AlbumCollectionSummary {
  const AlbumCollectionSummary({
    required this.installedCollectionId,
    required this.name,
    required this.author,
    required this.coverRelativePath,
    required this.totalCardCount,
    required this.distinctOwnedCount,
    required this.totalAvailablePacks,
    required this.coins,
  });

  final InstalledCollectionId installedCollectionId;
  final String name;
  final String? author;
  final RelativeMediaPath? coverRelativePath;
  final int totalCardCount;
  final int distinctOwnedCount;
  final int totalAvailablePacks;
  final int coins;

  double get completionRatio {
    if (totalCardCount == 0) {
      return 0;
    }
    return distinctOwnedCount / totalCardCount;
  }
}

List<AlbumCollectionSummary> _buildSummaries(
  List<InstalledCollection> collections,
  List<PackInventory> inventories,
) {
  final packsByCollection = <String, int>{};
  for (final inventory in inventories) {
    final key = inventory.installedCollectionId.value;
    packsByCollection[key] =
        (packsByCollection[key] ?? 0) + inventory.availableCount;
  }

  return [
    for (final collection in collections)
      AlbumCollectionSummary(
        installedCollectionId: collection.id,
        name: collection.name,
        author: collection.author,
        coverRelativePath: collection.coverRelativePath,
        totalCardCount: collection.totalCardCount,
        distinctOwnedCount: collection.distinctOwnedCount,
        totalAvailablePacks: packsByCollection[collection.id.value] ?? 0,
        coins: collection.coins,
      ),
  ];
}

Stream<R> _combineLatest<A, B, R>(
  Stream<A> first,
  Stream<B> second,
  R Function(A first, B second) combine,
) {
  late StreamController<R> controller;
  StreamSubscription<A>? firstSubscription;
  StreamSubscription<B>? secondSubscription;
  A? latestFirst;
  B? latestSecond;
  var hasFirst = false;
  var hasSecond = false;

  void emitIfReady() {
    if (hasFirst && hasSecond) {
      controller.add(combine(latestFirst as A, latestSecond as B));
    }
  }

  controller = StreamController<R>(
    onListen: () {
      firstSubscription = first.listen((value) {
        latestFirst = value;
        hasFirst = true;
        emitIfReady();
      }, onError: controller.addError);
      secondSubscription = second.listen((value) {
        latestSecond = value;
        hasSecond = true;
        emitIfReady();
      }, onError: controller.addError);
    },
    onCancel: () async {
      await firstSubscription?.cancel();
      await secondSubscription?.cancel();
    },
  );

  return controller.stream;
}
