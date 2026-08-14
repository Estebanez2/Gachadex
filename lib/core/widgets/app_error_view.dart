import 'package:flutter/material.dart';

import '../../app/localization/app_localizations.dart';
import '../constants/app_constants.dart';
import 'gachadex_ui.dart';

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
            child: GachadexSurfaceCard(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(
                        AppConstants.controlRadius,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppConstants.spacingMd),
                      child: Icon(
                        Icons.error_outline,
                        size: 40,
                        color: theme.colorScheme.onErrorContainer,
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
      ),
    );
  }
}
