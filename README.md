# Gachadex

Aplicacion Flutter para Android e iOS orientada a crear y jugar colecciones de
cartas personalizadas entre grupos de amigos. El producto funciona localmente y
sin conexion: sin cuentas, sin servidor, sin Firebase/Supabase y sin compras con
dinero real.

## Estado actual

Fase 3: borradores de coleccion, informacion general y rarezas.

Incluye la base tecnica de Fase 1, el dominio y persistencia local de Fase 2,
schema version 2, biblioteca de borradores, creacion atomica de borradores,
editor con autosave, portada provisional generada en Flutter y CRUD/reordenacion
de rarezas.

No incluye todavia creacion de cartas, selector de fotos/videos, tipos de sobre,
apertura visual, probabilidades ejecutables, temporizadores reales, economia
visible, notificaciones, importacion ni exportacion.

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

Flujo manual de Fase 3:

1. Abrir la pestana `Crear`.
2. Crear una coleccion nueva.
3. Editar nombre, autor, descripcion y portada provisional.
4. Entrar en `Rarezas`, anadir varias rarezas y reordenarlas.
5. Cerrar y volver a abrir la app para comprobar que el borrador persiste.

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
