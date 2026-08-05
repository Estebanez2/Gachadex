# Roadmap

Fecha: 2026-08-05

Este roadmap ordena el trabajo practico. La fase 0 de este documento es la fase documental solicitada ahora. La "base tecnica" descrita como fase 0 en `docs/PRODUCT_SPEC.md` queda aqui como fase 1 para no mezclar documentacion preparatoria con implementacion.

## Fase 0 - Foundation docs

Objetivo: preparar el repositorio antes de implementar producto.

Incluye:

- Verificar Flutter, Dart, doctor, `pubspec.yaml`, Android, iOS y estado Git.
- Analizar `references/altare-tcg-2023`.
- Analizar `references/react-card-builder`.
- Crear `docs/REFERENCE_ANALYSIS.md`.
- Crear `docs/ARCHITECTURE.md`.
- Crear `docs/ROADMAP.md`.
- Crear `docs/DEPENDENCIES.md`.
- Crear `THIRD_PARTY_NOTICES.md`.
- Actualizar `README.md`.
- Endurecer `.gitignore`.

Depende de: repositorio Flutter creado y submodulos presentes.

No incluye:

- Pantallas funcionales.
- Nuevas dependencias.
- Drift, Riverpod, GoRouter o plugins multimedia.
- Copia de codigo o recursos de referencia.

## Fase 1 - Base tecnica ejecutable

Objetivo: convertir la app Flutter inicial en un esqueleto navegable y testeable.

Incluye:

- Estructura feature-first.
- Tema propio inicial.
- Navegacion con GoRouter.
- Estado e inyeccion con Riverpod.
- Errores tipados base.
- UUIDs.
- Drift/SQLite y repositorios base.
- Pantallas vacias o placeholders minimos.
- Pruebas de arranque, routing y repositorios de prueba.

Depende de: fase 0.

## Fase 2 - Creador sin multimedia avanzada

Objetivo: definir una coleccion completa con imagenes, sin exportar ni jugar todavia.

Incluye:

- Datos generales.
- Rarezas.
- Cartas con imagen.
- Campos comicos.
- Plantillas basicas propias.
- Tipos de sobre.
- Pools de cartas.
- Probabilidades por rareza.
- Reglas de posiciones.
- Autosave de borradores.
- Validaciones de finalizacion, sin finalizar jugablemente todavia.

Depende de: fase 1.

## Fase 3 - Coleccion jugable local

Objetivo: finalizar una coleccion y abrir sobres en el mismo dispositivo.

Incluye:

- Snapshot inmutable.
- Coleccion instalada.
- Separacion contenido/progreso.
- Tres sobres iniciales.
- Temporizadores locales.
- Generador de sobres.
- Apertura atomica antes de animar.
- Album.
- Duplicados y cantidades.
- Apertura visual basica sin efectos complejos.

Depende de: fase 2.

## Fase 4 - Videos

Objetivo: soportar cartas con video de forma completa.

Incluye:

- Seleccion de videos.
- Lectura de duracion y dimensiones.
- Recorte temporal.
- Normalizacion MP4 H.264/AAC.
- Conservacion de sonido.
- Extraccion del primer fotograma.
- Miniaturas.
- Reproduccion en apertura y album.
- Gestion de ciclo de vida de `VideoPlayerController`.

Depende de: fase 3.

## Fase 5 - Exportacion e importacion

Objetivo: compartir colecciones sin servidor.

Incluye:

- Formato `.friendpack`.
- Manifest y JSON de contenido.
- Activos organizados.
- Checksums SHA-256.
- Exportacion por streaming.
- Comparticion nativa.
- Importacion segura.
- Validacion de relaciones.
- Prevencion de duplicados.
- Importacion atomica.
- Tres sobres al importar.

Depende de: fases 3 y 4 para incluir fotos y videos definitivos.

## Fase 6 - Economia

Objetivo: cerrar el ciclo de duplicados.

Incluye:

- Valores de venta por rareza.
- Venta parcial de duplicados.
- Monedas por coleccion.
- Historial de movimientos.
- Aceleracion de un temporizador.
- Aceleracion multiple.
- Validaciones de saldo y maximos.

Depende de: fase 3. Puede desarrollarse despues de fase 5 si se quiere priorizar compartir.

## Fase 7 - Notificaciones locales

Objetivo: avisar de sobres disponibles sin servidor.

Incluye:

- Solicitud de permisos.
- Programacion de la proxima notificacion por tipo de sobre.
- Cancelacion y reprogramacion.
- Apertura desde notificacion.
- Recuperacion tras reinicio cuando la plataforma lo permita.
- Pruebas de que las notificaciones no son fuente de verdad.

Depende de: fase 3 y de la estrategia de temporizadores.

## Fase 8 - Diseno y animaciones

Objetivo: elevar la experiencia visual con identidad propia.

Incluye:

- Direccion visual propia.
- Disenos de sobres.
- Animacion de apertura.
- Giro y revelado.
- Brillos y efectos propios por rareza.
- Sonido.
- Vibracion.
- Transiciones.
- Indicadores de carta nueva.
- Modo reducir animaciones.

Depende de: fases 3, 4 y 7. No debe copiar Pokemon TCG ni los efectos de Altare.

## Fase 9 - Estabilizacion y lanzamiento

Objetivo: preparar una primera version distribuible.

Incluye:

- Suite de pruebas completa.
- Optimizacion.
- Gestion de almacenamiento.
- Accesibilidad.
- Recuperacion de errores.
- Politica de privacidad.
- Iconos e identidad final.
- Tutorial inicial.
- Compilaciones Android.
- Preparacion iOS en Mac con Xcode.

Depende de: fases 1 a 8.

## Dependencias entre fases

```text
Fase 0
  -> Fase 1
      -> Fase 2
          -> Fase 3
              -> Fase 4
              -> Fase 6
              -> Fase 7
                  -> Fase 8
          -> Fase 5 depende de Fase 3 y Fase 4
Fase 9 depende de Fase 1 a Fase 8
```

## Regla de avance

No se empezara una fase nueva hasta que la fase actual tenga documentacion, pruebas, `dart format .`, `flutter analyze`, `flutter test`, revision de diff y verificacion manual descrita.
