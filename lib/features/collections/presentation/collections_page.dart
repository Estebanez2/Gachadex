import 'package:flutter/material.dart';

import '../../../app/localization/app_localizations.dart';
import '../../../core/widgets/app_empty_view.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AppEmptyView(
      icon: Icons.collections_bookmark_outlined,
      title: l10n.noCollections,
      description: l10n.collectionsEmptyDescription,
    );
  }
}
