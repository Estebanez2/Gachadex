# Arquitectura

Fecha: 2026-08-05

Este documento concreta la arquitectura objetivo para Friend Cards sin implementar todavia funcionalidades de producto. La fuente funcional sigue siendo `docs/PRODUCT_SPEC.md`.

## Principios

- La aplicacion funciona localmente y sin conexion.
- No hay cuentas, servidor, Firebase, Supabase ni servicios equivalentes.
- El contenido compartible vive en archivos `.friendpack` autosuficientes.
- Las fotos, videos y miniaturas se guardan como archivos internos, nunca como BLOB en SQLite.
- La base de datos guarda UUID, rutas relativas y metadatos.
- La definicion de contenido es independiente del progreso del jugador.
- Los proyectos editables son distintos de las colecciones instaladas e inmutables.
- No se reutilizan nombres, logos, marcos, imagenes, fuentes ni recursos oficiales o de terceros sin licencia revisada.

## Capas

### Presentacion

Contendra pantallas, widgets, formularios, navegacion, animaciones, mensajes de error, controles de accesibilidad y ciclo de vida de reproductores de video. No ejecutara consultas SQLite directamente y no contendra reglas de negocio.

### Aplicacion

Contendra casos de uso coordinadores. Ejemplos: crear proyecto, guardar borrador, crear rareza, crear carta, finalizar coleccion, abrir sobre, vender duplicado, recalcular temporizadores, importar y exportar. Orquestara transacciones, repositorios y servicios, pero no dependera de widgets.

### Dominio

Contendra entidades, value objects, reglas y errores tipados independientes de Flutter. Ejemplos: `CollectionId`, `CardId`, `Rarity`, `PackSlotRule`, `ProbabilityDistribution`, `PackOpeningResult`, `CoinTransaction` y validadores.

### Datos e infraestructura

Contendra Drift/SQLite, sistema de archivos, seleccion de archivos, procesamiento multimedia, ZIP, JSON, checksums, notificaciones locales y adaptadores de plugins. Toda dependencia cambiante se encapsulara detras de interfaces propias.

## Modulos

Estructura objetivo:

```text
lib/
  app/
    app.dart
    router.dart
    theme.dart

  core/
    database/
    errors/
    files/
    media/
    notifications/
    serialization/
    utils/
    widgets/

  features/
    home/
    collection_creator/
    collection_library/
    rarity_creator/
    card_creator/
    pack_creator/
    pack_opening/
    album/
    economy/
    import_export/
    settings/

  domain/
    entities/
    repositories/
    services/
    value_objects/
```

Cada feature importante podra dividirse en:

```text
feature/
  data/
  domain/
  presentation/
```

No se crearan capas vacias. Una feature pequena puede empezar con menos carpetas y crecer cuando tenga reglas o persistencia propias.

## Responsabilidades por modulo

- `home`: resumen de sobres, proximas recargas, monedas y accesos recientes.
- `collection_creator`: flujo de proyecto, autosave y revision antes de finalizar.
- `collection_library`: listado separado de colecciones instaladas y proyectos.
- `rarity_creator`: rarezas personalizadas, orden, color, icono, marco, efecto y valor de venta.
- `card_creator`: seleccion multimedia, plantillas, campos comicos, preview y validaciones.
- `pack_creator`: tipos de sobre, pools de cartas, reglas de posiciones y probabilidades.
- `pack_opening`: generacion atomica del resultado, revelado visual y recuperacion tras cierre.
- `album`: progreso, filtros, cantidades, faltantes, favoritos y detalle.
- `economy`: duplicados, venta, monedas y aceleracion de temporizadores.
- `import_export`: `.friendpack`, validacion, checksums, extraccion segura y comparticion.
- `settings`: preferencias locales, notificaciones, almacenamiento, licencias y privacidad.

## Flujo entre capas

1. La presentacion recoge una intencion del usuario.
2. La presentacion llama a un caso de uso de aplicacion.
3. El caso de uso valida con entidades y servicios de dominio.
4. El caso de uso usa repositorios y servicios de infraestructura.
5. La infraestructura traduce SQLite, archivos, plugins o sistema operativo a modelos propios.
6. El caso de uso devuelve un resultado o error tipado.
7. La presentacion traduce el resultado a estado visual y texto en espanol.

El flujo de dependencia siempre apunta hacia dentro: presentacion depende de aplicacion; aplicacion depende de dominio y contratos; infraestructura implementa contratos; dominio no depende de Flutter, Drift ni plugins.

## Estado e inyeccion

Riverpod se introducira en la fase tecnica, no en esta fase documental. Se usara para exponer casos de uso, repositorios, servicios y estados asincronos. Los providers no deben convertirse en estado global mutable; cada dependencia tendra ciclo de vida claro y sera reemplazable en pruebas.

## Navegacion

GoRouter se introducira en la fase tecnica. La navegacion inicial sera declarativa, con rutas para inicio, biblioteca, creador, detalle de coleccion, apertura, album, importacion/exportacion y ajustes. No habra rutas de autenticacion porque el producto no tiene cuentas.

## Almacenamiento local

La estrategia prevista es Drift sobre SQLite. La ubicacion estara en el directorio de soporte de la aplicacion obtenido con `path_provider`. SQLite guardara tablas relacionales y metadatos; los binarios multimedia viviran en archivos.

Estructura objetivo:

```text
app_support/
  database/
    app.sqlite

  projects/
    {projectId}/
      images/
      videos/
      thumbnails/
      packs/

  installed/
    {collectionId}/
      collection/
      cards/
        images/
        videos/
        thumbnails/
      packs/

  exports/
  temp/
```

Las rutas persistidas seran relativas al contenedor de proyecto o coleccion instalada. No se persistiran rutas absolutas.

## Proyectos editables y colecciones instaladas

Un proyecto de coleccion es mutable y se guarda con autosave. Puede cambiar datos generales, rarezas, cartas, sobres, economia y recursos multimedia.

Al finalizar:

1. Se valida el proyecto completo.
2. Se crea una definicion jugable inmutable con `collectionId` y `contentVersion`.
3. Se instala una copia jugable local para el creador.
4. Se entregan tres sobres iniciales del sobre principal.
5. Se habilita la exportacion.

Una coleccion instalada nunca se edita directamente en la primera version. Futuras actualizaciones usaran el mismo `collectionId` y un `contentVersion` superior.

## Definicion de contenido y progreso

Definicion de contenido:

- Colecciones y versiones.
- Rarezas.
- Cartas.
- Campos comicos.
- Activos multimedia.
- Tipos de sobre.
- Pools de cartas.
- Reglas de posiciones.
- Probabilidades por rareza.
- Plantillas y efectos seleccionados.

Progreso del jugador:

- Colecciones instaladas.
- Cartas obtenidas y cantidades.
- Favoritos.
- Inventario de sobres.
- Temporizadores.
- Historial de aperturas.
- Movimientos de monedas.

La apertura de sobres actualiza progreso en una transaccion antes de iniciar animaciones. Si la app se cierra durante el revelado, el resultado ya esta guardado y puede recuperarse.

## Fotografias, videos y miniaturas

La seleccion y procesamiento multimedia se aislaran detras de una interfaz `MediaProcessor`.

Fotografias:

- Copia a temporal.
- Correccion de orientacion.
- Recorte a la proporcion de plantilla.
- Redimensionado.
- Conversion a WebP.
- Miniatura WebP.
- Persistencia en carpeta del proyecto o coleccion instalada.

Videos:

- Seleccion desde galeria.
- Lectura de duracion y dimensiones.
- Rechazo o recorte si supera 15 segundos.
- Normalizacion a MP4 H.264.
- Audio AAC si existe pista de audio.
- Resolucion maxima inicial 1280 x 720.
- Extraccion del primer fotograma como miniatura.
- Conservacion del sonido durante compresion.

La UI usara miniaturas en listados. Los reproductores de video se inicializaran solo para la carta visible o abierta y se liberaran al salir.

## Importacion y exportacion

El formato `.friendpack` sera un contenedor comprimido con:

```text
manifest.json
collection.json
rarities.json
cards.json
pack_types.json
pack_rules.json
assets/
checksums.json
```

Exportacion:

- Se crea un archivo temporal.
- Se escriben JSON y activos por streaming.
- Se calcula SHA-256 por archivo.
- Se cierra el contenedor.
- Se verifica.
- Se comparte mediante UI nativa.

Importacion:

- Se copia el archivo a temporal.
- Se lee y valida `manifest.json`.
- Se comprueba version, UUID y duplicados.
- Se muestra previsualizacion.
- Se extrae de forma segura sin permitir rutas fuera del destino.
- Se validan JSON, relaciones, extensiones, tamanos y hashes.
- Se copian activos a almacenamiento definitivo.
- Se insertan datos y tres sobres iniciales en una transaccion.
- Se limpian temporales.

El progreso de quien exporta no se incluye en `.friendpack`.

## Migraciones

Habra dos niveles de versionado:

- `schemaVersion`: version de la base de datos local Drift.
- `formatVersion` y `contentVersion`: version del formato exportable y del contenido de una coleccion.

Reglas:

- Toda migracion de base de datos tendra prueba.
- Las migraciones seran hacia adelante y no dependeran de nombres visibles.
- Los UUID no se regeneran durante migraciones.
- Las migraciones de contenido instalado no se implementaran en la primera version, pero el modelo se disena para soportarlas.
- Cualquier cambio de arquitectura relevante se documentara en `docs/decisions/`.

## Errores

El dominio expondra errores tipados, por ejemplo:

- `InsufficientStorage`
- `InvalidCollectionFile`
- `UnsupportedFormatVersion`
- `CollectionAlreadyInstalled`
- `MissingMediaAsset`
- `InvalidProbabilityDistribution`
- `NoEligibleCards`
- `MediaProcessingFailed`
- `NotificationPermissionDenied`
- `DatabaseFailure`
- `ExportCancelled`
- `ImportCancelled`

La infraestructura convertira excepciones tecnicas a errores de dominio o aplicacion. La presentacion mostrara mensajes comprensibles en espanol y no filtrara stack traces al usuario.

## Pruebas

Pruebas unitarias:

- Probabilidades y seleccion por rareza.
- Reglas de posicion.
- Duplicados y venta.
- Coste de aceleracion.
- Temporizadores.
- Validaciones de proyectos.
- Versiones y checksums.

Pruebas de aplicacion:

- Finalizacion de coleccion.
- Apertura atomica.
- Entrega de tres sobres iniciales.
- Importacion transaccional.
- Exportacion por streaming.
- Recuperacion tras cierre durante apertura.

Pruebas de datos:

- DAOs y migraciones Drift.
- Integridad referencial.
- Cascadas de borrado.
- Separacion entre contenido y progreso.

Pruebas de infraestructura:

- Servicios de archivos con rutas relativas.
- Extraccion segura contra path traversal.
- Procesamiento multimedia mediante fakes y fixtures.
- Notificaciones con adaptadores mockeables.

Pruebas de presentacion:

- Widgets de formularios.
- Estados de error, carga y vacio.
- Accesibilidad basica.
- Reduccion de animaciones.

Comandos obligatorios al cerrar cada fase:

```text
dart format .
flutter analyze
flutter test
```

Cuando la fase toque Android, tambien se verificara compilacion Android. iOS requerira Mac con Xcode.
