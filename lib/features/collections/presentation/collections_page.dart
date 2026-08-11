import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/localization/app_localizations.dart';
import '../../../app/router/app_routes.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/app_empty_view.dart';
import '../../../core/widgets/app_error_view.dart';
import '../../../core/widgets/app_loading_view.dart';
import '../../import_export/application/gachadex_import_export_providers.dart';
import '../../import_export/domain/gachadex_package_failure.dart';
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
    final collectionsAsync = ref.watch(installedCollectionsProvider);

    return collectionsAsync.when(
      loading: () => const AppLoadingView(),
      error: (_, _) => AppErrorView(
        title: l10n.screenErrorTitle,
        description: l10n.saveError,
      ),
      data: (collections) {
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

        if (collections.isEmpty) {
          return Padding(
            padding: AppConstants.pagePadding,
            child: Column(
              children: [
                importButton,
                const SizedBox(height: AppConstants.spacingMd),
                Expanded(
                  child: AppEmptyView(
                    icon: Icons.collections_bookmark_outlined,
                    title: l10n.noCollections,
                    description: l10n.collectionsEmptyDescription,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: AppConstants.pagePadding,
          itemCount: collections.length + 1,
          separatorBuilder: (_, _) =>
              const SizedBox(height: AppConstants.spacingSm),
          itemBuilder: (context, index) {
            if (index == 0) {
              return importButton;
            }
            final collection = collections[index - 1];
            return Card(
              child: ListTile(
                leading: const Icon(Icons.collections_bookmark_outlined),
                title: Text(
                  collection.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  l10n.collectionProgress(
                    collection.distinctOwnedCount,
                    collection.totalCardCount,
                  ),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.go(
                  AppRoutes.installedCollectionPath(collection.id.value),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _importCollection() async {
    final l10n = context.l10n;
    setState(() => _importing = true);
    try {
      final picked = await ref
          .read(gachadexPackageActionsProvider)
          .pickForImport();
      if (!mounted) {
        return;
      }
      if (picked.preview.alreadyInstalled) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.collectionAlreadyInstalled)),
        );
        return;
      }
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(l10n.importPreviewTitle),
          content: Text(
            l10n.importPreviewDescription(
              picked.preview.name,
              picked.preview.cardCount,
              picked.preview.videoCount,
              picked.preview.packTypeCount,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(l10n.importCollection),
            ),
          ],
        ),
      );
      if (confirmed != true) {
        return;
      }
      await ref.read(gachadexPackageActionsProvider).importPicked(picked.path);
      if (mounted) {
        ref.invalidate(installedCollectionsProvider);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.collectionImported)));
      }
    } on GachadexPackageCanceled {
      return;
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
        ).showSnackBar(SnackBar(content: Text(l10n.importError)));
      }
    } finally {
      if (mounted) {
        setState(() => _importing = false);
      }
    }
  }
}
