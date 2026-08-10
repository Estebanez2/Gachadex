import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/localization/app_localizations.dart';
import '../../../app/router/app_routes.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/app_empty_view.dart';
import '../../../core/widgets/app_error_view.dart';
import '../../../core/widgets/app_loading_view.dart';
import '../application/installed_collection_providers.dart';

class CollectionsPage extends ConsumerWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final collectionsAsync = ref.watch(installedCollectionsProvider);

    return collectionsAsync.when(
      loading: () => const AppLoadingView(),
      error: (_, _) => AppErrorView(
        title: l10n.screenErrorTitle,
        description: l10n.saveError,
      ),
      data: (collections) {
        if (collections.isEmpty) {
          return AppEmptyView(
            icon: Icons.collections_bookmark_outlined,
            title: l10n.noCollections,
            description: l10n.collectionsEmptyDescription,
          );
        }

        return ListView.separated(
          padding: AppConstants.pagePadding,
          itemCount: collections.length,
          separatorBuilder: (_, _) =>
              const SizedBox(height: AppConstants.spacingSm),
          itemBuilder: (context, index) {
            final collection = collections[index];
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
}
