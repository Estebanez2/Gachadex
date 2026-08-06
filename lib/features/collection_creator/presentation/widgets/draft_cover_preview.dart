import 'package:flutter/material.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../domain/catalogs/draft_cover_catalog.dart';
import '../../domain/value_objects/draft_cover_style.dart';

class DraftCoverPreview extends StatelessWidget {
  const DraftCoverPreview({
    super.key,
    required this.style,
    required this.collectionName,
    this.height = 148,
  });

  final DraftCoverStyle style;
  final String collectionName;
  final double height;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final background = DraftCoverCatalog.colorById(style.backgroundColorId);
    final accent = DraftCoverCatalog.colorById(style.accentColorId);
    final backgroundColor = Color(background.colorValue);
    final accentColor = Color(accent.colorValue);
    final textColor = background.prefersDarkText ? Colors.black : Colors.white;
    final displayName = collectionName.trim().isEmpty
        ? l10n.unnamedCollection
        : collectionName.trim();

    return Semantics(
      label: l10n.cover,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [backgroundColor, accentColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: CustomPaint(
            painter: _DraftCoverPatternPainter(
              patternId: style.patternId,
              color: textColor.withValues(alpha: 0.18),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(_coverIcon(style.iconId), color: textColor, size: 36),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _initials(displayName),
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              color: textColor,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        displayName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: textColor,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

IconData _coverIcon(String id) {
  return switch (id) {
    'cover_icon_cards' => Icons.style_outlined,
    'cover_icon_laugh' => Icons.sentiment_very_satisfied_outlined,
    'cover_icon_camera' => Icons.photo_camera_outlined,
    'cover_icon_group' => Icons.groups_outlined,
    'cover_icon_trophy' => Icons.emoji_events_outlined,
    _ => Icons.auto_awesome_outlined,
  };
}

String _initials(String name) {
  final words = name
      .trim()
      .split(RegExp(r'\s+'))
      .where((word) => word.isNotEmpty)
      .toList(growable: false);
  if (words.isEmpty) {
    return 'G';
  }

  return words.take(2).map((word) => word[0].toUpperCase()).join();
}

class _DraftCoverPatternPainter extends CustomPainter {
  const _DraftCoverPatternPainter({
    required this.patternId,
    required this.color,
  });

  final String patternId;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2;

    switch (patternId) {
      case 'cover_pattern_diagonal':
        for (var x = -size.height; x < size.width; x += 18) {
          canvas.drawLine(
            Offset(x, size.height),
            Offset(x + size.height, 0),
            paint,
          );
        }
      case 'cover_pattern_dots':
        for (var x = 10.0; x < size.width; x += 24) {
          for (var y = 10.0; y < size.height; y += 24) {
            canvas.drawCircle(Offset(x, y), 2.2, paint);
          }
        }
      case 'cover_pattern_split':
        final fill = Paint()..color = color.withValues(alpha: 0.22);
        canvas.drawPath(
          Path()
            ..moveTo(size.width, 0)
            ..lineTo(size.width, size.height)
            ..lineTo(size.width * 0.28, size.height)
            ..close(),
          fill,
        );
      default:
        break;
    }
  }

  @override
  bool shouldRepaint(_DraftCoverPatternPainter oldDelegate) {
    return oldDelegate.patternId != patternId || oldDelegate.color != color;
  }
}
