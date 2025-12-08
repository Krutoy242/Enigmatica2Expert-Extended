# TODO

## Recent tasks 🚧✅❌⚠️♻️

### 🐛 Bugfixes

- [ ] 🐛 Fix Harvest Levels not working for non-"stone" material
- [ ] ✏️ Collector (on Tinkers at least) stops Axing trait from working (and possibly more traits that change the block you mine)
- [ ] ✏️ No recipe in Chemical Dissolution Chamber: Dirty Copper, Silver, Tin, Iron, Gold, Lead, Osmium
- [ ] ✏️ `Bone` fix crush -> melt -> cast dupe
- [ ] 🐛 Custom beacons not working on server

### ✨ New features

- [ ] `Butterfly` => `Wasp` in witch water
- [ ] Make `Quantum Armor` Tinker's alternative or add Airtight Seal book add to it
- [ ] Remove any kind of shears from game so players use Kama
- [ ] Remap `thermalexpansion.Enchanter` recipes since no one using them
- [ ] ✏️ for `Invar` recipe to replace ingot to dust in ArcFurnace
- [ ] 🟣 Migrate to Bansoukou 6
- [ ] ✏️ `Redstone Cable` harder recipe
- [ ] 🤖 Nanomachines give next levels of potions
- [ ] ✏️ Add `Upgrade, Chest, Backpack, Tank, Generator, Miner` Singularities
- [ ] ✏️ Return Tungsten Blocks for High-pressure turbines
- [ ] 🟢 Migrate from `UniDict` to `OnlyOneItem`
- [ ] 🧱 Automatically interactive-rebase
- [ ] 🖼️ Use `Legendary Tooltips` to mark harvest levels
- [ ] 🧶 make some ores / materials only harvestable with `Gluon Gun`
- [ ] ✏️ `Draconic Evolution` add recipes that use trillions RF
- [ ] ✨ Make Draconic Armor adopt upgrades of prev tier
- [ ] ✏️ Add `Anglesite`-like ore that made in form of RFTools dimlets only to enforce RFTDims exploration
- [ ] ✏️ RFTools `Dimension building` rework - make cheaper by balancing possible dimlets
- [ ] 💜 Make `[constant] difficulty` dimension for replicator discount. Probably RFTools ones

<!-- 
Command to concat all files in directory:
› find scripts/do -name '*.zs' -print0 | xargs -0 -I {} sh -c 'echo "--- {} ---"; cat "{}"'

Command to show all commits that changing same files:
› git log --oneline abc123..HEAD -- $(git diff-tree --no-commit-id --name-only -r abc123)

Command to optimize all the .png files:
› ./pngquant.exe 128 resources/**/*.png --skip-if-larger --ext .png --strip --verbose --force
› ./oxipng.exe resources/**/*.png --alpha --strip all
-->

---

---

## Long-Term

Planned non-urgent changes, or just good ideas:

### "Performance ⚡"

- [ ] ⚡ Make Lumenized optional
- [ ] ⚡ never use a fluid storage interface for IE's multiblock tanks (cause lag)
- [ ] ⚡ Remove `Fluid Conduit` recipe since lower FPS
- [ ] ⚡ add Warning about things that lower FPS: `placed item, drawers, Auto Sieve (promote ugly plating)`
- [ ] ⚡ Fix `OpenComputers` JEI plugin is still loaded (see benchmark)
- [ ] ⚡ Cleanup JER data (and ores on other planets for clear JER tab)
- [ ] ⚡ Fix projectiles accumulated on chunk borders, such as Scythe or Beam Laser. Use `ForceUpdateEntityClasses` StellarCore's config
- [ ] ⚡ Remove Openblock's `Vacuum Hoppers` since they cause lags
- [ ] ⚡ Improve performance of Replicator tick with crystal and other requirments
- [ ] ⚡ Disallow to connect `Storage Bus` to ISS - can cause 10% TPS strain
- [ ] ⚡ `OTG` should probably be optional mod when game starting since it laggy
- [ ] ⚡ Wand of the forest change recipe to Recipe Function
- [ ] ⚡ Remove automatic IE armor recycling to speed up game load
- [ ] ⚡ Remove `Chunk Loading Ward` since its make harder to find all chunk loaders on server
- [ ] ⚡ Get rid of `Simple Trophies` since they strain FPS
- [ ] ⚡ Remove `Cyclic`'s machines completely because they are laggy: https://i.imgur.com/cbCJJBq.png
- [ ] ⚡ Add Tips note about IE multiblocks causing strong FPS strain. Also make them all work so fast only 1 machine needed

### Quests and Docs expansion
- [ ] 📖 Conflux should be announced as team too
- [ ] 📖 Add tip about `/nick` command
- [ ] 📖 `Interdiction Pulsar` add to some quest reward and describe how to use
- [ ] 📖 Add Skyblock quest about Terraformer
- [ ] 📖 Add Blast Furnace heat source
- [ ] 📖 Add note about pregen spoiling Lootr chests https://github.com/LootrMinecraft/Lootr/issues/195
- [ ] 📖 Add little tiles fancy chest with lot of space
- [ ] 📖 Add not that /dev/null is infinite for Robot
- [ ] 📖 Distilled water add JEI entries
- [ ] 🐉 Bestiary book have missed item icons
- [ ] 📖 Suggest IC2 reactors schemas
- [ ] 📖 Add note that Mana Enchanter can put Airtight Seal on TCon armor
- [ ] 📖 Add quest about Troll smashing tools
- [ ] 📖 `Portal Spread` add quest
- [ ] 📖 `Conglomerate of Coal` add info about using as Portal catalyst
- [ ] 📖 Note that `Singularities` consume items in inventory
- [ ] 📖 Add bonus information on modpack finished, like time played, some stats and so on
- [ ] 📖 Add note that EU2 Mining Node can automate fluid interactions

### "Battle" expansion
- [ ] ✏️ Buff EU saber - give it more damage? But better split entities in two.
- [ ] ✏️ Golem should grow bigger on level up
- [ ] ✏️ Blights should be bigger
- [ ] ✏️ `Compressed` mobs should be bigger

### "Flora & Fauna" expansion
- [ ] 📖 `Cocoon of Caprice` add JEI entry
- [ ] ✨ Idea: Flower that regenerate ore in `bedrockore`
- [ ] 💡 Feature idea: animal totem that work when you place mobs on each other in right sequence (cow-sheep-chicken for example)
- [ ] 🌱 Add NC and QMD radioactive items mutating IC2 crops to increase / descrease their stats
- [ ] 🍐 Fix Papaya manual tree harvesting with custom interract event https://github.com/Krutoy242/Enigmatica2Expert-Extended/issues/426
- [ ] ✏️ Make necessary to tame and breed animals: `Amphitere, Cocatrice, Hippocampus, Hyppogryph, Boars, `
- [ ] ✏️ Rework size changing potions on mobs
- [ ] ✏️ Rework Entity melting in Smeltery, migrate from Barrel Milking, add JEI category
- [ ] ✏️ Use `Mulch` as ingredient
- [ ] ✏️ Use `Gorgon Head` as ingredient
- [ ] ✏️ Use `Eye of Cyclops` as ingredient
- [ ] ✏️ Use `Huge Stalk` as ingredient
- [ ] ✏️ `Harbinger Cube` must spawn with strong Iron/Diamond skin effects and as Blight
- [ ] ✏️ Add mobs that always blights (probably breedable mobs)
- [ ] ✏️ Moon stone could be used in Animals chapter
- [ ] ✏️ Add more seeds compat for Graden Cloche https://github.com/michelegargiulo/ZenCloche/wiki
- [ ] ✏️ Add `Block Shrooms` + `salis mundus` => `something` recipe
- [ ] ✏️ blight Tamed Always Drop Something. Problem: dont know how to determine if entity is tamed
- [ ] 🐀 Fix rats not spawn on garbage piles (they actually spawn in singleplayer)
- [ ] 🐀 Add Ratlantis Portal spread
- [ ] 🌳 Flora rework: Add immersive usage of trees. Padauk Tree could be used to get Gold. Fireproof obtainable only by breeding
- [ ] ✏️ Quark Frog Drop Cooked Legs on death
- [ ] 🐀 Compressed Garbage Piles should spawn rats sometimes
- [ ] ✏️ Add Ethereal trees usage
- [ ] ✏️ Add craft `Rat hole` + `Salis Mundus` -> `Something`
- [ ] 🔄 Add `Cow Hacker` feature. Buff cow with 2-3 special potions based on their UUID to turn it into drop generator.
- [ ] ✏️ Dragon Ice better craft isages
- [ ] 🔨 Ironwood Add material. Drop Armor from mobs on hit
- [ ] 🧩 nerf Cake Flower, Buff Game Of Life One

### "Nuclear☢️" expansion
- [ ] ☢️ Turn on Radiation
- [ ] ✏️ Add QMD alt source of Oxidised Ferric Sand (to make alternative for Asteroid mining)
- [ ] 📖 add Note that QMD multiblocks need `Liquid Helium` Cooler
- [ ] ✏️ Draconic Metals made in QMD multiblocks
- [ ] ✏️ `.numericalId` may be used to LibVulpes ghost blocks to preview structures. It can be preview for possible QMD coolers
- [ ] 🪐 NC have its own "Wasteland" dim - make Use Of it
- [ ] ✏️ QMD atmosphere collector for other dims
- [ ] ✏️ Add usage of `Perfect Fuel` in NCO (with `flux goo` as sub-product)
- [ ] 🌍 Gen Highly Radioactive stuff on `Asteroid Belt`, unbearable radiation
- [ ] ☢️ Space planets have constant radiation

### "Multiplayer" expansion
- [ ] 🎁 Reward with 1 DankNull panel in several quests to promote sharing
- [ ] 💻 Think if i could make a script to keep 100% modpack completion after new quests are added
- [ ] 💬 Chat names should have special unicode symbols to show Conflux level and "accomplishments" (including Discord support) `/nick ..`
- [ ] 💬 `Accomplishments` ⚜✳✴❇ mechanic:
  * Add messages "Player killex xxx mobs! WOW" based on spectacular stats.
  * Rewards for this "Accomplishments" should be not related to game progression.
  * Probably need to reward a player with a IE banners since they are rare and purely cosmetical.
  * Rewards could give some "multiplayer enchancing" status, like badges or skins.
  * Ideas for goals: Mined blocks, Jumps, Deaths.
  * Table with more ideas: https://www.reddit.com/r/feedthememes/comments/jk9rag/the_political_compass_but_its_types_of_ftb_players/

### Skyblock expansion

- [ ] 🧱 Skyblock: Make `Porouse Stone` and `AA Ore Laser` mandatory in skyblock

### Mods
- [ ] 🔴 Remove **Simple Trophies** and replace them with LittleTiles or 3dPrint structures
- [ ] 🟠 Do not update **Advanced Rocketry - Reworked** until fixed https://github.com/dercodeKoenig/AdvancedRocketry/issues/50
- [ ] 🟠 Do not update **JAOPCA** - uncompatible with `JAOPCACustom`
- [ ] 🟠 Do not update **籁/Sound Physics Remixin** `1.1.17` or above - uncompatible with `Java 8`
- [ ] 🟠 Do not update **LootTweaker** `0.3.3` or above - its removing deprecated functions used since E2E
- [ ] 🟠 Do not update **Deep Mob Evolution** `1.2.3` - power usage changes makes Dragon model unable to work
- [ ] 🟠 Do not update **RLTweaker** `0.6.1` or above - later versions only compatible with `I&F ROTN`
- [ ] 🟠 Do not update **RLMixins** `1.4.0` or above - mod specially rewritten for `RLCraft`
- [ ] 🟢 Add **everlastingabilities** when someone integrate it
- [ ] 🟢 Add **Heat And Climate** when someone integrate it
- [ ] 🟢 Add **quality-tools** when someone integrate it
- [ ] 🟢 Add **Steve Carts** when someone integrate it
- [ ] 🟢 Add **OpenGlasses2** - could help to find turnable blocks from coal
- [ ] 🟢 Add **Nothirium** when fixed https://github.com/Meldexun/Nothirium/issues/9
- [ ] 🟢 Return **Village Names** when fixed https://legacy.curseforge.com/minecraft/mc-mods/village-names/issues/18 Possible manual fix: https://discord.com/channels/911676461050642432/959878900278784030/1439667407726579933

### Other

- [ ] 👑 Upgrading Draconic tools give Omnopotence (cannot reproduce single player)
- [ ] 💎 Diamond shouldn't be meltable in smeltery
- [ ] 📖 Add emojis 🍎 to chapter finishing messages
- [ ] 🐦 enable Enchanting speed up for rats
- [ ] 📀 Add HV wire invincibility TCon trait
- [ ] 📀 Dont let IC2 miner dig any mining level
- [ ] 📀 Add `Uncrafting Table` automation block - probably GUI-less tile entities working like hopper
- [ ] 🔚 Make EIO capacitors actually usabe: right now, tweaked machine power usage make machine speed always 1 tick, neglibe capacitor usefulness
- [ ] ♻️ Refactor: replace all `itemUtils.getItem` to `<${}:${}>`
- [ ] ⚙️ Enable and integrate EIO capacitors for IF machines `config/ometweaks/ometweaks.cfg:261`
- [ ] 🔨 `Spectre` trait - remove annoying flashing
- [ ] ✏️ `Thermal Logistics` cheaper, use widely
- [ ] 💜 add `0 difficulty` dimension (replicator cant work here). Maybe Spectre. ☝ Problem: Allowing getting +1🎁 whole game.
- [ ] 🌍 Populate Wasteland (4598) with removed Ores but make them extremely durable
- [ ] 🐈 Ball of fur remove default dropping items
- [ ] 🌌 Add `Sound Singularity` - crafted with different sounds
- [ ] 🌌 Add `Helmet/Chest/Leggins/Boots Singularity`
- [ ] 🌌 Add `Pickaxe/Shovel/Hoe/Axe/Sword Singularity`
- [ ] ✏️ `Creative Impetus` add recipe. Doubdt - its block kinda ugly, no effects, more like technical.
- [ ] 🧪 Integrate new TCon Fluids: `Blazin' Blood + Bone, Venom + Bone`
- [ ] 🌍 Bio planet bog should have Peat under the ground
- [ ] ✨ Idea: Difficulty cant grow if you didnt died
- [ ] 🌍 Teleport player to AlienJungle with Blood Magic TP ritual
- [ ] 🌍 AlienJungle add JER data
- [ ] 𝓩𝒮 `/perf` improvments: Group chunks by dimension, Split big reports to pages, Add command mention in quest book
- [ ] 📀 change of `Trick: Ebony and Ivory` spell from "The End dimension" to "The End biome"
- [ ] 🧪 Add `Sulfur Dioxide/Trioxide` in fluid dictionary
- [ ] 🌍 Idea: fountains from Chemical Spreader projectiles that spread functionable fluid, transforming landscape around. Its also can be acid rain.
- [ ] 🟡 Integrate `My Precious`: add to Dungeon loot, add in Loot Boxes
- [ ] 💡 Idea: items doesnt have borders if already acquired
- [ ] 💡 Idea: Chain commands with `& /`
- [ ] 🔨 Little Tiles remove limits (but how? Its already have big limits)
- [ ] 🔵 Integrate more textures with `Lumenized` (contributor's help welcomed here)
- [ ] ✏️ Fix `Magma Crucible` cant melt Rotten Flesh
- [ ] ✏️ `Cinnabar Cluster` can only be made in the crucible/thaumatorium and not via an alchemist's stone in a crystalization chamber
- [ ] 📀 `Flux Anodizers` should output more ore when working with Netherending Ores
- [ ] 📀 [(Filled) Tin Can] fix not restoring nutrients
- [ ] 📀 Speed up Dragon Forge
- [ ] ✏️ `High Oven` does not provide x2 of fluid for Osmium Ore
- [ ] 🖼️ Add via mixins: https://legacy.curseforge.com/minecraft/texture-packs/ic2-seedbag-display
- [ ] 🐀 Rat Ore Doubling can dupe IC2 "Iridium Ore". Removing oreIridium from it wont help.
- [ ] ✏️ Add feature to clear drawer `Item: 0` when unlocking it https://github.com/jaquadro/StorageDrawers/commit/da9875158ad0fadc190aae437ea2d9e89d616cca
- [ ] 📖 Unmerge Furnace inputs in HEI (reported to HEI dev)
- [ ] 💧 Add `Fluid Interactions` between gaseous (floating up) and normal fluids
- [ ] 📀 Concrete make hardening slower for servers. Source code of concrete https://github.com/BluSunrize/ImmersiveEngineering/blob/master/src/main/java/blusunrize/immersiveengineering/common/blocks/BlockIEFluidConcrete.java#L51-L191
- [ ] 🦊 Transormation powder turn `Fox` into `Foxhound`
- [ ] 🟢 Integrate `villager-contracts`
- [ ] ✨ Idea: `Experiment 115` farm. You need to grow cakes to full for using them in recipe.
- [ ] ✏️ Rethink EnderIO `Fluid Tank` recipe since glass cant be poured with iron after cast
- [ ] ⭐ Make self-forbidding mechanism for Difficulty https://github.com/friendlyhj/ZenUtils/issues/53#issuecomment-2154922579
- [ ] ⭐ Difficulty: descrease over time?
- [ ] 📖 Skyblock chapter disable chapter comletion message on each quest (how if everything optional?)
- [ ] ✏️ Idea: Time in a Bottle add levels to Tinker's tools
- [ ] 📀 Add animated GIF for java warning https://github.com/Darkhax-Minecraft/OldJavaWarning/blob/1.12.2/src/main/java/net/darkhax/oldjava/OldJavaWarning.java
- [ ] 📖 Add Archeologyst trades to HEI
- [ ] ✏️ `Red Mechanic` move trades to other villager `config/vtt/trade_tables/red_mechanic.json`
- [ ] ✏️ Fix Generic Entity spawn spawning with wrong looking direction
- [ ] ✏️ Use `mods.jei.JEI.addItemNBTSubtype` to subtime `Genetic Templates` and `syringe` (when updated RandomTweaker after fix crash https://github.com/Project-RT/RandomTweaker/issues/82)
- [ ] ⚡ (ARR) Remove XU2 jei removed categories https://spark.lucko.me/MRBZYLxzrN?hl=325666
- [ ] 📀 Fix crops drop 1000 of berries on high stats
- [ ] 🎉 Add new mechanic for /dev/null for leveling up its recharging speed
- [ ] 📀 Raw Inversion Pillar - fix duping itself. Culd be used as craft mechanics since can spread will-infused stone.
- [ ] ⚒️ Add Trait trat replace ores with Stone when harvested
- [ ] 🏡 Fix one of the Recurrent Complex houses have lava that fire up whole building
- [ ] ⚒️ Make TE cache drop itself with content on break
- [ ] 🌍 Remove Poison Ivy from OTG generator. Its `biomesoplenty:plant_0:4` but i cant find where it defined
- [ ] 🌍 `122 Kepler 0118` improve generation (right now its just plain graphite)
- [ ] 🌎 fix Tropical Gardens Spawn In OTG Frozen Ocean
- [ ] 🕸 Create issues about IC2 Reactor in compact machine and cables disconnection
- [ ] 🐛 If Conarm armor have huge durability (>65,000), when it get damage over 50% its repairing to 100% and become unbreakable. On some cases it void armor from inventory instead
- [ ] ✏️ Apiarist Villagers should sell Combs cor Cacoa. Impossible to remove Apiarist trades with `vtt` mod
- [ ] 🌍 fix Mercury Have Water
- [ ] ✏️ Fix Health boost potion recipe (one from gold ingot)
- [ ] ✏️ Dank Null go out of ExtendedCrafting (keep EC recipes for end-tier)
- [ ] 📖 Fix achievments: end reborn hammer, Rats cauldron, Quark decor
- [ ] ✏️ Completely move AdvRocketry to tweaker mod instead of XML
- [ ] 🧩 Make Platforms from Random Things with metal texture instead of wood
- [ ] ✏️ disable Excavate Ench For Pickarang
- [ ] ✏️ invent Tool For Robot With Low Durability (robot may not spend durab)
- [ ] ✏️ Printing and assembling Chaos Guardian spawns Chaos Guardian
- [ ] 💥 going Between Dims Causing Client Freezez / memory leak
- [ ] ✏️ `Burnt in fluid` fix accept any meta
- [ ] 📖 Describe Skyblock quests
- [ ] 📀 Rustic's barrel make as x4 chests but without GUI or change somehow else to make more fun.
- [ ] ✏️ Lootr still turn Dispensers into Lootr Chests https://github.com/noobanidus/Lootr/issues/189
- [ ] ✏️ Nature chests still turn into Lootr
- [ ] 💅 twlight forest advancement not showing up in advancement tab v1.2.1. Need conformation
- [ ] ✏️ Make use of IC2 brewing
- [ ] 🔄 Implement https://github.com/Divine-Journey-2/Divine-Journey-2/pull/829
- [ ] 🚂 Buff mek steam a little
- [ ] 📖 Better document Butterfly => Wasp transform in Nether Portal
- [ ] 📖 Fix completion of quest chapters
- [ ] ✏️ Chemical thrower turns stone into ore if spreading on exact block (calculated based on world seed). Can be determined with Computer
- [ ] ✏️ `Conglomerate of Life` spawns Foxes and Pigmen near portal
- [ ] ✏️ Rebalance Sage and Druids trades
- [ ] ✏️ Add compressed `Charged Creeper chunk`
- [ ] ✏️ Glass fiber harder (clear glass maybe)
- [ ] ✏️ NC Motor replace by IC2 motor or change recipes
- [ ] 🌍 AbandonedWoodTower less spawn
- [ ] 🔄 Carryon change render for EIO warehouse
- [ ] 🌍 Some OTG biomes have no Ore spawn because they use not Stone. (Biome serach: `StoneBlock: (?!STONE)\w+`)
- [ ] 📀 Make ic2 crops scanned by default
- [ ] ✏️ Remove Fiery fruit from Target Chamber recipe
- [ ] 🔄 Inspect crash when placing Replicator near energy and break it
- [ ] 📖 Add quest book chapter about built-in excavators
- [ ] 📖 Add message about mining Ores in Nether that aggro Pigman. Use whitelist, ignore if Peaceful.
- [ ] 📖 Give player `Tier1 box` instead of putting Decor into Common boxes
- [ ] ✏️ Re-integrate molten `Amber`. But why?
- [ ] ✏️ Add Matter Balls craftable without compressor (they still obtainable through scrap boxes)
- [ ] ✏️ Re-integrate NCO `Melter`. All things meltable in Melter should be meltable in Smeltery
- [ ] ✏️ Remove recipes from `config\mysticalagriculture_recipes.cfg`
- [ ] ✏️ Cant make Bauble => advanced rings. Recipe functions prevent this from happen
- [ ] 📖 `AnyMeatraw` should cycle in JEI. This usually possible with ore.firstItem, but not working for some reason.
- [ ] 🔨 Add trait that auto-consume Sharpening Kits to repair TCon Tools
- [ ] ✏️ Add AS Grindstone recipe that rely on doubling chance mechanic
- [ ] 📖 Add AS ritual to quest book
- [ ] 💻 Add info about OC changes like https://www.reddit.com/r/feedthebeast/comments/98phxv/filtering_by_nbt_tag/
- [ ] 🔄 Make `scripts/jei` files not loaded on server
- [ ] 🐛 Items textures not animated too when **Animated Terrain** disabled
- [ ] 📖 Obtaining any **sharpening kit** finishes quest for this **mining level**
- [ ] ✏️ Petrotheum `Conflux I` craft, probably Quicksand => Tube => Petrotheum
- [ ] ✏️ Add craft mechanic - Mud Ball hit something (called "humilate")
- [ ] ✏️ Add mobs in Mek's gear
- [ ] 📖 List of items that may be add into loot boxes in future: Fireproof Shards, Copernicium-291, IC2 seeds, https://i.imgur.com/G0A2KF1.png https://i.imgur.com/99itSSA.png
- [ ] 🔄 Add custom progression for Twilight Forest based on Quest Book, since achievments can be disabled
- [ ] 📀 Fix NPE https://is.gd/wZprY2
- [ ] ✏️ Add multiblock structure that speed up blocks like Time In Bottle, but based on numbers of mobs around https://is.gd/tPPqt2
- [ ] 🔄 Fix after getting 30 hearts, player need to relog to enter nether
- [ ] 🔄 Check why mobs are not spawned enough (less then 70 for whole server)
- [ ] ✏️ Rethink HedgeAlchemy, add recipes for essential tech-alike ingredients
- [ ] ✏️ Fix main Vis Crystals doubled in JEI (happens because of Rustic add into JEI everything in output of Alchemical)
- [ ] 📀 Colossal Chests make bigger interface
- [ ] ✏️ Drop items onto garbage piles to make pile bigger
- [ ] ✏️ ? Quark Crystals: orange -> topaz nuggets, violet -> tanzanite nuggets, yellow -> brass nuggets
- [ ] 📀 Fix Green fertilizer output additional crop even if not grown (carrots)
- [ ] ✏️ Spray Pyrotheum or other liquids to turn blocks into charcoal or other stuff.
- [ ] ✏️ Change `Expire in block` craft to be faster
- [ ] ✏️ `Ash` add to liquid interaction
- [ ] ✏️ Remove wrong nuggets from Infernal Furnace
- [ ] 🔄 Add neural interface searching: with neural interface and special program find special blocks
- [ ] ✏️ **4x** Coal Singularity (or other) => Creative Bin (or other ways to craft creative bins with one unchangable item)
- [ ] 🌍 118_KELT-2ab: Add Kelps growing
- [ ] 🌍 Add new AdvRocke atmospheres
- [ ] 🌍 Add water animals at dim 118
- [ ] 🌿 Patchouli: Change **texture** of book
- [ ] 🔄 Fix Custom Animals drops non-cooked meat
- [ ] 🔨 ![](https://git.io/JnzzI "Glitch Infused Ingot") add material. Ability: drop matter from mobs
- [ ] 🔨 Add armor trait that speed up gain for `Time In Bottle`

### VAULTOPIC feature ideas

- Bauble compat

---

---

## TODO `E2EE v2.0`

List of features and changes for `E2EE v2.0`, that breaking worlds and require fresh start

- 🌍 Remove OTG `Origin` biome since unnatural
- 🌍 Remove OTG completely?
- ⚡ Remove `Libnine` and `Fluid Drawers` because lag https://github.com/phantamanta44/fluid-drawers/issues/19

---

---

## Unable to

- 🎆 Singularities add OreDicts on server, made usable in recipes - impossible since `#sideonly server` runs only on dedicated server
- 🟢 Silently download mods from Modrinth - forbidden by CF policy (https://modrinth.com/mod/hit-indication)
- ✏️ remove default furnace recipes from `arc furnace`. It seems like they are added by mods themselves, like Thermal or TConEvo
- ✏️ fix 59% on Bees Output such as Combs. Impossible since this how Mod Tweaker adds them. Some recipes have -1% some dont.
- ❌ fix I C2 Chainsaw Cant Cut TC trees. Impossible to change mining level with `MaterialChanger`
- ✏️ Add Rubber Wood in Resin Funnel - **Resin Funnel** recipes cant be changed
- 🔄 Blacklist Bedrock Ore for ![](https://git.io/Jz9q9 "Mining Laser")
- Buff Giant Sword - cant be buffed with MaterialChanger mod
- `<gendustry:gene_sample>.maxStackSize = 64;` **Transposer** dupe Samples when stackable
- 📖 whenever you have a rewards for a quest containing three items of tinkers, the last item does not show your stats. (Cant be fixed - FTBQ bug)
- ✏️ SAGmill stuck when produce too much Scrap with balls: best grinding balls produce X5 output that would make SAG mill without balls too weak
- ✏️ Fix Cottontail not turning into Dye. Dont know how to determine double plant
- ✏️ Add command to show all registered Floo Fireplaces. Impossible, files stored in dimension data.

---

---

## 📦 Items of Interest

Items that should have more uses:

### Tier 2

![](https://git.io/JnN1t "Sun Crystal") - split into shards and use as ingredient for all void miners
![](https://git.io/JRLSJ "Ice Shard")
![](https://git.io/JRnDa "Tar")

### Tier 3

![](https://git.io/JLjsf "Basalt Sediment")
![](https://git.io/JLhhf "Energized Clathrate")
![](https://git.io/JLhph "Destabilized Clathrate")

## 🔧 Crafting Methods

![](https://git.io/JG5U9 "Decay Generator")
![](https://git.io/JtDnO "Chemical Thrower")
![](http://tinyurl.com/Blue-Fire-Jar "Blue Fire Jar")
![](http://tinyurl.com/Radiator-Block "Radiator Block")

---

---

## Challenges ideas

- No AE2
  > You cant use AE2 terminal or such
  > But you get ???
- No EnderIO Conduits
  > Not using conduits
  > But ???
- No Tech
- No base
  > Cant stay in same chunk for long time. Can be featured with increasing Radiation in this chunk
- Speedrunning item
  > Item that can replace many other items inrecipes but only if you play fast enough
- No GUIs
  > Turn E2EE into opposite of GregTech, where 50% of your game you staring into GUI screens
  > Possible reward - whenever picking up item for the first time - get second copy of this item
- No generated Ores
  > Player started with limited amounts of Ores. He cant get more.

<!-- 
## Miscellaneous

### Player data reset

**Remove files:**
- advancements/[UUID].json
- data/ApiaristTracker.[UUID].dat
- data/ArboristTracker.[UUID].dat
- data/ftb_lib/players/[NAME].dat
- data/LepidopteristTracker.[UUID].dat
- data/POBox_player-[NAME]-[UUID].dat
- playerdata/[UUID].astral
- playerdata/[UUID].astralback
- playerdata/[UUID].cosarmor
- playerdata/[UUID].cyclicinvo
- playerdata/[UUID].dat
- playerdata/[UUID].ocnm
- playerdata/gamestages/[UUID].dat
- stats/[UUID].json

**Execute commands:**
- Leave team
- `/ftbquests change_progress reset [NAME]`
 -->
