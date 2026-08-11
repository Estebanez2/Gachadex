import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/domain/domain_enums.dart';
import '../../../../core/files/card_video_player.dart';
import '../../../../core/files/stored_media_image.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../../../../core/widgets/animated_appear.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_loading_view.dart';
import '../../../rarities/presentation/widgets/rarity_effect_layer.dart';
import '../../application/pack_providers.dart';
import '../../domain/entities/pack_opening_details.dart';

class PackOpeningPage extends ConsumerStatefulWidget {
  const PackOpeningPage({
    super.key,
    required this.installedCollectionId,
    required this.openingId,
  });

  final InstalledCollectionId installedCollectionId;
  final PackOpeningId openingId;

  @override
  ConsumerState<PackOpeningPage> createState() => _PackOpeningPageState();
}

class _PackOpeningPageState extends ConsumerState<PackOpeningPage> {
  int _index = 0;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(startRevealingPackOpeningProvider).call(widget.openingId);
      final details = await ref.read(
        packOpeningDetailsProvider(widget.openingId).future,
      );
      if (mounted) {
        final firstHidden = details.cards.indexWhere(
          (card) => !card.result.revealed,
        );
        setState(
          () => _index = firstHidden < 0 ? details.cards.length : firstHidden,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final detailsAsync = ref.watch(
      packOpeningDetailsProvider(widget.openingId),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.openPack),
        actions: [
          TextButton(onPressed: _busy ? null : _skip, child: Text(l10n.skip)),
        ],
      ),
      body: SafeArea(
        child: detailsAsync.when(
          loading: () => const AppLoadingView(),
          error: (_, _) => AppErrorView(
            title: l10n.screenErrorTitle,
            description: l10n.saveError,
          ),
          data: (details) {
            final completed =
                _index >= details.cards.length ||
                details.cards.every((card) => card.result.revealed);
            if (completed) {
              return _OpeningSummary(
                details: details,
                installedCollectionId: widget.installedCollectionId,
                onViewAlbum: _viewAlbum,
                onBackToPacks: _backToPacks,
              );
            }
            return _OpeningCardReveal(
              details: details.cards[_index],
              position: _index + 1,
              total: details.cards.length,
              busy: _busy,
              onRevealOrNext: () => _revealOrNext(details),
            );
          },
        ),
      ),
    );
  }

  Future<void> _revealOrNext(PackOpeningDetails details) async {
    final current = details.cards[_index];
    if (current.result.revealed) {
      unawaited(HapticFeedback.selectionClick());
      setState(() => _index += 1);
      return;
    }

    setState(() => _busy = true);
    await ref
        .read(revealOpeningCardProvider)
        .call(openingId: widget.openingId, slotIndex: current.result.slotIndex);
    ref.invalidate(packOpeningDetailsProvider(widget.openingId));
    unawaited(HapticFeedback.lightImpact());
    if (mounted) {
      setState(() => _busy = false);
    }
  }

  Future<void> _skip() async {
    setState(() => _busy = true);
    unawaited(HapticFeedback.mediumImpact());
    await ref.read(completePackOpeningProvider).call(widget.openingId);
    ref.invalidate(packOpeningDetailsProvider(widget.openingId));
    if (mounted) {
      setState(() => _busy = false);
    }
  }

  Future<void> _markCompleted() async {
    await ref.read(completePackOpeningProvider).call(widget.openingId);
  }

  Future<void> _viewAlbum() async {
    await _markCompleted();
    unawaited(HapticFeedback.selectionClick());
    if (mounted) {
      context.go(
        AppRoutes.installedCollectionAlbumPath(
          widget.installedCollectionId.value,
        ),
      );
    }
  }

  Future<void> _backToPacks() async {
    await _markCompleted();
    unawaited(HapticFeedback.selectionClick());
    if (mounted) {
      context.go(
        AppRoutes.installedCollectionPath(widget.installedCollectionId.value),
      );
    }
  }
}

class _OpeningCardReveal extends StatelessWidget {
  const _OpeningCardReveal({
    required this.details,
    required this.position,
    required this.total,
    required this.busy,
    required this.onRevealOrNext,
  });

  final PackOpeningCardDetails details;
  final int position;
  final int total;
  final bool busy;
  final VoidCallback onRevealOrNext;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final revealed = details.result.revealed;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final cardRadius = BorderRadius.circular(AppConstants.cardRadius);
    final rarityColor = Color(details.card.rarity.colorValue);

    return ListView(
      padding: AppConstants.pagePadding,
      children: [
        AnimatedAppear(
          child: Text(
            l10n.cardPosition(position, total),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: AppConstants.spacingMd),
        AnimatedScale(
          scale: revealed || reduceMotion ? 1 : 0.94,
          duration: reduceMotion
              ? Duration.zero
              : AppConstants.mediumAnimationDuration,
          child: AnimatedSwitcher(
            duration: reduceMotion
                ? Duration.zero
                : AppConstants.mediumAnimationDuration,
            switchInCurve: Curves.easeOutCubic,
            child: AspectRatio(
              key: ValueKey(revealed),
              aspectRatio: 0.72,
              child: RarityEffectFrame(
                effectId: revealed ? details.card.rarity.effectId : null,
                baseColor: rarityColor,
                borderRadius: cardRadius,
                animate: revealed,
                child: ClipRRect(
                  borderRadius: cardRadius,
                  child: revealed
                      ? _RevealedOpeningMedia(details: details)
                      : DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).colorScheme.primaryContainer,
                                Theme.of(
                                  context,
                                ).colorScheme.secondaryContainer,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.style_outlined,
                              size: 72,
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppConstants.spacingMd),
        if (revealed) ...[
          AnimatedAppear(
            child: Text(
              details.card.card.name,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(height: AppConstants.spacingSm),
          AnimatedAppear(
            delay: const Duration(milliseconds: 70),
            child: Center(
              child: Chip(
                avatar: Icon(
                  details.result.wasNew
                      ? Icons.auto_awesome_outlined
                      : Icons.repeat_outlined,
                ),
                label: Text(
                  details.result.wasNew
                      ? l10n.newCard
                      : l10n.repeatedCard(details.result.quantityAfter),
                ),
              ),
            ),
          ),
        ],
        const SizedBox(height: AppConstants.spacingLg),
        AnimatedAppear(
          delay: const Duration(milliseconds: 100),
          child: FilledButton.icon(
            onPressed: busy ? null : onRevealOrNext,
            icon: Icon(
              revealed ? Icons.navigate_next : Icons.visibility_outlined,
            ),
            label: Text(revealed ? l10n.next : l10n.revealCard),
          ),
        ),
      ],
    );
  }
}

class _RevealedOpeningMedia extends StatelessWidget {
  const _RevealedOpeningMedia({required this.details});

  final PackOpeningCardDetails details;

  @override
  Widget build(BuildContext context) {
    if (details.card.card.mediaType == MediaType.video &&
        details.card.thumbnailAsset != null) {
      return CardVideoPlayer(
        videoPath: details.card.mediaAsset.relativePath,
        thumbnailPath: details.card.thumbnailAsset!.relativePath,
        autoplay: true,
      );
    }
    return StoredMediaImage(path: details.card.mediaAsset.relativePath);
  }
}

class _OpeningSummary extends StatelessWidget {
  const _OpeningSummary({
    required this.details,
    required this.installedCollectionId,
    required this.onViewAlbum,
    required this.onBackToPacks,
  });

  final PackOpeningDetails details;
  final InstalledCollectionId installedCollectionId;
  final Future<void> Function() onViewAlbum;
  final Future<void> Function() onBackToPacks;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final newCount = details.cards.where((card) => card.result.wasNew).length;
    final repeatedCount = details.cards.length - newCount;

    return ListView(
      padding: AppConstants.pagePadding,
      children: [
        AnimatedAppear(
          child: Text(
            l10n.summary,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
        ),
        const SizedBox(height: AppConstants.spacingSm),
        Text(l10n.openingSummaryCounts(newCount, repeatedCount)),
        const SizedBox(height: AppConstants.spacingMd),
        for (var index = 0; index < details.cards.length; index++)
          AnimatedAppear(
            delay: Duration(milliseconds: index.clamp(0, 4) * 40),
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppConstants.spacingSm),
              child: Card(
                child: ListTile(
                  leading: SizedBox.square(
                    dimension: 48,
                    child: StoredMediaImage(
                      path:
                          details
                              .cards[index]
                              .card
                              .thumbnailAsset
                              ?.relativePath ??
                          details.cards[index].card.mediaAsset.relativePath,
                    ),
                  ),
                  title: Text(details.cards[index].card.card.name),
                  subtitle: Text(
                    details.cards[index].result.wasNew
                        ? l10n.newCard
                        : l10n.repeatedCard(
                            details.cards[index].result.quantityAfter,
                          ),
                  ),
                ),
              ),
            ),
          ),
        const SizedBox(height: AppConstants.spacingMd),
        FilledButton.icon(
          onPressed: onViewAlbum,
          icon: const Icon(Icons.grid_view_outlined),
          label: Text(l10n.viewAlbum),
        ),
        const SizedBox(height: AppConstants.spacingSm),
        OutlinedButton.icon(
          onPressed: onBackToPacks,
          icon: const Icon(Icons.inventory_2_outlined),
          label: Text(l10n.backToPacks),
        ),
      ],
    );
  }
}
