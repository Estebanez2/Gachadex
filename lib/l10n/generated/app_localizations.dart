import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('es')];

  /// Nombre visible de la aplicacion.
  ///
  /// In es, this message translates to:
  /// **'Gachadex'**
  String get appTitle;

  /// Etiqueta de la seccion principal.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get home;

  /// Etiqueta de la seccion de colecciones.
  ///
  /// In es, this message translates to:
  /// **'Colecciones'**
  String get collections;

  /// Etiqueta de la seccion de creacion.
  ///
  /// In es, this message translates to:
  /// **'Crear'**
  String get create;

  /// Etiqueta de la seccion de ajustes.
  ///
  /// In es, this message translates to:
  /// **'Ajustes'**
  String get settings;

  /// Titulo del selector de tema.
  ///
  /// In es, this message translates to:
  /// **'Tema'**
  String get theme;

  /// Opcion para usar el tema del sistema.
  ///
  /// In es, this message translates to:
  /// **'Sistema'**
  String get system;

  /// Opcion para usar tema claro.
  ///
  /// In es, this message translates to:
  /// **'Claro'**
  String get light;

  /// Opcion para usar tema oscuro.
  ///
  /// In es, this message translates to:
  /// **'Oscuro'**
  String get dark;

  /// Etiqueta de accion para volver a intentar una operacion.
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get retry;

  /// Titulo seguro para errores de presentacion.
  ///
  /// In es, this message translates to:
  /// **'No se ha podido mostrar esta pantalla.'**
  String get screenErrorTitle;

  /// Estado vacio de la pantalla Colecciones.
  ///
  /// In es, this message translates to:
  /// **'Todavía no hay colecciones.'**
  String get noCollections;

  /// Etiqueta para funciones aun no disponibles.
  ///
  /// In es, this message translates to:
  /// **'Próximamente'**
  String get comingSoon;

  /// Mensaje provisional de la pantalla Inicio.
  ///
  /// In es, this message translates to:
  /// **'Aquí aparecerán los sobres disponibles.'**
  String get homePackMessage;

  /// Descripcion del estado vacio de colecciones.
  ///
  /// In es, this message translates to:
  /// **'Aquí aparecerán las colecciones instaladas y los proyectos creados.'**
  String get collectionsEmptyDescription;

  /// Descripcion provisional de la pantalla Crear.
  ///
  /// In es, this message translates to:
  /// **'Aquí se crearán colecciones cuando la fase de creador esté lista.'**
  String get createDescription;

  /// Titulo de la pantalla de error controlado.
  ///
  /// In es, this message translates to:
  /// **'Error controlado'**
  String get controlledError;

  /// Descripcion segura del error controlado.
  ///
  /// In es, this message translates to:
  /// **'Esta pantalla comprueba que los errores se muestran con un mensaje seguro.'**
  String get controlledErrorDescription;

  /// Boton para abrir la ruta de error controlado.
  ///
  /// In es, this message translates to:
  /// **'Ver error controlado'**
  String get openControlledError;

  /// Tooltip del boton que abre el error controlado.
  ///
  /// In es, this message translates to:
  /// **'Abre la pantalla de error controlado'**
  String get openControlledErrorTooltip;

  /// Titulo para rutas desconocidas.
  ///
  /// In es, this message translates to:
  /// **'Página no encontrada'**
  String get notFoundTitle;

  /// Descripcion segura de pagina no encontrada.
  ///
  /// In es, this message translates to:
  /// **'La ruta solicitada no existe en Gachadex.'**
  String get notFoundDescription;

  /// Etiqueta accesible del estado de carga.
  ///
  /// In es, this message translates to:
  /// **'Cargando'**
  String get loading;

  /// Titulo de la informacion basica de la app.
  ///
  /// In es, this message translates to:
  /// **'Información de la aplicación'**
  String get appInfo;

  /// Estado actual del proyecto.
  ///
  /// In es, this message translates to:
  /// **'Fase 1: base técnica ejecutable.'**
  String get phaseOneStatus;

  /// Nota sobre la persistencia futura del tema.
  ///
  /// In es, this message translates to:
  /// **'La preferencia de tema se mantiene durante la sesión. La persistencia llegará cuando exista infraestructura local.'**
  String get themeSessionOnly;

  /// Boton deshabilitado de creacion futura.
  ///
  /// In es, this message translates to:
  /// **'Crear colección'**
  String get createDisabledAction;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
