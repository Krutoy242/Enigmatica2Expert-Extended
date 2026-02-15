#modloaded quark harvestcraft

import crafttweaker.item.IItemStack;

scripts.lib.loot.tweak('quark:entities/crab', 'legs', 'quark:crab_leg', null, [<harvestcraft:crabrawitem>], [1,3]);

// Quark Polished Marble
val marble = <ore:stoneMarble>;
recipes.removeShaped(<quark:marble:1>);
recipes.addShaped('Polished Marble', <quark:marble:1> * 9,
  [[marble, marble, marble],
    [marble, marble, marble],
    [marble, marble, marble]]);

// Quark Marble Wall Oredicted version
recipes.remove(<quark:marble_wall>);
recipes.addShaped('Quark Marble Wall',
  <quark:marble_wall> * 6,
  [[<ore:stoneMarble>, <ore:stoneMarble>, <ore:stoneMarble>],
    [<ore:stoneMarble>, <ore:stoneMarble>, <ore:stoneMarble>]]);

// Prevent melting dupe
craft.remake(<quark:obsidian_pressure_plate>, ['AA', 'AA'], { A: <ore:obsidian> });

// Melt sugar
scripts.process.melt(<ore:blockSugar>, <fluid:sugar> * (144 * 9));

// Conflict recipes
recipes.removeByRecipeName('quark:basalt_1');

// COnflict with Cathedral
craft.remake(<quark:basalt_speleothem> * 12, ['pretty',
  'B B',
  'B B',
  'B B'], {
  'B': <ore:stoneBasalt>,
});
craft.remake(<quark:endstone_speleothem> * 12, ['pretty',
  'B B',
  'B B',
  'B B'], {
  'B': <ore:oc:stoneEndstone>,
});
craft.remake(<quark:obsidian_speleothem> * 12, ['pretty',
  'B B',
  'B B',
  'B B'], {
  'B': <ore:obsidian>,
});

// Cheaper decorative blocks for building
craft.remake(<quark:charred_nether_bricks> * 32, ['pretty',
  'N N N',
  'N F N',
  'N N N'], {
  'N': <minecraft:nether_brick>,
  'F': <minecraft:fire_charge>,
});

recipes.removeByRecipeName("quark:iron_plate");
craft.make(<quark:iron_plate> * 48, ['pretty',
  '▬ ▬ ▬',
  '▬   ▬',
  '▬ ▬ ▬'], {
  '▬': <ore:ingotFakeIron>,
});

craft.remake(<quark:iron_plate:1> * 48, ['pretty',
  '▬ ▬ ▬',
  '▬ A ▬',
  '▬ ▬ ▬'], {
  '▬': <ore:ingotFakeIron>,
  'A': <ore:listAllwater>,
});

craft.make(<quark:iron_plate:1> * 8, ['pretty',
  '□ □ □',
  '□ A □',
  '□ □ □'], {
  '□': <quark:iron_plate>,
  'A': <ore:listAllwater>,
});

// Prevent duping with cheaper recipe
mods.tconstruct.Melting.removeRecipe(<fluid:iron>, <quark:iron_plate:1>);

// Too easy recipe
recipes.removeByRecipeName('quark:basalt');

recipes.remove(<quark:stone_basalt_slab>);
recipes.addShaped('oredicted_slab', <quark:stone_basalt_slab> * 6, [[<ore:stoneBasalt>, <ore:stoneBasalt>, <ore:stoneBasalt>]]);
mods.chisel.Carving.addVariation('basaltslab', <quark:stone_basalt_slab>);
mods.chisel.Carving.addVariation('basaltslab', <quark:stone_basalt_bricks_slab>);

// Fix recipes (each original quark recipe use basalt bricks for some reason)
for i in [
/* Inject_js(getSubMetas('quark:world_stone_carved').map(s=>s+',').join(' ')) */
0, 1, 2, 3, 4, 5, 6, 7,
/**/
] as int[] {
  if (i == 3) continue;
  craft.remake(<quark:world_stone_carved>.definition.makeStack(i) * 8, ['pretty',
    'G G G',
    'G   G',
    'G G G'], {
    'G': <quark:world_stone_bricks>.definition.makeStack(i), // Bricks
  });
}

// Fix conflicts with compressed
val mcWoodLogs = [
  <minecraft:log>,
  <minecraft:log:1>,
  <minecraft:log:2>,
  <minecraft:log:3>,
  <minecraft:log2>,
  <minecraft:log2:1>,
] as IItemStack[];
for i, log in mcWoodLogs {
  craft.remake(<quark:bark>.definition.makeStack(i) * 17, ['pretty',
    'G G G',
    'G c G',
    'G G G'], {
    'G': mcWoodLogs[i],
    'c': <additionalcompression:logwood_compressed>,
  });
}

// Fix conflicts with CoT compressed granite
recipes.remove(<quark:world_stone_pavement:*>);

// [Iron Rod] from [Slime in a Bucket][+2]
craft.remake(<quark:iron_rod> * 3, ['pretty',
  '  ╱ ╱',
  'B ~ ╱',
  'B B  '], {
  '╱': <ore:stickIron>,      // Iron Rod
  '~': <quark:slime_bucket:*>, // Slime in a Bucket
  'B': <ore:stoneBrimstone>, // Brimstone
});

// [Backpack] from [Iron Rod][+2]
craft.make(<quark:backpack>, ['pretty',
  '  ▬  ',
  'J / J',
  'J J J'], {
  '▬': <ore:ingotAlubrass>,
  'J': <ore:stoneJasper>,     // Jasper
  '/': <quark:iron_rod>,      // Iron Rod
});

// Alt usage
scripts.process.extract(<quark:glowcelium>, <thermalfoundation:material:2049>, 'No Exceptions');

// Turn Heart of diamond into Empowered Diamond with rat
mods.rats.recipes.addGemcutterRatRecipe(<quark:diamond_heart>, <actuallyadditions:item_crystal_empowered:2>);

// [White Candle] from [String][+1]
recipes.removeByRecipeName('quark:candle');
craft.make(<quark:candle> * 8, ['s','t','t'], {
  's': <ore:string>, // String
  't': <ore:tallow>, // Tallow
});

// [Paper Lamp] from [White Candle][+1]
craft.reshapeless(<quark:paper_lantern> * 4, 'C■', {
  'C': <forestry:carton>, // Carton
  '■': <ore:blockCandle>, // White Candle
});

// [Slime in a Bucket] from [Bucket][+1]
craft.shapeless(<quark:slime_bucket>, '§~', {
  '§': <randomthings:slimecube>, // Slime Cube
  '~': <minecraft:bucket>,       // Bucket
});

// [Monster Box] from [Truffle][+1]
craft.shaped(<quark:monster_box>, ['---', '-M-', '---'], {
  'M': <minecraft:mob_spawner>, // Monster Spawner
  '-': <iceandfire:dreadwood_planks>,
});

// Recipe added with another mod
recipes.remove(<quark:gravisand>);

recipes.removeByRecipeName('quark:turf');
recipes.addShapeless('turf any grass', <quark:turf>, [<ore:grassTall>, <ore:grassTall>, <ore:grassTall>, <ore:grassTall>]);

// [Cave root]
mods.thaumcraft.Crucible.registerRecipe(
  'quark:root', // Name
  'HEDGEALCHEMY@1', // Research
  <quark:root>, // Output
  <harvestcraft:ediblerootitem>, // Input
  Aspects('5🌱')
);

// [Blue sprout]
mods.thaumcraft.Crucible.registerRecipe(
  'quark:root_flower_blue', // Name
  'HEDGEALCHEMY@1', // Research
  <quark:root_flower>, // Output
  <harvestcraft:ediblerootitem>, // Input
  Aspects('5🛠️')
);

// [Black sprout]
mods.thaumcraft.Crucible.registerRecipe(
  'quark:root_flower_black', // Name
  'HEDGEALCHEMY@1', // Research
  <quark:root_flower:1>, // Output
  <harvestcraft:ediblerootitem>, // Input
  Aspects('5🌑')
);

// [White sprout]
mods.thaumcraft.Crucible.registerRecipe(
  'quark:root_flower_white', // Name
  'HEDGEALCHEMY@1', // Research
  <quark:root_flower:2>, // Output
  <harvestcraft:ediblerootitem>, // Input
  Aspects('5💪')
);

// Peaceful Skyblock alt
// [Archaeologist Hat] from [Zebrawood Wood Planks (Fireproof)]
craft.make(<quark:archaeologist_hat>, ['pretty',
  '# # #',
  '#   #'], {
  '#': <ore:plankFireproof>,
});
