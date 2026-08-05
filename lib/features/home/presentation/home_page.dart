import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/localization/app_localizations.dart';
import '../../../app/router/app_routes.dart';
import '../../../core/widgets/placeholder_feature_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return PlaceholderFeaturePage(
      icon: Icons.inventory_2_outlined,
      title: l10n.home,
      description: l10n.homePackMessage,
      action: Tooltip(
        message: l10n.openControlledErrorTooltip,
        child: FilledButton.icon(
          onPressed: () => context.goNamed(AppRoutes.controlledErrorName),
          icon: const Icon(Icons.report_gmailerrorred_outlined),
          label: Text(l10n.openControlledError),
        ),
      ),
    );
  }
}
