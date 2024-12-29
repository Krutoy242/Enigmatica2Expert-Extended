#reloadable
#modloaded avaritia

import crafttweaker.item.IItemStack;

// *======= Recipes =======*

mods.avaritia.ExtremeCrafting.remove(<avaritia:ultimate_stew>);
mods.avaritia.ExtremeCrafting.remove(<avaritia:cosmic_meatballs>);
mods.avaritia.ExtremeCrafting.remove(<avaritia:infinity_helmet>);
mods.avaritia.ExtremeCrafting.remove(<avaritia:infinity_chestplate>);
mods.avaritia.ExtremeCrafting.remove(<avaritia:infinity_pants>);
mods.avaritia.ExtremeCrafting.remove(<avaritia:infinity_boots>);
mods.avaritia.ExtremeCrafting.remove(<avaritia:infinity_sword>);
mods.avaritia.ExtremeCrafting.remove(<avaritia:infinity_bow>);
mods.avaritia.ExtremeCrafting.remove(<avaritia:infinity_pickaxe>);
mods.avaritia.ExtremeCrafting.remove(<avaritia:infinity_shovel>);
mods.avaritia.ExtremeCrafting.remove(<avaritia:infinity_axe>);
mods.avaritia.ExtremeCrafting.remove(<avaritia:infinity_hoe>);

// Infinity Ingot
mods.avaritia.ExtremeCrafting.remove(<avaritia:resource:6>);
mods.extendedcrafting.TableCrafting.addShaped(0, <avaritia:resource:6>, [
  [<ore:ingotCosmicNeutronium>, <ore:ingotCosmicNeutronium>, <ore:ingotCosmicNeutronium>, <ore:ingotCosmicNeutronium>, <ore:ingotCosmicNeutronium>, <ore:ingotCosmicNeutronium>, <ore:ingotCosmicNeutronium>, <ore:ingotCosmicNeutronium>, <ore:ingotCosmicNeutronium>],
  [<ore:ingotCosmicNeutronium>, <ore:ingotCrystalMatrix>, <avaritia:resource:5>, <avaritia:resource:5>, <extendedcrafting:singularity_ultimate>, <avaritia:resource:5>, <avaritia:resource:5>, <ore:ingotCrystalMatrix>, <ore:ingotCosmicNeutronium>],
  [<ore:ingotCosmicNeutronium>, <avaritia:resource:5>, <ore:ingotCrystalMatrix>, <ore:ingotCrystalMatrix>, <avaritia:resource:5>, <ore:ingotCrystalMatrix>, <ore:ingotCrystalMatrix>, <avaritia:resource:5>, <ore:ingotCosmicNeutronium>],
  [<ore:ingotCosmicNeutronium>, <ore:ingotCrystalMatrix>, <avaritia:resource:5>, <avaritia:resource:5>, <extendedcrafting:singularity_ultimate>, <avaritia:resource:5>, <avaritia:resource:5>, <ore:ingotCrystalMatrix>, <ore:ingotCosmicNeutronium>],
  [<ore:ingotCosmicNeutronium>, <ore:ingotCosmicNeutronium>, <ore:ingotCosmicNeutronium>, <ore:ingotCosmicNeutronium>, <ore:ingotCosmicNeutronium>, <ore:ingotCosmicNeutronium>, <ore:ingotCosmicNeutronium>, <ore:ingotCosmicNeutronium>, <ore:ingotCosmicNeutronium>],
  [null, null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null, null],
]);

// [Neutron Collector] from [Glitch Infused Ingot][+4]
mods.avaritia.ExtremeCrafting.remove(<avaritia:neutron_collector>);
craft.make(<avaritia:neutron_collector>, ['pretty',
  '⌃ U U U ⌃',
  'U C T C U',
  'U T ▬ T U',
  'U C T C U',
  '⌃ U U U ⌃'], {
  'C': <advgenerators:controller>, // Control Circuit
  '⌃': <extrautils2:decorativesolid:6>, // Blue Quartz
  'T': <draconicevolution:chaos_shard:3>, // Tiny Chaos Fragment
  'U': <ore:circuitUltimate>, // Ultimate Control Circuit
  '▬': <ore:ingotGlitch>, // Glitch Infused Ingot
});

// Neutronium Compressor isn't used
mods.avaritia.ExtremeCrafting.remove(<avaritia:neutronium_compressor>);

// Infinity Catalyst
mods.avaritia.ExtremeCrafting.remove(<avaritia:resource:5>);
mods.extendedcrafting.TableCrafting.addShapeless(0, <avaritia:resource:5>,
  [<avaritia:ultimate_stew>, <avaritia:endest_pearl>, <ore:gemBenitoite>,
    <ore:tokenOrIdolFlag>, <ore:gemAnglesite>, <darkutils:shulker_pearl>, <avaritia:cosmic_meatballs>,
    <quark:soul_bead>, <ore:slimecrystalPink>, <ore:plateElite>, <bloodmagic:demon_crystal>,
    <ore:dragonEgg>, <scalinghealth:heartcontainer>,
    <rustic:fluid_bottle>.withTag({ Fluid: { FluidName: 'wine', Amount: 1000, Tag: { Quality: 1 as float } } }),
    <ore:blockWither>, <ore:blockAethium>, <ore:blockCosmicNeutronium>, <extendedcrafting:storage:7>,
    <ore:blockEvilMetal>, <ore:blockCoalCoke>, <ore:compressed3xDustBedrock>, <tconstruct:firewood:1>,
    <ore:blockVividAlloy>, <ore:blockAmethyst>, <randomthings:spectreilluminator>,
    <twilightforest:block_storage:4>, <ore:blockSupremium>, <ore:blockDilithium>,
    <ore:blockCrystalMatrix>, <ore:blockEnderium>, <deepmoblearning:infused_ingot_block>,
    <contenttweaker:terrestrial_artifact_block>, <extrautils2:decorativesolid:6>, <appliedenergistics2:fluix_block>,
    <draconicevolution:draconium_block:1>, <ore:blockMyrmexResin>,
    <advancedrocketry:hotturf>, <forestry:bee_combs_0>, <ore:blockBoundMetal>,
    <ore:blockAstralStarmetal>, <ore:blockOsgloglas>, <ore:blockMirion>, <ore:blockTrinitite>]);

// [Endest Pearl] from [Pristine Enderman Matter][+5]
mods.avaritia.ExtremeCrafting.remove(<avaritia:endest_pearl>);
craft.make(<avaritia:endest_pearl>, ['pretty',
  '    - D -    ',
  '  - ▬ ▬ ▬ -  ',
  '- ▬ E ⌂ E ▬ -',
  'D ▬ ⌂ P ⌂ ▬ D',
  '- ▬ E ⌂ E ▬ -',
  '  - ▬ ▬ ▬ -  ',
  '    - D -    '], {
  'P': <deepmoblearning:pristine_matter_enderman>, // Pristine Enderman Matter
  '⌂': <actuallyadditions:block_misc:8>, // Ender Casing
  'D': <minecraft:dragon_breath>, // Dragon's Breath
  'E': <darkutils:monolith>,
  '▬': <ore:ingotEndorium>, // Endorium Ingot
  '-': <ore:ingotEndSteel>, // End Steel Ingot
});

// [Skullfire Sword] from [Obsidian Skull][+6]
mods.avaritia.ExtremeCrafting.remove(<avaritia:skullfire_sword>);
craft.make(<avaritia:skullfire_sword>, ['pretty',
  '        *',
  '      R  ',
  'D ■ O    ',
  '  ▄ ■    ',
  'S   D    '], {
  '*': <bloodmagic:lava_crystal>, // Lava Crystal
  'R': <rats:ratlantean_flame>, // Ratlantean Spirit Flame
  'D': <ore:boneDragon>, // Dragon Bone
  '■': <ore:blockBone>, // Bone Block
  'O': <randomthings:obsidianskull>, // Obsidian Skull
  '▄': <iceandfire:dragon_bone_block>, // Block of Dragon Bones
  'S': <cyclicmagic:soulstone>, // Soulstone
});

// [Ultimate Stew]*9 from [Cosmic Meatballs][+6]
craft.make(<avaritia:ultimate_stew> * 9, ['pretty',
  '  F       F  ',
  '■ F B C B F ■',
  '■ G G G G G ■',
  '■ G G G G G ■',
  '■ ( ( ( ( ( ■',
  '  ■ ■ ■ ■ ■  ',
  '  ▲ ▲ ▲ ▲ ▲  '], {
  '■': <ore:blockDilithium>, // Block of Dilithium
  '▲': <ore:dustMana>, // Mana Dust
  'B': <rustic:fluid_bottle>.withTag({ Fluid: { FluidName: 'wine', Amount: 1000, Tag: { Quality: 1.0 as float } } }), // Bottle of Wine
  'C': <avaritia:cosmic_meatballs>, // Cosmic Meatballs
  'F': <nuclearcraft:foursmore>, // FourS'more QuadS'mingot
  'G': <ore:foodNutrients5>, // Golden Apple
  '(': <ic2:filled_tin_can>, // (Filled) Tin Can
});

// [Cosmic Meatballs]
mods.extendedcrafting.TableCrafting.addShapeless(
  <avaritia:cosmic_meatballs> * 9, [
    /* Inject_js(
  getCSV('config/tellme/items-csv.csv')
  .filter(o=>o['Ore Dict keys'].split(',').includes('listAllmeatraw'))
  .map(o=>itemize(o['Registry name'], o['Meta/dmg']))
	.sort(naturalSort)
  .map(o=>[`   ${isJEIBlacklisted(o)?'#':' '}utils.tryCatch('${o}'`, `, <minecraft:beef>),`])
) */
    utils.tryCatch('betteranimalsplus:eel_meat_raw'  , <minecraft:beef>),
    utils.tryCatch('betteranimalsplus:pheasantraw'   , <minecraft:beef>),
    utils.tryCatch('betteranimalsplus:turkey_leg_raw', <minecraft:beef>),
    utils.tryCatch('betteranimalsplus:turkey_raw'    , <minecraft:beef>),
    utils.tryCatch('betteranimalsplus:venisonraw'    , <minecraft:beef>),
    utils.tryCatch('harvestcraft:duckrawitem'        , <minecraft:beef>),
    utils.tryCatch('harvestcraft:groundbeefitem'     , <minecraft:beef>),
    utils.tryCatch('harvestcraft:groundchickenitem'  , <minecraft:beef>),
    utils.tryCatch('harvestcraft:groundduckitem'     , <minecraft:beef>),
    utils.tryCatch('harvestcraft:groundfishitem'     , <minecraft:beef>),
    utils.tryCatch('harvestcraft:groundmuttonitem'   , <minecraft:beef>),
    utils.tryCatch('harvestcraft:groundporkitem'     , <minecraft:beef>),
    utils.tryCatch('harvestcraft:groundrabbititem'   , <minecraft:beef>),
    utils.tryCatch('harvestcraft:groundturkeyitem'   , <minecraft:beef>),
    utils.tryCatch('harvestcraft:groundvenisonitem'  , <minecraft:beef>),
    utils.tryCatch('harvestcraft:grubitem'           , <minecraft:beef>),
    utils.tryCatch('harvestcraft:rawtofabbititem'    , <minecraft:beef>),
    utils.tryCatch('harvestcraft:rawtofaconitem'     , <minecraft:beef>),
    utils.tryCatch('harvestcraft:rawtofeakitem'      , <minecraft:beef>),
    utils.tryCatch('harvestcraft:rawtofenisonitem'   , <minecraft:beef>),
    utils.tryCatch('harvestcraft:rawtofickenitem'    , <minecraft:beef>),
    utils.tryCatch('harvestcraft:rawtofuduckitem'    , <minecraft:beef>),
    utils.tryCatch('harvestcraft:rawtofurkeyitem'    , <minecraft:beef>),
    utils.tryCatch('harvestcraft:rawtofuttonitem'    , <minecraft:beef>),
    utils.tryCatch('harvestcraft:turkeyrawitem'      , <minecraft:beef>),
    utils.tryCatch('harvestcraft:venisonrawitem'     , <minecraft:beef>),
    utils.tryCatch('minecraft:beef'                  , <minecraft:beef>),
    utils.tryCatch('minecraft:chicken'               , <minecraft:beef>),
    utils.tryCatch('minecraft:mutton'                , <minecraft:beef>),
    utils.tryCatch('minecraft:porkchop'              , <minecraft:beef>),
    utils.tryCatch('minecraft:rabbit'                , <minecraft:beef>),
    utils.tryCatch('rats:raw_rat'                    , <minecraft:beef>),
    utils.tryCatch('tconevo:edible'                  , <minecraft:beef>),
    utils.tryCatch('twilightforest:raw_meef'         , <minecraft:beef>),
/**/
  ]);

// Neutronium Ingot
val ni = <ore:ingotCosmicNeutronium>;
// Infinity Catalyst
val ic = <avaritia:resource:5>;
// Infinity Ingot
val ii = <ore:ingotInfinity>;
// Crystal Matrix
val cm = <ore:blockCrystalMatrix>;

// Infinity Armor
mods.extendedcrafting.TableCrafting.addShaped(0,
  <avaritia:infinity_helmet>,
  [
    [null, null, ni, ni, ni, ni, ni, null, null],
    [null, ni, ii, ii, ii, ii, ii, ni, null],
    [null, ni, null, ic, ii, ic, null, ni, null],
    [null, ni, ii, ii, <draconicevolution:draconic_helm>.anyDamage(), ii, ii, ni, null],
    [null, ni, ii, ii, ii, ii, ii, ni, null],
    [null, ni, ii, null, ii, null, ii, ni, null],
    [null, null, null, null, null, null, null, null, null],
    [null, null, null, null, null, null, null, null, null],
    [null, null, null, null, null, null, null, null, null],
  ]);

mods.extendedcrafting.TableCrafting.addShaped(0,
  <avaritia:infinity_chestplate>,
  [
    [null, ni, ni, null, null, null, ni, ni, null],
    [ni, ni, ni, null, null, null, ni, ni, ni],
    [ni, ni, ni, null, null, null, ni, ni, ni],
    [null, ni, ii, ii, ii, ii, ii, ni, null],
    [null, ni, ii, ii, ii, ii, ii, ni, null],
    [null, ni, ii, ii, <draconicevolution:draconic_chest>.anyDamage(), ii, ii, ni, null],
    [null, ni, ii, ii, ii, ii, ii, ni, null],
    [null, ni, ii, ii, ii, ii, ii, ni, null],
    [null, null, ni, ni, ni, ni, ni, null, null],
  ]);

mods.extendedcrafting.TableCrafting.addShaped(0,
  <avaritia:infinity_pants>,
  [
    [ni, ni, ni, ni, ni, ni, ni, ni, ni],
    [ni, ii, ii, ii, <draconicevolution:draconic_legs>.anyDamage(), ii, ii, ii, ni],
    [ni, ii, ni, ni, ni, ni, ni, ii, ni],
    [ni, ii, ni, null, null, null, ni, ii, ni],
    [ni, ic, ni, null, null, null, ni, ic, ni],
    [ni, ii, ni, null, null, null, ni, ii, ni],
    [ni, ii, ni, null, null, null, ni, ii, ni],
    [ni, ii, ni, null, null, null, ni, ii, ni],
    [ni, ni, ni, null, null, null, ni, ni, ni],
  ]);

mods.extendedcrafting.TableCrafting.addShaped(0,
  <avaritia:infinity_boots>,
  [
    [null, ni, ni, ni, null, ni, ni, ni, null],
    [null, ni, ii, ni, null, ni, ii, ni, null],
    [null, ni, ii, ni, null, ni, ii, ni, null],
    [ni, ni, ii, ni, null, ni, ii, ni, ni],
    [ni, ii, ii, ni, null, ni, ii, ii, ni],
    [ni, ni, ni, ni, <draconicevolution:draconic_boots>.anyDamage(), ni, ni, ni, ni],
    [null, null, null, null, null, null, null, null, null],
    [null, null, null, null, null, null, null, null, null],
    [null, null, null, null, null, null, null, null, null],
  ]);

// Infinity Sword
mods.extendedcrafting.TableCrafting.addShaped(0,
  <avaritia:infinity_sword>,
  [
    [null, null, null, null, null, null, null, ii, ii],
    [null, null, null, null, null, null, ii, ii, ii],
    [null, null, null, null, null, ii, ii, ii, null],
    [null, null, null, null, ii, ii, ii, null, null],
    [null, cm, null, ii, ii, ii, null, null, null],
    [null, null, cm, <draconicevolution:draconic_staff_of_power>.anyDamage(), ii, null, null, null, null],
    [null, null, ni, cm, null, null, null, null, null],
    [null, ni, null, null, cm, null, null, null, null],
    [ic, null, null, null, null, null, null, null, null],
  ]);

// Infinity Bow
mods.extendedcrafting.TableCrafting.addShaped(0,
  <avaritia:infinity_bow>,
  [
    [null, null, null, ii, ii, null, null, null, null],
    [null, null, ii, null, <ore:blockRockwool>, null, null, null, null],
    [null, ii, null, null, <ore:blockRockwool>, null, null, null, null],
    [ii, null, null, null, <ore:blockRockwool>, null, null, null, null],
    [<draconicevolution:draconic_bow>.anyDamage(), null, null, null, <ore:blockRockwool>, null, null, null, null],
    [ii, null, null, null, <ore:blockRockwool>, null, null, null, null],
    [null, ii, null, null, <ore:blockRockwool>, null, null, null, null],
    [null, null, ii, null, <ore:blockRockwool>, null, null, null, null],
    [null, null, null, ii, ii, null, null, null, null],
  ]);

// Infinity Pickaxe
mods.extendedcrafting.TableCrafting.addShaped(0,
  <avaritia:infinity_pickaxe>.withTag({ ench: [{ lvl: 10 as short, id: 35 as short }] }),
  [
    [null, ii, ii, ii, ii, ii, ii, ii, null],
    [ii, ii, ii, ii, cm, ii, ii, ii, ii],
    [ii, ii, null, null, <draconicevolution:draconic_pick>.anyDamage(), null, null, ii, ii],
    [null, null, null, null, ni, null, null, null, null],
    [null, null, null, null, ni, null, null, null, null],
    [null, null, null, null, ni, null, null, null, null],
    [null, null, null, null, ni, null, null, null, null],
    [null, null, null, null, ni, null, null, null, null],
    [null, null, null, null, ni, null, null, null, null],
  ]);

// Infinity Shovel
mods.extendedcrafting.TableCrafting.addShaped(0,
  <avaritia:infinity_shovel>,
  [
    [null, null, null, null, null, null, ii, ii, ii],
    [null, null, null, null, null, ii, ii, <ore:blockInfinity>, ii],
    [null, null, null, null, null, null, <draconicevolution:draconic_shovel>.anyDamage(), ii, ii],
    [null, null, null, null, null, ni, null, ii, null],
    [null, null, null, null, ni, null, null, null, null],
    [null, null, null, ni, null, null, null, null, null],
    [null, null, ni, null, null, null, null, null, null],
    [null, ni, null, null, null, null, null, null, null],
    [ni, null, null, null, null, null, null, null, null],
  ]);

// Infinity Axe
mods.extendedcrafting.TableCrafting.addShaped(0,
  <avaritia:infinity_axe>,
  [
    [null, null, null, ii, null, null, null, null, null],
    [null, null, ii, ii, ii, ii, ii, null, null],
    [null, null, null, ii, ii, <draconicevolution:draconic_axe>.anyDamage(), ii, null, null],
    [null, null, null, null, null, ii, ni, null, null],
    [null, null, null, null, null, null, ni, null, null],
    [null, null, null, null, null, null, ni, null, null],
    [null, null, null, null, null, null, ni, null, null],
    [null, null, null, null, null, null, ni, null, null],
    [null, null, null, null, null, null, ni, null, null],
  ]);

// Infinity Hoe
mods.extendedcrafting.TableCrafting.addShaped(0,
  <avaritia:infinity_hoe>,
  [
    [null, null, null, null, null, ni, null, null, null],
    [null, ii, ii, ii, ii, ii, ii, null, null],
    [ii, ii, ii, ii, ii, <draconicevolution:draconic_hoe>.anyDamage(), ii, null, null],
    [ii, null, null, null, null, ii, ii, null, null],
    [null, null, null, null, null, ni, null, null, null],
    [null, null, null, null, null, ni, null, null, null],
    [null, null, null, null, null, ni, null, null, null],
    [null, null, null, null, null, ni, null, null, null],
    [null, null, null, null, null, ni, null, null, null],
  ]);

recipes.remove(<avaritia:extreme_crafting_table>);
mods.extendedcrafting.CombinationCrafting.addRecipe(<avaritia:extreme_crafting_table>,
  100000000, 1000000, <vaultopic:vice>,
  [<avaritia:resource:1>, <avaritia:resource:1>, <extendedcrafting:material:12>,
    <extendedcrafting:material:12>, <avaritia:resource:1>, <avaritia:resource:1>]);

// Using Dragon forge to harder recipes
function addDragonForgeRecipe(input1 as IItemStack, input2 as IItemStack, output as IItemStack) {
  mods.iceandfire.recipes.addFireDragonForgeRecipe(input1, input2, output);
  mods.iceandfire.recipes.addIceDragonForgeRecipe(input1, input2, output);
}

recipes.removeByRecipeName('avaritia:items/resource/crystal_matrix_ingot');
addDragonForgeRecipe(<minecraft:nether_star>, <ore:gemDilithium>.firstItem, <avaritia:resource:1>);

// Oredicting recipe
// [Compressed Crafting Table] from [Crafting Table]
recipes.removeByRecipeName('avaritia:blocks/crafting/compressed_crafting_table');
craft.shapeless(<avaritia:compressed_crafting_table>, 'wwwwwwwww', {
  'w': <ore:workbench>, // Crafting Table
});

// -------------------------------------------------------------------
// Burn singularity
// -------------------------------------------------------------------
static burnSingularity as IItemStack = <avaritia:singularity:12>; // Result Singularity
static fillingSingularity as IItemStack = <avaritia:singularity:9>; // Filling Singularity
static needCharge as double = pow(10.0, 9.0);
val needChargeStr = mods.zenutils.StaticString.format('%,d', needCharge as int).replaceAll(',', '§8,§6');
furnace.setFuel(burnSingularity, needCharge);

scripts.lib.tooltip.desc.jei(fillingSingularity,
  'singularity.heat', needChargeStr
);
scripts.lib.tooltip.desc.jei(burnSingularity,
  'singularity.burn', needChargeStr
);

static getCharge as function(IItemStack)double
  = function (item as IItemStack) as double { return item.burnTime as double; };

scripts.do.charge.addRecipe(
  'Burn Singularity',
  <avaritia:singularity>, // Empty Singularity
  fillingSingularity,
  burnSingularity,
  <*>.only(function (item) { return item.burnTime > 0; }),
  needCharge,
  <contenttweaker:any_burnable>, // Fake ingredient
  getCharge
);

// Examples
function addExampleRecipe(a as IItemStack[][]) as void {
  val map = {
    0: a[0][0], 1: a[0][1], 2: a[0][2],
    3: a[1][0], 4: a[1][1], 5: a[1][2],
    6: a[2][0], 7: a[2][1], 8: a[2][2],
  } as IItemStack[string];
  val output = scripts.do.charge.chargeRecipeFunction(map, fillingSingularity, burnSingularity, needCharge, getCharge);
  if (isNull(output)) return;
  recipes.addShaped(craft.uniqueRecipeName(output), output, a);
}

addExampleRecipe([
  [<avaritia:singularity>, <minecraft:cactus>, <minecraft:carpet>],
  [<ic2:sapling>         , <minecraft:stick> , <minecraft:wooden_slab>],
  [<minecraft:planks>    , <minecraft:torch> , <thaumcraft:log_greatwood>],
]);

addExampleRecipe([
  [<avaritia:singularity>          , <harvestcraft:pressedwax> , <thaumcraft:alumentum>],
  [<thermalfoundation:material:892>, <mysticalagriculture:coal>, <forestry:peat>],
  [<minecraft:coal:1>              , <forestry:wood_pile>      , <mechanics:fuel_dust>],
]);

addExampleRecipe([
  [<avaritia:singularity>            , <mysticalagradditions:storage:2>  , <mysticalagriculture:coal_block:4>],
  [<mysticalagriculture:coal_block:3>, <mysticalagriculture:coal_block:2>, <mysticalagradditions:insanium:5>],
  [<mysticalagriculture:coal_block:1>, <mysticalagriculture:coal:4>      , <chisel:block_coal_coke>],
]);
