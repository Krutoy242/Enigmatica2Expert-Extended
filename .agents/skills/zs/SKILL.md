---
name: zs
description: General ZenScript, mod-tweak, loot-table, and ZenUtils reference for scripts/*.zs. ALWAYS LOAD THIS SKILL when creating or editing ANY .zs file — it is MANDATORY for every ZenScript task.
metadata:
  audience: modpack-devs
  workflow: writing-zs
---

## Limitations

- No `try-catch` blocks.
- Instances are created without `new`: `val myClass = MyClass();`.
- Statics initialized with `static name` instead of `static var name`. Static functions initialized as static variables: `static init as function()void = function() as void { ... };`.

## Language edge cases

- **Map primitives are wrapped/nullable**: `map[key]` may return `null`. Cast to native primitive (`as int`, `as bool`) before use.
- **Native types**: only `string`; no `char`/`CharSequence`. No varargs — use `T[]`. Replace Java collections with ZenScript list syntax `[type]`.
- **Tooltips/JEI**: use `scripts.lib.tooltip.desc` helpers (`desc.jei`, `desc.tooltip`, `desc.both`) instead of raw JEI API. Lang keys auto-prefixed with `tooltips.lang.`.
- **Loader directives**: `#loader contenttweaker` for `VanillaFactory`/`IItemUse`; default loader for recipes/JEI. `#modloaded a b c` skips file unless all mods present. `#ignoreBracketErrors` when brackets reference optional mods.
- **Native collections**: annotate the **left-hand side** (`val recipes as [IRecipe] = ...`). Right-hand casts are ignored.
- **Upcasting**: must use an unsafe left-hand cast; right-hand cast is ignored:
  ```zs
  val entityLiving as IEntityLiving = entity; // Left-hand upcast
  ```
- **Map iteration**: generics are erased; cast each entry explicitly:
  ```zs
  for _entry in map.entrySet() {
      val entry = _entry as native.java.util.Map.Entry;
      val key   = entry.key as ItemStack;
      val value = entry.value as double;
  }
  ```
- **Array inference**: contextual typing wins (`as T[]`). Empty `[]` → `any[]`. Homogeneous infers to element type. Primitives (`int`, `long`, `float`, `double`, `bool`) never mix without context. Objects may share a common super-interface (e.g., `[<item>, <liquid>]` → `IIngredient[]`).
- **World time**: `world.time` is day time (0–24000) and freezes when day/night cycle is off. Use `world.worldInfo.worldTotalTime` for tick intervals.

## Mod tweaks (`scripts/mods/`)

One file per mod (`scripts/mods/<modid>.zs`), starting with `#modloaded <mod-id>`. Typical flow: hide unwanted JEI entries/categories, remove original recipes (`removeByRecipeName` preferred), then add replacements via shared craft helpers. Use `#priority 100` and `#reloadable` when you only touch recipes.

## Loot tables

Two parallel systems:
1. **LootTweaker** (`scripts/loot/`): `LootTweaker.getTable("...")`, `addPool("e2ee_...", ...)`, `addItemEntry(...)`. Reuse shared pools from `scripts/loot/preMadeLoot.zs` by iterating its static maps. Use pool prefix `e2ee_` and `#priority 10` so additions run after `scripts/_init/purge_loot.zs`.
2. **Dropt** (`config/dropt/` + `scripts/lib/dropt.zs`): for block/mob drops LootTweaker can't reach. Build rules in JSON or via ZS helpers.

## Native method access

Native method access: prefix imports with `native.` (e.g. `native.net.minecraft.world.World`). Use `.native` to unwrap CraftTweaker objects to MC classes and `.wrapper` to wrap them back; conversions apply automatically in arguments and casts. MCP method names are remapped to obfuscated names automatically, and JavaBean getters/setters (`getFoo`/`setFoo`) translate to ZenScript `foo` properties. `Iterable<T>` types can be iterated, expose `.length`, and cast to `[T]`; `==`/`!=` invoke `Objects.equals`. Downcasting native classes requires a checked right-hand cast (`val player = entity as Player`).

Advanced: `zenClass` can `extends` one native class plus any number of native interfaces; overrides must use SRG names (MCP in comments). Most dangerous APIs are blacklisted: file I/O, network, multithreading, Mixin/ASM, other JVM languages, and core Java internals (`java.lang` except `Class`, `sun.*`, `jdk.*`). `java.lang.Class` objects are obtainable (via `.class` or `.getClass()`) but all reflection methods on them are blocked.

## ZenUtils quick reference

Read any wiki page without cloning:
```bash
curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/<Folder>/<Page>.md"
```

Key areas (replace `<Folder>/<Page>`):
- **Preprocessors / utilities**: `Others/ScriptReloading`, `Others/SuppressErrorPreprocessor`, `Others/HardFailPreprocessor`, `Others/OrderlyMap`, `Others/GlobalFunctions`, `Others/Catenation`, `Others/PersistedCatenation`
- **ZenExpansions**: `ZenExpansion/TemplateString`, `ZenExpansion/NullishOperators`, `ZenExpansion/ArrayAndListOperations`, `ZenExpansion/NativeMethodAccess`, `ZenExpansion/Mixin`, `ZenExpansion/ZenUtilsPlayer`, `ZenExpansion/ZenUtilsWorld`
- **Classes**: `Classes/CrTI18n`, `Classes/CrTUUID`, `Classes/CrTItemHandler`, `Classes/CrTLiquidHandler`, `Classes/PlayerStat`, `Classes/GameRuleHelper`
- **Events**: `Events/EntityRemoveEvent`, `Events/WorldEvents`, `Events/GenericEventManager`
- **Custom commands**: `CustomCommand/ZenCommand`, `CustomCommand/ZenCommandTree`
- **CoT expansion**: `ContentTweakerExpansion/ExpandItem`, `ContentTweakerExpansion/EnergyItem`, `ContentTweakerExpansion/TileEntity`
- **FTB Quests**: `FTBQuests/Quest`, `FTBQuests/Events/QuestCompletedEvent`

Browse rendered wiki: `gh browse --wiki -R friendlyhj/ZenUtils`
