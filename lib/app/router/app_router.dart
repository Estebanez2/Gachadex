import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/app_error_view.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../features/collections/presentation/collections_page.dart';
import '../../features/controlled_error/presentation/controlled_error_page.dart';
import '../../features/creator/presentation/creator_page.dart';
import '../../features/home/presentation/home_page.dart';
import '../../features/settings/presentation/settings_page.dart';
import '../localization/app_localizations.dart';
import 'app_routes.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final router = createAppRouter();
  ref.onDispose(router.dispose);
  return router;
});

GoRouter createAppRouter({String initialLocation = AppRoutes.homePath}) {
  final rootNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'rootNavigator',
  );
  final homeNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'homeNavigator',
  );
  final collectionsNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'collectionsNavigator',
  );
  final createNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'createNavigator',
  );
  final settingsNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'settingsNavigator',
  );

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: initialLocation,
    debugLogDiagnostics: kDebugMode,
    redirect: (context, state) {
      if (state.uri.path == AppRoutes.rootPath) {
        return AppRoutes.homePath;
      }

      return null;
    },
    routes: [
      StatefulShellRoute.indexedStack(
        restorationScopeId: 'main_shell',
        builder: (context, state, navigationShell) {
          return AppScaffold(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: homeNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutes.homePath,
                name: AppRoutes.homeName,
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: collectionsNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutes.collectionsPath,
                name: AppRoutes.collectionsName,
                builder: (context, state) => const CollectionsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: createNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutes.createPath,
                name: AppRoutes.createName,
                builder: (context, state) => const CreatorPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: settingsNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutes.settingsPath,
                name: AppRoutes.settingsName,
                builder: (context, state) => const SettingsPage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: AppRoutes.controlledErrorPath,
        name: AppRoutes.controlledErrorName,
        builder: (context, state) => const ControlledErrorPage(),
      ),
    ],
    errorBuilder: (context, state) {
      final l10n = context.l10n;
      return Scaffold(
        appBar: AppBar(title: Text(l10n.notFoundTitle)),
        body: SafeArea(
          child: AppErrorView(
            title: l10n.screenErrorTitle,
            description: l10n.notFoundDescription,
          ),
        ),
      );
    },
  );
}
