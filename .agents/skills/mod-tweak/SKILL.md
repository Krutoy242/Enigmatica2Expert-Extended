---
name: mod-tweak
description: Template and conventions for per-mod ZenScript files in scripts/mods/<mod>.zs — choosing the right file, adding the #modloaded gate, removing original recipes, adding replacements with craft.zs, hiding JEI categories, and using shared lib helpers. Load this when creating or editing any file under scripts/mods/.
metadata:
  audience: modpack-devs
  workflow: writing-zs
---

## What I do

Provide the standard skeleton for `scripts/mods/<mod>.zs` files (≈200 of them) so a new mod tweak is consistent with the rest of the pack.

## When to use me

- Adding or editing any file in `scripts/mods/`.
- Deciding whether your tweak belongs in `scripts/mods/<mod>.zs` (general per-mod tweaks) or `scripts/mixin/<mod>.zs` (runtime bytecode patches — see `zenscript-mixins`).

## File location rules

- One file per mod, named after the mod id: `scripts/mods/actuallyadditions.zs`.
- Tweaks that touch multiple mods that conceptually belong to one mod family go into a folder: `scripts/mods/bloodmagic/`, `scripts/mods/extrautilities2/`.
- If you need to patch Java code at runtime (change constants, redirect methods, overwrite behavior), use `scripts/mixin/<mod>.zs`.

## Skeleton

```zs
#modloaded actuallyadditions
#priority 100
#reloadable

import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;

import scripts.craft.craft.craft;

// 1. Hide unwanted JEI entries.
mods.jei.JEI.hideCategory('actuallyadditions.crushing');

// 2. Remove vanilla / mod recipes you intend to replace.
recipes.removeByRecipeName('actuallyadditions:item_canola_seed');

// 3. Add replacements via craft.zs.
craft.remake(<actuallyadditions:item_canola_seed> * 2, ["pretty",
  "G",
  "S",
], {
  G: <ore:cropCanola>,
  S: <ore:seedCanola>,
});
```

## Headers

- Always start with `#modloaded <mod-id>` so the file is silently skipped when the mod is missing. This is what guarantees pack flexibility.
- `#priority 100` is a reasonable default; raise to 1000+ when other files depend on your removals running first.
- `#reloadable` whenever you only touch recipes / hide categories. Drop it for files that mutate static state.
- `#ignoreBracketErrors` only if you reference items that may not exist in all configurations.

## Common patterns

- **Remove by output**: `recipes.remove(<mod:item>);`
- **Remove by recipe name**: `recipes.removeByRecipeName("mod:name");` (preferred, surgical).
- **Hide JEI category**: `mods.jei.JEI.hideCategory("category.id");`.
- **Hide JEI item**: `mods.jei.JEI.removeAndHide(<mod:item>);`.
- **Tooltip**: import from `scripts.lib.tooltip` (see `scripts/lib/tooltip.zs`).

## Cross-skill links

- For the recipe DSL itself → skill `craft-recipes`.
- For broad multi-machine recipes → skill `process-system`.
- For runtime bytecode patches → skill `zenscript-mixins`.
- For new items/blocks → skill `cot-content`.
- For loot drops → skill `loot-tables`.

## Examples to mimic

- `scripts/mods/actuallyadditions.zs:1`
- `scripts/mods/botania.zs`
- `scripts/mods/avaritia.zs`
- `scripts/mods/draconicevolution.zs`
