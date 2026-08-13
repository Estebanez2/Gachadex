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
import '../../features/creator/presentation/creator_page.dart';
import '../../features/home/application/home_providers.dart';
import '../../features/home/presentation/home_page.dart';
import '../../features/packs/presentation/pages/pack_opening_page.dart';
import '../../features/packs/presentation/pages/pack_editor_page.dart';
import '../../features/settings/presentation/settings_page.dart';
import '../localization/app_localizations.dart';
import 'app_routes.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final router = createAppRouter(
    onHomeSelected: () => ref.invalidate(homeAvailablePacksProvider),
  );
  ref.onDispose(router.dispose);
  return router;
});

GoRouter createAppRouter({
  String initialLocation = AppRoutes.homePath,
  VoidCallback? onHomeSelected,
}) {
  final rootNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'rootNavigator',
  );
  final homeNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'homeNavigator',
  );
  final albumNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'albumNavigator',
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
          return AppScaffold(
            navigationShell: navigationShell,
            onHomeSelected: onHomeSelected,
          );
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
            navigatorKey: albumNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutes.albumPath,
                name: AppRoutes.albumName,
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
                          initialTabIndex: _initialInstalledCollectionTabIndex(
                            state.uri.queryParameters['tab'],
                          ),
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
        path: AppRoutes.collectionsPath,
        redirect: (context, state) => AppRoutes.albumPath,
      ),
      GoRoute(
        path: '${AppRoutes.collectionsPath}/:installedCollectionId',
        redirect: (context, state) {
          final id = state.pathParameters['installedCollectionId'];
          return id == null
              ? AppRoutes.albumPath
              : AppRoutes.installedCollectionPath(id);
        },
        routes: [
          GoRoute(
            path: 'openings/:openingId',
            redirect: (context, state) {
              final installedCollectionId =
                  state.pathParameters['installedCollectionId'];
              final openingId = state.pathParameters['openingId'];
              if (installedCollectionId == null || openingId == null) {
                return AppRoutes.albumPath;
              }
              return AppRoutes.packOpeningPath(
                installedCollectionId,
                openingId,
              );
            },
          ),
          GoRoute(
            path: 'cards/:cardId',
            redirect: (context, state) {
              final installedCollectionId =
                  state.pathParameters['installedCollectionId'];
              final cardId = state.pathParameters['cardId'];
              if (installedCollectionId == null || cardId == null) {
                return AppRoutes.albumPath;
              }
              return AppRoutes.albumCardPath(installedCollectionId, cardId);
            },
          ),
        ],
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

int _initialInstalledCollectionTabIndex(String? tab) {
  return switch (tab) {
    'cards' || 'album' => 1,
    'movements' => 2,
    _ => 0,
  };
}
