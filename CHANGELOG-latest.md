## ⚡ Performance Improvements

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/ccb74e5)⚡Cache `CyclopsCore` classloader environment check
    > Integrated Dynamics cables wasted up to 19% of server tick re-checking the JVM classloader every tick; now the check runs only once.

## 🐛 Fixes

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/ba80820)⛏️Fix chat error on killing in Glitch armor
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/383574d)✏️Purge ![](https://cdn.jsdelivr.net/gh/Krutoy242/mc-icons@master/i/harvestcraft/greengrapeitem__0.png "Green Grape") completely remove from game, closes #632
    > Green Grapes were partially removed from garden drops in 65f84ce but the item and seed were still obtainable. Now fully purged with oredicts and related configs, matching the treatment of other Pam's replacement items.
    > 
    > Fixes #632
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/822b9db)🎒Fix debug.log error spam
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/2e71b1f)💣![](https://cdn.jsdelivr.net/gh/Krutoy242/mc-icons@master/i/draconicevolution/mob_soul__0__5658348b.png "Creeper Soul") Explosion Strength 2->3
    > > Contributed by [ImNotEvenAngry](https://github.com/imnotevenangry)
    >
    > A creeper explosion has a power of 3 and a tnt explosion has a power of 4. The CreeperTrophy explosion has a power of 2, which is not sufficient enough to break the Basic Machine Casing, the Steel Casing, or the Advanced Machine Casing. This mixin simply increases the explosion power from 2 to 3, which will convert these casings into the appropriate machine parts.
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/48b641c)🔵Migrate legendarytooltips -> Obscure Tooltips
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/269d6f2)🔵Migrate to ThaumicInfo
    > Fix https://github.com/Krutoy242/Enigmatica2Expert-Extended/issues/630
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/1494d63)🔵Reconfigure Cleanroom Relauncher

  #### Configs

  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/3fb8ff2)🧩Replace ic2 fix `stellar_core`->`ic2-patcher`
    > Im not sure if this help to fix "IC2 cables disconnect" issue but we should at least try.
    > 
    > Related: https://github.com/Krutoy242/Enigmatica2Expert-Extended/issues/454
  * [🖇](https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/dbe8e07)🛸![](https://cdn.jsdelivr.net/gh/Krutoy242/mc-icons@master/i/enderio/block_alloy_smelter__0.png "Alloy Smelter") increase speed x2

## Mods changes
### 🟢 Added Mods

Icon | Summary | Reason
----:|:--------|:-------
<img src=""                                                                                              > |                       [**Obscure Tooltips**](https://www.curseforge.com/minecraft/mc-mods/obscure-tooltips)             <sup><sub>obscure_tooltips-forge-1.12.2-3.10.1.jar         </sub></sup><br>Stylized tooltips with beautiful effects and smooth animations! | Sounds better than LegendaryTooltips
<img src="https://media.forgecdn.net/avatars/thumbnails/1890/81/30/30/639182442226366058.png"            > |                    [**Thaumic Information**](https://www.curseforge.com/minecraft/mc-mods/thaumic-roid)                 <sup><sub>thaumicinfo-1.1.2.jar                            </sub></sup><br>Thaumic JEI + ThaumicWaila + VisualOres integration + performance | Better than Thaumic JEI
-----------


### 🔴 Removed Mods

Icon | Summary | Reason
----:|:--------|:-------
<img src="https://media.forgecdn.net/avatars/thumbnails/138/833/30/30/636524375193820008.png"            > |                            [**Thaumic JEI**](https://www.curseforge.com/minecraft/mc-mods/thaumic-jei)                  <sup><sub>ThaumicJEI-1.12.2-1.7.0.jar                      </sub></sup><br>A JEI addon for thaumcraft 6 | Replaced by Thaumic Information
<img src="https://media.forgecdn.net/avatars/thumbnails/438/697/30/30/637684634562173457.png"            > |         [**Legendary Tooltips [Neo/Forge]**](https://www.curseforge.com/minecraft/mc-mods/legendary-tooltips)           <sup><sub>LegendaryTooltips-1.12.2-1.1.11.jar              </sub></sup><br>Give your rare items a fancier tooltip!  Also adds additional tooltip configuration options. | Replaced by Obscure Tooltips
-----------

### 🟡 Updated Mods

Icon | Summary | Old / New
----:|:--------|:---------
<img src="https://media.forgecdn.net/avatars/thumbnails/252/7/30/30/637186307688060793.png"              > |                            [**A Dark Mode**](https://www.curseforge.com/minecraft/texture-packs/minecraft-dark-mode-mod-support)| <nobr>`Dark Mode-2.5.0.zip`</nobr><br><nobr>`Dark Mode-2.5.1.zip`</nobr><br><details><summary>Changelog ↑</summary><p>2.5.1: Added Support for:</p> <ul> <li>AE2 ModID View Cell</li> <li>AE2 PowerTools</li> <li>C.E.L.L.S</li> <li>Custom NPCs</li> <li>Techguns CE (partially, see <a href="https://github.com/TheSlize/Techguns2-Completion-Update/issues/59" target="_blank" rel="nofollow">TheSlize/Techguns2-Completion-Update#59</a></li> </ul> <p>Fixed:</p> <ul> <li>AE2UELWirelessUniversalTerminal button background</li> <li>AE2 Crafting Tree - Legacy</li> <li>Update AE2</li> <li>Update EnderCode</li> <li>Update EnderIO</li> <li>Update QMD</li> <li>Update Requious Frakto</li> </ul></details>
<img src="https://media.forgecdn.net/avatars/thumbnails/273/618/30/30/637255642042590715.png"            > |                     [**Tinkers' Evolution**](https://www.curseforge.com/minecraft/mc-mods/tinkers-evolution)           | <nobr>`tconevo-1.12.2-1.1.6`</nobr><br><nobr>`tconevo-1.12.2-1.1.7`</nobr><br><details><summary>Changelog ↑</summary><ul> <li>Fixed materials with overlapping recipes not producing Tinkers' Evolution tool parts (e.g. Natura nether wood ingredients making vanilla wood parts)</li> </ul></details>
<img src="https://media.forgecdn.net/avatars/thumbnails/312/949/30/30/637407315722572617.png"            > |                            [**MixinBooter**](https://www.curseforge.com/minecraft/mc-mods/mixin-booter)                | <nobr>`!mixinbooter-10.7`</nobr><br><nobr>`!mixinbooter-11.1`</nobr><br><details><summary>Changelog ↑↑</summary><div><b>!mixinbooter-11.1</b><br><h3>Fixed</h3><br><ul><li>Compatibilities with older minecraft versions</li></ul><br><h3>Changed</h3><br><ul><li>To have more robust suppression of class reading errors presented by Forge</li></ul><br><b>Full changelog between 11.0 and 11.1</b>: https://github.com/CleanroomMC/MixinBooter/compare/11.0...11.1</div><hr/><div><b>!mixinbooter-11.0</b><br><h3>Added</h3> <ul> <li>Allowing traditional <code>MixinConfigs</code> &amp; <code>MixinConnector</code> way of registering mixins once again</li> <li>Suppression of &quot;corrupt zip&quot; warnings from Forge when reading mods and parsing data</li> <li>Mod discovery (properly done). Accessible via <code>ModDiscoverer</code></li> <li>Way to resolve mod ids in a more correct and explicit manner</li> <li>Dedicated mixin logging output: <code>/logs/mixinbooter.log</code></li> <li>Configuration for various mixin flags and audit file</li> <li>Class-loading now traceable, helps with certain mixins trying to mixin classes that are loaded too early, good way to debug this issue</li> <li>Better testing within the workspace</li> <li>Warnings of mods shading mixins into their own jar file</li> <li>Documentation</li> </ul> <h3>Changed</h3> <ul> <li>CleanMix! Bridged the gap, CleanMix will be used in Cleanroom (as it updates soon tm)</li> <li>Deprecated early/mixin loading stages, division is no longer present</li> <li>Deprecated loader, hijacker interfaces</li> <li>Included annotation processor dependencies for maven artifact</li> <li>Better &quot;mod is present&quot; checks</li> <li>Phasing out mixin &quot;phases&quot;, configs gets immediately selected and processed</li> </ul> <h3>Removed</h3> <ul> <li>Explicit mod fixes</li> </ul></div></details>
<img src="https://media.forgecdn.net/avatars/thumbnails/920/586/30/30/638384165625905095.png"            > |                [**籁/Sound Physics Remixin**](https://www.curseforge.com/minecraft/mc-mods/sound-physics-remixin)       | <nobr>`soundphysics-1.2.0`</nobr><br><nobr>`soundphysics-1.2.1`</nobr><br><details><summary>Changelog ↑</summary><ul> <li>Should fix all sounds have no reverb</li> </ul></details>
<img src="null"                                                                                          > |                                  [**ARLib**](https://www.curseforge.com/minecraft/mc-mods/arlib)                       | <nobr>`libvulpes-0.5.4`</nobr><br><nobr>`libvulpes-0.5.5`</nobr><br><details><summary>Changelog ↑</summary><div> <pre>0.5.5<br>  - Holo-Projector: <br>    - Clear ghostblocks when opening GUI<br>    - Tooltip overhaul</pre> </div></details>
<img src="https://media.forgecdn.net/avatars/thumbnails/1193/283/30/30/638768621890000641.png"           > |                   [**Cleanroom Relauncher**](https://www.curseforge.com/minecraft/mc-mods/cleanroom-relauncher)        | <nobr>`!cleanroom-relauncher-0.5.0`</nobr><br><nobr>`!cleanroom-relauncher-0.6.1`</nobr><br><details><summary>Changelog ↑↑</summary><div><b>!cleanroom-relauncher-0.6.1</b><br><h3>Changed</h3> <ul> <li>Stopped shading in <code>com.google.code.gson</code> in relauncher</li> <li>Shade in <code>org.apache.commons.compress</code> version <code>1.28.0</code> to avoid issues</li> </ul></div><hr/><div><b>!cleanroom-relauncher-0.6.0</b><br><h3>Added</h3> <ul> <li>Download hash validation for Cleanroom packs and libraries</li> <li>Configuration options to clear the relauncher cache folder and provisioned Java folder</li> <li>Option to disable querying GitHub for release updates</li> </ul> <h3>Fixed</h3> <ul> <li>Incompatibility with new file names</li> <li>Update notification behavior to avoid redundant prompts</li> <li>Redundant release/config save calls during relaunch setup</li> <li>Temurin vendor matching/internal naming</li> </ul> <h3>Changed</h3> <ul> <li>Reworked Java provisioning to use JavaUtils'S provisioning APIs</li> <li>Improved cache deletion by walking files safely before removal</li> <li>Added network timeouts and request headers when querying GitHub releases</li> </ul></div></details>
<img src="https://media.forgecdn.net/avatars/thumbnails/1525/899/30/30/638990864881641740.png"           > |                         [**Quantum Things**](https://www.curseforge.com/minecraft/mc-mods/quantum-things)              | <nobr>`QuantumThings-MC-1.12.2-1.2.2`</nobr><br><nobr>`QuantumThings-MC-1.12.2-1.3.0`</nobr><br><details><summary>Changelog ↑</summary><ul> <li>Added the ability to configure whether Custom Workbenches should be disabled. (<a href="https://github.com/MagicJinn/Quantum-Things/pull/60" rel="nofollow">courtesy of Bronitt</a>)</li> </ul> <h3>Fixes</h3> <ul> <li>Fixed Plains biome generating in the Spectre dimension instead of the Spectral biome.</li> <li>Possibly fixed Spectre Illuminators randomly disabling themselves after reload/relog.</li> <li>Optimized some worldgen features to be more performant, specifically in regards to lighting calculations.</li> <li>Fixed a Redstone Observer crash when writer was null.</li> </ul></details>
<img src="https://media.forgecdn.net/avatars/thumbnails/1816/124/30/30/639147876630578376.png"           > |   [**Actually Additions V2 Coffee Edition**](https://www.curseforge.com/minecraft/mc-mods/actually-additions-v2-coffee-edition)| <nobr>`ActuallyAdditions-1.12.2-r155`</nobr><br><nobr>`ActuallyAdditions-1.12.2-r156`</nobr>
<img src="https://media.forgecdn.net/avatars/thumbnails/1864/439/30/30/639170258672343017.png"           > |             [**Requious Frakto Unofficial**](https://www.curseforge.com/minecraft/mc-mods/requious-frakto-unofficial)  | <nobr>`requious-0.13`</nobr><br><nobr>`requious-0.14`</nobr><br><details><summary>Changelog ↑</summary><p>Fix NPE with IC2 integration and Nuclear Craft mechanisms</p></details>
-----------
