import 'package:flutter/material.dart';

import '../../app/localization/app_localizations.dart';
import '../constants/app_constants.dart';

class AppLoadingView extends StatelessWidget {
  const AppLoadingView({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    final label = message ?? context.l10n.loading;

    return Semantics(
      label: label,
      liveRegion: true,
      child: Center(
        child: Padding(
          padding: AppConstants.pagePadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              if (message != null) ...[
                const SizedBox(height: AppConstants.spacingMd),
                Text(
                  message!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
