import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/app_constants.dart';
import '../core/notifications/application/notification_providers.dart';
import '../core/notifications/domain/pack_notification_payload.dart';
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
