## 🐛 Fixes

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/8ad22f8)✏️`Diverse singularities` - make more obivios how to craft them

  #### Loot

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/eb24ff1)👾Restore `Ender IO` pool name in EnderIO chest tables
    > Junk ![](https://cdn.jsdelivr.net/gh/Krutoy242/mc-icons@master/i/enderio/item_material__9.png "Wooden Gear") and ![](https://cdn.jsdelivr.net/gh/Krutoy242/mc-icons@master/i/enderio/item_material__10.png "Stone Gear") are again removed from dungeon, mineshaft, blacksmith and mansion chests.
    > 
    > Related: 26a577db6

  #### Mods

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/43eb148)🟠Rollback Immersive Technology to 1.10.206
    > Sorry that testing new mod versions broke your multiblocks and automation =( IT 1.11 ruined Melting Crucibles, ate Boilers and crashed the game on sight of an IE Transformer, so the pack steps back to the last version before the Immersive Convergence split.
    > 
    > ⚠️ Back up your world before updating, then check every IE/IT multiblock and which port its fluids actually come out of.
    > 
    > Related: ff715c7e2


## Mods changes

### 🔴 Removed Mods

Icon | Summary | Reason
----:|:--------|:-------
<img src="https://media.forgecdn.net/avatars/thumbnails/1684/237/30/30/639069808318604516.jpg"           > |                  [**Immersive Convergence**](https://www.curseforge.com/minecraft/mc-mods/immersive-convergence)        <sup><sub>ImmersiveConvergence-1.12.2-1.0.107-release.jar  </sub></sup><br>API for Immersive Engineering addons | Lib not required anymore
-----------

### 🟡 Updated Mods

Icon | Summary | Old / New
----:|:--------|:---------
<img src="https://media.forgecdn.net/avatars/thumbnails/1379/566/30/30/638894913493014322.png"           > |                   [**Immersive Technology**](https://www.curseforge.com/minecraft/mc-mods/mct-immersive-technology)    | <nobr>`MCT-ImmersiveTechnology-1.12.2-1.11.209-release`</nobr><br><nobr>`MCT-ImmersiveTechnology-1.12.2-1.10.206-release`</nobr><br><details><summary>Changelog ↓</summary><p>Changelog:</p> <p>&nbsp;* Make IC multiblocks work with VintageFix</p> <p>Changelog:</p> <h2>CONFIGS HAVE CHANGED, CHECK IC AND IT CONFIGS!</h2> <ul> <li>Unused import cleanup</li> <li>Solar melter to just melter name on recipes</li> <li>Client offset now calculated automatically</li> <li>Force temp minimum on boiler burners to 600</li> <li>Auto mirroring for boilers</li> <li>Mirror obj/model files are no longer needed</li> <li>Manual alignment on all versions</li> <li>Make smoke behave to config setting</li> <li>More cleanup and warning fixes</li> <li>More code to IC</li> <li>Performance fixes for solar reflector rendering</li> <li>Mixin and API blocks moved to IC</li> <li>Annotation alignment</li> <li>Solar Registry alignment with IC</li> <li>Massive API port to IC</li> <li>IC now does split model generation</li> <li>Shape and split model move to IC</li> <li>Assets re-work</li> <li>Updated boiler shapeaabb</li> </ul></details>
<img src="https://media.forgecdn.net/avatars/thumbnails/1040/449/30/30/638566423721005726.png"           > |                            [**StellarCore**](https://www.curseforge.com/minecraft/mc-mods/stellarcore)                 | <nobr>`StellarCore-1.6.0`</nobr><br><nobr>`StellarCore-1.6.1`</nobr><br><details><summary>Changelog ↑</summary><p>Fix the bug that appeared in the previous version.</p> <p>Process the OreDictionary class to reduce some memory usage; it may conflict with some mods. If problems occur, please disable it.</p></details>
-----------
