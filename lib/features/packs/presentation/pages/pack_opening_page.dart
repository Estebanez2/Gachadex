import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/domain/domain_enums.dart';
import '../../../../core/files/card_video_player.dart';
import '../../../../core/files/stored_media_image.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_loading_view.dart';
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
      setState(() => _index += 1);
      return;
    }
    setState(() => _busy = true);
    await ref
        .read(revealOpeningCardProvider)
        .call(openingId: widget.openingId, slotIndex: current.result.slotIndex);
    ref.invalidate(packOpeningDetailsProvider(widget.openingId));
    if (mounted) {
      setState(() => _busy = false);
    }
  }

  Future<void> _skip() async {
    setState(() => _busy = true);
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

    return ListView(
      padding: AppConstants.pagePadding,
      children: [
        Text(
          l10n.cardPosition(position, total),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppConstants.spacingMd),
        AnimatedScale(
          scale: revealed || reduceMotion ? 1 : 0.94,
          duration: reduceMotion
              ? Duration.zero
              : AppConstants.mediumAnimationDuration,
          child: AspectRatio(
            aspectRatio: 0.72,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppConstants.cardRadius),
              child: revealed
                  ? _RevealedOpeningMedia(details: details)
                  : ColoredBox(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      child: const Center(
                        child: Icon(Icons.style_outlined, size: 72),
                      ),
                    ),
            ),
          ),
        ),
        const SizedBox(height: AppConstants.spacingMd),
        if (revealed) ...[
          Text(
            details.card.card.name,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: AppConstants.spacingSm),
          Center(
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
        ],
        const SizedBox(height: AppConstants.spacingLg),
        FilledButton.icon(
          onPressed: busy ? null : onRevealOrNext,
          icon: Icon(
            revealed ? Icons.navigate_next : Icons.visibility_outlined,
          ),
          label: Text(revealed ? l10n.next : l10n.revealCard),
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
        Text(
          l10n.summary,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: AppConstants.spacingSm),
        Text(l10n.openingSummaryCounts(newCount, repeatedCount)),
        const SizedBox(height: AppConstants.spacingMd),
        for (final card in details.cards)
          Card(
            child: ListTile(
              leading: SizedBox.square(
                dimension: 48,
                child: StoredMediaImage(
                  path:
                      card.card.thumbnailAsset?.relativePath ??
                      card.card.mediaAsset.relativePath,
                ),
              ),
              title: Text(card.card.card.name),
              subtitle: Text(
                card.result.wasNew
                    ? l10n.newCard
                    : l10n.repeatedCard(card.result.quantityAfter),
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
