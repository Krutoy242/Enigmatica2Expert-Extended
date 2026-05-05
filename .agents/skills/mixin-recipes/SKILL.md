---
name: mixin-recipes
description: Targeted recipe surgery for mod-specific recipes lives in scripts/mixin/<mod>.zs — when to choose mixin/ over mods/, how to remove and replace a single recipe without breaking JEI, and the conventions the existing mixin files follow. Load this when surgically removing or rewriting one or a few specific recipes from a mod.
metadata:
  audience: modpack-devs
  workflow: writing-zs
---

## What I do

Describe `scripts/mixin/` — the place for **narrow, targeted** recipe edits to mod content, separate from `scripts/mods/<mod>.zs` which holds broader per-mod tweaks.

## When to use me

- You need to remove or rewrite one (or a small handful of) specific recipes from a mod.
- You want to "patch" an upstream mod recipe without putting it in the broader mod tweak file.
- Mass-removals of a category (e.g. "remove all Avaritia compressor recipes") that don't fit the multi-machine `process-system`.

If you're adding *general* mod tweaks (multiple recipe additions, JEI hides, etc.), prefer `scripts/mods/<mod>.zs` (skill `mod-tweak`).

## File location

- One file per mod: `scripts/mixin/<mod>.zs` (`scripts/mixin/avaritia.zs`, `scripts/mixin/botania.zs`, …).
- Sub-folders for mod families: `scripts/mixin/thaumcraft/`, `scripts/mixin/bloodmagic/`, `scripts/mixin/ic2/`.
- `scripts/mixin/cases/` and `scripts/mixin/common/` — shared helpers used by the mixin files.

## Skeleton

```zs
#modloaded avaritia
#priority 50
#reloadable

import crafttweaker.item.IItemStack;
import scripts.craft.craft.craft;

// Surgical removal by recipe name (preferred — no false matches).
recipes.removeByRecipeName('avaritia:neutron_ingot');

// Re-add with project DSL.
craft.remake(<avaritia:resource:1>, ["pretty",
  "C C C",
  "C N C",
  "C C C",
], {
  C: <ore:ingotCrystaltine>,
  N: <ore:ingotNeutronium>,
});
```

## Removal cheat-sheet

| Goal | Call |
| --- | --- |
| Remove by recipe name (best) | `recipes.removeByRecipeName('mod:name');` |
| Remove all recipes producing item | `recipes.remove(<mod:item>);` |
| Remove a specific machine recipe | `mods.<machine>.<API>.removeRecipe(...)` |
| Hide JEI entry too | `mods.jei.JEI.removeAndHide(<mod:item>);` |

## Conventions in this folder

- Keep each file short and cohesive — one logical reason for surgery per file/section.
- Comment each removal with the **why** (often "rebalanced for E2E:E").
- Use `#priority 50–100` so mixin files run after the mod's own additions but before broader pack additions.
- Use `#reloadable` whenever possible.

## Cross-skill links

- General per-mod tweaks → `mod-tweak`.
- Replacement crafting-table recipes → `craft-recipes`.
- Multi-machine equivalents → `process-system`.

## Examples

- `scripts/mixin/avaritia.zs:1`
- `scripts/mixin/botania.zs`
- `scripts/mixin/enderio.zs`
- `scripts/mixin/thaumcraft/`
