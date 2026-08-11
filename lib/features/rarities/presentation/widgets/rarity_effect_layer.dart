import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/catalogs/rarity_visual_catalog.dart';

enum RarityEffectKind { none, softGlow, sparkle, gradient, holographic, pulse }

@visibleForTesting
RarityEffectKind rarityEffectKindForId(String? effectId) {
  return switch (effectId ?? RarityVisualCatalog.defaultEffectId) {
    'rarity_effect_soft_glow' => RarityEffectKind.softGlow,
    'rarity_effect_spark' => RarityEffectKind.sparkle,
    'rarity_effect_gradient' => RarityEffectKind.gradient,
    'rarity_effect_holo' => RarityEffectKind.holographic,
    'rarity_effect_pulse' => RarityEffectKind.pulse,
    _ => RarityEffectKind.none,
  };
}

class RarityEffectFrame extends StatelessWidget {
  const RarityEffectFrame({
    super.key,
    required this.effectId,
    required this.baseColor,
    required this.borderRadius,
    required this.child,
    this.animate = true,
    this.clip = true,
  });

  final String? effectId;
  final Color baseColor;
  final BorderRadius borderRadius;
  final Widget child;
  final bool animate;
  final bool clip;

  @override
  Widget build(BuildContext context) {
    final kind = rarityEffectKindForId(effectId);
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final canAnimate = animate && !reduceMotion;
    final shadows = rarityEffectShadows(effectId, baseColor);

    Widget content = DecoratedBox(
      decoration: BoxDecoration(borderRadius: borderRadius, boxShadow: shadows),
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          child,
          Positioned.fill(
            child: _RarityEffectOverlay(
              kind: kind,
              baseColor: baseColor,
              borderRadius: borderRadius,
              animate: canAnimate,
            ),
          ),
        ],
      ),
    );

    if (clip) {
      content = ClipRRect(borderRadius: borderRadius, child: content);
    }
    return content;
  }
}

@visibleForTesting
List<BoxShadow> rarityEffectShadows(String? effectId, Color baseColor) {
  return switch (rarityEffectKindForId(effectId)) {
    RarityEffectKind.softGlow => [
      BoxShadow(
        color: baseColor.withValues(alpha: 0.28),
        blurRadius: AppConstants.elevationShadowBlur,
        spreadRadius: 1,
        offset: AppConstants.elevationShadowOffset,
      ),
    ],
    RarityEffectKind.sparkle => [
      BoxShadow(
        color: Colors.white.withValues(alpha: 0.34),
        blurRadius: 14,
        spreadRadius: 1,
      ),
    ],
    RarityEffectKind.pulse => [
      BoxShadow(
        color: baseColor.withValues(alpha: 0.38),
        blurRadius: 20,
        spreadRadius: 2,
      ),
    ],
    RarityEffectKind.holographic => [
      BoxShadow(
        color: baseColor.withValues(alpha: 0.24),
        blurRadius: 22,
        spreadRadius: 1,
        offset: AppConstants.elevationShadowOffset,
      ),
    ],
    RarityEffectKind.gradient || RarityEffectKind.none => const [],
  };
}

class _RarityEffectOverlay extends StatefulWidget {
  const _RarityEffectOverlay({
    required this.kind,
    required this.baseColor,
    required this.borderRadius,
    required this.animate,
  });

  final RarityEffectKind kind;
  final Color baseColor;
  final BorderRadius borderRadius;
  final bool animate;

  @override
  State<_RarityEffectOverlay> createState() => _RarityEffectOverlayState();
}

class _RarityEffectOverlayState extends State<_RarityEffectOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _sync();
  }

  @override
  void didUpdateWidget(covariant _RarityEffectOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    _sync();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sync() {
    if (widget.animate && _hasMotion(widget.kind)) {
      if (!_controller.isAnimating) {
        _controller.repeat();
      }
    } else {
      _controller.stop();
      _controller.value = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.kind == RarityEffectKind.none) {
      return const SizedBox.shrink();
    }
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) => CustomPaint(
          painter: _RarityEffectPainter(
            kind: widget.kind,
            baseColor: widget.baseColor,
            progress: widget.animate ? _controller.value : 0.25,
          ),
        ),
      ),
    );
  }

  bool _hasMotion(RarityEffectKind kind) {
    return switch (kind) {
      RarityEffectKind.sparkle ||
      RarityEffectKind.holographic ||
      RarityEffectKind.pulse => true,
      RarityEffectKind.none ||
      RarityEffectKind.softGlow ||
      RarityEffectKind.gradient => false,
    };
  }
}

class _RarityEffectPainter extends CustomPainter {
  const _RarityEffectPainter({
    required this.kind,
    required this.baseColor,
    required this.progress,
  });

  final RarityEffectKind kind;
  final Color baseColor;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    switch (kind) {
      case RarityEffectKind.softGlow:
        _paintSoftGlow(canvas, size);
      case RarityEffectKind.sparkle:
        _paintSparkles(canvas, size);
      case RarityEffectKind.gradient:
        _paintGradient(canvas, size);
      case RarityEffectKind.holographic:
        _paintHolographic(canvas, size);
      case RarityEffectKind.pulse:
        _paintPulse(canvas, size);
      case RarityEffectKind.none:
        break;
    }
  }

  void _paintSoftGlow(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [Colors.white.withValues(alpha: 0.20), Colors.transparent],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, paint);
  }

  void _paintSparkles(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withValues(alpha: 0.74);
    final points = [
      Offset(size.width * 0.18, size.height * (0.25 + progress * 0.08)),
      Offset(size.width * 0.72, size.height * (0.18 + progress * 0.10)),
      Offset(size.width * 0.82, size.height * (0.72 - progress * 0.10)),
      Offset(size.width * 0.36, size.height * (0.78 - progress * 0.08)),
    ];
    for (final point in points) {
      _paintSpark(canvas, point, 3.0 + 2.0 * math.sin(progress * math.pi));
    }
    canvas.drawPoints(ui.PointMode.points, points, paint..strokeWidth = 2);
  }

  void _paintGradient(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.white.withValues(alpha: 0.24),
          baseColor.withValues(alpha: 0.06),
          Colors.black.withValues(alpha: 0.16),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, paint);
  }

  void _paintHolographic(Canvas canvas, Size size) {
    final offset = (progress * size.width * 1.8) - size.width * 0.4;
    final paint = Paint()
      ..shader =
          LinearGradient(
            colors: [
              Colors.transparent,
              const Color(0xFF80FFF4).withValues(alpha: 0.18),
              const Color(0xFFFF7AE6).withValues(alpha: 0.20),
              Colors.white.withValues(alpha: 0.22),
              Colors.transparent,
            ],
            stops: const [0, 0.35, 0.52, 0.68, 1],
          ).createShader(
            Rect.fromLTWH(offset - size.width, 0, size.width * 2, size.height),
          );
    canvas.drawRect(Offset.zero & size, paint);
  }

  void _paintPulse(Canvas canvas, Size size) {
    final alpha = 0.08 + (math.sin(progress * math.pi * 2) + 1) * 0.05;
    final paint = Paint()..color = baseColor.withValues(alpha: alpha);
    canvas.drawRect(Offset.zero & size, paint);
  }

  void _paintSpark(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.82)
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;
    canvas
      ..drawLine(
        center.translate(-radius, 0),
        center.translate(radius, 0),
        paint,
      )
      ..drawLine(
        center.translate(0, -radius),
        center.translate(0, radius),
        paint,
      );
  }

  @override
  bool shouldRepaint(covariant _RarityEffectPainter oldDelegate) {
    return kind != oldDelegate.kind ||
        baseColor != oldDelegate.baseColor ||
        progress != oldDelegate.progress;
  }
}
