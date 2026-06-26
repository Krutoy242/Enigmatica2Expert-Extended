## 🐛 Fixes

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/86481c0)✏️Remove Advanced Ring Baubles since new fork handle them
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/4c3c9f3)🔨Return accidentally removed "vaporizer" trait from `Demonic Metal`
    > related 53e234bf245a1aae050c50356ed57354c94c1235
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/c8c5c63)🟠Undo migration `mct_immersivetechnology`
    > There is a bug that breaking LittleTiles inventories.
    > 
    > More info: https://github.com/tgstyle/MCT-Immersive-Technology/issues/319
    > 
    > related: 7147d0899fe54be8f621af919972921a13c43a61

## Mods changes
### 🟢 Added Mods

Icon | Summary | Reason
----:|:--------|:-------
<img src="https://media.forgecdn.net/avatars/thumbnails/235/613/30/30/637086790793528636.png"            > |                        [**Immersive Posts**](https://www.curseforge.com/minecraft/mc-mods/immersiveposts)               <sup><sub>ImmersivePosts-0.2.1.jar                         </sub></sup><br>Extendable treated-wood, aluminium, steel posts and more for ImmersiveEngineering. | Decoration asked in Discord
<img src="https://media.forgecdn.net/avatars/thumbnails/1863/769/30/30/639169880065855019.png"           > |                       [**Possibly Baubles**](https://www.curseforge.com/minecraft/mc-mods/possibly-baubles)             <sup><sub>possiblybaubles-1.0.1.jar                        </sub></sup><br>Adds Baubles support for Actually Additions items. | No more ring duplicates
-----------


### 🔴 Removed Mods

Icon | Summary | Reason
----:|:--------|:-------
<img src="https://media.forgecdn.net/avatars/thumbnails/147/192/30/30/636575169522401760.png"            > |                       [**Actually Baubles**](https://www.curseforge.com/minecraft/mc-mods/actually-baubles)             <sup><sub>ActuallyBaubles-1.12-1.1.jar                     </sub></sup><br>Baubles capability for some Actually Additions gadgets! | Replaced by `Possibly Baubles`
-----------

### 🟡 Updated Mods

Icon | Summary | Old / New
----:|:--------|:---------
<img src="https://media.forgecdn.net/avatars/thumbnails/1379/566/30/30/638894913493014322.png"           > |                   [**Immersive Technology**](https://www.curseforge.com/minecraft/mc-mods/mct-immersive-technology)    | <nobr>`MCT-ImmersiveTechnology-1.12.2-1.10.197-release`</nobr><br><nobr>`MCTImmersiveTechnology-1.12.2-1.9.102`</nobr><br><details><summary>Changelog ↓↓↓↓</summary><div><b>MCT-ImmersiveTechnology-1.12.2-1.10.184-release</b><br><p>&nbsp;- Belt optimization enabled by default (mct_mixin.cfg) DISABLE IF HAVING ISSUES<br>&nbsp;- Belts fully idle when no items/entites are on them after 2 seconds<br>&nbsp;- Belts now stay visually active for 2 seconds when items/entites pass over them (even without redstone)<br>&nbsp;- Massive reduction in duplicated code through clean inheritance hierarchy (easier updates &amp; bug fixes)<br>&nbsp;- All conveyor types now share consistent item handling (10-tick pickup delay + no-despawn logic)<br>&nbsp;- Covered conveyors now have unified, reliable collision &amp; selection boxes (horizontal + sloped)<br>&nbsp;- Covered variants properly render walls and supports<br>&nbsp;- Extractor arm now visually extends/retracts based on target block distance (up to 4 pixels)<br>&nbsp;- Split conveyor now has reliable alternating output + redstone pulse toggle mode (SPLIT / ALL LEFT / ALL RIGHT)<br>&nbsp;- Split redirection uses per-entity NBT for stable splitting behavior (no more lost items)<br>&nbsp;- Drop conveyors improved insertion detection and trapdoor compatibility<br>&nbsp;- Vertical conveyors now correctly render bottom belt/wall connections when appropriate<br>&nbsp;- Vertical upward push logic refined for smoother entity movement and better centering<br>&nbsp;- All covered variants (including vertical &amp; extract) now visually connect properly to adjacent blocks<br>&nbsp;- Consistent magnet suppression / reversion logic across all types prevents item glitches<br>&nbsp;- Better redstone interaction on extractors (unpowered = active extraction)<br>&nbsp;- Player sneaking now reliably stops movement on all conveyors<br>&nbsp;- Improved model cache keys include dye, cover, direction, activity, and extension state</p> <p>Changelog:</p> <p>&nbsp;- Fix CME mixin for Cleanroom again<br>&nbsp;- Fix High Pressure Steam Turbine not rendering rotor<br>&nbsp;- Add AdvanceCokeOven to CokeOven JEI tab<br>&nbsp;- Fixes for extract conveyors<br>&nbsp;- Idle belt entirely when not doing work<br>&nbsp;- Activate belts when entities are on them<br>&nbsp;- Fix excessive model update calls<br>&nbsp;- Add additional features to conveyors<br>&nbsp;- Conveyor optimizations<br>&nbsp;- Fix mixin not applying to split conveyor<br>&nbsp;- Initial commit of optimized conveyors<br>&nbsp;- Build cleanup<br>&nbsp;- Quick formatting fixes<br>&nbsp;- Fix OptiPNG to only run on JAR build<br>&nbsp;- Remove IF from crucible JEI<br>&nbsp;- Missed one for OptiPNG<br>&nbsp;- OptiPNG run<br>&nbsp;- Fix base heater IF value in manual</p></div><hr/><div><b>MCT-ImmersiveTechnology-1.12.2-1.10.192-release</b><br><p>Changelog:<br>&nbsp;- OptiPNG do not apply lossless<br>&nbsp;- Re-work sounds, this fixes some playing when not active<br>&nbsp;- Mixin to fix IE wire rendering<br>&nbsp;- Re-run less aggressive OptiPNG on all textures</p></div><hr/><div><b>MCT-ImmersiveTechnology-1.12.2-1.10.195-release</b><br><p>Changelog:</p> <p>&nbsp;- Release build 195 - 1.12.2 is now feature complete, maintenance only<br>&nbsp;- Various language file fixes<br>&nbsp;- Fix baseheater sound keeps playing after finished</p></div><hr/><div><b>MCT-ImmersiveTechnology-1.12.2-1.10.197-release</b><br><p>Changelog:</p> <p>- Fix item interaction on the stack limiter<br>- Add 4th mode to splitter conveyor it now does both/left/right/stop with redstone pulse<br>- Extract conveyor should not go angled<br>- Dropping conveyor should not rotate vertical</p></div></details>
-----------
