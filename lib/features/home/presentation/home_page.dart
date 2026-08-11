import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/localization/app_localizations.dart';
import '../../../app/router/app_routes.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/animated_appear.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return ListView(
      padding: AppConstants.pagePadding,
      children: [
        AnimatedAppear(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(AppConstants.cardRadius),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.spacingLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    color: theme.colorScheme.onPrimaryContainer,
                    size: 40,
                  ),
                  const SizedBox(height: AppConstants.spacingMd),
                  Text(
                    l10n.home,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSm),
                  Text(
                    l10n.homePackMessage,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: AppConstants.spacingMd),
        AnimatedAppear(
          delay: const Duration(milliseconds: 60),
          child: _HomeAction(
            icon: Icons.collections_bookmark_outlined,
            title: l10n.collections,
            description: l10n.collectionsEmptyDescription,
            onTap: () => context.go(AppRoutes.collectionsPath),
          ),
        ),
        const SizedBox(height: AppConstants.spacingSm),
        AnimatedAppear(
          delay: const Duration(milliseconds: 100),
          child: _HomeAction(
            icon: Icons.add_box_outlined,
            title: l10n.create,
            description: l10n.createDescription,
            onTap: () => context.go(AppRoutes.createPath),
          ),
        ),
        const SizedBox(height: AppConstants.spacingLg),
        Tooltip(
          message: l10n.openControlledErrorTooltip,
          child: OutlinedButton.icon(
            onPressed: () => context.goNamed(AppRoutes.controlledErrorName),
            icon: const Icon(Icons.report_gmailerrorred_outlined),
            label: Text(l10n.openControlledError),
          ),
        ),
      ],
    );
  }
}

class _HomeAction extends StatelessWidget {
  const _HomeAction({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text(
          description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
