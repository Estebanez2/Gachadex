import 'dart:async';
import 'dart:math' as math;

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
import '../../../cards/presentation/widgets/gachadex_card.dart';
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
  bool _visualBusy = false;
  bool _introDone = true;
  bool _openingPrepared = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final details = await ref.read(
        packOpeningDetailsProvider(widget.openingId).future,
      );
      final firstHidden = details.cards.indexWhere(
        (card) => !card.result.revealed,
      );
      final anyRevealed = details.cards.any((card) => card.result.revealed);
      final shouldRunIntro =
          details.opening.status == PackOpeningStatus.generated &&
          firstHidden == 0 &&
          !anyRevealed &&
          details.cards.isNotEmpty;
      if (mounted) {
        setState(() {
          _index = firstHidden < 0 ? details.cards.length : firstHidden;
          _introDone = !shouldRunIntro;
          _openingPrepared = true;
        });
      }
      await ref.read(startRevealingPackOpeningProvider).call(widget.openingId);
      ref.invalidate(packOpeningDetailsProvider(widget.openingId));
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
          TextButton(
            onPressed: _busy || _visualBusy ? null : _skip,
            child: Text(l10n.skip),
          ),
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
            if (!_openingPrepared) {
              return const AppLoadingView();
            }
            final completed =
                details.opening.status == PackOpeningStatus.completed ||
                _index >= details.cards.length;
            if (completed) {
              return _OpeningSummary(
                details: details,
                installedCollectionId: widget.installedCollectionId,
                onViewAlbum: _viewAlbum,
                onBackToPacks: _backToPacks,
              );
            }
            final hasRevealed = details.cards.any(
              (card) => card.result.revealed,
            );
            if (!_introDone && _index == 0 && !hasRevealed) {
              return _PackOpeningIntro(
                cardCount: details.cards.length,
                onDone: () {
                  if (mounted) {
                    setState(() => _introDone = true);
                  }
                },
              );
            }
            return _OpeningCardReveal(
              details: details.cards[_index],
              position: _index + 1,
              total: details.cards.length,
              remaining: details.cards.length - _index,
              busy: _busy,
              onReveal: () => _revealCurrent(details),
              onNext: () => _advanceCurrent(details),
              onVisualBusyChanged: _setVisualBusy,
            );
          },
        ),
      ),
    );
  }

  void _setVisualBusy(bool value) {
    if (mounted && _visualBusy != value) {
      setState(() => _visualBusy = value);
    }
  }

  Future<void> _revealCurrent(PackOpeningDetails details) async {
    final current = details.cards[_index];
    if (current.result.revealed) {
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

  Future<void> _advanceCurrent(PackOpeningDetails details) async {
    unawaited(HapticFeedback.selectionClick());
    final nextIndex = _index + 1;
    setState(() {
      _index = nextIndex;
      _busy = nextIndex >= details.cards.length;
    });
    if (nextIndex >= details.cards.length) {
      await ref.read(completePackOpeningProvider).call(widget.openingId);
      ref.invalidate(packOpeningDetailsProvider(widget.openingId));
      if (mounted) {
        setState(() => _busy = false);
      }
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

class _OpeningCardReveal extends StatefulWidget {
  const _OpeningCardReveal({
    required this.details,
    required this.position,
    required this.total,
    required this.remaining,
    required this.busy,
    required this.onReveal,
    required this.onNext,
    required this.onVisualBusyChanged,
  });

  final PackOpeningCardDetails details;
  final int position;
  final int total;
  final int remaining;
  final bool busy;
  final Future<void> Function() onReveal;
  final Future<void> Function() onNext;
  final ValueChanged<bool> onVisualBusyChanged;

  @override
  State<_OpeningCardReveal> createState() => _OpeningCardRevealState();
}

enum _OpeningCardVisualState { faceDown, flipping, faceUp, leaving }

class _OpeningCardRevealState extends State<_OpeningCardReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _flipController;
  late _OpeningCardVisualState _visualState;

  @override
  void initState() {
    super.initState();
    final revealed = widget.details.result.revealed;
    _visualState = revealed
        ? _OpeningCardVisualState.faceUp
        : _OpeningCardVisualState.faceDown;
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 540),
      value: revealed ? 1 : 0,
    );
  }

  @override
  void didUpdateWidget(covariant _OpeningCardReveal oldWidget) {
    super.didUpdateWidget(oldWidget);
    final changedCard =
        oldWidget.details.result.slotIndex != widget.details.result.slotIndex;
    if (changedCard) {
      final revealed = widget.details.result.revealed;
      _flipController.value = revealed ? 1 : 0;
      _visualState = revealed
          ? _OpeningCardVisualState.faceUp
          : _OpeningCardVisualState.faceDown;
      return;
    }
    if (widget.details.result.revealed &&
        _visualState == _OpeningCardVisualState.faceDown) {
      _flipController.value = 1;
      _visualState = _OpeningCardVisualState.faceUp;
    }
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final faceUp = _visualState == _OpeningCardVisualState.faceUp;
    final interactionLocked =
        widget.busy ||
        _visualState == _OpeningCardVisualState.flipping ||
        _visualState == _OpeningCardVisualState.leaving;

    return ListView(
      padding: AppConstants.pagePadding,
      children: [
        AnimatedAppear(
          child: Text(
            l10n.cardPosition(widget.position, widget.total),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: AppConstants.spacingMd),
        AnimatedBuilder(
          animation: _flipController,
          builder: (context, child) => _OpeningCardPile(
            details: widget.details,
            remaining: widget.remaining,
            visualState: _visualState,
            flipProgress: _flipController.value,
            onTap: interactionLocked ? null : _handleTap,
          ),
        ),
        const SizedBox(height: AppConstants.spacingMd),
        if (faceUp) ...[
          AnimatedAppear(
            delay: const Duration(milliseconds: 70),
            child: Center(
              child: Chip(
                avatar: Icon(
                  widget.details.result.wasNew
                      ? Icons.auto_awesome_outlined
                      : Icons.repeat_outlined,
                ),
                label: Text(
                  widget.details.result.wasNew
                      ? l10n.newCard
                      : l10n.repeatedCard(widget.details.result.quantityAfter),
                ),
              ),
            ),
          ),
        ],
        const SizedBox(height: AppConstants.spacingLg),
        AnimatedAppear(
          delay: const Duration(milliseconds: 100),
          child: FilledButton.icon(
            onPressed: interactionLocked ? null : _handleTap,
            icon: Icon(
              faceUp ? Icons.navigate_next : Icons.visibility_outlined,
            ),
            label: Text(faceUp ? l10n.next : l10n.revealCard),
          ),
        ),
      ],
    );
  }

  Future<void> _handleTap() async {
    if (_visualState == _OpeningCardVisualState.faceDown) {
      await _revealWithFlip();
    } else if (_visualState == _OpeningCardVisualState.faceUp) {
      await _leaveCurrentCard();
    }
  }

  Future<void> _revealWithFlip() async {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    widget.onVisualBusyChanged(true);
    setState(() => _visualState = _OpeningCardVisualState.flipping);
    try {
      if (reduceMotion) {
        _flipController.value = 1;
      } else {
        await _flipController.forward(from: 0);
      }
      if (!mounted) {
        return;
      }
      await widget.onReveal();
      if (!mounted) {
        return;
      }
      setState(() => _visualState = _OpeningCardVisualState.faceUp);
    } finally {
      widget.onVisualBusyChanged(false);
    }
  }

  Future<void> _leaveCurrentCard() async {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    widget.onVisualBusyChanged(true);
    setState(() => _visualState = _OpeningCardVisualState.leaving);
    await Future<void>.delayed(
      reduceMotion ? Duration.zero : const Duration(milliseconds: 320),
    );
    if (!mounted) {
      return;
    }
    widget.onVisualBusyChanged(false);
    await widget.onNext();
  }
}

class _PackOpeningIntro extends StatefulWidget {
  const _PackOpeningIntro({required this.cardCount, required this.onDone});

  final int cardCount;
  final VoidCallback onDone;

  @override
  State<_PackOpeningIntro> createState() => _PackOpeningIntroState();
}

abstract final class _PackAnimationAssets {
  static const front = 'assets/card_templates/pack_front.png';
  static const back = 'assets/card_templates/pack_back.png';
  static const bodyBack = 'assets/card_templates/pack_body_back.png';
  static const flap = 'assets/card_templates/pack_flap.png';
  static const innerFoil = 'assets/card_templates/pack_inner_foil.png';
}

final class _PackAnimationLayout {
  const _PackAnimationLayout({required this.packAspectRatio});

  static const current = _PackAnimationLayout(packAspectRatio: 2 / 3);

  final double packAspectRatio;
}

class _PackOpeningIntroState extends State<_PackOpeningIntro>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    final reduceMotion = WidgetsBinding
        .instance
        .platformDispatcher
        .accessibilityFeatures
        .disableAnimations;
    if (reduceMotion) {
      WidgetsBinding.instance.addPostFrameCallback((_) => widget.onDone());
      return;
    }
    _controller =
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 2850),
        )..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            widget.onDone();
          }
        });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    if (!WidgetsBinding
        .instance
        .platformDispatcher
        .accessibilityFeatures
        .disableAnimations) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    if (WidgetsBinding
        .instance
        .platformDispatcher
        .accessibilityFeatures
        .disableAnimations) {
      return const SizedBox.shrink();
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value;
        return Center(
          child: Padding(
            padding: AppConstants.pagePadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 350,
                  height: 450,
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      _EmergingCards(
                        progress: _interval(t, 0.52, 0.74),
                        visibleProgress: _interval(t, 0.44, 0.58),
                        cardCount: widget.cardCount,
                      ),
                      IgnorePointer(child: _AnimatedPack(progress: t)),
                    ],
                  ),
                ),
                const SizedBox(height: AppConstants.spacingMd),
                Text(
                  l10n.openPack,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  double _interval(double value, double begin, double end) {
    if (value <= begin) {
      return 0;
    }
    if (value >= end) {
      return 1;
    }
    return Curves.easeOutCubic.transform((value - begin) / (end - begin));
  }
}

class _AnimatedPack extends StatelessWidget {
  const _AnimatedPack({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    final flipProgress = _interval(progress, 0.08, 0.30);
    final openProgress = _interval(progress, 0.36, 0.58);
    final retireProgress = _interval(progress, 0.72, 0.88);
    final showingClosed = progress < 0.34;
    final yOffset = retireProgress * 115;
    final opacity = 1 - retireProgress;

    return Opacity(
      opacity: opacity.clamp(0, 1).toDouble(),
      child: Transform.translate(
        offset: Offset(0, yOffset),
        child: SizedBox(
          width: 230,
          child: AspectRatio(
            aspectRatio: _PackAnimationLayout.current.packAspectRatio,
            child: showingClosed
                ? _Pack3DFlip(progress: flipProgress)
                : _OpenPackBack(openProgress: openProgress),
          ),
        ),
      ),
    );
  }

  double _interval(double value, double begin, double end) {
    if (value <= begin) {
      return 0;
    }
    if (value >= end) {
      return 1;
    }
    return Curves.easeInOutCubic.transform((value - begin) / (end - begin));
  }
}

class _Pack3DFlip extends StatelessWidget {
  const _Pack3DFlip({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    final angle = progress * math.pi;
    final showBack = angle > math.pi / 2;
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.0018)
        ..rotateY(angle),
      child: Transform(
        alignment: Alignment.center,
        transform: showBack
            ? (Matrix4.identity()..rotateY(math.pi))
            : Matrix4.identity(),
        child: Image.asset(
          showBack ? _PackAnimationAssets.back : _PackAnimationAssets.front,
          key: ValueKey(showBack ? 'pack_back_asset' : 'pack_front_asset'),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class _OpenPackBack extends StatelessWidget {
  const _OpenPackBack({required this.openProgress});

  final double openProgress;

  @override
  Widget build(BuildContext context) {
    final flapAngle = -openProgress * 1.28;
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        Opacity(
          opacity: openProgress.clamp(0, 1).toDouble(),
          child: Image.asset(_PackAnimationAssets.innerFoil, fit: BoxFit.cover),
        ),
        Image.asset(_PackAnimationAssets.bodyBack, fit: BoxFit.cover),
        Align(
          alignment: Alignment.topCenter,
          child: FractionallySizedBox(
            heightFactor: 0.42,
            alignment: Alignment.topCenter,
            child: Transform(
              alignment: Alignment.topCenter,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.0018)
                ..rotateX(flapAngle),
              child: Image.asset(_PackAnimationAssets.flap, fit: BoxFit.cover),
            ),
          ),
        ),
      ],
    );
  }
}

class _EmergingCards extends StatelessWidget {
  const _EmergingCards({
    required this.progress,
    required this.visibleProgress,
    required this.cardCount,
  });

  final double progress;
  final double visibleProgress;
  final int cardCount;

  @override
  Widget build(BuildContext context) {
    final visibleCards = cardCount.clamp(1, 5).toInt();
    return Opacity(
      opacity: visibleProgress.clamp(0, 1).toDouble(),
      child: Transform.translate(
        offset: Offset(0, 150 - progress * 150),
        child: SizedBox(
          width: 300,
          height: 450,
          child: Stack(
            alignment: Alignment.center,
            children: [
              for (var i = visibleCards - 1; i >= 0; i--)
                Transform.translate(
                  offset: Offset(i * 8.0, i * 6.0),
                  child: Transform.rotate(
                    angle: (i - visibleCards / 2) * 0.035,
                    child: const GachadexCardBack(elevation: false),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OpeningCardPile extends StatelessWidget {
  const _OpeningCardPile({
    required this.details,
    required this.remaining,
    required this.visualState,
    required this.flipProgress,
    required this.onTap,
  });

  final PackOpeningCardDetails details;
  final int remaining;
  final _OpeningCardVisualState visualState;
  final double flipProgress;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final behind = (remaining - 1).clamp(0, 5).toInt();
    final leaving = visualState == _OpeningCardVisualState.leaving;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 350),
        child: AspectRatio(
          aspectRatio: 0.78,
          child: Stack(
            alignment: Alignment.center,
            children: [
              for (var i = behind; i >= 1; i--)
                Transform.translate(
                  offset: Offset(i * 8, i * 6),
                  child: Transform.rotate(
                    angle: i.isEven ? 0.035 : -0.035,
                    child: SizedBox(
                      width: 292,
                      child: Opacity(
                        opacity: 0.52 + (i * 0.06).clamp(0, 0.28).toDouble(),
                        child: const GachadexCardBack(elevation: true),
                      ),
                    ),
                  ),
                ),
              GestureDetector(
                onTap: onTap,
                child: AnimatedSlide(
                  offset: leaving && !reduceMotion
                      ? const Offset(0.95, -0.22)
                      : Offset.zero,
                  duration: reduceMotion
                      ? Duration.zero
                      : const Duration(milliseconds: 320),
                  curve: Curves.easeInCubic,
                  child: AnimatedOpacity(
                    opacity: leaving && !reduceMotion ? 0 : 1,
                    duration: reduceMotion
                        ? Duration.zero
                        : const Duration(milliseconds: 320),
                    child: Transform.rotate(
                      angle: leaving && !reduceMotion ? 0.20 : 0,
                      child: SizedBox(
                        width: 300,
                        child: _topCard(reduceMotion),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 12,
                bottom: 12,
                child: Chip(
                  visualDensity: VisualDensity.compact,
                  label: Text('$remaining'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topCard(bool reduceMotion) {
    if (reduceMotion) {
      return visualState == _OpeningCardVisualState.faceDown
          ? const GachadexCardBack()
          : _frontCard(autoplayVideo: true);
    }
    final angle = flipProgress * math.pi;
    final showFront = angle >= math.pi / 2;
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.0018)
        ..rotateY(angle),
      child: Transform(
        alignment: Alignment.center,
        transform: showFront
            ? (Matrix4.identity()..rotateY(math.pi))
            : Matrix4.identity(),
        child: showFront
            ? _frontCard(
                autoplayVideo: visualState == _OpeningCardVisualState.faceUp,
              )
            : const GachadexCardBack(),
      ),
    );
  }

  Widget _frontCard({required bool autoplayVideo}) {
    final isVideo = details.card.card.mediaType == MediaType.video;
    return GachadexCard(
      name: details.card.card.name,
      health: details.card.card.health,
      description: details.card.card.description ?? '',
      rarityName: details.card.rarity.name,
      rarityColorValue: details.card.rarity.colorValue,
      rarityEffectId: details.card.rarity.effectId,
      mediaType: details.card.card.mediaType,
      media: _OpeningCardMedia(details: details, autoplay: autoplayVideo),
      showVideoIndicator: isVideo && !autoplayVideo,
      animateEffect: visualState == _OpeningCardVisualState.faceUp,
    );
  }
}

class _OpeningCardMedia extends StatelessWidget {
  const _OpeningCardMedia({required this.details, required this.autoplay});

  final PackOpeningCardDetails details;
  final bool autoplay;

  @override
  Widget build(BuildContext context) {
    if (details.card.card.mediaType == MediaType.video &&
        details.card.thumbnailAsset != null) {
      if (!autoplay) {
        return StoredMediaImage(
          path: details.card.thumbnailAsset!.relativePath,
        );
      }
      return CardVideoPlayer(
        videoPath: details.card.mediaAsset.relativePath,
        thumbnailPath: details.card.thumbnailAsset!.relativePath,
        autoplay: true,
      );
    }
    return StoredMediaImage(
      path:
          details.card.thumbnailAsset?.relativePath ??
          details.card.mediaAsset.relativePath,
    );
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
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: details.cards.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 180,
            childAspectRatio: GachadexCardLayout.aspectRatio,
            mainAxisSpacing: AppConstants.spacingMd,
            crossAxisSpacing: AppConstants.spacingMd,
          ),
          itemBuilder: (context, index) {
            final card = details.cards[index];
            return AnimatedAppear(
              delay: Duration(milliseconds: index.clamp(0, 4) * 40),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: GachadexCard(
                      name: card.card.card.name,
                      health: card.card.card.health,
                      description: card.card.card.description ?? '',
                      rarityName: card.card.rarity.name,
                      rarityColorValue: card.card.rarity.colorValue,
                      rarityEffectId: card.card.rarity.effectId,
                      mediaType: card.card.card.mediaType,
                      compact: true,
                      media: StoredMediaImage(
                        path:
                            card.card.thumbnailAsset?.relativePath ??
                            card.card.mediaAsset.relativePath,
                      ),
                      showVideoIndicator:
                          card.card.card.mediaType == MediaType.video,
                    ),
                  ),
                  Positioned(
                    left: AppConstants.spacingXs,
                    top: AppConstants.spacingXs,
                    child: Chip(
                      visualDensity: VisualDensity.compact,
                      label: Text(
                        card.result.wasNew
                            ? l10n.newCard
                            : l10n.repeatedCard(card.result.quantityAfter),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
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
