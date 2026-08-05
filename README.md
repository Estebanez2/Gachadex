# Gachadex

Aplicación Flutter para Android e iOS orientada a crear y jugar colecciones de cartas personalizadas entre grupos de amigos. El producto funcionará localmente y sin conexión: sin cuentas, sin servidor, sin Firebase/Supabase y sin compras con dinero real.

## Estado actual

Fase 1: fundación técnica de Flutter.

Incluye estructura feature-first, Riverpod, GoRouter, navegación inferior, Material 3, tema claro/oscuro/sistema durante la sesión, localización inicial en español, estados comunes, logging de desarrollo, errores controlados y pruebas de arranque/navegación/tema/localización.

No incluye todavía colecciones reales, cartas, sobres, probabilidades, temporizadores, monedas, multimedia, base de datos, importación ni exportación.

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

La configuración está en `l10n.yaml` y el ARB inicial en `lib/l10n/app_es.arb`.

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

Ejemplo habitual con un emulador:

```bash
flutter run -d emulator-5554
```

## Análisis y pruebas

```bash
dart format .
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
```

Compilación Android debug:

```bash
flutter build apk --debug
```

## Documentación

- [Especificación funcional](docs/PRODUCT_SPEC.md)
- [Arquitectura](docs/ARCHITECTURE.md)
- [Roadmap](docs/ROADMAP.md)
- [Análisis de referencias](docs/REFERENCE_ANALYSIS.md)
- [Dependencias](docs/DEPENDENCIES.md)

## Aviso de marca

Gachadex no es un producto de Pokémon, no está afiliado a The Pokémon Company, Nintendo, Creatures Inc. ni Game Freak, y no utiliza nombres, logotipos, marcos, imágenes ni recursos oficiales de Pokémon.
