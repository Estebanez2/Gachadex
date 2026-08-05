# Arquitectura

Fecha: 2026-08-05

Este documento describe el estado tecnico tras la Fase 2: modelo de dominio y
persistencia local. La fuente funcional sigue siendo `docs/PRODUCT_SPEC.md`.

## Principios

- La aplicacion funciona localmente y sin conexion.
- No hay cuentas, servidor, Firebase, Supabase ni servicios equivalentes.
- La definicion de contenido y el progreso del jugador estan separados.
- Los identificadores de dominio son UUID permanentes tipados.
- Las fechas de dominio se validan como UTC.
- SQLite guarda metadatos y rutas relativas, nunca binarios multimedia.
- La presentacion no importa clases generadas por Drift.
- Las pantallas de Fase 1 no crean datos reales ni muestran funciones incompletas.

## Capas

```text
lib/
  app/                       Composicion Flutter, router, tema, l10n.
  core/
    database/                Drift, conexion, migraciones, providers.
    domain/                  Enums y validaciones compartidas.
    errors/                  Fallos seguros para capas superiores.
    identifiers/             UUID tipados y generador inyectable.
    time/                    Clock de produccion y FakeClock.
    value_objects/           Rutas multimedia relativas.
  features/
    collection_creator/      Proyecto editable y versiones de contenido.
    collections/             Colecciones instaladas.
    rarities/                Rarezas.
    cards/                   Cartas, campos y activos multimedia.
    packs/                   Sobres, pools, reglas y aperturas.
    album/                   Cartas obtenidas y progreso.
    economy/                 Historial de monedas.
```

Cada feature con logica real separa `domain/` y `data/`. Los repositorios de
dominio exponen entidades limpias; las implementaciones Drift viven en `data/`.

## Persistencia

`AppDatabase` esta en `lib/core/database/app_database.dart` y usa Drift sobre
SQLite. La conexion de produccion se abre con `drift_flutter` en almacenamiento
privado de la aplicacion mediante `getApplicationSupportDirectory()`; el archivo
real es `gachadex.sqlite`.

La base se expone con `appDatabaseProvider`. Riverpod crea una unica instancia
por `ProviderScope` y la cierra con `ref.onDispose`.

## Migraciones

`currentDatabaseSchemaVersion` vive en
`lib/core/database/migrations/schema_versions.dart` y actualmente vale `1`.

`createMigrationStrategy`:

- Crea todas las tablas en una instalacion nueva.
- Activa `PRAGMA foreign_keys = ON` en cada apertura.
- Registra apertura y migraciones con `AppLogger`.
- Rechaza upgrades no implementados con un mensaje seguro hasta que exista v2.

Para anadir v2 se debe subir `currentDatabaseSchemaVersion`, implementar el
bloque `onUpgrade` para `from == 1`, documentar la decision y cubrir la
migracion con tests antes de modificar datos de usuario.

## Dominio

El dominio no importa Drift, SQLite, companions ni filas generadas. Contiene:

- `CollectionProject` y `ContentVersion` para contenido editable/versionado.
- `InstalledCollection` para una coleccion instalada.
- `Rarity`, `Card`, `CardFieldValue` y `MediaAsset`.
- `PackType`, `PackCardPoolEntry`, `PackSlotRule`,
  `PackRarityProbability`, `PackInventory`, `PackOpening` y
  `PackOpeningCard`.
- `OwnedCard` y `CoinTransaction`.

Las reglas numericas, UUID, rutas relativas y fechas UTC se validan al construir
entidades. Las reglas entre tablas se validan en repositorios cuando SQLite no
puede expresarlas sin sobreacoplar el esquema.

## Repositorios

Interfaces de dominio:

- `CollectionProjectRepository`
- `ContentVersionRepository`
- `RarityRepository`
- `CardRepository`
- `PackTypeRepository`
- `InstalledCollectionRepository`
- `PlayerProgressRepository`

Implementaciones Drift:

- Crean borrador + version 1 en transaccion.
- Validan referencias cruzadas de coleccion y version.
- Evitan borrar rarezas usadas por cartas.
- Evitan instalar dos veces la misma coleccion/version.
- Borran progreso local al eliminar una coleccion instalada.
- No devuelven filas Drift a dominio o presentacion.

## Mappers

Los mappers explicitos viven en `features/*/data/mappers/`. Convierten:

- Fila Drift -> entidad de dominio.
- Entidad de dominio -> companion Drift.
- `DateTime` de Drift -> UTC de dominio.
- IDs tipados -> `String` para SQLite.

Los enums se guardan como strings estables mediante `TypeConverter`; no se usa
el indice automatico del enum.

## Eliminacion

- Borrar un borrador elimina su proyecto, version editable y activos de esa
  coleccion cuando no esta instalado.
- Borrar una coleccion instalada elimina solo progreso local mediante cascadas
  desde `installed_collections`.
- El contenido finalizado compartido queda protegido por repositorios y claves
  foraneas restrictivas.
- Las cascadas se usan para hijos estrictamente dependientes, como campos de
  carta, pool de sobre y filas de apertura.

## Tests

Las pruebas usan `NativeDatabase.memory()` para bases aisladas. Hay un test
adicional con archivo temporal que cierra y reabre SQLite para verificar
persistencia real. La base del dispositivo no se usa en tests.

## Limites de la fase

Queda fuera de Fase 2:

- Formularios completos.
- Selector o procesamiento de fotos/videos.
- Apertura visual de sobres.
- Probabilidades ejecutables.
- Temporizadores reales.
- Entrega de sobres iniciales.
- Economia visible.
- Notificaciones.
- Importacion/exportacion `.friendpack`.
