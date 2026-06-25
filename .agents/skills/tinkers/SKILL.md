---
name: tinkers
description: Add/modify TCon & ConArm materials, traits, modifiers, and Tinkers guidebook ("Materials and you") pages. Load when creating tool/armor materials/traits/modifiers, converting gear to TCon variants, or when a modifier/trait from an add-on mod is missing from the guidebook or shows a raw translation key.
---

## Material Types

## Required Steps for Adding a Material

1. **Register fluid** (if toolparts need to be casted) in `scripts/cot/init.zs`
2. **Define the Material and Traits** in `scripts/cot/trait/`
3. **Add Localizations** `resources/contenttweaker/lang/`:
   - `fluid.name=` for castable metals
   - `e2ee.tconstruct.material.name=` material name
   - `e2ee.tconstruct.trait.name` / `.description` for traits
4. **Script Melting & Casting Recipes** in `scripts/cot/recipes.zs`.

## Common Pitfalls & Problems

**Critical Convention: `_armor` Suffix**

All Construct's Armory traits are automatically suffixed with `_armor` at registration. `AbstractArmorTrait.create("glitch")` registers as `glitch_armor`. This suffix **must** be used in every reference.

**Traits on external (mod-registered) materials:** default-loader ZS, native `TinkerRegistry.getMaterial(id).addTrait(TinkerRegistry.getTrait(id), part)`; null-guard and skip ids already in `getAllTraitsForStats(part)`. Not CoT loader, not the deprecated `tweakersconstruct.cfg` `S:"Trait tweaks"` (breaks on colon ids, wipes defaults).

## Equipment Replacement Convention

When replacing conventional mod tools/armor with TConstruct's equivalents, use these patterns:

### Recipe References
In crafting recipes, reference ConArm cores with material NBT:
```zs
<conarm:helmet_core>.withTag({ Material: 'material_id' })
<conarm:chest_core>.withTag({ Material: 'material_id' })
<conarm:leggings_core>.withTag({ Material: 'material_id' })
<conarm:boots_core>.withTag({ Material: 'material_id' })
```

### Cleanup
- Add Purge entries for replaced armor items in `scripts/_init/purge.zs`
- Remove recycling entries from `scripts/equipment/armor.zs` and `scripts/mods/immersiveengineering/recycling.zs`

## Debug command: `/dump traits`

A reloadable subcommand registered in `scripts/debug/dump/traits.zs` lists every registered
Tinkers' Construct trait and Construct's Armory armor modifier in-game, with summary counts.
Part of the unified `/dump` command family; other subcommands include `arc_recycle`.

### Usage

```
/dump traits
```

### Output

- **Materials** — total count, hidden count, default trait entries, unique trait IDs.
- **TinkerRegistry modifiers** — each modifier/trait with identifier and localized name.
  Modifiers also in the `traits` map are tagged `[T]`; pure modifiers tagged `[M]`.
- **ArmoryRegistry (ConArm) armor modifiers** — tagged `[A]`, with localized names.
- **Summary block** — total materials, TCon modifiers (split into traits vs pure), ConArm
  armor modifiers, raw/missing lang keys, hidden count.

All data is also printed to `crafttweaker.log`.

### Implementation notes

- Uses native accesses: `TinkerRegistry.getAllModifiers()`, `TinkerRegistry.getTrait(id)`,
  `ArmoryRegistry.getAllArmorModifiers()`, and `Material.getDefaultTraits()`.
- Reloadable (`#reloadable`) and guarded (`#modloaded tconstruct conarm`).
- Registered into the `/dump` command dispatch via `scripts.debug.dump.main.registerSubcommand`.

## Guidebook ("Materials and you") & trait vs. modifier

When an add-on's tool feature is missing from the guidebook, or its name/description shows a raw translation key:

- **Trait ≠ modifier.** A tool feature can be registered as a *trait* and/or a *modifier* — these are separate registry maps. The guidebook's modifier section lists only features registered **as modifiers** that *also* have a guidebook page; a feature registered only as a trait works on tools but never appears in the book. Read the add-on's Java integration class (fetch it with the source-lookup tool from the `zs` skill) to see how it registers — trait vs modifier, and its exact identifier string.
- **Promote a trait to a modifier from the pack side** via a `.zs` script using native registry access: the instance already lives in the registry, so look it up and also register it as a modifier. Discover the registry/interface names with `zsfind`/source instead of hardcoding, and remember interface upcasts are **left-hand** casts (see `zs` skill).
- **Names/descriptions** come from lang keys derived from the feature's identifier (name and description are *separate* keys); a missing key renders as the raw key in-game. Add missing keys through the pack's resource-pack lang overrides (see `lang` skill), mirrored across **every** locale the pack ships.
- **Guidebook pages are data-driven JSON** under the pack's resource overrides. Section page-lists are **explicit and ordered** — pages are not auto-discovered, so a new page must be both authored *and* referenced in its section list. Copy the shape from an existing page plus the section list, and author per-locale text for each locale that has guidebook resources.
- Verify ZS changes with the `ct syntax` / `ct reload` loop from the `zs` skill before declaring done.
