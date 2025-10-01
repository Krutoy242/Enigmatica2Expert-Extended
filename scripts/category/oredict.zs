#ignoreBracketErrors
#priority 1000
#reloadable

import crafttweaker.item.IItemStack;
import crafttweaker.oredict.IOreDictEntry;

// *======= Safe versions for functions =======*
// Can avoid NPE when mods removed
function add(ore as IOreDictEntry, item as IItemStack) as void {
  if (!isNull(item)) ore.add(item);
}

function addItems(ore as IOreDictEntry, items as IItemStack[]) as void {
  for item in items {
    if (!isNull(item)) ore.add(item);
  }
}

function remove(ore as IOreDictEntry, item as IItemStack) as void {
  if (!isNull(item)) ore.remove(item);
}

function removeItems(ore as IOreDictEntry, items as IItemStack[]) as void {
  for item in items {
    if (!isNull(item)) ore.remove(item);
  }
}
// *===========================================*

addItems(<ore:itemJar>, [
  <twilightforest:firefly_jar>,
  <thaumcraft:jar_normal>,
  <biomesoplenty:jar_empty>,
  <iceandfire:jar_empty>,
]);

// Oredicts for pressure plates
addItems(<ore:pressurePlateWood>, [
  <twilightforest:twilight_oak_plate>,
  <twilightforest:canopy_plate>,
  <twilightforest:mangrove_plate>,
  <twilightforest:dark_plate>,
  <twilightforest:time_plate>,
  <twilightforest:trans_plate>,
  <twilightforest:mine_plate>,
  <twilightforest:sort_plate>,
]);

// Fixing Mortar and Pestle oredict from Pam's
add(<ore:pestleAndMortar>, <harvestcraft:mortarandpestleitem>);

// Fixing mushroom-y things
add(<ore:mushroomAny>, <harvestcraft:whitemushroomitem>);

// Removing Pam's in-world Apple from cropApple
remove(<ore:cropApple>, <harvestcraft:pamapple>);

add(<ore:foodButter>, <nuclearcraft:cocoa_butter>);

// Cobalt Block issues
remove(<ore:oreCobalt>, <tconstruct:metal>);
removeItems(<ore:oreArdite>, [<tconstruct:metal>, <tconstruct:ore>]);

// Fixing the Mineralis Ritual
remove(<ore:oreNickel>, <immersiveengineering:ore:4>);
removeItems(<ore:oreSilver>, [<iceandfire:silver_ore>, <immersiveengineering:ore:3>]);
removeItems(<ore:oreTin>, [<forestry:resources:2>, <ic2:resource:3>, <nuclearcraft:ore:1>, <mekanism:oreblock:2>, <libvulpes:ore0:5>]);
removeItems(<ore:oreAluminum>, [<immersiveengineering:ore:1>, <libvulpes:ore0:9>]);
removeItems(<ore:oreCopper>, [<immersiveengineering:ore>, <ic2:resource:1>, <forestry:resources:1>, <nuclearcraft:ore>, <mekanism:oreblock:1>, <libvulpes:ore0:4>]);
removeItems(<ore:oreLead>, [<ic2:resource:2>, <immersiveengineering:ore:2>, <nuclearcraft:ore:2>]);
removeItems(<ore:oreUranium>, [<ic2:resource:4>, <nuclearcraft:ore:4>]);

// Casings
add(<ore:casingBronze>, <ic2:casing>);
add(<ore:casingCopper>, <ic2:casing:1>);
add(<ore:casingGold>, <ic2:casing:2>);
add(<ore:casingIron>, <ic2:casing:3>);
add(<ore:casingLead>, <ic2:casing:4>);
add(<ore:casingSteel>, <ic2:casing:5>);
add(<ore:casingTin>, <ic2:casing:6>);

// Seeds
add(<ore:seedAluminium>, <mysticalagriculture:aluminum_seeds>);
add(<ore:seedAmber>, <mysticalagriculture:amber_seeds>);
add(<ore:seedAmethyst>, <mysticalagriculture:ender_amethyst_seeds>);
add(<ore:seedApatite>, <mysticalagriculture:apatite_seeds>);
add(<ore:seedAquamarine>, <mysticalagriculture:aquamarine_seeds>);
add(<ore:seedArdite>, <mysticalagriculture:ardite_seeds>);
add(<ore:seedAstralStarmetal>, <mysticalagriculture:starmetal_seeds>);
add(<ore:seedAwakenedDraconium>, <mysticalagradditions:awakened_draconium_seeds>);
add(<ore:seedBoron>, <mysticalagriculture:boron_seeds>);
add(<ore:seedCertusQuartz>, <mysticalagriculture:certus_quartz_seeds>);
add(<ore:seedCoal>, <mysticalagriculture:coal_seeds>);
add(<ore:seedCobalt>, <mysticalagriculture:cobalt_seeds>);
add(<ore:seedCopper>, <mysticalagriculture:copper_seeds>);
add(<ore:seedCreosolite>, <mysticalcreations:creosolite_seeds>);
add(<ore:seedDiamond>, <mysticalagriculture:diamond_seeds>);
add(<ore:seedDragonEgg>, <mysticalagradditions:dragon_egg_seeds>);
add(<ore:seedDraconium>, <mysticalagriculture:draconium_seeds>);
add(<ore:seedEnd>, <mysticalagriculture:end_seeds>);
add(<ore:seedEnderium>, <mysticalagriculture:enderium_seeds>);
add(<ore:seedFieryIngot>, <mysticalagriculture:fiery_ingot_seeds>);
add(<ore:seedFluix>, <mysticalagriculture:fluix_seeds>);
add(<ore:seedFluxedElectrum>, <mysticalagriculture:fluxed_electrum_seeds>);
add(<ore:seedGlowstone>, <mysticalagriculture:glowstone_seeds>);
add(<ore:seedGold>, <mysticalagriculture:gold_seeds>);
add(<ore:seedIridium>, <mysticalagriculture:iridium_seeds>);
add(<ore:seedIron>, <mysticalagriculture:iron_seeds>);
add(<ore:seedIronwood>, <mysticalagriculture:ironwood_seeds>);
add(<ore:seedKnightmetal>, <mysticalagriculture:knightmetal_seeds>);
add(<ore:seedKnightslime>, <mysticalagriculture:knightslime_seeds>);
add(<ore:seedLapis>, <mysticalagriculture:lapis_lazuli_seeds>);
add(<ore:seedLead>, <mysticalagriculture:lead_seeds>);
add(<ore:seedLithium>, <mysticalagriculture:lithium_seeds>);
add(<ore:seedMagnesium>, <mysticalagriculture:magnesium_seeds>);
add(<ore:seedMalachite>, <mysticalagriculture:malachite_seeds>);
add(<ore:seedMysticalFlower>, <mysticalagriculture:mystical_flower_seeds>);
add(<ore:seedNature>, <mysticalagriculture:nature_seeds>);
add(<ore:seedNether>, <mysticalagriculture:nether_seeds>);
add(<ore:seedNetherStar>, <mysticalagradditions:nether_star_seeds>);
add(<ore:seedNeutronium>, <mysticalagradditions:neutronium_seeds>);
add(<ore:seedNickel>, <mysticalagriculture:nickel_seeds>);
add(<ore:seedObsidian>, <mysticalagriculture:obsidian_seeds>);
add(<ore:seedOsmium>, <mysticalagriculture:osmium_seeds>);
add(<ore:seedPeridot>, <mysticalagriculture:peridot_seeds>);
add(<ore:seedPlatinum>, <mysticalagriculture:platinum_seeds>);
add(<ore:seedQuartz>, <mysticalagriculture:nether_quartz_seeds>);
add(<ore:seedQuartzBlack>, <mysticalagriculture:black_quartz_seeds>);
add(<ore:seedRedstone>, <mysticalagriculture:redstone_seeds>);
add(<ore:seedRockCrystal>, <mysticalagriculture:rock_crystal_seeds>);
add(<ore:seedRuby>, <mysticalagriculture:ruby_seeds>);
add(<ore:seedSapphire>, <mysticalagriculture:sapphire_seeds>);
add(<ore:seedSilver>, <mysticalagriculture:silver_seeds>);
add(<ore:seedSkyStone>, <mysticalagriculture:sky_stone_seeds>);
add(<ore:seedSteeleaf>, <mysticalagriculture:steeleaf_seeds>);
add(<ore:seedSulfur>, <mysticalagriculture:sulfur_seeds>);
add(<ore:seedTanzanite>, <mysticalagriculture:tanzanite_seeds>);
add(<ore:seedTerrasteel>, <mysticalagriculture:terrasteel_seeds>);
add(<ore:seedThaumium>, <mysticalagriculture:thaumium_seeds>);
add(<ore:seedThorium>, <mysticalagriculture:thorium_seeds>);
add(<ore:seedTin>, <mysticalagriculture:tin_seeds>);
add(<ore:seedTopaz>, <mysticalagriculture:topaz_seeds>);
add(<ore:seedUltimate>, <mysticalcreations:ultimate_seeds>);
add(<ore:seedUranium>, <mysticalagriculture:uranium_seeds>);
add(<ore:seedVoidMetal>, <mysticalagriculture:void_metal_seeds>);

// Essences
add(<ore:essenceAluminium>, <mysticalagriculture:aluminum_essence>);
add(<ore:essenceAmber>, <mysticalagriculture:amber_essence>);
add(<ore:essenceAmethyst>, <mysticalagriculture:ender_amethyst_essence>);
add(<ore:essenceApatite>, <mysticalagriculture:apatite_essence>);
add(<ore:essenceAquamarine>, <mysticalagriculture:aquamarine_essence>);
add(<ore:essenceArdite>, <mysticalagriculture:ardite_essence>);
add(<ore:essenceAstralStarmetal>, <mysticalagriculture:starmetal_essence>);
add(<ore:essenceBoron>, <mysticalagriculture:boron_essence>);
add(<ore:essenceCertusQuartz>, <mysticalagriculture:certus_quartz_essence>);
add(<ore:essenceCoal>, <mysticalagriculture:coal_essence>);
add(<ore:essenceCobalt>, <mysticalagriculture:cobalt_essence>);
add(<ore:essenceCopper>, <mysticalagriculture:copper_essence>);
add(<ore:essenceDiamond>, <mysticalagriculture:diamond_essence>);
add(<ore:essenceDraconium>, <mysticalagriculture:draconium_essence>);
add(<ore:essenceEnderium>, <mysticalagriculture:enderium_essence>);
add(<ore:essenceFieryIngot>, <mysticalagriculture:fiery_ingot_essence>);
add(<ore:essenceGold>, <mysticalagriculture:gold_essence>);
add(<ore:essenceIridium>, <mysticalagriculture:iridium_essence>);
add(<ore:essenceIron>, <mysticalagriculture:iron_essence>);
add(<ore:essenceIronwood>, <mysticalagriculture:ironwood_essence>);
add(<ore:essenceKnightmetal>, <mysticalagriculture:knightmetal_essence>);
add(<ore:essenceKnightslime>, <mysticalagriculture:knightslime_essence>);
add(<ore:essenceLapis>, <mysticalagriculture:lapis_lazuli_essence>);
add(<ore:essenceLead>, <mysticalagriculture:lead_essence>);
add(<ore:essenceLithium>, <mysticalagriculture:lithium_essence>);
add(<ore:essenceMagnesium>, <mysticalagriculture:magnesium_essence>);
add(<ore:essenceMalachite>, <mysticalagriculture:malachite_essence>);
add(<ore:essenceNickel>, <mysticalagriculture:nickel_essence>);
add(<ore:essenceOsmium>, <mysticalagriculture:osmium_essence>);
add(<ore:essencePeridot>, <mysticalagriculture:peridot_essence>);
add(<ore:essencePlatinum>, <mysticalagriculture:platinum_essence>);
add(<ore:essenceQuartz>, <mysticalagriculture:nether_quartz_essence>);
add(<ore:essenceQuartzBlack>, <mysticalagriculture:black_quartz_essence>);
add(<ore:essenceRedstone>, <mysticalagriculture:redstone_essence>);
add(<ore:essenceRuby>, <mysticalagriculture:ruby_essence>);
add(<ore:essenceSapphire>, <mysticalagriculture:sapphire_essence>);
add(<ore:essenceSilver>, <mysticalagriculture:silver_essence>);
add(<ore:essenceTanzanite>, <mysticalagriculture:tanzanite_essence>);
add(<ore:essenceThaumium>, <mysticalagriculture:thaumium_essence>);
add(<ore:essenceThorium>, <mysticalagriculture:thorium_essence>);
add(<ore:essenceTin>, <mysticalagriculture:tin_essence>);
add(<ore:essenceTopaz>, <mysticalagriculture:topaz_essence>);
add(<ore:essenceUranium>, <mysticalagriculture:uranium_essence>);
add(<ore:essenceVoidMetal>, <mysticalagriculture:void_metal_essence>);

// Slag
add(<ore:crystalSlag>, <ic2:misc_resource:5>);

// String isn't flax, wut
remove(<ore:cropFlax>, <minecraft:string>);

// Glowing Mushrooms
add(<ore:mushroomAny>, <nuclearcraft:glowing_mushroom>);
add(<ore:mushroomAny>, <randomthings:glowingmushroom>);
add(<ore:mushroomGlowing>, <nuclearcraft:glowing_mushroom>);
add(<ore:mushroomGlowing>, <randomthings:glowingmushroom>);

// Removing hoes from oredict
for item in <ore:toolHoe>.items {
  remove(<ore:toolHoe>, item);
}

// Pam's Apple
add(<ore:cropApple>, <harvestcraft:pamapple>);
add(<ore:listAllfruit>, <harvestcraft:pamapple>);

// Remove annoying sticks
removeItems(<ore:stickWood>, [<biomesoplenty:bamboo>, <biomesoplenty:plant_1:5>]);

// Boat Oredict
addItems(<ore:boat>, [
  <minecraft:boat>,
  <minecraft:spruce_boat>,
  <minecraft:birch_boat>,
  <minecraft:jungle_boat>,
  <minecraft:acacia_boat>,
  <minecraft:dark_oak_boat>,
  <biomesoplenty:boat_sacred_oak>,
  <biomesoplenty:boat_cherry>,
  <biomesoplenty:boat_umbran>,
  <biomesoplenty:boat_fir>,
  <biomesoplenty:boat_ethereal>,
  <biomesoplenty:boat_magic>,
  <biomesoplenty:boat_mangrove>,
  <biomesoplenty:boat_palm>,
  <biomesoplenty:boat_redwood>,
  <biomesoplenty:boat_willow>,
  <biomesoplenty:boat_pine>,
  <biomesoplenty:boat_hellbark>,
  <biomesoplenty:boat_jacaranda>,
  <biomesoplenty:boat_mahogany>,
  <biomesoplenty:boat_ebony>,
  <biomesoplenty:boat_eucalyptus>,
  <immersivepetroleum:speedboat>,
  <immersivepetroleum:upgrades>,
  <ic2:boat:3>,
]);

addItems(<ore:terracottaGlazed>, [
  <minecraft:orange_glazed_terracotta>,
  <minecraft:magenta_glazed_terracotta>,
  <minecraft:light_blue_glazed_terracotta>,
  <minecraft:yellow_glazed_terracotta>,
  <minecraft:lime_glazed_terracotta>,
  <minecraft:pink_glazed_terracotta>,
  <minecraft:gray_glazed_terracotta>,
  <minecraft:silver_glazed_terracotta>,
  <minecraft:cyan_glazed_terracotta>,
  <minecraft:purple_glazed_terracotta>,
  <minecraft:blue_glazed_terracotta>,
  <minecraft:brown_glazed_terracotta>,
  <minecraft:green_glazed_terracotta>,
  <minecraft:red_glazed_terracotta>,
  <minecraft:black_glazed_terracotta>,
  <minecraft:white_glazed_terracotta>,
]);

// Mycelium Oredict
add(<ore:mycelium>, <biomesoplenty:grass:8>);

// Biomesoplenty Dirt
addItems(<ore:dirt>, [
  <biomesoplenty:dirt:8>,
  <biomesoplenty:dirt:9>,
  <biomesoplenty:dirt:1>,
  <biomesoplenty:dirt:10>,
  <biomesoplenty:dirt:2>,
]);

// Coarse Dirt
addItems(<ore:dirtCoarse>, [
  <minecraft:dirt:1>,
  <biomesoplenty:dirt:8>,
  <biomesoplenty:dirt:9>,
  <biomesoplenty:dirt:10>,
]);

// Enhanced Ender Ingot
add(<ore:ingotEnderEnhanced>, <extendedcrafting:material:48>);

// Venison Oredict
addItems(<ore:listAllmeatraw>, [
  <betteranimalsplus:eel_meat_raw>,
]);

addItems(<ore:listAllmeatcooked>, [
  <betteranimalsplus:eel_meat_cooked>,
]);
add(<ore:listAllmeatcooked>, <twilightforest:cooked_meef>);
remove(<ore:feather>, <twilightforest:raven_feather>);

addItems(<ore:itemFiery>, [
  <twilightforest:fiery_blood>,
  <twilightforest:fiery_tears>,
]);

// Void Metal Block
add(<ore:blockVoid>, <thaumcraft:metal_void>);

// Circuit Board
add(<ore:circuitBoard>, <immersiveengineering:material:27>);

// Amber Oredict
add(<ore:blockAmber>, <thaumcraft:amber_block>);
add(<ore:blockAmber>, <thaumcraft:amber_brick>);

// Make nuggets more useful
addItems(<ore:listAllmeatcooked>, [
  <thaumcraft:chunk:0>,
  <thaumcraft:chunk:1>,
  <thaumcraft:chunk:2>,
  // <thaumcraft:chunk:3>,
  <thaumcraft:chunk:4>,
  <thaumcraft:chunk:5>,
]);
add(<ore:listAllfishcooked>, <thaumcraft:chunk:3>);
add(<ore:listAllfishraw>, <harvestcraft:eelrawitem>);
add(<ore:listAllfishfresh>, <harvestcraft:eelrawitem>);

// Blood Magic Runes
add(<ore:runeBlood>, <bloodmagic:blood_rune:*>);

// CakeDict(TM)
addItems(<ore:foodCake>, [
  <minecraft:cake>,
  <actuallyadditions:item_food:8>,
  <harvestcraft:carrotcakeitem>,
  <harvestcraft:cheesecakeitem>,
  <harvestcraft:cherrycheesecakeitem>,
  <harvestcraft:chocolatesprinklecakeitem>,
  <harvestcraft:holidaycakeitem>,
  <harvestcraft:pineappleupsidedowncakeitem>,
  <harvestcraft:pumpkincheesecakeitem>,
  <harvestcraft:redvelvetcakeitem>,
  <harvestcraft:lemondrizzlecakeitem>,
]);

// AA cheese
add(<ore:foodCheese>, <actuallyadditions:item_food>);

// Wither Dust
add(<ore:dustWither>, <darkutils:material>);
add(<ore:dustWither>, <quark:black_ash>);

// Astral Sorcery compatibility for Chisel marble
add(<ore:blockMarble>, <chisel:marble2:7>);

// Fertilizer
addItems(<ore:fertilizer>, [
  <ic2:crop_res:2>,
  <actuallyadditions:item_fertilizer>,
  <minecraft:dye:15>,
  <industrialforegoing:fertilizer>,
  <forestry:fertilizer_compound>,
  <mysticalagriculture:fertilized_essence>,
  <thermalfoundation:fertilizer>,
  <thermalfoundation:fertilizer:1>,
  <thermalfoundation:fertilizer:2>,
]);

// Sawdust compat
add(<ore:pulpWood>, <thermalfoundation:material:800>);
removeItems(<ore:pulpWood>, [<mekanism:sawdust>, <forestry:wood_pulp>]);
removeItems(<ore:dustWood>, [<mekanism:sawdust>, <excompressum:wood_chippings>]);

// Diamond Chip
add(<ore:nuggetDiamond>, <opencomputers:material:29>);
add(<ore:chipDiamond>, <thermalfoundation:material:16>);

// Dragon hearts
add(<ore:heartDragon>, <draconicevolution:dragon_heart>);
add(<ore:heartDragon>, <iceandfire:fire_dragon_heart>);
add(<ore:heartDragon>, <iceandfire:ice_dragon_heart>);

// Hippogryphs
add(<ore:hippogryphEgg>, <iceandfire:hippogryph_egg:*>);

// Who would ever use hyppogryphs eggs in craft?
removeItems(<ore:egg>, [
  <iceandfire:hippogryph_egg:*>,
  <iceandfire:iceandfire.deathworm_egg:*>,
  <iceandfire:myrmex_jungle_egg:*>,
  <iceandfire:myrmex_desert_egg:*>,
]);

// Dragon Eggs
addItems(<ore:dragonEgg>, [
  <iceandfire:dragonegg_red>,
  <iceandfire:dragonegg_green>,
  <iceandfire:dragonegg_bronze>,
  <iceandfire:dragonegg_gray>,
  <iceandfire:dragonegg_blue>,
  <iceandfire:dragonegg_white>,
  <iceandfire:dragonegg_sapphire>,
  <iceandfire:dragonegg_silver>,
]);

// Crafting hammers
add(<ore:craftingToolForgeHammer>, <immersiveengineering:tool>);

// Ice&Fire Witherbone
add(<ore:boneWither>, <tconstruct:materials:17>);

// Immersive Engineering Coal Coke Block
add(<ore:blockCoalCoke>, <immersiveengineering:stone_decoration:3>);
add(<ore:blockCoalCoke>, <thermalfoundation:storage_resource:1>);

// Certus Quartz
addItems(<ore:crystalCertus>, [<appliedenergistics2:material>, <appliedenergistics2:material:1>, <appliedenergistics2:material:10>]);
addItems(<ore:blockCertusQuartz>, [<appliedenergistics2:quartz_block>, <appliedenergistics2:quartz_pillar>, <appliedenergistics2:chiseled_quartz_block>]);
remove(<ore:oreCertusQuartz>, <appliedenergistics2:charged_quartz_ore>);

// Iridium
add(<ore:ingotIridium>, <ic2:misc_resource:1>);
add(<ore:nuggetIridium>, <ic2:misc_resource:2>);

// Marble
add(<ore:stoneMarblePolished>, <astralsorcery:blockmarble:*>);

// *======= Quark Specific Oredict =======*

add(<ore:sandstone>, <quark:sandstone_new:*>);
addItems(<ore:stoneMarble>, [<quark:world_stone_bricks:4>, <quark:marble:1>]);

add(<ore:stoneGranite>, <quark:world_stone_bricks>);
add(<ore:stoneDiorite>, <quark:world_stone_bricks:1>);
add(<ore:stoneAndesite>, <quark:world_stone_bricks:2>);
addItems(<ore:stoneBasalt>, [
  <quark:world_stone_bricks:3>,
  <cathedral:basalt_block_carved>,
  <cathedral:basalt_block_carved:1>,
  <cathedral:basalt_block_carved:2>,
  <cathedral:basalt_block_carved:3>,
  <cathedral:basalt_block_carved:4>,
  <cathedral:basalt_block_carved:5>,
]);

addItems(<ore:blockBricks>, [
  <minecraft:brick_block>,
  <chisel:bricks:*>,
  <engineersdecor:slag_brick_block>,
  <randomthings:stainedbrick:*>,
]);

addItems(<ore:slabBasalt>, [
  <quark:stone_basalt_slab>,
  <cathedral:basalt_slab_carved>,
  <cathedral:basalt_slab_carved:1>,
  <cathedral:basalt_slab_carved:2>,
  <cathedral:basalt_slab_carved:3>,
  <cathedral:basalt_slab_carved:4>,
  <cathedral:basalt_slab_carved:5>,
  <cathedral:basalt_slab_carved:6>,
]);

addItems(<ore:grassTall>, [
  <biomesoplenty:plant_0>,
  <biomesoplenty:plant_0:1>,
  <biomesoplenty:plant_0:7>,
  <biomesoplenty:plant_0:8>,
  <biomesoplenty:plant_0:13>,
  <biomesoplenty:plant_0:14>,
  <biomesoplenty:plant_1>,
  <minecraft:tallgrass:1>,
  <twilightforest:twilight_plant:5>,
  <tconstruct:slime_grass_tall>,
  <tconstruct:slime_grass_tall:4>,
  <tconstruct:slime_grass_tall:8>,
  <biomesoplenty:plant_0:11>,
  <biomesoplenty:plant_1:7>,
  <biomesoplenty:ivy>,
  <biomesoplenty:willow_vine>,
]);

// *======= This section was Made by Ordinator & the AllTheMods team =======*
// All credit for this script goes to Ordinator and the ATM team
// This script is borrowed from All The Mods 3 with permission. I have removed
// a few things, and added a few things.

add(<ore:stoneLimestone>, <quark:limestone:1>);
add(<ore:stoneLimestone>, <quark:world_stone_bricks:5>);

// *======= Planks =======*
addItems(<ore:plankWood>, [
  <rustic:painted_wood_white>,
  <rustic:painted_wood_orange>,
  <rustic:painted_wood_purple>,
  <rustic:painted_wood_blue>,
  <rustic:painted_wood_brown>,
  <rustic:painted_wood_green>,
  <rustic:painted_wood_red>,
  <rustic:painted_wood_black>,
  <rustic:painted_wood_magenta>,
  <rustic:painted_wood_light_blue>,
  <rustic:painted_wood_yellow>,
  <rustic:painted_wood_lime>,
  <rustic:painted_wood_pink>,
  <rustic:painted_wood_gray>,
  <rustic:painted_wood_silver>,
  <rustic:painted_wood_cyan>,
  <rustic:planks:*>,
  <biomesoplenty:planks_0:*>,
  <chisel:planks-acacia:*>,
  <chisel:planks-birch:*>,
  <chisel:planks-dark-oak:*>,
  <chisel:planks-jungle:*>,
  <chisel:planks-oak:*>,
  <chisel:planks-spruce:*>,
  <forestry:planks.0:*>,
  <forestry:planks.1:*>,
  <forestry:planks.fireproof.0:*>,
  <forestry:planks.fireproof.1:*>,
  <forestry:planks.vanilla.fireproof.0:*>,
  <minecraft:planks:*>,
]);

// *======= Beds =======*
add(<ore:bed>, <minecraft:bed:*>);

// *======= Trapdoors =======*

addItems(<ore:trapdoorWood>, [
  <minecraft:trapdoor>,
  <quark:dark_oak_trapdoor>,
  <quark:spruce_trapdoor>,
  <quark:birch_trapdoor>,
  <quark:jungle_trapdoor>,
  <quark:acacia_trapdoor>,
]);

// *======= Doors =======*
addItems(<ore:doorWood>, [
  <minecraft:wooden_door>,
  <biomesoplenty:fir_door>,
  <biomesoplenty:cherry_door>,
  <biomesoplenty:ebony_door>,
  <biomesoplenty:ethereal_door>,
  <biomesoplenty:eucalyptus_door>,
  <biomesoplenty:hellbark_door>,
  <biomesoplenty:jacaranda_door>,
  <biomesoplenty:magic_door>,
  <biomesoplenty:mahogany_door>,
  <biomesoplenty:mangrove_door>,
  <biomesoplenty:palm_door>,
  <biomesoplenty:pine_door>,
  <biomesoplenty:redwood_door>,
  <biomesoplenty:sacred_oak_door>,
  <biomesoplenty:umbran_door>,
  <biomesoplenty:willow_door>,
  <forestry:doors.acacia>, // Desert Acacia Door
  <forestry:doors.balsa>, // Balsa Door
  <forestry:doors.baobab>, // Baobab Door
  <forestry:doors.cherry>, // Cherry Door
  <forestry:doors.chestnut>, // Chestnut Door
  <forestry:doors.citrus>, // Citrus Door
  <forestry:doors.cocobolo>, // Cocobolo Door
  <forestry:doors.ebony>, // Ebony Door
  <forestry:doors.giganteum>, // Giant Sequoia Door
  <forestry:doors.greenheart>, // Greenheart Door
  <forestry:doors.ipe>, // Ipe Door
  <forestry:doors.kapok>, // Kapok Door
  <forestry:doors.larch>, // Larch Door
  <forestry:doors.lime>, // Lime Door
  <forestry:doors.mahoe>, // Mahoe Door
  <forestry:doors.mahogany>, // Mahogany Door
  <forestry:doors.maple>, // Maple Door
  <forestry:doors.padauk>, // Padauk Door
  <forestry:doors.palm>, // Palm Door
  <forestry:doors.papaya>, // Papaya Door
  <forestry:doors.pine>, // Pine Door
  <forestry:doors.plum>, // Plum Door
  <forestry:doors.poplar>, // Poplar Door
  <forestry:doors.sequoia>, // Sequoia Door
  <forestry:doors.teak>, // Teak Door
  <forestry:doors.walnut>, // Walnut Door
  <forestry:doors.wenge>, // Wenge Door
  <forestry:doors.willow>, // Willow Door
  <forestry:doors.zebrawood>, // Zebrawood Door
  <minecraft:acacia_door>,
  <minecraft:jungle_door>,
  <minecraft:birch_door>,
  <minecraft:spruce_door>,
  <minecraft:dark_oak_door>,
]);

// *======= Remove ender chest =======*

addItems(<ore:chest>, [
  <thaumcraft:hungry_chest>,
  <ironchest:iron_chest:7>, // Animals bonus
]);
removeItems(<ore:chest>, [
  <minecraft:ender_chest>,
  <minecraft:white_shulker_box>,
  <minecraft:orange_shulker_box>,
  <minecraft:magenta_shulker_box>,
  <minecraft:light_blue_shulker_box>,
  <minecraft:yellow_shulker_box>,
  <minecraft:lime_shulker_box>,
  <minecraft:pink_shulker_box>,
  <minecraft:gray_shulker_box>,
  <minecraft:silver_shulker_box>,
  <minecraft:cyan_shulker_box>,
  <minecraft:purple_shulker_box>,
  <minecraft:blue_shulker_box>,
  <minecraft:brown_shulker_box>,
  <minecraft:green_shulker_box>,
  <minecraft:red_shulker_box>,
  <minecraft:black_shulker_box>,
]);

// *======= Singularities =======*
addItems(<ore:machineCase>, [
  <actuallyadditions:block_misc:4>,
  <actuallyadditions:block_misc:8>,
  <actuallyadditions:block_misc:9>,
  <deepmoblearning:machine_casing>,
  <enderio:item_material:1>,
  <enderio:item_material:53>,
  <enderio:item_material:54>,
  <enderio:item_material:55>,
  <enderio:item_material:66>,
  <enderio:item_material>,
  <environmentaltech:interconnect>,
  <forestry:flexible_casing>,
  <forestry:hardened_machine>,
  <forestry:impregnated_casing>,
  <forestry:sturdy_machine>,
  <ic2:resource:12>,
  <ic2:resource:13>,
  <immersiveengineering:metal_decoration0:3>,
  <immersiveengineering:metal_decoration0:4>,
  <immersiveengineering:metal_decoration0:5>,
  <libvulpes:advstructuremachine>,
  <libvulpes:structuremachine>,
  <mekanism:basicblock:8>,
  <mysticalagriculture:mystical_machine_frame>,
  <nuclearcraft:part:10>,
  <nuclearcraft:part:11>,
  <nuclearcraft:part:12>,
  <opencomputers:case1>,
  <opencomputers:case2>,
  <opencomputers:case3>,
  <rftools:machine_frame>,
  <teslacorelib:machine_case>,
  <thaumcraft:metal_alchemical_advanced>,
  <thaumcraft:metal_alchemical>,
  <thermalexpansion:frame:64>,
  <thermalexpansion:frame:128>,
  <thermalexpansion:frame:129>,
  <thermalexpansion:frame:130>,
  <thermalexpansion:frame:131>,
  <thermalexpansion:frame:132>,
  <thermalexpansion:frame:146>,
  <thermalexpansion:frame:147>,
  <thermalexpansion:frame:148>,
  <thermalexpansion:frame>,
]);

addItems(<ore:itemBall>, [
  <actuallyadditions:item_crystal_empowered:3>,
  <actuallyadditions:item_crystal:3>,
  <actuallyadditions:item_hairy_ball>,
  <actuallyadditions:item_misc:12>,
  <appliedenergistics2:material:6>,
  <appliedenergistics2:material:9>,
  <appliedenergistics2:material:47>,
  <appliedenergistics2:material:48>,
  <avaritia:endest_pearl>,
  <avaritia:matter_cluster:*>,
  <avaritiaio:grindingballinfinity>,
  <avaritiaio:grindingballneutronium>,
  <biomesoplenty:mudball>,
  <botania:manaresource:1>,
  <botania:thirdeye>,
  <botania:vineball>,
  <buildinggadgets:construction_chunk_dense>,
  <cyclicmagic:ender_eye_orb>,
  <cyclicmagic:magic_net>,
  <cyclicmagic:stone_pebble>,
  <darkutils:material:1>,
  <darkutils:shulker_pearl>,
  <draconicevolution:reactor_core>,
  <enderio:item_alloy_ball:1>,
  <enderio:item_alloy_ball:2>,
  <enderio:item_alloy_ball:3>,
  <enderio:item_alloy_ball:4>,
  <enderio:item_alloy_ball:5>,
  <enderio:item_alloy_ball:6>,
  <enderio:item_alloy_ball:7>,
  <enderio:item_alloy_ball:8>,
  <enderio:item_alloy_ball:9>,
  <enderio:item_alloy_ball>,
  <enderio:item_alloy_endergy_ball:1>,
  <enderio:item_alloy_endergy_ball:2>,
  <enderio:item_alloy_endergy_ball:3>,
  <enderio:item_alloy_endergy_ball:4>,
  <enderio:item_alloy_endergy_ball:6>,
  <enderio:item_material:57>,
  <enderio:item_material:58>,
  <enderio:item_material:59>,
  <endreborn:item_advanced_ender_pearl>,
  <exnihilocreatio:item_material:1>,
  <extrautils2:ingredients:2>,
  <eyeofdragons:eye_of_firedragon>,
  <eyeofdragons:eye_of_icedragon>,
  <forestry:propolis:1>,
  <forestry:propolis:2>,
  <forestry:propolis:3>,
  <forestry:propolis>,
  <harvestcraft:sesameballitem>,
  <ic2:crafting:16>,
  <ic2:crafting:20>,
  <iceandfire:cockatrice_eye>,
  <industrialforegoing:mob_imprisonment_tool>,
  <mctsmelteryio:iceball>,
  <mekanism:substrate>,
  <minecraft:clay_ball>,
  <minecraft:ender_eye>,
  <minecraft:ender_pearl>,
  <minecraft:slime_ball>,
  <minecraft:snowball>,
  <randomthings:stableenderpearl>,
  <rats:cheese_cannonball>,
  <rftools:infused_enderpearl>,
  <tconstruct:edible:1>,
  <tconstruct:edible:2>,
  <tconstruct:edible:4>,
  <tconstruct:throwball:1>,
  <tconstruct:throwball>,
  <thaumcraft:focus_1>,
  <thaumcraft:focus_2>,
  <thaumcraft:focus_3>,
  <thaumcraft:primordial_pearl>,
  <thaumcraft:quicksilver>,
  <thaumicenergistics:blank_knowledge_core>,
  <thaumicenergistics:knowledge_core>,
  <thaumictinkerer:sky_pearl>,
  <thaumicwonders:meaty_orb>,
  <thaumicwonders:meteorb>,
  <thermalfoundation:material:832>,
  <thermalfoundation:material:833>,
  <trinity:am242_pit>,
  <trinity:bk248_pit>,
  <trinity:cf249_pit>,
  <trinity:cf251_pit>,
  <trinity:cm247_pit>,
  <trinity:np237_pit>,
  <trinity:pu239_pit>,
  <trinity:u233_pit>,
  <trinity:u235_pit>,
]);

for mod in ['extendedcrafting', 'avaritia', 'contenttweaker'] as string[] {
  if (!isNull(loadedMods[mod])) {
    for item in loadedMods[mod].items {
      if (item.definition.id.matches('.*singularity.*'))
        add(<ore:singularity>, item);
    }
  }
}
// *======= Conversion Recipes =======*

recipes.addShapeless('trapdoororedict1', <minecraft:trapdoor>, [<ore:trapdoorWood>]);
recipes.addShapeless('bedoredict1', <minecraft:bed>, [<ore:bed>]);

// Rats
addItems(<ore:hatArcheologist>, [<quark:archaeologist_hat:*>, <rats:archeologist_hat:*>]);
addItems(<ore:hatPirate>, [<quark:pirate_hat>, <rats:pirat_hat>]);
addItems(<ore:garbage>, [<rats:garbage_pile>]);

// Some dusts
remove(<ore:dustEnderPearl>, <ic2:dust:31>);
removeItems(<ore:dustQuartz>, [<actuallyadditions:item_dust:5>, <nuclearcraft:gem_dust:2>]);
removeItems(<ore:dustNetherQuartz>, [<actuallyadditions:item_dust:5>, <enderio:item_material:33>, <nuclearcraft:gem_dust:2>]);

// Any iceCream
addItems(<ore:listAllicecream>, itemUtils.getItemsByRegexRegistryName('harvestcraft:.*icecreamitem'));
remove(<ore:listAllicecream>, <harvestcraft:silkentofuitem>);

// Myrmex
addItems(<ore:myrmexEgg>, [<iceandfire:myrmex_desert_egg:*>, <iceandfire:myrmex_jungle_egg:*>]);
addItems(<ore:blockMyrmexResin>, [<iceandfire:myrmex_desert_resin_block>, <iceandfire:myrmex_jungle_resin_block>]);

// Milk powder as milk
addItems(<ore:listAllmilk>, [<ic2:dust:33>]);

// Bitumen
addItems(<ore:bitumen>, [<thermalfoundation:material:892>, <immersivepetroleum:material>]);

// Additional essence added with mysticalcreations
addItems(<ore:essenceTier1>, [<mysticalcreations:creosolite_essence>]);
addItems(<ore:essenceTier3>, [<mysticalagriculture:starmetal_essence>]);
add(<ore:essenceTier6>, <mysticalcreations:ultimate_essence>);

addItems(<ore:seedsTier2>, [<mysticalcreations:creosolite_seeds>]);
addItems(<ore:seedsTier3>, [<mysticalagriculture:starmetal_seeds>]);
add(<ore:seedsTier6>, <mysticalcreations:ultimate_seeds>);

// IC2 ashes to the dustAsh
for item in <ore:dustAshes>.items {
  add(<ore:dustAsh>, item);
}

// Its too hard to craft for being just obsidian
remove(<ore:gemObsidian>, <cyclicmagic:crystallized_obsidian>);
remove(<ore:gemAmber>, <cyclicmagic:crystallized_amber>);

// Mystical any crystal
addItems(<ore:infusionCrystal>, [
  <matc:inferiumcrystal>,
  <matc:intermediumcrystal>,
  <matc:prudentiumcrystal>,
  <matc:superiumcrystal>,
  <matc:supremiumcrystal>,
  <mysticalagriculture:infusion_crystal>,
  <mysticalagriculture:master_infusion_crystal>,
]);

// Slimes with TCon is not so rare, so better to keep this item separately
remove(<ore:slimeball>, <quark:slime_bucket>);

addItems(<ore:ingotFakeIron>, [<minecraft:iron_ingot>, <enderio:item_alloy_ingot:9>]);
addItems(<ore:blockFakeIron>, [<minecraft:iron_block>, <enderio:block_alloy:9>]);
addItems(<ore:nuggetFakeIron>, [<minecraft:iron_nugget>, <enderio:item_alloy_nugget:9>]);

add(<ore:ingotSpectre>, <randomthings:ingredient:3>);
add(<ore:ingotPhosphor>, <forestry:phosphor>);

addItems(<ore:blockDimensional>, [
  <rftoolsdim:dimensional_blank_block>,
  <rftoolsdim:dimensional_block>,
  <rftoolsdim:dimensional_cross_block>,
  <rftoolsdim:dimensional_cross2_block>,
  <rftoolsdim:dimensional_pattern1_block>,
  <rftoolsdim:dimensional_pattern2_block>,
  <rftoolsdim:dimensional_small_blocks>,
]);

// Remove wildcarded but keep original
remove(<ore:oreDimensionalShard>, <rftools:dimensional_shard_ore:*>);

// Remove conflicst
remove(<ore:blockGlassWhite>, <enderio:block_fused_glass>);

// Add oredict
add(<ore:blockDraconiumCharged>, <draconicevolution:draconium_block:1>);
add(<ore:blockMenril>, <integrateddynamics:crystalized_menril_block>);
add(<ore:blockSugarcane>, <quark:reed_block>);
add(<ore:blockSugar>, <quark:sugar_block>);
add(<ore:blockFlesh>, <thaumcraft:flesh_block>);

// Make draconic ore Nether/End variants like all other Nether/End ores
removeItems(<ore:oreDraconium>, [
  <draconicevolution:draconium_ore:1>,
  <draconicevolution:draconium_ore:2>,
]);
add(<ore:oreNetherDraconium>, <draconicevolution:draconium_ore:1>);
add(<ore:oreEndDraconium>, <draconicevolution:draconium_ore:2>);

// Rearrange items in Dye Oredict to better integration
// with AA [Lens Of Color]
removeItems(<ore:dyeBrown>, [<enderio:item_material:49>, <industrialforegoing:fertilizer>]);
remove(<ore:dyeGreen>, <enderio:item_material:48>);

// Add missed Ores (used for Actually Additions)
add(<ore:crushedNetherrack>, <exnihilocreatio:block_netherrack_crushed>);

// Helpful ore name
add(<ore:oreRockCrystal>, <astralsorcery:blockcustomore>);

// Remove useless oredict from redstone (from mekanism)
remove(<ore:alloyBasic>, <minecraft:redstone>);

// Remove Chorus and Menril glasses from Glass, because they are pricy
remove(<ore:blockGlass>, <integratedterminals:menril_glass>);
remove(<ore:blockGlass>, <integratedterminals:chorus_glass>);

// All items that produce about ~160 XP
addItems(<ore:itemXP>, [
  <actuallyadditions:item_solidified_experience>,
  <deepmoblearning:living_matter_overworldian>,
  <minecraft:experience_bottle>,
  <mysticalagriculture:chunk:5>,
  <mysticalagriculture:experience_essence>,
  <mysticalagriculture:xp_droplet>,
]);

// Add oredict for benefication
add(<ore:oreBenitoite>, <contenttweaker:ore_benitoite>);
add(<ore:oreAnglesite>, <contenttweaker:ore_anglesite>);
add(<ore:gemBenitoite>, <contenttweaker:benitoite>);
add(<ore:gemAnglesite>, <contenttweaker:anglesite>);

// Alien Crystals for benefication
add(<ore:aliencrystalViolet>, <advancedrocketry:crystal>);
add(<ore:aliencrystalBlue>, <advancedrocketry:crystal:1>);
add(<ore:aliencrystalGreen>, <advancedrocketry:crystal:2>);
add(<ore:aliencrystalRed>, <advancedrocketry:crystal:3>);
add(<ore:aliencrystalYellow>, <advancedrocketry:crystal:4>);
add(<ore:aliencrystalOrange>, <advancedrocketry:crystal:5>);
add(<ore:sandOxidisedFerric>, <advancedrocketry:hotturf>);

// Coil copies
add(<ore:coilGold>, <nuclearcraft:turbine_dynamo_coil:3>);
add(<ore:coilAluminum>, <nuclearcraft:turbine_dynamo_coil:2>);

// Sequoia
addItems(<ore:logSequoia>, [
  <forestry:logs.1:3>,
  <forestry:logs.6>,
  <forestry:logs.fireproof.1:3>,
  <forestry:logs.fireproof.6>,
]);
addItems(<ore:plankSequoia>, [
  <forestry:planks.0:7>,
  <forestry:planks.1:8>,
  <forestry:planks.fireproof.0:7>,
  <forestry:planks.fireproof.1:8>,
]);

// Missed Ingots and blocks
add(<ore:ingotEnderat>, <extendedcrafting:material:36>);
add(<ore:blockEnderat>, <extendedcrafting:storage:5>);
add(<ore:ingotGlitch>, <deepmoblearning:glitch_infused_ingot>);
add(<ore:blockGlitch>, <deepmoblearning:infused_ingot_block>);

// Rat Diamond
add(<ore:gemDiamondRat>, <rats:rat_diamond>);
addItems(<ore:gemDiamondRat>, <ore:gemDiamond>.items);

// Used for ultimate crafting
addItems(<ore:foodNutrients5>, [
  <minecraft:golden_apple:1>,
  <harvestcraft:chickencurryitem>,
  <harvestcraft:hamandpineapplepizzaitem>,
  <harvestcraft:randomtacoitem>,
  <harvestcraft:gourmetporkburgeritem>,
  <harvestcraft:delightedmealitem>,
  <harvestcraft:deluxenachoesitem>,
  <harvestcraft:netherstartoastitem>,
  <harvestcraft:chimichangaitem>,
  <harvestcraft:ploughmanslunchitem>,
  <harvestcraft:deluxechickencurryitem>,
  <harvestcraft:thankfuldinneritem>,
  <harvestcraft:gourmetvenisonburgeritem>,
]);

addItems(<ore:listAllmeatraw>, [
  <twilightforest:raw_meef>,
]);

remove(<ore:plateadvancedAlloy>, <ic2:crafting:3>);
remove(<ore:dustObsidian>, <endreborn:catalyst>);
remove(<ore:tungstenIngot>, <endreborn:item_ingot_wolframium>);
add(<ore:oreXorcite>, <endreborn:dragon_essence>);
add(<ore:gemXorcite>, <endreborn:death_essence>);
add(<ore:oreTungsten>, <endreborn:block_wolframium_ore>);
add(<ore:nuggetTungsten>, <endreborn:wolframium_nugget>);
add(<ore:blockTungsten>, <endreborn:block_wolframium>);
add(<ore:slabConcrete>, <immersiveengineering:stone_decoration_slab:5>);
add(<ore:plateConcrete>, <immersiveengineering:stone_device:3>);

// Add missed leaves
addItems(<ore:treeLeaves>, [<exnihilocreatio:block_infested_leaves>, <exnihilocreatio:block_infesting_leaves>]);

// Add missed seeds, that drops from grass
addItems(<ore:listAllseed>, [
  <rustic:tomato_seeds>,
  <rustic:chili_pepper_seeds>,
  <immersiveengineering:seed>,
  <rustic:grape_stem>,
]);

// Fix missed berry
add(<ore:listAllberry>, <integrateddynamics:menril_berries>);

// Pebbles to be replaceable with other ones
remove(<ore:pebble>, <botania:manaresource:21>);
addItems(<ore:pebble>, [
  <cyclicmagic:stone_pebble>,
  <exnihilocreatio:item_pebble>,
  <exnihilocreatio:item_pebble:1>,
  <exnihilocreatio:item_pebble:2>,
  <exnihilocreatio:item_pebble:3>,
]);

add(<ore:orePhosphor>, <contenttweaker:ore_phosphor>);
add(<ore:nuggetPhosphor>, <contenttweaker:nugget_phosphor>);
add(<ore:dustTinyGold>, <contenttweaker:dust_tiny_gold>);
add(<ore:dustTinyIron>, <rustic:dust_tiny_iron>);
add(<ore:dustTinySilver>, <contenttweaker:dust_tiny_silver>);
add(<ore:listAllwater>, <littletiles:lttransparentcoloredblock:5>);
add(<ore:oreEnderBiomeEssence>, <biomesoplenty:biome_block>);

addItems(<ore:stoneMetamorphic>, [
  <botania:biomestonea>,
  <botania:biomestonea:1>,
  <botania:biomestonea:2>,
  <botania:biomestonea:3>,
  <botania:biomestonea:4>,
  <botania:biomestonea:5>,
  <botania:biomestonea:6>,
  <botania:biomestonea:7>,
]);

addItems(<ore:itemEntangled>, [
  <appliedenergistics2:material:48>,
]);

add(<ore:machineTeleporter>, <mekanism:machineblock:11>);

addItems(<ore:workbench>, [
  <randomthings:customworkbench>,
]);

add(<ore:upgradeDarkSteel>, <enderio:item_dark_steel_upgrade:*>);
add(<ore:logWood>, <ic2:rubber_wood>);

addItems(<ore:headAnimal>, [
  <betteranimalsplus:bearhead>,
  <betteranimalsplus:bearhead_1>,
  <betteranimalsplus:bearhead_2>,
  <betteranimalsplus:bearhead_3>,
  <betteranimalsplus:boarhead>,
  <betteranimalsplus:boarhead_1>,
  <betteranimalsplus:boarhead_2>,
  <betteranimalsplus:boarhead_3>,
  <betteranimalsplus:boarhead_4>,
  <betteranimalsplus:coyotehead>,
  <betteranimalsplus:coyotehead_1>,
  <betteranimalsplus:deerhead>,
  <betteranimalsplus:deerhead_1>,
  <betteranimalsplus:deerhead_2>,
  <betteranimalsplus:deerhead_3>,
  <betteranimalsplus:deerhead_4>,
  <betteranimalsplus:foxhead>,
  <betteranimalsplus:foxhead_1>,
  <betteranimalsplus:foxhead_2>,
  <betteranimalsplus:foxhead_3>,
  <betteranimalsplus:foxhead_4>,
  <betteranimalsplus:moosehead>,
  <betteranimalsplus:moosehead_1>,
  <betteranimalsplus:moosehead_2>,
  <betteranimalsplus:moosehead_3>,
  <betteranimalsplus:moosehead_4>,
  <betteranimalsplus:reindeerhead>,
  <betteranimalsplus:reindeerhead_1>,
  <betteranimalsplus:reindeerhead_2>,
  <betteranimalsplus:reindeerhead_3>,
  <betteranimalsplus:reindeerhead_4>,
  <betteranimalsplus:wolfhead>,
  <betteranimalsplus:wolfhead_1>,
  <betteranimalsplus:wolfhead_2>,
  <betteranimalsplus:wolfhead_3>,
  <betteranimalsplus:wolfhead_4>,
  <betteranimalsplus:wolfhead_5>,
  <betteranimalsplus:wolfhead_6>,
]);

addItems(<ore:cape>, [
  <betteranimalsplus:bear_cape_black>,
  <betteranimalsplus:bear_cape_brown>,
  <betteranimalsplus:bear_cape_kermode>,
  <betteranimalsplus:wolf_cape_arctic>,
  <betteranimalsplus:wolf_cape_black>,
  <betteranimalsplus:wolf_cape_brown>,
  <betteranimalsplus:wolf_cape_classic>,
  <betteranimalsplus:wolf_cape_red>,
  <betteranimalsplus:wolf_cape_timber>,
]);

addItems(<ore:record>, [
  <betteranimalsplus:record_crab_rave>,
  <betteranimalsplus:record_walrus>,
]);

add(<ore:foodFriedegg>, <betteranimalsplus:fried_egg>);

// For some reason, Industrial Foregoing register this oredict too late
add(<ore:ingotPinkMetal>, <industrialforegoing:pink_slime_ingot>);

//#################
// Nuclearcraft
//#################

// Fission Reactor
addItems(<ore:wallReactor>, [
  <nuclearcraft:fission_casing>,
  <nuclearcraft:fission_glass>,
]);

// Salt Reactor
addItems(<ore:wallTurbine>, [
  <nuclearcraft:turbine_casing>,
  <nuclearcraft:turbine_glass>,
]);

//#################
// QMD
//#################

add(<ore:ingotMercury>, <thaumcraft:quicksilver>);
add(<ore:nuggetMercury>, <thaumcraft:nugget:5>);

// Accelerators
addItems(<ore:wallAccelerator>, [
  <qmd:accelerator_casing>,
  <qmd:accelerator_glass>,
]);

// Chambers
addItems(<ore:wallTargetChamber>, [
  <qmd:particle_chamber_casing>,
  <qmd:particle_chamber_glass>,
]);

// VacuumChambers
addItems(<ore:wallVacuumChambers>, [
  <qmd:containment_casing>,
  <qmd:containment_glass>,
]);
