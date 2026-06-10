---
name: quest
description: Edit FTB Quests (.snbt) — tasks, rewards, descriptions, lang files. Load when modifying quest content.
---

## Quest file locations

| What | Path |
|------|------|
| Quest definitions | `config/ftbquests/normal/chapters/<chapter>/<quest>.snbt` |
| Chapter index | `config/ftbquests/normal/chapters/index.snbt` |
| Reward tables | `config/ftbquests/normal/reward_tables/<uid>.snbt` |
| Reward table index | `config/ftbquests/normal/reward_tables/index.snbt` |
| Lang (EN) | `resources/ftbquests/lang/en_us.lang` |
| Lang (RU) | `resources/ftbquests/lang/ru_ru.lang` |
| Lang (ZH) | `resources/ftbquests/lang/zh_cn.lang` |

## Quest SNBT structure

```snbt
{
  title: "{q.mod.quest.name}",       // optional — auto from first task item if missing
  icon: "mod:item",                   // optional
  x: 0.0d, y: 0.0d,                 // required — position on chapter map
  shape: "square",                    // optional
  size: 0.75d,                        // optional
  optional: 1b,                       // optional
  hide_dependency_lines: 1b,          // optional
  disable_toast: 1b,                  // optional
  can_repeat: 1b,                     // optional
  text: ["{q.mod.quest.desc}"],       // required
  dependencies: ["<uid>"],            // optional
  tasks: [{ uid, type, items, ... }],
  rewards: [{ uid, type, ... }]
}
```

### Task types

**Item task** (most common):
```snbt
{
  uid: "8hexchars",
  type: "item",
  items: [{ item: "mod:item", count: 1 }],  // flat string or {id, tag, Count}
  count: 1L,                                  // total count across all items
  consume_items: 0b,
  ignore_damage: 1b,
  ignore_nbt: 1b,
  only_from_crafting: 0b,
  partial_results: 1b
}
```
Items can be a flat string `"mod:item 1 meta"` or an object `{id:"mod:item", Damage:0s, Count:1b, tag:{...}}`.
Multiple items in the array = any of them counts.

### Reward types

**Item reward:**
```snbt
{ uid: "8hexchars", type: "item", item: "mod:item", count: 1 }
```

**Custom reward** (loot crate or invisible/scripted):
```snbt
{ uid: "8hexchars", type: "custom", title: "{e2ee.quest.rare}", icon: { id: "ftbquests:lootcrate", tag: { type: "rare" } }, tags: ["loot"] }
```
Auto-invisible: add `auto: "invisible"`, `team_reward: 1b`, omit icon.
Available rarities: `common`, `uncommon`, `rare`, `legendary`, `mythic`, `decor`, `food`, `generators`, `materials`, `storage`.

**Choice reward** (pick from reward table):
```snbt
{ uid: "8hexchars", type: "choice", table: <index> }
```
Table index is 0-based position in `reward_tables/index.snbt`.

**XP reward:**
```snbt
{ uid: "8hexchars", type: "xp_levels", xp_levels: 50 }
```

### Multi-task / multi-reward

Simply add more objects to the `tasks: []` / `rewards: []` array. Each needs a unique 8-char hex `uid`.

## Lang key pattern

- Quest name: `q.<mod>.<quest>.name`
- Quest desc: `q.<mod>.<quest>.desc`
- Custom reward title: `{e2ee.quest.<rarity>}`
- Use `§` color codes (`§6`, `§c`, `§a`, `§r`, etc.) and `\n` for line breaks in lang values.

## Common tasks

### Add a task item to a quest
1. Find quest by item ID or lang key
2. Add a new `{uid, type:"item", items:[{item:"..."}]}` to the `tasks` array
3. Use a unique 8-char hex uid (quest filename without `.snbt` works)

### Change reward type
Replace the reward object. For table→custom, replace `{type:"choice", table:N}` with `{type:"custom", title:"{e2ee.quest.rare}", icon:{id:"ftbquests:lootcrate", tag:{type:"rare"}}, tags:["loot"]}`.

### Update quest description
1. Change the lang file entry for `q.<mod>.<quest>.desc` in all 3 lang files
2. Use `\n\n` for paragraph breaks, `§` for color

### Add a quest reward where none exists
Append `rewards: [{...}]` after the `tasks` array (before closing `}`).

## Committing quest changes

**Format:** `<type>(quest): 📖<description>`
- Types: `fix`, `feat`, `chore`, `refactor`
- Item names in `[]`: `[Thermal Centrifuge][Induction Furnace]`

**Before commit — check emoji for the file:**
```sh
git log -n 5 --pretty=format:%B -- path/to/file
```

**Body (optional):** one sentence explaining *why*, aimed at players.

**Staging lang files selectively** (only quest-related lines):
```sh
printf 'y\ny\nn\n' | git add -p resources/ftbquests/lang/en_us.lang
```

## Item format reference

- Flat string: `"mod:item <count> <meta>"` e.g. `"ic2:te 1 52"`, `"ic2:upgrade 1 3"`
- Object: `{ id: "mod:item", Count: 1b, Damage: 0s, tag: { ... } }`

Find item names via JEI dumps or grep existing quests.
