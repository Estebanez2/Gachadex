import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/app_error_view.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../core/identifiers/entity_id.dart';
import '../../features/cards/presentation/pages/card_editor_page.dart';
import '../../features/album/presentation/pages/album_card_detail_page.dart';
import '../../features/collections/presentation/collections_page.dart';
import '../../features/collections/presentation/installed_collection_detail_page.dart';
import '../../features/collection_creator/presentation/pages/collection_draft_editor_page.dart';
import '../../features/collection_creator/presentation/pages/create_draft_page.dart';
import '../../features/controlled_error/presentation/controlled_error_page.dart';
import '../../features/creator/presentation/creator_page.dart';
import '../../features/home/presentation/home_page.dart';
import '../../features/packs/presentation/pages/pack_opening_page.dart';
import '../../features/packs/presentation/pages/pack_editor_page.dart';
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
                routes: [
                  GoRoute(
                    path: ':installedCollectionId',
                    name: AppRoutes.installedCollectionName,
                    builder: (context, state) {
                      final installedCollectionId =
                          state.pathParameters['installedCollectionId'];
                      if (installedCollectionId == null) {
                        return _RouteError(
                          description: context.l10n.projectNotFound,
                        );
                      }

                      try {
                        return InstalledCollectionDetailPage(
                          installedCollectionId: InstalledCollectionId(
                            installedCollectionId,
                          ),
                          initialTabIndex:
                              state.uri.queryParameters['tab'] == 'album'
                              ? 1
                              : 0,
                        );
                      } on FormatException {
                        return _RouteError(
                          description: context.l10n.projectNotFound,
                        );
                      }
                    },
                    routes: [
                      GoRoute(
                        path: 'openings/:openingId',
                        name: AppRoutes.packOpeningName,
                        builder: (context, state) {
                          final installedCollectionId =
                              state.pathParameters['installedCollectionId'];
                          final openingId = state.pathParameters['openingId'];
                          if (installedCollectionId == null ||
                              openingId == null) {
                            return _RouteError(
                              description: context.l10n.projectNotFound,
                            );
                          }

                          try {
                            return PackOpeningPage(
                              installedCollectionId: InstalledCollectionId(
                                installedCollectionId,
                              ),
                              openingId: PackOpeningId(openingId),
                            );
                          } on FormatException {
                            return _RouteError(
                              description: context.l10n.projectNotFound,
                            );
                          }
                        },
                      ),
                      GoRoute(
                        path: 'cards/:cardId',
                        name: AppRoutes.albumCardName,
                        builder: (context, state) {
                          final installedCollectionId =
                              state.pathParameters['installedCollectionId'];
                          final cardId = state.pathParameters['cardId'];
                          if (installedCollectionId == null || cardId == null) {
                            return _RouteError(
                              description: context.l10n.projectNotFound,
                            );
                          }

                          try {
                            return AlbumCardDetailPage(
                              installedCollectionId: InstalledCollectionId(
                                installedCollectionId,
                              ),
                              cardId: CardId(cardId),
                            );
                          } on FormatException {
                            return _RouteError(
                              description: context.l10n.projectNotFound,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
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
        path: AppRoutes.createNewPath,
        name: AppRoutes.createNewName,
        builder: (context, state) => const CreateDraftPage(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '${AppRoutes.createProjectPathPrefix}/:projectId',
        name: AppRoutes.createProjectName,
        builder: (context, state) {
          final projectId = state.pathParameters['projectId'];
          if (projectId == null) {
            return _RouteError(description: context.l10n.projectNotFound);
          }

          try {
            return CollectionDraftEditorPage(
              projectId: CollectionProjectId(projectId),
            );
          } on FormatException {
            return _RouteError(description: context.l10n.projectNotFound);
          }
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '${AppRoutes.createProjectPathPrefix}/:projectId/cards/new',
        name: AppRoutes.createCardNewName,
        builder: (context, state) {
          final projectId = state.pathParameters['projectId'];
          if (projectId == null) {
            return _RouteError(description: context.l10n.projectNotFound);
          }

          try {
            return CardEditorPage(projectId: CollectionProjectId(projectId));
          } on FormatException {
            return _RouteError(description: context.l10n.projectNotFound);
          }
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '${AppRoutes.createProjectPathPrefix}/:projectId/cards/:cardId',
        name: AppRoutes.createCardEditName,
        builder: (context, state) {
          final projectId = state.pathParameters['projectId'];
          final cardId = state.pathParameters['cardId'];
          if (projectId == null || cardId == null) {
            return _RouteError(description: context.l10n.projectNotFound);
          }

          try {
            return CardEditorPage(
              projectId: CollectionProjectId(projectId),
              cardId: CardId(cardId),
            );
          } on FormatException {
            return _RouteError(description: context.l10n.projectNotFound);
          }
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '${AppRoutes.createProjectPathPrefix}/:projectId/packs/new',
        name: AppRoutes.createPackNewName,
        builder: (context, state) {
          final projectId = state.pathParameters['projectId'];
          if (projectId == null) {
            return _RouteError(description: context.l10n.projectNotFound);
          }

          try {
            return PackEditorPage(projectId: CollectionProjectId(projectId));
          } on FormatException {
            return _RouteError(description: context.l10n.projectNotFound);
          }
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path:
            '${AppRoutes.createProjectPathPrefix}/:projectId/packs/:packTypeId',
        name: AppRoutes.createPackEditName,
        builder: (context, state) {
          final projectId = state.pathParameters['projectId'];
          final packTypeId = state.pathParameters['packTypeId'];
          if (projectId == null || packTypeId == null) {
            return _RouteError(description: context.l10n.projectNotFound);
          }

          try {
            return PackEditorPage(
              projectId: CollectionProjectId(projectId),
              packTypeId: PackTypeId(packTypeId),
            );
          } on FormatException {
            return _RouteError(description: context.l10n.projectNotFound);
          }
        },
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

class _RouteError extends StatelessWidget {
  const _RouteError({required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.screenErrorTitle)),
      body: SafeArea(
        child: AppErrorView(
          title: l10n.screenErrorTitle,
          description: description,
        ),
      ),
    );
  }
}
