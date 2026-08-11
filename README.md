# Gachadex

Aplicacion Flutter para Android e iOS orientada a crear y jugar colecciones de
cartas personalizadas entre grupos de amigos. El producto funciona localmente y
sin conexion: sin cuentas, sin servidor, sin Firebase/Supabase y sin compras con
dinero real.

## Estado actual

Fase 8: borradores, rarezas, cartas con fotografias y videos, configuracion de
sobres, finalizacion local, temporizadores, apertura de sobres y album.

Incluye la base tecnica de Fase 1, el dominio y persistencia local de Fase 2,
schema version 4, biblioteca de borradores, creacion atomica de borradores,
editor con autosave, portada provisional generada en Flutter y CRUD/reordenacion
de rarezas. La seccion Cartas permite seleccionar una foto de galeria,
recortarla, guardarla como WebP privado con miniatura, o seleccionar un video
de hasta 15 segundos, procesarlo como MP4 con audio y thumbnail, completar
datos, ver preview, editar y eliminar. La seccion Sobres permite crear varios tipos de
sobre, elegir principal, configurar cartas elegibles, reglas por posicion,
pesos por rareza y simular aperturas sin modificar progreso. La seccion
Revision valida la coleccion, la finaliza de forma local, instala la copia
jugable del creador, entrega tres sobres iniciales del sobre principal y crea
temporizadores independientes para cada tipo de sobre. Las colecciones
instaladas permiten abrir sobres disponibles, revelar cartas una a una, saltar
la apertura, recuperar aperturas pendientes y consultar album con obtenidas,
faltantes, repetidas, cantidades, favoritas, filtros por rareza/tipo de medio y
orden.

No incluye todavia venta de duplicados, economia usable, notificaciones,
importacion ni exportacion.

## Requisitos

- Flutter 3.44.8 stable o compatible.
- Dart 3.12.2 o compatible.
- Android SDK para desarrollo Android.
- macOS con Xcode para compilar o probar iOS.

## Instalar dependencias

```bash
flutter pub get
```

## Generar localizaciones

```bash
flutter gen-l10n
```

La configuracion esta en `l10n.yaml` y el ARB inicial en
`lib/l10n/app_es.arb`.

## Generar codigo Drift

El archivo generado `lib/core/database/app_database.g.dart` se versiona para que
el proyecto compile tras clonar sin exigir generacion inmediata.

```bash
dart run build_runner build --delete-conflicting-outputs
```

Con `build_runner` 2.15.1 puede aparecer un aviso indicando que
`--delete-conflicting-outputs` fue retirado; el build sigue generando
correctamente.

Para limpiar la cache de build_runner cuando sea necesario:

```bash
dart run build_runner clean
dart run build_runner build
```

No se versionan `.dart_tool/`, `build/`, bases SQLite locales, journals ni datos
personales.

## Ejecutar la app

Lista dispositivos disponibles:

```bash
flutter devices
```

Ejecuta en el dispositivo por defecto:

```bash
flutter run
```

Selecciona un dispositivo Android concreto:

```bash
flutter run -d <device-id>
```

Flujo manual de Fase 8:

1. Abrir la pestana `Crear`.
2. Crear una coleccion nueva.
3. Editar nombre, autor, descripcion y portada provisional.
4. Entrar en `Rarezas`, anadir varias rarezas y reordenarlas.
5. Entrar en `Cartas` y pulsar `Anadir carta`.
6. Seleccionar una fotografia de galeria, recortarla y completar nombre, vida,
   numero, rareza, plantilla, marco, colores y campos comicos.
7. Guardar, cerrar completamente la app y volver a abrirla.
8. Verificar que la carta y su miniatura siguen en la cuadricula.
9. Editar la carta, sustituir la foto y guardar.
10. Entrar en `Sobres` y pulsar `Anadir sobre`.
11. Configurar nombre, cinco cartas por sobre, 12 horas, maximo 3 y coste.
12. Elegir cartas elegibles, revisar reglas por posicion y pesos por rareza.
13. Guardar; el primer sobre queda como principal.
14. Crear un segundo sobre, marcarlo como principal y comprobar que el anterior
    deja de serlo.
15. Editar un sobre guardado y ejecutar `Simular`; no se crean cartas obtenidas
    ni inventario.
16. Cerrar y reabrir la app; verificar que sobres, reglas, pesos y principal se
    conservan.
17. Entrar en `Revision` y comprobar que Informacion, Rarezas, Cartas y Sobres
    aparecen listos.
18. Pulsar `Finalizar coleccion`, confirmar y verificar que se abre el detalle
    de la coleccion instalada.
19. En `Colecciones`, abrir la coleccion instalada y comprobar que el sobre
    principal muestra `3/3 disponibles`.
20. Si hay sobres secundarios, comprobar que aparecen con `0/max` y su propio
    tiempo restante.
21. Cerrar y reabrir la app; verificar que la coleccion instalada y el
    inventario siguen ahi.
22. Esperar o adelantar el reloj del emulador hasta superar una recarga,
    reabrir o volver a primer plano y verificar que el inventario se actualiza.
23. Pulsar `Abrir sobre` y comprobar que el inventario baja de 3 a 2.
24. Revelar cartas una a una y comprobar indicador `Nueva` o `Repetida`.
25. Usar `Saltar` en otra apertura y comprobar que aparece el resumen.
26. Entrar en `Album` y verificar obtenidas, faltantes, cantidades y porcentaje.
27. Abrir una carta obtenida, revisar vida, descripcion, plantilla, marco y
    campos comicos, marcarla como favorita y filtrar `Favoritas`.
28. Filtrar por `Repetidas`, rareza y tipo de medio; ordenar por `Cantidad` y
    `Primera obtencion`.
29. Cerrar la app a mitad de una apertura y volver a abrir la coleccion:
    debe aparecer `Continuar apertura` sin consumir otro sobre.
30. Crear o editar otra carta, elegir `Video`, seleccionar un video de menos de
    15 segundos y verificar thumbnail, duracion y preview.
31. Guardar, cerrar y reabrir; comprobar que el video y su thumbnail persisten.
32. Finalizar una coleccion con esa carta, abrir sobres hasta obtenerla y
    confirmar que al revelar se reproduce con sonido, vuelve al thumbnail y
    permite `Repetir`.
33. Entrar al album: el grid debe mostrar solo thumbnail con icono de video; el
    detalle debe reproducir el video y detenerse al salir.

## Analisis y pruebas

```bash
dart format .
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
```

Compilacion Android debug:

```bash
flutter build apk --debug
```

## Base de datos

- Esquema: [docs/DATABASE_SCHEMA.md](docs/DATABASE_SCHEMA.md)
- Arquitectura: [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)
- Dependencias: [docs/DEPENDENCIES.md](docs/DEPENDENCIES.md)

La conexion de produccion usa `drift_flutter` y crea `gachadex.sqlite` en el
directorio privado de soporte de la app. Los tests usan bases en memoria o
archivos temporales aislados.

## Documentacion

- [Especificacion funcional](docs/PRODUCT_SPEC.md)
- [Arquitectura](docs/ARCHITECTURE.md)
- [Roadmap](docs/ROADMAP.md)
- [Creador de borradores](docs/DRAFT_CREATOR.md)
- [Esquema de base de datos](docs/DATABASE_SCHEMA.md)
- [Analisis de referencias](docs/REFERENCE_ANALYSIS.md)
- [Dependencias](docs/DEPENDENCIES.md)

## Aviso de marca

Gachadex no es un producto de Pokemon, no esta afiliado a The Pokemon Company,
Nintendo, Creatures Inc. ni Game Freak, y no utiliza nombres, logotipos, marcos,
imagenes ni recursos oficiales de Pokemon.
