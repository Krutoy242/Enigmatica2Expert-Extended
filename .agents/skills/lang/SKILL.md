---
name: lang
description: Edit .lang files under resources/ via editlang.sh script. Load when doing i18n, localization changes, or adding translation keys. Do NOT load for non-lang text changes.
---

## Workflow

1. Find key pattern via grep
2. Replace value using `bash .agents/skills/lang/editlang.sh`

## Script (always use instead of default edit tool)

```bash
bash .agents/skills/lang/editlang.sh <file_path> <lang_key> <value>
```

### Example

```bash
bash .agents/skills/lang/editlang.sh resources/contenttweaker/lang/en_us.lang item.contenttweaker.coin_fakeiron.name "Iron Alloy Coin"
```

### Parameters

1. `file_path` - Path to the `.lang` file (must exist)
2. `lang_key` - The translation key to update (must exist in file)
3. `value` - New value (use quotes if contains spaces). `%` signs are auto-escaped to `%%`.

### Error handling

| Exit code | Condition |
|-----------|-----------|
| 1 | Missing arguments |
| 2 | File not found or not a `.lang` file |
| 3 | Key not found in file |

## Gotchas

- `%` signs are automatically escaped to `%%` by the script.
- `editlang.sh` only **updates existing** keys (exit 3 if the key is absent). To **add a new** key, edit the file directly with the normal edit tool, placing it next to a related key, and add the same key to **every** locale file the pack ships (mirror `en_us`, `ru_ru`, `zh_cn`, …).

## Additional emojis

These Unicode characters render correctly in-game, so try to use them:
```
─│┌┐└┘├┤┬┴┼═║╒╓╔╕╖╗╘╙╚╛╜╝╞╟╠╡╢╣╤╥╦╧╨╩╪╫╬▀▄█▌▐░▒▓♩♪♫♬♭♮⚀⚁⚂⚃⚄⚅⚐⚑☀☁☂☃☄★☆☈☐☑☒☔⚓⚔⚗⚠⚡⚥✂✉✎✔✘❄❣❤⭐⌘⌚⌛⏏☮☯☜☞☠☹☺
```
