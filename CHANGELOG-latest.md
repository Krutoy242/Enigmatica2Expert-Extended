## ✨ New Features

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/152d8c2)⌨️Run custom commands from the server console
    > /perf, /omnipotence, /acquire and others now work for non-player senders: they reply to whoever ran them (console/command blocks get readable plain text), player-targeted commands require an explicit selector instead of silently picking a player, and the shared logic lives in scripts/lib/command.zs.
  * <img src="https://i.imgur.com/WTHJ5Oi.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/6bbbe60)🪄`Thaumic Tinkerer` migration
    > > Contributed by [TabakaSIM](https://github.com/tabakasim)
    >
    > - Rearranged the ![](https://cdn.jsdelivr.net/gh/Krutoy242/mc-icons@master/i/thaumcraft/thaumonomicon__0.png "Thaumonomicon") Eldritch category.  
    > - Added [Ender Mirror] functionality to the ![](https://cdn.jsdelivr.net/gh/Krutoy242/mc-icons@master/i/omniwand/wand__0.png "Omniwand").  
    > - Integrated the `Terminus` and `Ascension` aspects into progression. These are now among the most difficult aspects to obtain, surpassed only by the `amogus` aspect.  
    > - <img src="https://i.imgur.com/K1X7Ll9.png" align=right> Added **Necromancy**, including support for summoning some modded mobs.
    > 
    > ### Balance
    > 
    > - Harder [Essentia Combiner] now requires `Terminus` essentia.  
    > - <img src="https://i.imgur.com/ha3jIdU.png" align=right> Harder ![](https://cdn.jsdelivr.net/gh/Krutoy242/mc-icons@master/i/thaumicaugmentation/thaumostatic_harness__0.png "Thaumostatic Harness")
    > 
    > - Replaced [Adamantine Armor] with [Ichorium Armor] in progression.  
    >  > - Adamantine armor and the Tinkers' Construct material remain unchanged.  
    >  > - This change was made because Adamantine Armor offered little unique gameplay beyond being indestructible and providing a high Vis discount, while Ichorium Armor serves as more utility.  
    > - Ichorium require [Treminus] and [Acension] aspects vis crystals instead of Nether/End shards
  * <img src="https://i.imgur.com/0DCUxz5.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/2a5cff4)🪄Thaumcraft spell - expanded
    > > Contributed by [TabakaSIM](https://github.com/tabakasim)
    >
    > - New focus tier [Supreme Focus] with 100 capacity  
    > - New thaumcraft spells:  
    >   > - Apiary Acceleration - Accelerate bee process (works with pam harvest, forestry, gendustry apiaries)  
    >   > - Blackout - Remove all light sources in large area  
    >   > - Bloomia - Manipulate ic2 crops stats  
    >   > - Buttercatch - Catch all forestry butterflies in large area  
    >   > - Chronostasis - halts world.  
    >   > - Crossbreed - Force nearby ic2 crops to breed  
    >   > - Crystalize - Growth thaumcraft vis crystals; decorate your cavern base with crystal structures  
    >   > - Explosion - Creates explosion on impact  
    >   > - Feralis - Enslave tameable animals or change it's ownership  
    >   > - Vampirysm - Offensive spell; steal life from targest; fill your life essence storage  
    > - All (almost) thaumcraft spells have different vis crystal required in ![](https://cdn.jsdelivr.net/gh/Krutoy242/mc-icons@master/i/thaumcraft/wand_workbench__0.png "Focal Manipulator") crafting, for example `Efreet Flame` require `Infernum` vis crystal  
    > - Fix: Efreet flame spell now works on bifrost blocks (also other blocks that didn't worked before)

## 🐛 Fixes

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/8ef831f)📑Update Obscure Tooltips config to remedy mod conflicts
    > > Contributed by [ImNotEvenAngry](https://github.com/imnotevenangry)
    >
    > Should fix BackpackPreview and blue screen on hover

  #### Configs

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/e38e856)🔵Disable jerCrystals to avoid NPE on startup
    > Disables JER crystal integration in Thaumic Information to work around  
    > a NullPointerException in LootDrop.compareTo when ThaumcraftApiHelper  
    > returns null for certain aspects.
    > 
    > Related: https://github.com/roidrole/Thaumic-Information/issues/4
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/ebe8b9a)🧩Change some spawn chunk loading configs

## Mods changes
### 🟢 Added Mods

Icon | Summary | Reason
----:|:--------|:-------
<img src="https://media.forgecdn.net/avatars/thumbnails/1818/855/30/30/639149303839243292.png"           > |                           [**KAMI: Reborn**](https://www.curseforge.com/minecraft/mc-mods/kami-reborn)                  <sup><sub>kami-1.0.4.jar                                   </sub></sup><br>An overhaul of the KAMI module from Thaumic Tinkerer for Thaumcraft 6. | New fork
<img src="https://media.forgecdn.net/avatars/thumbnails/1544/794/30/30/639002585210312759.png"           > |                        [**Expanded Events**](https://www.curseforge.com/minecraft/mc-mods/expanded-events)              <sup><sub>expandedevents-1.2.2.jar                         </sub></sup><br>Adds new event handlers for a few key events. | Lib for fork
-----------

### 🟡 Updated Mods

Icon | Summary | Old / New
----:|:--------|:---------
<img src="https://media.forgecdn.net/avatars/thumbnails/292/428/30/30/637325593905195388.png"            > |                              [**Zen Utils**](https://www.curseforge.com/minecraft/mc-mods/zenutil)                     | <nobr>`zenutils-1.27.4`</nobr><br><nobr>`zenutils-1.27.5`</nobr><br><details><summary>Changelog ↑</summary><ul> <li>Improve native method matching error messages</li> <li>Rework bytebuf to fix netty memory leak</li> <li>Fix <code>/ct reload</code> error after <code>/ct syntax</code> for cross-loader references</li> <li>Fix template strings doesn't parse symbols as literals</li> </ul></details>
<img src="https://media.forgecdn.net/avatars/thumbnails/312/949/30/30/637407315722572617.png"            > |                            [**MixinBooter**](https://www.curseforge.com/minecraft/mc-mods/mixin-booter)                | <nobr>`!mixinbooter-11.1`</nobr><br><nobr>`!mixinbooter-11.5`</nobr><br><details><summary>Changelog ↑↑↑↑</summary><div><b>!mixinbooter-11.5</b><br><h3>Fixed</h3><br><ul><li>Old mods doing dumb things</li></ul><br><b>Full changelog between 11.4 and 11.5</b>: https://github.com/CleanroomMC/MixinBooter/compare/11.4...11.5</div><hr/><div><b>!mixinbooter-11.4</b><br><h3>Fixed</h3><br><ul><li>Rescuing all coremods that have a TweakClass attribute, instead only help those that have MixinTweaker as the TweakClass</li></ul><br><b>Full changelog between 11.3 and 11.4</b>: https://github.com/CleanroomMC/MixinBooter/compare/11.3...11.4</div><hr/><div><b>!mixinbooter-11.3</b><br><h3>Added</h3><br><ul><li>Warnings if mixins have somehow got no accessor targets</li></ul><br><ul><li>Exclusion of Mixin's launch package by default, may fix dev environment woes</li></ul><br><h3>Fixed</h3><br><ul><li>Concurrent modifications when mixin configurations are being registered and selected</li></ul><br><ul><li>Allow `IExtension` classes to passthrough and be in the same packages as mixins</li></ul><br><ul><li>Superclasses not being considered if they're interfaces</li></ul><br><b>Full changelog between 11.2 and 11.3</b>: https://github.com/CleanroomMC/MixinBooter/compare/11.2...11.3</div><hr/><div><b>!mixinbooter-11.2</b><br><h3>Fixed</h3><br><ul><li>#124, now MixinExtras won't crash in older Minecraft versions</li></ul><br><ul><li>#126, injects `CoremodRescuer` earlier in the tweakers list, helps mods using wrong APIs to still submit mixin configurations properly</li></ul><br><ul><li>Incompatibility with mods like VintageFix which errors due to an upstream regression for synthetic inner classes</li></ul><br><h3>Changed</h3><br><ul><li>Updated CleanMix to 0.4.1</li></ul><br><ul><li>Prefer reading `ForgeVersion` with reflection for the current Minecraft version (thanks to @ZZZank)</li></ul><br><b>Full changelog between 11.1 and 11.2</b>: https://github.com/CleanroomMC/MixinBooter/compare/11.1...11.2</div></details>
<img src="https://media.forgecdn.net/avatars/thumbnails/343/120/30/30/637487797218677486.png"            > |                     [**Better Biome Blend**](https://www.curseforge.com/minecraft/mc-mods/better-biome-blend)          | <nobr>`betterbiomeblend-1.12.2-1.2.1-forge`</nobr><br><nobr>`betterbiomeblend-1.12.2-1.1.7-forge`</nobr><br><details><summary>Changelog ↓</summary><p>Serene Seasons compatibility. Mixin dependency fix. General bug fixes.</p></details>
<img src="https://media.forgecdn.net/avatars/thumbnails/1193/283/30/30/638768621890000641.png"           > |                   [**Cleanroom Relauncher**](https://www.curseforge.com/minecraft/mc-mods/cleanroom-relauncher)        | <nobr>`!cleanroom-relauncher-0.6.1`</nobr><br><nobr>`!cleanroom-relauncher-0.6.2`</nobr><br><details><summary>Changelog ↑</summary><h3>Fixed</h3> <ul> <li>Duplicate downloads as the downloader is now cleaned up to avoid this from happening</li> </ul></details>
<img src="https://media.forgecdn.net/avatars/thumbnails/1723/373/30/30/639096406588694749.png"           > |                           [**Armored Arms**](https://www.curseforge.com/minecraft/mc-mods/armored-arms)                | <nobr>`ArmoredArms-v1.5.1-1.12.2-release`</nobr><br><nobr>`ArmoredArms-v1.5.3-1.12.2-release`</nobr><br><details><summary>Changelog ↑↑</summary><div><b>ArmoredArms-v1.5.3-1.12.2-release</b><br><p>Fixed:</p> <ul> <li>Crush without HBM.</li> </ul></div><hr/><div><b>ArmoredArms-v1.5.2-1.12.2-release</b><br><p>Changes:</p> <ul> <li>Migrated to core 1.2.6</li> <li>Updated compatibility with HBM</li> </ul></div></details>
<img src="https://media.forgecdn.net/avatars/thumbnails/1430/837/30/30/638927053511180100.png"           > |                         [**ThaumicTweaker**](https://www.curseforge.com/minecraft/mc-mods/thaumictweaker)              | <nobr>`thaumictweaker-1.3.2`</nobr><br><nobr>`thaumictweaker-1.3.3`</nobr><br><details><summary>Changelog ↑</summary><h3>Fixed</h3> <ul> <li>Fixed Flux Rift drain fix causing rifts to disappear when they're interacted by Thaumic Augmentation's Metaspatial Extruder</li> </ul></details>
<img src="https://media.forgecdn.net/avatars/thumbnails/1540/189/30/30/639000001051070063.png"           > |                         [**Antique Armory**](https://www.curseforge.com/minecraft/mc-mods/antique-armory)              | <nobr>`AntiqueArmory-1.12.2-1.2.9`</nobr><br><nobr>`AntiqueArmory-1.12.2-1.3.0`</nobr><br><details><summary>Changelog ↑</summary><ul> <li>Fixed <code>addMultiItem</code> not working on ContentTweaker integration (thanks to XiFengXiaoYun)</li> </ul></details>
<img src="https://media.forgecdn.net/avatars/thumbnails/1818/819/30/30/639149282719677740.png"           > |               [**Thaumic Tinkerer: Reborn**](https://www.curseforge.com/minecraft/mc-mods/thaumic-tinkerer-reborn)     | <nobr>`thaumictinkerer-1.12.2-5.9.15-Unofficial`</nobr><br><nobr>`thaumictinkerer-1.0.6`</nobr><br><details><summary>Changelog ↑</summary><h3>Fixed</h3> <ul> <li>Fixed Necromancy Tablet CraftTweaker recipe removal methods not working</li> <li>Fixed Transvector Dislocator moving unbreakable blocks</li> </ul></details>
-----------
