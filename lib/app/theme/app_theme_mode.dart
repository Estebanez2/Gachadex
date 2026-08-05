import 'package:flutter/material.dart';

import '../localization/app_localizations.dart';

const appThemeModes = <ThemeMode>[
  ThemeMode.system,
  ThemeMode.light,
  ThemeMode.dark,
];

extension AppThemeModeLabel on ThemeMode {
  String localizedLabel(AppLocalizations l10n) {
    return switch (this) {
      ThemeMode.system => l10n.system,
      ThemeMode.light => l10n.light,
      ThemeMode.dark => l10n.dark,
    };
  }

  IconData get icon {
    return switch (this) {
      ThemeMode.system => Icons.brightness_auto_outlined,
      ThemeMode.light => Icons.light_mode_outlined,
      ThemeMode.dark => Icons.dark_mode_outlined,
    };
  }
}
