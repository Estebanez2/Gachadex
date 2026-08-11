import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/app_constants.dart';
import '../core/notifications/application/notification_providers.dart';
import '../core/notifications/domain/pack_notification_payload.dart';
import '../features/collections/application/installed_collection_providers.dart';
import '../features/import_export/application/gachadex_import_export_providers.dart';
import '../features/import_export/application/incoming_gachadex_file_service.dart';
import '../features/import_export/domain/gachadex_package_failure.dart';
import '../features/packs/application/pack_notification_coordinator_provider.dart';
import 'localization/app_localizations.dart';
import 'router/app_router.dart';
import 'router/app_routes.dart';
import 'theme/app_theme.dart';
import 'theme/theme_controller.dart';

class GachadexApp extends ConsumerStatefulWidget {
  const GachadexApp({super.key});

  @override
  ConsumerState<GachadexApp> createState() => _GachadexAppState();
}

class _GachadexAppState extends ConsumerState<GachadexApp>
    with WidgetsBindingObserver {
  StreamSubscription<PackNotificationPayload>? _notificationTapSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _notificationTapSubscription = ref
        .read(localNotificationServiceProvider)
        .selections
        .listen(_openCollectionFromNotification);
    WidgetsBinding.instance.addPostFrameCallback((_) => _refreshPacks());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_notificationTapSubscription?.cancel());
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshPacks();
    }
  }

  void _refreshPacks() {
    unawaited(
      ref.read(notificationCoordinatorProvider).initializeAndRefreshAll(),
    );
  }

  void _openCollectionFromNotification(PackNotificationPayload payload) {
    ref
        .read(appRouterProvider)
        .go(
          AppRoutes.installedCollectionPath(
            payload.installedCollectionId.value,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeControllerProvider);

    return MaterialApp.router(
      title: AppConstants.appName,
      onGenerateTitle: (context) => context.l10n.appTitle,
      restorationScopeId: AppConstants.restorationScopeId,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      routerConfig: router,
      locale: const Locale('es'),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      builder: (context, child) {
        return _IncomingPackageListener(
          child: child ?? const SizedBox.shrink(),
        );
      },
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale != null) {
          for (final supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode) {
              return supportedLocale;
            }
          }
        }

        return const Locale('es');
      },
    );
  }
}

class _IncomingPackageListener extends ConsumerStatefulWidget {
  const _IncomingPackageListener({required this.child});

  final Widget child;

  @override
  ConsumerState<_IncomingPackageListener> createState() =>
      _IncomingPackageListenerState();
}

class _IncomingPackageListenerState
    extends ConsumerState<_IncomingPackageListener> {
  StreamSubscription<String>? _incomingPackageSubscription;
  final Set<String> _handledIncomingPackagePaths = <String>{};

  @override
  void initState() {
    super.initState();
    final incomingFiles = ref.read(incomingGachadexFileServiceProvider);
    _incomingPackageSubscription = incomingFiles.paths.listen(
      _openIncomingPackage,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_openInitialIncomingPackage(incomingFiles));
    });
  }

  @override
  void dispose() {
    unawaited(_incomingPackageSubscription?.cancel());
    super.dispose();
  }

  Future<void> _openInitialIncomingPackage(
    IncomingGachadexFileService incomingFiles,
  ) async {
    final path = await incomingFiles.takeInitialPath();
    if (path != null) {
      await _openIncomingPackage(path);
    }
  }

  Future<void> _openIncomingPackage(String path) async {
    if (!_handledIncomingPackagePaths.add(path) || !mounted) {
      return;
    }

    final interactionContext = await _waitForRouterContext();
    if (interactionContext == null || !interactionContext.mounted) {
      _handledIncomingPackagePaths.remove(path);
      return;
    }

    final l10n = interactionContext.l10n;
    try {
      final picked = await ref
          .read(gachadexPackageActionsProvider)
          .previewExternalFile(path);
      if (!mounted || !interactionContext.mounted) {
        return;
      }
      if (picked.preview.alreadyInstalled) {
        ScaffoldMessenger.of(interactionContext).showSnackBar(
          SnackBar(content: Text(l10n.collectionAlreadyInstalled)),
        );
        ref.read(appRouterProvider).go(AppRoutes.collectionsPath);
        return;
      }

      final confirmed = await showDialog<bool>(
        context: interactionContext,
        useRootNavigator: true,
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
        return;
      }

      final result = await ref
          .read(gachadexPackageActionsProvider)
          .importPicked(picked.path);
      ref.invalidate(installedCollectionsProvider);
      if (!mounted || !interactionContext.mounted) {
        return;
      }
      ScaffoldMessenger.of(
        interactionContext,
      ).showSnackBar(SnackBar(content: Text(l10n.collectionImported)));
      ref
          .read(appRouterProvider)
          .go(AppRoutes.installedCollectionPath(result.installedCollectionId));
    } on GachadexPackageFailure catch (error) {
      if (mounted && interactionContext.mounted) {
        ScaffoldMessenger.of(
          interactionContext,
        ).showSnackBar(SnackBar(content: Text(error.safeMessage)));
      }
    } on Object catch (error) {
      if (mounted && interactionContext.mounted) {
        ScaffoldMessenger.of(interactionContext).showSnackBar(
          SnackBar(content: Text('${l10n.importError} Detalle: $error')),
        );
      }
    }
  }

  Future<BuildContext?> _waitForRouterContext() async {
    for (var attempt = 0; attempt < 10; attempt += 1) {
      if (!mounted) {
        return null;
      }
      final routerContext = ref
          .read(appRouterProvider)
          .routerDelegate
          .navigatorKey
          .currentContext;
      if (routerContext != null) {
        return routerContext;
      }
      await Future<void>.delayed(const Duration(milliseconds: 50));
    }
    return null;
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
