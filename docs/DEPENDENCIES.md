# Dependencias

Fecha: 2026-08-05

Este documento registra las dependencias directas del proyecto tras la Fase 1: fundación técnica de Flutter. No se han añadido Drift, SQLite, UUID, multimedia, notificaciones, archivos, Firebase, Supabase ni servicios online.

## Dependencias directas actuales

| Dependencia | Versión | Tipo | Función | Licencia | Compatibilidad | Motivo | Fase |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Flutter SDK | 3.44.8 stable | SDK | Framework móvil multiplataforma | BSD-3-Clause | Android e iOS | Base de la aplicación | Base |
| Dart SDK | 3.12.2 stable | SDK | Lenguaje y herramientas | BSD-3-Clause | Android e iOS vía Flutter | Incluido con Flutter | Base |
| `flutter` | SDK | Producción | Widgets, Material 3 y runtime Flutter | BSD-3-Clause | Android e iOS | Dependencia principal de Flutter | Base |
| `flutter_localizations` | SDK | Producción | Delegates oficiales de localización de Flutter | BSD-3-Clause | Android e iOS | Necesario para internacionalización y Material en español | Fase 1 |
| `flutter_riverpod` | `^3.4.2`, resuelto 3.4.2 | Producción | Estado de sesión, inyección y observación de providers | MIT | Android e iOS | Gestionar `ThemeMode`, exponer router y preparar DI testeable | Fase 1 |
| `go_router` | `^17.4.0`, resuelto 17.4.0 | Producción | Navegación declarativa con shell de pestañas | BSD-3-Clause | Android e iOS | Rutas centralizadas, `StatefulShellRoute.indexedStack`, errores de router | Fase 1 |
| `intl` | `^0.20.2`, resuelto 0.20.2 | Producción | Soporte de generación oficial de localizaciones | BSD-3-Clause | Android e iOS | `flutter gen-l10n` genera código que importa `package:intl`; Flutter 3.44.8 fija 0.20.2 desde `flutter_localizations` | Fase 1 |
| `flutter_test` | SDK | Desarrollo | Pruebas de widgets y helpers de test | BSD-3-Clause | No aplica directamente | Suite de arranque, navegación, tema, localización y widgets comunes | Base |
| `flutter_lints` | `^6.0.0`, resuelto 6.0.0 | Desarrollo | Reglas recomendadas de análisis estático | BSD-3-Clause | No aplica directamente | Calidad base del código Dart/Flutter | Base |

## Revisión previa a la incorporación

- `flutter_riverpod` 3.4.2 figura en pub.dev como paquete Flutter para Android e iOS, publicado por `dash-overflow.net`, licencia MIT y mantenimiento reciente.
- `go_router` 17.4.0 figura en pub.dev como paquete Flutter oficial publicado por `flutter.dev`, compatible con Android e iOS, licencia BSD-3-Clause y estado feature-complete con mantenimiento de estabilidad.
- `intl` 0.20.3 es la última versión en pub.dev, pero `flutter_localizations` en Flutter 3.44.8 fija `intl` a 0.20.2. Se usa 0.20.2 por compatibilidad con el SDK instalado.
- `flutter_localizations` pertenece al SDK Flutter y evita añadir otro paquete para delegates Material/Cupertino/Widgets.

## Dependencias transitivas

Las dependencias transitivas están fijadas en `pubspec.lock` y no se listan una a una salvo que pasen a ser dependencias directas. Si aparece una librería como transitiva por el árbol de Flutter/test, no implica que Gachadex la use en código de producto.

## Dependencias fuera de alcance en esta fase

No incorporar durante esta fase:

- Drift, SQLite, `sqlite3`, `path_provider`, `path`, `uuid`.
- `image_picker`, `video_player`, plugins de cámara, galería, archivos o vídeo.
- `share_plus`, `archive`, importación/exportación `.friendpack`.
- `flutter_local_notifications`.
- Firebase, Supabase o cualquier servicio online.

Estas dependencias se revisarán en la fase correspondiente, con licencia, mantenimiento, soporte Android/iOS y motivo documentados antes de agregarlas.

## Fuentes revisadas

- https://pub.dev/packages/flutter_riverpod
- https://pub.dev/packages/flutter_riverpod/license
- https://pub.dev/packages/go_router
- https://pub.dev/packages/go_router/license
- https://pub.dev/packages/intl
- https://pub.dev/packages/intl/license
- https://docs.flutter.dev/ui/internationalization
