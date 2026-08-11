# Arquitectura

Fecha: 2026-08-10

Este documento describe el estado tecnico tras la Fase 8: borradores,
rarezas, cartas con fotografias y videos, configuracion de sobres,
finalizacion local, inventario con temporizadores, apertura de sobres y album.
La fuente funcional sigue siendo `docs/PRODUCT_SPEC.md`.

## Principios

- La aplicacion funciona localmente y sin conexion.
- No hay cuentas, servidor, Firebase, Supabase ni servicios equivalentes.
- La definicion de contenido y el progreso del jugador estan separados.
- Los identificadores de dominio son UUID permanentes tipados.
- Las fechas de dominio se validan como UTC.
- SQLite guarda metadatos y rutas relativas, nunca binarios multimedia.
- La presentacion no importa clases generadas por Drift.
- La pantalla Crear manipula borradores reales y conserva el progreso local.
- La Fase 4 guarda fotografias de cartas en archivos privados y registra solo
  rutas relativas/metadatos en SQLite.
- Finalizar una coleccion crea una coleccion instalada local y separa progreso
  de definicion.
- La Fase 8 anade videos de carta como archivos privados MP4 y thumbnails WebP.

## Capas

```text
lib/
  app/                       Composicion Flutter, router, tema, l10n.
  core/
    database/                Drift, conexion, migraciones, providers.
    domain/                  Enums y validaciones compartidas.
    errors/                  Fallos seguros para capas superiores.
    files/                   Almacenamiento multimedia privado.
    identifiers/             UUID tipados y generador inyectable.
    time/                    Clock de produccion y FakeClock.
    value_objects/           Rutas multimedia relativas.
  features/
    collection_creator/      Borradores, portadas generadas y versiones.
    collections/             Colecciones instaladas.
    rarities/                Rarezas y catalogos visuales.
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
`lib/core/database/migrations/schema_versions.dart` y actualmente vale `4`.

`createMigrationStrategy`:

- Crea todas las tablas en una instalacion nueva.
- Activa `PRAGMA foreign_keys = ON` en cada apertura.
- Registra apertura y migraciones con `AppLogger`.
- Migra de v1 a v2 anadiendo la configuracion de portada provisional a
  `collection_projects`.
- Migra de v2 a v3 recreando `card_field_values` con el catalogo fijo de campos
  comicos de Fase 4.
- Migra de v3 a v4 anadiendo ids de diseno generado para sobres y permitiendo
  grupos de probabilidad en reglas `minimumRarity`.
- Rechaza upgrades no implementados con un mensaje seguro.

Para anadir una nueva version se debe subir `currentDatabaseSchemaVersion`,
implementar una rama explicita en `onUpgrade`, documentar el cambio y cubrir la
migracion con tests antes de modificar datos de usuario.

## Dominio

El dominio no importa Drift, SQLite, companions ni filas generadas. Contiene:

- `CollectionProject`, `ContentVersion` y `DraftCoverStyle` para contenido
  editable/versionado.
- `InstalledCollection` para una coleccion instalada.
- `Rarity`, `Card`, `CardFieldValue` y `MediaAsset`.
- `PackType`, `PackCardPoolEntry`, `PackSlotRule`,
  `PackRarityProbability`, `PackInventory`, `PackOpening` y
  `PackOpeningCard`.
- `OwnedCard` y `CoinTransaction`.

Las reglas numericas, UUID, rutas relativas, catalogos visuales y fechas UTC se
validan al construir entidades o antes de guardar. Las reglas entre tablas se
validan en repositorios cuando SQLite no puede expresarlas sin sobreacoplar el
esquema.

## Creador de borradores

La Fase 3 introduce un flujo real bajo `/create`:

- `/create` lista borradores ordenados por `updatedAtUtc` descendente.
- `/create/new` crea un borrador atomico con version 1 y redirige al editor.
- `/create/project/:projectId` edita informacion general, portada provisional,
  rarezas y lista de cartas.
- `/create/project/:projectId/cards/new` crea una carta con fotografia.
- `/create/project/:projectId/cards/:cardId` edita una carta existente.

La presentacion vive en `features/creator/presentation` y
`features/collection_creator/presentation`. El estado editable se concentra en
`CollectionDraftController`, que escucha proyecto y rarezas, calcula el estado
incompleto de la fase y guarda cambios con debounce. Los casos de uso viven en
`features/collection_creator/application` y `features/rarities/application`.

La portada provisional no usa `MediaAsset`: guarda ids estables de color,
acento, icono y patron definidos en `DraftCoverCatalog`.

## Cartas con fotografias

La Fase 4 anade creacion, edicion y borrado de cartas de imagen:

- `ProjectMediaStorage` genera rutas relativas, resuelve archivos privados,
  copia temporales y borra archivos.
- `CardPhotoProcessor` usa galeria, recorte nativo y compresion WebP para
  producir una imagen principal y una miniatura.
- `CreateImageCard`, `UpdateImageCard` y `DeleteImageCard` coordinan archivos y
  base de datos. Las filas `MediaAsset`, `Card` y `CardFieldValue` se escriben
  en transacciones; si falla la base tras copiar archivos se limpian los nuevos.
- Al sustituir foto, la antigua no se borra hasta que la actualizacion de base
  termina correctamente.
- Las cuadriculas usan miniaturas; la preview puede usar la foto pendiente en
  temporal antes de guardar.

Rutas actuales:

```text
projects/{projectId}/cards/images/{assetId}.webp
projects/{projectId}/cards/thumbnails/{assetId}.webp
```

## Sobres y motor de seleccion

La Fase 5 habilita la seccion `Sobres` dentro del borrador:

- Lista, crea, edita, reordena y elimina tipos de sobre.
- Mantiene exactamente un sobre principal por version de contenido.
- Guarda pool de cartas elegibles, reglas por posicion y pesos por rareza.
- Guarda portada/reverso provisionales como ids estables de catalogo, no como
  rutas multimedia falsas.

`PackGenerator` vive en `features/packs/domain/services/` y es puro. Recibe
`PackConfiguration`, cartas elegibles, rarezas y `Random` inyectado. Para cada
slot lee su regla, selecciona rareza, aplica fallback cuando procede y elige una
carta uniforme sin retirarla del pool, por lo que puede repetir cartas en el
mismo sobre. `fixedRarity` no usa fallback silencioso.

El simulador del editor usa el mismo motor y no escribe progreso, inventario,
aperturas, album ni monedas.

## Finalizacion e instalacion local

La Fase 6 habilita la seccion `Revision` dentro del editor de borrador:

- Valida informacion, rarezas, cartas y sobres antes de instalar.
- Comprueba que los activos de imagen referenciados siguen existiendo.
- Requiere al menos una carta, una rareza, un sobre valido y exactamente un
  sobre principal con acumulacion minima de tres.
- Finaliza de forma transaccional la version de contenido, marca el proyecto
  como `finalized`, crea `InstalledCollection` y crea inventario para cada tipo
  de sobre.
- La operacion es idempotente por `collectionId` + `contentVersionId`: repetir
  finalizacion devuelve la coleccion ya instalada.

El sobre principal recibe los tres sobres iniciales configurados en
`CollectionProject.startingPackCount`, acotados por `maxAccumulated`. Los demas
tipos de sobre empiezan con cero disponibles, pero con su propio temporizador.

## Temporizadores de sobres

`PackRechargeCalculator` vive en `features/packs/domain/services/` y es puro:
recibe conteos, maximo, intervalo, proxima recarga y hora UTC actual. Calcula
cuantos sobres se acumulan sin superar el maximo y sin depender de zona horaria
local.

`PackRechargeService` vive en `features/packs/application/` y coordina base de
datos, `Clock`, repositorios e inventario. La app refresca temporizadores al
arrancar y al volver a primer plano; el detalle de coleccion tambien refresca su
inventario al abrirse.

La pantalla `Colecciones` lista colecciones instaladas y el detalle muestra
sobres disponibles, maximo acumulado, tiempo restante y apertura cuando hay
inventario.

## Apertura de sobres

La Fase 7 implementa `OpenPack` en `features/packs/application/`:

- Refresca el inventario antes de abrir.
- Rechaza aperturas sin sobres disponibles o con otra apertura activa.
- Valida la configuracion del sobre y usa `PackGenerator` de Fase 5.
- Guarda `PackOpening`, `PackOpeningCard`, `OwnedCard`, inventario y contador
  `distinctOwnedCount` en una unica transaccion.
- Calcula `wasNew` y `quantityAfter` dentro de la transaccion, incluyendo cartas
  repetidas dentro del mismo sobre.
- Si el inventario estaba lleno, inicia el siguiente intervalo con
  `PackRechargeCalculator.nextAfterConsumed`; si no estaba lleno, conserva el
  temporizador existente.

La UI de apertura marca la apertura como `revealing`, revela cartas una a una,
permite `Saltar` y completa la apertura marcando todas las cartas como
reveladas. La apertura ya existe en SQLite antes de mostrar la primera carta.

## Recuperacion de aperturas

`PackOpeningRepository.getActive` busca aperturas `generated` o `revealing` por
coleccion instalada. Al entrar al detalle se muestra `Continuar apertura` si hay
una pendiente. No se vuelve a generar ni se consume otro sobre. Si todas las
cartas estuvieran reveladas pero la apertura no estuviera completada, el
repositorio la completa de forma segura.

## Album

`AlbumRepository` consulta el album desde `cards` con `LEFT JOIN` a
`owned_cards` y joins a rareza/media. La tabla base es siempre `cards`, por lo
que tambien aparecen faltantes. Las faltantes se entregan al modelo de UI sin
nombre, rareza visible ni imagen para no revelar contenido.

El album expone:

- Obtenidas / total y porcentaje.
- Total de copias calculado con las cantidades actuales.
- Numero de favoritas.
- Filtros: todas, obtenidas, faltantes, repetidas, favoritas, rareza y tipo de
  medio.
- Orden: numero, nombre, rareza, primera obtencion y cantidad.
- Detalle de carta obtenida con imagen completa, vida, descripcion, plantilla,
  marco, campos comicos y favorito.

## Videos de carta

La Fase 8 amplia el editor de cartas existente para elegir `Foto` o `Video`.
`CardVideoProcessor` encapsula `image_picker` y `video_compress`: selecciona un
video de galeria, lee metadatos, rechaza duraciones mayores a 15 segundos,
comprime a MP4 720p conservando audio cuando existe y genera un thumbnail del
primer fotograma.

El modelo no cambia de esquema: `Card.mediaType` pasa a `video`, el
`MediaAsset` principal guarda `video/mp4`, dimensiones, duracion, tamano y ruta
relativa al MP4; `thumbnailAssetId` apunta a un WebP usado en grids, resumen,
portada previa y detalle. La DB sigue guardando solo rutas y metadatos.

`CardVideoPlayer` resuelve rutas relativas desde almacenamiento privado y usa
`video_player` sobre archivo local. Mantiene un unico controller por instancia,
pausa al cambiar de pantalla o pasar la app a background, vuelve al thumbnail al
terminar y ofrece `Repetir`. Los grids nunca crean controllers ni reproducen
videos.

## Repositorios

Interfaces de dominio:

- `CollectionProjectRepository`
- `ContentVersionRepository`
- `RarityRepository`
- `CardRepository`
- `PackTypeRepository`
- `PackInventoryRepository`
- `PackOpeningRepository`
- `AlbumRepository`
- `InstalledCollectionRepository`
- `PlayerProgressRepository`

Implementaciones Drift:

- Crean borrador + version 1 en transaccion.
- Observan, actualizan y borran borradores.
- Actualizan la portada provisional y refrescan `updatedAtUtc`.
- Validan referencias cruzadas de coleccion y version.
- Evitan borrar rarezas usadas por cartas.
- Detectan nombres duplicados de rarezas normalizados.
- Reordenan rarezas compactando `orderIndex`.
- Reordenan sobres compactando `sortIndex`, reemplazan pools/reglas/pesos en
  transaccion y actualizan `updatedAtUtc` del borrador.
- Evitan instalar dos veces la misma coleccion/version.
- Leen y actualizan inventario independiente por tipo de sobre.
- Abren sobres de forma atomica y conservan historial de aperturas.
- Consultan album sin SQL desde widgets.
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
persistencia real de borradores, portada y orden de rarezas. La base del
dispositivo no se usa en tests.

Los widgets de Fase 3 se prueban con repositorios en memoria para evitar que los
streams de Drift dejen temporizadores pendientes dentro de `testWidgets`; la
persistencia real queda cubierta por tests de repositorio y controlador.

## Limites de la fase

Queda fuera de Fase 8:

- Venta de duplicados.
- Economia usable.
- Notificaciones.
- Importacion/exportacion `.gachadex`.
