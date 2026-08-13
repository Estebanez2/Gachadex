import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gachadex/app/localization/app_localizations.dart';
import 'package:gachadex/features/home/presentation/home_page.dart';

import '../helpers/test_app.dart';

void main() {
  testWidgets('Spanish localizations are available and loaded', (tester) async {
    await pumpGachadexApp(tester);

    final context = tester.element(find.byType(HomePage));
    final locale = Localizations.localeOf(context);
    final l10n = AppLocalizations.of(context);

    expect(locale.languageCode, 'es');
    expect(l10n.appTitle, 'Gachadex');
    expect(find.text('Inicio'), findsWidgets);
    expect(find.text('\u00c1lbum'), findsWidgets);
    expect(find.text('Crear'), findsWidgets);
    expect(find.text('Ajustes'), findsWidgets);
  });
}
