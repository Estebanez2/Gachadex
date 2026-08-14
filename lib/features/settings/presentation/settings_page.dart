import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/localization/app_localizations.dart';
import '../../../app/theme/app_theme_mode.dart';
import '../../../app/theme/theme_controller.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/notifications/application/notification_providers.dart';
import '../../../core/widgets/gachadex_ui.dart';
import '../../../features/packs/application/pack_notification_coordinator_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final themeMode = ref.watch(themeControllerProvider);
    final notificationsEnabled = ref.watch(packNotificationsEnabledProvider);

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
              GachadexHeroPanel(
                icon: Icons.settings_outlined,
                title: l10n.settings,
                description: l10n.themeSessionOnly,
              ),
              const SizedBox(height: AppConstants.spacingLg),
              GachadexSectionHeader(
                icon: Icons.palette_outlined,
                title: l10n.theme,
              ),
              const SizedBox(height: AppConstants.spacingSm),
              GachadexSurfaceCard(
                child: SingleChildScrollView(
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
              ),
              const SizedBox(height: AppConstants.spacingLg),
              GachadexSurfaceCard(
                child: notificationsEnabled.when(
                  loading: () => ListTile(
                    leading: const Icon(Icons.notifications_outlined),
                    title: Text(l10n.packNotifications),
                    subtitle: const LinearProgressIndicator(),
                  ),
                  error: (_, _) => ListTile(
                    leading: const Icon(Icons.notifications_off_outlined),
                    title: Text(l10n.packNotifications),
                    subtitle: Text(l10n.packNotificationsError),
                  ),
                  data: (enabled) => Column(
                    children: [
                      SwitchListTile(
                        secondary: Icon(
                          enabled
                              ? Icons.notifications_active_outlined
                              : Icons.notifications_off_outlined,
                        ),
                        title: Text(l10n.packNotifications),
                        subtitle: Text(
                          enabled
                              ? l10n.packNotificationsEnabledDescription
                              : l10n.packNotificationsDisabledDescription,
                        ),
                        value: enabled,
                        onChanged: (value) {
                          ref
                              .read(notificationCoordinatorProvider)
                              .setPackNotificationsEnabled(value);
                        },
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton.icon(
                          onPressed: () {
                            ref
                                .read(notificationCoordinatorProvider)
                                .openNotificationSettings();
                          },
                          icon: const Icon(Icons.settings_outlined),
                          label: Text(l10n.openNotificationSettings),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppConstants.spacingLg),
              GachadexSurfaceCard(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.info_outline),
                      title: Text(l10n.appInfo),
                      subtitle: Text(
                        '${l10n.appTitle}\n${l10n.phaseOneStatus}',
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.palette_outlined),
                      title: Text(l10n.theme),
                      subtitle: Text(l10n.themeSessionOnly),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
