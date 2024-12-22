# v1.52.0 (2024-12-16)

## Mods changes
### 🟡 Updated Mods

Icon | Summary | Old / New
----:|:--------|:---------
<img src="https://media.forgecdn.net/avatars/thumbnails/676/130/30/30/638066753607299461.png"            > |                     [**Deep Mob Evolution**](https://www.curseforge.com/minecraft/mc-mods/dme)                         | <nobr>DeepMobEvolution-1.12.2-1.2.2</nobr><br><nobr>DeepMobEvolution-1.12.2-1.2.3</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/868/154/30/30/638282265875005308.png"            > |                 [**Patchouli ROFL Edition**](https://www.curseforge.com/minecraft/mc-mods/patchouli-rofl-edition)      | <nobr>Patchouli-1.0-26</nobr><br><nobr>Patchouli-1.0-27</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1071/348/30/30/638606872011907048.png"           > |              [**Fluid Interaction Tweaker**](https://www.curseforge.com/minecraft/mc-mods/fluid-interaction-tweaker)   | <nobr>fluidintetweaker-1.4.1</nobr><br><nobr>fluidintetweaker-1.5.0</nobr>
-----------

## ✨ New Features

* <img src="https://i.imgur.com/GfowEGq.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/04d38ecf929b9848c6fa72baeb4d6a703dcda696)☁Use ![](https://github.com/Krutoy242/mc-icons/raw/master/i/fluid/ic2construction_foam.png "Construction Foam") in ![](https://github.com/Krutoy242/mc-icons/raw/master/i/advancedrocketry/chemicalreactor__0.png "Crystallizer") for "burn in fluid"
  > > Contributed by [TrashboxBobylev](trashbox.bobylev@gmail.com)
  >
  > - Adds ability to use IC2's construction foam to solidify MA essence and ExNihilo ore pieces using AdvRocketry's Crystallizer into actual ores without using in-world interactions.
  > - Allows to do Knightslime and Obsidian essences transformations with IE Mixer.
* <img src="https://i.imgur.com/taHneAE.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/61d211a9650a551c1b0ef6ba7eabc460b768209e)🎒Add content preview for more items
  > ![](https://github.com/Krutoy242/mc-icons/raw/master/i/spiceoflife/lunchbox__0.png "Lunch Box")![](https://github.com/Krutoy242/mc-icons/raw/master/i/spiceoflife/lunchbag__0.png "Lunch Bag")![](https://github.com/Krutoy242/mc-icons/raw/master/i/travelersbackpack/travelers_backpack__0.png "Traveler's Backpack")![](https://github.com/Krutoy242/mc-icons/raw/master/i/industrialforegoing/mob_imprisonment_tool__0.png "Mob Imprisonment Tool")![](https://github.com/Krutoy242/mc-icons/raw/master/i/enderio/item_soul_vial__0.png "Soul Vial")![](https://github.com/Krutoy242/mc-icons/raw/master/i/scannable/scanner__0.png "Scanner")
* [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/7a9508ec6f7dd8b8085053c15b4a05d0009608c0)🎒Add right-click open capability for +14 items
  > 

## 🐛 Fixes

* [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/3b6b33e66d3a1482b8793692d6a17bc076991199)✏️`Thaumic Worners Stones` make actually unrepearable
  > 
* [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/aefe543f14c6b0dc6399a8ca5ad178edd6213b56)✏️![](https://github.com/Krutoy242/mc-icons/raw/master/i/immersiveengineering/graphite_electrode__0.png "Graphite Electrode") now unbreakable recipe accept repaired electrode
  > 
* [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/20aca0136d90859c8d91dea5bbfeef611a239c02)💙![](https://github.com/Krutoy242/mc-icons/raw/master/i/requious/replicator__0.png "Replicator") increase difficulty on replication x10 more now
  > Before this change, formula was `uuMbConsumed ^ 0.6 / 10000` which was neglible small, unrecognisible value. Now its gonna be `/ 1000` instead.
* [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/492c088af3d8e065c5bc065d4c335196aa8523da)💙![](https://github.com/Krutoy242/mc-icons/raw/master/i/requious/replicator__0.png "Replicator") now correctly counting `Spent UU` stat value
  > Before, stat values changes every secod, using unreasonable values.

#### Balance

* [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/590f6e24f939be8161a7e07f41eb81f9457e1296)✏️![](https://github.com/Krutoy242/mc-icons/raw/master/i/enderio/item_alloy_ingot__5.png "Pulsating Iron Ingot") now not require ![](https://github.com/Krutoy242/mc-icons/raw/master/i/enderio/item_material__75.png "Infinity Reagent")
  > 
* <img src="https://i.imgur.com/4kjDTwg.png" align=right> [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/78784edfd56b88bab22ef69a294ea2e53d7c294d)✏️![](https://github.com/Krutoy242/mc-icons/raw/master/i/enderio/block_decoration3__4.png "Simple Sagmill (decoration block)") nerf `Dirty Ore` output
  > Now output x12 main result and half% of secondary.
  > 
  > Dev note: Sag Mill is extremely fast way to process Dirty ores. It also output a lot of secondary output whick makes other Dirty Ore processing methods futile.

#### Qol

* [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/2aae15f28b26c36a61000baa7b7f9c6cce48390f)✏️add conversion between NC and Mek Hydrogen
  > fix https://github.com/Krutoy242/Enigmatica2Expert-Extended/issues/443
* [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/9444a66804974b8d08ad77d41ea001238aecd0d1)✏️add few recipes to ![](https://github.com/Krutoy242/mc-icons/raw/master/i/extrautils2/machine__0__acc99c9d.png "Crusher") from removed ![](https://github.com/Krutoy242/mc-icons/raw/master/i/actuallyadditions/block_grinder__0.png "Crusher")
  > 

#### Quest

* [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/0d7be6e07effc23b3c47bd686a1b39d8ab2ada51)📖Fix ![](https://github.com/Krutoy242/mc-icons/raw/master/i/ic2/foam_sprayer__0.png "CF Sprayer")![](https://github.com/Krutoy242/mc-icons/raw/master/i/ic2/mining_laser__0.png "Mining Laser") quest tasks
  > 
* [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/43f2b5f6a505d60734174489c7ac3a80e9a3c1f9)📖Remove ![](https://github.com/Krutoy242/mc-icons/raw/master/i/scannable/scanner__0.png "Scanner") from loot box
  > For players not accidentally get difficulty from it



