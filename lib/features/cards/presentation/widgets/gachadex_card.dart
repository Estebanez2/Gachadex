import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/domain/domain_enums.dart';
import '../../../rarities/presentation/widgets/rarity_effect_layer.dart';

final class GachadexCardLayout {
  const GachadexCardLayout({
    required this.nameRect,
    required this.healthRect,
    required this.mediaRect,
    required this.descriptionRect,
    required this.rarityRect,
  });

  static const aspectRatio = 2 / 3;
  static const frontOverlayAsset =
      'assets/card_templates/card_front_overlay.png';
  static const backAsset = 'assets/card_templates/card_back.png';
  static const defaultLayout = GachadexCardLayout(
    nameRect: Rect.fromLTWH(0.055, 0.035, 0.54, 0.082),
    healthRect: Rect.fromLTWH(0.705, 0.052, 0.21, 0.065),
    mediaRect: Rect.fromLTWH(0.039, 0.119, 0.923, 0.661),
    descriptionRect: Rect.fromLTWH(0.075, 0.805, 0.575, 0.13),
    rarityRect: Rect.fromLTWH(0.685, 0.915, 0.235, 0.052),
  );

  final Rect nameRect;
  final Rect healthRect;
  final Rect mediaRect;
  final Rect descriptionRect;
  final Rect rarityRect;
}

class GachadexCardBack extends StatelessWidget {
  const GachadexCardBack({super.key, this.elevation = true});

  final bool elevation;

  @override
  Widget build(BuildContext context) {
    final card = AspectRatio(
      aspectRatio: GachadexCardLayout.aspectRatio,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        child: Image.asset(
          GachadexCardLayout.backAsset,
          key: const ValueKey('gachadex_card_back_asset'),
          fit: BoxFit.cover,
        ),
      ),
    );
    if (!elevation) {
      return card;
    }
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.20),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: card,
    );
  }
}

class GachadexCard extends StatelessWidget {
  const GachadexCard({
    super.key,
    required this.name,
    required this.health,
    required this.description,
    required this.rarityName,
    required this.media,
    this.mediaType = MediaType.image,
    this.rarityColorValue,
    this.rarityEffectId,
    this.layout = GachadexCardLayout.defaultLayout,
    this.animateEffect = false,
    this.compact = false,
    this.showVideoIndicator = true,
    this.placeholderIcon = Icons.photo_outlined,
  });

  final String name;
  final int? health;
  final String description;
  final String rarityName;
  final Widget? media;
  final MediaType mediaType;
  final int? rarityColorValue;
  final String? rarityEffectId;
  final GachadexCardLayout layout;
  final bool animateEffect;
  final bool compact;
  final bool showVideoIndicator;
  final IconData placeholderIcon;

  @override
  Widget build(BuildContext context) {
    final baseColor = Color(rarityColorValue ?? 0xFFF4B83B);
    return Semantics(
      label: name.trim().isEmpty ? 'Carta Gachadex' : 'Carta ${name.trim()}',
      child: AspectRatio(
        aspectRatio: GachadexCardLayout.aspectRatio,
        child: RarityEffectFrame(
          effectId: rarityEffectId,
          baseColor: baseColor,
          borderRadius: BorderRadius.circular(AppConstants.cardRadius),
          animate: animateEffect,
          clip: false,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppConstants.cardRadius),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final size = Size(constraints.maxWidth, constraints.maxHeight);
                final cardWidth = size.width;
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    _PositionedRect(
                      rect: layout.mediaRect,
                      size: size,
                      child: _MediaSlot(
                        media: media,
                        mediaType: mediaType,
                        showVideoIndicator: showVideoIndicator,
                        placeholderIcon: placeholderIcon,
                      ),
                    ),
                    Image.asset(
                      GachadexCardLayout.frontOverlayAsset,
                      key: const ValueKey('gachadex_card_front_overlay_asset'),
                      fit: BoxFit.cover,
                    ),
                    _PositionedRect(
                      rect: layout.nameRect,
                      size: size,
                      child: _ResponsiveCardText(
                        text: name.trim().isEmpty ? 'Nombre' : name.trim(),
                        maxLines: compact ? 1 : 2,
                        baseFontSize: cardWidth * (compact ? 0.052 : 0.058),
                        minFontSize: cardWidth * 0.036,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          shadows: const [
                            Shadow(color: Colors.black87, blurRadius: 3),
                          ],
                        ),
                      ),
                    ),
                    _PositionedRect(
                      rect: layout.healthRect,
                      size: size,
                      child: _ResponsiveCardText(
                        text: '${health ?? 0}',
                        maxLines: 1,
                        baseFontSize: cardWidth * (compact ? 0.06 : 0.067),
                        minFontSize: cardWidth * 0.042,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          shadows: const [
                            Shadow(color: Colors.black87, blurRadius: 3),
                          ],
                        ),
                      ),
                    ),
                    _PositionedRect(
                      rect: layout.descriptionRect,
                      size: size,
                      child: _ResponsiveCardText(
                        text: description.trim().isEmpty
                            ? 'Descripcion'
                            : description.trim(),
                        maxLines: compact ? 2 : 4,
                        baseFontSize: cardWidth * (compact ? 0.035 : 0.043),
                        minFontSize: cardWidth * 0.027,
                        style: TextStyle(
                          color: Colors.white,
                          height: 1.08,
                          fontWeight: FontWeight.w700,
                          shadows: const [
                            Shadow(color: Colors.black87, blurRadius: 2),
                          ],
                        ),
                      ),
                    ),
                    _PositionedRect(
                      rect: layout.rarityRect,
                      size: size,
                      child: _ResponsiveCardText(
                        text: rarityName.trim().isEmpty
                            ? 'Rareza'
                            : rarityName.trim(),
                        maxLines: 1,
                        baseFontSize: cardWidth * (compact ? 0.034 : 0.041),
                        minFontSize: cardWidth * 0.026,
                        style: const TextStyle(
                          color: Color(0xFF171107),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _PositionedRect extends StatelessWidget {
  const _PositionedRect({
    required this.rect,
    required this.size,
    required this.child,
  });

  final Rect rect;
  final Size size;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: rect.left * size.width,
      top: rect.top * size.height,
      width: rect.width * size.width,
      height: rect.height * size.height,
      child: child,
    );
  }
}

class _MediaSlot extends StatelessWidget {
  const _MediaSlot({
    required this.media,
    required this.mediaType,
    required this.showVideoIndicator,
    required this.placeholderIcon,
  });

  final Widget? media;
  final MediaType mediaType;
  final bool showVideoIndicator;
  final IconData placeholderIcon;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      key: const ValueKey('gachadex_card_media_rect'),
      borderRadius: BorderRadius.circular(AppConstants.cardRadius * 3),
      child: ColoredBox(
        color: Colors.black,
        child: Stack(
          fit: StackFit.expand,
          children: [
            media ??
                Center(
                  child: Icon(
                    placeholderIcon,
                    color: Colors.white.withValues(alpha: 0.82),
                    size: 42,
                  ),
                ),
            if (showVideoIndicator && mediaType == MediaType.video)
              Align(
                alignment: Alignment.center,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.32),
                    shape: BoxShape.circle,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ResponsiveCardText extends StatelessWidget {
  const _ResponsiveCardText({
    required this.text,
    required this.style,
    required this.maxLines,
    required this.baseFontSize,
    required this.minFontSize,
  });

  final String text;
  final TextStyle style;
  final int maxLines;
  final double baseFontSize;
  final double minFontSize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final fittedStyle = _fitStyle(
          constraints: constraints.biggest,
          direction: Directionality.of(context),
        );
        return Center(
          child: Text(
            text,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: fittedStyle,
          ),
        );
      },
    );
  }

  TextStyle _fitStyle({
    required Size constraints,
    required TextDirection direction,
  }) {
    var size = baseFontSize;
    while (size > minFontSize) {
      final painter = TextPainter(
        text: TextSpan(
          text: text,
          style: style.copyWith(fontSize: size),
        ),
        maxLines: maxLines,
        textAlign: TextAlign.center,
        textDirection: direction,
      )..layout(maxWidth: constraints.width);
      if (!painter.didExceedMaxLines && painter.height <= constraints.height) {
        break;
      }
      size -= 1;
    }
    return style.copyWith(
      fontSize: size.clamp(minFontSize, baseFontSize).toDouble(),
    );
  }
}
