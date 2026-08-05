# Esquema de base de datos

Fecha: 2026-08-05

Schema version: `1`

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

- `collection_number >= 0`.
- `health BETWEEN 1 AND 9999`.
- `sort_index >= 0`.

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
  `attackName`, `attackDescription`, `favoriteSnack`, `catchphrase`,
  `insideJoke`, `weakness`, `resistance`, `specialSkill`.

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
- Configuracion coherente segun `rule_type`.

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
- `available_count <= max_accumulated`.

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

Historial local de moneda preparado para fases posteriores.

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

## Migracion a version 2

Para v2:

1. Subir `currentDatabaseSchemaVersion`.
2. Anadir ramas explicitas en `createMigrationStrategy`.
3. Mantener migraciones idempotentes por rango `from/to`.
4. Anadir tests de migracion con una base creada en v1.
5. Documentar cambios en este archivo y, si cambia una decision importante,
   crear una entrada en `docs/decisions/`.
