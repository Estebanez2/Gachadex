import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class AppEmptyView extends StatelessWidget {
  const AppEmptyView({
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

    return Center(
      child: Padding(
        padding: AppConstants.pagePadding,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppConstants.maxContentWidth,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48, color: theme.colorScheme.secondary),
              const SizedBox(height: AppConstants.spacingMd),
              Text(
                title,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppConstants.spacingSm),
              Text(
                description,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge,
              ),
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
