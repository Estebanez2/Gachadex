import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/localization/app_localizations.dart';
import '../../../app/router/app_routes.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/files/stored_media_image.dart';
import '../../../core/value_objects/relative_media_path.dart';
import '../../../core/widgets/app_empty_view.dart';
import '../../../core/widgets/app_error_view.dart';
import '../../../core/widgets/app_loading_view.dart';
import '../../../core/widgets/gachadex_ui.dart';
import '../application/album_collection_summary_providers.dart';
import '../../import_export/presentation/import_collection_flow.dart';
import '../application/installed_collection_providers.dart';

class CollectionsPage extends ConsumerStatefulWidget {
  const CollectionsPage({super.key});

  @override
  ConsumerState<CollectionsPage> createState() => _CollectionsPageState();
}

class _CollectionsPageState extends ConsumerState<CollectionsPage> {
  bool _importing = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final summariesAsync = ref.watch(albumCollectionSummariesProvider);

    return summariesAsync.when(
      loading: () => const AppLoadingView(),
      error: (_, _) => AppErrorView(
        title: l10n.screenErrorTitle,
        description: l10n.saveError,
      ),
      data: (summaries) {
        final importButton = Align(
          alignment: Alignment.centerRight,
          child: FilledButton.icon(
            onPressed: _importing ? null : _importCollection,
            icon: _importing
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.file_upload_outlined),
            label: Text(l10n.importCollection),
          ),
        );

        if (summaries.isEmpty) {
          return Padding(
            padding: AppConstants.pagePadding,
            child: Column(
              children: [
                Expanded(
                  child: AppEmptyView(
                    icon: Icons.collections_bookmark_outlined,
                    title: l10n.albumEmptyTitle,
                    description: l10n.albumEmptyDescription,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => context.go(AppRoutes.createPath),
                        icon: const Icon(Icons.add_box_outlined),
                        label: Text(l10n.createCollection),
                      ),
                    ),
                    const SizedBox(width: AppConstants.spacingSm),
                    Expanded(child: importButton),
                  ],
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: AppConstants.pagePadding,
          itemCount: summaries.length + 2,
          separatorBuilder: (_, _) =>
              const SizedBox(height: AppConstants.spacingSm),
          itemBuilder: (context, index) {
            if (index == 0) {
              return GachadexHeroPanel(
                icon: Icons.collections_bookmark_outlined,
                title: l10n.album,
                description: l10n.albumLibraryDescription,
              );
            }
            if (index == 1) {
              return GachadexSectionHeader(
                icon: Icons.folder_open_outlined,
                title: l10n.collections,
                trailing: importButton,
              );
            }
            final summary = summaries[index - 2];
            return _AlbumCollectionCard(summary: summary);
          },
        );
      },
    );
  }

  Future<void> _importCollection() async {
    setState(() => _importing = true);
    try {
      final imported = await runImportCollectionFlow(
        context: context,
        ref: ref,
      );
      if (imported) {
        ref.invalidate(installedCollectionsProvider);
        ref.invalidate(albumCollectionSummariesProvider);
      }
    } finally {
      if (mounted) {
        setState(() => _importing = false);
      }
    }
  }
}

class _AlbumCollectionCard extends StatelessWidget {
  const _AlbumCollectionCard({required this.summary});

  final AlbumCollectionSummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final percent = (summary.completionRatio * 100).toStringAsFixed(1);

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        onTap: () => context.go(
          AppRoutes.installedCollectionPath(
            summary.installedCollectionId.value,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spacingMd),
          child: Row(
            children: [
              _CollectionCover(path: summary.coverRelativePath),
              const SizedBox(width: AppConstants.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            summary.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                        ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                    if (summary.author != null) ...[
                      const SizedBox(height: AppConstants.spacingXs),
                      Text(
                        summary.author!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: AppConstants.spacingSm),
                    Wrap(
                      spacing: AppConstants.spacingSm,
                      runSpacing: AppConstants.spacingSm,
                      children: [
                        GachadexMetricPill(
                          icon: Icons.grid_view_outlined,
                          value: percent,
                          label: l10n.albumProgress(
                            summary.distinctOwnedCount,
                            summary.totalCardCount,
                            percent,
                          ),
                        ),
                        GachadexMetricPill(
                          icon: Icons.inventory_2_outlined,
                          value: summary.totalAvailablePacks.toString(),
                          label: l10n.totalAvailablePacksCount(
                            summary.totalAvailablePacks,
                          ),
                        ),
                        GachadexMetricPill(
                          icon: Icons.toll_outlined,
                          value: summary.coins.toString(),
                          label: l10n.gachacoin,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CollectionCover extends StatelessWidget {
  const _CollectionCover({required this.path});

  final RelativeMediaPath? path;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppConstants.cardRadius),
      child: SizedBox.square(
        dimension: 76,
        child: path == null
            ? ColoredBox(
                color: colorScheme.secondaryContainer,
                child: Icon(
                  Icons.collections_bookmark_outlined,
                  color: colorScheme.onSecondaryContainer,
                ),
              )
            : StoredMediaImage(path: path!),
      ),
    );
  }
}
