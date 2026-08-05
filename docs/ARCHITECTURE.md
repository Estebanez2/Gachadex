# Arquitectura

Fecha: 2026-08-05

Este documento describe el estado técnico tras la Fase 1: fundación Flutter ejecutable. La fuente funcional sigue siendo `docs/PRODUCT_SPEC.md`; esta fase no implementa todavía colecciones, cartas, sobres, probabilidades, temporizadores, monedas, multimedia, base de datos, importación ni exportación.

## Principios

- La aplicación funciona localmente y sin conexión.
- No hay cuentas, servidor, Firebase, Supabase ni servicios equivalentes.
- No se usan nombres, logotipos, marcos, recursos ni patrones visuales oficiales de Pokémon.
- Los textos visibles se preparan para internacionalización y arrancan en español.
- No se crean modelos de producto ni datos falsos que parezcan persistentes.
- No se añaden capas vacías, repositorios falsos ni casos de uso sin lógica.

## Estructura creada

```text
lib/
  main.dart

  app/
    app.dart
    localization/
      app_localizations.dart
    observers/
      app_provider_observer.dart
    router/
      app_router.dart
      app_routes.dart
    theme/
      app_theme.dart
      app_theme_mode.dart
      theme_controller.dart

  core/
    constants/
      app_constants.dart
    errors/
      app_exception.dart
      app_failure.dart
      error_mapper.dart
    logging/
      app_logger.dart
    widgets/
      app_empty_view.dart
      app_error_view.dart
      app_loading_view.dart
      app_scaffold.dart
      placeholder_feature_page.dart

  features/
    collections/
      presentation/
        collections_page.dart
    controlled_error/
      presentation/
        controlled_error_page.dart
    creator/
      presentation/
        creator_page.dart
    home/
      presentation/
        home_page.dart
    settings/
      presentation/
        settings_page.dart

  l10n/
    app_es.arb
    generated/
      app_localizations.dart
      app_localizations_es.dart
```

```text
test/
  app/
  core/
    widgets/
  helpers/
```

La organización es feature-first en presentación, con `app/` para composición global y `core/` para infraestructura compartida mínima. Las carpetas `data/`, `domain/` y `application/` se crearán solo cuando haya reglas o persistencia reales.

## Punto de entrada

`lib/main.dart` solo:

1. Inicializa Flutter con `WidgetsFlutterBinding.ensureInitialized()`.
2. Crea un `ProviderScope`.
3. Registra `AppProviderObserver`.
4. Arranca `GachadexApp`.

No hay variables globales mutables ni inicializaciones ficticias de base de datos, archivos o notificaciones.

## Riverpod

Riverpod se usa para:

- Gestionar `ThemeMode` durante la sesión mediante `themeControllerProvider`.
- Exponer `appRouterProvider` como dependencia reemplazable en tests.
- Observar creación, actualización y errores de providers con `AppProviderObserver`.

El observer solo registra en debug, no registra valores de providers, rutas de archivos, contenido multimedia, secretos ni datos personales. Todo logging pasa por `AppLogger`.

La preferencia de tema no se persiste todavía. Se documenta explícitamente como pendiente hasta que exista infraestructura local.

## Navegación

GoRouter define rutas centralizadas en `AppRoutes`:

- `/` redirige a `/home`.
- `/home` muestra Inicio.
- `/collections` muestra Colecciones.
- `/create` muestra Crear.
- `/settings` muestra Ajustes.
- `/controlled-error` muestra una pantalla de error controlado.

La navegación principal usa `StatefulShellRoute.indexedStack` con cuatro ramas y `NavigationBar` de Material 3. El shell común vive en `AppScaffold` y conserva el estado de las ramas al cambiar de pestaña cuando GoRouter puede hacerlo.

Las rutas desconocidas usan `errorBuilder` y muestran `AppErrorView` con un mensaje seguro, sin detalles técnicos.

## Tema visual

`AppTheme` configura Material 3 con tema claro y oscuro, color scheme propio basado en verde teal y acentos coral/ámbar apagado. Se tematizan:

- `AppBar`.
- `NavigationBar`.
- `Card`.
- `FilledButton`.
- `OutlinedButton`.
- `InputDecoration`.
- `Dialog`.
- `SnackBar`.
- `BottomSheet`.
- `Divider`.

La identidad visual evita amarillo/azul como copia directa de Pokémon, pokéballs, tipografías Pokémon, marcos de TCG y recursos de otras marcas.

## Internacionalización

La app usa el flujo oficial de Flutter:

- `flutter_localizations`.
- `intl` compatible con el pin del SDK.
- `flutter gen-l10n`.
- `lib/l10n/app_es.arb`.
- Código generado versionado en `lib/l10n/generated/`.

`GachadexApp` fija español como idioma inicial con `locale: Locale('es')`, declara `supportedLocales` desde `AppLocalizations` y usa delegates generados. Añadir otro idioma requerirá incorporar otro ARB, por ejemplo `app_en.arb`.

## Errores

La base mínima incluye:

- `AppException`: errores técnicos capturados con código y mensaje seguro opcional.
- `AppFailure`: errores presentables.
- `UnexpectedFailure`, `ValidationFailure`, `NavigationFailure`.
- `ErrorMapper`: conversión de errores conocidos a mensajes seguros.

La UI no muestra stack traces, rutas internas ni detalles técnicos.

## Logging

`AppLogger` encapsula `dart:developer` con niveles `debug`, `info`, `warning` y `error`.

- En debug registra eventos útiles de desarrollo.
- En release elimina logs no esenciales.
- Los stack traces solo se adjuntan en debug.
- No se registran datos personales, contenido multimedia, archivos completos ni secretos.

## Pantallas provisionales

- Inicio: mensaje de sobres futuros y botón a error controlado.
- Colecciones: estado vacío reutilizable.
- Crear: explicación breve y acción deshabilitada.
- Ajustes: selector de tema sistema/claro/oscuro e información básica.
- Error controlado: `AppErrorView` accesible sin cerrar la app.

Estas pantallas no crean sobres, colecciones, proyectos, cartas ni datos falsos.

## Accesibilidad y responsive básico

- `NavigationBar` mantiene etiquetas visibles.
- Acciones importantes tienen texto y tooltip cuando aporta valor.
- Los estados comunes usan textos centrados, ancho máximo y `Semantics` cuando corresponde.
- El contenido usa scroll y evita alturas fijas que corten texto escalado.
- Los tests cubren navegación con labels y una pasada con escala de texto elevada en viewport móvil.

## Límites de la fase

Queda fuera de esta Fase 1:

- Persistencia local, Drift, SQLite, migraciones y repositorios.
- UUID e identificadores de producto.
- Modelos de colecciones, cartas, rarezas, sobres o economía.
- Selección, procesamiento o reproducción multimedia.
- Importación/exportación `.friendpack`.
- Temporizadores, monedas y notificaciones.
- Cambios nativos innecesarios en Android/iOS.
