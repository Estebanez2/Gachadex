# Creador de borradores

Fecha: 2026-08-05

Documento operativo de la Fase 3. Describe el alcance implementado para crear y
editar borradores locales de coleccion.

## Alcance

La Fase 3 permite:

- Ver una biblioteca de borradores en la pestana `Crear`.
- Crear un borrador nuevo con version de contenido `1`.
- Editar nombre, autor y descripcion.
- Elegir una portada provisional generada en Flutter.
- Crear, editar, reordenar y borrar rarezas.
- Guardar automaticamente y recuperar el borrador tras reiniciar la app.
- Borrar un borrador con confirmacion.

No permite crear cartas, importar multimedia, crear sobres, finalizar
colecciones ni jugar.

## Rutas

- `/create`: lista de borradores.
- `/create/new`: crea un borrador y redirige al editor.
- `/create/project/:projectId`: editor del borrador.

Las rutas se centralizan en `lib/app/router/app_routes.dart`.

## Guardado automatico

`CollectionDraftController` mantiene el estado editable y aplica un debounce de
550 ms antes de persistir cambios validos. Al salir del editor o cuando la app
pasa a `inactive`/`paused`, se llama a `flushPendingSave()`.

Los estados visibles son:

- `Guardado`
- `Pendiente`
- `Guardando`
- `Corrige los campos para guardar`
- `No se pudo guardar`

Los campos demasiado largos se conservan en pantalla, pero no sobrescriben el
valor persistido hasta que vuelven a ser validos.

## Portada provisional

La portada usa `DraftCoverStyle` y `DraftCoverCatalog`. Se guardan ids estables
de color principal, color secundario, icono y patron en `collection_projects`.
No se crea ningun `MediaAsset`, ruta falsa ni archivo multimedia.

## Rarezas

Las rarezas usan `RarityVisualCatalog` para color, icono, marco y efecto. El
nombre se normaliza para detectar duplicados ignorando mayusculas y espacios
exteriores. El valor de venta debe ser no negativo y no superar el maximo de la
fase.

Al borrar una rareza, el repositorio comprueba `countCardsUsingRarity`. En Fase
3 todavia no hay UI de cartas, pero la proteccion ya existe para no romper
contenido cuando esa fase llegue.

## Persistencia

La persistencia vive en SQLite/Drift. La version de esquema actual es `2` y
anade a `collection_projects` las columnas de portada provisional. El progreso
del jugador sigue separado de la definicion de contenido.

La persistencia se cubre con un test que crea una base en archivo temporal,
guarda borrador, portada y varias rarezas, cierra SQLite, reabre el archivo y
comprueba que los datos y el orden se conservan.
