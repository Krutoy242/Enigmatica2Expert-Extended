## ⚡ Performance Improvements

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/2d1f6ee)⚡Disable Vis crystal generation in non-magic dimensions
    > Removed 73 entries.  
    > This will clean up JER tab for JEI and unflood JEI entries overall.
    > 
    > List of dimensions without Vis crystals:
    > 
    > - Alien Jungle (200)  
    > - Europa (106)  
    > - Io (105)  
    > - KELT-4ab (120)  
    > - Kepler 0118 (122)  
    > - Kepler 0119 (123)  
    > - Luna (100)  
    > - Mars (103)  
    > - Mercury (101)  
    > - Neptune (110)  
    > - Titan (108)  
    > - Uranus (109)  
    > - Venus (102)
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/3534b1f)⚡Do not spawn Botania mushrooms in space+
    > Removed 180+ entries.
    > 
    > This will clean up JER tab for JEI and unflood JEI entries overall.
    > 
    > List of dimensions without Botania's mushroioms:  
    > - Alien Jungle (200)  
    > - Io (105)  
    > - KELT-4ab (120)  
    > - Kepler 0118 (122)  
    > - Kepler 0119 (123)  
    > - Luna (100)  
    > - Mars (103)  
    > - Mercury (101)  
    > - Neptune (110)  
    > - Proxima B (111)  
    > - Titan (108)  
    > - Uranus (109)  
    > - Venus (102)  
    > - Wasteland (4598)
  * <img src="https://i.imgur.com/us0jyQl.png" align=right width="50%"> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/644747a)⚡Fix `OpenComputers` JEI plugin is still loaded
    > Should descrease loading time to ~2 second.
    > 
    > related 08dae5cf3bb7a6ec6e5d5e9e04c91cdf477015c1

## ✨ New Features

  * <img src="https://i.imgur.com/QXFy3Do.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/e6d66ff)📖JER now sort entries by their rarities
    > More frequent - earlier on the pages
  * <img src="https://i.imgur.com/dGuw15i.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/0451002)🪐Rich advanced rocketry planet configs
    > - Disable rain on `Mercury`, `Venus`, `Kepler 0118`  
    > - Add retrograde orbit to `Venus` and `Kepler 0119`  
    > - Add high-tier laser drill ores to `Kepler 0118` and `Kepler 0119`  
    > - Add aquatic mob spawns to `Europa`  
    > - Adjust crater, geode, and volcano frequencies on `Mars`, `Luna`, `Kepler 0118`, `KELT-1b`  
    > - Scale stars and add names in `Magnis Vulpes` system  
    > - Vary ring angles on `Hubble` and `KELT-1b`  
    > - Enable constant rain on `Alien Jungle`

## 🐛 Fixes

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/40d26d3)⌛Restore ![](https://github.com/Krutoy242/mc-icons/raw/master/i/randomthings/timeinabottle__0__f62.png "Time in a bottle") legacy
    > Revert Tiab mechanic back as it was in `v1.76.0-beta`  and earlier. Now ![](https://github.com/Krutoy242/mc-icons/raw/master/i/contenttweaker/bee_diversity__0.png "Bee Diversity Store") working again.
    > 
    > Thanks `MagicJinn` for implementing this revert https://github.com/MagicJinn/Quantum-Things/issues/36
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/8f306dc)✏️Fix dupe with [(every) Chute] (IE)
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/3f8dc43)📖Fix JER shuffled `Nether` and `End` entries
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/5060393)🧩 ![](https://github.com/Krutoy242/mc-icons/raw/master/i/minecraft/piston__0__c44316ae.png "Piston") allow all `Quantum Things` blocks
    > Thanks `MagicJinn` for implementing piston handling!
    > 
    > Fix https://github.com/MagicJinn/Quantum-Things/issues/42
    > 
    > Related: 6c8b972db7faeae9204d8e32c8da68410d1172a6
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/0eb681b)🧩 ![](https://github.com/Krutoy242/mc-icons/raw/master/i/openblocks/tank__0.png "Tank") forbid to pistoning
    > .. since causing crash
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/0d1a821)🧩`Packetfixer` increase packet sizes
    > Should not have changes in game.
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/088d7cc)🪄![](https://github.com/Krutoy242/mc-icons/raw/master/i/thaumcraft/infusion_matrix__0.png "Runic Matrix") fix modifiers
    > > Contributed by [TabakaSIM](https://github.com/tabakasim)
    >
    > Fix missing infusion matrix changed form `thaumtweaks` mod. Now speed and cost moddifier are applied correctly.

  #### Quest

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/1159234)📖Fix finishing game message erroring if you crafted air
    > I dont know how you cafted air 🤷‍♂️
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/01d8ce6)📖Fix players can't achieve `Conflux I` and `V`

## Mods changes

### 🟡 Updated Mods

Icon | Summary | Old / New
----:|:--------|:---------
<img src="https://media.forgecdn.net/avatars/thumbnails/292/428/30/30/637325593905195388.png"            > |                              [**Zen Utils**](https://www.curseforge.com/minecraft/mc-mods/zenutil)                     | <nobr>zenutils-1.26.19</nobr><br><nobr>zenutils-1.27.0</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/468/506/30/30/637752171904887013.jpeg"           > |                       [**Had Enough Items**](https://www.curseforge.com/minecraft/mc-mods/had-enough-items)            | <nobr>HadEnoughItems_1.12.2-4.30.2</nobr><br><nobr>HadEnoughItems_1.12.2-4.30.3</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/551/59/30/30/637888242565991470.png"             > |                              [**ModularUI**](https://www.curseforge.com/minecraft/mc-mods/modularui)                   | <nobr>modularui-3.1.5</nobr><br><nobr>modularui-3.1.6</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/828/846/30/30/638216794274587308.png"            > |                             [**VintageFix**](https://www.curseforge.com/minecraft/mc-mods/vintagefix)                  | <nobr>vintagefix-0.6.2</nobr><br><nobr>vintagefix-0.7.0</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1001/840/30/30/638521728187451529.jpg"           > |           [**Advanced Rocketry - Reworked**](https://www.curseforge.com/minecraft/mc-mods/advanced-rocketry-2)         | <nobr>advancedrocketry-2.2.5hotfix</nobr><br><nobr>advancedrocketry-2.2.6</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1142/718/30/30/638707398997158910_animated.gif"  > | [**Avaritia 1.1x Unofficial Extended Life**](https://www.curseforge.com/minecraft/mc-mods/avaritia-1-1x-unofficial)    | <nobr>avaritia-1.12.2-3.3.0.48-hotfix6</nobr><br><nobr>avaritia-1.12.2-3.3.0.48-hotfix7</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1679/685/30/30/639067599608097833.png"           > |                                 [**Gnetum**](https://www.curseforge.com/minecraft/mc-mods/gnetum)                      | <nobr>gnetum-1.4.0</nobr><br><nobr>gnetum-1.4.1</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1525/899/30/30/638990864881641740.png"           > |                         [**Quantum Things**](https://www.curseforge.com/minecraft/mc-mods/quantum-things)              | <nobr>QuantumThings-MC-1.12.2-1.1.0</nobr><br><nobr>QuantumThings-MC-1.12.2-1.2.0</nobr>
-----------
