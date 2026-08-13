import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/domain/domain_enums.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/files/card_video_player.dart';
import '../../../../core/files/stored_media_image.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_loading_view.dart';
import '../../../collections/application/installed_collection_providers.dart';
import '../../../cards/presentation/widgets/gachadex_card.dart';
import '../../../economy/application/economy_providers.dart';
import '../../application/album_providers.dart';
import '../../domain/entities/album_card_entry.dart';

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
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 380),
                    child: GachadexCard(
                      name: entry.name ?? '',
                      health: entry.health,
                      description: entry.description ?? '',
                      rarityName: entry.rarityName ?? '',
                      rarityColorValue: entry.rarityColorValue,
                      rarityEffectId: entry.rarityEffectId,
                      mediaType: entry.mediaType,
                      animateEffect: true,
                      showVideoIndicator: entry.mediaType == MediaType.video,
                      media:
                          entry.mediaType == MediaType.video &&
                              entry.thumbnailRelativePath != null
                          ? CardVideoPlayer(
                              videoPath: entry.imageRelativePath!,
                              thumbnailPath: entry.thumbnailRelativePath!,
                              autoplay: true,
                            )
                          : StoredMediaImage(
                              path: entry.imageRelativePath!,
                              fit: BoxFit.cover,
                            ),
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
                      onPressed: () {
                        HapticFeedback.selectionClick();
                        ref
                            .read(toggleFavoriteCardProvider)
                            .call(
                              installedCollectionId: installedCollectionId,
                              cardId: entry.cardId,
                            );
                      },
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
                Text('${l10n.copies}: ${entry.quantity}'),
                if (entry.sellableCopies > 0) ...[
                  const SizedBox(height: AppConstants.spacingMd),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.toll_outlined),
                      title: Text(l10n.sellDuplicates),
                      subtitle: Text(
                        '${l10n.sellableCopies(entry.sellableCopies)}\n'
                        '${l10n.unitSellValue(entry.sellValue ?? 0)}',
                      ),
                      trailing: FilledButton.icon(
                        onPressed: () => _showSellDialog(
                          context: context,
                          ref: ref,
                          entry: entry,
                        ),
                        icon: const Icon(Icons.sell_outlined),
                        label: Text(l10n.sellDuplicates),
                      ),
                    ),
                  ),
                ],
                if (entry.firstObtainedAtUtc != null)
                  Text(
                    l10n.firstObtained(
                      MaterialLocalizations.of(
                        context,
                      ).formatShortDate(entry.firstObtainedAtUtc!.toLocal()),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _showSellDialog({
    required BuildContext context,
    required WidgetRef ref,
    required AlbumCardEntry entry,
  }) async {
    final l10n = context.l10n;
    final sellValue = entry.sellValue ?? 0;
    var quantity = 1;
    final confirmedQuantity = await showDialog<int>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final income = quantity * sellValue;
            return AlertDialog(
              title: Text(l10n.confirmSale),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${l10n.copies}: ${entry.quantity}'),
                  Text(l10n.sellableCopies(entry.sellableCopies)),
                  Text(l10n.unitSellValue(sellValue)),
                  const SizedBox(height: AppConstants.spacingMd),
                  Text(l10n.quantityToSell),
                  Row(
                    children: [
                      IconButton(
                        onPressed: quantity <= 1
                            ? null
                            : () => setDialogState(() => quantity -= 1),
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            quantity.toString(),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: quantity >= entry.sellableCopies
                            ? null
                            : () => setDialogState(() => quantity += 1),
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                  Text(l10n.saleIncomePreview(quantity, sellValue, income)),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(l10n.cancel),
                ),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(quantity),
                  child: Text(l10n.confirmSale),
                ),
              ],
            );
          },
        );
      },
    );
    if (confirmedQuantity == null) {
      return;
    }

    try {
      await ref
          .read(sellDuplicateCardsProvider)
          .call(
            installedCollectionId: installedCollectionId,
            cardId: entry.cardId,
            quantityToSell: confirmedQuantity,
          );
      ref.invalidate(
        albumCardProvider((id: installedCollectionId, cardId: cardId)),
      );
      ref.invalidate(albumStatsProvider(installedCollectionId));
      ref.invalidate(installedCollectionProvider(installedCollectionId));
      ref.invalidate(installedCollectionsProvider);
      if (context.mounted) {
        HapticFeedback.lightImpact();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.saleCompleted)));
      }
    } on AppFailure catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.safeMessage)));
      }
    } on Object {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.saveError)));
      }
    }
  }
}
