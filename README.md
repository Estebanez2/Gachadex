# Friend Cards / Gachadex

Aplicacion Flutter para Android e iOS orientada a crear y jugar colecciones de cartas personalizadas entre grupos de amigos. El producto funcionara localmente y sin conexion: sin cuentas, sin servidor, sin Firebase/Supabase y sin compras con dinero real.

## Estado actual

Fase 0: preparacion del repositorio, documentacion de arquitectura y analisis de repositorios de referencia. Todavia no hay pantallas funcionales de producto.

## Requisitos

- Flutter 3.44.8 stable o compatible.
- Dart 3.12.2 o compatible.
- Android SDK para desarrollo Android.
- macOS con Xcode para compilar o probar iOS.

## Clonar con submodulos

```bash
git clone --recurse-submodules <repo-url>
cd Gachadex
```

Si ya clonaste el repositorio sin submodulos:

```bash
git submodule update --init --recursive
```

## Instalar y ejecutar

```bash
flutter pub get
flutter run
```

## Analisis y pruebas

```bash
dart format .
flutter analyze
flutter test
```

## Documentacion

- [Especificacion funcional](docs/PRODUCT_SPEC.md)
- [Arquitectura](docs/ARCHITECTURE.md)
- [Roadmap](docs/ROADMAP.md)
- [Analisis de referencias](docs/REFERENCE_ANALYSIS.md)
- [Dependencias](docs/DEPENDENCIES.md)

## Aviso de marca

Friend Cards / Gachadex no es un producto de Pokemon, no esta afiliado a The Pokemon Company, Nintendo, Creatures Inc. ni Game Freak, y no utiliza nombres, logotipos, marcos, imagenes ni recursos oficiales de Pokemon.
