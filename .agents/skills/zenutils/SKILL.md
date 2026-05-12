# ZenUtils

Reference for [friendlyhj/ZenUtils](https://github.com/friendlyhj/ZenUtils) — a CraftTweaker 1.12 addon. Use this skill to know what features exist and how to pull their docs directly from the wiki.

**Wiki snapshot:** 2026-03-08

## Read a wiki page (no clone, no temp files)

Every page can be read with `curl` from the raw wiki URL:

```bash
curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/<Folder>/<Page>.md"
```

Examples:
```bash
curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/Others/ScriptReloading.md"
curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/ZenExpansion/Mixin.md"
curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/CustomCommand/ZenCommand.md"
```

## Feature index

### ZenScript Extension

| Feature | Command |
|---------|---------|
| ScriptReloading | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/Others/ScriptReloading.md"` |
| SuppressErrorPreprocessor | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/Others/SuppressErrorPreprocessor.md"` |
| HardFailPreprocessor | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/Others/HardFailPreprocessor.md"` |
| OrderlyMap | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/Others/OrderlyMap.md"` |
| IData Deep Update | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/Classes/DeepDataUpdate.md"` |
| Template String | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/ZenExpansion/TemplateString.md"` |
| Nullish Operators | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/ZenExpansion/NullishOperators.md"` |
| Array and List Operations | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/ZenExpansion/ArrayAndListOperations.md"` |
| Native Method Access | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/ZenExpansion/NativeMethodAccess.md"` |
| Mixin | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/ZenExpansion/Mixin.md"` |
| GlobalFunctions | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/Others/GlobalFunctions.md"` |
| Catenation | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/Others/Catenation.md"` |
| PersistedCatenation | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/Others/PersistedCatenation.md"` |

### ZenExpansions

| Feature | Command |
|---------|---------|
| ZenUtilsEntity | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/ZenExpansion/ZenUtilsEntity.md"` |
| ZenUtilsEntityDefinition | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/ZenExpansion/ZenUtilsEntityDefinition.md"` |
| ZenUtilsPlayer | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/ZenExpansion/ZenUtilsPlayer.md"` |
| ZenUtilsWorld | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/ZenExpansion/ZenUtilsWorld.md"` |
| ExpandedCommandManager | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/ZenExpansion/ExpandedCommandManager.md"` |

### Classes

| Feature | Command |
|---------|---------|
| CrTI18n | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/Classes/CrTI18n.md"` |
| CrTUUID | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/Classes/CrTUUID.md"` |
| CrTItemHandler | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/Classes/CrTItemHandler.md"` |
| CrTLiquidHandler | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/Classes/CrTLiquidHandler.md"` |
| ILiquidTankProperties | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/Classes/ILiquidTankProperties.md"` |
| StringList | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/Classes/StringList.md"` |
| HexHelper | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/Classes/HexHelper.md"` |
| StaticString | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/Classes/StaticString.md"` |
| PlayerStat | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/Classes/PlayerStat.md"` |
| IStatFormatter | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/Classes/IStatFormatter.md"` |
| GameRuleHelper | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/Classes/GameRuleHelper.md"` |

### Events

| Feature | Command |
|---------|---------|
| EntityRemoveEvent | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/Events/EntityRemoveEvent.md"` |
| EntityItemDeathEvent | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/Events/EntityItemDeathEvent.md"` |
| EntityItemFallEvent | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/Events/EntityItemFallEvent.md"` |
| WorldEvents | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/Events/WorldEvents.md"` |
| GenericEventManager | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/Events/GenericEventManager.md"` |

### Custom Command

| Feature | Command |
|---------|---------|
| ZenCommand | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/CustomCommand/ZenCommand.md"` |
| ZenCommandTree | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/CustomCommand/ZenCommandTree.md"` |
| ZenUtilsCommandSender | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/CustomCommand/ZenUtilsCommandSender.md"` |
| IGetCommandUsage | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/CustomCommand/IGetCommandUsage.md"` |
| ICommandExecute | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/CustomCommand/ICommandExecute.md"` |
| IGetTabCompletion | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/CustomCommand/IGetTabCompletion.md"` |
| CommandUtils | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/CustomCommand/CommandUtils.md"` |

### CoT Expansion

| Feature | Command |
|---------|---------|
| ExpandVanillaFactory | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/ContentTweakerExpansion/ExpandVanillaFactory.md"` |
| ExpandItem | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/ContentTweakerExpansion/ExpandItem.md"` |
| ExpandBlock | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/ContentTweakerExpansion/ExpandBlock.md"` |
| EnergyItem | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/ContentTweakerExpansion/EnergyItem.md"` |
| TileEntity | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/ContentTweakerExpansion/TileEntity.md"` |
| TileEntityInGame | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/ContentTweakerExpansion/TileEntityInGame.md"` |
| LateSetCoTFunction | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/ContentTweakerExpansion/LateSetCoTFunction.md"` |

### FTB Quests Events

| Feature | Command |
|---------|---------|
| QuestObjectBase | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/FTBQuests/QuestObjectBase.md"` |
| Chapter | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/FTBQuests/Chapter.md"` |
| Quest | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/FTBQuests/Quest.md"` |
| Task | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/FTBQuests/Task.md"` |
| Reward | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/FTBQuests/Reward.md"` |
| FTBQEventManager | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/FTBQuests/Events/FTBQEventManager.md"` |
| ObjectCompletedEvent | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/FTBQuests/Events/ObjectCompletedEvent.md"` |
| ChapterCompletedEvent | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/FTBQuests/Events/ChapterCompletedEvent.md"` |
| QuestCompletedEvent | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/FTBQuests/Events/QuestCompletedEvent.md"` |
| TaskCompletedEvent | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/FTBQuests/Events/TaskCompletedEvent.md"` |
| TaskStartedEvent | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/FTBQuests/Events/TaskStartedEvent.md"` |
| CustomRewardEvent | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/FTBQuests/Events/CustomRewardEvent.md"` |
| CustomTaskEvent | `curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/FTBQuests/Events/CustomTaskEvent.md"` |

## Browse interactively with `gh`

Open the rendered wiki in browser:
```bash
gh browse --wiki -R friendlyhj/ZenUtils
```

Print the wiki URL:
```bash
gh browse --wiki -n -R friendlyhj/ZenUtils
```

## Updating this skill

When ZenUtils adds new wiki pages, follow these steps to update the skill:

1. **List current wiki files** (no clone needed, uses shallow fetch):
   ```bash
   cd /tmp && git clone --depth 1 https://github.com/friendlyhj/ZenUtils.wiki.git && find ZenUtils.wiki -name "*.md" | grep -v _Sidebar | sed 's|ZenUtils.wiki/||' | sort
   ```

2. **Compare against the tables above.** New pages will show up in the output. Add them to the correct category table (or create a new category if a new folder appears).

3. **Get the latest wiki commit date** to update the snapshot header:
   ```bash
   cd /tmp && git clone --depth 1 --bare https://github.com/friendlyhj/ZenUtils.wiki.git && git -C ZenUtils.wiki log -1 --format=%ci
   ```
   Convert the printed date to `YYYY-MM-DD` and replace the **Wiki snapshot** value at the top of this file.

4. **Page-to-folder mapping rules:**
   - Wiki URLs like `/wiki/PageName` map to raw files at `https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/<Folder>/PageName.md`
   - Most pages sit in a subfolder (`ZenExpansion/`, `Events/`, `Classes/`, `CustomCommand/`, `ContentTweakerExpansion/`, `FTBQuests/`, `Others/`)
   - If unsure of the folder, run the `find` command from step 1 and search for the `.md` filename
   - The root `Home.md` is the wiki landing page and does not need to be indexed here
