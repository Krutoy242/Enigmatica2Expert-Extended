---
name: zenscript-mixins
description: ZenUtils runtime bytecode mixins in scripts/mixin/<mod>.zs — #loader mixin files that patch Java classes at runtime using #mixin preprocessor annotations. Not recipe surgery; these are actual Mixin injections written in ZenScript.
metadata:
  audience: modpack-devs
  workflow: writing-zs
---

## What I do

Describe `scripts/mixin/` — the place for **ZenUtils runtime bytecode patches**. These files use `#loader mixin` and `#mixin` preprocessor annotations to generate Mixin classes that modify Java code at runtime.

This is **not** CraftTweaker recipe manipulation. If you want to remove or add crafting recipes, use `scripts/mods/<mod>.zs` (skill `mod-tweak`) instead.

## When to use me

- You need to change a hardcoded constant, method behavior, or field access inside a mod's Java code.
- You want to inject code at specific points (method entry, field access, method invocation) in a target class.
- You need to replace an entire method body (`Overwrite`).
- You need client-only patches (`#sideonly client`).

## File structure

- One file per mod: `scripts/mixin/<mod>.zs` (`scripts/mixin/actuallyadditions.zs`, `scripts/mixin/botania.zs`, …).
- Sub-folders for mod families: `scripts/mixin/bloodmagic/`, `scripts/mixin/ic2/`, `scripts/mixin/thaumcraft/`.
- `scripts/mixin/cases/` and `scripts/mixin/common/` — shared bridge helpers.
- `scripts/mixin/<mod>/shared.zs` — per-mod `zenClass Op` bridge for cross-loader data sharing.

## Skeleton

```zs
#modloaded actuallyadditions
#loader mixin

import native.net.minecraft.block.state.IBlockState;
import mixin.CallbackInfoReturnable;

#mixin {targets: "de.ellpeck.actuallyadditions.mod.tile.TileEntityBioReactor"}
zenClass MixinTileEntityBioReactor {
    #mixin ModifyConstant {method: "updateEntity", constant: {intValue: 2}}
    function buffPowerGeneration(value as int) as int {
        return 20;
    }
}
```

## Headers

- `#loader mixin` — **required**. Tells ZenUtils to compile this script to a Mixin class.
- `#modloaded <mod-id>` — skip the file if the mod is absent.
- `#sideonly client` — for client-only target classes (place before `zenClass`).
- Mixin scripts are **not reloadable**.

## Common annotation usage in this pack

| Annotation | Count | Typical use |
|---|---|---|
| `ModifyConstant` | ~51 | Change hardcoded literals (capacity, damage, cooldown, etc.) |
| `Redirect` | ~46 | Replace a method call or field access with custom logic |
| `Overwrite` | ~32 | Replace an entire method body |
| `Inject` | ~29 | Hook at method start/return/invoke points; cancel or modify flow |
| `Shadow` | ~22 | Access private fields of the target class |
| `Static` | ~46 | Mark a mixin method as static (required for `<clinit>` hooks) |
| `ModifyVariable` | ~5 | Change a local variable at a specific STORE/LOAD/JUMP point |
| `WrapOperation` | ~1 | MixinExtras: wrap an invocation with custom logic |

## Patterns observed

### Buffing constants
The most common pattern — changing hardcoded numbers:
```zs
#mixin ModifyConstant {method: "<init>", constant: {intValue: 80000}}
function buffCapacity(value as int) as int {
    return 320000;
}
```

### Disabling unwanted behavior
Use `Overwrite` with a NO-OP or `Inject` with `ci.cancel()`:
```zs
#mixin Overwrite
function hasCustomArmorHead() as bool { /* NO-OP */ }

#mixin Inject {method: "registerRecipes", at: {value: "HEAD"}, cancellable: true}
function removeRecipes(event as RegistryEvent.Register, ci as CallbackInfo) as void {
    ci.cancel();
}
```

### Client-side patches
```zs
#loader mixin
#sideonly client
#mixin {targets: "com.example.client.ClientOnlyClass"}
zenClass MixinClientOnlyClass { ... }
```

### Cross-loader bridge (shared.zs)
When a mixin needs data from normal CraftTweaker scripts, use a `zenClass Op` bridge:

`scripts/mixin/thaumcraft/shared.zs`:
```zs
#loader mixin
zenClass Op {
  static doRefining as function(HarvestDropsEvent, ItemStack)void;
}
```

`scripts/mixin/thaumcraft/thaumcraft_ct.zs` (normal loader):
```zs
scripts.mixin.thaumcraft.shared.Op.doRefining = function(event, heldItem) as void { ... };
```

`scripts/mixin/thaumcraft/thaumcraft.zs` (mixin loader):
```zs
scripts.mixin.thaumcraft.shared.Op.doRefining(event, heldItem);
```

### Method wildcard
`method: "*"` matches every method in the class (useful for `ModifyConstant`):
```zs
#mixin ModifyConstant {method: "*", constant: {intValue: 4}}
```

## Conventions in this folder

- Name the `zenClass` `Mixin<TargetClassName>` for clarity.
- Keep related mixins for one mod in one file when possible.
- Use `#modloaded` so the file is silently skipped if the target mod is absent.
- Use `// NO-OP` comment for empty `Overwrite` bodies.
- Comment the **why** above each mixin class (bug fix, balance change, performance optimization).

## Cross-skill links

- Mixin annotation syntax and full reference → `mixin-annotations`.
- General ZenScript edge cases → `zenscript`.
- ZenUtils feature index and wiki → `zenutils`.
- CraftTweaker recipe tweaks (the actual recipe surgery) → `mod-tweak`.

## Examples

- `scripts/mixin/actuallyadditions.zs` — buffs batteries, tools, machines; redirects mining lens logic
- `scripts/mixin/botania.zs` — JEI tooltip injection, orechid behavior, boss spawn changes
- `scripts/mixin/iceandfire.zs` — removes dread thrall armor, overwrites villager trade init
- `scripts/mixin/immersiveengineering_client.zs` — disables manual recipe indexing for faster load
- `scripts/mixin/thaumcraft/`
