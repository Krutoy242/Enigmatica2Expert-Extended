---
name: loot-tables
description: Edit loot in the modpack via scripts/loot/ (LootTweaker), scripts/lib/loot.zs helpers, scripts/lib/dropt.zs and config/dropt/ — adding mob drops, chest contents, fishing pools, plus how preMadeLoot.zs feeds shared pools into multiple loot tables. Load this when adjusting drops, chest loot, or fishing tables.
metadata:
  audience: modpack-devs
  workflow: writing-loot
---

## What I do

Cover the two parallel loot systems used in this pack:

1. **LootTweaker** ZenScript (`scripts/loot/`).
2. **Dropt** rules (`config/dropt/` + `scripts/lib/dropt.zs` + `crafttweaker.log` integrations).

## When to use me

- Adding or editing mob drops, chest loot, fishing rewards.
- Wiring a shared item pool (`scripts/loot/preMadeLoot.zs`) into a new loot table.
- Adjusting block-break drops via Dropt.

## Folder layout

| Path | Purpose |
| --- | --- |
| `scripts/loot/preMadeLoot.zs` | Shared static maps (`baubles`, etc.) used as pools by other files. |
| `scripts/loot/minecraft/` | Vanilla loot tweaks. |
| `scripts/loot/twilight_forest/`, `astral_sorcery/`, `ice_and_fire/`, `quark/`, `thaumcraft/` | Per-mod loot tweaks. |
| `scripts/lib/loot.zs` | Helpers: weighted picks, table builders, condition shortcuts. |
| `scripts/lib/dropt.zs` | Dropt rule builder helpers. |
| `config/dropt/` | Dropt rule files (JSON / SNBT). |

## File header (LootTweaker)

```zs
#modloaded loottweaker
#priority 10
#ignoreBracketErrors

import crafttweaker.item.IItemStack;
import crafttweaker.item.WeightedItemStack;
import loottweaker.LootTweaker;
import loottweaker.vanilla.loot.Functions;
import loottweaker.vanilla.loot.Conditions;
```

## Common operations

- **Add a pool entry**:
  ```zs
  val table = LootTweaker.getTable("minecraft:chests/simple_dungeon");
  val pool  = table.addPool("e2ee_extra", 1, 3, 0, 0);
  pool.addItemEntry(<minecraft:diamond>, 5).setWeight(10).setQuality(0);
  ```
- **Reuse `preMadeLoot.zs` pools**: iterate the static maps and `pool.addItemEntry(...)` per entry — see how existing files in `scripts/loot/` consume `static baubles as int[][IItemStack]`.
- **Conditions / functions**: pull from `loottweaker.vanilla.loot.Conditions` / `Functions`. For custom logic, `mods.daomephsta_loot_shared.LootFunction` (already imported in `scripts/lib/loot.zs`).

## Dropt

- Drop-tables for blocks/mobs that LootTweaker can't reach cleanly.
- Edit `config/dropt/*.json` directly, or build them from ZS via `scripts/lib/dropt.zs` helpers.
- Dropt log: `dropt.log` at repo root.

## Naming

- Pool ids: prefix with `e2ee_` so additions are easy to grep and wipe with `purge`.
- Use `#priority 10` so loot files run *after* `_init/purge_loot.zs` purges any stale tables.

## Cross-skill links

- Mob behaviour / kill triggers → see `scripts/do/`.
- New loot items → may need ContentTweaker (`cot-content`).
- Removing whole tables on init → `scripts/_init/purge_loot.zs`.

## Examples

- `scripts/loot/preMadeLoot.zs:1`
- `scripts/lib/loot.zs:1`
- `scripts/loot/minecraft/`
- `scripts/loot/twilight_forest/`
