> [!IMPORTANT]
> ⚠️ This update downgrade NoiseThreader to fix worldgen crash happening from `v1.62.0`.

## 🐛 Fixes


  #### Balance

  * <img src="https://i.imgur.com/IWvnWgA.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/73522e8)🌆Add Lumenized glow for ![](https://github.com/Krutoy242/mc-icons/raw/master/i/minecraft/sand__0.png "Radioactive Sand") and ![](https://github.com/Krutoy242/mc-icons/raw/master/i/nuclearcraft/wasteland_earth__0.png "Radioactive Wasteland Earth")
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/0387d0b)⌛![](https://github.com/Krutoy242/mc-icons/raw/master/i/advancedrocketry/vitrifiedsand__0.png "Vitrified Sand") now drops more isotopes
    > Now drop list is: ![](https://github.com/Krutoy242/mc-icons/raw/master/i/qmd/isotope__5.png "Protactinium-231 Dust")![](https://github.com/Krutoy242/mc-icons/raw/master/i/qmd/isotope__1.png "Beryllium-7")![](https://github.com/Krutoy242/mc-icons/raw/master/i/qmd/isotope__0.png "Sodium-22")
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/f23abd9)🌆Optimize png images
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/2b1052a)🌆Prune screenshots slideshow from outdated ones
    > And reduce quality of the rest.
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/3771901)🌞Force java profiler for `Flare`
    > Fix https://github.com/Krutoy242/Enigmatica2Expert-Extended/issues/518
  * <img src="https://i.imgur.com/0W2z9Mq.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/66ecb8d)🎒Traveler's Backpack place near Tomb on death
    > Now Backpack will always be placed near the Tomb on player death.  
    > This is also remove bansoukou patch.
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/0b601ea)🐦Fix mekanism rare block name crash
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/3f5663f)👑Add `Omnipotence` when player start game on Asteroid Belt or a planet
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/8a45df9)👑Fix `Omnipotence` do not silk touch TileEntities
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/b69f09a)🔌Make ![](https://github.com/Krutoy242/mc-icons/raw/master/i/forestry/propolis__0.png "Propolis") unreplicable
    > Propolis was unable to be scanned correctly
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/2ba6446)🤹‍♂️Fix experience orbs becoming too big
    > No more orbs with a size larger than planet.
  * <img src="https://i.imgur.com/zimGGda.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/7a7afc1)✏️![](https://github.com/Krutoy242/mc-icons/raw/master/i/actuallyadditions/item_crate_keeper__0.png "Storage Crate Keeper") cheaper
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/ed16726)🚀Fix entity render in `Asteroid Belt`
    > Related https://github.com/dercodeKoenig/AdvancedRocketry/issues/62
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/94f413a)🟡Remove `File Director` from the server
    > Since only used for clientside Optifine

  #### WIP

  * <img src="https://i.imgur.com/RFl3Afm.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/f693715)🌌![](https://github.com/Krutoy242/mc-icons/raw/master/i/appliedenergistics2/material__47.png "Singularity") craft almost any AE2 component
    > Place Singularity with one of QMD isotope ![](https://github.com/Krutoy242/mc-icons/raw/master/i/qmd/isotope__5.png "Protactinium-231 Dust")![](https://github.com/Krutoy242/mc-icons/raw/master/i/qmd/isotope__1.png "Beryllium-7")![](https://github.com/Krutoy242/mc-icons/raw/master/i/qmd/isotope__0.png "Sodium-22") to craft almost any possible AE2 item.  
    > This mechanic have no practicle use right now, but will be used in endgame later.

  #### Worldgen

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/dc92e47)🌍`Asteroid Belt` add bedrock generation
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/4ea9b7e)🌍`Asteroid Belt` change gravitation
  * <img src="https://i.imgur.com/bR1DH93.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/568b9db)🌍`Asteroid Belt` move closer to the black hole

## Mods changes
### 🟢 Added Mods

Icon | Summary | Reason
----:|:--------|:-------
<img src="https://media.forgecdn.net/avatars/thumbnails/16/243/30/30/635643468531367733.png"             > |                  [**Custom Loading Screen**](https://www.curseforge.com/minecraft/mc-mods/better-loading-screen)        <sup><sub>CustomLoadingScreen-1.12.2-1.5.9.jar             </sub></sup><br>Allows you to completly customise the loading screen with json files. (Formally Better Loading Screen) | CLS already configured for E2EE long time ago but wasnt used because of [this issue](https://github.com/AlexIIL/CustomLoadingScreen/issues/74). Since most players using Cleanroom already, lets test if issue still actual.
-----------

### 🟡 Updated Mods

Icon | Summary | Old / New
----:|:--------|:---------
<img src="https://media.forgecdn.net/avatars/thumbnails/142/108/30/30/636546700830987709.png"            > |                           [**CraftTweaker**](https://www.curseforge.com/minecraft/mc-mods/crafttweaker)                | <nobr>CraftTweaker2-1.12-4.1.20.705</nobr><br><nobr>CraftTweaker2-1.12-4.1.20.707</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1362/814/30/30/638885115958149175.png"           > |                           [**PackagedAuto**](https://www.curseforge.com/minecraft/mc-mods/packagedauto)                | <nobr>PackagedAuto-1.12.2-1.0.19.66</nobr><br><nobr>PackagedAuto-1.12.2-1.0.21.68</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1362/816/30/30/638885116793099467.png"           > |                     [**PackagedExCrafting**](https://www.curseforge.com/minecraft/mc-mods/packagedexcrafting)          | <nobr>PackagedExCrafting-1.12.2-1.0.2.31</nobr><br><nobr>PackagedExCrafting-1.12.2-1.0.3.32</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/292/428/30/30/637325593905195388.png"            > |                              [**Zen Utils**](https://www.curseforge.com/minecraft/mc-mods/zenutil)                     | <nobr>zenutils-1.25.4</nobr><br><nobr>zenutils-1.25.5</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/544/923/30/30/637877302202441012.png"            > |                              [**Atlas Lib**](https://www.curseforge.com/minecraft/mc-mods/atlas-lib)                   | <nobr>Atlas-Lib-1.12.2-1.1.8</nobr><br><nobr>Atlas-Lib-1.12.2-1.1.8a</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1363/536/30/30/638885540715738013.png"           > |                         [**PackagedAstral**](https://www.curseforge.com/minecraft/mc-mods/packagedastral)              | <nobr>PackagedAstral-1.12.2-1.0.3.21</nobr><br><nobr>PackagedAstral-1.12.2-1.0.4.22</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1363/379/30/30/638885462388978264.png"           > |                       [**PackagedDraconic**](https://www.curseforge.com/minecraft/mc-mods/packageddraconic)            | <nobr>PackagedDraconic-1.12.2-1.0.3.23</nobr><br><nobr>PackagedDraconic-1.12.2-1.0.4.24</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/937/632/30/30/638416090890641368.png"            > |            [**Thaumic Tinkerer Unofficial**](https://www.curseforge.com/minecraft/mc-mods/thaumic-tinkerer-unofficial) | <nobr>thaumictinkerer-1.12.2-5.9.8-Unofficial</nobr><br><nobr>thaumictinkerer-1.12.2-5.9.10-Unofficial</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1040/744/30/30/638566774921391570.png"           > |               [**Magiculture Integrations**](https://www.curseforge.com/minecraft/mc-mods/magiculture-integrations)    | <nobr>magicultureintegrations-1.12.2-2.2.4</nobr><br><nobr>magicultureintegrations-1.12.2-2.2.5</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1111/53/30/30/638662497025737758.png"            > |                        [**Patchouli Books**](https://www.curseforge.com/minecraft/mc-mods/patchouli-books)             | <nobr>patchoulibooks-0.2.5</nobr><br><nobr>patchoulibooks-0.2.6</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1128/28/30/30/638686145366913611.jpg"            > |                            [**Curvy Pipes**](https://www.curseforge.com/minecraft/mc-mods/curvy-pipes)                 | <nobr>curvy_pipes-1.12.2-1.12.1</nobr><br><nobr>curvy_pipes-1.12.2-1.12.4</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1130/663/30/30/638689855192047243.png"           > |                          [**NoiseThreader**](https://www.curseforge.com/minecraft/mc-mods/noisethreader)               | <nobr>NoiseThreader-1.1.1</nobr><br><nobr>NoiseThreader-1.0.0</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1134/796/30/30/638695730831585929.png"           > |[**Extended Crafting Terminals for Applied Energistics 2**](https://www.curseforge.com/minecraft/mc-mods/extended-crafting-terminals-for-applied)| <nobr>ae2exttable-v1.0.7</nobr><br><nobr>ae2exttable-v1.0.8</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1176/204/30/30/638748608591942674.png"           > |                       [**RandomComplement**](https://www.curseforge.com/minecraft/mc-mods/random-complement)           | <nobr>random_complement-1.5.5</nobr><br><nobr>random_complement-1.5.7</nobr>
-----------
