# Roadmap

Fecha: 2026-08-11

Este roadmap ordena el trabajo practico. La fase 0 documental queda separada de
la implementacion tecnica.

## Fase 0 - Foundation docs

Estado: completada.

Incluye documentacion base, analisis de referencias, arquitectura inicial,
roadmap, dependencias, avisos de terceros, README y endurecimiento de
`.gitignore`.

## Fase 1 - Base tecnica ejecutable

Estado: completada.

Incluye estructura feature-first, tema propio, GoRouter, Riverpod, logging,
errores base, internacionalizacion en espanol, pantallas placeholder y pruebas
de arranque, navegacion, tema, localizacion y accesibilidad basica.

No incluye persistencia, modelos de producto, multimedia, temporizadores,
gachacoin, notificaciones, importacion ni exportacion.

## Fase 2 - Modelo de dominio y persistencia local

Estado: implementada en la rama `phase/02-domain-database`.

Incluye:

- Modelo de dominio inicial independiente de Drift.
- UUID permanentes tipados.
- `Clock` inyectable.
- Rutas multimedia relativas.
- Drift + SQLite.
- Esquema v1 con tablas de contenido, definicion y progreso.
- Migraciones preparadas.
- DAOs, mappers, repositorios y providers Riverpod.
- Base en memoria para tests.
- Tests de dominio, restricciones, relaciones, transacciones, streams y
  persistencia en archivo temporal.

No incluye:

- Formularios completos.
- Seleccion o procesamiento multimedia.
- Apertura visual de sobres.
- Probabilidades ejecutables.
- Temporizadores reales.
- Tres sobres iniciales.
- Economia visible.
- Notificaciones.
- Importacion/exportacion.

## Fase 3 - Creador sin multimedia avanzada

Estado: implementada en la rama `phase/03-collection-drafts`.

Objetivo de esta entrega: crear y recuperar borradores de coleccion, editar
informacion general, usar una portada provisional generada en Flutter y gestionar
rarezas sin multimedia avanzada.

Incluye:

- Biblioteca real de borradores en `/create`.
- Creacion atomica de borrador y version de contenido.
- Editor en `/create/project/:projectId`.
- Nombre, autor y descripcion con validaciones y contadores.
- Portada provisional por catalogos de color, acento, icono y patron.
- Autosave con debounce, estados de guardado y recuperacion tras reinicio.
- Estado incompleto por secciones de esta fase.
- CRUD de rarezas con catalogos visuales propios y valor de venta.
- Reordenacion de rarezas y proteccion al borrar si existen cartas asociadas.
- Borrado de borrador con confirmacion.
- Tests de validacion, controlador, widgets, repositorios y persistencia en
  archivo.

No incluye:

- Creacion de cartas.
- Seleccion, normalizacion o reproduccion de fotos/videos.
- Tipos de sobre, pools, probabilidades ni reglas de slots.
- Finalizacion, instalacion o juego de colecciones desde la UI.

Depende de: fase 2.

## Fase 4 - Cartas con fotografias

Estado: implementada en la rama `phase/04-image-cards`.

Incluye:

- Seccion Cartas dentro del editor de borrador.
- Creacion, edicion y eliminacion de cartas con fotografia.
- Selector de galeria, recorte nativo, WebP principal y miniatura WebP.
- Rutas relativas en SQLite y archivos en almacenamiento privado.
- Plantillas propias sencillas, marco, colores y previsualizacion.
- Campos comicos del catalogo fijo.
- Coordinacion archivo/base en casos de uso y limpieza en flujos normales.
- Migracion de esquema v3 para el catalogo de campos de carta.
- Tests de validacion, repositorio, archivos y persistencia con base temporal.

No incluye:

- Videos.
- Sobres, pools, probabilidades ni apertura.
- Album jugable, temporizadores, gachacoin, notificaciones, importacion ni
  exportacion.

Depende de: fase 3.

## Fase 5 - Configuracion de sobres

Estado: implementada en la rama `phase/05-pack-configuration`.

Incluye:

- Seccion Sobres dentro del editor de borrador.
- Crear, editar, reordenar, eliminar y marcar sobre principal.
- Portada y reverso generados en Flutter mediante ids estables.
- Cartas elegibles con seleccion multiple.
- Reglas por posicion: rareza fija, distribucion y rareza minima.
- Pesos enteros por rareza.
- Motor puro de seleccion con `Random` inyectado, fallback y repetidas.
- Simulador dentro del editor sin modificar progreso.
- Migracion de esquema v4 para diseno de sobres y `minimumRarity` ponderada.
- Tests de motor, validacion, repositorio y persistencia.

No incluye finalizacion, coleccion instalada, entrega de sobres, temporizadores
activos, apertura visual, album jugable, gachacoin funcional, videos,
notificaciones, importacion ni exportacion.

Depende de: fase 4.

## Fase 6 - Coleccion jugable local

Estado: implementada en la rama `phase/06-finalize-install-timers`.

Incluye:

- Seccion Revision en el editor de borrador.
- Validacion completa por Informacion, Rarezas, Cartas y Sobres.
- Finalizacion transaccional e idempotente de una coleccion valida.
- Proyecto marcado como finalizado y fuera de la lista editable de borradores.
- Coleccion instalada local para el creador.
- Tres sobres iniciales en el sobre principal.
- Inventario para cada tipo de sobre.
- Temporizadores locales independientes por tipo de sobre, calculados en UTC.
- Refresco de inventarios al arrancar, al volver a primer plano y al abrir el
  detalle de una coleccion instalada.
- Pantalla Colecciones con colecciones instaladas y detalle de inventario.

No incluye apertura real de sobres, escritura de cartas obtenidas, album
jugable, venta de duplicados, economia usable, notificaciones, videos,
importacion ni exportacion.

Depende de: fase 5.

## Fase 7 - Apertura de sobres y album

Estado: implementada en la rama `phase/07-pack-opening-album`.

Incluye:

- Apertura real de sobres desde colecciones instaladas.
- Consumo atomico de un sobre disponible.
- Generacion de cartas con el motor de Fase 5.
- Escritura previa a UI de `PackOpening` y `PackOpeningCard`.
- Actualizacion de `OwnedCard`, repetidas, `wasNew` y `quantityAfter`.
- Recuperacion de apertura pendiente sin consumir otro sobre.
- Revelado basico carta a carta, salto y resumen.
- Album con obtenidas, faltantes ocultas, repetidas, cantidades, favoritas,
  filtros por estado/rareza/medio, orden y estadisticas basicas.

No incluye videos, venta de duplicados, economia usable, aceleracion,
notificaciones, importacion ni exportacion.

Depende de: fase 6.

## Fase 8 - Videos

Estado: implementada en la rama `phase/08-video-cards`.

Incluye seleccion de videos desde galeria, lectura de duracion y dimensiones,
rechazo de videos de mas de 15 segundos, normalizacion MP4 720p con audio,
thumbnail WebP del primer fotograma, rutas relativas, guardado/edicion/borrado
seguro, reproduccion en apertura y detalle de album, replay, pausa de ciclo de
vida y uso exclusivo de thumbnails en grids.

No incluye importacion/exportacion `.gachadex`, gachacoin, venta de duplicados,
aceleracion, notificaciones ni efectos visuales finales.

Depende de: fase 7.

## Fase 9 - Exportacion e importacion

Objetivo: compartir colecciones sin servidor.

Incluye formato `.gachadex`, manifest, JSON de contenido, activos,
checksums SHA-256, exportacion por streaming, comparticion nativa, importacion
segura, validacion, duplicados e importacion atomica.

Depende de: fases 7 y 8.

## Fase 10 - Economia

Objetivo: cerrar el ciclo de duplicados.

Incluye venta parcial, valores por rareza, gachacoin por coleccion, historial,
aceleracion de temporizadores y validaciones de saldo.

Depende de: fase 6.

## Fase 11 - Notificaciones locales

Objetivo: avisar de sobres disponibles sin servidor.

Incluye permisos, programacion/cancelacion/reprogramacion local, apertura desde
notificacion y recuperacion tras reinicio cuando la plataforma lo permita.

Depende de: fase 6 y de la estrategia de temporizadores.

## Fase 12 - Diseno y animaciones

Estado: implementada en la rama `phase/12-visual-polish`.

Objetivo: elevar la experiencia visual con identidad propia.

Incluye tokens de movimiento, accesos iniciales pulidos, animacion de apertura,
revelado con transiciones, efectos propios por rareza, feedback tactil,
apariciones suaves, indicadores visuales y respeto de reducir animaciones. No
copia Pokemon TCG ni efectos de Altare de forma literal.

Depende de: fases 6, 7 y 10.

## Fase 13 - Estabilizacion y lanzamiento

Objetivo: preparar una primera version distribuible.

Incluye suite amplia, optimizacion, almacenamiento, accesibilidad, recuperacion
de errores, privacidad, identidad final, tutorial inicial, compilaciones
Android y preparacion iOS en Mac con Xcode.

Depende de: fases 1 a 10.

## Regla de avance

No se empezara una fase nueva hasta que la fase actual tenga documentacion,
pruebas, `dart format .`, `flutter analyze`, `flutter test`, revision de diff y
verificacion manual descrita.
