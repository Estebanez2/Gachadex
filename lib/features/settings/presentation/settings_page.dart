import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/localization/app_localizations.dart';
import '../../../app/theme/app_theme_mode.dart';
import '../../../app/theme/theme_controller.dart';
import '../../../core/constants/app_constants.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final themeMode = ref.watch(themeControllerProvider);
    final theme = Theme.of(context);

    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        padding: AppConstants.pagePadding.copyWith(
          top: AppConstants.spacingXl,
          bottom: AppConstants.spacingXl,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppConstants.maxContentWidth,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.settings,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: AppConstants.spacingLg),
              Text(
                l10n.theme,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppConstants.spacingSm),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SegmentedButton<ThemeMode>(
                  showSelectedIcon: false,
                  segments: [
                    for (final mode in appThemeModes)
                      ButtonSegment<ThemeMode>(
                        value: mode,
                        icon: Icon(mode.icon),
                        label: Text(mode.localizedLabel(l10n)),
                      ),
                  ],
                  selected: {themeMode},
                  onSelectionChanged: (selection) {
                    ref
                        .read(themeControllerProvider.notifier)
                        .setThemeMode(selection.single);
                  },
                ),
              ),
              const SizedBox(height: AppConstants.spacingLg),
              const Divider(),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.info_outline),
                title: Text(l10n.appInfo),
                subtitle: Text('${l10n.appTitle}\n${l10n.phaseOneStatus}'),
              ),
              const Divider(),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.palette_outlined),
                title: Text(l10n.theme),
                subtitle: Text(l10n.themeSessionOnly),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
