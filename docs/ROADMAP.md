# Roadmap

Fecha: 2026-08-05

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
monedas, notificaciones, importacion ni exportacion.

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

Objetivo: definir una coleccion completa con imagenes ya persistidas como rutas,
sin exportar ni jugar todavia.

Incluye datos generales, rarezas, cartas con imagen normalizada en fases
posteriores, campos comicos, plantillas propias, tipos de sobre, pools,
probabilidades, reglas de slots, autosave de borradores y validaciones de
finalizacion.

Depende de: fase 2.

## Fase 4 - Coleccion jugable local

Objetivo: finalizar una coleccion y abrir sobres en el mismo dispositivo.

Incluye snapshot inmutable, coleccion instalada, separacion contenido/progreso,
tres sobres iniciales, temporizadores locales, generador de sobres, apertura
atomica antes de animar, album, duplicados y apertura visual basica.

Depende de: fase 3.

## Fase 5 - Videos

Objetivo: soportar cartas con video de forma completa.

Incluye seleccion de videos, lectura de duracion y dimensiones, recorte temporal,
normalizacion MP4 H.264/AAC, conservacion de sonido, primer fotograma,
miniaturas y reproduccion controlada.

Depende de: fase 4.

## Fase 6 - Exportacion e importacion

Objetivo: compartir colecciones sin servidor.

Incluye formato `.friendpack`, manifest, JSON de contenido, activos,
checksums SHA-256, exportacion por streaming, comparticion nativa, importacion
segura, validacion, duplicados e importacion atomica.

Depende de: fases 4 y 5.

## Fase 7 - Economia

Objetivo: cerrar el ciclo de duplicados.

Incluye venta parcial, valores por rareza, monedas por coleccion, historial,
aceleracion de temporizadores y validaciones de saldo.

Depende de: fase 4.

## Fase 8 - Notificaciones locales

Objetivo: avisar de sobres disponibles sin servidor.

Incluye permisos, programacion/cancelacion/reprogramacion local, apertura desde
notificacion y recuperacion tras reinicio cuando la plataforma lo permita.

Depende de: fase 4 y de la estrategia de temporizadores.

## Fase 9 - Diseno y animaciones

Objetivo: elevar la experiencia visual con identidad propia.

Incluye disenos de sobres, animacion de apertura, giro/revelado, efectos propios
por rareza, sonido, vibracion, transiciones, indicadores y modo reducir
animaciones. No debe copiar Pokemon TCG ni efectos de Altare de forma literal.

Depende de: fases 4, 5 y 8.

## Fase 10 - Estabilizacion y lanzamiento

Objetivo: preparar una primera version distribuible.

Incluye suite amplia, optimizacion, almacenamiento, accesibilidad, recuperacion
de errores, privacidad, identidad final, tutorial inicial, compilaciones
Android y preparacion iOS en Mac con Xcode.

Depende de: fases 1 a 9.

## Regla de avance

No se empezara una fase nueva hasta que la fase actual tenga documentacion,
pruebas, `dart format .`, `flutter analyze`, `flutter test`, revision de diff y
verificacion manual descrita.
