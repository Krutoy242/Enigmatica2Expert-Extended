## ✨ New Features

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/a6b8883)⛏️![](https://github.com/Krutoy242/mc-icons/raw/master/i/minecraft/emerald__0.png "Emerald") modifier now doubles durability
    > Was +50%. This change required, since we already have ![](https://github.com/Krutoy242/mc-icons/raw/master/i/tconstruct/materials__14.png "Reinforcement") which doubles durability and emerald looked weak in compare.
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/90d1492)⛏️![](https://github.com/Krutoy242/mc-icons/raw/master/i/conarm/gauntlet_mat_attack__0.png "Gauntlet of Power") add +50% damage (was +15%)
    > I've never seen anyone happy about this modifier. Now, the damage will be one and a half times greater, allowing you to stack it with other bonuses to get insane damage.
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/71555cb)✏️![](https://github.com/Krutoy242/mc-icons/raw/master/i/contenttweaker/conglomerate_of_life__0__a671482.png "Conglomerate Of Life") now also helps with generating feathers and eggs from birds
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/1040a54)✏️Add "Supreme Leader" mob build recipe
    > fix https://github.com/Krutoy242/Enigmatica2Expert-Extended/issues/501
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/b7e4353)💬Respect `/nick` names for server messages
    > Now this messages will use nicknames instead of registration player names on the servers:  
    > - Omnipotence  
    > - /restart_server  
    > - hand over your items  
    > - opening Mythic crate  
    > - chapter beginning / finishing
  * <img src="https://i.imgur.com/fypUGZA.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/2905b2c)🧻Add ![](https://github.com/Krutoy242/mc-icons/raw/master/i/contenttweaker/conglomerate_of_life__0__a671482.png "Conglomerate Of Life") JEI entry

  #### Balance

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/3a10b1c)✏️Add ![](https://github.com/Krutoy242/mc-icons/raw/master/i/cyclicmagic/apple__0.png "Apple Sprout")![](https://github.com/Krutoy242/mc-icons/raw/master/i/thermalfoundation/fertilizer__0.png "Phyto-Gro") to Farmer buying lists

## 🐛 Fixes

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/22aeeac)⛏️![](https://github.com/Krutoy242/mc-icons/raw/master/i/iceandfire/fire_dragon_blood__0.png "Fire Dragon Blood") make x10 times more damage
    > Now +20 per level
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/cde3c66)⛏️Fix ![](https://github.com/Krutoy242/mc-icons/raw/master/i/avaritia/singularity__1.png "Woodweave Singularity") cannot be used for tool parts
    > Comes out, that default ContentTweaker's material make methods doesnt allow NBT matching. In this case we could use trick to add woodweave_singularity into Tweakersconstruct mod as a duplicate for accepting "any NBT".
    > 
    > fix https://github.com/Krutoy242/Enigmatica2Expert-Extended/issues/557
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/f7a416b)⛏️Remove `Magically Brittle` from ![](https://github.com/Krutoy242/mc-icons/raw/master/i/forestry/apatite__0.png "Apatite")
    > `Magically Brittle` prevented to use Apatite tools for automation with robots.
    > 
    > Be careful - extra/handle parts still have Brittle trait
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/134643c)✂️Remove all modded shears
    > I've noticed that many newbies, when they need to harvest grass or vines, see in JEI that scissors cannot be crafted, and mistakenly think that the modpack developer is forcing them to craft obsidian or other scissors from mods. I hope that if I remove all scissors except for vanilla ones, players will realize that something is wrong here and that they still need to use Kama from Tinkercast Construct.
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/45dbd68)✏️Add ![](https://github.com/Krutoy242/mc-icons/raw/master/i/iceandfire/hydra_fang__0.png "Hydra Fang") recipe for "Vegan" challenge (no killing at all)
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/1a192c9)✏️Speed up ![](https://github.com/Krutoy242/mc-icons/raw/master/i/tconstruct/casting__0.png "Casting Table") cooldown time x10
    > Some metals have high melting temperature, which causing them to cooldown forever.  
    > Now time will affect cooldown x10 times less.
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/5778732)🌌Skyblock: fix RFTools dimensions actually being accessable
    > > Contributed by [eri-k](https://github.com/eri-k)
    >
    > now skyblock players will be able to visit RFTools dimensions.
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/58dce51)🍼Buff Actually Additions rings
    > Now effect x10 times longer
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/8e61100)🐝![](https://github.com/Krutoy242/mc-icons/raw/master/i/forestry/builder_bag__0.png "Building Backpack") add EngineersDecor blocks
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/cc57243)💡Remove Lumenized textures from modpack
    > > Contributed by [AnasDevO](https://github.com/anasdevo)
    >
    > Now textures and other configuration files would be handled by resource pack instead.
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/0967d45)🔨![](https://github.com/Krutoy242/mc-icons/raw/master/i/scalinghealth/heartdust__0__6e25ca5b.png "Heart Dust") not required anymore for Conarm Speed Modifier
    > Instead, it required 200 [Redstone Dust] for each level of Speedy

  #### Balance

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/f37b18c)✏️![](https://github.com/Krutoy242/mc-icons/raw/master/i/opencomputers/disassembler__0.png "Disassembler") remove 5% break chance
    > No more losing robot components on disassembling
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/87f4422)✏️![](https://github.com/Krutoy242/mc-icons/raw/master/i/randomthings/ingredient__2.png "Ectoplasm") drop from ![](https://github.com/Krutoy242/mc-icons/raw/master/i/randomthings/spectreleaf__0.png "Spectre Leaves") buff to 50%
    > Was 2%
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/7db5f52)✏️![](https://github.com/Krutoy242/mc-icons/raw/master/i/flopper/flopper__0.png "Flopper") now craftable from polished substones
    > ![](https://github.com/Krutoy242/mc-icons/raw/master/i/minecraft/stone__2.png "Polished Granite")![](https://github.com/Krutoy242/mc-icons/raw/master/i/minecraft/stone__4.png "Polished Diorite")![](https://github.com/Krutoy242/mc-icons/raw/master/i/minecraft/stone__6.png "Polished Andesite")
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/93aebbb)✏️![](https://github.com/Krutoy242/mc-icons/raw/master/i/randomthings/inventoryrerouter__0.png "Inventory Rerouter") cheaper since its basically a pipe
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/a934d28)✏️![](https://github.com/Krutoy242/mc-icons/raw/master/i/randomthings/stableenderpearl__0.png "Stable Ender Pearl") cheaper
    > 16 => 32 per craft
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/1322e5a)✏️[Villager Contract] cheaper, ![](https://github.com/Krutoy242/mc-icons/raw/master/i/tconstruct/materials__19__dff4a3d9.png "Mending Moss") instead of [Soul Stone]
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/52f3927)✏️Add ![](https://github.com/Krutoy242/mc-icons/raw/master/i/immersiveengineering/seed__0.png "Industrial Hemp Seeds") to ![](https://github.com/Krutoy242/mc-icons/raw/master/i/farmingforblockheads/market__0.png "Market")
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/6cbe727)✏️Buff ExtraUtils generators
    > - ![](https://github.com/Krutoy242/mc-icons/raw/master/i/extrautils2/machine__0__1615b97.png "Netherstar Generator") x4 rf/t output  
    > - [Ender Generator] rework inputs and rf/t
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/c34fa7e)✏️Cheaper ![](https://github.com/Krutoy242/mc-icons/raw/master/i/cyclicmagic/battery__0.png "Battery")
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/d83b419)✏️Cheaper ![](https://github.com/Krutoy242/mc-icons/raw/master/i/conarm/resist_mat_proj__0.png "Projectile Resistance")![](https://github.com/Krutoy242/mc-icons/raw/master/i/conarm/resist_mat_blast__0.png "Blast Resistance")![](https://github.com/Krutoy242/mc-icons/raw/master/i/conarm/resist_mat_fire__0.png "Fire Resistance")
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/daf0837)✏️Cheaper ![](https://github.com/Krutoy242/mc-icons/raw/master/i/randomthings/ingredient__3.png "Spectre Ingot")
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/0e011bb)✏️Rebalance ![](https://github.com/Krutoy242/mc-icons/raw/master/i/contenttweaker/empowered_phosphor__0.png "Empowered Phosphor") line
    > - Buff output of ![](https://github.com/Krutoy242/mc-icons/raw/master/i/randomthings/ingredient__13.png "Blackout Powder")  
    > - Cheaper ![](https://github.com/Krutoy242/mc-icons/raw/master/i/forestry/bituminous_peat__0.png "Bituminous Peat")  
    > - More burn time for ![](https://github.com/Krutoy242/mc-icons/raw/master/i/contenttweaker/conglomerate_of_coal__0.png "Conglomerate Of Coal")![](https://github.com/Krutoy242/mc-icons/raw/master/i/contenttweaker/blasted_coal__0.png "Blasted Coal")![](https://github.com/Krutoy242/mc-icons/raw/master/i/contenttweaker/empowered_phosphor__0.png "Empowered Phosphor")![](https://github.com/Krutoy242/mc-icons/raw/master/i/contenttweaker/saturated_phosphor__0.png "Saturated Phosphor")

  #### Configs

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/a54ab26)💻![](https://github.com/Krutoy242/mc-icons/raw/master/i/opencomputers/disassembler__0.png "Disassembler") remove chance of destroying items
    > Disassembler mostly used for reconfigure Robots. It should not restroy valuable parts doing it.

  #### Quest

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/031ac7e)📖Add ![](https://github.com/Krutoy242/mc-icons/raw/master/i/randomthings/stableenderpearl__0.png "Stable Ender Pearl") to quest rewards
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/69c1cd9)📖Add sub-chests like "Decor" or "Generators" to trade option
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/57f24d6)📖Better server chapter notifications
    > - Now both "Begin"/"Finished" chapter messages will have emojis  
    > - Now If you play in team, instead of duplicate "Begin"/"Finished" message for each player, only 1 message will be shown for whole team  
    > - Now when playing in team, total play time will be shown. This will endorse players who progressing without team thus having less time for completion
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/1243391)📖Buff Tier1 lootboxes
    > **Common**  
    >  - No more produce Food and Decor boxes  
    >  - Some Common rewards was replaced with Food and Decor boxes instead
    > 
    > **Decor**  
    >  - Now have a lot more infinite building blocks  
    >  - Less junky options like vanilla Banners
    > 
    > **Other**  
    >  - Removed junky options  
    >  - Move some items from higher tier  
    >  - Increase amounts of other items
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/15b9afc)📖Fix `Elevator` task any color
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/e35f899)📖Fix `Little Chisel` reward wrong table
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/ee83b24)📖Fix hetkey typo at Schematica quest
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/972ddcb)📖Ignore NBT in Thaumcraft jars quests
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/2938e92)📖Replace custom lootbox rewards with actual item rewards
    > Should have no changes, just removed "✪" symbol from lootbox reward tooltip

  #### Recipes

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/3751998)✏️Remove duplicate ![](https://github.com/Krutoy242/mc-icons/raw/master/i/nuclearcraft/alloy__2.png "Hard Carbon Alloy Ingot")

## Mods changes
### 🟢 Added Mods

Icon | Summary | Reason
----:|:--------|:-------
<img src="https://media.forgecdn.net/avatars/thumbnails/1540/189/30/30/639000001051070063.png"           > |                         [**Antique Armory**](https://www.curseforge.com/minecraft/mc-mods/antique-armory)               <sup><sub>AntiqueArmory-1.12.2-1.2.6.jar                   </sub></sup><br>Continued maintenance of Construct&#x27;s Armory for 1.12.2 🛡️ Enter the world of armor | Maintained fork
<img src="https://media.forgecdn.net/avatars/thumbnails/1542/324/30/30/639001128201473190.png"           > |                              [**BloomTech**](https://www.curseforge.com/minecraft/texture-packs/bloomtech)              <sup><sub>BloomTech-1.0.0.zip                              </sub></sup><br>A ressource pack to go with Lumenized! | More bloom textures
-----------


### 🔴 Removed Mods

Icon | Summary | Reason
----:|:--------|:-------
<img src="https://media.forgecdn.net/avatars/thumbnails/15/499/30/30/635627200908557487.png"             > |                            [**OpenModsLib**](https://www.curseforge.com/minecraft/mc-mods/openmodslib)                  <sup><sub>OpenModsLib-1.12.2-0.12.2.jar                    </sub></sup><br>Common base used by OpenBlocks and OpenPeripheral | Not required anymore
<img src="https://media.forgecdn.net/avatars/thumbnails/26/313/30/30/635789463860983758.png"             > |                         [**Chunk Animator**](https://www.curseforge.com/minecraft/mc-mods/chunk-animator)               <sup><sub>ChunkAnimator-1.12.2-1.2.1.jar                   </sub></sup><br>A small client side mod that animates the appearance of chunks so that they don&#x27;t just appear instantly. | Causing about `1%` FPS strain. Its not much, but i believe such mod should only took `0%`
<img src="https://media.forgecdn.net/avatars/thumbnails/153/560/30/30/636619290357325647.png"            > |                     [**Construct's Armory**](https://www.curseforge.com/minecraft/mc-mods/constructs-armory)            <sup><sub>conarm-1.12.2-1.2.5.10.jar                       </sub></sup><br>A Tinkers&#x27; Construct add-on for those looking to enter the world of armor | Replaced by fork
-----------

### 🟡 Updated Mods

Icon | Summary | Old / New
----:|:--------|:---------
<img src="https://media.forgecdn.net/avatars/thumbnails/358/827/30/30/637520208754289091.png"            > |                            [**CensoredASM**](https://www.curseforge.com/minecraft/mc-mods/lolasm)                      | <nobr>loliasm-5.29</nobr><br><nobr>loliasm-5.30</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/468/506/30/30/637752171904887013.jpeg"           > |                       [**Had Enough Items**](https://www.curseforge.com/minecraft/mc-mods/had-enough-items)            | <nobr>HadEnoughItems_1.12.2-4.29.11</nobr><br><nobr>HadEnoughItems_1.12.2-4.29.12</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1304/81/30/30/638847932766552243.png"            > |                                  [**Fugue**](https://www.curseforge.com/minecraft/mc-mods/fugue)                       | <nobr>+Fugue-0.21.0</nobr><br><nobr>+Fugue-0.22.2</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1045/277/30/30/638572993870832594.png"           > |                         [**Thaumcraft Fix**](https://www.curseforge.com/minecraft/mc-mods/thaumcraftfix)               | <nobr>ThaumcraftFix-1.12.2-1.1.8</nobr><br><nobr>ThaumcraftFix-1.12.2-1.1.9</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1062/375/30/30/638594947374082619.png"           > |                         [**JEI Area Fixer**](https://www.curseforge.com/minecraft/mc-mods/jei-area-fixer)              | <nobr>jei_area_fixer-2.2.1</nobr><br><nobr>jei_area_fixer-2.3.0</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1482/227/30/30/638963404721998907.png"           > |                        [**Crash Assistant**](https://www.curseforge.com/minecraft/mc-mods/crash-assistant)             | <nobr>!!!CrashAssistant-forge-1.12.2-1.10.22</nobr><br><nobr>!!!CrashAssistant-forge-1.12.2-1.10.23</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1358/482/30/30/638882387444615595.png"           > |             [**Thaumic Wonders Unofficial**](https://www.curseforge.com/minecraft/mc-mods/thaumic-wonders-unofficial)  | <nobr>thaumicwonders-2.2.1</nobr><br><nobr>thaumicwonders-2.2.2</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1432/698/30/30/638928288850650094.png"           > |                    [**OpenBlocks Reopened**](https://www.curseforge.com/minecraft/mc-mods/openblocks-reopened)         | <nobr>OpenBlocksReopened-1.12.2-1.8.2</nobr><br><nobr>OpenBlocksReopened-1.12.2-1.8.3</nobr>
-----------
