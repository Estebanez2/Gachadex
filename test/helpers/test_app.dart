import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gachadex/app/app.dart';
import 'package:gachadex/app/localization/app_localizations.dart';
import 'package:gachadex/app/router/app_router.dart';
import 'package:gachadex/app/theme/app_theme.dart';
import 'package:gachadex/core/database/database_providers.dart';

import 'database_test_utils.dart';

Future<void> pumpGachadexApp(
  WidgetTester tester, {
  String? initialLocation,
  List<dynamic> overrides = const [],
}) async {
  final effectiveOverrides = [...overrides];
  if (overrides.isEmpty) {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
    final database = createInMemoryDatabase();
    effectiveOverrides.add(appDatabaseProvider.overrideWithValue(database));
  }

  if (initialLocation != null) {
    final router = createAppRouter(initialLocation: initialLocation);
    addTearDown(router.dispose);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          ...effectiveOverrides,
          appRouterProvider.overrideWithValue(router),
        ],
        child: const GachadexApp(),
      ),
    );
  } else {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [...effectiveOverrides],
        child: const GachadexApp(),
      ),
    );
  }

  await tester.pump();
  await tester.pump(const Duration(milliseconds: 350));
}

Future<void> disposeGachadexApp(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump(const Duration(milliseconds: 1));
  await tester.pump(const Duration(milliseconds: 1));
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
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
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
