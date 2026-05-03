## ⚡ Performance Improvements

  * <img src="https://i.imgur.com/ms29ZmG.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/b69904a)⚡Disable RLTweaker carryon features
    > For some reason, "Quark Chest Fix" or "Tile Entity Drop Safety Check" took about 3% TPS. Disabling this feature should increase performance.

## ✨ New Features

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/9d7074a)🤡Add `clown` rank for clowns
    > Later, this rank will be automatically assigned to players who dupe Mythic loot chests and boast, "Look how fast I'm progressing in this modpack."

## 🐛 Fixes

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/5e881d8)✏️Fix AR multiblock recipes missed
    > - Return batch-crafting ![](https://github.com/Krutoy242/mc-icons/raw/master/i/forestry/fabricator__0.png "Thermionic Fabricator") and ![](https://github.com/Krutoy242/mc-icons/raw/master/i/forestry/carpenter__0.png "Carpenter")  
    > - Return some alloys in ![](https://github.com/Krutoy242/mc-icons/raw/master/i/advancedrocketry/arcfurnace__0.png "Electric Arc Furnace")
    > 
    > Accidentally remowed here 245392e681b2a31591f3d7324f3a25856752625c
    > 
    > Fix https://github.com/Krutoy242/Enigmatica2Expert-Extended/issues/610  
    > Fix https://github.com/Krutoy242/Enigmatica2Expert-Extended/issues/609
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/a8f0fb8)✏️Remove two 'no-ingredient' recipes from ![](https://github.com/Krutoy242/mc-icons/raw/master/i/enderio/block_alloy_smelter__0.png "Alloy Smelter")
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/fe75a82)🏛️`Building Gadgets` increase *Max Build Distance* to 48
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/9bd2863)💰Tweak some dungeon loot
    > - ![](https://github.com/Krutoy242/mc-icons/raw/master/i/botania/teruterubozu__0.png "Teru Teru Bozu") less frequent since cant be recycled
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/d40f5fa)🔨Fix Troll's veapons kicking from server on hit sheeps
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/e33f246)🧩`Exnetadditions` disable mana and essention transfer
    > Botania and Thaumcraft already have lot of options to transfer their resources.

  #### Info

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/a09dd8e)📝Prune useless tips

  #### JEI

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/c4b4f84)🌍Remove ![](https://github.com/Krutoy242/mc-icons/raw/master/i/biomesoplenty/gem_ore__5.png "Malachite Ore") from `KELT-6a` JER tab
    > Since Malachite doesnt spawn here

  #### Server

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/df48556)💻Equalize min and max RAM for servers

## Mods changes
### 🟢 Added Mods

Icon | Summary | Reason
----:|:--------|:-------
<img src="https://media.forgecdn.net/avatars/thumbnails/845/501/30/30/638243430763826986.png"            > |        [**The One Probe Community Edition**](https://www.curseforge.com/minecraft/mc-mods/the-one-probe-community-edition)<sup><sub>TheOneProbe-CE-1.12-1.3.7-fix1.jar               </sub></sup><br>Displays the entity or block you are viewing | Lets try this version of TOP to test if its better than TheOneSmeagle.
<img src="https://media.forgecdn.net/avatars/thumbnails/1097/871/30/30/638644057459524955.png"           > |                       [**TopAllDependents**](https://www.curseforge.com/minecraft/mc-mods/topalldependents)             <sup><sub>TopAllDependents-1.4.jar                         </sub></sup><br>Adds mod support to The One Probe by McJty | TOP dependency
<img src="https://media.forgecdn.net/avatars/thumbnails/1418/269/30/30/638918884845889202.png"           > |                                   [**ZNet**](https://www.curseforge.com/minecraft/mc-mods/znet)                         <sup><sub>XNet-1.8.18.jar                                  </sub></sup><br>Fork of XNet 1.12.2 that aims to fix and improve it | Fork with bugfixes
<img src="https://media.forgecdn.net/avatars/thumbnails/1743/241/30/30/639109201838070228.png"           > |                        [**XNet: Additions**](https://www.curseforge.com/minecraft/mc-mods/xnet-additions)               <sup><sub>XNetAdditions-0.1.4.jar                          </sub></sup><br>An XNet addon focused on adding support for new channel types and resource systems. | Add mek gas compat
-----------


### 🔴 Removed Mods

Icon | Summary | Reason
----:|:--------|:-------
<img src="https://media.forgecdn.net/avatars/thumbnails/951/894/30/30/638441639917328756.png"            > |                          [**TheOneSmeagle**](https://www.curseforge.com/minecraft/mc-mods/theonesmeagle)                <sup><sub>TheOneSmeagle-1.12-1.1.5.jar                     </sub></sup><br>A fork of The One Probe, meant to be a more immersive version of WAILA/HWYLA | Replaced by TOP-CE
<img src="https://media.forgecdn.net/avatars/thumbnails/44/562/30/30/636033342690526889.jpeg"            > |                             [**TOP Addons**](https://www.curseforge.com/minecraft/mc-mods/top-addons)                   <sup><sub>topaddons-1.12.2-1.13.0.jar                      </sub></sup><br>Adds mod support to The One Probe by McJty | Replaced by TopAllDependents
<img src="https://media.forgecdn.net/avatars/thumbnails/428/742/30/30/637662550518620713.png"            > |                      [**Thaumic One Probe**](https://www.curseforge.com/minecraft/mc-mods/thaumic-one-probe)            <sup><sub>thaumic-one-probe-1.12.2-1.0.0.jar               </sub></sup><br>adds TOP displays for various thaumcraft apparatus | Replaced by TopAllDependents
<img src="https://media.forgecdn.net/avatars/thumbnails/89/38/30/30/636229039734109684.png"              > |                                   [**XNet**](https://www.curseforge.com/minecraft/mc-mods/xnet)                         <sup><sub>xnet-1.12-1.8.2.jar                              </sub></sup><br>XNet is a highly optimized networking cable system for items, energy, fluids, information, ... | Replaced by ZNet
-----------

### 🟡 Updated Mods

Icon | Summary | Old / New
----:|:--------|:---------
<img src="https://media.forgecdn.net/avatars/thumbnails/248/435/30/30/637168261428598002.png"            > |                                    [**QMD**](https://www.curseforge.com/minecraft/mc-mods/qmd)                         | <nobr>QMD-1.5 beta 3-1.12.2</nobr><br><nobr>QMD-1.5-1.12.2</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/468/506/30/30/637752171904887013.jpeg"           > |                       [**Had Enough Items**](https://www.curseforge.com/minecraft/mc-mods/had-enough-items)            | <nobr>HadEnoughItems_1.12.2-4.30.3</nobr><br><nobr>HadEnoughItems_1.12.2-4.31.1</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/551/59/30/30/637888242565991470.png"             > |                              [**ModularUI**](https://www.curseforge.com/minecraft/mc-mods/modularui)                   | <nobr>modularui-3.1.6</nobr><br><nobr>modularui-3.1.5</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1197/189/30/30/638773173284175448.png"           > |                     [**Roughly Enough IDs**](https://www.curseforge.com/minecraft/mc-mods/reid)                        | <nobr>RoughlyEnoughIDs-2.3.0</nobr><br><nobr>RoughlyEnoughIDs-2.3.1</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/894/711/30/30/638338657652175030.png"            > |                                   [**Zume**](https://www.curseforge.com/minecraft/mc-mods/zume)                        | <nobr>zume-1.2.1</nobr><br><nobr>zume-1.2.2</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/908/439/30/30/638360340448042423.png"            > |                [**Just Enough Magiculture**](https://www.curseforge.com/minecraft/mc-mods/just-enough-magiculture)     | <nobr>justenoughmagiculture-1.12.2-1.2.1</nobr><br><nobr>justenoughmagiculture-1.12.2-1.2.2</nobr>
<img src="null"                                                                                          > |                                  [**ARLib**](https://www.curseforge.com/minecraft/mc-mods/arlib)                       | <nobr>libvulpes-0.5.1</nobr><br><nobr>libvulpes-0.5.2</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1040/744/30/30/638566774921391570.png"           > |               [**Magiculture Integrations**](https://www.curseforge.com/minecraft/mc-mods/magiculture-integrations)    | <nobr>magicultureintegrations-1.12.2-2.2.7</nobr><br><nobr>magicultureintegrations-1.12.2-2.3.0</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1045/277/30/30/638572993870832594.png"           > |                         [**Thaumcraft Fix**](https://www.curseforge.com/minecraft/mc-mods/thaumcraftfix)               | <nobr>ThaumcraftFix-1.12.2-1.1.9</nobr><br><nobr>ThaumcraftFix-1.12.2-1.1.10</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1176/204/30/30/638748608591942674.png"           > |                       [**RandomComplement**](https://www.curseforge.com/minecraft/mc-mods/random-complement)           | <nobr>random_complement-1.9.1</nobr><br><nobr>random_complement-1.9.3</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1223/434/30/30/638801642158504721.png"           > |                       [**Tinkers' Antique**](https://www.curseforge.com/minecraft/mc-mods/tinkers-antique)             | <nobr>TinkersAntique-1.12.2-2.13.0.205</nobr><br><nobr>TinkersAntique-1.12.2-2.13.0.206</nobr>
-----------
