# v1.53.0 (2024-12-29)

## ✨ New Features

* <img src="https://i.imgur.com/hAeoOLA.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/f26a60de76a9df8b2913a3b7219887dd6f39b087)![](https://github.com/Krutoy242/mc-icons/raw/master/i/actuallyadditions/item_drill__0.png "Drill") now can be enchanted with Excavation
  > 
* [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/c0e7391113cba4baf3d09475826df362da754cea)🌷![](https://github.com/Krutoy242/mc-icons/raw/master/i/botania/mushroom__14.png "Red Shimmering Mushroom")![](https://github.com/Krutoy242/mc-icons/raw/master/i/botania/mushroom__11.png "Blue Shimmering Mushroom")![](https://github.com/Krutoy242/mc-icons/raw/master/i/botania/mushroom__9.png "Cyan Shimmering Mushroom")![](https://github.com/Krutoy242/mc-icons/raw/master/i/botania/mushroom__7.png "Gray Shimmering Mushroom")![](https://github.com/Krutoy242/mc-icons/raw/master/i/botania/mushroom__5.png "Lime Shimmering Mushroom")![](https://github.com/Krutoy242/mc-icons/raw/master/i/botania/mushroom__6.png "Pink Shimmering Mushroom")![](https://github.com/Krutoy242/mc-icons/raw/master/i/botania/mushroom__15.png "Black Shimmering Mushroom")![](https://github.com/Krutoy242/mc-icons/raw/master/i/botania/mushroom__12.png "Brown Shimmering Mushroom")![](https://github.com/Krutoy242/mc-icons/raw/master/i/botania/mushroom__13.png "Green Shimmering Mushroom")![](https://github.com/Krutoy242/mc-icons/raw/master/i/botania/mushroom__0.png "White Shimmering Mushroom")![](https://github.com/Krutoy242/mc-icons/raw/master/i/botania/mushroom__1.png "Orange Shimmering Mushroom")![](https://github.com/Krutoy242/mc-icons/raw/master/i/botania/mushroom__10.png "Purple Shimmering Mushroom")![](https://github.com/Krutoy242/mc-icons/raw/master/i/botania/mushroom__4.png "Yellow Shimmering Mushroom")![](https://github.com/Krutoy242/mc-icons/raw/master/i/botania/mushroom__2.png "Magenta Shimmering Mushroom")![](https://github.com/Krutoy242/mc-icons/raw/master/i/botania/mushroom__3.png "Light Blue Shimmering Mushroom")![](https://github.com/Krutoy242/mc-icons/raw/master/i/botania/mushroom__8.png "Light Gray Shimmering Mushroom") now drop Petals
  > This will help with inventory cluttering when exploring
* <img src="https://i.imgur.com/0hWWK5Y.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/e088b304328a7885d21e54f19232734ea165bc9a)🧯Rework appearence and math for "Woodweave" Fireproof Singularity
  > - New item ID
  > - Removed "intermediate" ingredient
  > - Now Woodweave Singularity have another texture
  > - Now "power" or "charge" shown as durability instead of tooltip
  > - Removed clicking for info, now can see on tooltip
  > - Now can be used as a weapon (its a bug)
  > - Changed required charge from 1M to 30K
  > - Changed math of calculating charge
  > 
  > Crafting Principle is the same - its easier to craft if you using many different kids of Fireproof planks.
  > For example, you need only 4 planks each of the types if you craft from 25 kinds of planks.

#### Fishing_rework

* <img src="https://i.imgur.com/ICrJdRZ.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/17ba7bee5510b1b4dc8574d2b71ea80f6c3e86c6)🐟Add `Fish Singularity`
  > Fish Singularity is a singularity crafted from Empty Singularity and required for automatic fishing machines.
  > 
  > To craft you need around ~4 fishes all of 17 kinds of raw fish, or way more if you do not provide big variety of fish types.
* <img src="https://i.imgur.com/0Vvvk4r.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/1d40f53c0aaf979f5b0cf5118166ff67e258c295)🐟Lower all [fish] usages
  > Now, almost all recipes accept ![](https://github.com/Krutoy242/mc-icons/raw/master/i/harvestcraft/groundfishitem__0.png "Ground Fish"), which can be multiplied x4 from one fish.
  > 
  > Also, some recipes was tweaker to require less fishes.
* <img src="https://i.imgur.com/rVGxwR5.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/4d997c5f251fc8846e199fa230ea1091d8015537)🐟Make all auto-fishers require Singularity
  > Since usage of fish is low, there is barely no requirment to mass-fishing anything.
  > 
  > This will encourage using more complicated setups rather than 1-block solutions.
* <img src="https://i.imgur.com/okYjnKT.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/bf958e4c2719f2530c751bad5d8354408f5ec899)✏️Add ![](https://github.com/Krutoy242/mc-icons/raw/master/i/iceandfire/troll_weapon.hammer__0.png "Troll's Hammer") recipes
  > Now all Troll's weapons SMASHING entities and drop appropriate x4 Grinded Meat when match possible.
  > For example, killing [Sheep] will drop ![](https://github.com/Krutoy242/mc-icons/raw/master/i/harvestcraft/groundmuttonitem__0.png "Ground Mutton") instead of [Mutton], equal to x4 of original quantity.
* [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/e2073e4a97be2dcea8d2d692d328763d0471da01)✏️![](https://github.com/Krutoy242/mc-icons/raw/master/i/thaumcraft/chunk__3.png "Fish Nugget") add to `listAllfishcooked` for more recipe usages
  > Also add all other TH meat nuggets to `listAllmeatcooked` list.
* [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/ee18980fb97e722563b63ff76cba821ff9b17860)✏️![](https://github.com/Krutoy242/mc-icons/raw/master/i/iceandfire/fishing_spear__0.png "Fishing Spear") add alt recipe

## 🐛 Fixes

* [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/79c7a494afa42f78d720436384a4545709ee00f0)⛑️fix `Portal Spread` used to dupe ![](https://github.com/Krutoy242/mc-icons/raw/master/i/minecraft/gold_ore__0.png "Gold Ore")![](https://github.com/Krutoy242/mc-icons/raw/master/i/minecraft/iron_ore__0.png "Iron Ore")
  > 
* [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/d759cc05c122be43f67d591f03a4315b62d3f445)✏️fix potion of `growth` and `scattering` have same recipe
  > 
* [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/61540138a081af62eacdefe93a7e50d0038ecfc7)✏️fix rare error message related to NC melter
  > 
* [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/4cfdeb1e9533d6d26f6e799aae643a873d6084ae)🎒![](https://github.com/Krutoy242/mc-icons/raw/master/i/spiceoflife/lunchbox__0.png "Lunch Box")![](https://github.com/Krutoy242/mc-icons/raw/master/i/spiceoflife/lunchbag__0.png "Lunch Bag") remove from `BackpackOpener`
  > 
* [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/eb537169d7df2385bc66b5e00d4c0b7b4db86351)🔄Make smaller ![](https://github.com/Krutoy242/mc-icons/raw/master/i/thaumcraft/wand_workbench__0.png "Focal Manipulator") gui to fit HEI bookmarks
* [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/941022deff0971047736549c0f9c6a1ccd49786c)🦯Thaumcraft related fixes
  > > Contributed by [TabakaSIM](78695622+TabakaSIM@users.noreply.github.com)
  >
  > * Fixed aquamarine aspects
  > * Removed aspects from unused bronze items
  > * Updated quest info about infernal furnace
  > * Make sonus aspect replaceable if ThAd was removed
  > * Removed spider scan in golems research (for peaceful run)
  > * Added extra entry about mithminite
  >   > Now players should be less confused about researches that are about tinker's version of mithminite research
  > * Changed recipes of awakened ichorium armor
  >   > Now each type require 4 addtionals items:
  >   > - Botania quartz type
  >   > - Thaumcraft related bauble
  >   > - Item that is realated to armor, but can be aquired from trading with villagers
  >   > - One extra item
* [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/5ce0cc61d88633366ab703525b0ef8500a091a58)🛣️add BM `Ritual Stones` to excavate groups
  > Now easier to pick up multiblock rituals

#### Balance

* [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/2c37f4f7388d695ea7d25921dae63a7f61465d44)✏️buff `Eldritch Will` ritual will output x10
  > 

#### Info

* [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/c4c2387595911e54605950cf14e613e8dae3ae10)📝![](https://github.com/Krutoy242/mc-icons/raw/master/i/akashictome/tome__0.png "Akashic Tome") add `TOP`, `Gendustry` and `ThermalLogistic`
  > 
* [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/437c398c1811509ecb1052cd43a9bf504b0c5a9b)📝Add tip about Patchouli+HEI integration
  > 

#### Quest

* [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/42b132ad8581db0185980c175a24689b2f1011a6)📖![](https://github.com/Krutoy242/mc-icons/raw/master/i/extrautils2/terraformer__0.png "Terraformer") add note that "only 1 of a type required"
  > 
* [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/f0d2a319c096f320348218b6f5e8ab9cfa764655)📖Fix ![](https://github.com/Krutoy242/mc-icons/raw/master/i/actuallyadditions/block_furnace_double__0.png "Powered Furnace") had no requirments
  > 
## Mods changes
### 🟢 Added Mods

Icon | Summary | Reason
----:|:--------|:-------
<img src="https://media.forgecdn.net/avatars/thumbnails/951/894/30/30/638441639917328756.png"            > |                          [**TheOneSmeagle**](https://www.curseforge.com/minecraft/mc-mods/theonesmeagle)                <sup><sub>theonesmeagle-1.12-1.0.4.jar                     </sub></sup><br>A fork of The One Probe, meant to be a more immersive version of WAILA/HWYLA | Better replacement of WAILA
<img src="https://media.forgecdn.net/avatars/thumbnails/44/562/30/30/636033342690526889.jpeg"            > |                             [**TOP Addons**](https://www.curseforge.com/minecraft/mc-mods/top-addons)                   <sup><sub>topaddons-1.12.2-1.13.0.jar                      </sub></sup><br>Adds mod support to The One Probe by McJty | (TOP addon)
<img src="https://media.forgecdn.net/avatars/thumbnails/428/742/30/30/637662550518620713.png"            > |                      [**Thaumic One Probe**](https://www.curseforge.com/minecraft/mc-mods/thaumic-one-probe)            <sup><sub>thaumic-one-probe-1.12.2-1.0.0.jar               </sub></sup><br>adds TOP displays for various thaumcraft apparatus | (TOP addon)
<img src="https://media.forgecdn.net/avatars/thumbnails/1111/53/30/30/638662497025737758.png"            > |                        [**Patchouli Books**](https://www.curseforge.com/minecraft/mc-mods/patchouli-books)              <sup><sub>patchoulibooks-0.2.2.jar                         </sub></sup><br>An add-on to Patchouli for 1.12.2 | Added guides for mods like `Thermal Logistics`
<img src="https://media.forgecdn.net/avatars/thumbnails/29/943/30/30/635853960312359636.png"             > |                       [**Mod Name Tooltip**](https://www.curseforge.com/minecraft/mc-mods/mod-name-tooltip)             <sup><sub>modnametooltip_1.12.2-1.10.1.jar                 </sub></sup><br>Minecraft mod that shows an ItemStack&#x27;s mod name on its tooltip. | Required after removing WAILA
-----------


### 🔴 Removed Mods

Icon | Summary | Reason
----:|:--------|:-------
<img src="https://media.forgecdn.net/avatars/thumbnails/63/499/30/30/636143286314870563_animated.gif"    > |                                  [**Hwyla**](https://www.curseforge.com/minecraft/mc-mods/hwyla)                        <sup><sub>Hwyla-1.8.26-B41_1.12.2.jar                      </sub></sup><br>Hwyla (Here&#x27;s What You&#x27;re Looking At) is a UI improvement mod aimed at providing block information directly in-game. It is also a fork of Waila. | Replaced by `TheOneProbe`
<img src="https://media.forgecdn.net/avatars/thumbnails/6/741/30/30/635367541803914396.png"              > |                   [**Waila Harvestability**](https://www.curseforge.com/minecraft/mc-mods/waila-harvestability)         <sup><sub>WailaHarvestability-mc1.12-1.1.12.jar            </sub></sup><br>An add-on for Waila that adds information about the harvestability of what you are looking at | (WAILA addon)
<img src="https://media.forgecdn.net/avatars/thumbnails/11/204/30/30/635483047149673159.png"             > |         [**Wawla - What Are We Looking At**](https://www.curseforge.com/minecraft/mc-mods/wawla)                        <sup><sub>Wawla-1.12.2-2.6.275.jar                         </sub></sup><br>Waila/Hwyla addon which adds all the info. | (WAILA addon)
<img src="https://media.forgecdn.net/avatars/thumbnails/207/323/30/30/636965628804677340.png"            > |                                [**Jade 🔍**](https://www.curseforge.com/minecraft/mc-mods/jade)                         <sup><sub>Jade-0.1.0.jar                                   </sub></sup><br>Shows information about what you are looking at. (Hwyla/WAILA fork for Minecraft 1.16+) | (WAILA addon)
-----------

### 🟡 Updated Mods

Icon | Summary | Old / New
----:|:--------|:---------
<img src="https://media.forgecdn.net/avatars/thumbnails/10/842/30/30/635468327818431130.png"             > |                        [**Storage Drawers**](https://www.curseforge.com/minecraft/mc-mods/storage-drawers)             | <nobr>StorageDrawers-1.12.2-5.5.3</nobr><br><nobr>StorageDrawers-1.12.2-5.5.3</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/92/854/30/30/636258666554688823.png"             > |                        [**Xaero's Minimap**](https://www.curseforge.com/minecraft/mc-mods/xaeros-minimap)              | <nobr>Xaeros_Minimap_24.6.1_Forge_1.12</nobr><br><nobr>Xaeros_Minimap_24.7.1_Forge_1.12</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/180/855/30/30/636796143936766724.png"            > |                           [**PackagedAuto**](https://www.curseforge.com/minecraft/mc-mods/packagedauto)                | <nobr>PackagedAuto-1.12.2-1.0.15.57</nobr><br><nobr>PackagedAuto-1.12.2-1.0.15.58</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/196/654/30/30/636886857118683130.png"            > |                      [**Xaero's World Map**](https://www.curseforge.com/minecraft/mc-mods/xaeros-world-map)            | <nobr>XaerosWorldMap_1.39.2_Forge_1.12</nobr><br><nobr>XaerosWorldMap_1.39.2_Forge_1.12</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/292/428/30/30/637325593905195388.png"            > |                              [**Zen Utils**](https://www.curseforge.com/minecraft/mc-mods/zenutil)                     | <nobr>zenutils-1.21.4</nobr><br><nobr>zenutils-1.21.5</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/648/528/30/30/638050129235150630.png"            > |                               [**RLMixins**](https://www.curseforge.com/minecraft/mc-mods/rlmixins)                    | <nobr>RLMixins-1.3.14</nobr><br><nobr>RLMixins-1.3.15</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/874/755/30/30/638296262646953159.png"            > |                [**Alfheim Lighting Engine**](https://www.curseforge.com/minecraft/mc-mods/alfheim-lighting-engine)     | <nobr>Alfheim-1.5-Dev-1</nobr><br><nobr>Alfheim-1.5-Dev-4</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/937/632/30/30/638416090890641368.png"            > |            [**Thaumic Tinkerer Unofficial**](https://www.curseforge.com/minecraft/mc-mods/thaumic-tinkerer-unofficial) | <nobr>thaumictinkerer-1.12.2-5.7.2-Unofficial</nobr><br><nobr>thaumictinkerer-1.12.2-5.8.0-Unofficial</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1001/840/30/30/638521728187451529.jpg"           > |           [**Advanced Rocketry - Reworked**](https://www.curseforge.com/minecraft/mc-mods/advanced-rocketry-2)         | <nobr>AdvancedRocketry-1.12.2-2.1.4-8</nobr><br><nobr>AdvancedRocketry-1.12.2-2.1.4-9</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1043/608/30/30/638570948098338792.png"           > |                  [**Integrated Derivative**](https://www.curseforge.com/minecraft/mc-mods/integrated-derivative)       | <nobr>integratedderivative-1.1.1</nobr><br><nobr>integratedderivative-1.1.2</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1071/348/30/30/638606872011907048.png"           > |              [**Fluid Interaction Tweaker**](https://www.curseforge.com/minecraft/mc-mods/fluid-interaction-tweaker)   | <nobr>fluidintetweaker-1.5.0</nobr><br><nobr>fluidintetweaker-1.5.1</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1109/618/30/30/638660579625539174.png"           > |                       [**Backpack Display**](https://www.curseforge.com/minecraft/mc-mods/backpack-display)            | <nobr>backpackdisplay-1.6.0</nobr><br><nobr>backpackdisplay-1.6.2</nobr>
-----------


