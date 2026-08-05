# AGENTS.md

## Fuente de verdad del producto

Antes de planificar o modificar funcionalidades, lee:

* `docs/PRODUCT_SPEC.md`
* `docs/ARCHITECTURE.md`, cuando exista.
* `docs/ROADMAP.md`, cuando exista.
* `docs/REFERENCE_ANALYSIS.md`, cuando exista.

`docs/PRODUCT_SPEC.md` es la fuente de verdad funcional. No inventes cambios que contradigan ese documento.

## Objetivo del proyecto

Crear una aplicación Flutter para Android e iOS de colecciones de cartas personalizadas para grupos de amigos.

La aplicación debe funcionar localmente y sin conexión. Permitirá crear colecciones, cartas con fotografías o vídeos, rarezas, sobres, probabilidades, temporizadores, álbumes, duplicados, monedas e importación y exportación mediante archivos autosuficientes.

## Restricciones obligatorias

* No utilizar cuentas de usuario.
* No utilizar servidor.
* No utilizar Firebase, Supabase ni servicios equivalentes.
* No depender de Internet para jugar, importar o abrir sobres.
* No utilizar nombres, logotipos, marcos, imágenes ni recursos oficiales de Pokémon.
* No copiar la interfaz de Pokémon TCG Pocket de forma literal.
* Crear una identidad visual propia.
* No guardar fotografías o vídeos personales dentro del repositorio Git.
* No incrustar binarios multimedia en SQLite.
* Guardar únicamente rutas relativas y metadatos en la base de datos.
* No añadir compras con dinero real.
* No añadir partidas, combates o intercambios en la primera versión.
* No implementar funcionalidades futuras hasta que la fase actual esté terminada.
* No modificar los repositorios incluidos en `references/`.
* No usar WebView para ejecutar las aplicaciones React o JavaScript dentro de Flutter.
* No añadir una dependencia abandonada sin documentar antes sus riesgos y alternativas.
* No cambiar una decisión de arquitectura importante sin registrarla en `docs/decisions/`.

## Repositorios de referencia

Analiza estos repositorios cuando la tarea correspondiente lo necesite:

* `references/altare-tcg-2023`
* `references/react-card-builder`

Utilízalos para estudiar:

### Altare TCG

* Flujo de apertura de sobres.
* Selección por rarezas.
* Revelado de cartas.
* Efectos visuales.
* Seguimiento de colección.
* Contadores.
* Accesibilidad.
* Posibilidad de omitir o reducir animaciones.

### React Card Builder

* Composición de una carta mediante capas.
* Plantillas.
* Colocación y recorte de imágenes.
* Formularios de atributos.
* Previsualización en tiempo real.
* Generación de una representación exportable.

El código web no debe trasladarse mecánicamente. Reimplementa en Flutter y Dart las ideas que sean útiles.

## Licencias y atribución

Antes de copiar código, archivos o algoritmos identificables:

1. Comprueba la licencia del archivo y del repositorio.
2. Conserva los avisos exigidos.
3. Añade la atribución a `THIRD_PARTY_NOTICES.md`.
4. Copia la licencia necesaria a `third_party/licenses/`.
5. Documenta en el código el origen cuando se trate de una adaptación directa.

No asumas que una dependencia de un repositorio tiene automáticamente la misma licencia que el repositorio principal.

No reutilices recursos de Pokémon u otras marcas aunque aparezcan dentro de un repositorio de ejemplo.

## Arquitectura

Usa una arquitectura feature-first con separación clara entre:

* Presentación.
* Casos de uso.
* Dominio.
* Datos e infraestructura.

Estructura orientativa:

```text
lib/
  app/
  core/
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
```

Dentro de cada funcionalidad importante utiliza, cuando aporte valor:

```text
data/
domain/
presentation/
```

No crees abstracciones vacías ni capas sin una función real.

## Tecnologías base

Usa versiones estables compatibles con el Flutter instalado.

Tecnologías previstas:

* Flutter y Dart.
* Riverpod para estado e inyección.
* GoRouter para navegación.
* Drift y SQLite para persistencia local.
* UUID para identificadores permanentes.
* Path Provider para almacenamiento interno.
* Plugins multiplataforma mantenidos para selección y reproducción multimedia.
* Notificaciones locales, sin notificaciones push.

Aísla el procesamiento multimedia detrás de interfaces propias para poder sustituir plugins sin modificar el dominio.

## Modelo de datos

Los identificadores de colecciones, versiones, cartas, rarezas, tipos de sobre, activos multimedia, aperturas y transacciones deben ser UUID permanentes.

No utilices como identificador:

* El nombre.
* La posición en una lista.
* La ruta de un archivo.
* El número visible de una carta.
* Un índice de la interfaz.

El progreso del jugador debe estar separado de la definición inmutable de una colección.

Diseña desde el principio el contenido con `collectionId` y `contentVersion`, aunque la primera versión todavía no permita actualizar colecciones.

## Multimedia

* Fotografías normalizadas a WebP.
* Vídeos de hasta 15 segundos.
* Vídeos normalizados a MP4.
* Códec de vídeo H.264.
* Audio AAC cuando exista pista de audio.
* Resolución máxima inicial de 1280 × 720.
* Primer fotograma utilizado como portada.
* No eliminar el sonido durante la compresión.
* Usar miniaturas en listados.
* No inicializar todos los reproductores de vídeo simultáneamente.

## Calidad del código

* Null safety obligatoria.
* No utilizar `dynamic` salvo interoperabilidad justificada.
* Evitar archivos excesivamente grandes.
* Preferir clases y funciones pequeñas con responsabilidades claras.
* No introducir estado global mutable.
* No ignorar errores con bloques `catch` vacíos.
* Usar errores de dominio tipados.
* No mezclar consultas SQLite directamente dentro de widgets.
* Añadir comentarios solo cuando expliquen una decisión no evidente.
* Mantener nombres de código en inglés.
* Los textos visibles al usuario estarán inicialmente en español y preparados para internacionalización.

## Flujo de trabajo

Trabaja en una única fase por tarea.

Antes de modificar código:

1. Lee los documentos relevantes.
2. Inspecciona el código existente.
3. Explica brevemente el plan.
4. Identifica riesgos o incompatibilidades.

Durante el trabajo:

1. Haz cambios limitados a la fase solicitada.
2. Añade o actualiza pruebas.
3. No avances a la siguiente fase.
4. No realices refactorizaciones ajenas a la tarea.

Al terminar:

1. Ejecuta `dart format .`.
2. Ejecuta `flutter analyze`.
3. Ejecuta `flutter test`.
4. Ejecuta pruebas adicionales específicas de la fase.
5. Revisa el diff.
6. Resume los archivos modificados.
7. Indica los comandos ejecutados y sus resultados.
8. Describe cómo verificar manualmente el resultado.
9. Señala riesgos o trabajo pendiente.
10. Detente y espera la siguiente instrucción.

## Git

* No trabajes directamente sobre `main`.
* Usa una rama por fase.
* No hagas `push`, `merge`, rebase destructivo ni elimines ramas sin autorización expresa.
* No utilices `git reset --hard` para resolver problemas.
* No sobrescribas cambios del usuario.
* Antes de una modificación extensa, comprueba `git status`.
* Mantén commits pequeños y descriptivos.
* Usa mensajes de commit en inglés siguiendo un estilo como:

  * `chore: configure Flutter foundation`
  * `feat: add collection draft persistence`
  * `test: cover pack probability engine`
  * `fix: preserve pack progress after app restart`

## Dependencias

Antes de añadir una dependencia de producción:

1. Comprueba que sea compatible con Android e iOS.
2. Comprueba que siga mantenida.
3. Revisa su licencia.
4. Explica qué problema resuelve.
5. Evita dependencias que puedan sustituirse con una solución pequeña y estable.
6. Añade la información relevante a `docs/DEPENDENCIES.md`.

No fijes versiones antiguas solo porque aparezcan en los repositorios React de referencia.

## Definition of Done

Una tarea solo está terminada cuando:

* Cumple el comportamiento solicitado.
* No contradice `docs/PRODUCT_SPEC.md`.
* Tiene pruebas adecuadas.
* `dart format .` no deja cambios pendientes.
* `flutter analyze` termina sin errores.
* `flutter test` termina correctamente.
* La persistencia sobrevive al reinicio cuando corresponda.
* Android sigue compilando.
* No se han incluido archivos personales ni secretos.
* La documentación afectada está actualizada.
* Se ha explicado una forma concreta de verificación manual.
