# Especificación funcional y técnica de la aplicación de cartas coleccionables

## 1. Resumen del producto

La aplicación será una plataforma móvil para **Android e iPhone** orientada a grupos de amigos. Permitirá crear colecciones de cartas personalizadas y graciosas utilizando fotografías o vídeos de la galería del móvil.

Cada colección podrá contener:

* Todas las cartas que quiera el creador.
* Rarezas personalizadas.
* Uno o varios tipos de sobres.
* Diferentes diseños visuales.
* Probabilidades por rareza.
* Temporizadores independientes para cada tipo de sobre.
* Una economía local basada en monedas.
* Un álbum donde consultar cartas obtenidas, faltantes y repetidas.

La colección completa podrá exportarse como un único archivo. Otra persona podrá recibir ese archivo, importarlo en su móvil y comenzar a abrir sobres sin necesitar Internet, una cuenta ni un servidor.

La aplicación no utilizará elementos, nombres, marcos, iconos ni diseños oficiales de Pokémon. La inspiración estará únicamente en conceptos generales como:

* Apertura de sobres.
* Colección de cartas.
* Rarezas.
* Animaciones de revelado.
* Cartas repetidas.
* Temporizadores.
* Monedas para reducir esperas.

## 2. Principios obligatorios

Estos principios deben mantenerse durante todo el desarrollo.

### 2.1. Funcionamiento local

Toda la aplicación funcionará sin conexión a Internet.

Se guardarán localmente:

* Colecciones creadas.
* Colecciones importadas.
* Fotografías.
* Vídeos.
* Miniaturas.
* Progreso del álbum.
* Sobres disponibles.
* Temporizadores.
* Monedas.
* Cartas repetidas.
* Historial de aperturas y ventas.

No habrá:

* Registro.
* Inicio de sesión.
* Servidor.
* Sincronización automática.
* Base de datos online.
* Catálogo público.
* Amigos dentro de la aplicación.
* Compras con dinero real.

### 2.2. Android e iPhone

El proyecto se desarrollará con Flutter para compartir la mayor parte del código entre Android e iOS.

El desarrollo inicial podrá hacerse en Windows y probarse en Android. Para compilar, probar y publicar la versión de iPhone será necesario utilizar un Mac con Xcode.

### 2.3. Separación entre creación y juego

La aplicación tendrá dos contextos distintos:

1. **Proyecto de creación:** colección que todavía se está preparando.
2. **Colección instalada:** versión cerrada que ya se puede jugar.

Esta separación es fundamental.

Mientras una colección esté en creación, se podrá modificar libremente. Cuando el creador la finalice:

* Se generará una versión jugable inmutable.
* Se podrá exportar.
* Se instalará también en el dispositivo del creador.
* El creador recibirá los mismos tres sobres iniciales que cualquier persona que la importe.
* El progreso del álbum quedará separado de los datos originales de creación.

Aunque inicialmente no se puedan editar colecciones finalizadas, esta estructura permitirá añadir actualizaciones posteriormente sin rehacer toda la aplicación.

## 3. Alcance de la primera versión

La primera versión funcional deberá incluir todo lo siguiente.

### 3.1. Creación

* Crear una colección.
* Añadir nombre, portada, autor y descripción.
* Crear rarezas personalizadas.
* Crear cartas con foto o vídeo.
* Añadir nombre, vida y campos cómicos.
* Elegir una plantilla visual.
* Crear varios tipos de sobres.
* Configurar probabilidades por rareza.
* Configurar cartas garantizadas mediante reglas de posiciones.
* Configurar el tiempo de recarga.
* Configurar la acumulación máxima.
* Configurar precios de venta y aceleración.
* Finalizar la colección.

### 3.2. Exportación e importación

* Exportar una colección completa en un único archivo.
* Compartir el archivo mediante las opciones del sistema.
* Seleccionar un archivo recibido.
* Validarlo.
* Importarlo.
* Impedir que la misma colección se importe dos veces.
* Copiar fotografías y vídeos al almacenamiento interno de la aplicación.

### 3.3. Juego y colección

* Recibir tres sobres iniciales.
* Acumular sobres según el temporizador.
* Recibir notificaciones locales.
* Abrir sobres con animaciones.
* Reproducir vídeos automáticamente al revelar las cartas.
* Guardar cartas obtenidas.
* Permitir cartas repetidas.
* Mostrar cartas faltantes.
* Mostrar cantidades de cada carta.
* Vender duplicados.
* Obtener monedas.
* Usar monedas para completar uno o varios temporizadores.

### 3.4. Exclusiones de la primera versión

No se incluirán inicialmente:

* Partidas con reglas.
* Mazos.
* Combates.
* Intercambios.
* Cuentas.
* Servidores.
* Sincronización.
* Colecciones públicas.
* Actualización de colecciones ya instaladas.
* Edición de cartas después de finalizar una colección.
* Compras con dinero real.
* Protección contra cambiar manualmente la hora.
* Moderación de contenido.
* Exportación del álbum en PDF.
* Grabación automática de aperturas.
* Editor visual completamente libre.

## 4. Terminología

### Colección

Conjunto completo de cartas, rarezas, sobres y configuraciones.

Ejemplo:

> Viaje a Londres 2026

### Proyecto de colección

Versión editable de una colección antes de ser finalizada.

### Colección instalada

Copia inmutable utilizada para abrir sobres y registrar progreso.

### Carta

Elemento coleccionable individual con fotografía o vídeo, nombre, rareza, vida y datos cómicos.

### Rareza

Categoría visual y probabilística de una carta.

Ejemplos:

* Normal.
* Graciosa.
* Legendaria.
* Vergonzosa.
* Prohibida.
* Mítica.

### Tipo de sobre

Configuración concreta de sobre con imagen, número de cartas, probabilidades, cartas disponibles y temporizador propio.

### Álbum

Vista del progreso del usuario en una colección.

### Copia

Cantidad de veces que el usuario ha obtenido una misma carta.

### Duplicado

Cualquier copia adicional después de la primera.

### Sobre principal

Tipo de sobre marcado como principal. Los tres sobres iniciales serán de este tipo.

## 5. Flujo general del creador

El flujo completo de creación será:

1. Abrir la aplicación.
2. Entrar en **Crear colección**.
3. Introducir los datos generales.
4. Crear las rarezas.
5. Crear las cartas.
6. Crear uno o varios tipos de sobres.
7. Marcar uno como sobre principal.
8. Configurar temporizadores, probabilidades y economía.
9. Revisar la colección.
10. Corregir errores.
11. Finalizarla.
12. Instalar automáticamente una copia jugable.
13. Recibir tres sobres del tipo principal.
14. Exportar el archivo para compartirlo.

La aplicación debe guardar automáticamente el borrador después de cada cambio.

Si se cierra la aplicación durante la creación, el proyecto debe continuar exactamente desde donde estaba.

## 6. Flujo general de quien recibe una colección

1. Recibir el archivo por WhatsApp, correo, AirDrop, Drive, cable u otro medio.
2. Abrir la aplicación.
3. Pulsar **Importar colección**.
4. Seleccionar el archivo.
5. Ver una pantalla de previsualización.
6. Confirmar la importación.
7. Esperar a que se copien los contenidos.
8. Recibir tres sobres del tipo principal.
9. Empezar a abrirlos.
10. Consultar el álbum.
11. Esperar nuevos sobres.
12. Vender duplicados.
13. Utilizar monedas para acelerar recargas.

## 7. Arquitectura general

La aplicación debe separar claramente cuatro capas.

### 7.1. Presentación

Contiene:

* Pantallas.
* Widgets.
* Animaciones.
* Formularios.
* Navegación.
* Estados visuales.
* Reproductor de vídeo.
* Mensajes de error.

### 7.2. Aplicación

Contiene los casos de uso:

* Crear colección.
* Añadir carta.
* Finalizar colección.
* Exportar colección.
* Importar colección.
* Calcular sobres disponibles.
* Abrir sobre.
* Vender duplicado.
* Acelerar temporizador.
* Programar notificación.

### 7.3. Dominio

Contiene las reglas independientes de Flutter:

* Entidades.
* Validaciones.
* Cálculo de probabilidades.
* Economía.
* Temporizadores.
* Reglas de duplicados.
* Compatibilidad de versiones.
* Identificadores.

### 7.4. Infraestructura

Contiene:

* Base de datos.
* Sistema de archivos.
* Selección de fotos y vídeos.
* Procesamiento multimedia.
* ZIP.
* JSON.
* Notificaciones.
* Compartición.
* Importación de archivos.

## 8. Organización recomendada del proyecto

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
    card_creator/
    rarity_creator/
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

Cada funcionalidad deberá dividirse, al menos, en:

```text
feature/
  data/
  domain/
  presentation/
```

## 9. Tecnologías recomendadas

### Base de datos

Se recomienda **SQLite mediante Drift**.

Drift permite trabajar con una base de datos relacional local, consultas reactivas, transacciones y migraciones tipadas. Esto encaja bien con relaciones como colecciones, cartas, rarezas, sobres, cantidades y movimientos de monedas.

### Estado de la aplicación

Se recomienda **Riverpod** para:

* Separar lógica y widgets.
* Gestionar estados asíncronos.
* Inyectar repositorios.
* Facilitar pruebas.
* Actualizar automáticamente las pantallas cuando cambie la base de datos.

### Navegación

Se recomienda **go_router** para declarar rutas y organizar la navegación entre inicio, creador, álbum y apertura.

### Archivos

* `path_provider`: obtener carpetas internas y temporales.
* `file_selector`: elegir archivos para importar o ubicaciones para guardar.
* `share_plus`: abrir el menú nativo de compartir.
* `archive`: crear y extraer el contenedor comprimido.

### Multimedia

* `image_picker`: seleccionar imágenes o vídeos.
* `image_cropper`: recortar fotografías.
* `flutter_image_compress` o procesamiento equivalente: reducir y convertir imágenes.
* `video_player`: reproducir vídeos.
* Un servicio nativo encapsulado para comprimir vídeo y extraer el primer fotograma.

No debe acoplarse toda la aplicación directamente a un paquete concreto de compresión de vídeo. Se creará una interfaz `MediaProcessor`, porque los paquetes multimedia pueden cambiar o comportarse de forma distinta entre Android e iOS.

### Notificaciones

Se recomienda `flutter_local_notifications`.

Las notificaciones serán recordatorios. El estado real de los sobres se calculará siempre desde la base de datos y el reloj del dispositivo. En Android, las alarmas exactamente puntuales pueden requerir permisos especiales; no conviene que el funcionamiento de los sobres dependa de que la notificación llegue en el segundo exacto.

## 10. Modelo de datos

## 10.1. Proyecto de creación

Tabla `collection_projects`:

```text
id
collection_id
name
author
description
cover_asset_id
status
created_at
updated_at
format_version
content_version
main_pack_type_id
default_starting_packs
```

### Campos importantes

`id`
Identificador interno de la fila.

`collection_id`
Identificador universal permanente de la colección.

`status`:

```text
draft
finalized
```

`format_version`
Versión del formato del archivo.

`content_version`
Versión concreta del contenido. En la primera versión será `1`.

`default_starting_packs`
Inicialmente siempre tendrá valor `3`, aunque se guardará como campo para poder cambiarlo en futuras versiones.

## 10.2. Colección instalada

Tabla `installed_collections`:

```text
id
collection_id
content_version
name
author
description
cover_path
main_pack_type_id
installed_at
source
coins
distinct_cards_owned
total_cards
last_opened_at
```

`source`:

```text
created_locally
imported
```

Una colección creada y posteriormente finalizada tendrá dos representaciones:

* Proyecto de autoría.
* Colección instalada para jugar.

## 10.3. Rareza

Tabla `rarities`:

```text
id
collection_id
rarity_id
name
order_index
color_value
icon_id
frame_id
effect_id
sell_value
probability_weight
is_enabled
```

### Reglas

* El nombre es personalizado.
* El color se elige de una lista.
* Icono, marco y efecto visual existen como metadatos internos con valores por
  defecto y compatibilidad con datos antiguos, pero no se muestran en el flujo
  simple de creacion/edicion de rarezas.
* El valor de venta se configura por rareza.
* La probabilidad base de aparicion se configura por rareza con un entero de 0
  a 100.
* Debe existir al menos una rareza.
* Para completar/finalizar una coleccion, las probabilidades de rarezas activas
  deben sumar exactamente 100 y al menos una debe ser mayor que 0.
* Una rareza usada por una carta no puede eliminarse sin reasignar antes esa carta.

## 10.4. Carta

Tabla `cards`:

```text
id
collection_id
card_id
collection_number
name
health
rarity_id
media_type
media_path
thumbnail_path
template_id
frame_id
primary_color
secondary_color
description
created_at
sort_index
```

`media_type`:

```text
image
video
```

`collection_number` será único dentro de una colección.

Ejemplo visual:

```text
023 / 080
```

`card_id` será permanente y no dependerá del nombre, del número ni de la imagen.

## 10.5. Campos cómicos

Tabla `card_field_values`:

```text
id
card_id
field_type_id
value
display_order
```

La aplicación incluirá un catálogo fijo de campos.

Ejemplos de `field_type_id`:

```text
nickname
special_ability
attack
weakness
famous_quote
danger_level
embarrassment_level
intelligence
luck
resistance
charisma
punctuality
secret_power
favorite_object
legendary_moment
team
location
custom_description
```

El usuario elegirá cuáles añadir a cada carta.

No podrá crear identificadores de campos completamente nuevos en la primera versión.

Cada plantilla definirá:

* Cuántos campos soporta.
* Longitud máxima.
* Posición.
* Tamaño de letra.
* Número máximo de líneas.

## 10.6. Activos multimedia

Tabla `media_assets`:

```text
id
asset_id
owner_type
owner_id
media_type
relative_path
thumbnail_relative_path
mime_type
width
height
duration_ms
file_size
sha256
created_at
```

Los archivos no se guardarán como BLOB dentro de SQLite.

SQLite almacenará únicamente:

* Rutas.
* Metadatos.
* Duración.
* Dimensiones.
* Hash.
* Tamaño.

Las fotos y vídeos estarán en carpetas internas.

## 10.7. Tipo de sobre

Tabla `pack_types`:

```text
id
collection_id
pack_type_id
name
description
front_asset_id
back_asset_id
card_count
recharge_seconds
max_accumulated
is_main
coins_per_full_recharge
sort_index
```

### Validaciones

* Debe existir al menos un tipo de sobre.
* Exactamente uno será principal.
* El sobre principal tendrá `max_accumulated >= 3`.
* `card_count` será mayor que cero.
* `recharge_seconds` será mayor que cero.
* El sobre debe contener al menos una carta elegible.
* Las probabilidades deben sumar el 100 % en cada regla probabilística.

## 10.8. Cartas disponibles en un sobre

Tabla `pack_card_pool`:

```text
id
pack_type_id
card_id
is_enabled
```

Esto permitirá:

* Sobres con todas las cartas.
* Sobres temáticos.
* Sobres que solo contengan determinadas personas.
* Una misma carta en varios tipos de sobre.

## 10.9. Reglas de posiciones

Tabla `pack_slot_rules`:

```text
id
pack_type_id
slot_index
rule_type
minimum_rarity_order
probability_group_id
```

En lugar de aplicar una única probabilidad global sin control, cada posición del sobre tendrá una regla.

Ejemplo de un sobre de cinco cartas:

```text
Posición 1: común garantizada
Posición 2: común garantizada
Posición 3: común o poco común
Posición 4: cualquier rareza
Posición 5: rara o superior
```

`rule_type`:

```text
fixed_rarity
probability_distribution
minimum_rarity
```

## 10.10. Probabilidades por rareza

Tabla `pack_rarity_probabilities`:

```text
id
probability_group_id
rarity_id
weight
```

Ejemplo:

```text
Normal: 60
Graciosa: 25
Rara: 10
Legendaria: 4
Mítica: 1
```

La probabilidad siempre se determinará por rareza.

Una vez seleccionada la rareza:

1. Se obtendrán las cartas de esa rareza permitidas en ese sobre.
2. Se elegirá una al azar.
3. Todas las cartas elegibles de esa rareza tendrán inicialmente la misma probabilidad.
4. Se permitirán repeticiones.

No habrá una probabilidad individual configurable por carta en la primera versión.

## 10.11. Progreso del jugador

Tabla `owned_cards`:

```text
id
installed_collection_id
card_id
quantity
first_obtained_at
last_obtained_at
is_favorite
```

### Reglas

* Si la carta no existía, se inserta con cantidad `1`.
* Si ya existía, se incrementa `quantity`.
* No existe límite de copias.
* Una carta se considera conseguida cuando `quantity >= 1`.
* Solo se puede vender cuando `quantity > 1`.
* Nunca se permitirá vender la última copia.

## 10.12. Estado de los sobres

Tabla `pack_inventory`:

```text
id
installed_collection_id
pack_type_id
available_count
max_accumulated
next_recharge_at
last_calculated_at
```

Cada tipo de sobre tendrá su propio registro.

## 10.13. Historial de aperturas

Tabla `pack_openings`:

```text
id
opening_id
installed_collection_id
pack_type_id
status
generated_at
completed_at
```

Tabla `pack_opening_cards`:

```text
id
opening_id
card_id
slot_index
was_new
quantity_after
revealed
```

`status`:

```text
generated
revealing
completed
```

Este historial es necesario para recuperarse de cierres o errores durante la animación.

## 10.14. Movimientos de monedas

Tabla `coin_transactions`:

```text
id
installed_collection_id
transaction_type
amount
balance_after
related_card_id
related_pack_type_id
created_at
metadata_json
```

`transaction_type`:

```text
sell_duplicate
accelerate_timer
manual_adjustment
migration
```

Los movimientos positivos suman monedas. Los negativos las gastan.

## 11. Identificadores

Se utilizarán identificadores UUID para:

* Colección.
* Carta.
* Rareza.
* Tipo de sobre.
* Activo multimedia.
* Apertura.
* Transacción.

El paquete `uuid` permite generar identificadores compatibles con este propósito.

Nunca se utilizará como identificador permanente:

* El nombre.
* La posición en una lista.
* El número visible.
* La ruta del archivo.
* El índice de una base de datos.

Esto permitirá cambiar nombres, posiciones o archivos sin romper relaciones.

## 12. Creación de una colección

## 12.1. Pantalla inicial

Mostrará:

* Nombre.
* Autor.
* Descripción.
* Portada.
* Botón para continuar.
* Indicador de progreso del asistente.

### Validaciones

* Nombre obligatorio.
* Autor opcional, aunque recomendado.
* Portada obligatoria antes de finalizar.
* Nombre máximo recomendado: 60 caracteres.
* Descripción máxima recomendada: 500 caracteres.

## 12.2. Estado de borrador

Cada proyecto comenzará como `draft`.

Durante este estado se podrá:

* Cambiar información.
* Añadir y eliminar rarezas.
* Añadir, editar y eliminar cartas.
* Añadir, editar y eliminar sobres.
* Reordenar elementos.
* Salir y continuar después.

No se podrá abrir sobres desde el borrador.

## 13. Creación de rarezas

La pantalla mostrará una lista ordenada.

Para cada rareza se configurará:

* Nombre.
* Color.
* Icono.
* Marco.
* Efecto.
* Valor de venta.
* Orden de menor a mayor rareza.

### Opciones prediseñadas

La aplicación incluirá una amplia gama de:

* Colores.
* Estrellas.
* Coronas.
* Fuegos.
* Diamantes.
* Rayos.
* Símbolos cómicos.
* Marcos.
* Fondos.
* Brillos.
* Hologramas.

El creador podrá combinar opciones, pero no importar nuevos efectos ni crear animaciones desde cero en la primera versión.

## 14. Creación de cartas

## 14.1. Pasos

1. Elegir foto o vídeo.
2. Procesar el archivo.
3. Elegir plantilla.
4. Introducir nombre.
5. Introducir vida.
6. Elegir rareza.
7. Añadir campos cómicos.
8. Personalizar colores y marco.
9. Previsualizar.
10. Guardar.

## 14.2. Campos obligatorios

* Nombre.
* Vida.
* Rareza.
* Foto o vídeo.
* Plantilla.
* Número de colección.

## 14.3. Vida

La vida será un valor numérico.

Valores recomendados:

```text
Mínimo: 1
Máximo: 9999
```

La vida no tendrá una función jugable en la primera versión. Será decorativa y cómica.

## 14.4. Foto

Proceso:

1. Seleccionar desde la galería.
2. Copiar a una carpeta temporal.
3. Corregir orientación.
4. Permitir recorte.
5. Ajustar a la proporción de la plantilla.
6. Reducir dimensiones.
7. Convertir a WebP.
8. Generar miniatura.
9. Guardar en el proyecto.

Configuración inicial recomendada:

```text
Imagen principal máxima: 1440 píxeles en el lado largo
Miniatura: 480 píxeles
Formato: WebP
Calidad orientativa: 80–85
```

La calidad exacta deberá ajustarse mediante pruebas visuales.

## 14.5. Vídeo

Proceso:

1. Seleccionar desde la galería.
2. Leer duración y dimensiones.
3. Rechazar o recortar si supera el máximo.
4. Permitir elegir el fragmento.
5. Normalizar orientación.
6. Comprimir.
7. Conservar el sonido.
8. Extraer el primer fotograma.
9. Guardar el primer fotograma como WebP.
10. Guardar el vídeo normalizado.

Configuración inicial:

```text
Duración máxima del archivo elegido: 1 minuto
Duración máxima guardada en carta: 15 segundos
Resolución máxima: 1280 × 720
Contenedor: MP4
Vídeo: H.264
Audio: AAC
Sonido: obligatorio
Miniatura: primer fotograma
```

H.264 y AAC dentro de MP4 ofrecen una base compatible con los formatos multimedia habituales de Android y evitan depender de WebM en iPhone.

Si un vídeo no contiene una pista de audio, podrá aceptarse, pero la aplicación no añadirá sonido artificial. “Siempre con sonido” significa que nunca se eliminará la pista de audio durante la compresión.

## 14.6. Comportamiento visual de los vídeos

### Durante la apertura

1. Aparece el reverso.
2. Se realiza la animación de revelado.
3. Aparece la carta.
4. Si es un vídeo, comienza automáticamente.
5. Se reproduce con sonido.
6. Al terminar, se muestra el primer fotograma.
7. Aparece un icono para volver a reproducirlo.

### Dentro del álbum

1. La cuadrícula muestra el primer fotograma.
2. Un icono indica que contiene vídeo.
3. Al tocarla, se abre la vista detallada.
4. Comienza la reproducción con sonido.
5. Al terminar, vuelve a mostrarse la portada.
6. Puede repetirse tocando el botón correspondiente.

### Cuando la app pierde el foco

El vídeo se pausa si:

* Se bloquea el móvil.
* Se minimiza la aplicación.
* Se abre otra pantalla.
* Entra una llamada.
* Se cierra el detalle de la carta.

## 15. Plantillas de carta

La aplicación incluirá plantillas cerradas y configurables.

Cada plantilla definirá:

* Proporción.
* Área multimedia.
* Posición del nombre.
* Posición de la vida.
* Posición de rareza.
* Número de campos cómicos.
* Distribución de campos.
* Tipografías compatibles.
* Marcos compatibles.
* Efectos compatibles.

El creador podrá personalizar:

* Plantilla.
* Marco.
* Color principal.
* Color secundario.
* Fondo.
* Fuente dentro de una lista.
* Iconos.
* Reverso.
* Efecto de rareza.

No podrá:

* Arrastrar libremente cada texto.
* Cambiar coordenadas manualmente.
* Importar una fuente.
* Dibujar un marco personalizado.
* Crear una animación nueva.

Esto evita diseños rotos y facilita que todas las cartas se vean correctamente en diferentes pantallas.

## 16. Creación de sobres

## 16.1. Datos generales

Cada sobre tendrá:

* Nombre.
* Descripción.
* Imagen frontal.
* Imagen trasera.
* Número de cartas.
* Tiempo de recarga.
* Máximo acumulable.
* Coste de aceleración.
* Lista de cartas posibles.
* Reglas de posiciones.
* Probabilidades.

## 16.2. Sobre principal

Una colección tendrá exactamente un sobre principal.

Su función será:

* Proporcionar los tres sobres iniciales.
* Ser el tipo seleccionado por defecto en la pantalla de inicio.
* Servir como referencia cuando no se haya elegido otro.

El máximo acumulable del sobre principal deberá ser, como mínimo, tres.

## 16.3. Número de cartas

El creador podrá elegir cuántas cartas contiene el sobre.

Rango recomendado:

```text
Mínimo: 1
Máximo inicial: 10
```

El límite de 10 mantiene las animaciones y la interfaz manejables. Podrá ampliarse después.

## 16.4. Cartas elegibles

El creador podrá:

* Incluir todas las cartas.
* Seleccionar cartas concretas.
* Seleccionar por rareza.
* Usar una combinación.

Una carta podrá aparecer en varios tipos de sobre.

## 16.5. Repeticiones

Se permiten:

* Cartas ya obtenidas.
* Varias copias de la misma carta en distintos sobres.
* La misma carta dos o más veces dentro del mismo sobre.

No se excluirá automáticamente una carta después de haber sido elegida.

## 16.6. Probabilidades

Las probabilidades se asignarán por rareza.

La selección se realizará en dos fases:

1. Elegir rareza según su peso.
2. Elegir aleatoriamente una carta de esa rareza dentro del conjunto permitido.

### Caso sin cartas disponibles

Si una regla selecciona una rareza que no tiene cartas elegibles:

1. Se buscará la siguiente rareza inferior con cartas.
2. Si no existe, se buscará una superior.
3. Si ninguna rareza tiene cartas, la configuración del sobre será inválida y no podrá finalizarse.

La pantalla de creación debe detectar esta situación antes de exportar.

## 16.7. Garantías

Las garantías se implementarán mediante reglas de posición.

Ejemplos:

* Primera carta siempre normal.
* Última carta rara o superior.
* Dos primeras cartas de baja rareza.
* Cualquier rareza en todas las posiciones.

El creador verá una previsualización resumida:

```text
Carta 1: Normal garantizada
Carta 2: Normal 70 %, Graciosa 30 %
Carta 3: Cualquier rareza
Carta 4: Cualquier rareza
Carta 5: Rara o superior
```

## 17. Finalización de una colección

Antes de finalizar, se ejecutará una revisión completa.

### Requisitos

* Nombre establecido.
* Portada establecida.
* Al menos una rareza.
* Al menos una carta.
* Todas las cartas válidas.
* Al menos un tipo de sobre.
* Exactamente un sobre principal.
* Sobre principal con acumulación mínima de tres.
* Todos los sobres con cartas elegibles.
* Probabilidades correctas.
* Todos los archivos presentes.
* Todos los vídeos procesados.
* Sin identificadores duplicados.

### Resultado

Al finalizar:

1. El proyecto pasa a `finalized`.
2. Se crea un snapshot inmutable.
3. Se genera una colección instalada.
4. Se crean registros de progreso vacíos.
5. Se entregan tres sobres del tipo principal.
6. Se inicializan los temporizadores.
7. Se programan notificaciones.
8. Se habilita la exportación.

## 18. Tres sobres iniciales

Cuando una colección se crea o importa:

* Se entregan exactamente tres sobres.
* Los tres son del tipo principal.
* Los demás tipos de sobre empiezan con cero sobres.
* Todos los temporizadores comienzan en el momento de instalación.
* Los tres sobres no consumen monedas.
* No se vuelven a entregar al cerrar y abrir la aplicación.
* Borrar y volver a importar la colección sí reiniciará el progreso, porque se considera una nueva instalación local.

La entrega se registrará dentro de la misma transacción que crea la colección instalada para impedir entregas duplicadas si la aplicación se cierra.

## 19. Temporizadores

## 19.1. Estado por tipo de sobre

Cada tipo de sobre tendrá:

* Cantidad disponible.
* Máximo acumulable.
* Intervalo de recarga.
* Fecha de la siguiente recarga.

## 19.2. Cálculo al abrir la aplicación

La aplicación no mantendrá un contador ejecutándose permanentemente.

Al abrirse o volver a primer plano:

1. Lee la hora actual.
2. Lee `next_recharge_at`.
3. Calcula cuántos intervalos han transcurrido.
4. Suma los sobres correspondientes.
5. Limita la cantidad al máximo acumulable.
6. Calcula la próxima recarga.
7. Guarda el resultado.

## 19.3. Alcanzar el máximo

Cuando un tipo de sobre llega al máximo:

* Deja de acumular sobres.
* No guarda tiempo adicional oculto.
* No acumula créditos de recarga.
* Al abrir uno, comienza un nuevo intervalo completo desde ese momento.

Ejemplo:

```text
Máximo: 3
Disponibles: 3
Tiempo sin abrir la app: 5 días
Resultado: siguen disponibles 3
```

Al abrir uno:

```text
Disponibles: 2
Siguiente recarga: ahora + intervalo
```

## 19.4. Cambio manual de hora

No se intentará impedirlo.

La aplicación confiará en la hora local del dispositivo.

Si alguien adelanta la hora, podrá acelerar sobres. Se acepta porque:

* No hay competición.
* No hay dinero real.
* No hay servidor.
* La aplicación está orientada a amigos.
* Se prioriza el funcionamiento offline.

## 20. Notificaciones

La aplicación solicitará permiso para notificaciones la primera vez que una colección necesite programarlas.

Se programará una notificación para la siguiente recarga relevante de cada tipo de sobre.

Ejemplo:

> Ya tienes un nuevo sobre de “Momentos legendarios”.

Las notificaciones no serán la fuente de verdad.

Aunque una notificación:

* No llegue.
* Llegue tarde.
* Sea bloqueada.
* Sea eliminada.
* Se programe con una hora anterior.

La aplicación recalculará siempre los sobres cuando se abra.

No se programarán cientos de notificaciones futuras. Solo la próxima notificación necesaria de cada tipo, lo que reduce problemas con límites y restricciones del sistema. Las notificaciones locales no necesitan un servidor; Apple permite que el propio sistema entregue una notificación programada incluso cuando la aplicación no está activa.

## 21. Apertura de sobres

## 21.1. Inicio

Al pulsar **Abrir**:

1. Se comprueba que haya al menos un sobre.
2. Se recalculan temporizadores.
3. Se inicia una transacción de base de datos.
4. Se genera el contenido completo.
5. Se guarda el resultado.
6. Se descuenta un sobre.
7. Se suman las cartas al inventario.
8. Se confirma la transacción.
9. Comienza la animación.

El resultado debe guardarse antes de la animación.

## 21.2. Motivo

La animación no debe controlar la obtención real de cartas.

Si la app se cierra durante la apertura:

* Las cartas ya están guardadas.
* No se pierde el sobre.
* No se duplica el premio.
* Al volver, se puede continuar la revelación o mostrar el resumen.

## 21.3. Generación

Para cada posición:

1. Obtener su regla.
2. Elegir rareza.
3. Obtener cartas elegibles.
4. Elegir una carta.
5. Registrar si es nueva.
6. Registrar la cantidad posterior.

Se utilizará una fuente aleatoria local.

No se necesita que el resultado sea verificable por un servidor.

## 21.4. Animación

Secuencia recomendada:

1. Mostrar el sobre.
2. Permitir tocar o deslizar.
3. Animar apertura.
4. Mostrar el reverso de la primera carta.
5. Girar o revelar.
6. Aplicar efecto según rareza.
7. Reproducir vídeo si corresponde.
8. Mostrar si es nueva o repetida.
9. Continuar con la siguiente.
10. Mostrar resumen final.

Cuando el inventario tenga muchos sobres acumulados, la app podrá ofrecer abrir
lotes de 5 o 10 sobres en una sola apertura guardada. El lote consume todos esos
sobres de golpe y muestra un único resumen con todas las cartas obtenidas.

## 21.5. Carta nueva

Indicadores:

* Etiqueta “NUEVA”.
* Sonido diferenciado.
* Brillo.
* Animación especial.
* Actualización del contador del álbum.

## 21.6. Carta repetida

Mostrará:

```text
Repetida
Ahora tienes 4 copias
```

No se venderá automáticamente.

## 22. Álbum

## 22.1. Resumen

Mostrará:

* Nombre de colección.
* Portada.
* Cartas distintas obtenidas.
* Total de cartas.
* Porcentaje completado.
* Copias totales.
* Monedas.
* Última carta conseguida.

Ejemplo:

```text
38 de 60 cartas
63 % completado
92 copias totales
340 monedas
```

## 22.2. Cuadrícula

Cada posición mostrará:

* Número.
* Miniatura.
* Nombre.
* Rareza.
* Cantidad.
* Icono de vídeo.
* Favorito.

### Carta no obtenida

Podrá mostrarse:

* Como silueta.
* Con número.
* Sin nombre.
* Con rareza oculta.

La configuración inicial recomendada es mostrar silueta y número, pero ocultar nombre y contenido.

## 22.3. Filtros

* Todas.
* Obtenidas.
* Faltantes.
* Repetidas.
* Favoritas.
* Por rareza.
* Por tipo de sobre.
* Foto.
* Vídeo.

## 22.4. Orden

* Número de colección.
* Nombre.
* Rareza.
* Fecha de obtención.
* Cantidad.
* Faltantes primero.

## 22.5. Detalle

La vista detallada mostrará:

* Carta completa.
* Vídeo si existe.
* Nombre.
* Vida.
* Rareza.
* Campos cómicos.
* Número.
* Cantidad de copias.
* Fecha de primera obtención.
* Valor de venta.
* Botón de favorito.
* Botón para vender copias.

## 23. Duplicados y venta

## 23.1. Regla principal

Solo se podrán vender las copias que superen la primera.

```text
Cantidad: 1 → no se puede vender
Cantidad: 2 → se puede vender 1
Cantidad: 5 → se pueden vender hasta 4
```

## 23.2. Valor

El valor será el definido por la rareza.

Ejemplo:

```text
Normal: 5 monedas
Graciosa: 15 monedas
Rara: 40 monedas
Legendaria: 100 monedas
```

## 23.3. Venta

La pantalla permitirá elegir cantidad.

Ejemplo:

```text
Copias actuales: 5
Máximo vendible: 4
Cantidad a vender: 3
Monedas obtenidas: 120
Copias restantes: 2
```

La operación se realizará en una transacción:

1. Comprobar cantidad.
2. Reducir copias.
3. Sumar monedas.
4. Registrar movimiento.
5. Actualizar interfaz.

## 23.4. Monedas por colección

Las monedas serán independientes para cada colección.

No se podrán usar monedas de una colección en otra.

Esto evita desequilibrios entre colecciones con configuraciones diferentes.

## 24. Aceleración de temporizadores

## 24.1. Comportamiento

El usuario podrá utilizar monedas para completar:

* El temporizador actual de un tipo de sobre.
* Varios ciclos de ese tipo.
* Temporizadores de varios tipos en una sola operación.

La compra con monedas podrá superar el máximo acumulable. El máximo acumulable
solo limita la recarga automática gratuita: si el inventario queda en el máximo
o por encima, el temporizador queda pausado hasta que el usuario abra sobres y
el inventario baje por debajo de ese máximo.

## 24.2. Coste

Cada tipo de sobre tendrá un coste completo de recarga:

```text
coins_per_full_recharge
```

Para el primer sobre, cuyo temporizador puede estar parcialmente completado:

```text
coste = techo(
  tiempo_restante / tiempo_total × coste_recarga_completa
)
```

Para sobres adicionales:

```text
coste_adicional = coste_recarga_completa
```

### Ejemplo

```text
Intervalo: 12 horas
Coste completo: 120 monedas
Tiempo restante: 3 horas
Coste del primer sobre: 30 monedas
Segundo sobre adicional: 120 monedas
Total para dos: 150 monedas
```

## 24.3. Selector múltiple

La pantalla mostrará:

```text
Sobre normal
Disponibles: 0/3
Cantidad a generar: 2
Coste: 150 monedas
```

También podrá seleccionar varios tipos:

```text
Sobre normal: 2
Sobre especial: 1
Coste total: 340 monedas
```

Antes de confirmar se comprobará:

* Saldo suficiente.
* Saldo suficiente incluso cuando se compran sobres por encima del máximo.
* Estado actualizado de temporizadores.
* Pausa de recarga automática si el inventario queda en el máximo o por encima.

## 25. Exportación de una colección

## 25.1. Extensión

Nombre provisional:

```text
.gachadex
```

Ejemplo:

```text
viaje_londres_2026.gachadex
```

Internamente será un contenedor comprimido.

## 25.2. Estructura

```text
manifest.json
collection.json
rarities.json
cards.json
pack_types.json
pack_rules.json

assets/
  collection/
  cards/
    images/
    videos/
    thumbnails/
  packs/

checksums.json
```

## 25.3. Manifest

Ejemplo conceptual:

```json
{
  "formatVersion": 1,
  "collectionId": "uuid",
  "contentVersion": 1,
  "name": "Viaje a Londres",
  "author": "Alejandro",
  "mainPackTypeId": "uuid",
  "startingPacks": 3,
  "createdAt": "2026-08-05T10:00:00Z",
  "cardCount": 60,
  "rarityCount": 5,
  "packTypeCount": 3
}
```

## 25.4. Contenido incluido

El archivo llevará:

* Todas las imágenes.
* Todos los vídeos.
* Todas las miniaturas.
* Información de cartas.
* Rarezas.
* Sobres.
* Probabilidades.
* Valores de venta.
* Costes de aceleración.
* Diseños seleccionados.
* Versión de formato.
* Hash de cada archivo.

No llevará:

* Cartas obtenidas.
* Monedas.
* Sobres disponibles.
* Progreso.
* Historial.
* Datos de otra persona.

## 25.5. Compresión

Las imágenes estarán previamente en WebP.

Los vídeos estarán previamente comprimidos en MP4.

Como esos formatos ya están comprimidos, el contenedor podrá guardar esos archivos sin volver a comprimirlos agresivamente. Esto reduce el tiempo de exportación y evita consumir memoria innecesaria.

## 25.6. Exportación por streaming

La aplicación no deberá cargar la colección completa en memoria.

El proceso debe:

1. Crear un archivo temporal.
2. Añadir documentos JSON.
3. Añadir activos uno por uno.
4. Actualizar el progreso.
5. Cerrar el contenedor.
6. Verificarlo.
7. Abrir el menú de compartir.

La pantalla mostrará:

```text
Preparando colección
Procesando 35 de 80 archivos
62 %
```

## 26. Importación

## 26.1. Selección

El usuario pulsará **Importar colección** y elegirá el archivo mediante el selector nativo.

El paquete `file_selector` ofrece selección y guardado de archivos mediante las interfaces nativas, y `share_plus` permite compartir el archivo usando el menú estándar de Android o iOS.

## 26.2. Proceso

1. Copiar el archivo a una carpeta temporal.
2. Leer `manifest.json`.
3. Comprobar versión.
4. Comprobar identificador.
5. Comprobar si ya está instalada.
6. Mostrar previsualización.
7. Comprobar espacio disponible.
8. Extraer de forma segura.
9. Validar JSON.
10. Validar relaciones.
11. Comprobar hashes.
12. Copiar archivos al almacenamiento definitivo.
13. Insertar datos en una transacción.
14. Entregar tres sobres.
15. Crear temporizadores.
16. Programar notificaciones.
17. Eliminar temporales.

## 26.3. Previsualización

Antes de confirmar:

* Portada.
* Nombre.
* Autor.
* Número de cartas.
* Cantidad de vídeos.
* Tamaño.
* Tipos de sobre.
* Espacio necesario.
* Advertencia sobre contenido recibido.

## 26.4. Colección repetida

Si ya existe el mismo `collection_id`:

```text
Esta colección ya está instalada.
```

No se importará una segunda copia.

En la primera versión tampoco se aceptará una versión superior. El mensaje será:

```text
Esta colección ya está instalada. Las actualizaciones estarán disponibles en una versión posterior de la aplicación.
```

## 26.5. Importación atómica

La colección solo aparecerá en la biblioteca cuando todo haya terminado correctamente.

Si falla:

* Se cancelará la transacción.
* Se borrarán archivos parcialmente copiados.
* No se entregarán sobres.
* No quedará una colección incompleta.

## 27. Seguridad del archivo

Aunque se comparta entre amigos, el importador debe tratarlo como un archivo externo.

Debe comprobar:

* Rutas que intenten salir de la carpeta de destino.
* Nombres de archivo inválidos.
* Archivos duplicados.
* Tamaños declarados falsos.
* JSON mal formado.
* Identificadores repetidos.
* Extensiones no permitidas.
* Vídeos incompatibles.
* Falta de espacio.
* Hash incorrecto.
* Número exagerado de archivos.
* Relación de compresión sospechosa.

No se ejecutará ningún código contenido en el archivo.

Los hashes SHA-256 servirán para detectar corrupción o modificación accidental, no para demostrar autoría.

## 28. Sistema de archivos interno

Estructura propuesta:

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

Las rutas guardadas en la base de datos serán relativas.

Ejemplo correcto:

```text
cards/videos/card_73ac.mp4
```

No se guardará una ruta absoluta como:

```text
C:\Users\...
```

Esto facilita migraciones y funcionamiento entre Android e iOS.

`path_provider` permite localizar directorios propios de la aplicación en cada plataforma.

## 29. Pantallas

## 29.1. Navegación principal

Barra inferior:

1. **Inicio**
2. **Colecciones**
3. **Crear**
4. **Ajustes**

## 29.2. Inicio

Mostrará:

* Sobres disponibles.
* Próximas recargas.
* Monedas por colección.
* Acceso rápido a álbumes.
* Últimas cartas obtenidas.

## 29.3. Colecciones

Dos pestañas:

* Instaladas.
* Proyectos creados.

Cada colección instalada mostrará:

* Portada.
* Nombre.
* Progreso.
* Sobres disponibles.
* Monedas.

Cada proyecto mostrará:

* Portada.
* Nombre.
* Estado.
* Número de cartas.
* Botón para continuar.

## 29.4. Crear

Asistente:

1. Información.
2. Rarezas.
3. Cartas.
4. Sobres.
5. Economía.
6. Revisión.

## 29.5. Detalle de colección

Pestañas:

* Sobres.
* Álbum.
* Progreso.
* Ajustes locales.

## 29.6. Ajustes locales de colección

* Activar/desactivar notificaciones.
* Eliminar colección.
* Consultar tamaño.
* Ver fecha de importación.
* Ver versión.
* Volver a exportar solo si es una colección creada localmente.

## 29.7. Ajustes generales

* Tema.
* Sonido.
* Vibración.
* Calidad de vídeo.
* Uso de almacenamiento.
* Borrar temporales.
* Información de formato.
* Licencias de software.

## 30. Eliminación

## 30.1. Eliminar colección instalada

Mostrará una advertencia:

```text
Se eliminarán:
- Todas las cartas obtenidas
- Los duplicados
- Las monedas
- Los sobres
- El progreso
- Las fotos y vídeos de esta colección
```

Será una operación irreversible.

## 30.2. Eliminar proyecto

Si todavía es borrador:

* Se eliminarán sus cartas.
* Se eliminarán archivos temporales.
* No afectará a colecciones instaladas diferentes.

## 30.3. Proyecto finalizado

En la primera versión podrá conservarse como fuente de autoría en modo de solo lectura.

Esto permitirá implementar posteriormente la opción **Añadir cartas a una colección**.

## 31. Tratamiento de errores

Todos los servicios devolverán errores tipados.

Ejemplos:

```text
InsufficientStorage
InvalidCollectionFile
UnsupportedFormatVersion
CollectionAlreadyInstalled
MissingMediaAsset
InvalidProbabilityDistribution
NoEligibleCards
MediaProcessingFailed
NotificationPermissionDenied
DatabaseFailure
ExportCancelled
ImportCancelled
```

La interfaz no mostrará excepciones técnicas.

Ejemplo:

```text
No se ha podido importar la colección porque falta uno de sus vídeos.
```

## 32. Rendimiento

### Reglas

* No cargar todos los vídeos simultáneamente.
* Usar miniaturas en cuadrículas.
* Inicializar `VideoPlayerController` solo en la carta abierta.
* Liberar controladores al salir.
* Paginar álbumes grandes.
* Procesar archivos pesados fuera del hilo principal.
* Exportar e importar por streaming.
* Evitar guardar binarios en SQLite.
* Mantener caché limitada.
* Borrar temporales después de cada operación.

### Álbum

La cuadrícula cargará:

* Miniatura.
* Nombre.
* Rareza.
* Cantidad.

El vídeo completo solo se abrirá al entrar en detalle.

## 33. Privacidad

La aplicación trabajará con fotos y vídeos personales.

Debe dejar claro:

* Los archivos permanecen en el dispositivo.
* Solo salen cuando el usuario exporta o comparte.
* La aplicación no los sube a Internet.
* El receptor obtiene una copia completa.
* El creador debe tener permiso de las personas que aparecen.
* Borrar una colección local no borra copias ya enviadas.

Los permisos de galería se solicitarán únicamente cuando sean necesarios.

## 34. Accesibilidad

* Textos escalables.
* Contraste suficiente.
* No transmitir rareza únicamente mediante color.
* Icono y nombre de rareza.
* Botones con etiquetas accesibles.
* Opción de reducir animaciones.
* Subtítulos no obligatorios en la primera versión.
* Control de volumen mediante el sistema.
* Indicador visible en cartas con vídeo.

## 35. Pruebas

## 35.1. Unitarias

* Probabilidades.
* Selección de rareza.
* Selección de carta.
* Duplicados.
* Venta.
* Coste de aceleración.
* Cálculo de temporizadores.
* Acumulación máxima.
* Tres sobres iniciales.
* Validaciones.
* Versiones.
* Hashes.

## 35.2. Base de datos

* Crear colección.
* Importación transaccional.
* Apertura atómica.
* Venta atómica.
* Migraciones.
* Recuperación tras fallo.
* Eliminación en cascada.

## 35.3. Multimedia

* Foto vertical.
* Foto horizontal.
* Foto cuadrada.
* Vídeo vertical.
* Vídeo horizontal.
* Vídeo sin sonido.
* Vídeo demasiado largo.
* Vídeo de alta resolución.
* Cancelación durante compresión.
* Archivo corrupto.

## 35.4. Importación

* Archivo correcto.
* Colección repetida.
* Hash incorrecto.
* Falta un vídeo.
* JSON inválido.
* Sin espacio.
* Cierre durante importación.
* Archivo con rutas inseguras.

## 35.5. Apertura

* Una carta.
* Diez cartas.
* Todas repetidas.
* Todas nuevas.
* Vídeos consecutivos.
* Cierre durante la animación.
* Móvil bloqueado durante vídeo.
* Regreso después de un cierre.

## 35.6. Temporizadores

* Aplicación cerrada varias horas.
* Aplicación cerrada varios días.
* Máximo alcanzado.
* Cambio manual de hora.
* Cambio de zona horaria.
* Reinicio del dispositivo.
* Notificaciones desactivadas.
* Aceleración múltiple.

## 36. Fases de desarrollo

# Fase 0: base técnica

Objetivo: proyecto ejecutable y arquitectura preparada.

Implementar:

* Proyecto Flutter.
* Navegación.
* Tema.
* Drift.
* Riverpod.
* Estructura de carpetas.
* Manejo de errores.
* Generación de UUID.
* Repositorios base.

Resultado:

* La aplicación abre.
* Navega entre pantallas vacías.
* Crea y consulta registros de prueba.

# Fase 1: creador sin multimedia avanzada

Objetivo: poder definir la estructura completa de una colección.

Implementar:

* Datos generales.
* Rarezas.
* Cartas inicialmente con imagen.
* Campos cómicos.
* Plantillas básicas.
* Tipos de sobre.
* Probabilidades.
* Validaciones.
* Borradores.

Resultado:

* Se puede crear una colección completa con imágenes.
* Todavía no se exporta ni se juega.

# Fase 2: colección jugable local

Objetivo: finalizar una colección y abrir sobres en el mismo móvil.

Implementar:

* Snapshot inmutable.
* Colección instalada.
* Tres sobres iniciales.
* Temporizadores.
* Generador de sobres.
* Álbum.
* Duplicados.
* Apertura básica sin efectos complejos.

Resultado:

* El creador puede jugar su propia colección.

# Fase 3: vídeos

Objetivo: cartas con vídeo completamente funcionales.

Implementar:

* Selección.
* Recorte.
* Compresión.
* MP4 H.264/AAC.
* Primer fotograma.
* Reproducción.
* Ciclo de vida.
* Sonido.
* Miniaturas.

Resultado:

* Fotos y vídeos se comportan correctamente en Android e iPhone.

# Fase 4: exportación e importación

Objetivo: compartir colecciones.

Implementar:

* Formato `.gachadex`.
* JSON.
* ZIP.
* Checksums.
* Exportación por streaming.
* Compartición.
* Importación segura.
* Prevención de duplicados.
* Tres sobres al importar.

Resultado:

* Una colección creada en un dispositivo puede utilizarse en otro.

# Fase 5: economía

Objetivo: completar el ciclo de repetidas.

Implementar:

* Valores por rareza.
* Venta.
* Monedas.
* Historial.
* Aceleración de un temporizador.
* Aceleración múltiple.
* Validaciones.

Resultado:

* Los duplicados tienen utilidad.

# Fase 6: notificaciones

Objetivo: avisar de sobres disponibles.

Implementar:

* Permisos.
* Programación.
* Cancelación.
* Reprogramación.
* Apertura desde notificación.
* Gestión de reinicio y cambios.

Resultado:

* El usuario recibe recordatorios locales sin servidor.

# Fase 7: diseño y animaciones

Objetivo: conseguir una experiencia visual atractiva.

Implementar:

* Diseños de sobres.
* Animación de apertura.
* Giro de cartas.
* Brillos.
* Hologramas.
* Efectos de rareza.
* Sonidos.
* Vibración.
* Transiciones.
* Indicadores de carta nueva.

Resultado:

* La experiencia se parece a una aplicación coleccionable terminada.

# Fase 8: estabilización

Objetivo: preparar lanzamiento.

Implementar:

* Pruebas completas.
* Optimización.
* Gestión de almacenamiento.
* Accesibilidad.
* Recuperación de errores.
* Política de privacidad.
* Iconos.
* Tutorial inicial.
* Compilaciones de Android e iOS.

## 37. Funciones posteriores

## 37.1. Añadir cartas a una colección existente

Se utilizarán:

* Mismo `collection_id`.
* `content_version` superior.
* Nuevos `card_id`.
* Mismos identificadores para lo existente.

Al importar una actualización:

* Se conservarán cartas obtenidas.
* Se conservarán cantidades.
* Se conservarán monedas.
* Se conservarán sobres.
* Se añadirán las cartas nuevas.
* Se actualizará el total del álbum.
* No se eliminarán cartas antiguas.

## 37.2. Edición de cartas existentes

Más compleja porque debe decidirse:

* Si cambia el contenido para quien ya la obtuvo.
* Si se conserva el vídeo anterior.
* Si se considera una variante.
* Si modifica rareza y valor.
* Cómo afecta a sobres.

No debe implementarse hasta tener un sistema de migraciones de contenido estable.

## 37.3. Copia de seguridad local

Archivo separado con:

* Colecciones.
* Progreso.
* Monedas.
* Historial.
* Proyectos.

No será compatible con compartir una colección como contenido jugable; será una copia privada del dispositivo.

## 37.4. Exportación individual

Posteriormente:

* Carta de foto como imagen.
* Carta de vídeo como MP4 con marco.
* Imagen de progreso.
* PDF del álbum.
* Vídeo de apertura.

## 37.5. Intercambio

Posible futura función offline mediante:

* QR.
* Archivo.
* Bluetooth.
* Código temporal.

Necesitaría evitar duplicaciones fraudulentas, por lo que no es prioritaria.

## 37.6. Juego

Una futura capa podría incluir:

* Mazos.
* Ataques.
* Vida real de partida.
* Turnos.
* Efectos.
* Partidas locales.

No debe condicionar la primera arquitectura, salvo mantener campos como vida, ataque y habilidad en las cartas.

## 38. Criterios de finalización de la primera versión

La primera versión se considerará completa cuando pueda realizarse esta prueba de principio a fin:

1. Una persona crea una colección.
2. Añade rarezas personalizadas.
3. Añade cartas con fotos y vídeos.
4. Añade campos cómicos.
5. Crea varios tipos de sobres.
6. Configura probabilidades.
7. Configura temporizadores.
8. Finaliza la colección.
9. Recibe tres sobres.
10. Abre los sobres.
11. Obtiene cartas nuevas y repetidas.
12. Consulta el álbum.
13. Vende duplicados.
14. Usa monedas para completar varios temporizadores.
15. Exporta la colección.
16. Envía el archivo a otro móvil.
17. El segundo móvil la importa.
18. Recibe tres sobres.
19. Abre los sobres sin Internet.
20. Conserva su progreso después de cerrar y reiniciar la aplicación.

## 39. Orden recomendado para empezar a programar

No se debe comenzar por las animaciones.

El orden correcto es:

1. Entidades e identificadores.
2. Base de datos.
3. Creación de colecciones.
4. Rarezas.
5. Cartas con imagen.
6. Sobres y probabilidades.
7. Finalización.
8. Colección instalada.
9. Tres sobres iniciales.
10. Generación y apertura sin animaciones.
11. Álbum.
12. Duplicados.
13. Monedas.
14. Temporizadores.
15. Vídeos.
16. Exportación e importación.
17. Notificaciones.
18. Diseño final.
19. Animaciones y efectos.

Este orden permite probar primero las reglas esenciales y añadir después la presentación visual sin poner en riesgo los datos ni el progreso.
