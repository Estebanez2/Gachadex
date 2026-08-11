# Esquema de base de datos

Fecha: 2026-08-06

Schema version: `5`

Motor: SQLite mediante Drift.

Archivo de produccion: `gachadex.sqlite` en el directorio privado de soporte de
la aplicacion.

## Politicas globales

- `PRAGMA foreign_keys = ON` se activa al abrir la base.
- No hay columnas BLOB.
- Los IDs se guardan como `TEXT` con UUID validado en dominio.
- Las fechas se escriben desde dominio como UTC y los mappers las recuperan como
  UTC.
- Las rutas multimedia se guardan como `TEXT` relativo y normalizado.
- Los enums se guardan como strings estables.

## Tablas

### `collection_projects`

Proyecto editable.

Claves:

- PK: `id`.
- Unique index: `collection_id`.

Relaciones:

- `cover_asset_id` -> `media_assets.id` (`SET NULL`).
- `current_content_version_id` -> `content_versions.id` (`RESTRICT`).
- `main_pack_type_id` -> `pack_types.id` (`SET NULL`).

Restricciones:

- `current_content_version >= 1`.
- `starting_pack_count >= 0`.

Columnas de Fase 3:

- `draft_cover_color_id`: id estable del color principal de la portada
  generada.
- `draft_cover_accent_color_id`: id estable del color secundario.
- `draft_cover_icon_id`: id estable del icono.
- `draft_cover_pattern_id`: id estable del patron visual.

Estas columnas no referencian `media_assets`: son una portada provisional
generada en Flutter y se validan contra `DraftCoverCatalog`.

### `content_versions`

Versiones de contenido de una coleccion.

Claves:

- PK: `id`.
- Unique: `collection_id + version_number`.
- Partial unique index: una version actual por `collection_id`.

Restricciones:

- `version_number >= 1`.
- `format_version >= 1`.

### `installed_collections`

Coleccion instalada y contadores de progreso agregados.

Claves:

- PK: `id`.
- Unique: `collection_id + content_version_id`.
- Index: `collection_id`.

Relaciones:

- `content_version_id` -> `content_versions.id` (`RESTRICT`).
- `main_pack_type_id` -> `pack_types.id` (`SET NULL`).

Restricciones:

- `coins >= 0`.
- `total_card_count >= 0`.
- `distinct_owned_count >= 0`.

### `rarities`

Rarezas de una version de contenido.

Claves:

- PK: `id`.
- Unique: `content_version_id + order_index`.
- Unique: `content_version_id + name`.
- Index: `collection_id + content_version_id`.

Relaciones:

- `content_version_id` -> `content_versions.id` (`CASCADE`).

Restricciones:

- `order_index >= 0`.
- `sell_value >= 0`.

### `media_assets`

Metadatos de imagen/video. No guarda binarios.

Claves:

- PK: `id`.
- Index: `collection_id + owner_type + owner_id`.

Restricciones:

- `file_size >= 0`.
- `width` y `height` nulos o positivos.
- `duration_ms` nulo o positivo.

### `cards`

Cartas de una version de contenido.

Claves:

- PK: `id`.
- Unique: `content_version_id + collection_number`.
- Index: `collection_id + content_version_id`.
- Index: `rarity_id`.

Relaciones:

- `content_version_id` -> `content_versions.id` (`CASCADE`).
- `rarity_id` -> `rarities.id` (`RESTRICT`).
- `media_asset_id` -> `media_assets.id` (`RESTRICT`).
- `thumbnail_asset_id` -> `media_assets.id` (`SET NULL`).

Restricciones:

- `collection_number > 0`.
- `health BETWEEN 1 AND 9999`.
- `sort_index >= 0`.

Columnas de Fase 5:

- `front_color_id`, `front_accent_color_id`, `front_icon_id`,
  `front_pattern_id`: ids estables de la portada generada en Flutter.
- `back_color_id`, `back_accent_color_id`, `back_icon_id`,
  `back_pattern_id`: ids estables del reverso generado en Flutter.

No guardan rutas ficticias ni activos multimedia; los ids se interpretan contra
`PackVisualCatalog`.

### `card_field_values`

Campos comicos predefinidos por carta.

Claves:

- PK: `id`.
- Unique: `card_id + field_type_id`.
- Index: `card_id`.

Relaciones:

- `card_id` -> `cards.id` (`CASCADE`).

Restricciones:

- `display_order >= 0`.
- `field_type_id` dentro del catalogo fijo:
  `nickname`, `special_ability`, `attack`, `weakness`, `famous_quote`,
  `danger_level`, `embarrassment_level`, `intelligence`, `luck`,
  `resistance`, `charisma`, `punctuality`, `secret_power`,
  `favorite_object`, `legendary_moment`, `team`, `location`,
  `custom_description`.

### `pack_types`

Tipos de sobre de una version.

Claves:

- PK: `id`.
- Unique: `content_version_id + name`.
- Unique: `content_version_id + sort_index`.
- Partial unique index: un sobre principal por `content_version_id`.
- Index: `collection_id + content_version_id`.

Relaciones:

- `content_version_id` -> `content_versions.id` (`CASCADE`).
- `front_asset_id` -> `media_assets.id` (`SET NULL`).
- `back_asset_id` -> `media_assets.id` (`SET NULL`).

Restricciones:

- `card_count > 0`.
- `recharge_seconds > 0`.
- `max_accumulated > 0`.
- `coins_per_full_recharge >= 0`.
- `sort_index >= 0`.

### `pack_card_pool`

Cartas disponibles dentro de un sobre.

Claves:

- PK: `pack_type_id + card_id`.
- Index: `card_id`.

Relaciones:

- `pack_type_id` -> `pack_types.id` (`CASCADE`).
- `card_id` -> `cards.id` (`CASCADE`).

Regla adicional:

- El repositorio valida que sobre y carta pertenezcan a la misma coleccion y
  version.

### `pack_slot_rules`

Reglas por posicion de sobre.

Claves:

- PK: `id`.
- Unique: `pack_type_id + slot_index`.
- Index: `pack_type_id`.

Relaciones:

- `pack_type_id` -> `pack_types.id` (`CASCADE`).
- `fixed_rarity_id` -> `rarities.id` (`RESTRICT`).

Restricciones:

- `slot_index >= 0`.
- `minimum_rarity_order` nulo o no negativo.
- Configuracion coherente segun `rule_type`. `minimumRarity` guarda
  `minimum_rarity_order` y `probability_group_id` para ponderar solo rarezas
  iguales o superiores.

### `pack_rarity_probabilities`

Pesos enteros por grupo de probabilidad.

Claves:

- PK: `probability_group_id + rarity_id`.
- Index: `rarity_id`.

Relaciones:

- `rarity_id` -> `rarities.id` (`RESTRICT`).

Restricciones:

- `weight > 0`.

Regla adicional:

- El repositorio valida que el grupo exista en una regla de slot y que la
  rareza pertenezca al mismo sobre/version.

### `pack_inventory`

Inventario local de sobres por coleccion instalada.

Claves:

- PK: `installed_collection_id + pack_type_id`.
- Index: `installed_collection_id`.

Relaciones:

- `installed_collection_id` -> `installed_collections.id` (`CASCADE`).
- `pack_type_id` -> `pack_types.id` (`RESTRICT`).

Restricciones:

- `available_count >= 0`.
- `max_accumulated > 0`.

`available_count` puede ser mayor que `max_accumulated` cuando el usuario
compra sobres con gachacoin. En ese estado la recarga automatica queda pausada
hasta que el inventario vuelva a estar por debajo del maximo.

### `owned_cards`

Cartas obtenidas por coleccion instalada.

Claves:

- PK: `installed_collection_id + card_id`.
- Index: `installed_collection_id`.

Relaciones:

- `installed_collection_id` -> `installed_collections.id` (`CASCADE`).
- `card_id` -> `cards.id` (`RESTRICT`).

Restricciones:

- `quantity >= 1`.

### `pack_openings`

Aperturas generadas atomicamente, aun sin UI visual.

Claves:

- PK: `id`.
- Index: `installed_collection_id`.

Relaciones:

- `installed_collection_id` -> `installed_collections.id` (`CASCADE`).
- `pack_type_id` -> `pack_types.id` (`RESTRICT`).

### `pack_opening_cards`

Cartas resultantes de una apertura.

Claves:

- PK: `opening_id + slot_index`.
- Index: `card_id`.

Relaciones:

- `opening_id` -> `pack_openings.id` (`CASCADE`).
- `card_id` -> `cards.id` (`RESTRICT`).

Restricciones:

- `slot_index >= 0`.
- `quantity_after >= 1`.

### `coin_transactions`

Historial local de gachacoin por coleccion instalada.

Claves:

- PK: `id`.
- Index: `installed_collection_id`.

Relaciones:

- `installed_collection_id` -> `installed_collections.id` (`CASCADE`).
- `related_card_id` -> `cards.id` (`SET NULL`).
- `related_pack_type_id` -> `pack_types.id` (`SET NULL`).

Restricciones:

- `balance_after >= 0`.

## Indices

Ademas de PKs y uniques, existen indices para las consultas previstas:

- Proyectos por `collection_id`.
- Versiones por `collection_id`.
- Rarezas por `collection_id + content_version_id`.
- Cartas por `collection_id + content_version_id` y `rarity_id`.
- Activos por `collection_id + owner_type + owner_id`.
- Sobres por `collection_id + content_version_id`.
- Progreso por `installed_collection_id`.
- Aperturas por `installed_collection_id`.

## Migraciones

### Version 1 -> 2

Anade a `collection_projects` la configuracion de portada provisional:

- `draft_cover_color_id TEXT NOT NULL DEFAULT 'cover_teal'`
- `draft_cover_accent_color_id TEXT NOT NULL DEFAULT 'cover_gold'`
- `draft_cover_icon_id TEXT NOT NULL DEFAULT 'cover_icon_spark'`
- `draft_cover_pattern_id TEXT NOT NULL DEFAULT 'cover_pattern_solid'`

Los valores por defecto coinciden con `DraftCoverStyle.defaultStyle()` para que
los borradores existentes puedan abrirse sin crear activos multimedia ni rutas
ficticias.

### Version 2 -> 3

Recrea `card_field_values` para sustituir el `CHECK` de campos comicos de Fase
2 por el catalogo fijo de Fase 4.

Durante la copia se preservan datos existentes mapeando IDs antiguos:

- `attackName` -> `attack`
- `attackDescription` -> `custom_description`
- `favoriteSnack` -> `favorite_object`
- `catchphrase` -> `famous_quote`
- `insideJoke` -> `legendary_moment`
- `specialSkill` -> `special_ability`
- `weakness` y `resistance` se mantienen.

La tabla nueva conserva PK, unique `card_id + field_type_id`, indice por
`card_id` y `ON DELETE CASCADE` hacia `cards`.

### Version 3 -> 4

Anade a `pack_types` ids estables para portada y reverso provisionales:

- `front_color_id`, `front_accent_color_id`, `front_icon_id`,
  `front_pattern_id`.
- `back_color_id`, `back_accent_color_id`, `back_icon_id`,
  `back_pattern_id`.

Tambien recrea `pack_slot_rules` para permitir que `minimumRarity` tenga
`probability_group_id`, necesario para seleccionar entre rarezas permitidas con
pesos enteros.

### Version 4 -> 5

Recrea `pack_inventory` para eliminar la restriccion
`available_count <= max_accumulated`. El maximo acumulable limita solo la
recarga automatica gratuita; las compras con gachacoin pueden dejar el
inventario por encima de ese maximo.

### Proximas versiones

Para una nueva version:

1. Subir `currentDatabaseSchemaVersion`.
2. Anadir ramas explicitas en `createMigrationStrategy`.
3. Mantener migraciones idempotentes por rango `from/to`.
4. Anadir tests de migracion con una base creada en v1.
5. Documentar cambios en este archivo y, si cambia una decision importante,
   crear una entrada en `docs/decisions/`.
