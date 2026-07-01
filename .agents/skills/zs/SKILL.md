---
name: zs
description: Write ZenScript in `./scripts/`. Load for editing any .zs file, or to register/modify mod-registry content (e.g. registering Tinkers modifiers/traits) from scripts via native access.
---

## Signature lookup (`zsfind`)

Use when using unknown getters/methods in `.zs` code or getting type error. Queries class definitions, properties (`val`/`var`), and method signatures with expanded types. Searches two dumps: the curated CraftTweaker API (`ct-dump`, preferred) and the raw `native.` Minecraft/mod classes (`ct-dump-native`, ~113k files, used as a fallback).

```bash
pnpm zsfind ClassOne ClassTwo.field ClassThree.method
```

**Query forms** (pass as many as you want in one call):
- **Short name** — `IItemStack`, `EntityPlayer`
- **Partial path** — dots or slashes: `crafttweaker.item.IItemStack`, `net/minecraft/item/ItemStack`, `native.net.minecraft.item.ItemStack`
- **Member** — `IItemStack.withTag`, `EntityPlayer.gameProfile`
- **Regex pattern** — `IItem(Stack|Definition)`, `.*Player`, `^I`
  - Auto-detected when query contains regex metacharacters `()|*+?[]{}^$`
  - Results ≤25 printed as a list; more prompts to narrow the query
  - Expansion files (zenClass importing an identically-named class) are excluded

**Output format:** all file paths display as class-style paths: `crafttweaker.item.IItemStack`, `native.net.minecraft.item.ItemStack`, `crafttweaker.item.IItemStack → withTag`.

**Examples:**
```bash
# Recommend using multiple signatures in search:
pnpm zsfind IItemStack.withTag IData.asString IBlockState

# Lookup a getter and automatically load its returned class:
pnpm zsfind IItemStack.definition

# Native (vanilla/mod) class — found via the ct-dump-native fallback:
pnpm zsfind EntityPlayer

# Regex to find all IItemStack/IItemDefinition variants:
pnpm zsfind "IItem(Stack|Definition)"

# Broad regex warns with count and asks to narrow:
pnpm zsfind "^I"
# → Found 15655 matches, narrow your query.
```

Failed lookups print fuzzy "did you mean" suggestions. Ambiguous short names (e.g. `Builder`) list the matching paths so you can re-query with a path. The native file index is cached; pass `--reindex` after the dump is regenerated.Backend: `@mctools/zsfind` package (`mc-tools/packages/zsfind`).

## Limitations

- No `try-catch` blocks.
- Instances are created without `new`: `val myClass = MyClass();`.
- Statics initialized with `static name` instead of `static var name`. Static functions initialized as static variables: `static init as function()void = function() as void { ... };`.
- **`#priority` is inverted**: higher number = EARLIER load. Examples: `#priority 100` loads before `#priority 0` loads before `#priority -10`. Most negative = last.
- **`zenClass` cannot see module-level `function` in same file**: `function` keyword outside `zenClass` is invisible from inside its methods. Put helpers in a separate file and `import` them — imported symbols (even functions from other files) are visible.

## Language edge cases

- **Map primitives are wrapped/nullable**: `map[key]` may return `null`. Cast to native primitive (`as int`, `as bool`) before use.
- **Object → primitive**: ZS cannot cast `Object` directly to `int`/`double`/`bool`. Double-cast via wrapper: `obj as Integer as int`, `obj as Double as double`.
- **Native types**: only `string`; no `char`/`CharSequence`. No varargs — use `T[]`. Replace Java collections with ZenScript list syntax `[type]`.
- **Tooltips/JEI**: use `scripts.lib.tooltip.desc` helpers (`desc.jei`, `desc.tooltip`, `desc.both`) instead of raw JEI API. Lang keys auto-prefixed with `tooltips.lang.`.
- **Loader directives**: `#loader contenttweaker` for `VanillaFactory`/`IItemUse`; default loader for recipes/JEI. `#modloaded a b c` skips file unless all mods present. `#ignoreBracketErrors` when brackets reference optional mods.
- **Native collections**: annotate the **left-hand side** (`val recipes as [IRecipe] = ...`). Right-hand casts are ignored.
- **Upcasting**: must use an unsafe left-hand cast; right-hand cast is ignored:
  ```zs
  val entityLiving as IEntityLiving = entity; // Left-hand upcast
  ```
- **Prefer ZS maps/lists**: use `type[type]` and `[type]` instead of `HashMap`/`ArrayList`/`Map`. Java types only at API boundaries.
- **Maps can't hold functions as values**: a typed function-value map (`function(T)void[string]`) fails to parse, and an `any[string]` map errors when you assign a function (`map[key] = fn`). For a name→handler registry, use two parallel lists — `[string]` keys + `[function(T)void]` handlers — and dispatch by linear scan (see the `/dump` subcommand dispatch in `scripts/debug/dump/main.zs`).
- **Map iteration**: generics are erased; cast each entry explicitly:
  ```zs
  for _entry in map.entrySet() {
    val entry = _entry as native.java.util.Map.Entry;
    val key   = entry.key as ItemStack;
    val value = entry.value as double;
  }
  ```
- `static variable as type = ...;` left-handed typing is mandatory. Would error without type from the left.
- **`static` fields are final at runtime**: reassigning throws `IllegalAccessError` at runtime (not caught by `ct syntax`). Use a mutable map for global state: `static flags as bool[string] = {};` then `flags['k'] = true;`.
- **`IItemStack.native` returns a copy**: mutations are discarded. Reach the live stack via `entity.getItemStackFromSlot(slot)` and match with `ItemStack.areItemStacksEqual`. CoT trait callbacks (`onToolDamage`, `onArmorDamaged`) have the same limitation.
- **Array inference**: contextual typing wins (`as T[]`). Empty `[]` → `any[]`. Homogeneous infers to element type. Primitives (`int`, `long`, `float`, `double`, `bool`) never mix without context. Objects may share a common super-interface (e.g., `[<item>, <liquid>]` → `IIngredient[]`).
- **Array/list mutability**: `T[]` (array syntax) is **immutable** — `.add()` silently fails, `.length` stays 0. Use `[T]` (list syntax) for mutable collections. In function return types, never return bare `[]` — it compiles to `IAny[]` and fails bytecode verification; use `[] as T[]`.
- **World time**: `world.time` is day time (0–24000) and freezes when day/night cycle is off. Use `world.worldInfo.worldTotalTime` for tick intervals.
- **Function params immutable**: `function` parameters are `val`. To reassign, copy to `var`: `var x = param;`.
- **Global `min`/`max` are type-strict**: the global `min(a,b)`/`max(a,b)` resolve, but only have matching-primitive overloads (`int,int` / `long,long` / `float,float` / `double,double`) — no auto-widening or mixed types, so `max(1, xAsDouble)` (int+double) or `max(0.0, yAsFloat)` (double+float) fail to resolve.
- **Enum shorthand**: imported enum constants are accessible as bare identifiers — `head` instead of `crafttweaker.entity.IEntityEquipmentSlot.head()`. Import the enum class and use values directly: `[head, chest, legs, feet] as IEntityEquipmentSlot[]`.

## Folder structure
- `scripts/mods/` files solely for one mod. Create subfolders when need many files.
- `scripts/loot/` tweaking loot tables.
- `scripts/lib/` reusable libraries.

### Extensible system with safe mod feature injection

A core library in `scripts/lib/` defines only the base logic and exposes a static list of extension callbacks. It never imports classes from optional mods, so it always loads regardless of which mods are present.

Files in `scripts/lib/<name>/mod/` add functionality for specific mods. Each such file is guarded by `#modloaded <modid>` and contains initialisation code that registers its callback function into the core library's static list at load time (via `scripts.lib.<name>.<listName>.add(...)`).

The trick relies on the fact that `#modloaded` skips parsing the entire file when the mod is absent — the mod's class imports are never resolved, so the core library never sees errors. When the mod is present, the file loads and the callback is registered before any call to the core function.

## Native method access

Native method access: prefix imports with `native.` (e.g. `native.net.minecraft.world.World`). Use `.native` to unwrap CraftTweaker objects to MC classes and `.wrapper` to wrap them back; conversions apply automatically in arguments and casts. MCP method names are remapped to obfuscated names automatically, and JavaBean getters/setters (`getFoo`/`setFoo`) translate to ZenScript `foo` properties. `Iterable<T>` types can be iterated, expose `.length`, and cast to `[T]`; `==`/`!=` invoke `Objects.equals`. Downcasting native classes requires a checked right-hand cast (`val player = entity as Player`).

Advanced: `zenClass` can `extends` one native class plus any number of native interfaces; overrides must use SRG names (MCP in comments). Most dangerous APIs are blacklisted: file I/O, network, multithreading, Mixin/ASM, other JVM languages, and core Java internals (`java.lang` except `Class`, `sun.*`, `jdk.*`). `java.lang.Class` objects are obtainable (via `.class` or `.getClass()`) but all reflection methods on them are blocked.

## Mod source code lookup

Get the local path to a mod's **Java source** when you need method signatures, field names, or bytecode — for native access (above), mixins, or understanding mod internals. Do NOT use for config/recipe questions.

```bash
pnpm mod-source <mod_name_or_id>   # prints absolute source path to stdout
pnpm mod-source mod_name_or_id | eza -T --stdin | head -60
```

The single result path goes to stdout; all diagnostics go to stderr. It resolves in order: existing local folder/cache → clone from `minecraftinstance.json`/CurseForge → jar metadata + GitHub search → same-author/Gemini → decompile. Backed by the `@mctools/source` package (`mc-tools/packages/source`).

## ZenUtils quick reference

Read any wiki page without cloning:
```bash
bash .agents/skills/zs/zenutils.sh <folder/page>
```

Key areas:
- **Preprocessors / utilities**: `Others/ScriptReloading`, `Others/SuppressErrorPreprocessor`, `Others/HardFailPreprocessor`, `Others/OrderlyMap`, `Others/GlobalFunctions`, `Others/Catenation`, `Others/PersistedCatenation`
- **ZenExpansions**: `ZenExpansion/TemplateString`, `ZenExpansion/NullishOperators`, `ZenExpansion/ArrayAndListOperations`, `ZenExpansion/NativeMethodAccess`, `ZenExpansion/Mixin`, `ZenExpansion/ZenUtilsPlayer`, `ZenExpansion/ZenUtilsWorld`
- **Classes**: `Classes/CrTI18n`, `Classes/CrTUUID`, `Classes/CrTItemHandler`, `Classes/CrTLiquidHandler`, `Classes/PlayerStat`, `Classes/GameRuleHelper`
- **Events**: `Events/EntityRemoveEvent`, `Events/WorldEvents`, `Events/GenericEventManager`
- **Custom commands**: `CustomCommand/ZenCommand`, `CustomCommand/ZenCommandTree`
- **CoT expansion**: `ContentTweakerExpansion/ExpandItem`, `ContentTweakerExpansion/EnergyItem`, `ContentTweakerExpansion/TileEntity`
- **FTB Quests**: `FTBQuests/Quest`, `FTBQuests/Events/QuestCompletedEvent`

Examples:
```bash
bash .agents/skills/zs/zenutils.sh ZenExpansion/NullishOperators
bash .agents/skills/zs/zenutils.sh Classes/CrTI18n
```

## Deobfuscating SRG field names

When native access shows only SRG names like `field_135054_a`, look up the MCP deobfuscated name from the bundled stable-39 mappings:

```bash
# Look up a specific SRG field
7z x config/mcp_stable-39-1.12.zip -so fields.csv | rg field_135054_a

# Look up all SRG fields matching a pattern
7z x config/mcp_stable-39-1.12.zip -so fields.csv | rg "I18n|Locale"

# The CSV columns: searge,name,side,desc
# side: 0=both, 1=server, 2=client
```

Where `config/mcp_stable-39-1.12.zip` is the MCP mapping archive in the project root. If a field is missing from the native dump but exists in the mappings, you may still be able to reference it by either its SRG or MCP name (both work in ZS native access).

## MC command executing

There is running MC instance with current modpack. You can execute commands and receive their responces.

```bash
npx tsx .agents/skills/zs/run-cmd.ts 'say Hello!' # Execute `/say Hello!` from the server
npx tsx .agents/skills/zs/run-cmd.ts 'say Hello' 'say World!' # allow chaining
```

## Troubleshooting

### Full syntax/parse error breakdown
Use after changing any .zs script, except for #reloadable scripts. DO NOT use if you planning to use `ct-reload` next.
```bash
pnpm ct-syntax
```
Note: ZenUtils have a bug that throwing false error `unsupported mixin annotation: Static`. Always ignore this error.

### Safe complete reload with syntax pre-checking
Runs syntax check first, aborts if errors found, otherwise reloads and reports errors. Use after changing #reloadable scripts:
```bash
pnpm ct-reload
```
Note: `/ct reload` has a known bug that shows some unrelated errors. Track file source of errors. It also does NOT reset live runtime state (windowIds, cached maps). If a handler still misbehaves after reload, do a full MC restart with `pnpm reducer restart` (see the `reducer` skill — it also reports `crafttweaker.log` errors and can disable mods or auto-bisect a load bug).

## Event patterns

### Avoiding throws inside event handlers
ZenScript has no `try-catch`, so a native method that throws (e.g. `IModifier.canApply` throws `TinkerGuiException`) aborts the whole script. Use boolean alternatives (`canApplyTogether`) or sanitize inputs so the throwing path is never reached.
