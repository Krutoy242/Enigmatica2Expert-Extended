# do/portal_spread.zs

![Portal Spreading](https://i.imgur.com/b1ChXXH.gif)

## 📖 Description

Introducing the enhanced version of the [Nether Portal Spread](https://www.curseforge.com/minecraft/mc-mods/nether-portal-spread) mod, rewritten in ZenScript with numerous new features and significant performance improvements.

## ✨ Features

Retaining all the beloved features of the original **Nether Portal Spread** mod:

- Nether portals spread Nether blocks to the Overworld within a configurable radius.
- By default, the spread can be halted by placing four coal blocks **in the corners**.
- Players receive notifications when the spread effect initiates or is prevented.

**Exciting New Features:**

- ### ⚡ Incredible Performance
  > * Operates approximately x1000 times faster due to advanced algorithms.
  > * Construct 100 or more portals with negligible server TPS impact.

- ### ✨ Enhanced Block Replacement Mechanic
  > Blocks retain their state during replacement — stone stairs become Nether Brick stairs, preserving their orientation.  
  > ![Blocks keep their state](https://i.imgur.com/I07FGF4.png)

- ### 💬 Informative Chat Messages
  > * With Quark installed, block icons appear in chat upon portal creation.  
  >   ![Portal Creation chat message](https://i.imgur.com/zilMMrM.png)
  >
  > * Interact with portals to view their speed and radius.  
  >   ![Portal touch info](https://i.imgur.com/2dJ9hmI.png)
  >
  > * Modify portal power with different corner blocks.  
  >   ![Message on changing blocks](https://i.imgur.com/ibAWNk7.png)
  >
  > * Holding `Flint And Steel` reveals portal particles.  
  >   ![Portal pulsation](https://i.imgur.com/wd3f25C.gif)

- ### 🔥 Advanced Modifiers
  > * Any modded coal in the `ore:blockCoal` oredict can halt the portal, configurable in the settings.  
  >   ![Blocks on corners](https://i.imgur.com/YkB4to9.png)
  >
  > * Special blocks can increase the portal's speed and radius.  
  >   ![Larger radius](https://i.imgur.com/VxKs9Yg.png)

- ### 📜 JEI Integration
  > Default and custom recipes are listed in JEI (requires additional configuration).  
  > ![JEI tab with recipes](https://i.imgur.com/cfriBvm.png)

- ### 🌐 Multilingual Support
  > Available in *Russian* and *Simplified Chinese*, with the option to add more languages.  
  > ![Chinese message](https://i.imgur.com/hTHKuSD.png)

- ### 🛠️ OP Command `/portal_spread <status|debug|faster|slower>`
  > Manage portal states, debug issues, or adjust speed for testing purposes.  
  > ![Debug information](https://i.imgur.com/TV5DtSU.png)

## 🚀 Installation

1. Ensure you're running Minecraft version `1.12.2`.

2. Install the following mods:
    - [CraftTweaker](https://www.curseforge.com/minecraft/mc-mods/crafttweaker)
    - [Zen Utils](https://www.curseforge.com/minecraft/mc-mods/zenutil)
    - [Resource Loader](https://www.curseforge.com/minecraft/mc-mods/resource-loader)
    - [Requious Frakto](https://www.curseforge.com/minecraft/mc-mods/requious-frakto) (optional, for JEI support)

3. Download the `do/portal_spread` `.zip` file from the CurseForge page.

4. Place the downloaded file into your `.minecraft/` directory and unzip it.

The `do/portal_spread` archive contains CraftTweaker scripts for all spreading logic and configurations, as well as resource files for localizations.

## 🤝 Compatibility

`do/portal_spread` is designed to be compatible with a multitude of mods, seamlessly integrating modded blocks into the portal's spread behavior.

Supported mods include:

- Actually Additions
- Additional Compression
- Advanced Rocketry
- Applied Energistics 2
- Astral Sorcery
- Biomes O' Plenty
- Botania
- Chisel
- Dark Utilities
- Ex Compressum
- Ex Nihilo Creatio
- Extra Utilities 2
- Floralchemy
- Forestry
- Ice and Fire
- Immersive Engineering
- Mystical Agriculture
- Netherending Ores
- NuclearCraft
- Quark
- Rats
- Rustic
- Sonar Core
- Tinkers' Construct
- Thaumcraft
- Thermal Foundation
- Twilight Forest

...and maybe more!

## ⚙️ Configuration

Customize portal spread settings such as maximum radius in the `scripts/do/portal_spread/config.zs` file.

![Configuration preview](https://i.imgur.com/dAutk0j.png)

You can also modify these values from any other script in your `scripts/` folder. Remember to set a high `#priority` value.

```swift
// Priority lower than config.zs but higher than any other scripts in portal_spread/
#priority 4400

import scripts.do.portal_spread.config.Config;

// Set the default maximum radius for portal spread
Config.defaultRadius = 32;

// Increase the portal spread speed by a factor of four
Config.spreadDelay = 0.25;
```

### 📖 JEI Recipe Integration

To add JEI recipe support, refer to the instructions in the header comment of the `scripts/do/portal_spread/requious.zs` file. This will enable players to view both default and custom recipes directly within the JEI interface, streamlining their gameplay experience.

### 🛠️ Custom Recipe Creation

Adding custom recipes to your portal spread is straightforward. Begin by importing the `spread` class instance from `scripts.do.portal_spread.recipes.spread` and utilize the `set()` or `setAll()` functions:

- **`set(dimFrom, dimTo, blockFrom, blocksTo, fallback = null)`**
  - `dimFrom`: The dimension ID from which the portal originates.
  - `dimTo`: The dimension ID to which the portal leads.
  - `blockFrom`: The block state(s) to be converted. Requires an exact match.
  - `blocksTo`: An array of potential output block states. Each subsequent block has a roughly 1/3 chance compared to the previous one. For example, `[A, B]` results in `A` 75% of the time and `B` 25% of the time. A list like `[A, B, C, D]` would distribute as `[44%, 31%, 19%, 6%]`.
  - `fallback`: An array of fallback block states used if `blocksTo` is empty or contains only `null` values. This is useful for cross-modpack compatibility, defaulting to vanilla blocks when certain mods are not installed.

- **`setAll([same params as set()])`**
  - Functions similarly to `set()`, but matches based on BlockID rather than exact `IBlockState`. For instance, `<blockstate:minecraft:stone>` matches Stone as well as its variants like Diorite and Andesite.

**🛈 Notes:**

- Both `set()` and `setAll()` methods can be chained, e.g., `spread.set([...]).setAll([...]);`.
- Use `setNether([...])` and `setNetherAll([...])` for convenience functions that default `dimFrom` and `dimTo` to `0` and `-1` respectively, representing Vanilla *Overworld* to *The Nether* portals.

**🧪 Example:**

```ts
import scripts.do.portal_spread.recipes.spread;

spread

// Convert various Overworld terrain blocks into Netherrack and Quartz Ore
.setAllNether([
  <blockstate:minecraft:grass>,
  <blockstate:minecraft:dirt>,
  <blockstate:minecraft:farmland>,
  <blockstate:minecraft:stone>,
], [
  <blockstate:minecraft:netherrack>,
  <blockstate:minecraft:quartz_ore>,
])

// Convert only Mossy Cobblestone into Magma
.setAllNether([
  <blockstate:minecraft:mossy_cobblestone>,
], [<blockstate:minecraft:magma>])

// Maintain slab properties when converting Stone Slabs to Nether Brick Slabs
.setNether([
  <blockstate:minecraft:stone_slab:half=bottom,variant=stone_brick>,
  <blockstate:minecraft:stone_slab:half=bottom,variant=stone>,
], [<blockstate:minecraft:stone_slab:half=bottom,variant=nether_brick>])
.setNether([
  <blockstate:minecraft:stone_slab:half=top,variant=stone_brick>,
  <blockstate:minecraft:stone_slab:half=top,variant=stone>,
], [<blockstate:minecraft:stone_slab:half=top,variant=nether_brick>])
;
```

#### Helper stick

Creating custom recipes is a breeze with the in-game recipe editor. While in creative mode, use the following command to obtain a special stick for recipe creation:

```d
/give @p stick 1 0 {}
```

- Hold `[Shift]` and `[Right-click]` to select one or multiple **input** block states.
- Simply `[Right-click]` to select one or multiple **output** block states.
- `[Left-click]` to **finalize** the recipe by adding the block as an output.

The newly created recipe will be output to the `crafttweaker.log` file. You can then incorporate it into the `scripts/do/portal_spread/recipes.zs` file or any other script within your `scripts/` directory.

## 📜 License

This project is released under the MIT License, granting you the freedom to use, modify, and distribute the mod as you see fit, provided that credit is given to the original author [Krutoy242](https://github.com/Krutoy242).

<!-- Publish script:

& "C:/Program Files/WinRAR/Rar.exe" a -r dev/~dist/portal_spread-v1.0.0.zip scripts/do/portal_spread/*.zs resources/portal_spread

-->
