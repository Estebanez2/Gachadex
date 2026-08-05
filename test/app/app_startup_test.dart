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
    expect(
      find.text('Aquí aparecerán los sobres disponibles.'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });
}
