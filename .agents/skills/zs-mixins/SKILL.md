---
name: zs-mixins
description: Write/edit ZenUtils bytecode mixins in scripts/mixin/. Load when editing "#loader mixin" scripts or patching Java classes. Do NOT load for recipe tweaks — use "zs" skill instead.
---

## What & when

`#loader mixin` scripts in `scripts/mixin/` compile to Mixin classes and patch target Java classes at runtime. Use them to change hardcoded constants, redirect method calls, or inject behavior. Not reloadable.

## File structure

- One file per mod: `scripts/mixin/<mod>.zs` (or sub-folders for families, e.g. `thaumcraft/`).
- `scripts/mixin/cases/`, `scripts/mixin/common/` — shared bridge helpers.
- `scripts/mixin/<mod>/shared.zs` — per-mod `zenClass Op` bridge for cross-loader data sharing.

### Gotchas

- `#sideonly client` — for client-only targets.
- helpers are Unavailable in `#loader mixin` scripts:
  * Helpers from zenutils, eg `mods.zenutils.*`
  * Crafttweaker types, eg `crafttweaker.item.IItemStack`

## Target syntax

```zs
/*
  Why this mixin required.
*/
#mixin {targets: 'com.example.package.TargetClass'}
zenClass MixinTargetClass { ... }
```

- Multiple targets: `targets: ['pkg.A', 'pkg.B']`
- Class name convention: `Mixin<TargetClassName>`.
- Inside methods, `this0` is the target instance (cast to target type). For static targets, shadow static fields instead.
- Keep related mixins for one mod in one file.
- Always use `#modloaded` so files are skipped silently if the mod is absent.
- Comment the **why** above each mixin class.
- Use `// NO-OP` for empty `Overwrite` bodies.
- Primitive collections only ZS-styled: `[int]` for a List (mutable), `int[]` for array (immutable)

## Annotation syntax

Annotations are preprocessors. The `#mixin` line, optional JSON block, and the function/field must be adjacent — **no blank lines** between them.

**Single-line**
```zs
#mixin ModifyConstant {method: 'getMaxEnergy', constant: {intValue: 10000}}
function buff(value as int) as int { return 20000000; }
```

**Multi-line**
```zs
#mixin ModifyConstant
#{
#    method: 'getMaxEnergy',
#    constant: {intValue: 10000}
#}
function buff(value as int) as int { return 20000000; }
```

**Static method:**
```zs
#mixin Static
#mixin ModifyConstant {method: '<clinit>', constant: {intValue: 41472}}
function buffStorage(value as int) as int { return 2000000000; }
```

### JSON leniency

Parsed by Gson lenient mode. Supports unquoted keys, single-quoted strings, `//` comments, `=` / `=>` instead of `:`, `;` instead of `,`. **Trailing commas are rejected** (`[1,2,]`).

## Common annotations

- **Base Mixin**: `Inject`, `ModifyConstant`, `ModifyVariable`, `ModifyArg`, `Redirect`, `Overwrite`, `Shadow`, `Accessor`, `Static`, `Final`, `Slice`.
- **MixinExtras**: `WrapOperation`, `ModifyExpressionValue`, `ModifyReturnValue`, `WrapWithCondition`, `WrapMethod`.
- **Targeting sugar**: `Definition`, `Expression`, `Local`, `Share`, `Cancellable`, `SugarBridge`.

## Types & callbacks

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

### Cross-loader bridge

**Purpose**:
1. Inject mixin code on early game load stage.
2. Reference mixin to a static function.
3. Replace function inside `#reloadable` script (allow reload code without restarting game).

`mixin.zs`:
```zs
    // inside mixin class method body
    scripts.mixin.modname.shared.Op.action(1);
    // ...
```

`shared.zs`:
```zs
#loader mixin

zenClass Op {
  static action as function(int)void;
}
```

`reloadable.zs`:
```zs
#reloadable

scripts.mixin.modname.shared.Op.action
  = function(val as int) as void {
    ...
  };
```

## Discovering targets

ZenUtils hard-codes Mixin remap to `false`; `method` / `at.target` must match bytecode names (obfuscated).

Decompile:
```bash
# whole jar
java -jar cfr-0.152.jar --outputdir ./~cfr_out 'mods/mod-name.jar'

# single class
java -jar cfr-0.152.jar 'mods/mod-name.jar' --jarfilter 'com.example.package.YourClassName'

# bytecode
javap -c -cp 'mods/mod-name.jar' com.example.package.ClassName
```

**Decompile `.mixin.out` class — run from project root**:
```bash
./.agents/skills/zs-mixins/decomp-mixin.sh .mixin.out/class/path/to/TargetClass.class
```
