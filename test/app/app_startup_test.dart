import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gachadex/app/app.dart';
import 'package:gachadex/features/home/presentation/home_page.dart';

import '../helpers/test_app.dart';

void main() {
  testWidgets('GachadexApp mounts on Inicio without exceptions', (
    tester,
  ) async {
    await pumpGachadexApp(tester);

    expect(find.byType(GachadexApp), findsOneWidget);
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.text('Inicio'), findsWidgets);
    await _pumpUntilText(tester, 'Sobres disponibles');
    expect(find.text('Sobres disponibles'), findsOneWidget);
    expect(find.text('No tienes sobres disponibles'), findsWidgets);
    expect(tester.takeException(), isNull);
  });
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
