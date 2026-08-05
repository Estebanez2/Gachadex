# Dependencias

Fecha: 2026-08-05

Este documento registra las dependencias directas del proyecto tras la Fase 2:
modelo de dominio y persistencia local.

## Dependencias directas actuales

| Dependencia | Version | Tipo | Funcion | Licencia | Compatibilidad | Motivo | Fase | Riesgos |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Flutter SDK | 3.44.8 stable | SDK | Framework movil multiplataforma | BSD-3-Clause | Android e iOS | Base de la aplicacion | Base | Mantenerse en canal estable |
| Dart SDK | 3.12.2 stable | SDK | Lenguaje y herramientas | BSD-3-Clause | Android e iOS via Flutter | Incluido con Flutter | Base | Seguir restricciones del SDK Flutter |
| `flutter` | SDK | Produccion | Widgets, Material 3 y runtime Flutter | BSD-3-Clause | Android e iOS | Dependencia principal | Base | Ninguno especifico |
| `flutter_localizations` | SDK | Produccion | Delegates oficiales de localizacion | BSD-3-Clause | Android e iOS | Material/Cupertino/Widgets en espanol | Fase 1 | Pin de `intl` impuesto por SDK |
| `flutter_riverpod` | `^3.4.2`, resuelto 3.4.2 | Produccion | Estado e inyeccion | MIT | Android e iOS | Providers de router, tema, base y repositorios | Fase 1 | Cambios de API mayores en futuras versiones |
| `go_router` | `^17.4.0`, resuelto 17.4.0 | Produccion | Navegacion declarativa | BSD-3-Clause | Android e iOS | Rutas centralizadas y shell de tabs | Fase 1 | Paquete feature-complete; vigilar cambios de estabilidad |
| `intl` | `^0.20.2`, resuelto 0.20.2 | Produccion | Soporte de gen-l10n | BSD-3-Clause | Android e iOS | Codigo generado por Flutter importa `intl` | Fase 1 | 0.20.3 existe, pero Flutter 3.44.8 fija 0.20.2 |
| `drift` | `^2.34.3`, resuelto 2.34.3 | Produccion | ORM/SQL tipado sobre SQLite | MIT | Android e iOS | Esquema local, DAOs, streams y transacciones | Fase 2 | Requiere codigo generado actualizado |
| `drift_flutter` | `^0.3.1`, resuelto 0.3.1 | Produccion | Conexion Flutter para Drift | MIT | Android e iOS | Base privada con `path_provider` e isolate de SQLite | Fase 2 | Usa dependencias nativas transitivas de SQLite |
| `path_provider` | `^2.1.6`, resuelto 2.1.6 | Produccion | Directorios privados de app | BSD-3-Clause | Android e iOS | Ubicar `gachadex.sqlite` sin permisos de almacenamiento publico | Fase 2 | Diferencias de rutas por plataforma |
| `path` | `^1.9.1`, resuelto 1.9.1 | Produccion | Manipulacion de rutas | BSD-3-Clause | Android e iOS | Validar rutas multimedia relativas normalizadas | Fase 2 | No sustituye validaciones de seguridad propias |
| `uuid` | `^4.6.0`, resuelto 4.6.0 | Produccion | UUID v4 | MIT | Android e iOS | IDs permanentes tipados e inyectables | Fase 2 | Evitar usar UUID como sustituto de reglas de integridad |
| `flutter_test` | SDK | Desarrollo | Pruebas de widgets y helpers | BSD-3-Clause | No aplica directamente | Suite de arranque, dominio, DB y repositorios | Base | Ninguno especifico |
| `flutter_lints` | `^6.0.0`, resuelto 6.0.0 | Desarrollo | Reglas recomendadas de analisis | BSD-3-Clause | No aplica directamente | Calidad base del codigo | Base | Nuevas reglas pueden exigir ajustes |
| `build_runner` | `2.15.1`, resuelto 2.15.1 | Desarrollo | Ejecucion de generadores | BSD-3-Clause | No aplica directamente | Generar `app_database.g.dart` | Fase 2 | Fijado por compatibilidad con `flutter_test`/`meta`; la opcion `--delete-conflicting-outputs` avisa que fue retirada |
| `drift_dev` | `2.34.0`, resuelto 2.34.0 | Desarrollo | Generador Drift | MIT | No aplica directamente | Generar tablas, companions y DAOs | Fase 2 | Fijado porque 2.34.5 exige `analyzer` incompatible con Flutter 3.44.8 |

## Transitivas relevantes

- `sqlite3` 3.5.1 llega como transitiva de Drift y se usa para SQLite local y
  tests en memoria.
- `sqlite3_flutter_libs` 0.6.0+eol llega como transitiva de `drift_flutter`;
  no se anadio directa porque Drift actual la resuelve.
- `sqlcipher_flutter_libs` 0.7.0+eol llega transitoriamente por el arbol de
  SQLite; Gachadex no cifra la base en Fase 2.

Las transitivas estan fijadas en `pubspec.lock`. Pasaran a directas solo si el
codigo del proyecto las importa explicitamente.

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
- `build_runner` y `drift_dev`: versiones fijadas por compatibilidad real con
  Flutter 3.44.8, `flutter_test`, `meta` y `analyzer`.

## Dependencias fuera de alcance

No incorporar todavia:

- `image_picker`, `image_cropper`, `video_player`, plugins de camara, galeria,
  archivos o video.
- `flutter_local_notifications`.
- `share_plus`, `file_selector`, `archive`.
- Firebase, Supabase o cualquier servicio online.

## Fuentes revisadas

- https://pub.dev/packages/flutter_riverpod
- https://pub.dev/packages/go_router
- https://pub.dev/packages/intl
- https://pub.dev/packages/drift
- https://pub.dev/packages/drift_flutter
- https://pub.dev/packages/path_provider
- https://pub.dev/packages/path
- https://pub.dev/packages/uuid
- https://pub.dev/packages/build_runner
- https://pub.dev/packages/drift_dev
- https://docs.flutter.dev/ui/internationalization
