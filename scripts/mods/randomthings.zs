#modloaded randomthings nuclearcraft

import crafttweaker.item.IIngredient;

// Defined by hammering
recipes.remove(<randomthings:ingredient:5>);

// Custom mechanics changed by Mixins
scripts.jei.crafting_hints.add1to1(<thaumcraft:cluster:1>, <minecraft:gold_ingot> * 8, <entity:randomthings:goldenchicken>.asIngr());

// Add hints with Spectre trees mechanics
scripts.jei.crafting_hints.addInsOutCatl(
  [<randomthings:ingredient:2>, <ore:treeSapling>],
  <randomthings:spectresapling>
);
scripts.jei.crafting_hints.addInsOutsCatl(
  [<randomthings:spectresapling>],
  [<randomthings:spectrelog> * 7, <randomthings:spectreleaf> * 50]
);

scripts.lib.loot.tweak('randomthings:beanpod', 'Diamond', 'minecraft:diamond', null, [
  <biomesoplenty:gem:1>,
  <biomesoplenty:gem:2>,
  <biomesoplenty:gem:3>,
  <biomesoplenty:gem:4>,
  <biomesoplenty:gem:5>,
  <biomesoplenty:gem:6>
], [0,1]);

// NuclearCraft -> Random Things Glowing Mushroom
recipes.removeShapeless(<minecraft:brown_mushroom>, [<nuclearcraft:glowing_mushroom>]);
recipes.addShapeless('Random Things Glowing Mushroom',
  <randomthings:glowingmushroom>, [<nuclearcraft:glowing_mushroom>]);

// Nerf from 300
furnace.setFuel(<randomthings:blockofsticks>, 80);

recipes.remove(<randomthings:idcard>);
recipes.addShapeless('idcard',
  <randomthings:idcard>,
  [<ore:paper>,<ore:dyeBlack>, <ore:dyeRed>]);

// Ender bucket recipe change
recipes.remove(<randomthings:enderbucket>);
recipes.addShaped('ender_bucket1',
  <randomthings:enderbucket>,
  [[<minecraft:ender_pearl>],
    [<minecraft:bucket>]]);
recipes.addShaped('ender_bucket2',
  <randomthings:enderbucket>,
  [[<ore:plateIron>, <minecraft:ender_pearl>, <ore:plateIron>],
    [null, <ore:plateIron>, null]]);

// Clear reinforced bucket
utils.clearFluid(<randomthings:reinforcedenderbucket>);

// Floo dust
recipes.remove(<randomthings:ingredient:7>);
recipes.addShapeless('Floo Dust 8',  <randomthings:ingredient:7> * 8, [<ore:enderpearl>, <ore:dustRedstone>, <ore:gunpowder>, <ore:cropBean>]);
recipes.addShapeless('Floo Dust 64', <randomthings:ingredient:7> * 64, [<appliedenergistics2:material:46>, <ore:dustRedstone>, <ore:gunpowder>, <ore:cropBean>]);

// Floo Token cheaper alt
scripts.process.compress(<randomthings:ingredient:7> * 3, <randomthings:flootoken>, 'No Exceptions');

// Lubricient
craft.reshapeless(<randomthings:ingredient:6> * 4, 'ABC', {
  A: <minecraft:wheat_seeds>,
  B: <minecraft:potion>.withTag({ Potion: 'minecraft:water' }),
  C: <ore:cropBean>,
});

// [Time in a bottle] from [Experience Imbue][+3]
craft.remake(<randomthings:timeinabottle>, ['pretty',
  '  C  ',
  '  E  ',
  'B F B'], {
  'C': <minecraft:clock>,            // Clock
  'E': <randomthings:imbue:2>,       // Experience Imbue
  'B': <randomthings:ingredient:13>, // Blackout Powder
  'F': <randomthings:ingredient:7>,  // Floo Powder
});

// Illuminator
recipes.remove(<randomthings:spectreilluminator>);
recipes.addShaped(<randomthings:spectreilluminator>, [
  [null, <randomthings:ingredient:2>, null],
  [<randomthings:ingredient:2>, <extrautils2:suncrystal>, <randomthings:ingredient:2>],
  [null, <randomthings:ingredient:2>, null]]);

// [Spectre Key] from [Concealment Key][+1]
craft.remake(<randomthings:spectrekey>, ['pretty',
  '  E  ',
  'E C E',
  '  E  '], {
  'E': <randomthings:ingredient:2>, // Ectoplasm
  'C': <storagedrawers:shroud_key>, // Concealment Key
});

// Spectre Anchor
recipes.removeShaped(<randomthings:spectreanchor>);
recipes.addShaped(<randomthings:spectreanchor>, [
  [<randomthings:ingredient:2>],
  [<tombmanygraves:death_list> ?? <minecraft:paper>],
  [<extrautils2:ingredients:5>]]);

// Spectre Ingot
recipes.remove(<randomthings:ingredient:3>);
recipes.addShapeless('Spectre Ingot Harder', <randomthings:ingredient:3>, [
  <ore:ingotUnstable>,
  <randomthings:ingredient:2>,
  <thermalfoundation:material:134>,
  <forestry:phosphor>,
]);
recipes.addShapeless('Spectre Ingot Harder alt', <randomthings:ingredient:3>, [
  <ore:ingotUnstable>,
  <randomthings:ingredient:2>,
  <thermalfoundation:material:134>,
  <ore:ingotPlutonium242All>,
]);

// Spectre Charger Tier 1
recipes.remove(<randomthings:spectrecharger>);
recipes.addShaped(<randomthings:spectrecharger>, [
  [<deepmoblearning:soot_covered_plate>, <enderio:block_electric_light>, <deepmoblearning:soot_covered_plate>],
  [<randomthings:ingredient:3>, <extrautils2:powertransmitter>, <randomthings:ingredient:3>]]);

// Spectre Charger Tier 2
recipes.remove(<randomthings:spectrecharger:1>);
recipes.addShaped(<randomthings:spectrecharger:1>, [
  [<deepmoblearning:soot_covered_plate>, <randomthings:spectrecharger>, <deepmoblearning:soot_covered_plate>],
  [<ore:ingotRedstoneAlloy>, <randomthings:spectrecharger>, <ore:ingotRedstoneAlloy>]]);

// Spectre Charger Tier 3
recipes.remove(<randomthings:spectrecharger:2>);
recipes.addShaped(<randomthings:spectrecharger:2>, [
  [<deepmoblearning:soot_covered_plate>, <randomthings:spectrecharger:1>, <deepmoblearning:soot_covered_plate>],
  [<ore:itemEnderCrystalPowder>, <randomthings:spectrecharger:1>, <ore:itemEnderCrystalPowder>]]);

// Make saplings with MA essence
recipes.addShaped('Spectre Saplings', <randomthings:spectresapling> * 10, [
  [null, <mysticalagriculture:nature_essence>, null],
  [<mysticalagriculture:wood_essence>, <randomthings:ingredient:2>, <mysticalagriculture:wood_essence>],
  [null, <mysticalagriculture:nature_essence>, null]]);

// Oxygen bottle
mods.thermalexpansion.Transposer.addFillRecipe(<randomthings:bottleofair>, <minecraft:glass_bottle>, <liquid:oxygen> * 1000, 25000);

// Lesser Magic Bean
craft.remake(<randomthings:beans:1>, ['pretty',
  'x x x',
  'x O x',
  'x x x'], {
  x: <ore:blockGold>,
  O: <ore:cropBean>,
});

// [Player Interface] from [Evil Tear][+2]
craft.remake(<randomthings:playerinterface>, ['pretty',
  'B E B',
  'E v E',
  'B E B'], {
  'B': <randomthings:ingredient:13>, // Blackout Powder
  'E': <randomthings:ingredient:2>,  // Ectoplasm
  'v': <randomthings:ingredient:1>,  // Evil Tear
});

// Imbuer
craft.remake(<randomthings:imbuingstation>, ['pretty',
  'A B A',
  'C D C',
  'A E A'], {
  A: <forestry:wood_pile>,
  B: <minecraft:water_bucket>,
  C: <ore:dustHydratedCoal>,
  D: <tconstruct:materials:18>,
  E: <rats:raw_plastic>,
});

// [Blackout_Powder*4] from [Bio_Coal][+2]
craft.reshapeless(<randomthings:ingredient:13>, 'F☺▲', {
  '▲': <ore:dustAsh>,                   // Ash
  'F': <fluxnetworks:flux>,             // Flux
  '☺': <actuallyadditions:item_misc:22>, // Bio Coal
});

// [Slime Cube] from [Mending Moss][+2]
craft.remake(<randomthings:slimecube>, ['pretty',
  'F s F',
  's M s',
  'F s F'], {
  'F': <randomthings:ingredient:7>, // Floo Powder
  's': <ore:slimecrystal>, // Green Slime Crystal
  'M': <tconstruct:materials:19>,   // Mending Moss
});

// [Fertilized Dirt]*8
craft.remake(<randomthings:fertilizeddirt> * 8, ['pretty',
  'F f F',
  'f ~ f',
  'F f F'], {
  'F': <randomthings:ingredient:7>, // Floo Powder
  'f': <ore:fertilizer>,            // Fertilizer
  '~': LiquidIngr('witchwater'),
});

val weatherIngrs = {
  'a': <ore:feather>,               // Feather
  'B': <ore:itemBeeswax>,           // Beeswax
  'C': <forestry:pollen:1>,         // Crystalline Pollen Cluster
  'c': <mctsmelteryio:iceball> ?? <iceandfire:dragon_ice>,
  'f': <minecraft:double_plant>,    // Poppy
  'l': <randomthings:ingredient:13>,// Blackout Powder
  'e': <ore:egg>,
} as IIngredient[string];

// [Weather_Egg_<Sun>*2] from [Egg][+3]
craft.remake(<randomthings:weatheregg> * 4, ['pretty',
  'B f B',
  'l e l',
  'B f B'], weatherIngrs
);

// [Weather_Egg_<Rain>*2] from [Egg][+3]
craft.remake(<randomthings:weatheregg:1> * 8, ['pretty',
  'B C B',
  'l e l',
  'B C B'], weatherIngrs
);
craft.make(<randomthings:weatheregg:1> * 4, ['pretty',
  'B c B',
  'l e l',
  'B c B'], weatherIngrs
);

// [Weather_Egg_<Storm>*2] from [Egg][+3]
craft.remake(<randomthings:weatheregg:2> * 4, ['pretty',
  'B a B',
  'l e l',
  'B a B'], weatherIngrs
);

// Spectre String harder
recipes.remove(<randomthings:ingredient:12>);
recipes.addShapeless('cheaper spectre string', <randomthings:ingredient:12>, [<mysticalagriculture:crafting:23>, <randomthings:ingredient:2>]);

val spectreIngrs = {
  '♥': <randomthings:spectrecoil_redstone>,   // Redstone Spectre Coil
  'p': <randomthings:spectrecoil_normal>,     // Spectre Coil
  '□': <ore:fusedQuartz>,
  'e': <ore:eyeofredstone>,                   // Eye of Redstone
  'E': <ore:pearlEnderEye>,                   // Eye of Ender
  'I': <twilightforest:ice_bomb>,             // Ice Bomb
  '▬': <randomthings:ingredient:3>,           // Spectre Ingot
  'o': <cyclicmagic:soulstone>,               // Soulstone
  'P': <forestry:crafting_material:1>,        // Pulsating Mesh
  'S': <mysticalagriculture:crafting:23>,
  'i': <contenttweaker:conglomerate_of_coal>,
  'l': <contenttweaker:conglomerate_of_life>,
  't': <contenttweaker:conglomerate_of_sun>,
  'C': <cyclicmagic:crystallized_obsidian>, // Crystallized Obsidian
  'N': <ore:ingotEndorium>,
} as IIngredient[string];

// [Spectre_Coil] from [Ice_Bomb][+4]
craft.remake(<randomthings:spectrecoil_normal>, ['pretty',
  'S ▬ S',
  'P I P',
  'S i S'], spectreIngrs
);

// Other alt
// [Spectre Coil] from [Ice_Bomb][+4]
craft.remake(<randomthings:spectrecoil_normal>, ['pretty',
  'S ▬ S',
  'N I N',
  'S i S'], spectreIngrs
);

// [Redstone_Spectre_Coil] from [Spectre_Coil][+4]
craft.remake(<randomthings:spectrecoil_redstone>, ['pretty',
  'S ▬ S',
  'e p e',
  'S l S'], spectreIngrs
);

// [Ender_Spectre_Coil] from [Redstone_Spectre_Coil][+4]
craft.remake(<randomthings:spectrecoil_ender>, ['pretty',
  'S ▬ S',
  'E ♥ E',
  'S t S'], spectreIngrs
);

// [Spectre Lens] from [Spectre Ingot][+2]
craft.remake(<randomthings:spectrelens>, ['pretty',
  '◊ ◊ ◊',
  '- - -',
  '# ▬ #'], {
  '◊': <ore:gemPearl>,              // Shulker Pearl
  '-': <ore:plateMithril>,
  '#': <randomthings:spectreplank>, // Spectre Planks
  '▬': <ore:ingotSpectre>,          // Spectre Ingot
});

// [Spectre Energy Injector] from [Soulstone][+3]
craft.remake(<randomthings:spectreenergyinjector>, ['pretty',
  '■ ■ ■',
  '▬ S ▬',
  'o o o'], {
  '■': <ore:fusedQuartz>,       // Fused Quartz
  '▬': <ore:ingotSpectre>,      // Spectre Ingot
  'S': <cyclicmagic:soulstone>, // Soulstone
  'o': <ore:obsidian>,          // Obsidian
});

// ----------------------------

// [Nature Core]
craft.remake(<randomthings:naturecore>, ['pretty',
  '# § #',
  '§ E §',
  '# § #'], {
  '#': <twilightforest:twilight_log:*>,
  '§': <randomthings:slimecube>,     // Slime Cube
  'E': <darkutils:monolith>,
});

// Cheaper (used ender pearl)
// [Returning_Block_of_Sticks*8] from [Floo_Powder][+1]
craft.remake(<randomthings:blockofsticks:1> * 8, ['pretty',
  '□ □ □',
  '□ F □',
  '□ □ □'], {
  '□': <randomthings:blockofsticks>, // Block of Sticks
  'F': <randomthings:ingredient:7>,   // Floo Powder
});

// [Eclipsed_Clock] from [Spectre_Illuminator][+2]
craft.remake(<randomthings:eclipsedclock>, ['pretty',
  'B O B',
  'O S O',
  'B O B'], {
  'B': <randomthings:ingredient:13>,      // Blackout Powder
  'S': <randomthings:spectreilluminator>, // Spectre Illuminator
  'O': <bibliocraft:clock:*>,              // Oak Clock
});

// Remove all default imbue recipes
mods.roidtweaker.randomthings.Imbuing.clearRecipes();

// Remake imbues, make them way cheaper
mods.roidtweaker.randomthings.Imbuing.addRecipe(
  <randomthings:imbue>,
  <minecraft:potion>.withTag({ Potion: 'minecraft:water' }),
  [<actuallyadditions:item_misc:11>,
  <tconstruct:edible:4>,
  <actuallyadditions:item_misc:10>,
]);
mods.roidtweaker.randomthings.Imbuing.addRecipe(
  <randomthings:imbue:1>,
  <minecraft:potion>.withTag({ Potion: 'minecraft:water' }),
  [<minecraft:red_mushroom>,
  <minecraft:potato>,
  <minecraft:brown_mushroom>,
]);
mods.roidtweaker.randomthings.Imbuing.addRecipe(
  <randomthings:imbue:2>,
  <minecraft:potion>.withTag({ Potion: 'minecraft:water' }),
  [<randomthings:beans>,
  <minecraft:dye:4>,
  <minecraft:glowstone_dust>,
]);
mods.roidtweaker.randomthings.Imbuing.addRecipe(
  <randomthings:imbue:3>,
  <minecraft:potion>.withTag({ Potion: 'minecraft:water' }),
  [<minecraft:netherbrick>,
  <iceandfire:wither_shard>,
  <minecraft:soul_sand>,
]);

// [Sound Box] from [Citrus Wood Planks]*6[+1]
craft.remake(<randomthings:soundbox>, ['pretty',
  '◊ ◊ ◊',
  '◊ # ◊',
  '◊ ◊ ◊'], {
  '#': <ore:plankWood>, // Citrus Wood Planks
  '◊': <ore:gemLapis>, // Lapis Lazuli
});

// [Summoning Pendulum] from [Iron Rod][+1]
craft.remake(<randomthings:summoningpendulum>, [
  '/',
  '#',
  '#'], {
  '/': <quark:iron_rod>,            // Iron Rod
  '#': <randomthings:spectreplank>, // Spectre Planks
});

// [Spectre Coil Nr. 46] from [Conglomerate Of Coal][+3]
craft.remake(<randomthings:spectrecoil_number>, ['pretty',
  '# ◊ #',
  'F © F',
  '# F #'], {
  '#': <randomthings:spectreplank>,           // Spectre Planks
  '◊': <ore:gemPearl>,                        // Shulker Pearl
  'F': <randomthings:ingredient:7>,           // Floo Powder
  '©': <contenttweaker:conglomerate_of_coal>, // Conglomerate Of Coal
});

// [Pitcher Plant] from [Oxeye Daisy][+2]
craft.remake(<randomthings:pitcherplant>, [
  'M',
  'f',
  'F'], {
  'M': <randomthings:ingredient:13>,
  'f': <ore:flower>,                  // Oxeye Daisy
  'F': <randomthings:fertilizeddirt>, // Fertilized Dirt
});

// [Stable Ender Pearl] from [Ender Pearl][+2]
craft.remake(<randomthings:stableenderpearl> * 16, ['pretty',
  'F F F',
  'F e F',
  'o o o'], {
  'F': <randomthings:ingredient:7>, // Floo Powder
  'e': <ore:enderpearl>,            // Ender Pearl
  'o': <fluxnetworks:flux>,
});

// [Item Collector] from [Bottle o' Enchanting][+2]
craft.remake(<randomthings:itemcollector>, ['pretty',
  '  F  ',
  '  X  ',
  'o o o'], {
  'F': <randomthings:ingredient:7>, // Floo Powder
  'X': <ore:itemXP>,                // Bottle o' Enchanting
  'o': <ore:obsidian>,              // Obsidian
});

// [Rain Shield] from [Blaze Rod][+2]
craft.remake(<randomthings:rainshield>, ['pretty',
  '    F',
  '  /  ',
  'B    '], {
  'F': <randomthings:ingredient:7>, // Floo Powder
  '/': <ore:rodBlaze>,              // Blaze Rod
  'B': <ore:stoneBrimstone>,        // Brimstone
});

// [Igniter] from [Compressed Cobblestone][+3]
craft.remake(<randomthings:igniter>, ['pretty',
  '¤ ¤ n',
  '░ R R',
  '¤ ¤ n'], {
  '¤': <ore:gearSteel>,               // Steel Gear
  'n': <ore:netherrack>,              // Netherrack
  '░': <ore:compressed1xCobblestone>, // Compressed Cobblestone
  'R': <randomthings:rainshield>,     // Rain Shield
});

// Harder (or not) Evil Tear
recipes.remove(<randomthings:ingredient:1>);
scripts.process.evaporate(<fluid:crystal> * 1000, <randomthings:ingredient:1>, 'No Exceptions');

// [Escape Rope] from [String][+1]
craft.reshapeless(<randomthings:escaperope>, '▬s', {
  '▬': <ore:ingotDemonicMetal>, // Demon Ingot
  's': <ore:string>,            // String
});

// [Plate Base]*4 from [Paper][+1]
craft.remake(<randomthings:ingredient:8> * 4, ['pretty',
  'I   I',
  '  p  ',
  'I   I'], {
  'I': <ore:barsIron>, // Iron Bars
  'p': <ore:paper>,    // Paper
});

// [Collection Plate]*2 from [Wooden Hopper][+1]
craft.remake(<randomthings:plate_collection> * 2, ['pretty',
  '□   □',
  '  W  ',
  '□   □'], {
  '□': <randomthings:ingredient:8>, // Plate Base
  'W': <tconstruct:wooden_hopper>,  // Wooden Hopper
});

// [Extraction Plate]*2 from [Wooden Hopper][+2]
craft.remake(<randomthings:plate_extraction> * 2, ['pretty',
  '□ ‚ □',
  '‚ W ‚',
  '□ ‚ □'], {
  '□': <randomthings:ingredient:8>, // Plate Base
  '‚': <ore:nuggetFakeIron>,        // Iron Alloy Nugget
  'W': <tconstruct:wooden_hopper>,  // Wooden Hopper
});

// [Ender Anchor] from [Reinforced Obsidian][+2]
craft.remake(<randomthings:enderanchor>, ['pretty',
  'S E S',
  'S R S',
  'S S S'], {
  'S': <randomthings:stableenderpearl>,     // Stable Ender Pearl
  'E': <randomthings:ingredient:2>,         // Ectoplasm
  'R': <enderio:block_reinforced_obsidian>, // Reinforced Obsidian
});

// Conflict with Compressed Sticks
// [Block of Sticks] from [Stick]
craft.remake(<randomthings:blockofsticks> * 8, ['pretty',
  '# # #',
  '#   #',
  '# # #'], {
  '#': <ore:stickWood>, // Stick
});

// Cheaper but use more specific ingredients (basalt)
// [Inventory Rerouter] from [Wooden Hopper][+2]
craft.remake(<randomthings:inventoryrerouter>, ['pretty',
  'B s B',
  's W s',
  'B s B'], {
  'B': <ore:stoneBasalt>, // Basalt
  's': <ore:stone>, // Stone
  'W': <tconstruct:wooden_hopper>, // Wooden Hopper
});

// Magic Bean alt
furnace.addRecipe(<randomthings:beans:2>, <twilightforest:magic_beans>, 50);
scripts.jei.crafting_hints.add1to1(<randomthings:beans:2>, <randomthings:beanpod>);

// Used as ingredient
// [Biome Glass]*8 from [Empowered Palis Crystal Block][+2]
recipes.remove(<randomthings:biomeglass>);
scripts.mods.forestry.ThermionicFabricator.addCast(<randomthings:biomeglass> * 8, Grid([
  ' ╳',
  ' *',
  ' ▬'], {
  '╳': <ore:itemPulsatingCrystal>, // Pulsating Crystal
  '*': <actuallyadditions:block_crystal_empowered:1>, // Empowered Palis Crystal Block
  '▬': <ore:ingotPlatinum>,        // Platinum Ingot
}).shaped(), <fluid:glass> * 4000);

// Defined by decaying of corals
for i in 0 .. 5 {
  val stone = <randomthings:biomestone>.definition.makeStack(i);
  recipes.remove(stone);
  if (i==0) continue;
  mods.chisel.Carving.addVariation('biome_stone', stone);
}
furnace.addRecipe(<randomthings:biomestone:1>, <randomthings:biomestone>, 0.5);

// Cheaper to use as ingredient
craft.remake(<darkutils:monolith>, ['pretty',
  'S ▲ S',
  'S M S',
  'S ▲ S'], {
  '▲': <ore:dustEmerald>,         // Crushed Emerald
  'S': <ore:itemXP>, // Solidified Experience
  'M': <tconstruct:materials:19>, // Mending Moss
});

// Cheaper platforms
craft.remake(<randomthings:platform> * 6, ['###', ' F '], { '#': <minecraft:planks>,'F': <randomthings:ingredient:7> });
craft.remake(<randomthings:platform:1> * 6, ['###', ' F '], { '#': <minecraft:planks:1>,'F': <randomthings:ingredient:7> });
craft.remake(<randomthings:platform:2> * 6, ['###', ' F '], { '#': <minecraft:planks:2>,'F': <randomthings:ingredient:7> });
craft.remake(<randomthings:platform:3> * 6, ['###', ' F '], { '#': <minecraft:planks:3>,'F': <randomthings:ingredient:7> });
craft.remake(<randomthings:platform:4> * 6, ['###', ' F '], { '#': <minecraft:planks:4>,'F': <randomthings:ingredient:7> });
craft.remake(<randomthings:platform:5> * 6, ['###', ' F '], { '#': <minecraft:planks:5>,'F': <randomthings:ingredient:7> });
craft.remake(<randomthings:superlubricentplatform> * 6, ['SSS', ' F '], { 'S': <randomthings:superlubricentice>,'F': <randomthings:ingredient:7> });

// Bricks from any brick
for i, dye in scripts.vars.oreDye {
  craft.remake(<randomthings:stainedbrick>.definition.makeStack(i) * 8, ['pretty',
    '- - -',
    '- d -',
    '- - -'], {
    'd': dye,
    '-': <ore:blockBricks>,
  });
}
