import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_app.dart';

void main() {
  testWidgets('navigation destinations expose accessible labels', (
    tester,
  ) async {
    final semanticsHandle = tester.ensureSemantics();

    try {
      await pumpGachadexApp(tester);

      expect(_semanticsLabel(tester, 'Inicio'), contains('Inicio'));
      expect(_semanticsLabel(tester, 'Colecciones'), contains('Colecciones'));
      expect(_semanticsLabel(tester, 'Crear'), contains('Crear'));
      expect(_semanticsLabel(tester, 'Ajustes'), contains('Ajustes'));
      expect(
        find.byTooltip('Abre la pantalla de error controlado'),
        findsOneWidget,
      );
    } finally {
      semanticsHandle.dispose();
    }
  });

  testWidgets('main pages tolerate elevated text scale on a mobile viewport', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    tester.platformDispatcher.textScaleFactorTestValue = 1.8;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    await pumpGachadexApp(tester);

    try {
      await tester.tap(navigationLabel('Colecciones'));
      await _pumpNavigation(tester);
      await tester.tap(navigationLabel('Crear'));
      await _pumpNavigation(tester);
      await tester.tap(navigationLabel('Ajustes'));
      await _pumpNavigation(tester);

      expect(tester.takeException(), isNull);
    } finally {
      await disposeGachadexApp(tester);
    }
  });
}

String _semanticsLabel(WidgetTester tester, String label) {
  return tester.getSemantics(navigationLabel(label)).getSemanticsData().label;
}

Future<void> _pumpNavigation(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 350));
}
