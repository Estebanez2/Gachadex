# Dependencias

Fecha: 2026-08-05

No se han anadido dependencias en la fase 0. Esta tabla documenta el estado actual y las dependencias previstas antes de incorporarlas. Las versiones previstas se revisaron en pub.dev el 2026-08-05, pero no deben fijarse hasta la fase en que se introduzcan.

## Dependencias existentes

| Dependencia | Version actual | Tipo | Motivo | Android/iOS | Licencia | Estado de mantenimiento | Fase |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Flutter SDK | 3.44.8 stable | SDK | Framework de app movil multiplataforma | Android e iOS soportados | BSD-3-Clause | Stable; `flutter doctor` OK para Android | Base actual |
| Dart SDK | 3.12.2 stable | SDK | Lenguaje y tooling | Android/iOS via Flutter | BSD-3-Clause | Stable, incluido con Flutter | Base actual |
| `flutter` | SDK | Produccion | Widgets, Material y runtime Flutter | Android e iOS | BSD-3-Clause | Mantenido por Flutter | Base actual |
| `cupertino_icons` | constraint `^1.0.8`, resuelto 1.0.9 | Produccion | Iconos estilo Cupertino generados por plantilla Flutter | Android e iOS | MIT | Paquete publicado en pub.dev y resuelto localmente | Base actual |
| `flutter_test` | SDK | Dev | Pruebas de widgets y utilidades de test | Android/iOS no aplica directamente | BSD-3-Clause | Mantenido por Flutter | Base actual |
| `flutter_lints` | 6.0.0 | Dev | Reglas recomendadas de lint | Android/iOS no aplica directamente | BSD-3-Clause | Mantenido por Flutter/Dart | Base actual |

Las dependencias transitivas existentes estan fijadas en `pubspec.lock` y no se listan una a una aqui salvo que pasen a ser dependencias directas.

## Dependencias previstas

| Dependencia | Version vista en pub.dev | Tipo previsto | Motivo | Android/iOS | Licencia | Estado de mantenimiento | Fase |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `flutter_riverpod` | 3.4.2 | Produccion | Estado, inyeccion y estados asincronos testeables | Android e iOS | MIT | Publicado 7 dias antes de la revision; alto uso | Fase 1 |
| `go_router` | 17.4.0 | Produccion | Navegacion declarativa y shell de tabs | Android e iOS | BSD-3-Clause | Paquete Flutter oficial, feature-complete y activo | Fase 1 |
| `drift` | 2.34.3 | Produccion | Persistencia SQLite tipada, transacciones, migraciones y streams | Android e iOS | MIT | Activo y publicado 8 dias antes de la revision | Fase 1 |
| `drift_flutter` | 0.3.1 | Produccion | Apertura de bases Drift en Flutter con rutas de plataforma | Android e iOS | MIT | Activo; utilidad pequena del ecosistema Drift | Fase 1 |
| `drift_dev` | 2.34.5 | Dev | Generador de codigo Drift | No aplica directamente | MIT | Activo; debe emparejarse con Drift | Fase 1 |
| `build_runner` | 2.16.0 | Dev | Ejecucion de generadores | No aplica directamente | BSD-3-Clause | Activo; publicado 5 dias antes de la revision | Fase 1 |
| `sqlite3` | 3.5.1 | Produccion indirecta/directa | Bindings SQLite usados por Drift | Android e iOS | MIT | Activo; version 3.x agrupa soporte nativo | Fase 1 |
| `sqlite3_flutter_libs` | 0.6.0+eol | No agregar directamente salvo requerimiento indirecto | Antes se usaba para SQLite nativo | Android e iOS | MIT | Obsoleto; pub.dev indica usar `sqlite3` 3.x | Fase 1, solo si Drift lo requiere |
| `uuid` | 4.6.0 | Produccion | UUID permanentes para colecciones, cartas, rarezas, sobres, activos, aperturas y transacciones | Android e iOS | MIT | Activo y con soporte RFC9562 | Fase 1 |
| `path_provider` | 2.1.6 | Produccion | Directorios internos, soporte y temporales de la app | Android SDK 24+, iOS 13+ | BSD-3-Clause | Paquete Flutter oficial activo | Fase 1 |
| `path` | 1.9.1 | Produccion | Composicion segura de rutas relativas | Android e iOS via Dart | BSD-3-Clause | Paquete Dart estable; ya presente como transitiva | Fase 1 |
| `file_selector` | 1.1.0 | Produccion | Seleccion de `.friendpack` y ubicaciones cuando la plataforma lo permita | Android SDK 21+, iOS 12+ | BSD-3-Clause | Paquete Flutter oficial activo | Fase 5 |
| `share_plus` | 13.3.0 | Produccion | Compartir `.friendpack` con la UI nativa | Android e iOS | BSD-3-Clause | Flutter Community, activo; revisar cambios de API | Fase 5 |
| `archive` | 4.0.9 | Produccion | ZIP y streaming de `.friendpack` | Android e iOS via Dart | MIT | Activo; version 4 prioriza File IO y menor memoria | Fase 5 |
| `crypto` | 3.0.7 | Produccion | SHA-256 para checksums de activos | Android e iOS via Dart | BSD-3-Clause | Paquete Dart activo; no usar como prueba de autoria | Fase 5 |
| `image_picker` | 1.2.3 | Produccion | Seleccion de imagenes y videos desde galeria/camara si se habilita | Android SDK 24+, iOS 13+ | Apache-2.0, BSD-3-Clause | Paquete Flutter oficial activo; manejar lost data en Android | Fase 2 para imagen, Fase 4 para video |
| `image_cropper` | 12.2.1 | Produccion | Recorte con UI nativa de imagenes | Android, iOS, web | BSD-3-Clause | Activo; depende de librerias nativas que requieren creditos | Fase 2 |
| `flutter_image_compress` | 2.5.1 | Produccion candidata | Conversion y compresion a WebP mediante APIs nativas | Android, iOS, macOS, web | MIT | Activo; verificar soporte WebP real por plataforma y dispositivos | Fase 2 |
| Servicio nativo de video por definir | Por definir | Produccion | Recorte, compresion MP4 H.264/AAC y primer fotograma | Android e iOS | Por revisar | No elegir paquete abandonado; aislar con `MediaProcessor` | Fase 4 |
| `video_player` | 2.13.0 | Produccion | Reproducir videos locales en apertura y album | Android SDK 24+, iOS 13+ | BSD-3-Clause | Paquete Flutter oficial activo | Fase 4 |
| `flutter_local_notifications` | 22.2.0 | Produccion | Notificaciones locales de sobres disponibles | Android e iOS | BSD-3-Clause | Activo; requiere Flutter SDK minimo 3.38.1 | Fase 7 |

## Dependencias de referencia que no se trasladan

| Dependencia | Repositorio | Motivo |
| --- | --- | --- |
| `papaparse.min.js` | Altare | La app no cargara CSV en runtime; si se usa para migracion sera herramienta separada. |
| `a11y-dialog.min.js` | Altare | Accesibilidad web no aplica a Flutter. |
| `live-server` | Altare | Servidor de desarrollo web, innecesario. |
| `pokemon-cards-css` | Altare, acreditado | Riesgo de licencia y marca; no copiar efectos. |
| `react`, `react-scripts`, `tailwindcss` | React Card Builder | No se usara WebView ni React dentro de Flutter. |
| `html-to-image`, `html2canvas`, `jspdf` | React Card Builder | Exportacion DOM/PDF no aplica a `.friendpack` ni a Flutter v1. |
| `three`, `@react-three/fiber`, `@react-three/drei` | React Card Builder | Vista 3D web fuera de alcance de la primera version. |
| `react-material-symbols` | React Card Builder | Iconografia web no necesaria; revisar alternativas propias cuando haga falta. |

## Reglas antes de agregar una dependencia

Antes de introducir cualquier dependencia de produccion:

1. Revisar soporte Android e iOS.
2. Revisar licencia del paquete y de sus dependencias nativas.
3. Confirmar mantenimiento reciente.
4. Documentar el motivo en este archivo.
5. Encapsular plugins de infraestructura detras de interfaces propias.
6. Agregar o actualizar pruebas.
7. Evitar dependencias abandonadas o sustituibles por codigo pequeno y estable.

## Fuentes revisadas

- https://pub.dev/packages/flutter_riverpod
- https://pub.dev/packages/go_router
- https://pub.dev/packages/drift
- https://pub.dev/packages/drift_flutter
- https://pub.dev/packages/build_runner
- https://pub.dev/packages/sqlite3
- https://pub.dev/packages/sqlite3_flutter_libs
- https://pub.dev/packages/path_provider
- https://pub.dev/packages/path
- https://pub.dev/packages/uuid
- https://pub.dev/packages/file_selector
- https://pub.dev/packages/share_plus
- https://pub.dev/packages/archive
- https://pub.dev/packages/image_picker
- https://pub.dev/packages/image_cropper
- https://pub.dev/packages/flutter_image_compress
- https://pub.dev/packages/video_player
- https://pub.dev/packages/flutter_local_notifications
- https://pub.dev/packages/crypto
