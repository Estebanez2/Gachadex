import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gachadex/core/widgets/app_error_view.dart';

import '../helpers/test_app.dart';

void main() {
  testWidgets('main tabs navigate and update the active destination', (
    tester,
  ) async {
    await pumpGachadexApp(tester);

    try {
      expect(_selectedIndex(tester), 0);
      expect(navigationLabel('Colecciones'), findsNothing);
      expect(find.text('Ver error controlado'), findsNothing);

      await tester.tap(navigationLabel('\u00c1lbum'));
      await _pumpUntilTextContaining(tester, 'ninguna colecci');
      expect(find.textContaining('ninguna colecci'), findsOneWidget);
      expect(_selectedIndex(tester), 1);

      await tester.tap(navigationLabel('Crear'));
      await _pumpUntilTextContaining(tester, 'has creado ninguna colecci');
      expect(find.textContaining('has creado ninguna colecci'), findsOneWidget);
      expect(_selectedIndex(tester), 2);

      await tester.tap(navigationLabel('Ajustes'));
      await _pumpUntilTextContaining(tester, 'Informaci');
      expect(find.textContaining('Informaci'), findsWidgets);
      expect(_selectedIndex(tester), 3);

      await tester.tap(navigationLabel('Inicio'));
      await _pumpUntilText(tester, 'Sobres disponibles');
      expect(find.text('Sobres disponibles'), findsOneWidget);
      expect(_selectedIndex(tester), 0);
    } finally {
      await disposeGachadexApp(tester);
    }
  });

  testWidgets('controlled error is not exposed in normal navigation', (
    tester,
  ) async {
    await pumpGachadexApp(tester);

    expect(find.text('Error controlado'), findsNothing);
    expect(find.text('Ver error controlado'), findsNothing);
  });

  testWidgets('unknown routes display the not found error state', (
    tester,
  ) async {
    await pumpGachadexApp(tester, initialLocation: '/ruta-inexistente');

    expect(find.byType(AppErrorView), findsOneWidget);
    expect(find.textContaining('gina no encontrada'), findsOneWidget);
    expect(
      find.text('La ruta solicitada no existe en Gachadex.'),
      findsOneWidget,
    );
  });
}

int _selectedIndex(WidgetTester tester) {
  final navigationBar = tester.widget<NavigationBar>(
    find.byType(NavigationBar),
  );
  return navigationBar.selectedIndex;
}

Future<void> _pumpUntilText(WidgetTester tester, String text) async {
  for (var attempt = 0; attempt < 20; attempt += 1) {
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    if (find.text(text).evaluate().isNotEmpty) {
      return;
    }
  }
}

Future<void> _pumpUntilTextContaining(WidgetTester tester, String text) async {
  for (var attempt = 0; attempt < 20; attempt += 1) {
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    if (find.textContaining(text).evaluate().isNotEmpty) {
      return;
    }
  }
}
