# Dependencias

Fecha: 2026-08-11

Este documento registra las dependencias directas del proyecto tras la Fase 13.
Las Fases 12 y 13 no anadieron dependencias directas.

## Dependencias directas actuales

| Dependencia | Version | Tipo | Funcion | Licencia | Compatibilidad | Motivo | Fase | Riesgos |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Flutter SDK | 3.44.8 stable | SDK | Framework movil multiplataforma | BSD-3-Clause | Android e iOS | Base de la aplicacion | Base | Mantenerse en canal estable |
| Dart SDK | 3.12.2 stable | SDK | Lenguaje y herramientas | BSD-3-Clause | Android e iOS via Flutter | Incluido con Flutter | Base | Seguir restricciones del SDK Flutter |
| `flutter` | SDK | Produccion | Widgets, Material 3 y runtime Flutter | BSD-3-Clause | Android e iOS | Dependencia principal | Base | Ninguno especifico |
| `flutter_localizations` | SDK | Produccion | Delegates oficiales de localizacion | BSD-3-Clause | Android e iOS | Material/Cupertino/Widgets en espanol | Fase 1 | Pin de `intl` impuesto por SDK |
| `flutter_local_notifications` | `^22.2.0`, resuelto 22.3.0 | Produccion | Notificaciones locales programadas | BSD-3-Clause | Android e iOS | Avisar cuando un sobre vuelve a estar disponible sin servidor | Fase 11 | Android requiere permisos/receivers y algunos fabricantes limitan alarmas en segundo plano; iOS conserva hasta 64 pendientes |
| `flutter_riverpod` | `^3.4.2`, resuelto 3.4.2 | Produccion | Estado e inyeccion | MIT | Android e iOS | Providers de router, tema, base y repositorios | Fase 1 | Cambios de API mayores en futuras versiones |
| `go_router` | `^17.4.0`, resuelto 17.4.0 | Produccion | Navegacion declarativa | BSD-3-Clause | Android e iOS | Rutas centralizadas y shell de tabs | Fase 1 | Paquete feature-complete; vigilar cambios de estabilidad |
| `intl` | `^0.20.2`, resuelto 0.20.2 | Produccion | Soporte de gen-l10n | BSD-3-Clause | Android e iOS | Codigo generado por Flutter importa `intl` | Fase 1 | 0.20.3 existe, pero Flutter 3.44.8 fija 0.20.2 |
| `image_picker` | `^1.2.3`, resuelto 1.2.3 | Produccion | Selector de imagenes de galeria | Apache-2.0/BSD-3-Clause | Android e iOS | Elegir fotografia para cartas sin permisos amplios de almacenamiento | Fase 4 | En Android/iOS los archivos elegidos son temporales y se copian a almacenamiento privado |
| `image_cropper` | `^12.2.1`, resuelto 12.2.1 | Produccion | Recorte nativo de fotografias | BSD-3-Clause | Android e iOS | Ajustar la foto a la proporcion fija de las plantillas | Fase 4 | Requiere declarar `UCropActivity` en Android |
| `flutter_image_compress` | `^2.5.1`, resuelto 2.5.1 | Produccion | Compresion/conversion WebP | MIT | Android e iOS | Crear imagen principal WebP y miniatura WebP | Fase 4 | El soporte WebP depende de implementaciones nativas; mantener pruebas manuales en Android/iOS |
| `video_player` | `^2.13.0`, resuelto 2.13.0 | Produccion | Reproduccion de video local | BSD-3-Clause | Android e iOS | Reproducir MP4 de cartas en apertura y album sin controllers en grids | Fase 8 | Soporte de codec depende de ExoPlayer/AVPlayer; usar MP4 H.264/AAC |
| `video_compress` | `^3.1.4`, resuelto 3.1.4 | Produccion | Metadatos, compresion MP4 y thumbnail de video | MIT | Android e iOS | Normalizar videos cortos sin anadir FFmpeg completo y generar primer fotograma | Fase 8 | Plugin nativo no oficial; probar en Android/iOS y vigilar mantenimiento |
| `archive` | `^4.0.9`, resuelto 4.0.9 | Produccion | Crear y leer contenedores ZIP `.gachadex` | MIT | Android e iOS | Exportar/importar colecciones offline con archivos JSON y multimedia | Fase 9 | Validar rutas, tamanos y hashes antes de extraer |
| `crypto` | `^3.0.7`, resuelto 3.0.7 | Produccion | SHA-256 | BSD-3-Clause | Android e iOS | Verificar integridad de metadatos y activos del paquete `.gachadex` | Fase 9 | Hashes detectan corrupcion, no prueban autoria |
| `timezone` | `^0.11.1`, resuelto 0.11.1 | Produccion | Fechas programadas con zona horaria para notificaciones | BSD-3-Clause | Android e iOS | `zonedSchedule` del plugin requiere instantes timezone-aware | Fase 11 | La app programa en UTC para evitar ambiguedades locales |
| `file_selector` | `^1.1.0`, resuelto 1.1.0 | Produccion | Selector nativo de archivos | BSD-3-Clause | Android e iOS | Elegir paquetes `.gachadex` recibidos sin servidor ni Internet | Fase 9 | Los filtros nativos varian por plataforma; se valida tambien la extension en codigo |
| `share_plus` | `^13.3.0`, resuelto 13.3.0 | Produccion | Comparticion nativa | BSD-3-Clause | Android e iOS | Abrir el menu del sistema para compartir el paquete exportado | Fase 9 | El resultado de compartir depende de cada sistema y app destino |
| `drift` | `^2.34.3`, resuelto 2.34.3 | Produccion | ORM/SQL tipado sobre SQLite | MIT | Android e iOS | Esquema local, DAOs, streams y transacciones | Fase 2 | Requiere codigo generado actualizado |
| `drift_flutter` | `^0.3.1`, resuelto 0.3.1 | Produccion | Conexion Flutter para Drift | MIT | Android e iOS | Base privada con `path_provider` e isolate de SQLite | Fase 2 | Usa dependencias nativas transitivas de SQLite |
| `path_provider` | `^2.1.6`, resuelto 2.1.6 | Produccion | Directorios privados de app | BSD-3-Clause | Android e iOS | Ubicar `gachadex.sqlite` sin permisos de almacenamiento publico | Fase 2 | Diferencias de rutas por plataforma |
| `path` | `^1.9.1`, resuelto 1.9.1 | Produccion | Manipulacion de rutas | BSD-3-Clause | Android e iOS | Validar rutas multimedia relativas normalizadas | Fase 2 | No sustituye validaciones de seguridad propias |
| `uuid` | `^4.6.0`, resuelto 4.6.0 | Produccion | UUID v4 | MIT | Android e iOS | IDs permanentes tipados e inyectables | Fase 2 | Evitar usar UUID como sustituto de reglas de integridad |
| `flutter_test` | SDK | Desarrollo | Pruebas de widgets y helpers | BSD-3-Clause | No aplica directamente | Suite de arranque, dominio, DB y repositorios | Base | Ninguno especifico |
| `flutter_lints` | `^6.0.0`, resuelto 6.0.0 | Desarrollo | Reglas recomendadas de analisis | BSD-3-Clause | No aplica directamente | Calidad base del codigo | Base | Nuevas reglas pueden exigir ajustes |
| `build_runner` | `2.15.1`, resuelto 2.15.1 | Desarrollo | Ejecucion de generadores | BSD-3-Clause | No aplica directamente | Generar `app_database.g.dart` | Fase 2 | Fijado por compatibilidad con `flutter_test`/`meta`; la opcion `--delete-conflicting-outputs` avisa que fue retirada |
| `drift_dev` | `2.34.0`, resuelto 2.34.0 | Desarrollo | Generador Drift | MIT | No aplica directamente | Generar tablas, companions y DAOs | Fase 2 | Fijado porque 2.34.5 exige `analyzer` incompatible con Flutter 3.44.8 |
| `sqlite3` | `^3.5.1`, resuelto 3.5.1 | Desarrollo | Preparar bases SQLite antiguas en tests | MIT | Android, iOS, desktop y web; en Gachadex se usa solo en tests | Crear una base v4 real para probar migraciones Drift | Fase 10 | Mantenerlo como dependencia de desarrollo; el runtime usa Drift/`drift_flutter` |

## Transitivas relevantes

- `sqlite3` 3.5.1 tambien llega como transitiva de Drift, pero se declara
  directa de desarrollo porque los tests de migracion preparan bases antiguas
  con SQLite crudo.
- `sqlite3_flutter_libs` 0.6.0+eol llega como transitiva de `drift_flutter`;
  no se anadio directa porque Drift actual la resuelve.
- `sqlcipher_flutter_libs` 0.7.0+eol llega transitoriamente por el arbol de
  SQLite; Gachadex no cifra la base en la version actual.
- `cross_file`, `flutter_plugin_android_lifecycle`, `html`, `csslib` y `http`
  llegan por los plugins de imagen/video.
- `file_selector_android`, `file_selector_ios`, `file_selector_web`,
  `share_plus_platform_interface`, `url_launcher_*`, `posix` y `win32` llegan
  por la seleccion de archivos, la comparticion y el empaquetado ZIP.
- `flutter_local_notifications_*`, `dbus`, `xml` y `petitparser` llegan por
  el plugin de notificaciones locales y sus implementaciones por plataforma.

Las transitivas estan fijadas en `pubspec.lock`. Pasaran a directas solo si el
codigo del proyecto las importa explicitamente.

## Avisos de compilacion

El build Android puede mostrar avisos del plugin Gradle de Kotlin aplicados por
dependencias transitivas de multimedia, especialmente
`flutter_image_compress_common` y `video_compress`. En Fase 13 no bloquean
`flutter analyze`, `flutter test` ni las compilaciones Android verificadas; se
deben revisar al actualizar Flutter, Gradle o esos plugins.

## Revision previa a la incorporacion

- `drift` 2.34.3: paquete mantenido, licencia MIT, compatible con Flutter y
  SQLite; resuelve esquema tipado, streams y transacciones.
- `drift_flutter` 0.3.1: helper mantenido para abrir bases Drift en Flutter;
  usa directorios privados y evita hardcodear rutas.
- `path_provider` 2.1.6: plugin oficial Flutter, licencia BSD-3-Clause,
  compatible con Android e iOS.
- `path` 1.9.1: paquete Dart oficial, licencia BSD-3-Clause, suficiente para
  normalizar rutas POSIX guardadas.
- `uuid` 4.6.0: paquete mantenido, licencia MIT, genera UUID v4.
- `image_picker` 1.2.3: plugin publicado por `flutter.dev`, mantenido y
  compatible con Android/iOS. En Android usa el Photo Picker moderno cuando
  esta disponible; en iOS requiere `NSPhotoLibraryUsageDescription`. Tambien se
  usa para seleccionar videos desde galeria.
- `image_cropper` 12.2.1: plugin mantenido para Android/iOS/Web basado en
  recorte nativo. En Android se declaro `UCropActivity`; iOS no requiere
  configuracion adicional propia del plugin.
- `flutter_image_compress` 2.5.1: plugin mantenido para compresion nativa y
  salida WebP en Android/iOS. Se usa solo para imagenes, no para video.
- `video_player` 2.13.0: plugin oficial de `flutter.dev`, licencia
  BSD-3-Clause, publicado recientemente y compatible con Android/iOS. Se usa
  solo con archivos locales, por lo que no requiere permiso de Internet.
- `video_compress` 3.1.4: plugin MIT con soporte Android/iOS para metadatos,
  compresion MP4 y thumbnail. Se eligio frente a FFmpeg completo por menor peso
  y licencia permisiva; el riesgo principal es su mantenimiento menos oficial.
- `archive` 4.0.9: libreria MIT mantenida para ZIP y otros contenedores,
  compatible con Dart/Flutter. Se usa con encoder de archivo para anadir
  ficheros uno a uno y con validaciones propias de rutas y tamanos.
- `crypto` 3.0.7: paquete publicado por `dart.dev`, licencia BSD-3-Clause,
  compatible con Flutter. Se usa solo para SHA-256 de JSON y activos.
- `file_selector` 1.1.0: plugin publicado por `flutter.dev`, licencia
  BSD-3-Clause, soporta Android SDK 21+ e iOS 12+. Se eligio frente a
  `file_picker` porque `file_picker` resolvio a 3.0.4 con el grafo actual.
- `share_plus` 13.3.0: plugin mantenido por Flutter Community, licencia
  BSD-3-Clause, usa las hojas nativas de compartir en Android e iOS.
- `flutter_local_notifications` 22.3.0: plugin BSD-3-Clause mantenido para
  notificaciones locales en Android/iOS. Se usa con `zonedSchedule`, permisos
  nativos y alarmas inexactas para evitar permisos de alarma exacta.
- `timezone` 0.11.1: paquete BSD-3-Clause mantenido con base IANA; necesario
  para programar con la API zoned del plugin. Gachadex usa UTC para los avisos.
- `build_runner` y `drift_dev`: versiones fijadas por compatibilidad real con
  Flutter 3.44.8, `flutter_test`, `meta` y `analyzer`.
- `sqlite3` 3.5.1: paquete MIT mantenido por el autor de Drift, compatible con
  las plataformas del proyecto. Se usa solo en tests para construir una base
  antigua y comprobar migraciones sin exponer APIs SQLite a la aplicacion.

## Dependencias fuera de alcance

No incorporar todavia:

- Plugins de camara personalizada, galeria avanzada, archivos generales o
  editor de video avanzado.
- Firebase, Supabase o cualquier servicio online.

## Fuentes revisadas

- https://pub.dev/packages/flutter_riverpod
- https://pub.dev/packages/go_router
- https://pub.dev/packages/intl
- https://pub.dev/packages/image_picker
- https://pub.dev/packages/image_cropper
- https://pub.dev/packages/flutter_image_compress
- https://pub.dev/packages/video_player
- https://pub.dev/packages/video_compress
- https://pub.dev/packages/archive
- https://pub.dev/packages/crypto
- https://pub.dev/packages/file_selector
- https://pub.dev/packages/share_plus
- https://pub.dev/packages/flutter_local_notifications
- https://pub.dev/packages/timezone
- https://pub.dev/packages/drift
- https://pub.dev/packages/drift_flutter
- https://pub.dev/packages/path_provider
- https://pub.dev/packages/path
- https://pub.dev/packages/uuid
- https://pub.dev/packages/build_runner
- https://pub.dev/packages/drift_dev
- https://pub.dev/packages/sqlite3
- https://docs.flutter.dev/ui/internationalization
