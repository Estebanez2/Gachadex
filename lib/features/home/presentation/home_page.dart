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

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final packsAsync = ref.watch(homeAvailablePacksProvider);

    return packsAsync.when(
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
            padding: AppConstants.pagePadding,
            children: [
              AnimatedAppear(child: _HomeHeader(totalAvailable: total)),
              const SizedBox(height: AppConstants.spacingMd),
              AnimatedAppear(
                delay: const Duration(milliseconds: 50),
                child: Align(
                  alignment: Alignment.centerLeft,
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
                ),
              ),
              const SizedBox(height: AppConstants.spacingLg),
              Text(
                l10n.availablePacksTitle,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
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
                for (var index = 0; index < packs.length; index++) ...[
                  AnimatedAppear(
                    delay: Duration(milliseconds: index.clamp(0, 4) * 45),
                    child: _AvailablePackCard(pack: packs[index]),
                  ),
                  const SizedBox(height: AppConstants.spacingSm),
                ],
            ],
          ),
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
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              color: theme.colorScheme.onPrimaryContainer,
              size: 40,
            ),
            const SizedBox(height: AppConstants.spacingMd),
            Text(
              l10n.appTitle,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: AppConstants.spacingSm),
            Text(
              totalAvailable == 0
                  ? l10n.noAvailablePacks
                  : l10n.homeAvailablePacksCount(totalAvailable),
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AvailablePackCard extends StatelessWidget {
  const _AvailablePackCard({required this.pack});

  final HomeAvailablePack pack;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        onTap: () => context.go(
          AppRoutes.installedCollectionPath(pack.installedCollectionId.value),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spacingMd),
          child: Row(
            children: [
              _PackVisual(style: pack.visualStyle),
              const SizedBox(width: AppConstants.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            pack.packName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                        ),
                        if (pack.isMain)
                          Chip(
                            visualDensity: VisualDensity.compact,
                            label: Text(l10n.mainPack),
                          ),
                      ],
                    ),
                    const SizedBox(height: AppConstants.spacingXs),
                    Text(
                      pack.collectionName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppConstants.spacingSm),
                    Text(
                      l10n.homePackAvailableLine(
                        pack.availableCount,
                        pack.maxAccumulated,
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingSm),
                    Row(
                      children: [
                        Chip(
                          visualDensity: VisualDensity.compact,
                          avatar: const Icon(Icons.check_circle_outline),
                          label: Text(l10n.available),
                        ),
                        const Spacer(),
                        TextButton.icon(
                          onPressed: () => context.go(
                            AppRoutes.installedCollectionPath(
                              pack.installedCollectionId.value,
                            ),
                          ),
                          icon: const Icon(Icons.chevron_right),
                          label: Text(l10n.viewCollection),
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

class _PackVisual extends StatelessWidget {
  const _PackVisual({required this.style});

  final PackVisualStyle style;

  @override
  Widget build(BuildContext context) {
    final color = Color(PackVisualCatalog.colorValueForId(style.colorId));
    final accent = Color(
      PackVisualCatalog.colorValueForId(style.accentColorId),
    );
    return SizedBox(
      width: 74,
      height: 104,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: accent, width: 3),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _PackPatternPainter(
                  color: accent.withValues(alpha: 0.22),
                ),
              ),
            ),
            Center(
              child: Icon(
                PackVisualCatalog.iconForId(style.iconId),
                color: Colors.white,
                size: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PackPatternPainter extends CustomPainter {
  const _PackPatternPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2;
    for (var x = -size.height; x < size.width; x += 14) {
      canvas.drawLine(
        Offset(x, size.height),
        Offset(x + size.height, 0),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _PackPatternPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
