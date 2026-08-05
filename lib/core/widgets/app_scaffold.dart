import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/localization/app_localizations.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final destinations = [
      _NavigationDestination(
        icon: Icons.home_outlined,
        selectedIcon: Icons.home,
        label: l10n.home,
      ),
      _NavigationDestination(
        icon: Icons.collections_bookmark_outlined,
        selectedIcon: Icons.collections_bookmark,
        label: l10n.collections,
      ),
      _NavigationDestination(
        icon: Icons.add_circle_outline,
        selectedIcon: Icons.add_circle,
        label: l10n.create,
      ),
      _NavigationDestination(
        icon: Icons.settings_outlined,
        selectedIcon: Icons.settings,
        label: l10n.settings,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(_titleForIndex(l10n))),
      body: SafeArea(top: false, child: navigationShell),
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: [
          for (final destination in destinations)
            NavigationDestination(
              icon: Icon(destination.icon),
              selectedIcon: Icon(destination.selectedIcon),
              label: destination.label,
            ),
        ],
      ),
    );
  }

  String _titleForIndex(AppLocalizations l10n) {
    return switch (navigationShell.currentIndex) {
      0 => l10n.home,
      1 => l10n.collections,
      2 => l10n.create,
      3 => l10n.settings,
      _ => l10n.appTitle,
    };
  }
}

final class _NavigationDestination {
  const _NavigationDestination({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
}
