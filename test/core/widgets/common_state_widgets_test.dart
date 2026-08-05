import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gachadex/core/widgets/app_empty_view.dart';
import 'package:gachadex/core/widgets/app_error_view.dart';
import 'package:gachadex/core/widgets/app_loading_view.dart';

import '../../helpers/test_app.dart';

void main() {
  testWidgets('AppEmptyView shows title and description', (tester) async {
    await pumpLocalizedWidget(
      tester,
      const AppEmptyView(
        icon: Icons.inbox_outlined,
        title: 'Sin elementos',
        description: 'No hay contenido para mostrar.',
      ),
    );

    expect(find.text('Sin elementos'), findsOneWidget);
    expect(find.text('No hay contenido para mostrar.'), findsOneWidget);
  });

  testWidgets('AppErrorView shows retry action when provided', (tester) async {
    var retryTapped = false;

    await pumpLocalizedWidget(
      tester,
      AppErrorView(
        title: 'Error',
        description: 'Mensaje seguro.',
        onRetry: () {
          retryTapped = true;
        },
      ),
    );

    await tester.tap(find.text('Reintentar'));
    await tester.pump();

    expect(find.text('Error'), findsOneWidget);
    expect(find.text('Mensaje seguro.'), findsOneWidget);
    expect(retryTapped, isTrue);
  });

  testWidgets('AppLoadingView shows progress indicator', (tester) async {
    await pumpLocalizedWidget(tester, const AppLoadingView(), settle: false);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
