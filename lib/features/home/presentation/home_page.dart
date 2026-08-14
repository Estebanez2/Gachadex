import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/localization/app_localizations.dart';
import '../../../app/router/app_routes.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/animated_appear.dart';
import '../../../core/widgets/app_empty_view.dart';
import '../../../core/widgets/app_error_view.dart';
import '../../../core/widgets/app_loading_view.dart';
import '../../import_export/presentation/import_collection_flow.dart';
import '../../packs/domain/catalogs/pack_visual_catalog.dart';
import '../../packs/domain/value_objects/pack_visual_style.dart';
import '../application/home_providers.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool _importing = false;
  late DateTime _nowUtc;
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _nowUtc = DateTime.now().toUtc();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() => _nowUtc = DateTime.now().toUtc());
      }
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final packsAsync = ref.watch(homeAvailablePacksProvider);

    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF060818), Color(0xFF090B16), Color(0xFF05070F)],
        ),
      ),
      child: packsAsync.when(
        loading: () => const AppLoadingView(),
        error: (_, _) => AppErrorView(
          title: l10n.screenErrorTitle,
          description: l10n.saveError,
        ),
        data: (packs) {
          final total = packs.fold<int>(
            0,
            (sum, pack) => sum + pack.availableCount,
          );
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(homeAvailablePacksProvider),
            child: ListView(
              padding: AppConstants.pagePadding.copyWith(
                top: AppConstants.spacingLg,
                bottom: AppConstants.spacingXl,
              ),
              children: [
                AnimatedAppear(child: _HomeHeader(totalAvailable: total)),
                const SizedBox(height: AppConstants.spacingMd),
                AnimatedAppear(
                  delay: const Duration(milliseconds: 50),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: OutlinedButton.icon(
                      onPressed: _importing ? null : _importCollection,
                      icon: _importing
                          ? const SizedBox.square(
                              dimension: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.file_download_outlined),
                      label: Text(l10n.importCollection),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFFD9B8FF),
                        side: const BorderSide(color: Color(0xFF8D55F7)),
                        backgroundColor: const Color(
                          0xFF6D35D8,
                        ).withValues(alpha: 0.16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppConstants.spacingLg),
                _HomeSectionTitle(title: l10n.availablePacksTitle),
                const SizedBox(height: AppConstants.spacingMd),
                if (packs.isEmpty)
                  AnimatedAppear(
                    delay: const Duration(milliseconds: 80),
                    child: AppEmptyView(
                      icon: Icons.inventory_2_outlined,
                      title: l10n.noAvailablePacks,
                      description: l10n.homeEmptyDescription,
                    ),
                  )
                else
                  _PackGrid(packs: packs, nowUtc: _nowUtc),
              ],
            ),
          );
        },
      ),
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
        ref.invalidate(homeAvailablePacksProvider);
      }
    } finally {
      if (mounted) {
        setState(() => _importing = false);
      }
    }
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({required this.totalAvailable});

  final int totalAvailable;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      children: [
        Transform.rotate(
          angle: -0.16,
          child: SizedBox(
            width: 34,
            height: 46,
            child: _PackFrontImage(
              style: PackVisualCatalog.defaultFrontStyle,
              collectionName: 'G',
              compactLogo: true,
            ),
          ),
        ),
        const SizedBox(width: AppConstants.spacingSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      l10n.appTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacingXs),
                  const Icon(
                    Icons.auto_awesome,
                    color: Color(0xFFB58CFF),
                    size: 18,
                  ),
                ],
              ),
              Text(
                totalAvailable == 0
                    ? l10n.homeEmptyDescription
                    : l10n.homeAvailablePacksCount(totalAvailable),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFFB7B9D6),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        IconButton.filledTonal(
          tooltip: l10n.settings,
          onPressed: () => context.go(AppRoutes.settingsPath),
          icon: const Icon(Icons.settings_outlined),
          style: IconButton.styleFrom(
            foregroundColor: const Color(0xFFE7DDFF),
            backgroundColor: Colors.white.withValues(alpha: 0.08),
          ),
        ),
      ],
    );
  }
}

class _HomeSectionTitle extends StatelessWidget {
  const _HomeSectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.inventory_2_outlined,
          color: Color(0xFFB58CFF),
          size: 20,
        ),
        const SizedBox(width: AppConstants.spacingXs),
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}

class _PackGrid extends StatelessWidget {
  const _PackGrid({required this.packs, required this.nowUtc});

  final List<HomeAvailablePack> packs;
  final DateTime nowUtc;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final crossAxisCount = width < 330
            ? 3
            : width < 620
            ? 4
            : 6;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: packs.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: AppConstants.spacingSm,
            crossAxisSpacing: AppConstants.spacingSm,
            childAspectRatio: 0.49,
          ),
          itemBuilder: (context, index) {
            return AnimatedAppear(
              delay: Duration(milliseconds: index.clamp(0, 8) * 35),
              child: _AvailablePackTile(pack: packs[index], nowUtc: nowUtc),
            );
          },
        );
      },
    );
  }
}

class _AvailablePackTile extends StatelessWidget {
  const _AvailablePackTile({required this.pack, required this.nowUtc});

  final HomeAvailablePack pack;
  final DateTime nowUtc;

  @override
  Widget build(BuildContext context) {
    final canRecharge = pack.availableCount < pack.maxAccumulated;
    final remaining = pack.nextRechargeAtUtc.difference(nowUtc);
    final accent = Color(
      PackVisualCatalog.colorValueForId(pack.visualStyle.accentColorId),
    );
    final borderColor = pack.availableCount > 0
        ? accent.withValues(alpha: 0.42)
        : const Color(0xFFFF4D6D).withValues(alpha: 0.32);

    return Material(
      color: const Color(0xFF0D1020),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        side: BorderSide(color: borderColor),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.go(
          AppRoutes.installedCollectionPath(pack.installedCollectionId.value),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spacingXs),
          child: Column(
            children: [
              SizedBox(
                height: 18,
                child: Center(
                  child: Text(
                    pack.packName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppConstants.spacingXs),
              Expanded(
                child: Center(
                  child: _PackFrontImage(
                    style: pack.visualStyle,
                    collectionName: pack.collectionName,
                  ),
                ),
              ),
              const SizedBox(height: AppConstants.spacingXs),
              _PackCountBadge(
                available: pack.availableCount,
                max: pack.maxAccumulated,
                accent: accent,
              ),
              if (canRecharge) ...[
                const SizedBox(height: 2),
                Text(
                  _formatRemaining(remaining),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: const Color(0xFFB7B9D6),
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                  ),
                ),
              ],
            ],
          ),
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

class _PackFrontImage extends StatelessWidget {
  const _PackFrontImage({
    required this.style,
    required this.collectionName,
    this.compactLogo = false,
  });

  final PackVisualStyle style;
  final String collectionName;
  final bool compactLogo;

  @override
  Widget build(BuildContext context) {
    final color = Color(PackVisualCatalog.colorValueForId(style.colorId));
    final accent = Color(
      PackVisualCatalog.colorValueForId(style.accentColorId),
    );

    return AspectRatio(
      aspectRatio: 0.607,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: 0.35),
              blurRadius: 14,
              spreadRadius: 1,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/card_templates/pack_front.png',
                fit: BoxFit.cover,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      color.withValues(alpha: 0.46),
                      Colors.transparent,
                      accent.withValues(alpha: 0.34),
                    ],
                  ),
                  backgroundBlendMode: BlendMode.overlay,
                ),
              ),
              CustomPaint(
                painter: _PackSheenPainter(
                  color: accent.withValues(alpha: 0.18),
                ),
              ),
              Positioned(
                left: 9,
                right: 9,
                bottom: 18,
                child: Text(
                  compactLogo ? 'G' : collectionName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: compactLogo ? 9 : 8,
                    shadows: const [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 4,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PackCountBadge extends StatelessWidget {
  const _PackCountBadge({
    required this.available,
    required this.max,
    required this.accent,
  });

  final int available;
  final int max;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final empty = available <= 0;
    final color = empty ? const Color(0xFFFF5C75) : accent;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.32)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
        child: Text(
          '$available / $max',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: color,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

class _PackSheenPainter extends CustomPainter {
  const _PackSheenPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.03;
    final path = Path()
      ..moveTo(size.width * 0.18, size.height * 0.74)
      ..cubicTo(
        size.width * 0.42,
        size.height * 0.52,
        size.width * 0.58,
        size.height * 0.94,
        size.width * 0.82,
        size.height * 0.70,
      );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _PackSheenPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
