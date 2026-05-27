---
name: zs-mixins
description: ZenUtils runtime bytecode mixins in scripts/mixin/<mod>.zs — file conventions, annotation syntax, and common patterns. ALWAYS LOAD THIS SKILL when editing ANY file under scripts/mixin/ or ANY .zs that starts with #loader mixin — it is MANDATORY.
metadata:
  audience: modpack-devs
  workflow: writing-zs
---

## What & when

`#loader mixin` scripts in `scripts/mixin/` compile to Mixin classes and patch target Java classes at runtime. Use them to change hardcoded constants, redirect method calls, or inject behavior. **Not reloadable.** For recipe surgery use `scripts/mods/<mod>.zs` instead.

## File structure

- One file per mod: `scripts/mixin/<mod>.zs` (or sub-folders for families, e.g. `thaumcraft/`).
- `scripts/mixin/cases/`, `scripts/mixin/common/` — shared bridge helpers.
- `scripts/mixin/<mod>/shared.zs` — per-mod `zenClass Op` bridge for cross-loader data sharing.

### Headers

```zs
#modloaded actuallyadditions
#loader mixin
```
- `#sideonly client` — place **before** `zenClass` for client-only targets.
- `mods.zenutils.*` helpers are unavailable in mixin scripts (compile to `null`). Use builtins (`~`, `toString()`).

## Target syntax

```zs
#mixin {targets: "de.ellpeck.actuallyadditions.mod.tile.TileEntityBioReactor"}
zenClass MixinTileEntityBioReactor { ... }
```

- Multiple targets: `targets: ["pkg.A", "pkg.B"]`
- Name the class `Mixin<TargetClassName>`.
- Inside methods, `this0` is the target instance (cast to target type). For static targets, shadow static fields instead.

## Annotation syntax

Annotations are preprocessors. The `#mixin` line, optional JSON block, and the function/field must be adjacent — **no blank lines** between them.

**Single-line** (ZenUtils ≥ v1.21.2):
```zs
#mixin ModifyConstant {method: "getMaxEnergy", constant: {intValue: 10000}}
function buff(value as int) as int { return 20000000; }
```

**Multi-line** (all versions): every continuation line starts with `#`.
```zs
#mixin ModifyConstant
#{
#    method: "getMaxEnergy",
#    constant: {intValue: 10000}
#}
function buff(value as int) as int { return 20000000; }
```

**Static method:**
```zs
#mixin Static
#mixin ModifyConstant {method: "<clinit>", constant: {intValue: 41472}}
function buffStorage(value as int) as int { return 2000000000; }
```

### JSON leniency

Parsed by Gson lenient mode. Supports unquoted keys, single-quoted strings, `//` comments, `=` / `=>` instead of `:`, `;` instead of `,`. **Trailing commas are rejected** (`[1,2,]`).

## Common annotations

### Base Mixin

| Annotation | Purpose |
|---|---|
| `Inject` | Hook at `HEAD`, `RETURN`, `INVOKE`, etc. Add `cancellable: true` to allow `ci.cancel()`. |
| `ModifyConstant` | Replace a literal. |
| `ModifyVariable` | Change a local at `STORE` / `LOAD` / `JUMP`. |
| `ModifyArg` / `ModifyArgs` | Change one or many method-call arguments. |
| `Redirect` | Replace a call/field access entirely. Prefer `WrapOperation`. |
| `Overwrite` | Replace entire method body. Use sparingly. |
| `Shadow` | Access private fields/methods. Declare a field with the same name to auto-shadow. |
| `Accessor` / `Invoker` | Generate getters/setters/callers for private members. |
| `Static` | Target a `static` method. |
| `Final` | Mark shadowed field as final (combine with `val`). |
| `Slice` | Restrict search range with `from`/`to` anchors. |

### MixinExtras (preferred over Redirect/Overwrite)

| Annotation | Purpose |
|---|---|
| `WrapOperation` | Wrap a call/field/constructor. Accepts `Operation` to call original. |
| `ModifyExpressionValue` | Modify result of any expression. |
| `ModifyReturnValue` | Modify return after method executes. |
| `WrapWithCondition` | Execute original only if handler returns `true`. |
| `WrapMethod` | Wrap entire method body. Accepts `Operation`. |

### Targeting sugar

| Annotation | Purpose |
|---|---|
| `Definition` / `Expression` | Target via Java-like expression string (`at: {value: "MIXINEXTRAS:EXPRESSION"}`). |
| `Local` | Capture local variable into a parameter (`parameter: 0`, `-1` = last). |
| `Share` | Share an object between injectors in the same method. |
| `Cancellable` | Allow cancelling without `CallbackInfo`. |
| `SugarBridge` | Enable calling other injectors from a handler. |

## Types & callbacks

Only **native types** are allowed: `import native.pkg.Class;`, primitive arrays `[int]`, and callback types.

| Type | Use |
|---|---|
| `mixin.CallbackInfo` | `Inject` cancellation (`ci.cancel()`). |
| `mixin.CallbackInfoReturnable` | `Inject` + capture/set return value. |
| `mixin.Operation` | `WrapOperation` / `WrapMethod` to call original (`original.call(...)`). |

`Local` with `ref: true` uses a **1-length array** as `LocalRef<T>`:
```zs
#mixin WrapOperation {method: "doInit", at: {value: "INVOKE", target: "…"}}
#mixin Local {parameter: -1, ref: true}
function myHook(manager as ISqueezerManager, op as mixin.Operation, localVar as ItemRegistryCore[]) as void {
    op.call(manager);
    localVar[0] = null; // set
}
```

## Patterns

### Buff constants
```zs
#mixin ModifyConstant {method: "<init>", constant: {intValue: 80000}}
function buffCapacity(value as int) as int { return 320000; }
```

### Disable behavior
```zs
// NO-OP Overwrite
#mixin Overwrite
function hasCustomArmorHead() as bool { /* NO-OP */ }

// Cancel method entry
#mixin Inject {method: "registerRecipes", at: {value: "HEAD"}, cancellable: true}
function removeRecipes(event as RegistryEvent.Register, ci as CallbackInfo) as void {
    ci.cancel();
}
```

### Cross-loader bridge
`shared.zs` (mixin loader):
```zs
#loader mixin
zenClass Op {
    static doRefining as function(HarvestDropsEvent, ItemStack)void;
}
```

Normal loader script:
```zs
scripts.mixin.thaumcraft.shared.Op.doRefining = function(event, heldItem) as void { ... };
```

Mixin loader script:
```zs
scripts.mixin.thaumcraft.shared.Op.doRefining(event, heldItem);
```

### Method wildcard
`method: "*"` matches every method (useful for `ModifyConstant`):
```zs
#mixin ModifyConstant {method: "*", constant: {intValue: 4}}
```

## Discovering targets

ZenUtils hard-codes Mixin remap to `false`; `method` / `at.target` must match bytecode names (SRG/obfuscated for MC/Forge, usually MCP for mod internals).

Decompile:
```bash
# whole jar
java -jar cfr-0.152.jar --outputdir ./~cfr_out mods/<Mod>.jar

# single class
java -jar cfr-0.152.jar --outputdir ./~cfr_out mods/<Mod>.jar --jarfilter "com.example.package.YourClassName"

# bytecode
javap -c -cp path/to/yourfile.jar com.example.package.ClassName
```

Inspect `./~cfr_out/...` for exact signatures and visibility.

**One-liner for `.mixin.out` — date, decompile, and show source** (relative path, written once):
```bash
f=".mixin.out/class/path/to/TargetClass.class"; ls -la "$f" && java -jar cfr-0.152.jar "$f" --outputdir "${f%/*}" --clobber true && cat "$(find "${f%/*}" -name "*.java" -newer "$f" | head -1)"
```

## Conventions

- `zenClass Mixin<TargetClassName>`
- Keep related mixins for one mod in one file.
- Always use `#modloaded` so files are skipped silently if the mod is absent.
- Comment the **why** above each mixin class.
- Use `// NO-OP` for empty `Overwrite` bodies.
