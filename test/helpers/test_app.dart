import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gachadex/app/app.dart';
import 'package:gachadex/app/localization/app_localizations.dart';
import 'package:gachadex/app/router/app_router.dart';
import 'package:gachadex/app/theme/app_theme.dart';

Future<void> pumpGachadexApp(
  WidgetTester tester, {
  String? initialLocation,
}) async {
  if (initialLocation != null) {
    final router = createAppRouter(initialLocation: initialLocation);
    addTearDown(router.dispose);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [appRouterProvider.overrideWithValue(router)],
        child: const GachadexApp(),
      ),
    );
  } else {
    await tester.pumpWidget(const ProviderScope(child: GachadexApp()));
  }

  await tester.pumpAndSettle();
}

Future<void> pumpLocalizedWidget(
  WidgetTester tester,
  Widget child, {
  bool settle = true,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('es'),
      home: Scaffold(body: child),
    ),
  );
  if (settle) {
    await tester.pumpAndSettle();
  } else {
    await tester.pump();
  }
}

Finder navigationLabel(String label) {
  return find.descendant(
    of: find.byType(NavigationBar),
    matching: find.text(label),
  );
}
