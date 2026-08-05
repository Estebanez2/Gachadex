import 'package:flutter/material.dart';

import '../../app/localization/app_localizations.dart';
import '../constants/app_constants.dart';

class AppErrorView extends StatelessWidget {
  const AppErrorView({
    super.key,
    required this.title,
    required this.description,
    this.onRetry,
    this.retryLabel,
  });

  final String title;
  final String description;
  final VoidCallback? onRetry;
  final String? retryLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resolvedRetryLabel = retryLabel ?? context.l10n.retry;

    return Semantics(
      liveRegion: true,
      child: Center(
        child: Padding(
          padding: AppConstants.pagePadding,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppConstants.maxContentWidth,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 48,
                  color: theme.colorScheme.error,
                ),
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
                if (onRetry != null) ...[
                  const SizedBox(height: AppConstants.spacingLg),
                  Tooltip(
                    message: resolvedRetryLabel,
                    child: FilledButton.icon(
                      onPressed: onRetry,
                      icon: const Icon(Icons.refresh),
                      label: Text(resolvedRetryLabel),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
