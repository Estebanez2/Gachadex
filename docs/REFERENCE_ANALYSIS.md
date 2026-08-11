# Analisis de repositorios de referencia

Fecha: 2026-08-05

Este documento resume el analisis de los submodulos:

- `references/altare-tcg-2023` en `4e54097600ac68177f788350605857627ea62d9c`
- `references/react-card-builder` en `ddbdabf43d6cc91842a85006182af9f143b7777a`

No se ha copiado codigo ni recursos desde estos repositorios. Las conclusiones sirven para orientar una reimplementacion propia en Flutter y Dart, compatible con `docs/PRODUCT_SPEC.md`.

## Altare TCG 2023

### Arquitectura y tecnologias

Altare es una aplicacion web estatica formada por HTML, CSS y JavaScript modular sin framework de UI. La informacion de cartas vive en CSV y se carga en cliente con Papa Parse. La carta se renderiza como un Web Component `tcg-card`, con un fragmento HTML compartido para frente/reverso y CSS para disposicion, volteo y efectos.

Persistencia: `localStorage` del navegador.

Dependencias declaradas: ninguna de produccion en `package.json`; solo `live-server` y `prettier` como dev dependencies. Tambien incluye copias minificadas de `papaparse.min.js` y `a11y-dialog.min.js`.

Licencia del repo: `LICENSE` declara MIT. Aun asi, los efectos de cartas requieren revision separada porque `README.md` acredita `pokemon-cards-css` y `css/card.css` repite ese credito.

### Funciones relevantes

- Apertura de sobres con posiciones fijas y probabilidades por rareza.
- Seleccion aleatoria por rareza y despues por carta.
- Revelado de cartas una a una con reverso, volteo y modo pila o cuadricula.
- Seguimiento de cartas obtenidas y contador de tiradas en `localStorage`.
- Album con alternancia entre coleccion completa y cartas obtenidas.
- Ordenacion, busqueda y paginacion del album.
- Atributos de accesibilidad: `aria-live`, skip link, controles por teclado, dialog accesible y opcion de reducir animaciones.

### Apertura de sobres

Archivos concretos:

- `references/altare-tcg-2023/pages/gacha.html`: controles de apertura, modo pila/cuadricula, checkbox para desactivar animaciones, contador y region `aria-live`.
- `references/altare-tcg-2023/js/gacha.js`: define `slots`, `specialSlots`, `pullCards`, `getRandomCards`, `pullAndRenderCards` y `testRates`.
- `references/altare-tcg-2023/js/cards.js`: define el Web Component, el volteo, el apilado visual, el z-index, la restauracion de accesibilidad tras revelar y la actualizacion del modo de vista.
- `references/altare-tcg-2023/css/card.css`: animaciones `left`, `flip`, clases de pila/cuadricula y efectos visuales.

Observacion para Friend Cards: el algoritmo de seleccion por pesos es portable conceptualmente, pero debe cambiarse para soportar las reglas del producto: UUID, `pack_slot_rules`, validacion previa, transaccion local, guardado del resultado antes de animar y repeticion permitida incluso dentro del mismo sobre.

### Rarezas

Archivos concretos:

- `references/altare-tcg-2023/Regis Altare Card List CSV.csv`: columna `Rarity Folder` con valores como `Element`, `Common`, `Uncommon`, `Rare`, `HoloRare`, `UltraRare`, `SecretRare`.
- `references/altare-tcg-2023/js/main.js`: agrupa cartas por rareza en `cards_by_rarity`.
- `references/altare-tcg-2023/js/gacha.js`: usa rarezas como claves de pesos por posicion.
- `references/altare-tcg-2023/js/cards.js`: `setCardRarity` traduce rarezas altas a clases visuales `holo`, `ultra` y `secret`.
- `references/altare-tcg-2023/css/card.css`: define capas visuales para `basic`, `holo`, `ultra` y `secret`.

Observacion para Friend Cards: la idea de agrupar por rareza y usar una lista ordenada es util. No se deben reutilizar nombres, colores, texturas ni efectos de Altare.

### Seguimiento de coleccion

Archivos concretos:

- `references/altare-tcg-2023/js/gacha.js`: guarda `pull-count`, `special-count`, `card-{Collector Number}` y `count-{Rarity Folder}` en `localStorage`.
- `references/altare-tcg-2023/js/collection.js`: implementa `getOwnedCards`, ordenacion por numero o rareza, busqueda, paginacion, contador de cartas obtenidas y cierre del aviso inicial.
- `references/altare-tcg-2023/pages/collection.html`: controles de mostrar coleccion completa, reiniciar, ordenar, paginar y buscar.
- `references/altare-tcg-2023/js/main.js`: configura controles de coleccion y reseteo de `localStorage`.

Observacion para Friend Cards: el producto necesita cantidades, duplicados, favoritos, monedas, historial y recuperacion tras cierre. Por tanto, la persistencia debe ser SQLite/Drift, no `localStorage`.

### Plantillas y edicion de cartas

Altare no es un editor de cartas. Renderiza cartas finalizadas como imagenes completas.

Archivos concretos:

- `references/altare-tcg-2023/card.html`: estructura generica de frente, reverso e imagen de carta.
- `references/altare-tcg-2023/js/cards.js`: crea el componente `tcg-card`, busca datos por `Collector Number` y aplica la imagen como fondo.
- `references/altare-tcg-2023/details-dialog.html` y `references/altare-tcg-2023/js/dialog.js`: detalle de carta con metadatos, descripciones y dialog accesible.

Observacion para Friend Cards: solo sirve como inspiracion para componente de vista, no para edicion ni composicion por capas.

### Carga y colocacion de imagenes

Archivos concretos:

- `references/altare-tcg-2023/js/cards.js`: `CARD_IMAGES_URL`, `getImageURL` y `backgroundImage`.
- `references/altare-tcg-2023/css/card.css`: `background-size`, `background-position`, proporciones y escalado responsive.
- `references/altare-tcg-2023/images/Card Images/**`: cartas renderizadas finales por rareza.
- `references/altare-tcg-2023/Regis Altare Card List CSV.csv`: relacion entre rareza, archivo, numero, nombre, creditos y texto alternativo.

Observacion para Friend Cards: usar rutas relativas y metadatos es compatible con la spec, pero las imagenes de Altare no deben reutilizarse.

### Exportacion

Altare no implementa exportacion de colecciones jugables. Tiene enlaces externos de descarga a PDF o formato accesible.

Archivos concretos:

- `references/altare-tcg-2023/pages/credits.html`
- `references/altare-tcg-2023/index.html`
- `references/altare-tcg-2023/pages/gacha.html`
- `references/altare-tcg-2023/pages/collection.html`

Observacion para Friend Cards: no sirve para `.gachadex`; la exportacion debera ser nueva, local, atomica, por streaming y con checksums.

### Codigo que podria portarse a Dart

- Seleccion por pesos de rareza desde `js/gacha.js`, reescrita en dominio Dart y probada con casos unitarios.
- Agrupacion de cartas por rareza desde `js/main.js`, adaptada a entidades con UUID.
- Ordenacion, busqueda y paginacion conceptual desde `js/collection.js`.
- La idea de separar resultado de apertura y revelado visual, aunque en Altare todavia estan mas acoplados de lo que acepta Friend Cards.

### Codigo solo como inspiracion

- Web Components, manipulacion directa del DOM y HTML string templates.
- `localStorage` como persistencia.
- Pila/cuadricula de cartas en CSS.
- Dialog web con `a11y-dialog`.
- Efectos de brillo y holograma.
- Controles de accesibilidad y reduccion de movimiento, como requisitos de UX, no como implementacion literal.

### Recursos que no deben reutilizarse

- Imagenes de Regis Altare, Holostars/Hololive, fan arts, logos, chibi, iconos, fondos, reversos de cartas y GIFs.
- CSVs de cartas, mensajes, creditos y autores.
- Textos, descripciones, nombres de rareza y cualquier identidad visual del proyecto.
- Efectos visuales derivados de `pokemon-cards-css` sin revision de licencia y rediseno.
- Cualquier estetica que copie o recuerde de forma literal a Pokemon TCG.

### Dependencias y licencias a revisar

- `pokemon-cards-css`: acreditado en `README.md` y `css/card.css`; requiere revisar licencia original antes de adaptar cualquier idea identificable.
- `papaparse.min.js`: cabecera indica MIT; no se necesita en Flutter salvo para herramientas puntuales de migracion.
- `a11y-dialog.min.js`: cabecera indica `a11y-dialog 7.5.2`; no aplica a Flutter, pero sus patrones de accesibilidad son buena referencia.
- `live-server` y `prettier`: dev dependencies web, no trasladables a la app.

## React Card Builder

### Arquitectura y tecnologias

React Card Builder es una aplicacion React creada con `react-scripts`, Tailwind CSS y componentes funcionales. La raiz `src/App.js` mantiene estado controlado para todos los campos de formulario, captura el nodo de carta con `html-to-image`, vuelca el resultado a un canvas y permite exportar PNG o PDF con `jspdf`. Tambien muestra una previsualizacion 3D con Three.js, `@react-three/fiber`, `@react-three/drei` y `OrbitControls`.

El README indica que el proyecto esta archivado, deprecado y sin mantenimiento. Tambien dice que la licencia es MIT, pero en la copia local no existe un archivo `LICENSE`, por lo que cualquier reutilizacion directa queda bloqueada hasta verificar la licencia real del repositorio y de cada recurso.

### Funciones relevantes

- Formularios controlados por campos.
- Previsualizacion en tiempo real.
- Seleccion de plantilla.
- Carga local de imagen mediante input de archivo.
- Composicion visual por capas absolutas.
- Exportacion a PNG y PDF.
- Vista 3D opcional de frente y reverso.

### Apertura de sobres

No implementa apertura de sobres, probabilidades ni generacion aleatoria.

### Rarezas

Archivos concretos:

- `references/react-card-builder/src/components/lorcana/Form.js`: selector `rarity`.
- `references/react-card-builder/src/components/lorcana/Card.js`: muestra icono de rareza desde `./lorcana/icons/{rarity}.png`.
- `references/react-card-builder/public/lorcana/icons/*.png`: iconos de rareza de Lorcana.

Observacion para Friend Cards: solo aporta la idea de que la rareza puede tener una representacion visual seleccionable. No se deben reutilizar iconos, nombres ni estilo Lorcana.

### Seguimiento de coleccion

No implementa album, progreso, copias, duplicados ni persistencia de coleccion.

### Plantillas y edicion de cartas

Archivos concretos:

- `references/react-card-builder/src/App.js`: estado unico `inputValues`, cambios por `handleInputChange`, tipo de builder y captura para previsualizacion.
- `references/react-card-builder/src/components/lorcana/Form.js`: formulario de plantilla, nombre, coste, campos, arte, rareza y creditos.
- `references/react-card-builder/src/components/lorcana/Card.js`: composicion por capas absolutas con arte, marco, iconos y textos.
- `references/react-card-builder/src/components/yugioh/Form.js`: formulario condicional segun plantilla, generacion de identificador visible y campos numericos.
- `references/react-card-builder/src/components/yugioh/Card.js`: composicion por capas absolutas para otra familia de plantilla.
- `references/react-card-builder/src/index.css`: fuentes locales y clases tipograficas para las plantillas.

Observacion para Friend Cards: la estructura de "descriptor de plantilla + areas fijas + preview reactiva" encaja con la spec. Debe reimplementarse con widgets Flutter y modelos propios, no con WebView ni React.

### Carga y colocacion de imagenes

Archivos concretos:

- `references/react-card-builder/src/App.js`: `handleFileChange` usa `URL.createObjectURL(file)` y carga una imagen local.
- `references/react-card-builder/src/components/lorcana/Form.js`: input `type="file"` con `accept="image/*"`.
- `references/react-card-builder/src/components/yugioh/Form.js`: input `type="file"` con `accept="image/*"`.
- `references/react-card-builder/src/components/lorcana/Card.js`: coloca `inputValues.artwork` como `backgroundImage` dentro de un area fija.
- `references/react-card-builder/src/components/yugioh/Card.js`: coloca `inputValues.artwork` como `backgroundImage` dentro de un area fija.

Observacion para Friend Cards: usar areas multimedia fijas es una idea valida. La app necesita ademas recorte, normalizacion, WebP, MP4, miniaturas y rutas relativas persistidas.

### Exportacion

Archivos concretos:

- `references/react-card-builder/src/App.js`: `handleCapture`, `toPng`, canvas 2D, `saveAsImage` y `saveAsPDF`.
- `references/react-card-builder/src/components/CardPage.js`: carga imagenes y crea previsualizacion 3D.
- `references/react-card-builder/src/components/Card.js`: mapea texturas de frente y reverso en un mesh.

Observacion para Friend Cards: exportar una carta como imagen/PDF queda fuera de la primera version. La exportacion prioritaria sera `.gachadex`, por streaming, con manifiesto, JSON, activos y SHA-256.

### Codigo que podria portarse a Dart

- Modelo conceptual de campos controlados y previsualizacion inmediata.
- Separacion entre formulario y preview.
- Descriptor de plantillas con areas fijas.
- Exportacion de una representacion visual solo como funcion futura, no para la primera version.

### Codigo solo como inspiracion

- Componentes React y Tailwind.
- Captura DOM con `html-to-image`.
- Generacion de PDF con `jspdf`.
- Previsualizacion 3D con Three.js.
- Posiciones absolutas concretas y medidas de plantillas existentes.
- Flujo de dos juegos concretos como categorias de plantilla.

### Recursos que no deben reutilizarse

- Plantillas, reversos, iconos, nombres y disposicion visual de Lorcana.
- Plantillas, reversos, iconos, nombres, fuentes y disposicion visual de Yu-Gi-Oh.
- Textos de copyright `Disney Lorcana` y `KONAMI`.
- Fuentes en `src/fonts/lor/**` y `src/fonts/yu/**` hasta verificar licencias independientes.
- Logos y favicons del repositorio.

### Dependencias y licencias a revisar

- El repositorio esta archivado y el README enlaza a `LICENSE`, pero el archivo no esta presente en la copia local.
- Dependencias principales: `react`, `react-scripts`, `tailwindcss`, `html-to-image`, `html2canvas`, `jspdf`, `three`, `@react-three/fiber`, `@react-three/drei`, `react-material-symbols`.
- `package-lock.json` contiene varias dependencias o transitivas marcadas como `deprecated`; no se deben trasladar versiones ni dependencias a Flutter.
- Los recursos de marcas y fuentes requieren revision por archivo, no por licencia global.

## Matriz de reutilizacion

| Necesidad de Friend Cards | Repositorio de referencia | Archivo o modulo | Forma de reutilizacion | Riesgo | Decision |
| --- | --- | --- | --- | --- | --- |
| Abrir sobres por posiciones | Altare | `js/gacha.js` | Reimplementar algoritmo de pesos en dominio Dart | Bajo si se reescribe; requiere adaptar repetidos y transacciones | Portar concepto, no codigo |
| Probabilidades por rareza | Altare | `js/gacha.js`, `js/main.js` | Usar idea de pesos acumulados por rareza | Medio: Altare no valida configuracion ni fallback por rareza vacia | Reimplementar con validaciones de spec |
| Garantias por posicion | Altare | `js/gacha.js` `slots` | Inspirar `pack_slot_rules` | Bajo | Reimplementar con entidades propias |
| Resultado antes de animacion | Altare | `js/gacha.js`, `js/cards.js` | Separar mas claramente en Friend Cards | Medio: en Altare generacion y UI estan acopladas | Implementar desde cero |
| Revelado carta a carta | Altare | `js/cards.js`, `css/card.css`, `pages/gacha.html` | Inspiracion de flujo y estados | Alto si se copian animaciones o estetica | Solo inspiracion |
| Reducir animaciones | Altare | `pages/gacha.html`, `js/cards.js`, `css/card.css` | Requisito UX y accesibilidad | Bajo | Implementar equivalente Flutter |
| Anuncios accesibles | Altare | `pages/gacha.html`, `js/cards.js` | Inspirar semantica y feedback | Bajo | Implementar con `Semantics` y textos localizados |
| Seguimiento de cartas obtenidas | Altare | `js/gacha.js`, `js/collection.js` | Inspirar contadores basicos | Medio: `localStorage` no sirve para progreso complejo | Usar Drift/SQLite |
| Album con filtros | Altare | `js/collection.js`, `pages/collection.html` | Inspirar busqueda, ordenacion y paginacion | Bajo | Reimplementar con repositorios y queries |
| Duplicados y cantidades | Altare | No cubierto; solo booleanos por carta | No reutilizable | Alto si se fuerza el modelo | Implementar modelo propio |
| Rarezas visuales | Altare | `js/cards.js`, `css/card.css` | Inspiracion de mapear rareza a efecto | Alto por `pokemon-cards-css` y estetica Pokemon | No copiar; disenar identidad propia |
| Efectos holograficos | Altare | `css/card.css` | Solo estudiar restricciones tecnicas | Alto por licencia y marca | Bloqueado hasta revision; preferir efectos propios |
| Carga CSV | Altare | `js/main.js`, CSVs | No necesaria en producto final | Bajo | Solo podria servir para migraciones internas |
| Cartas como imagen completa | Altare | `images/Card Images/**` | No reutilizar | Alto por derechos y datos de fans | Vetado |
| Plantillas editables | React Card Builder | `src/components/lorcana/Card.js`, `src/components/yugioh/Card.js` | Inspirar descriptor de capas fijas | Alto por marcas y layout copiable | Reimplementar con plantillas propias |
| Formularios de carta | React Card Builder | `src/components/lorcana/Form.js`, `src/components/yugioh/Form.js` | Inspirar campos controlados y preview | Medio: campos no coinciden con spec | Crear formularios propios |
| Carga de imagen | React Card Builder | `src/App.js`, forms | Inspirar flujo selector -> preview | Medio: no normaliza ni persiste | Implementar con servicios multimedia |
| Colocacion de imagen | React Card Builder | `src/components/*/Card.js` | Inspirar area multimedia fija | Alto si se copian coordenadas | Usar areas propias por plantilla |
| Exportar carta como PNG/PDF | React Card Builder | `src/App.js` | Funcion futura fuera de v1 | Medio: DOM capture no aplica a Flutter | No implementar en primera version |
| Previsualizacion 3D | React Card Builder | `src/components/CardPage.js`, `src/components/Card.js` | Inspiracion futura | Medio: Three.js no aplica a Flutter movil | No incluir en primera version |
| Exportar coleccion `.gachadex` | Ambos | No cubierto | Sin reutilizacion directa | Bajo | Disenar formato propio |
| Licencias y atribucion | Ambos | `LICENSE`, `README.md`, minified libs, assets | Revisar antes de cualquier copia futura | Alto en React por LICENSE ausente y marcas | No copiar nada en fase 0 |

## Decision general

Altare aporta el mejor mapa de flujo para apertura, rarezas, revelado, album y accesibilidad. React Card Builder aporta el mejor mapa para formularios, plantillas cerradas, composicion visual y preview. En ambos casos la reutilizacion sera conceptual. El codigo, assets, fuentes, marcas, nombres y efectos identificables no se incorporaran a Friend Cards sin revision independiente, atribucion y una decision documentada.
