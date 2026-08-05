# Third Party Notices

Fecha: 2026-08-05

Este proyecto esta en fase 0. No se ha copiado codigo, assets, fuentes, imagenes, videos, plantillas ni efectos desde los repositorios de referencia.

## Dependencias directas actuales

### Flutter SDK

Licencia: BSD-3-Clause.

Uso: framework base de la aplicacion.

### Dart SDK

Licencia: BSD-3-Clause.

Uso: lenguaje, runtime y herramientas.

### cupertino_icons

Licencia: MIT.

Uso: dependencia incluida por la plantilla Flutter para iconos Cupertino.

### flutter_test

Licencia: BSD-3-Clause.

Uso: pruebas de Flutter.

### flutter_lints

Licencia: BSD-3-Clause.

Uso: reglas de analisis estatico.

## Repositorios de referencia

### Altare TCG 2023

Ubicacion local: `references/altare-tcg-2023`

Licencia del repo: MIT, segun `references/altare-tcg-2023/LICENSE`.

Uso en Friend Cards: referencia de analisis. No se ha incorporado codigo ni recurso.

Avisos:

- El README acredita efectos inspirados por `pokemon-cards-css`.
- Los efectos de `css/card.css` no se copiaran sin revision de licencia independiente.
- Las imagenes, iconos, textos, cartas, CSVs, nombres y recursos de Regis Altare, Holostars/Hololive y fans no se reutilizaran.

### React Card Builder

Ubicacion local: `references/react-card-builder`

Licencia indicada por el README: MIT. En la copia local no existe archivo `LICENSE`, por lo que cualquier reutilizacion directa queda bloqueada hasta verificar el repositorio original y cada recurso.

Uso en Friend Cards: referencia de analisis. No se ha incorporado codigo ni recurso.

Avisos:

- El README indica que el proyecto esta deprecado, archivado y sin mantenimiento.
- Los recursos de Lorcana y Yu-Gi-Oh, incluyendo plantillas, iconos, fuentes, reversos y textos de copyright, no se reutilizaran.
- Las dependencias web no se trasladaran a Flutter.

## Politica de actualizacion

Si en una fase futura se copia o adapta codigo identificable:

1. Revisar licencia del archivo y del repositorio.
2. Conservar avisos exigidos.
3. Copiar la licencia a `third_party/licenses/`.
4. Actualizar este documento.
5. Documentar la adaptacion en el codigo.

No se asumira que una dependencia o asset hereda automaticamente la licencia del repositorio principal.
