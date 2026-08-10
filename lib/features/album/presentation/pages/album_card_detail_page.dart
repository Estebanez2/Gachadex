import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/files/stored_media_image.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_loading_view.dart';
import '../../application/album_providers.dart';

class AlbumCardDetailPage extends ConsumerWidget {
  const AlbumCardDetailPage({
    super.key,
    required this.installedCollectionId,
    required this.cardId,
  });

  final InstalledCollectionId installedCollectionId;
  final CardId cardId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final cardAsync = ref.watch(
      albumCardProvider((id: installedCollectionId, cardId: cardId)),
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.cardDetail)),
      body: SafeArea(
        child: cardAsync.when(
          loading: () => const AppLoadingView(),
          error: (_, _) => AppErrorView(
            title: l10n.screenErrorTitle,
            description: l10n.saveError,
          ),
          data: (entry) {
            if (!entry.isOwned) {
              return AppErrorView(
                title: l10n.undiscovered,
                description: l10n.cardStillMissing,
              );
            }
            return ListView(
              padding: AppConstants.pagePadding,
              children: [
                AspectRatio(
                  aspectRatio: 0.72,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AppConstants.cardRadius,
                    ),
                    child: StoredMediaImage(
                      path: entry.imageRelativePath!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: AppConstants.spacingMd),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        entry.name ?? l10n.undiscovered,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ),
                    IconButton.filledTonal(
                      tooltip: l10n.favorites,
                      onPressed: () => ref
                          .read(toggleFavoriteCardProvider)
                          .call(
                            installedCollectionId: installedCollectionId,
                            cardId: entry.cardId,
                          ),
                      icon: Icon(
                        entry.isFavorite
                            ? Icons.star
                            : Icons.star_border_outlined,
                      ),
                    ),
                  ],
                ),
                Text('${l10n.collectionNumber}: ${entry.collectionNumber}'),
                if (entry.health != null)
                  Text('${l10n.health}: ${entry.health}'),
                Text('${l10n.rarity}: ${entry.rarityName ?? ''}'),
                if (entry.description != null) ...[
                  const SizedBox(height: AppConstants.spacingSm),
                  Text('${l10n.description}: ${entry.description}'),
                ],
                if (entry.templateId != null)
                  Text('${l10n.template}: ${entry.templateId}'),
                if (entry.frameId != null)
                  Text('${l10n.frame}: ${entry.frameId}'),
                Text('${l10n.copies}: ${entry.quantity}'),
                if (entry.firstObtainedAtUtc != null)
                  Text(
                    l10n.firstObtained(
                      MaterialLocalizations.of(
                        context,
                      ).formatShortDate(entry.firstObtainedAtUtc!.toLocal()),
                    ),
                  ),
                if (entry.fieldValues.isNotEmpty) ...[
                  const SizedBox(height: AppConstants.spacingMd),
                  Text(
                    l10n.comicFields,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSm),
                  for (final field in entry.fieldValues)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(field.label),
                      subtitle: Text(field.value),
                    ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
