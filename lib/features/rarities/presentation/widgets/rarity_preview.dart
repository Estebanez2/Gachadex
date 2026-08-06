import 'package:flutter/material.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/catalogs/rarity_visual_catalog.dart';
import '../../domain/entities/rarity.dart';

class RarityPreview extends StatelessWidget {
  const RarityPreview({super.key, required this.rarity, this.compact = false});

  final Rarity rarity;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colorOption = RarityVisualCatalog.colorByValue(rarity.colorValue);
    final baseColor = Color(rarity.colorValue);
    final textColor = colorOption.prefersDarkText ? Colors.black : Colors.white;
    final radius = rarity.frameId == 'rarity_frame_rounded' ? 8.0 : 3.0;
    final borderWidth = switch (rarity.frameId) {
      'rarity_frame_double' => 3.0,
      'rarity_frame_neon' => 2.5,
      'rarity_frame_pixel' => 2.0,
      _ => 1.5,
    };
    final borderColor = switch (rarity.frameId) {
      'rarity_frame_metallic' => Colors.white.withValues(alpha: 0.82),
      'rarity_frame_neon' => Colors.cyanAccent,
      'rarity_frame_comic' => Colors.black,
      'rarity_frame_elegant' => Colors.white70,
      _ => textColor.withValues(alpha: 0.78),
    };

    return Semantics(
      label: rarity.name,
      child: Container(
        constraints: compact
            ? const BoxConstraints(minHeight: 68)
            : const BoxConstraints(minHeight: 112),
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: borderColor, width: borderWidth),
          boxShadow: _effectShadow(rarity.effectId, baseColor),
        ),
        child: Stack(
          children: [
            if (rarity.effectId == 'rarity_effect_gradient' ||
                rarity.effectId == 'rarity_effect_holo')
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withValues(alpha: 0.22),
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.18),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(AppConstants.spacingMd),
              child: Row(
                children: [
                  Icon(_rarityIcon(rarity.iconId), color: textColor, size: 32),
                  const SizedBox(width: AppConstants.spacingMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          rarity.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: textColor,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${context.l10n.sellValue}: ${rarity.sellValue}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: textColor),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '#${rarity.orderIndex + 1}',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

IconData rarityIconForId(String id) {
  return _rarityIcon(id);
}

IconData _rarityIcon(String id) {
  return switch (id) {
    'rarity_icon_crown' => Icons.workspace_premium_outlined,
    'rarity_icon_diamond' => Icons.diamond_outlined,
    'rarity_icon_fire' => Icons.local_fire_department_outlined,
    'rarity_icon_bolt' => Icons.bolt_outlined,
    'rarity_icon_rocket' => Icons.rocket_launch_outlined,
    'rarity_icon_glasses' => Icons.visibility_outlined,
    'rarity_icon_trophy' => Icons.emoji_events_outlined,
    'rarity_icon_ghost' => Icons.nightlight_round_outlined,
    'rarity_icon_footprint' => Icons.directions_walk_outlined,
    'rarity_icon_smile' => Icons.sentiment_satisfied_alt_outlined,
    'rarity_icon_burst' => Icons.flare_outlined,
    'rarity_icon_heart' => Icons.favorite_border_outlined,
    'rarity_icon_moon' => Icons.dark_mode_outlined,
    'rarity_icon_sun' => Icons.wb_sunny_outlined,
    _ => Icons.star_outline,
  };
}

List<BoxShadow> _effectShadow(String? effectId, Color baseColor) {
  return switch (effectId) {
    'rarity_effect_soft_glow' => [
      BoxShadow(
        color: baseColor.withValues(alpha: 0.34),
        blurRadius: 10,
        spreadRadius: 1,
      ),
    ],
    'rarity_effect_spark' => [
      BoxShadow(
        color: Colors.white.withValues(alpha: 0.42),
        blurRadius: 8,
        spreadRadius: 0,
      ),
    ],
    'rarity_effect_pulse' => [
      BoxShadow(
        color: baseColor.withValues(alpha: 0.45),
        blurRadius: 14,
        spreadRadius: 2,
      ),
    ],
    _ => const [],
  };
}
