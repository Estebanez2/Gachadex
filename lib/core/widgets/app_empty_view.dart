import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import 'gachadex_ui.dart';

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

    return LayoutBuilder(
      builder: (context, constraints) {
        final minHeight = constraints.hasBoundedHeight
            ? constraints.maxHeight
            : 0.0;

        return SingleChildScrollView(
          padding: AppConstants.pagePadding,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: minHeight),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppConstants.maxContentWidth,
                ),
                child: GachadexSurfaceCard(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(
                            AppConstants.controlRadius,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(AppConstants.spacingMd),
                          child: Icon(
                            icon,
                            size: 40,
                            color: theme.colorScheme.onSecondaryContainer,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppConstants.spacingMd),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: AppConstants.spacingSm),
                      Text(
                        description,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      if (action != null) ...[
                        const SizedBox(height: AppConstants.spacingLg),
                        action!,
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
