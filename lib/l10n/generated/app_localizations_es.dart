// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Gachadex';

  @override
  String get home => 'Inicio';

  @override
  String get collections => 'Colecciones';

  @override
  String get create => 'Crear';

  @override
  String get settings => 'Ajustes';

  @override
  String get theme => 'Tema';

  @override
  String get system => 'Sistema';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Oscuro';

  @override
  String get retry => 'Reintentar';

  @override
  String get screenErrorTitle => 'No se ha podido mostrar esta pantalla.';

  @override
  String get noCollections => 'Todavía no hay colecciones.';

  @override
  String get comingSoon => 'Próximamente';

  @override
  String get homePackMessage => 'Aquí aparecerán los sobres disponibles.';

  @override
  String get collectionsEmptyDescription =>
      'Aquí aparecerán las colecciones instaladas y los proyectos creados.';

  @override
  String get createDescription =>
      'Aquí se crearán colecciones cuando la fase de creador esté lista.';

  @override
  String get controlledError => 'Error controlado';

  @override
  String get controlledErrorDescription =>
      'Esta pantalla comprueba que los errores se muestran con un mensaje seguro.';

  @override
  String get openControlledError => 'Ver error controlado';

  @override
  String get openControlledErrorTooltip =>
      'Abre la pantalla de error controlado';

  @override
  String get notFoundTitle => 'Página no encontrada';

  @override
  String get notFoundDescription => 'La ruta solicitada no existe en Gachadex.';

  @override
  String get loading => 'Cargando';

  @override
  String get appInfo => 'Información de la aplicación';

  @override
  String get phaseOneStatus => 'Fase 1: base técnica ejecutable.';

  @override
  String get themeSessionOnly =>
      'La preferencia de tema se mantiene durante la sesión. La persistencia llegará cuando exista infraestructura local.';

  @override
  String get createDisabledAction => 'Crear colección';
}
