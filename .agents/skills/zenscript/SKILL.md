---
name: zenscript
description: General-purpose ZenScript (.zs) guide for edge cases, odd behavior, and unexpected issues. Load this when creating or editing any file under scripts/.
metadata:
  audience: modpack-devs
  workflow: writing-zs
---

## Known Culprits

### Map-accessed primitives are wrapped and nullable
`map[key]` returns a wrapped primitive (not a raw primitive) that may be `null`.  
- Null-check the result if the key might not exist  
- Cast to the native primitive type (e.g., `int`, `bool`) before use  

### Native Types
- ZenScript only has `string`; replace `char`/`CharSequence` with `string`.
- No varargs (`T...`); use `T[]` arrays for variable-length parameters.
- Replace Java collections/lists (`List`, `Iterable`, `Iterator`, etc.) with ZenScript list syntax `[type]`.

### Tooltips & JEI descriptions
Use the project helper `scripts.lib.tooltip.desc` instead of raw `mods.jei.JEI.addDescription` / `item.addTooltip`:
- `desc.jei(item, 'key')` — JEI tab; `desc.tooltip(item, 'key')` — hover; `desc.both(item, 'key')` — both.
- Lang key is auto-prefixed with `tooltips.lang.`. Multiline via `\n` or `<br>` in the lang value (one key per item, not `descN` splits).

### Loader / guard directives
- `#loader contenttweaker` — required for `VanillaFactory.createItem` / `IItemUse`. Recipes, tooltips, JEI stay on the default CrT loader (split into two files when both are needed).
- `#modloaded a b c` — skip the script unless all listed mods are present.
- `#ignoreBracketErrors` — needed when bracket handlers (`<modid:...>`) reference optional mods.
