import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_app.dart';

void main() {
  testWidgets('theme starts in system mode', (tester) async {
    await pumpGachadexApp(tester);

    expect(_materialApp(tester).themeMode, ThemeMode.system);
  });

  testWidgets('theme can switch without leaving Ajustes', (tester) async {
    await pumpGachadexApp(tester);

    await tester.tap(navigationLabel('Ajustes'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Claro'));
    await tester.pumpAndSettle();
    expect(_materialApp(tester).themeMode, ThemeMode.light);
    expect(find.text('Información de la aplicación'), findsOneWidget);

    await tester.tap(find.text('Oscuro'));
    await tester.pumpAndSettle();
    expect(_materialApp(tester).themeMode, ThemeMode.dark);
    expect(find.text('Información de la aplicación'), findsOneWidget);

    await tester.tap(find.text('Sistema'));
    await tester.pumpAndSettle();
    expect(_materialApp(tester).themeMode, ThemeMode.system);
    expect(find.text('Información de la aplicación'), findsOneWidget);
  });
}

MaterialApp _materialApp(WidgetTester tester) {
  return tester.widget<MaterialApp>(find.byType(MaterialApp));
}
