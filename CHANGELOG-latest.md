## ⚡ Performance Improvements


  #### Gear

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/ddbd5d3)⚡Rework TCon armor generation onmobs
    > - Now using native TCon methods, increasing performance for generation equipment  
    > - Lot of new modifiers added into gear pieces with higher difficulty level

## ✨ New Features

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/517b9fd)⛏️Add `Self-fix` trait
    > Trait that allow auto-merge compatible `Sharpening Kits` to repair currently hold tool when it lose durability.
    > 
    > Added to the materials: ![](https://github.com/Krutoy242/mc-icons/raw/master/i/thermalfoundation/material__129.png "Tin Ingot")![](https://github.com/Krutoy242/mc-icons/raw/master/i/thermalfoundation/material__164.png "Constantan Ingot")![](https://github.com/Krutoy242/mc-icons/raw/master/i/advancedrocketry/alienwood__0.png "Lightwood Wood")
  * <img src="https://i.imgur.com/yatlzHH.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/65dc301)⛏️Replace Glitch armor with brand new Glitch metal material
    > - Same traits as Glitch set has (flight, +matter drop)  
    > - Same traits for weapons (+18 perm damage)
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/356700c)✊Punch to extract/insert items
    > Now ![](https://github.com/Krutoy242/mc-icons/raw/master/i/openblocks/technicolor_glasses__0.png "Amazing Technicolor Glasses") have new mechanic when wear:  
    > - Prevent opening almost any GUI (including JEI or inventories) ←⚠️ could be bugged   
    > - But you can insert/take items from block inventories by punching them with empty hand or with item  
    > - Works even in cosmetic armor slots
    > 
    > Why? This is a WIP for future feature "Nogui challenge"
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/23bb765)🌠Make meteor ritual automateable
    > Before: ritual marked unactivated after each success, requiring player and only real player to reactivate it.  
    > Now: ritual never marked unactivated, and just have short cooldown.
  * <img src="https://i.imgur.com/uPOejQP.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/1d87636)🌱IC2 scanned by default
    > Now you dont need to scan your crops anymore! They all always scanned already.
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/1c2a338)🌷![](https://github.com/Krutoy242/mc-icons/raw/master/i/botania/specialflower__0__b359283d.png "Loonium") rework
    > > Contributed by [TabakaSIM](https://github.com/tabakasim)
    >
    > - Loonium spawns mobs from other mods.  
    > - On peaceful spawns butterflies that need to be caught to get loot.
  * <img src="https://i.imgur.com/xJ9tPb7.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/258523d)💚![](https://github.com/Krutoy242/mc-icons/raw/master/i/randomthings/ingredient__7__2c87b6ea.png "Floo Powder") fireplace name display
    > Right-clicking [Floo Bricks] will show obfuscated parts of the fireplace name.  
    > Touch it more.
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/5c43bfb)🤎Throw mud to turn blocks into brown variants

## 🐛 Fixes

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/fe5fad2)⌨️Improve `/cofh clearblocks` command
    > Now can be used with `inventory` keyword to clear blocks based on current player inventory + keep other block names
    > 
    > Use as `/cofh clearblocks <x> <y> <z> <radius> <dimension> inventory [water lava ...]`
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/7bf5f3a)♻️![](https://github.com/Krutoy242/mc-icons/raw/master/i/immersiveengineering/metal_multiblock__13.png "Arc Furnace") remove duplicate recycle recipes
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/9fabb52)♻️Add more ![](https://github.com/Krutoy242/mc-icons/raw/master/i/immersiveengineering/metal_multiblock__13.png "Arc Furnace") recycle recipes
    > Now it working with recipes from Thaumcraft and Forestry.
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/cc3f789)♻️Disable UniversalTweaks mixin for RequiousFracto
    > Since fixed in the fork
  * <img src="https://i.imgur.com/9rCyweu.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/2a8a529)⚚![](https://github.com/Krutoy242/mc-icons/raw/master/i/bloodmagic/demon_will_gauge__0.png "Demon Will Aura Gauge") add to ![](https://github.com/Krutoy242/mc-icons/raw/master/i/omniwand/wand__0.png "Omniwand")
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/29c3199)✏️![](https://github.com/Krutoy242/mc-icons/raw/master/i/twilightforest/crumble_horn__0.png "Crumble Horn") fix crash on usage
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/9cfb796)✏️![](https://github.com/Krutoy242/mc-icons/raw/master/i/requious/infinity_furnace__0.png "Infinity Furnace") fix merging unstackables
    > Can't melt items with unstackable output anymore
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/5d7f39b)✏️![](https://github.com/Krutoy242/mc-icons/raw/master/i/twilightforest/uncrafting_table__0.png "Uncrafting Table") prevent dupe with oredict
    > Now any items that share oredict in input and output will be blocked.
    > 
    > No more duping ![](https://github.com/Krutoy242/mc-icons/raw/master/i/redstonerepository/material__5.png "Gelid Crystal") from ![](https://github.com/Krutoy242/mc-icons/raw/master/i/libvulpes/elitemotor__0.png "Elite Motor")
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/9dd5b30)🍱Fix ![](https://github.com/Krutoy242/mc-icons/raw/master/i/storagedrawers/compdrawers__0.png "Compacting Drawer") destroyed by hand
    > > Contributed by [Bada774](https://github.com/bada774)
    >
    > When playing on server with low TPS and lot of AS perks, hand-breaking speed is so fast, even one frame of punching Drawer caused it to break -> just disappear.
    > 
    > This fixes breaking drawers when taking items.
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/1db8b5d)👒Tagging entities not always keep them persisten
    > > Contributed by [Bada774](https://github.com/bada774)
    >
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/a9c4298)📖Fix ![](https://github.com/Krutoy242/mc-icons/raw/master/i/requious/infinity_furnace__0.png "Infinity Furnace") desc 4x to 3x
    > related 418ffe18
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/6f27143)🔉Fix scafolds not playing proper sound
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/03846f6)🔵Remove Requious mixins since fixed
    > ..by updating to RequiousFracto fork.
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/08c922d)🦯[Infernal Furnace] remove leftovers of incorrect nuggets
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/aab4f19)🪐Make `skyblock` planet render as void world
    > Instead of second planet orbiting Earth 😅
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/7147d08)🟠Migration `mct_immersivetechnology`
    > There was some changes in HPS turbine and melting crucible.
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/08e9282)🟠Migration `mctsmelteryio` => `smelteryio`
    > This migration renaming all item and blocks IDs, so expect any AE patterns with those items broke, any blocks dissapear.
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/73b68ff)🟠Migration to `RequiousFractoUnofficial`
    > Required some shifting of JEI pages

  #### Balance

  * <img src="https://i.imgur.com/sm60l1U.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/230c76e)✏️![](https://github.com/Krutoy242/mc-icons/raw/master/i/ic2/crafting__6.png "Electric Motor") cheaper in ![](https://github.com/Krutoy242/mc-icons/raw/master/i/extendedcrafting/table_basic__0.png "Engineering Table")
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/b497147)✏️![](https://github.com/Krutoy242/mc-icons/raw/master/i/industrialforegoing/animal_resource_harvester__0.png "Animal Rancher") fix ingredient
  * <img src="https://i.imgur.com/oTuRr9I.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/eb9ef30)✏️![](https://github.com/Krutoy242/mc-icons/raw/master/i/integratedtunnels/part_exporter_energy_item__0.png "Energy Exporter") default transfer rate to 2G rf/t
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/5ba89ee)✏️![](https://github.com/Krutoy242/mc-icons/raw/master/i/ic2/block_cutting_blade__2.png "Block Cutting Blade (Diamond)") harder
    > Now diamond would not be meltable in Smeltery anymore, making blade require ![](https://github.com/Krutoy242/mc-icons/raw/master/i/immersivetech/metal_multiblock1__8.png "Melting Crucible") instead.
  * <img src="https://i.imgur.com/XGJOeY9.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/69ee1d8)✏️![](https://github.com/Krutoy242/mc-icons/raw/master/i/ic2/ingot__0.png "Mixed Metal Ingot") cheaper in ![](https://github.com/Krutoy242/mc-icons/raw/master/i/extendedcrafting/table_basic__0.png "Engineering Table")
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/1f3605a)✏️![](https://github.com/Krutoy242/mc-icons/raw/master/i/extrautils2/machine__0__c1480540.png "Potion Generator") now accept only modded potions
  * <img src="https://i.imgur.com/q4gXocD.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/8869d93)✏️![](https://github.com/Krutoy242/mc-icons/raw/master/i/thermalfoundation/material__165.png "Signalum Ingot") make faster in Alloy Smeltery
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/3047eaa)✏️X10 energy transfer rate all `Gendustry` machines
    > Since sometimes you need several RF pipes to power one machine
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/3a19e6b)💙X10 replication cost increase without catalyst
    > Since players actively use vanilla IC2 replication mechanics instead of the custom one, all prices for the vanilla replicator have been increased 10x. At the same time, the discount for low difficulty has also been increased 10x, so this does not affect the intended replication price. Replicating without a catalyst is already a sufficient advantage for IC2 replicator users.

  #### Gear

  * <img src="https://i.imgur.com/VDgScEt.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/6283d0e)`ExCompressum` add ![](https://github.com/Krutoy242/mc-icons/raw/master/i/tconstruct/book__0.png "Materials and You") entries
    > For ![](https://github.com/Krutoy242/mc-icons/raw/master/i/excompressum/auto_compressor__0.png "Auto Compressor") and ![](https://github.com/Krutoy242/mc-icons/raw/master/i/excompressum/double_compressed_diamond_hammer__0.png "Double Compressed Diamond Hammer").  
    > No body knew untill today that there is modifier for compressing mined blocks.

  #### JEI

  * <img src="https://i.imgur.com/ax4uVAU.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/488a74d)📃Collapse ![](https://github.com/Krutoy242/mc-icons/raw/master/i/minecraft/crafting_table__0.png "Crafting Table")
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/b7d203a)📑Unhide ![](https://github.com/Krutoy242/mc-icons/raw/master/i/rftools/syringe__0__3318beea.png "Syringe")
    > Now we can make collapsable group instead of hiding item from JEI.
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/7ee8b2b)📝Slightly improve sorting of JEI categories

  #### Quest

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/6e0b2dd)📖![](https://github.com/Krutoy242/mc-icons/raw/master/i/industrialforegoing/infinity_drill__0.png "Infinity Drill")[Naquadah Reservoir] replace/add loot crate rewards
    > Both quests previously had no meaningful loot reward, now give legendary/rare crates.
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/47d3634)📖![](https://github.com/Krutoy242/mc-icons/raw/master/i/ic2/te__52.png "Thermal Centrifuge")![](https://github.com/Krutoy242/mc-icons/raw/master/i/ic2/te__54.png "Induction Furnace") add Redstone Signal Inverter Upgrade info
  * <img src="https://i.imgur.com/bGixF7j.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/0897247)📖Add ![](https://github.com/Krutoy242/mc-icons/raw/master/i/rftools/spawner__0.png "Spawner") living matter list
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/b9ba96b)📖Add note that wild dragons must be chained
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/718b55a)📖Fix ![](https://github.com/Krutoy242/mc-icons/raw/master/i/advancedrocketry/warpcore__0.png "Warp Core") quest cant be finished

  #### Server

  * <img src="https://i.imgur.com/y5iAlIp.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/a79dcdb)📝Add info about `Mc2Discord` configuration
    > Config already predwefined with fancy cool format

  #### Worldgen

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/ad6192b)🌍![](https://github.com/Krutoy242/mc-icons/raw/master/i/netherendingores/ore_nether_vanilla__2.png "Nether Emerald Ore") disable gen in The Nether
    > Emeralds supposed to be traded, not mined.
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/306320b)🌍`Terra Nova` now have huge ![](https://github.com/Krutoy242/mc-icons/raw/master/i/forestry/bog_earth__0.png "Bog Earth") veins
  * <img src="https://i.imgur.com/XmskCco.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/baad173)🪐Enrich atmosphere types for solar system and fictional systems
    > Enrich planetDefs.xml with realistic atmosphere values for solar system planets (Mercury, Venus, Mars, Titan, Uranus, Neptune) and add extreme atmosphere types for fictional systems (Kepler 0118, Chloros, Nexus, etc.)

## Mods changes
### 🟢 Added Mods

Icon | Summary | Reason
----:|:--------|:-------
<img src="https://media.forgecdn.net/avatars/thumbnails/1761/728/30/30/639120546278056317.png"           > |                [**Recurrent Complex Volts**](https://www.curseforge.com/minecraft/mc-mods/recurrent-complex-volts)      <sup><sub>RecurrentComplexVolts-1.12.2-2.0.0.6.jar         </sub></sup><br>structure generation for modern minecraft | Supported fork
<img src="https://media.forgecdn.net/avatars/thumbnails/1864/439/30/30/639170258672343017.png"           > |             [**Requious Frakto Unofficial**](https://www.curseforge.com/minecraft/mc-mods/requious-frakto-unofficial)   <sup><sub>requious-0.13.jar                                </sub></sup><br>Fork mod for creating custom single-block machines | Fork with several crash fixes
-----------


### 🔴 Removed Mods

Icon | Summary | Reason
----:|:--------|:-------
<img src="https://media.forgecdn.net/avatars/thumbnails/14/392/30/30/635594066493907797.png"             > |                      [**Recurrent Complex**](https://www.curseforge.com/minecraft/mc-mods/recurrent-complex)            <sup><sub>RecurrentComplex-1.4.8.6.jar                     </sub></sup><br>Adds a ton more structure generation, dungeons, and randomized loot - Fully customizable | Replaced by fork
<img src="https://media.forgecdn.net/avatars/thumbnails/220/560/30/30/637020934015742854.png"            > |                        [**Requious Frakto**](https://www.curseforge.com/minecraft/mc-mods/requious-frakto)              <sup><sub>Requious Frakto-0.12.jar                         </sub></sup><br>This is a techmod. It contains whatever you configure it to contain. | Replaced by fork
-----------

### 🟡 Updated Mods

Icon | Summary | Old / New
----:|:--------|:---------
<img src="https://media.forgecdn.net/avatars/thumbnails/1675/104/30/30/639065166237565452.jpg"           > |                            [**Smeltery IO**](https://www.curseforge.com/minecraft/mc-mods/mct-smeltery-io)             | <nobr>`MCTSmelteryIO-1.12.2-1.2.63`</nobr><br><nobr>`MCT-SmelteryIO-1.12.2-1.3.70`</nobr><br><details><summary>Changelog</summary><div><b>MCT-SmelteryIO-1.12.2-1.3.70</b><br><p>Changelog:</p> <p>&nbsp;- Remove last traces of mixin code<br>&nbsp;- Config name fix<br>&nbsp;- Fix formatting in build<br>&nbsp;- More build fixes<br>&nbsp;- Build updates<br>&nbsp;- Remove mixin from manifest<br>&nbsp;- Add issue templates<br>&nbsp;- Add configurable coolant items<br>&nbsp;- Fix mixin relic in release<br>&nbsp;- Fix version in mods screen<br>&nbsp;- Add cooldown to SI<br>&nbsp;- Code formatting and TE fixes<br>&nbsp;- Iceball better particles<br>&nbsp;- Fix up json models<br>&nbsp;- Sided mixin is only allowed in DEV<br>&nbsp;- Fix GUI for CM modes<br>&nbsp;- TE Optimizations<br>&nbsp;- Internal mod rename to fix TE registration issues<br>&nbsp;- TE Improvements<br>&nbsp;- Fix up registration code and additional warnings<br>&nbsp;- Get mod working in dev again</p> <p>&nbsp;</p></div><hr/><div><b>MCT-SmelteryIO-1.12.2-1.3.68</b><br><p>Changelog:</p> <p>&nbsp;- Remove mixin from manifest<br>&nbsp;- Add issue templates<br>&nbsp;- Add configurable coolant items<br>&nbsp;- Fix mixin relic in release<br>&nbsp;- Fix version in mods screen<br>&nbsp;- Add cooldown to SI<br>&nbsp;- Code formatting and TE fixes<br>&nbsp;- Iceball better particles<br>&nbsp;- Fix up json models<br>&nbsp;- Sided mixin is only allowed in DEV<br>&nbsp;- Fix GUI for CM modes<br>&nbsp;- TE Optimizations<br>&nbsp;- Internal mod rename to fix TE registration issues<br>&nbsp;- TE Improvements<br>&nbsp;- Fix up registration code and additional warnings<br>&nbsp;- Get mod working in dev again</p></div></details>
<img src="https://media.forgecdn.net/avatars/thumbnails/1379/566/30/30/638894913493014322.png"           > |                   [**Immersive Technology**](https://www.curseforge.com/minecraft/mc-mods/mct-immersive-technology)    | <nobr>`MCTImmersiveTechnology-1.12.2-1.9.102`</nobr><br><nobr>`MCT-ImmersiveTechnology-1.12.2-1.10.197-release`</nobr><br><details><summary>Changelog</summary><div><b>MCT-ImmersiveTechnology-1.12.2-1.10.197-release</b><br><p>Changelog:</p> <p>- Fix item interaction on the stack limiter<br>- Add 4th mode to splitter conveyor it now does both/left/right/stop with redstone pulse<br>- Extract conveyor should not go angled<br>- Dropping conveyor should not rotate vertical</p></div><hr/><div><b>MCT-ImmersiveTechnology-1.12.2-1.10.195-release</b><br><p>Changelog:</p> <p>&nbsp;- Release build 195 - 1.12.2 is now feature complete, maintenance only<br>&nbsp;- Various language file fixes<br>&nbsp;- Fix baseheater sound keeps playing after finished</p></div><hr/><div><b>MCT-ImmersiveTechnology-1.12.2-1.10.192-release</b><br><p>Changelog:<br>&nbsp;- OptiPNG do not apply lossless<br>&nbsp;- Re-work sounds, this fixes some playing when not active<br>&nbsp;- Mixin to fix IE wire rendering<br>&nbsp;- Re-run less aggressive OptiPNG on all textures</p></div><hr/><div><b>MCT-ImmersiveTechnology-1.12.2-1.10.184-release</b><br><p>&nbsp;- Belt optimization enabled by default (mct_mixin.cfg) DISABLE IF HAVING ISSUES<br>&nbsp;- Belts fully idle when no items/entites are on them after 2 seconds<br>&nbsp;- Belts now stay visually active for 2 seconds when items/entites pass over them (even without redstone)<br>&nbsp;- Massive reduction in duplicated code through clean inheritance hierarchy (easier updates &amp; bug fixes)<br>&nbsp;- All conveyor types now share consistent item handling (10-tick pickup delay + no-despawn logic)<br>&nbsp;- Covered conveyors now have unified, reliable collision &amp; selection boxes (horizontal + sloped)<br>&nbsp;- Covered variants properly render walls and supports<br>&nbsp;- Extractor arm now visually extends/retracts based on target block distance (up to 4 pixels)<br>&nbsp;- Split conveyor now has reliable alternating output + redstone pulse toggle mode (SPLIT / ALL LEFT / ALL RIGHT)<br>&nbsp;- Split redirection uses per-entity NBT for stable splitting behavior (no more lost items)<br>&nbsp;- Drop conveyors improved insertion detection and trapdoor compatibility<br>&nbsp;- Vertical conveyors now correctly render bottom belt/wall connections when appropriate<br>&nbsp;- Vertical upward push logic refined for smoother entity movement and better centering<br>&nbsp;- All covered variants (including vertical &amp; extract) now visually connect properly to adjacent blocks<br>&nbsp;- Consistent magnet suppression / reversion logic across all types prevents item glitches<br>&nbsp;- Better redstone interaction on extractors (unpowered = active extraction)<br>&nbsp;- Player sneaking now reliably stops movement on all conveyors<br>&nbsp;- Improved model cache keys include dye, cover, direction, activity, and extension state</p> <p>Changelog:</p> <p>&nbsp;- Fix CME mixin for Cleanroom again<br>&nbsp;- Fix High Pressure Steam Turbine not rendering rotor<br>&nbsp;- Add AdvanceCokeOven to CokeOven JEI tab<br>&nbsp;- Fixes for extract conveyors<br>&nbsp;- Idle belt entirely when not doing work<br>&nbsp;- Activate belts when entities are on them<br>&nbsp;- Fix excessive model update calls<br>&nbsp;- Add additional features to conveyors<br>&nbsp;- Conveyor optimizations<br>&nbsp;- Fix mixin not applying to split conveyor<br>&nbsp;- Initial commit of optimized conveyors<br>&nbsp;- Build cleanup<br>&nbsp;- Quick formatting fixes<br>&nbsp;- Fix OptiPNG to only run on JAR build<br>&nbsp;- Remove IF from crucible JEI<br>&nbsp;- Missed one for OptiPNG<br>&nbsp;- OptiPNG run<br>&nbsp;- Fix base heater IF value in manual</p></div></details>
<img src="https://media.forgecdn.net/avatars/thumbnails/292/428/30/30/637325593905195388.png"            > |                              [**Zen Utils**](https://www.curseforge.com/minecraft/mc-mods/zenutil)                     | <nobr>`zenutils-1.27.2`</nobr><br><nobr>`zenutils-1.27.4`</nobr><br><details><summary>Changelog</summary><ul> <li>refactor LaunchClassLoaderBytesProvider to use MethodHandles and check transformer exclusions</li> <li>fix parameterNames doesn't consider big types</li> <li>temp support patch for List subclass: NonNullList</li> </ul></details>
<img src="https://media.forgecdn.net/avatars/thumbnails/329/782/30/30/637455985217160421.png"            > |                    [**Quark: RotN Edition**](https://www.curseforge.com/minecraft/mc-mods/quark-rotn-edition)          | <nobr>`QuarkRotN-r1.6-191`</nobr><br><nobr>`QuarkRotN-r1.6-192`</nobr><br><details><summary>Changelog</summary><p>- Add LemonSkin as incompatible mod with Food Tooltips feature</p></details>
<img src="https://media.forgecdn.net/avatars/thumbnails/1041/903/30/30/638568420563290317.png"           > |                    [**Forgelin-Continuous**](https://www.curseforge.com/minecraft/mc-mods/forgelin-continuous)         | <nobr>`Forgelin-Continuous-2.3.20.0`</nobr><br><nobr>`Forgelin-Continuous-2.4.0.0`</nobr><br><details><summary>Changelog</summary><h1>Bundled Libraries</h1> <ul> <li>Kotlin 2.4.0</li></details>
<img src="https://media.forgecdn.net/avatars/thumbnails/1759/563/30/30/639119386794317021.png"           > |                                  [**Chibi**](https://www.curseforge.com/minecraft/mc-mods/chibi)                       | <nobr>`loliasm-5.32`</nobr><br><nobr>`loliasm-5.33`</nobr><br><details><summary>Changelog</summary><ul> <li>Fix Advent of Ascension thrown weapons not working with <code>delayItemStackCapabilityInit</code> due to their own hacky nature (thanks jchung01!)</li> </ul></details>
<img src="https://media.forgecdn.net/avatars/thumbnails/385/984/30/30/637574191414697010.png"            > |                        [**Fluidlogged API**](https://www.curseforge.com/minecraft/mc-mods/fluidlogged-api)             | <nobr>`Fluidlogged-API-v3.3.1-mc1.12.2`</nobr><br><nobr>`Fluidlogged-API-v3.3.2-mc1.12.2`</nobr><br><details><summary>Changelog</summary><b>Bug Fixes:</b><br><ul><li>Fix occasional visual flickering while moving underwater (fixes <a href="https://github.com/jbredwards/Fluidlogged-API/issues/299">#299</a>).</li></ul><br><ul><li> Make it harder for the player to clip their camera into water without applying the correct fog or overlay.</li></ul></details>
<img src="https://media.forgecdn.net/avatars/thumbnails/557/657/30/30/637904734114975779.png"            > |                  [**Inventory Bogo Sorter**](https://www.curseforge.com/minecraft/mc-mods/inventory-bogosorter)        | <nobr>`bogosorter-1.6.3`</nobr><br><nobr>`bogosorter-1.6.4`</nobr><br><details><summary>Changelog</summary><ul><li>Fix GTCE / GTNE compatibility (#113)</li><li>Bump version to 1.6.4</li></ul></details>
<img src="https://media.forgecdn.net/avatars/thumbnails/588/553/30/30/637958651914966029.png"            > |                         [**Baubley Elytra**](https://www.curseforge.com/minecraft/mc-mods/baubley-elytra)              | <nobr>`Baubley-Elytra-v1.3.3-mc1.12.2`</nobr><br><nobr>`Baubley-Elytra-v1.3.6-mc1.12.2`</nobr><br><details><summary>Changelog</summary><div><b>Baubley-Elytra-v1.3.6-mc1.12.2</b><br>Initial Modrinth Release<hr/><b>Features:</b><br><ul><li>Add credits to the mod list gui entry.</li></ul><br><ul><li>Add mod logo to the mod list gui entry.</li></ul><br><ul><li>Add Modrinth `updateJSON` url.</li></ul><br><ul><li>Lang key for mod description in the mod list gui entry.</li></ul><br><ul><li>Make this mod's config gui translucent while in a world.</li></ul><br><ul><li>New config settings for toggling the Baubles patches added by this mod. These settings may only be changed while ConfigAnytime is installed, and are stored in a new "baubleye\_patches.cfg" file. The existing config settings are unchanged!</li></ul><br><ul><li>Remap Colytra's dedicated "elytra bauble" item, and replace it with the Vanilla elytra item at runtime.</li></ul><br><b>Bug Fixes:</b><br><ul><li>Minor changes to the "elytra bauble checker" code to make it work with new Baubles forks (such as Bubbles). Certain patches may need to be disabled for full compatibility though (using the new config settings).</li></ul><hr/><b>Bug Fixes:</b><br><ul><li>Fix crash during mod load if Colytra is not installed (fixes <a href="https://github.com/jbredwards/Baubley-Elytra-Mod/issues/8">#8</a>) (this bug only affected v1.3.4 of Baubley Elytra).</li></ul><hr/><b>Bug Fixes:</b><br><ul><li>Fix strange crash during server load (fixes <a href="https://github.com/jbredwards/Baubley-Elytra-Mod/issues/9">#9</a>) (this bug only affected v1.3.4 & v1.3.5 of Baubley Elytra).</li></ul></div><hr/><div><nobr><a href="/linkout?remoteUrl=https%253a%252f%252fmodrinth.com%252fmod%252fbaubley-elytra%252fchangelog">Baubley-Elytra-v1.3.5-mc1.12.2 ↗</a></nobr></div><hr/><div><nobr><a href="/linkout?remoteUrl=https%253a%252f%252fmodrinth.com%252fmod%252fbaubley-elytra%252fchangelog">Baubley-Elytra-v1.3.4-mc1.12.2 ↗</a></nobr></div></details>
<img src="https://media.forgecdn.net/avatars/thumbnails/920/586/30/30/638384165625905095.png"            > |                [**籁/Sound Physics Remixin**](https://www.curseforge.com/minecraft/mc-mods/sound-physics-remixin)       | <nobr>`soundphysics-1.1.15`</nobr><br><nobr>`soundphysics-1.1.19`</nobr><br><details><summary>Changelog</summary><div><b>soundphysics-1.1.19</b><br><ul> <li>Fix Jukebox mod playing being cut out</li> <li>Fix IC2(exp/classic) jetpack freeze</li> <li>Attempts to improve Simple Voice Chat compat</li> <li>Fix sound name null crash</li> </ul></div><hr/><div><b>soundphysics-1.1.17</b><br><ul> <li>Move to Cleanroom, it is now a Cleanroom-only mod</li> <li>Fix wrong Mixin target somehow worked and somehow broken</li> <li>Somehow fix a rare null pointer exception, need further tests</li> </ul></div></details>
<img src="https://media.forgecdn.net/avatars/thumbnails/1304/81/30/30/638847932766552243.png"            > |                                  [**Fugue**](https://www.curseforge.com/minecraft/mc-mods/fugue)                       | <nobr>`+Fugue-0.23.4`</nobr><br><nobr>`+Fugue-0.23.6`</nobr><br><details><summary>Changelog</summary><ul> <li>6af3a68 Change gradle Xmx to 8g</li> <li>70f823d Add Transcend patch</li> <li>ecec2ee Update gradle to 9.5.1</li> <li>75665d8 Revert &quot;Fix compat with new lwjgl change&quot;</li> <li>09d84cf Fix Railcraft compatibility (#129)</li> <li>58c5d2d Fix compat with new lwjgl change</li> <li>adf679e Update gradle</li> </ul></details>
<img src="https://media.forgecdn.net/avatars/thumbnails/1001/840/30/30/638521728187451529.jpg"           > |           [**Advanced Rocketry - Reworked**](https://www.curseforge.com/minecraft/mc-mods/advanced-rocketry-2)         | <nobr>`advancedrocketry-2.2.9`</nobr><br><nobr>`advancedrocketry-2.2.10`</nobr><br><details><summary>Changelog</summary><div> <pre>2.2.10<br><br>- Fixed rocket destination validation:<br>  - Unregistered dimensions no longer fall back to Earth (dim 0), preventing invalid custom-dimension and cross-star routes from passing checks.<br>  - Improved error messages for unmapped dimensions, instead of silent failure.<br>- Allow png LEO textures, <br>  - Add voidleo.png to be used with customicon="void"<br>  - Convert asteroidleo to png, and blank background<br>- Removed AR.Core (empty modcontainer showing in "Mods")<br>- One more small Jei.lodaded guard<br>- Update Chinese (thanks to ZY)</pre> </div></details>
<img src="null"                                                                                          > |                                  [**ARLib**](https://www.curseforge.com/minecraft/mc-mods/arlib)                       | <nobr>`libvulpes-0.5.3`</nobr><br><nobr>`libvulpes-0.5.4`</nobr><br><details><summary>Changelog</summary><div> <pre>0.5.4<br>  - 3D spinning render in rocket/observatory GUI, now renders behind held item<br>  - Corrected limited slots for Satellite Builder</pre> </div></details>
<img src="https://media.forgecdn.net/avatars/thumbnails/1049/742/30/30/638578938162857406.png"           > |    [**Rather Enough Immersive Multiblocks**](https://www.curseforge.com/minecraft/mc-mods/rather-enough-immersive-multiblocks)| <nobr>`reim-0.2`</nobr><br><nobr>`reim-0.3`</nobr><br><details><summary>Changelog</summary><p>+ Fixed compatibility with new versions of Immersive Tech</p></details>
<img src="https://media.forgecdn.net/avatars/thumbnails/1482/227/30/30/638963404721998907.png"           > |                        [**Crash Assistant**](https://www.curseforge.com/minecraft/mc-mods/crash-assistant)             | <nobr>`!!!CrashAssistant-forge-1.12.2-1.11.9`</nobr><br><nobr>`!!!CrashAssistant-forge-1.12.2-1.11.10`</nobr><br><details><summary>Changelog</summary><ul> <li>Ported mod to 26.2 for NeoForge and Fabric.</li> <li>Fixed better compatibility checker (BCC mod), new config format.</li> <li>Fixed compatiblity with Radiance mod. Also must fix compatibility with any other mod which is replacing OpenGL API with Vulkan.</li> </ul> <h3><a href="/linkout?remoteUrl=https%253a%252f%252fkostromdan.github.io%252fCrash-Assistant%252fchangelog.md" rel="nofollow">See full changelog</a></h3></details>
<img src="https://media.forgecdn.net/avatars/thumbnails/1358/482/30/30/638882387444615595.png"           > |             [**Thaumic Wonders Unofficial**](https://www.curseforge.com/minecraft/mc-mods/thaumic-wonders-unofficial)  | <nobr>`thaumicwonders-2.3.1`</nobr><br><nobr>`thaumicwonders-2.3.2`</nobr><br><details><summary>Changelog</summary><h3>Fixed</h3> <ul> <li>Fixed inactive Osmotic Enchanter disassembling structure if broken near active enchanter</li> <li>Fixed server crash on enchanter placement</li> <li>Fixed missing Osmotic Enchanter language keys</li> </ul></details>
<img src="https://media.forgecdn.net/avatars/thumbnails/1430/837/30/30/638927053511180100.png"           > |                         [**ThaumicTweaker**](https://www.curseforge.com/minecraft/mc-mods/thaumictweaker)              | <nobr>`thaumictweaker-1.3.1`</nobr><br><nobr>`thaumictweaker-1.3.2`</nobr><br><details><summary>Changelog</summary><h3>Changed</h3> <ul> <li>Ars Magica 2: Rekindled ores are now supported by Sounding Color Overrides</li> </ul> <h3>Fixed</h3> <ul> <li>Fixed Firebat hitbox eye height</li> <li>Fixed a server crash with scanning</li> </ul></details>
<img src="https://media.forgecdn.net/avatars/thumbnails/1525/899/30/30/638990864881641740.png"           > |                         [**Quantum Things**](https://www.curseforge.com/minecraft/mc-mods/quantum-things)              | <nobr>`QuantumThings-MC-1.12.2-1.2.0`</nobr><br><nobr>`QuantumThings-MC-1.12.2-1.2.2`</nobr><br><details><summary>Changelog</summary><div><b>QuantumThings-MC-1.12.2-1.2.2</b><br><h3>Fixes</h3> <ul> <li>Fix Spectre Lens NullPointerException when starting a server (introduced in 1.2.1).</li> </ul></div><hr/><div><b>QuantumThings-MC-1.12.2-1.2.1</b><br><h3>Fixes</h3> <ul> <li>Named the new variants of Spectre wood consistently with vanilla (Spectre Planks &gt; Spectre Wood Planks) (Introduced in 1.2.0).</li> <li>Fixed a crash from CustomClassWriter on newer java versions. (<a href="https://github.com/MagicJinn/Quantum-Things/pull/55" rel="nofollow">courtesy of Leclowndu93150</a>)</li> <li>Fixed a crash when the Notification Interface was used in Multiplayer. (<a href="https://github.com/MagicJinn/Quantum-Things/pull/57" rel="nofollow">courtesy of Alternis</a>)</li> <li>Fixed the Ancient Furnace being able to break indestructible blocks.</li> <li>Fixed Magic Beans being able to resume growing when being interacted with with the Acceleration Wand (or any other item that would run updateTick()).</li> </ul></div></details>
<img src="https://media.forgecdn.net/avatars/thumbnails/1790/428/30/30/639134569119590165.png"           > |                             [**ThaumicAPI**](https://www.curseforge.com/minecraft/mc-mods/thaumicapi)                  | <nobr>`thaumicapi-1.0.2`</nobr><br><nobr>`thaumicapi-1.1.0`</nobr><br><details><summary>Changelog</summary><h2>[1.1.0]</h2> <h3>Added</h3> <ul> <li>Added NBTTagCompound support for Vis Discount items</li> <li>Added vis discount support for items held in mainhand or offhand</li> <li>Added helper method for adding Vis Discount to items <code>ThaumicAPI#addWarpingToStack(ItemStack, int)</code> or by adding the <code>TC.VISDISCOUNT</code> integer NBT tag to the ItemStack tag compound</li> <li>Added helper method for adding Warping to items <code>ThaumicAPI#addVisDiscountToStack(ItemStack, int)</code></li> </ul></details>
<img src="https://media.forgecdn.net/avatars/thumbnails/1816/124/30/30/639147876630578376.png"           > |   [**Actually Additions V2 Coffee Edition**](https://www.curseforge.com/minecraft/mc-mods/actually-additions-v2-coffee-edition)| <nobr>`ActuallyAdditions-1.12.2-r152`</nobr><br><nobr>`ActuallyAdditions-1.12.2-r155`</nobr>
-----------
