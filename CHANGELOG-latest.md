## ⚡ Performance Improvements

  * <img src="https://i.imgur.com/RRJHTaQ.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/037c281)⚡ Remove automatic IE armor recycling to speed up game load
    > Now, recycling recipes gonna be static and updated by modpack dev, rather than generate each game load.  
    > This saves several seconds of load time, since automatic script iterated every single recipe in game and every single ingredient of this recipe, which is slow operation.
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/7e765d6)⚡Fix ![](https://github.com/Krutoy242/mc-icons/raw/master/i/plethora/module__1.png "Frickin' laser beam") projectiles accumulated on chunk borders
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/5c93280)⚡Improve performance of ![](https://github.com/Krutoy242/mc-icons/raw/master/i/requious/replicator__0.png "Replicator")
    > About x2 less TPS usage in all modes.

## 🐛 Fixes

  * <img src="https://i.imgur.com/5QYZv06.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/4d43937)✏️![](https://github.com/Krutoy242/mc-icons/raw/master/i/twilightforest/uncrafting_table__0.png "Uncrafting Table") prevent exploiting tiers
    > Now, you cant uncraft an item to the recipe of this item with other NBT tags. This prevents uncrafting ![](https://github.com/Krutoy242/mc-icons/raw/master/i/mekanism/machineblock2__11__9a743a0a.png "Basic Fluid Tank") into ![](https://github.com/Krutoy242/mc-icons/raw/master/i/mekanism/machineblock2__11__9a743a67.png "Ultimate Fluid Tank") ingredients.
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/b114a5f)✏️Purge ![](https://github.com/Krutoy242/mc-icons/raw/master/i/enderio/item_liquid_conduit__0.png "Fluid Conduit")![](https://github.com/Krutoy242/mc-icons/raw/master/i/enderio/item_liquid_conduit__1.png "Pressurized Fluid Conduit")
    > since they cause FPS lag. Ender Conduits still available.
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/f468f5f)🌱IC2 crops fix insane output (and no output at all)
    > Fix https://github.com/Krutoy242/Enigmatica2Expert-Extended/issues/549
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/6377a7e)🗑️ Remove obsolete AR asteroid JEI tab
    > Since this is already implemented by AR.

  #### Quest

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/a0a11b4)📖 `Botania` chapter replace loot reward to custom instead of random
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/1d00cc7)📖Full `ru_ru` questbook translation
    > Thanks `t0ma999`

## Mods changes

⚠️ Since there are no mod-related changes in the `1.81.0-beta` changelog (despite the fact that the mods have been modified), this changelog includes a *Mod Changes* section that compiles changes from both versions.

### 🟢 Added Mods

Icon | Summary | Reason
----:|:--------|:-------
<img src="https://media.forgecdn.net/avatars/thumbnails/1193/283/30/30/638768621890000641.png"           > |                   [**Cleanroom Relauncher**](https://www.curseforge.com/minecraft/mc-mods/cleanroom-relauncher)         <sup><sub>!cleanroom-relauncher-0.5.0.jar                  </sub></sup><br>Relaunches Forge into Cleanroom! | Java 25 for everyone! Warning: Ru and Cn residents can have issues with downloading required libs.
<img src="https://media.forgecdn.net/avatars/thumbnails/1248/579/30/30/638815123194346443.png"           > |                         [**VisualClaiming**](https://www.curseforge.com/minecraft/mc-mods/visualclaiming)               <sup><sub>visualclaiming-0.1.2.jar                         </sub></sup><br>Addon to VisualOres that add FTB Utilities Claimed Chunk Viewer | Nice QOL for servers
<img src="https://media.forgecdn.net/avatars/thumbnails/1588/691/30/30/639027889140193342.png"           > |                               [**XaeroLib**](https://www.curseforge.com/minecraft/mc-mods/xaerolib)                     <sup><sub>xaerolib-forge-1.12.2-1.1.0.jar                  </sub></sup><br>Library containing shared code for Xaero&#x27;s Minimap and World Map | Lib for Xaero mods updates.
-----------

### 🟡 Updated Mods

Icon | Summary | Old / New
----:|:--------|:---------
<img src="https://media.forgecdn.net/avatars/thumbnails/92/854/30/30/636258666554688823.png"             > |                        [**Xaero's Minimap**](https://www.curseforge.com/minecraft/mc-mods/xaeros-minimap)              | <nobr>Xaeros_Minimap_25.2.10_Forge_1.12</nobr><br><nobr>xaerominimap-forge-1.12.2-25.3.13</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/196/654/30/30/636886857118683130.png"            > |                      [**Xaero's World Map**](https://www.curseforge.com/minecraft/mc-mods/xaeros-world-map)            | <nobr>XaerosWorldMap_1.39.12_Forge_1.12</nobr><br><nobr>xaeroworldmap-forge-1.12.2-1.40.16</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/220/544/30/30/637020855283796863.jpeg"           > |               [**NuclearCraft: Overhauled**](https://www.curseforge.com/minecraft/mc-mods/nuclearcraft-overhauled)     | <nobr>nuclearcraft-1.12.2-2o.9.2</nobr><br><nobr>nuclearcraft-1.12.2-2o.9.3</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/248/435/30/30/637168261428598002.png"            > |                                    [**QMD**](https://www.curseforge.com/minecraft/mc-mods/qmd)                         | <nobr>QMD-1.5-1.12.2</nobr><br><nobr>QMD-1.5.1-1.12.2</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/273/618/30/30/637255642042590715.png"            > |                     [**Tinkers' Evolution**](https://www.curseforge.com/minecraft/mc-mods/tinkers-evolution)           | <nobr>tconevo-1.12.2-1.1.5</nobr><br><nobr>tconevo-1.12.2-1.1.6</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/468/506/30/30/637752171904887013.jpeg"           > |                       [**Had Enough Items**](https://www.curseforge.com/minecraft/mc-mods/had-enough-items)            | <nobr>HadEnoughItems_1.12.2-4.31.1</nobr><br><nobr>HadEnoughItems_1.12.2-4.31.2</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/551/59/30/30/637888242565991470.png"             > |                              [**ModularUI**](https://www.curseforge.com/minecraft/mc-mods/modularui)                   | <nobr>modularui-3.1.5</nobr><br><nobr>modularui-3.1.6</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/557/657/30/30/637904734114975779.png"            > |                  [**Inventory Bogo Sorter**](https://www.curseforge.com/minecraft/mc-mods/inventory-bogosorter)        | <nobr>bogosorter-1.6.2</nobr><br><nobr>bogosorter-1.6.3</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/856/836/30/30/638260772226865253.png"            > |                             [**VisualOres**](https://www.curseforge.com/minecraft/mc-mods/visualores)                  | <nobr>visualores-0.2.7</nobr><br><nobr>visualores-0.2.8</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1040/744/30/30/638566774921391570.png"           > |               [**Magiculture Integrations**](https://www.curseforge.com/minecraft/mc-mods/magiculture-integrations)    | <nobr>magicultureintegrations-1.12.2-2.3.0</nobr><br><nobr>magicultureintegrations-1.12.2-2.3.1</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1679/685/30/30/639067599608097833.png"           > |                                 [**Gnetum**](https://www.curseforge.com/minecraft/mc-mods/gnetum)                      | <nobr>gnetum-1.4.1</nobr><br><nobr>gnetum-1.4.3</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1223/434/30/30/638801642158504721.png"           > |                       [**Tinkers' Antique**](https://www.curseforge.com/minecraft/mc-mods/tinkers-antique)             | <nobr>TinkersAntique-1.12.2-2.13.0.206</nobr><br><nobr>TinkersAntique-1.12.2-2.13.0.207</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1418/269/30/30/638918884845889202.png"           > |                                   [**ZNet**](https://www.curseforge.com/minecraft/mc-mods/znet)                        | <nobr>XNet-1.8.19</nobr><br><nobr>XNet-1.8.20</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1430/826/30/30/638927049348150845.png"           > |                       [**Congrega Mystica**](https://www.curseforge.com/minecraft/mc-mods/congrega-mystica)            | <nobr>CongregaMystica-1.1.0</nobr><br><nobr>CongregaMystica-1.1.1</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1540/189/30/30/639000001051070063.png"           > |                         [**Antique Armory**](https://www.curseforge.com/minecraft/mc-mods/antique-armory)              | <nobr>AntiqueArmory-1.12.2-1.2.7</nobr><br><nobr>AntiqueArmory-1.12.2-1.2.8</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1743/241/30/30/639109201838070228.png"           > |                        [**XNet: Additions**](https://www.curseforge.com/minecraft/mc-mods/xnet-additions)              | <nobr>XNetAdditions-0.1.4</nobr><br><nobr>XNetAdditions-0.1.5</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1790/428/30/30/639134569119590165.png"           > |                             [**ThaumicAPI**](https://www.curseforge.com/minecraft/mc-mods/thaumicapi)                  | <nobr>thaumicapi-1.0.0</nobr><br><nobr>thaumicapi-1.0.1</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1793/908/30/30/639136459836649885.png"           > |               [**Tinker's Planner Antique**](https://www.curseforge.com/minecraft/mc-mods/tinkers-planner-antique)     | <nobr>TinkersPlannerAntique-1.12.2-1.0.2</nobr><br><nobr>TinkersPlannerAntique-1.12.2-1.0.3</nobr>
-----------
