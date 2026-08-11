import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/localization/app_localizations.dart';
import '../../../app/router/app_routes.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/domain/domain_enums.dart';
import '../../../core/errors/app_failure.dart';
import '../../../core/files/stored_media_image.dart';
import '../../../core/identifiers/entity_id.dart';
import '../../../core/widgets/app_empty_view.dart';
import '../../../core/widgets/app_error_view.dart';
import '../../../core/widgets/app_loading_view.dart';
import '../../album/application/album_providers.dart';
import '../../album/domain/entities/album_card_entry.dart';
import '../../import_export/application/gachadex_import_export_providers.dart';
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
    this.initialTabIndex = 0,
  });

  final InstalledCollectionId installedCollectionId;
  final int initialTabIndex;

  @override
  ConsumerState<InstalledCollectionDetailPage> createState() =>
      _InstalledCollectionDetailPageState();
}

class _InstalledCollectionDetailPageState
    extends ConsumerState<InstalledCollectionDetailPage> {
  bool _exporting = false;

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

    return DefaultTabController(
      length: 2,
      initialIndex: widget.initialTabIndex,
      child: Scaffold(
        appBar: AppBar(
          title: collectionAsync.maybeWhen(
            data: (collection) => Text(collection.name),
            orElse: () => Text(l10n.installedCollection),
          ),
          actions: [
            collectionAsync.maybeWhen(
              data: (collection) =>
                  collection.source == InstalledCollectionSource.createdLocally
                  ? IconButton(
                      tooltip: l10n.exportCollection,
                      onPressed: _exporting ? null : _exportCollection,
                      icon: _exporting
                          ? const SizedBox.square(
                              dimension: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.ios_share_outlined),
                    )
                  : const SizedBox.shrink(),
              orElse: () => const SizedBox.shrink(),
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                icon: const Icon(Icons.inventory_2_outlined),
                text: l10n.packs,
              ),
              Tab(icon: const Icon(Icons.grid_view_outlined), text: l10n.album),
            ],
          ),
        ),
        body: SafeArea(
          child: collectionAsync.when(
            loading: () => const AppLoadingView(),
            error: (_, _) => AppErrorView(
              title: l10n.screenErrorTitle,
              description: l10n.projectNotFound,
            ),
            data: (_) => TabBarView(
              children: [
                _PacksTab(installedCollectionId: widget.installedCollectionId),
                _AlbumTab(installedCollectionId: widget.installedCollectionId),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _exportCollection() async {
    final l10n = context.l10n;
    setState(() => _exporting = true);
    try {
      await ref
          .read(gachadexPackageActionsProvider)
          .exportAndShare(widget.installedCollectionId.value);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.collectionExported)));
      }
    } on GachadexPackageFailure catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.safeMessage)));
      }
    } on Object {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.exportError)));
      }
    } finally {
      if (mounted) {
        setState(() => _exporting = false);
      }
    }
  }
}

class _PacksTab extends ConsumerWidget {
  const _PacksTab({required this.installedCollectionId});

  final InstalledCollectionId installedCollectionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final inventoryAsync = ref.watch(
      packInventoryProvider(installedCollectionId),
    );
    final activeAsync = ref.watch(
      activePackOpeningProvider(installedCollectionId),
    );

    return activeAsync.when(
      loading: () => const AppLoadingView(),
      error: (_, _) => AppErrorView(
        title: l10n.screenErrorTitle,
        description: l10n.saveError,
      ),
      data: (activeOpening) => inventoryAsync.when(
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
              if (activeOpening != null) ...[
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.play_circle_outline),
                    title: Text(l10n.pendingOpening),
                    subtitle: Text(l10n.pendingOpeningDescription),
                    trailing: FilledButton(
                      onPressed: () => context.go(
                        AppRoutes.packOpeningPath(
                          installedCollectionId.value,
                          activeOpening.opening.id.value,
                        ),
                      ),
                      child: Text(l10n.continueOpening),
                    ),
                  ),
                ),
                const SizedBox(height: AppConstants.spacingMd),
              ],
              Text(
                l10n.packInventory,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: AppConstants.spacingMd),
              for (final inventory in inventories)
                _PackInventoryCard(
                  inventory: inventory,
                  hasActiveOpening: activeOpening != null,
                  installedCollectionId: installedCollectionId,
                ),
            ],
          );
        },
      ),
    );
  }
}

class _PackInventoryCard extends ConsumerStatefulWidget {
  const _PackInventoryCard({
    required this.inventory,
    required this.hasActiveOpening,
    required this.installedCollectionId,
  });

  final PackInventory inventory;
  final bool hasActiveOpening;
  final InstalledCollectionId installedCollectionId;

  @override
  ConsumerState<_PackInventoryCard> createState() => _PackInventoryCardState();
}

class _PackInventoryCardState extends ConsumerState<_PackInventoryCard> {
  bool _opening = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final packAsync = ref.watch(_packTypeProvider(widget.inventory.packTypeId));

    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingMd),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        child: packAsync.when(
          loading: () => const AppLoadingView(),
          error: (_, _) => Text(l10n.saveError),
          data: (pack) {
            final available = widget.inventory.availableCount;
            final remaining = widget.inventory.nextRechargeAtUtc.difference(
              DateTime.now().toUtc(),
            );
            final canRecharge = available < widget.inventory.maxAccumulated;
            final canOpen =
                available > 0 && !widget.hasActiveOpening && !_opening;

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
                    if (pack.isMain) Chip(label: Text(l10n.mainPack)),
                  ],
                ),
                const SizedBox(height: AppConstants.spacingSm),
                Text(
                  l10n.availablePacks(
                    available,
                    widget.inventory.maxAccumulated,
                  ),
                ),
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
                    onPressed: canOpen ? () => _open(pack.id) : null,
                    icon: _opening
                        ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.inventory_2_outlined),
                    label: Text(l10n.openPack),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _open(PackTypeId packTypeId) async {
    final l10n = context.l10n;
    setState(() => _opening = true);
    try {
      final opening = await ref
          .read(openPackProvider)
          .call(
            installedCollectionId: widget.installedCollectionId,
            packTypeId: packTypeId,
          );
      if (mounted) {
        context.go(
          AppRoutes.packOpeningPath(
            widget.installedCollectionId.value,
            opening.opening.id.value,
          ),
        );
      }
    } on AppFailure catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.safeMessage)));
      }
    } on Object {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.saveError)));
      }
    } finally {
      if (mounted) {
        setState(() => _opening = false);
      }
    }
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

class _AlbumTab extends ConsumerWidget {
  const _AlbumTab({required this.installedCollectionId});

  final InstalledCollectionId installedCollectionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final query = ref.watch(albumQueryProvider);
    final statsAsync = ref.watch(albumStatsProvider(installedCollectionId));
    final raritiesAsync = ref.watch(
      albumRaritiesProvider(installedCollectionId),
    );
    final cardsAsync = ref.watch(
      albumCardsProvider((
        installedCollectionId: installedCollectionId,
        query: query,
      )),
    );

    return ListView(
      padding: AppConstants.pagePadding,
      children: [
        statsAsync.when(
          loading: () => const AppLoadingView(),
          error: (_, _) => Text(l10n.saveError),
          data: (stats) => _AlbumStatsCard(stats: stats),
        ),
        const SizedBox(height: AppConstants.spacingMd),
        Wrap(
          spacing: AppConstants.spacingSm,
          runSpacing: AppConstants.spacingSm,
          children: [
            DropdownButton<AlbumStatusFilter>(
              value: query.status,
              onChanged: (value) {
                if (value != null) {
                  ref.read(albumQueryProvider.notifier).setStatus(value);
                }
              },
              items: [
                DropdownMenuItem(
                  value: AlbumStatusFilter.all,
                  child: Text(l10n.all),
                ),
                DropdownMenuItem(
                  value: AlbumStatusFilter.owned,
                  child: Text(l10n.owned),
                ),
                DropdownMenuItem(
                  value: AlbumStatusFilter.missing,
                  child: Text(l10n.missing),
                ),
                DropdownMenuItem(
                  value: AlbumStatusFilter.repeated,
                  child: Text(l10n.repeated),
                ),
                DropdownMenuItem(
                  value: AlbumStatusFilter.favorites,
                  child: Text(l10n.favorites),
                ),
              ],
            ),
            raritiesAsync.when(
              loading: () => const SizedBox.shrink(),
              error: (_, _) => const SizedBox.shrink(),
              data: (rarities) => DropdownButton<RarityId?>(
                value: query.rarityId,
                onChanged: (value) {
                  ref.read(albumQueryProvider.notifier).setRarity(value);
                },
                items: [
                  DropdownMenuItem<RarityId?>(
                    value: null,
                    child: Text(l10n.allRarities),
                  ),
                  for (final rarity in rarities)
                    DropdownMenuItem<RarityId?>(
                      value: rarity.id,
                      child: Text(rarity.name),
                    ),
                ],
              ),
            ),
            DropdownButton<AlbumMediaFilter>(
              value: query.media,
              onChanged: (value) {
                if (value != null) {
                  ref.read(albumQueryProvider.notifier).setMedia(value);
                }
              },
              items: [
                DropdownMenuItem(
                  value: AlbumMediaFilter.all,
                  child: Text(l10n.allMedia),
                ),
                DropdownMenuItem(
                  value: AlbumMediaFilter.image,
                  child: Text(l10n.photo),
                ),
                DropdownMenuItem(
                  value: AlbumMediaFilter.video,
                  child: Text(l10n.video),
                ),
              ],
            ),
            DropdownButton<AlbumSort>(
              value: query.sort,
              onChanged: (value) {
                if (value != null) {
                  ref.read(albumQueryProvider.notifier).setSort(value);
                }
              },
              items: [
                DropdownMenuItem(
                  value: AlbumSort.number,
                  child: Text(l10n.collectionNumber),
                ),
                DropdownMenuItem(value: AlbumSort.name, child: Text(l10n.name)),
                DropdownMenuItem(
                  value: AlbumSort.rarity,
                  child: Text(l10n.rarity),
                ),
                DropdownMenuItem(
                  value: AlbumSort.firstObtained,
                  child: Text(l10n.firstObtainedSort),
                ),
                DropdownMenuItem(
                  value: AlbumSort.quantity,
                  child: Text(l10n.quantity),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppConstants.spacingMd),
        cardsAsync.when(
          loading: () => const AppLoadingView(),
          error: (_, _) => AppErrorView(
            title: l10n.screenErrorTitle,
            description: l10n.saveError,
          ),
          data: (cards) => GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cards.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 180,
              childAspectRatio: 0.68,
              mainAxisSpacing: AppConstants.spacingMd,
              crossAxisSpacing: AppConstants.spacingMd,
            ),
            itemBuilder: (context, index) {
              return _AlbumCardTile(
                entry: cards[index],
                installedCollectionId: installedCollectionId,
                onToggleFavorite: () => ref
                    .read(toggleFavoriteCardProvider)
                    .call(
                      installedCollectionId: installedCollectionId,
                      cardId: cards[index].cardId,
                    ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _AlbumStatsCard extends StatelessWidget {
  const _AlbumStatsCard({required this.stats});

  final AlbumStats stats;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final percent = (stats.completionRatio * 100).toStringAsFixed(1);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.album,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: AppConstants.spacingSm),
            Text(
              l10n.albumProgress(
                stats.distinctOwnedCount,
                stats.totalCardCount,
                percent,
              ),
            ),
            Text(l10n.totalCopies(stats.totalCopies)),
            Text(l10n.favoriteCount(stats.favoriteCount)),
          ],
        ),
      ),
    );
  }
}

class _AlbumCardTile extends StatelessWidget {
  const _AlbumCardTile({
    required this.entry,
    required this.installedCollectionId,
    required this.onToggleFavorite,
  });

  final AlbumCardEntry entry;
  final InstalledCollectionId installedCollectionId;
  final VoidCallback onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final title = entry.isOwned ? entry.name! : l10n.undiscovered;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: entry.isOwned
            ? () => context.go(
                AppRoutes.albumCardPath(
                  installedCollectionId.value,
                  entry.cardId.value,
                ),
              )
            : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: entry.thumbnailRelativePath == null
                  ? ColoredBox(
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                      child: const Icon(Icons.lock_outline, size: 44),
                    )
                  : StoredMediaImage(
                      path: entry.thumbnailRelativePath!,
                      fit: BoxFit.cover,
                    ),
            ),
            if (entry.mediaType == MediaType.video && entry.isOwned)
              const Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.all(AppConstants.spacingXs),
                  child: Icon(Icons.play_circle_fill),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(AppConstants.spacingSm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '#${entry.collectionNumber} $title',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          entry.isOwned
                              ? '${entry.rarityName} · x${entry.quantity}'
                              : l10n.missing,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (entry.isOwned)
                        IconButton(
                          tooltip: l10n.favoriteToggle,
                          onPressed: onToggleFavorite,
                          icon: Icon(
                            entry.isFavorite
                                ? Icons.star
                                : Icons.star_border_outlined,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
