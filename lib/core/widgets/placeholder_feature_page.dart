import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class PlaceholderFeaturePage extends StatelessWidget {
  const PlaceholderFeaturePage({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.action,
  });

  final IconData icon;
  final String title;
  final String description;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        padding: AppConstants.pagePadding.copyWith(
          top: AppConstants.spacingXl,
          bottom: AppConstants.spacingXl,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppConstants.maxContentWidth,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 48, color: theme.colorScheme.secondary),
              const SizedBox(height: AppConstants.spacingLg),
              Text(
                title,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: AppConstants.spacingSm),
              Text(description, style: theme.textTheme.bodyLarge),
              if (action != null) ...[
                const SizedBox(height: AppConstants.spacingLg),
                action!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
