import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/localization/app_localizations.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/identifiers/entity_id.dart';
import '../../../core/widgets/app_empty_view.dart';
import '../../../core/widgets/app_error_view.dart';
import '../../../core/widgets/app_loading_view.dart';
import '../../packs/application/pack_providers.dart';
import '../../packs/domain/entities/pack_inventory.dart';
import '../../packs/domain/entities/pack_type.dart';
import '../application/installed_collection_providers.dart';

final _packTypeProvider = FutureProvider.autoDispose
    .family<PackType, PackTypeId>((ref, id) {
      return ref.watch(packRepositoryProvider).getById(id);
    });

class InstalledCollectionDetailPage extends ConsumerStatefulWidget {
  const InstalledCollectionDetailPage({
    super.key,
    required this.installedCollectionId,
  });

  final InstalledCollectionId installedCollectionId;

  @override
  ConsumerState<InstalledCollectionDetailPage> createState() =>
      _InstalledCollectionDetailPageState();
}

class _InstalledCollectionDetailPageState
    extends ConsumerState<InstalledCollectionDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(
        ref
            .read(packRechargeServiceProvider)
            .refreshCollection(widget.installedCollectionId),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final collectionAsync = ref.watch(
      installedCollectionProvider(widget.installedCollectionId),
    );
    final inventoryAsync = ref.watch(
      packInventoryProvider(widget.installedCollectionId),
    );

    return Scaffold(
      appBar: AppBar(
        title: collectionAsync.maybeWhen(
          data: (collection) => Text(collection.name),
          orElse: () => Text(l10n.installedCollection),
        ),
      ),
      body: SafeArea(
        child: collectionAsync.when(
          loading: () => const AppLoadingView(),
          error: (_, _) => AppErrorView(
            title: l10n.screenErrorTitle,
            description: l10n.projectNotFound,
          ),
          data: (collection) => inventoryAsync.when(
            loading: () => const AppLoadingView(),
            error: (_, _) => AppErrorView(
              title: l10n.screenErrorTitle,
              description: l10n.saveError,
            ),
            data: (inventories) {
              if (inventories.isEmpty) {
                return AppEmptyView(
                  icon: Icons.inventory_2_outlined,
                  title: l10n.noPackInventoryTitle,
                  description: l10n.noPackInventoryDescription,
                );
              }

              return ListView(
                padding: AppConstants.pagePadding,
                children: [
                  Text(
                    l10n.packInventory,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingMd),
                  for (final inventory in inventories)
                    _PackInventoryCard(
                      inventory: inventory,
                      isMain: inventory.packTypeId == collection.mainPackTypeId,
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _PackInventoryCard extends ConsumerWidget {
  const _PackInventoryCard({required this.inventory, required this.isMain});

  final PackInventory inventory;
  final bool isMain;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final packAsync = ref.watch(_packTypeProvider(inventory.packTypeId));

    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingMd),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        child: packAsync.when(
          loading: () => const AppLoadingView(),
          error: (_, _) => Text(l10n.saveError),
          data: (pack) {
            final available = inventory.availableCount;
            final now = DateTime.now().toUtc();
            final remaining = inventory.nextRechargeAtUtc.difference(now);
            final canRecharge = available < inventory.maxAccumulated;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        pack.name,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ),
                    if (isMain) Chip(label: Text(l10n.mainPack)),
                  ],
                ),
                const SizedBox(height: AppConstants.spacingSm),
                Text(l10n.availablePacks(available, inventory.maxAccumulated)),
                const SizedBox(height: AppConstants.spacingXs),
                Text(
                  canRecharge
                      ? l10n.nextPackIn(_formatRemaining(remaining))
                      : l10n.packRechargeFull,
                ),
                const SizedBox(height: AppConstants.spacingMd),
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.lock_open_outlined),
                    label: Text(l10n.openPackComingSoon),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  String _formatRemaining(Duration duration) {
    final safe = duration.isNegative ? Duration.zero : duration;
    final hours = safe.inHours;
    final minutes = safe.inMinutes.remainder(60);
    final seconds = safe.inSeconds.remainder(60);
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    }
    return '${seconds}s';
  }
}
