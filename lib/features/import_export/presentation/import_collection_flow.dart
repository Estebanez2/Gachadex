import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/localization/app_localizations.dart';
import '../application/gachadex_import_export_providers.dart';
import '../domain/gachadex_package_failure.dart';

Future<bool> runImportCollectionFlow({
  required BuildContext context,
  required WidgetRef ref,
}) async {
  final l10n = context.l10n;
  try {
    final picked = await ref
        .read(gachadexPackageActionsProvider)
        .pickForImport();
    if (!context.mounted) {
      return false;
    }
    if (picked.preview.alreadyInstalled) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.collectionAlreadyInstalled)));
      return false;
    }
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.importPreviewTitle),
        content: Text(
          l10n.importPreviewDescription(
            picked.preview.name,
            picked.preview.cardCount,
            picked.preview.videoCount,
            picked.preview.packTypeCount,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.importCollection),
          ),
        ],
      ),
    );
    if (confirmed != true) {
      return false;
    }

    await ref.read(gachadexPackageActionsProvider).importPicked(picked.path);
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.collectionImported)));
    }
    return true;
  } on GachadexPackageCanceled {
    return false;
  } on GachadexPackageFailure catch (error) {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.safeMessage)));
    }
    return false;
  } on Object {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.importError)));
    }
    return false;
  }
}
