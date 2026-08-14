import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class GachadexHeroPanel extends StatelessWidget {
  const GachadexHeroPanel({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.trailing,
  });

  final IconData icon;
  final String title;
  final String description;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        border: Border.all(color: scheme.primary.withValues(alpha: 0.18)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingLg),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 420 && trailing != null;
            final heading = Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: scheme.primary.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(
                      AppConstants.controlRadius,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.spacingSm),
                    child: Icon(
                      icon,
                      color: scheme.onPrimaryContainer,
                      size: 32,
                    ),
                  ),
                ),
                const SizedBox(width: AppConstants.spacingMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: scheme.onPrimaryContainer,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: AppConstants.spacingXs),
                      Text(
                        description,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: scheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );

            if (compact) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heading,
                  const SizedBox(height: AppConstants.spacingMd),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: trailing!,
                  ),
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: heading),
                if (trailing != null) ...[
                  const SizedBox(width: AppConstants.spacingSm),
                  trailing!,
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class GachadexSectionHeader extends StatelessWidget {
  const GachadexSectionHeader({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: scheme.primary),
        const SizedBox(width: AppConstants.spacingSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: AppConstants.spacingXs),
                Text(
                  subtitle!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (trailing != null) ...[
          const SizedBox(width: AppConstants.spacingSm),
          trailing!,
        ],
      ],
    );
  }
}

class GachadexSurfaceCard extends StatelessWidget {
  const GachadexSurfaceCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppConstants.spacingMd),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.surfaceContainerLowest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}

class GachadexMetricPill extends StatelessWidget {
  const GachadexMetricPill({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppConstants.controlRadius),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingMd,
          vertical: AppConstants.spacingSm,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: scheme.primary),
            const SizedBox(width: AppConstants.spacingXs),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 180),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: scheme.onSurfaceVariant,
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
