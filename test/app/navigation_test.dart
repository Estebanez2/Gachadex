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

      await tester.tap(navigationLabel('Colecciones'));
      await _pumpUntilText(tester, 'Todavía no hay colecciones.');
      expect(find.text('Todavía no hay colecciones.'), findsOneWidget);
      expect(_selectedIndex(tester), 1);

      await tester.tap(navigationLabel('Crear'));
      await _pumpUntilText(tester, 'Todavía no has creado ninguna colección');
      expect(
        find.text('Todavía no has creado ninguna colección'),
        findsOneWidget,
      );
      expect(_selectedIndex(tester), 2);

      await tester.tap(navigationLabel('Ajustes'));
      await _pumpUntilText(tester, 'Información de la aplicación');
      expect(find.text('Información de la aplicación'), findsOneWidget);
      expect(_selectedIndex(tester), 3);

      await tester.tap(navigationLabel('Inicio'));
      await _pumpUntilText(tester, 'Aquí aparecerán los sobres disponibles.');
      expect(
        find.text('Aquí aparecerán los sobres disponibles.'),
        findsOneWidget,
      );
      expect(_selectedIndex(tester), 0);
    } finally {
      await disposeGachadexApp(tester);
    }
  });

  testWidgets('controlled error route displays AppErrorView safely', (
    tester,
  ) async {
    await pumpGachadexApp(tester);

    await tester.tap(find.text('Ver error controlado'));
    await _pumpUntilText(tester, 'No se ha podido mostrar esta pantalla.');

    expect(find.byType(AppErrorView), findsOneWidget);
    expect(find.text('No se ha podido mostrar esta pantalla.'), findsOneWidget);
    expect(
      find.text(
        'Esta pantalla comprueba que los errores se muestran con un mensaje seguro.',
      ),
      findsOneWidget,
    );
    expect(find.text('Reintentar'), findsOneWidget);
  });

  testWidgets('unknown routes display the not found error state', (
    tester,
  ) async {
    await pumpGachadexApp(tester, initialLocation: '/ruta-inexistente');

    expect(find.byType(AppErrorView), findsOneWidget);
    expect(find.text('Página no encontrada'), findsOneWidget);
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
