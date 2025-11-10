> ### ⚠️Warning:  
> This version includes the “Key Binding Patch” mod, which breaks almost all key bindings.  
> Do not update, or be prepared to reconfigure half of the buttons. 🤷‍♂️

## ✨ New Features


  #### Quest

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/dee813d)📖Trade Loot Chests to pick reward

## 🐛 Fixes

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/13d9922)♻️Use UniversalTweaks to handle RandomThings spectre tp bug
    > related: 162edc0f2e282b450c50ed5a16d20c4e51156ddc  
    > https://github.com/ACGaming/UniversalTweaks/pull/722
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/b5d4a08)✏️![](https://github.com/Krutoy242/mc-icons/raw/master/i/minecraft/emerald__0.png "Emerald") fix dupe in ![](https://github.com/Krutoy242/mc-icons/raw/master/i/enderio/block_sag_mill__0.png "SAG Mill")
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/645bcf2)✏️[Gelid Enderium] require way less Hot cryotheum
    > Also ![](https://github.com/Krutoy242/mc-icons/raw/master/i/redstonerepository/material__5.png "Gelid Crystal") now require ![](https://github.com/Krutoy242/mc-icons/raw/master/i/actuallyadditions/item_crystal_empowered__4.png "Empowered Emeradic Crystal") instead of emerald
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/623df0d)✏️Migrate from `rockytweaks` to `roidtweaker`
    > Shoudl have no ingame changes
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/17b12f2)🌌Fix player fall into TP loop when jumping from void with a book
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/5442fc6)🎒Add new items to BackpackOpener
    > > Contributed by [Crestfall17](https://github.com/crestfall17)
    >
    > ![](https://github.com/Krutoy242/mc-icons/raw/master/i/thermalexpansion/satchel__0.png "Satchel (Basic)")![](https://github.com/Krutoy242/mc-icons/raw/master/i/thaumcraft/focus_pouch__0.png "Focus Pouch")![](https://github.com/Krutoy242/mc-icons/raw/master/i/thaumadditions/crystal_bag__0.png "Crystal Bag")
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/97da484)🐦Fix SmelteryIO blocks harvest level and hardness
    > > Contributed by [Crestfall17](https://github.com/crestfall17)
    >
    > - Fixed harvestLevel of all blocks in Smeltery IO from 2 -> -1  
    > - Increased block resistance for consistency with base mod from 15 -> 20
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/535a46a)🐦Migrate JER `Bansoukou` => `ZS mixins`
    > > Contributed by [ZZZank](https://github.com/zzzank)
    >
    > Move JustEnoughResources patch (worldgen tab sorting) to ZS mixins instead of Bansoukou.  
    > Should have no ingame changes.
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/c126a16)🐦Migrate OTG DimensionData patch `Bansoukou` => `ZS mixins`
    > > Contributed by [ZZZank](https://github.com/zzzank)
    >
    > It should not have any effect on gameplay.
    > 
    > P.S. To be honest, we don't remember why this patch was needed 🤷‍♂️
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/27509f1)🐦Migrate ThermalDynamics JEI `Bansoukou` => `ZS mixins`
    > > Contributed by [ZZZank](https://github.com/zzzank)
    >
    > should have no ingame changes
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/9223f5f)💙![](https://github.com/Krutoy242/mc-icons/raw/master/i/enderstorage/ender_pouch__0__563bae3a.png "Ender Pouch") remove 'gui' trigger
    > Now only Chest and ![](https://github.com/Krutoy242/mc-icons/raw/master/i/enderstorage/ender_storage__1.png "Ender Tank") will increase difficulty, and not the pouch.
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/a9bfe38)📃Hide Rustic's alcohol added by `CongregaMystica`
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/5597e17)📖Add quest and more info about inworld smelting
    > fix https://github.com/Krutoy242/Enigmatica2Expert-Extended/issues/553  
    > Related a8b2540421626ea870d0123440076c4177da36d3
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/780a09b)🧩Enable underwater fog
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/6615476)🪄Disable item interaction with ![](https://github.com/Krutoy242/mc-icons/raw/master/i/thaumcraft/crucible__0.png "Crucible")
    > No more "I accidentally melted my backpack"
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/30fb53b)🛢️Disable ImmTech pipes to fix visual bug of pipe connection

  #### Configs

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/bf5da63)🧩Enable `Armor Swap` in `Universal Tweaks` configs
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/877815f)🧩Enable `Fast World Loading` in `Universal Tweaks` configs

  #### Perf_command

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/dd5831f)✈️Fix error on `/perf chunks`

  #### Quest

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/640b0c7)📖`Appliy` typo

  #### Recipes

  * <img src="https://i.imgur.com/pt0SFwD.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/99c5096)✏️Extended Chisel support for Sonar Core blocks
    > > Contributed by [Crestfall17](https://github.com/crestfall17)
    >
    > - Reinforced Stone, Reinforced Stone Brick, Stable Stone (Rimmed, Black Rimmed), Stable Stone Plain (Rimmed, Black Rimmed) merged into one group  
    > - Reinforced Dirt, Reinforced Dirt Brick  
    > - Stable Glass, Clear Stable Glass added to generic 'glass' group, since their crafting recipe is just a conversion from generic glass

## Mods changes
### 🟢 Added Mods

Icon | Summary | Reason
----:|:--------|:-------
<img src="https://media.forgecdn.net/avatars/thumbnails/896/184/30/30/638341178690607437.png"            > |                      [**Key Binding Patch**](https://www.curseforge.com/minecraft/mc-mods/key-binding-patch)            <sup><sub>[MC-1.12.2] Key Binding Patch v1.3.3.3 - 2024-12-1.jar</sub></sup><br>Patch and enhance vanilla key binding system. | Promising to bind same button for many actions at once
<img src="https://media.forgecdn.net/avatars/thumbnails/1045/277/30/30/638572993870832594.png"           > |                         [**Thaumcraft Fix**](https://www.curseforge.com/minecraft/mc-mods/thaumcraftfix)                <sup><sub>ThaumcraftFix-1.12.2-1.1.8.jar                   </sub></sup><br>Many a fix for Thaumcraft 6 | 👍
<img src="https://media.forgecdn.net/avatars/thumbnails/1393/258/30/30/638903329452120885.png"           > |                             [**Gadothaumy**](https://www.curseforge.com/minecraft/mc-mods/gadothaumy)                   <sup><sub>Infusion Claw Mod-1.0.0.jar                      </sub></sup><br>A mod allows you start thaumcraft infusion automatically | Should replace previously removed feature of Golems that could activate Infusion no more
-----------


### 🔴 Removed Mods

Icon | Summary | Reason
----:|:--------|:-------
<img src="https://media.forgecdn.net/avatars/thumbnails/95/818/30/30/636279857174885928.png"             > |                           [**Rocky Tweaks**](https://www.curseforge.com/minecraft/mc-mods/rocky-tweaks)                 <sup><sub>rockytweaks-1.12.2-0.6.1.jar                     </sub></sup><br>Features for mod pack creators: Anvil Tweaker &amp; Merchant Tweaker. | Replaced by `roidtweaker`
-----------

### 🟡 Updated Mods

Icon | Summary | Old / New
----:|:--------|:---------
<img src="https://media.forgecdn.net/avatars/thumbnails/159/374/30/30/636658415780463602.png"            > |                          [**CraftPresence**](https://www.curseforge.com/minecraft/mc-mods/craftpresence)               | <nobr>CraftPresence-2.6.2+1.12.2-forge</nobr><br><nobr>CraftPresence-2.7.0+1.12.2-forge</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/292/428/30/30/637325593905195388.png"            > |                              [**Zen Utils**](https://www.curseforge.com/minecraft/mc-mods/zenutil)                     | <nobr>zenutils-1.25.11</nobr><br><nobr>zenutils-1.26.2</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/468/506/30/30/637752171904887013.jpeg"           > |                       [**Had Enough Items**](https://www.curseforge.com/minecraft/mc-mods/had-enough-items)            | <nobr>HadEnoughItems_1.12.2-4.29.8</nobr><br><nobr>HadEnoughItems_1.12.2-4.29.9</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/551/59/30/30/637888242565991470.png"             > |                              [**ModularUI**](https://www.curseforge.com/minecraft/mc-mods/modularui)                   | <nobr>modularui-2.5.0-rc6</nobr><br><nobr>modularui-3.0.4</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/557/657/30/30/637904734114975779.png"            > |                  [**Inventory Bogo Sorter**](https://www.curseforge.com/minecraft/mc-mods/inventory-bogosorter)        | <nobr>bogosorter-1.4.11</nobr><br><nobr>bogosorter-1.5.0</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/641/454/30/30/638043757664856777.png"            > |                       [**Universal Tweaks**](https://www.curseforge.com/minecraft/mc-mods/universal-tweaks)            | <nobr>UniversalTweaks-1.12.2-1.16.0.1</nobr><br><nobr>UniversalTweaks-1.12.2-1.17.0</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/937/632/30/30/638416090890641368.png"            > |            [**Thaumic Tinkerer Unofficial**](https://www.curseforge.com/minecraft/mc-mods/thaumic-tinkerer-unofficial) | <nobr>thaumictinkerer-1.12.2-5.9.14-Unofficial</nobr><br><nobr>thaumictinkerer-1.12.2-5.9.15-Unofficial</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1047/367/30/30/638575733030598020.png"           > |                                 [**UniLib**](https://www.curseforge.com/minecraft/mc-mods/unilib)                      | <nobr>UniLib-1.1.1+1.12.2-forge</nobr><br><nobr>UniLib-1.2.0+1.12.2-forge</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1482/227/30/30/638963404721998907.png"           > |                        [**Crash Assistant**](https://www.curseforge.com/minecraft/mc-mods/crash-assistant)             | <nobr>!!!CrashAssistant-forge-1.12.2-1.10.11</nobr><br><nobr>!!!CrashAssistant-forge-1.12.2-1.10.19</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1358/482/30/30/638882387444615595.png"           > |             [**Thaumic Wonders Unofficial**](https://www.curseforge.com/minecraft/mc-mods/thaumic-wonders-unofficial)  | <nobr>thaumicwonders-2.1.4</nobr><br><nobr>thaumicwonders-2.2.0</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1409/140/30/30/638913115744696491.png"           > |                           [**Armored Arms**](https://www.curseforge.com/minecraft/mc-mods/armored-arms)                | <nobr>ArmoredArms-v1.3.2-release</nobr><br><nobr>ArmoredArms-v1.3.4-release</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1430/826/30/30/638927049348150845.png"           > |                       [**Congrega Mystica**](https://www.curseforge.com/minecraft/mc-mods/congrega-mystica)            | <nobr>CongregaMystica-1.12.2-1.0.5</nobr><br><nobr>CongregaMystica-1.12.2-1.0.6</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1430/837/30/30/638927053511180100.png"           > |                         [**ThaumicTweaker**](https://www.curseforge.com/minecraft/mc-mods/thaumictweaker)              | <nobr>thaumictweaker-1.1.1</nobr><br><nobr>thaumictweaker-1.2.1</nobr>
-----------
