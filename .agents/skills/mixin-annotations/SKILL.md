---
name: mixin-annotations
description: ZenUtils mixin annotation syntax for `#loader mixin` scripts — how to write `#mixin` preprocessors, target classes, inject points, and callbacks. Use this when authoring or editing `scripts/mixin/<mod>.zs` files that patch Java code at runtime.
metadata:
  audience: modpack-devs
  workflow: writing-zs
---

## What I do

Describe ZenUtils mixin annotation syntax for CraftTweaker 1.12. These are `#loader mixin` scripts that compile to Mixin bytecode and patch target classes at runtime. They live in `scripts/mixin/`.

## File header

Every mixin script **must** start with:

```zs
#loader mixin
```

Add `#modloaded <modid>` if the file depends on a mod being present. Mixin scripts are **not reloadable**.

## Target a class

Use the class-level `#mixin` preprocessor to declare the target. ZenUtils supports two shorthand forms.

### Long form (pre-v1.21.2, still valid)

```zs
#mixin Mixin
#{targets: "com.example.mod.TargetClass"}
zenClass MixinTargetClass {
    ...
}
```

### Short form (recommended)

```zs
#mixin {targets: "com.example.mod.TargetClass"}
zenClass MixinTargetClass {
    ...
}
```

### Multiple targets

```zs
#mixin
#{
#    priority: 2000,
#    targets: [
#        "com.example.mod.ClassA",
#        "com.example.mod.ClassB"
#    ]
#}
zenClass MixinBothClasses { ... }
```

### Client-only mixins

If the target class exists only on the client, add `#sideonly client` **before** the zenClass:

```zs
#mixin {targets: "com.example.client.OnlyClientClass"}
#sideonly client
zenClass MixinOnlyClientClass { ... }
```

## Annotation syntax rules

All mixin annotations use a **preprocessor** form. A `#mixin` line declares the annotation name, an optional JSON block describes its arguments, then a function or field follows. The three parts must be adjacent — **no blank lines** between them.

### Multi-line form (works everywhere)

```zs
#mixin ModifyConstant
#{
#    method: "getMaxEnergy",
#    constant: {intValue: 10000}
#}
function modifyMaxEnergyModifier(value as int) as int {
    return 20000000;
}
```

### Single-line form (ZenUtils ≥ v1.21.2)

```zs
#mixin ModifyConstant {method: "getMaxEnergy", constant: {intValue: 10000}}
function modifyMaxEnergyModifier(value as int) as int {
    return 20000000;
}
```

**Rule:** every line of the JSON block must start with `#` because it is still preprocessor content. Indentation inside the JSON is for readability only.

## Static functions

ZenScript does not allow `static` inside `zenClass`. Mark a function static with the `#mixin Static` preprocessor **before** the method annotation:

```zs
#mixin Static
#mixin ModifyConstant {method: "<clinit>", constant: {intValue: 41472}}
function buffStorage(value as int) as int {
    return 2000000000;
}
```

## Common method annotations

| Annotation | Typical use | Key arguments |
|---|---|---|
| `ModifyConstant` | Change a literal value | `method`, `constant: {intValue: …}` or `floatValue`, `longValue`, `doubleValue`, `stringValue` |
| `ModifyVariable` | Change a local variable | `method`, `at: {value: "STORE" \| "LOAD" \| "JUMP", …}`, `name`, `ordinal` |
| `Redirect` | Replace a method/field access | `method`, `at: {value: "INVOKE" \| "FIELD", target: "Lowner;desc", ordinal: n}` |
| `Inject` | Run code at a hook point | `method`, `at: {value: "HEAD" \| "RETURN" \| "INVOKE" \| "FIELD", …}`, `cancellable: true` |
| `Overwrite` | Replace entire method | (none) |
| `WrapOperation` | MixinExtras: wrap an invocation | `method`, `at: {value: "INVOKE", target: "…"}`, plus `Operation` parameter |

**Rules for `target` descriptors:** use **obfuscated/SRG names** in `method` and `at.target`. Mixin remap is hardcoded to `false` in ZenUtils. You may still use MCP names in the function body when calling methods.

**Wildcard method:** `method: "*"` matches every method in the class (useful for `ModifyConstant`).

## Allowed types

Inside mixin scripts, only **native types** are allowed because mixin loads before CraftTweaker registers its own types. Use:

- Native imports: `import native.com.example.Class;`
- Primitive arrays: `[int]`, `[string]`, etc.
- Callback types: `mixin.CallbackInfo`, `mixin.CallbackInfoReturnable`, `mixin.Operation`

## CallbackInfo and CallbackInfoReturnable

For `Inject` hooks that need cancellation or return-value capture:

```zs
import mixin.CallbackInfo;
import mixin.CallbackInfoReturnable;

#mixin Inject {method: "foo", at: {value: "HEAD"}, cancellable: true}
function cancelFoo(ci as CallbackInfo) as void {
    ci.cancel();
}

#mixin Inject {method: "bar", at: {value: "RETURN"}, cancellable: true}
function modifyBar(cir as CallbackInfoReturnable) as void {
    cir.setReturnValue(42);
}
```

`CallbackInfoReturnable#getReturnValue` returns `java.lang.Object`; cast it to the real type.

## WrapOperation and MixinExtras

Requires ZenUtils ≥ v1.26.0. Use `mixin.Operation` to call the original method.

```zs
import mixin.Operation;

#mixin WrapOperation
#{
#    method: "doInit",
#    at: {value: "INVOKE", target: "Lowner;method()V"}
#}
function wrappedCall(owner as SomeType, arg as int, original as Operation) as void {
    // skip, modify, or delegate
    original.call(owner, arg);
}
```

`Operation#call` accepts `java.lang.Object...` and returns `java.lang.Object` due to lack of generics in ZenScript.

## Parameter annotations (Local, Share, Cancellable)

Annotate a specific parameter with an extra `#mixin` preprocessor before the function. Use `parameter: n` to choose which parameter (0 = first, -1 = last, -2 = penultimate; default is -1).

### LocalRef simulation

If a parameter needs `LocalRef<T>`, add `ref: true` and declare the parameter as a **1-length array**:

```zs
#mixin WrapOperation {method: "doInit", at: {value: "INVOKE", target: "…"}}
#mixin Local {parameter: -1, ref: true}
function myHook(
    manager as ISqueezerManager,
    operation as mixin.Operation,
    localVar as ItemRegistryCore[]  // LocalRef<ItemRegistryCore>
) as void {
    operation.call(manager);
    print(toString(localVar[0])); // get
    localVar[0] = null;           // set
}
```

## Shadow fields

Access private fields of the target class by declaring them with `#mixin Shadow`. You can also combine with `#mixin Final`:

```zs
#mixin Shadow
#mixin Final
var mana as int;

#mixin Shadow
static privateStaticField as Type;
```

## Private member exposure

A function **without** any mixin annotation is injected into the target class directly. This lets you expose private members to outside scripts:

```zs
#mixin {targets: "foo.Bar"}
zenClass MixinFooBar {
    // Creates a public method on foo.Bar
    function getPrivateField() as Type {
        return this0.privateField;
    }
}
```

Then in a normal `#loader crafttweaker` script:

```zs
val barObj as Bar = ...;
barObj.getPrivateField();
```

## `this0`

Inside a mixin method, `this0` is the target instance already cast to the target type. Use it to access fields and methods (including private/protected and superclass members). For static contexts, use shadowed static fields instead — `this0` does not handle static members.

## `zenClass` naming convention

Name the class `Mixin<TargetClassName>` for clarity. It does not have to match the Java file name, but consistency helps:

```zs
zenClass MixinTileEntitySilo { ... }
zenClass MixinAlloyRecipeManager { ... }
```

## Full example

```zs
#modloaded immersiveengineering
#loader mixin

#mixin {targets: "blusunrize.immersiveengineering.common.blocks.metal.TileEntitySilo"}
zenClass MixinTileEntitySilo {
    #mixin Static
    #mixin ModifyConstant {method: "<clinit>", constant: {intValue: 41472}}
    function buffStorage(value as int) as int {
        return 2000000000;
    }
}
```

## `#mixin` annotation parser rules

The JSON body of `#mixin` annotations is parsed by **Google Gson in lenient mode** (`new GsonBuilder().setLenient().create()`). This means the annotation block accepts a relaxed superset of standard JSON.

### What works (lenient JSON)
- **Unquoted keys**: `{method: "foo"}` or `{ 'method': "foo" }`
- **Single-quoted strings**: `{value: 'HEAD'}`
- **Comments inside the block**: `// line comment` or `/* block comment */`
- **`=` or `=>` instead of `:`**: `{key => value}`
- **`;` instead of `,`**: `[a; b; c]` or `{a=1; b=2}`
- **Extra array separators**: `[1, 2, ,]` (omitted value becomes `null`)
- **Any capitalization for literals**: `true`/`TRUE`/`True`, `false`, `null`
- **Unescaped control characters** in strings

### What does NOT work
- **Trailing commas**: `[1, 2,]` is rejected. Use an extra separator only if you want a `null` filler: `[1, 2, ,]`.
- **Nested block comments**.

## Cross-skill links

- E2E:E mixin file conventions and patterns → `zenscript-mixins`
- General ZenScript edge cases and behavior → `zenscript`
- ZenUtils feature index and wiki URLs → `zenutils`
