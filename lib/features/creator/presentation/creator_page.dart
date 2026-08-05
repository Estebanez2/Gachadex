import 'package:flutter/material.dart';

import '../../../app/localization/app_localizations.dart';
import '../../../core/widgets/placeholder_feature_page.dart';

class CreatorPage extends StatelessWidget {
  const CreatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return PlaceholderFeaturePage(
      icon: Icons.edit_note_outlined,
      title: l10n.create,
      description: l10n.createDescription,
      action: FilledButton.icon(
        onPressed: null,
        icon: const Icon(Icons.hourglass_empty),
        label: Text(l10n.createDisabledAction),
      ),
    );
  }
}
