#modloaded thaumcraft bloodmagic
#ignoreBracketErrors

import crafttweaker.data.IData;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;

// ######################################################################
// Remove armor that can be replaced with Construct's Armory (Conarm)
// ######################################################################

val armorToRemove = [
  // Immersive Engineering
  <immersiveengineering:steel_armor_head>,
  <immersiveengineering:steel_armor_chest>,
  <immersiveengineering:steel_armor_legs>,
  <immersiveengineering:steel_armor_feet>,
  <immersiveengineering:faraday_suit_head>,
  <immersiveengineering:faraday_suit_chest>,
  <immersiveengineering:faraday_suit_legs>,
  <immersiveengineering:faraday_suit_feet>,
] as IItemStack[];

for item in armorToRemove {
  Purge(item);
}

// Only remove recipes but keep in JEI
val vanillaArmorToRemove = [
  <minecraft:iron_helmet>,
  <minecraft:iron_chestplate>,
  <minecraft:iron_leggings>,
  <minecraft:iron_boots>,
  <minecraft:golden_helmet>,
  <minecraft:golden_chestplate>,
  <minecraft:golden_leggings>,
  <minecraft:golden_boots>,
  <minecraft:diamond_helmet>,
  <minecraft:diamond_chestplate>,
  <minecraft:diamond_leggings>,
  <minecraft:diamond_boots>,
] as IItemStack[];

for item in vanillaArmorToRemove {
  recipes.remove(item);
}

// ######################################################################
// Replace recipes that used items
// ######################################################################

// Iron
val helmet_iron = <conarm:helmet_core>.withTag({ Material: 'iron' });
remakeEx(<actuallyadditions:item_player_probe>, [
  [<minecraft:iron_bars>, null, <minecraft:iron_bars>],
  [<minecraft:iron_bars>, helmet_iron, <minecraft:iron_bars>],
  [<actuallyadditions:item_crystal_empowered>, <minecraft:skull:1>, <actuallyadditions:item_crystal_empowered>],
]);

remakeEx(itemUtils.getItem('openblocks:sonic_glasses'), [
  [<ore:ingotIron>, helmet_iron, <ore:ingotIron>],
  [<minecraft:obsidian>, <ore:stickWood>, <minecraft:obsidian>],
  [null, null, null],
]);

remakeEx(<randomthings:superlubricentboots>, [
  [<conarm:boots_core>.withTag({ Material: 'iron' })],
  [<randomthings:ingredient:6>],
]);

// Blood Magic Alchemy Array recipes
val BRT = <bloodmagic:component:8>;
mods.bloodmagic.AlchemyArray.removeRecipe(BRT, <minecraft:iron_helmet>);
mods.bloodmagic.AlchemyArray.removeRecipe(BRT, <minecraft:iron_chestplate>);
mods.bloodmagic.AlchemyArray.removeRecipe(BRT, <minecraft:iron_leggings>);
mods.bloodmagic.AlchemyArray.removeRecipe(BRT, <minecraft:iron_boots>);

mods.bloodmagic.AlchemyArray.addRecipe(<bloodmagic:living_armour_helmet>, BRT, helmet_iron, 'bloodmagic:textures/models/AlchemyArrays/bindingarray.png');
mods.bloodmagic.AlchemyArray.addRecipe(<bloodmagic:living_armour_chest>, BRT, <conarm:chest_core>.withTag({ Material: 'iron' }), 'bloodmagic:textures/models/AlchemyArrays/bindingarray.png');
mods.bloodmagic.AlchemyArray.addRecipe(<bloodmagic:living_armour_leggings>, BRT, <conarm:leggings_core>.withTag({ Material: 'iron' }), 'bloodmagic:textures/models/AlchemyArrays/bindingarray.png');
mods.bloodmagic.AlchemyArray.addRecipe(<bloodmagic:living_armour_boots>, BRT, <conarm:boots_core>.withTag({ Material: 'iron' }), 'bloodmagic:textures/models/AlchemyArrays/bindingarray.png');

// Compact Solars recipes
val compactSolarsRecipes = {
  <compactsolars:compact_solar_block>  : <compactsolars:solar_hat_low_voltage>,
  <compactsolars:compact_solar_block:1>: <compactsolars:solar_hat_medium_voltage>,
  <compactsolars:compact_solar_block:2>: <compactsolars:solar_hat_high_voltage>,
} as IItemStack[IIngredient];

for input, output in compactSolarsRecipes {
  recipes.remove(output);
  recipes.addShapeless(output, [helmet_iron, input]);
}

// Gold
val goldRecipes = {
  <draconicevolution:tool_upgrade:9>  : [<conarm:chest_core>.withTag({ Material: 'electrum' }), <draconicevolution:draconic_core:*>],
  <draconicevolution:tool_upgrade:10> : [<conarm:boots_core>.withTag({ Material: 'electrum' }), <ore:blockRedstone>],
  <draconicevolution:tool_upgrade:11> : [<conarm:boots_core>.withTag({ Material: 'electrum' }), <ore:blockSlime>],
} as IIngredient[][IItemStack];

for output, cores in goldRecipes {
  remakeEx(output, [
    [<minecraft:dye:4>, <draconicevolution:draconic_core:*>, <minecraft:dye:4>],
    [<ore:ingotDraconium>, cores[0], <ore:ingotDraconium>],
    [<minecraft:dye:4>, cores[1], <minecraft:dye:4>],
  ]);
}

// Diamond
val dimBootsCore = <conarm:boots_core>.withTag({ Material: 'diamantine_crystal' });
val dimChestCore = <conarm:chest_core>.withTag({ Material: 'diamantine_crystal' });

remakeEx(<draconicevolution:tool_upgrade:8>, [
  [<minecraft:dye:4>, <draconicevolution:draconic_core:*>, <minecraft:dye:4>],
  [<ore:ingotDraconium>, dimChestCore, <ore:ingotDraconium>],
  [<minecraft:dye:4>, <draconicevolution:draconic_core:*>, <minecraft:dye:4>],
]);

remakeEx(<environmentaltech:modifier_jump_boost>, [
  [dimBootsCore, <environmentaltech:litherite_crystal>, dimBootsCore],
  [<environmentaltech:mica>, <environmentaltech:modifier_null>, <environmentaltech:mica>],
  [dimBootsCore, <environmentaltech:lonsdaleite_crystal>, dimBootsCore],
]);

mods.bloodmagic.TartaricForge.removeRecipe([<minecraft:diamond_chestplate:*>, <bloodmagic:soul_gem:1>, <minecraft:iron_block>, <minecraft:obsidian>]);
mods.bloodmagic.TartaricForge.addRecipe(<bloodmagic:sentient_armour_gem>, [dimChestCore, <bloodmagic:soul_gem:1>, <minecraft:iron_block>, <minecraft:obsidian>], 250, 150);

// ######################################################################
// Generate recipes
// ######################################################################

static armorStaged as IData[string] = scripts.equipment.armorData.armorStaged;

function getSetPiece(setData as IData, pieceN as int) as IItemStack {
  if (isNull(setData)) return null;

  val idStr = setData.list[pieceN].id.asString();
  if (isNull(idStr)) return null;

  val piece = getIngredientFromString(idStr);
  if (isNull(piece)) {
    logger.logWarning('Armor.zs Error. No armor item <' ~ idStr ~ '>');
    return null;
  }

  return piece.itemArray[0];
}

static setNames as string[] = ['Helmet', 'Chestplate', 'Leggins', 'Boots'];

function createRecipe(setData as IData, setId as string, pieceN as int, ingrs as IIngredient[][]) as void {
  val setPiece = getSetPiece(setData, pieceN);
  if (isNull(setPiece)) {
    logger.logWarning('Armor.zs Error. No armor for set {' ~ setId ~ '} for piece: ' ~ setNames[pieceN]);
    return;
  }

  recipes.removeShaped(setPiece);
  recipes.addShaped(craft.uniqueRecipeName(setPiece), setPiece, ingrs, utils.smartUpgradeFnc, null);
}

function armGridExtra(n as int, mat as IIngredient, extra as IIngredient, prev as IData) as IIngredient[][] {
  val prevReal = getSetPiece(prev, n);
  val prevAny = !isNull(prevReal) ? prevReal.anyDamage().marked('marked') : null;
  /* */if (n == 0) return [[mat , extra  ,  mat], [mat, prevAny, mat], [null, null   , null]] as IIngredient[][];
  else if (n == 1) return [[mat , prevAny,  mat], [mat, extra  , mat], [mat , mat    ,  mat]] as IIngredient [][];
  else if (n == 2) return [[mat , extra  ,  mat], [mat, prevAny, mat], [mat , null   ,  mat]] as IIngredient [][];
  else if (n == 3) return [[null, null   , null], [mat, extra  , mat], [mat , prevAny,  mat]] as IIngredient [][];
  return null;
}

function armGridNormal(n as int, mat as IIngredient, prev as IData) as IIngredient[][] {
  return armGridExtra(n, mat, mat, prev);
}

function createArmorSet(setData as IData, setId as string) as void {
  if (!isNull(setData.recipe) && !isNull(setData.recipe.manual)) return; // Recipe shuld be manual only
  if (isNull(setData.material)) return; // No ingredient data

  val matStr = setData.material.asString();
  val mat = getIngredientFromString(matStr);
  if (isNull(mat)) {
    logger.logWarning('Armor.zs Error. No material {' ~ matStr ~ '}');
    return;
  }

  val prev = armorStaged[D(setData).get('prev', { d: 'undefined' })];
  val extra = isNull(setData.recipe) || isNull(setData.recipe.extra)
    ? null
    : getIngredientFromString(setData.recipe.extra.asString());

  for i in 0 .. setNames.length {
    val grid = isNull(extra)
      ? armGridNormal(i, mat, prev)
      : armGridExtra(i, mat, extra, prev);
    createRecipe(setData, setId, i, grid);
  }
}

for setId, setData in armorStaged {
  createArmorSet(setData, setId);
}

// ######################################################################
//
// Manual recipes
//
// ######################################################################

remakeEx(<botania:terrasteelboots>, [[<ore:dreamwoodTwig>, <ore:runeWinterB>, <ore:dreamwoodTwig>], [<ore:ingotTerrasteel>, <botania:elementiumboots>.anyDamage(), <ore:ingotTerrasteel>], [null, <ore:ingotTerrasteel>, null]]);
remakeEx(<botania:terrasteellegs>, [[<ore:dreamwoodTwig>, <ore:runeAutumnB>, <ore:dreamwoodTwig>], [<ore:ingotTerrasteel>, <botania:elementiumlegs>.anyDamage(), <ore:ingotTerrasteel>], [null, <ore:ingotTerrasteel>, null]]);
remakeEx(<botania:terrasteelchest>, [[<ore:dreamwoodTwig>, <ore:runeSummerB>, <ore:dreamwoodTwig>], [<ore:ingotTerrasteel>, <botania:elementiumchest>.anyDamage(), <ore:ingotTerrasteel>], [<ore:ingotTerrasteel>, <ore:ingotTerrasteel>, <ore:ingotTerrasteel>]]);
remakeEx(<botania:terrasteelhelm>, [[<ore:dreamwoodTwig>, <ore:runeSpringB>, <ore:dreamwoodTwig>], [<ore:ingotTerrasteel>, <botania:elementiumhelm>.anyDamage(), <ore:ingotTerrasteel>], [null, <ore:ingotTerrasteel>, null]]);
recipes.addShapeless(<botania:terrasteelhelmreveal>, [<botania:terrasteelhelm>.anyDamage(), <thaumcraft:goggles>.anyDamage()]);

val anyCrystal = <ic2:energy_crystal:*> | <ic2:energy_crystal:*>.withTag({}, false);
remakeEx(<ic2:nano_helmet:26>, [[<ic2:crafting:15>, anyCrystal, <ic2:crafting:15>], [<ic2:crafting:15>, <ic2:nightvision_goggles:26>.anyDamage(), <ic2:crafting:15>], [null, <conarm:helmet_core>.withTag({ Material: 'energetic_metal' }), null]]);
remakeEx(<ic2:nano_chestplate:26>, [[<ic2:crafting:15>, <conarm:chest_core>.withTag({ Material: 'energetic_metal' }), <ic2:crafting:15>], [<ic2:crafting:15>, anyCrystal, <ic2:crafting:15>], [<ic2:crafting:15>, <ic2:crafting:15>, <ic2:crafting:15>]]);
remakeEx(<ic2:nano_leggings:26>, [[<ic2:crafting:15>, anyCrystal, <ic2:crafting:15>], [<ic2:crafting:15>, <conarm:leggings_core>.withTag({ Material: 'energetic_metal' }), <ic2:crafting:15>], [<ic2:crafting:15>, null, <ic2:crafting:15>]]);
remakeEx(<ic2:nano_boots:26>, [[<ic2:crafting:15>, anyCrystal, <ic2:crafting:15>], [<ic2:crafting:15>, <conarm:boots_core>.withTag({ Material: 'energetic_metal' }), <ic2:crafting:15>], [null, null, null]]);

remakeEx(<ic2:quantum_boots:26>, [[null, null, null], [<ic2:crafting:4>, <redstonearsenal:armor.boots_flux>.anyDamage(), <ic2:crafting:4>], [<ic2:rubber_boots>, <ore:lapotronCrystal>, <ic2:rubber_boots>]]);
remakeEx(<ic2:quantum_leggings:26>, [[<ic2:crafting:3>, <ore:lapotronCrystal>, <ic2:crafting:3>], [<ic2:crafting:4>, <redstonearsenal:armor.legs_flux>.anyDamage(), <ic2:crafting:4>], [null, <ore:lapotronCrystal>, null]]);
remakeEx(<ic2:quantum_chestplate:26>, [[<ic2:crafting:3>, <ore:lapotronCrystal>, <ic2:crafting:3>], [<ic2:crafting:4>, <redstonearsenal:armor.plate_flux>.anyDamage(), <ic2:crafting:4>], [<ic2:crafting:3>, <ic2:jetpack_electric>.anyDamage(), <ic2:crafting:3>]]);
remakeEx(<ic2:quantum_helmet:26>, [[<ic2:crafting:3>, null, <ic2:crafting:3>], [<ic2:crafting:4>, <redstonearsenal:armor.helmet_flux>.anyDamage(), <ic2:crafting:4>], [null, <ore:lapotronCrystal>, null]]);

// *======= Draconic Armor =======*

recipes.remove(<draconicevolution:wyvern_helm>);
recipes.remove(<draconicevolution:wyvern_boots>);
recipes.remove(<draconicevolution:wyvern_legs>);
recipes.remove(<draconicevolution:wyvern_chest>);

// Wyvern
mods.extendedcrafting.CombinationCrafting.addRecipe(<draconicevolution:wyvern_helm>,
  1000000000, 1000000, <draconicevolution:wyvern_energy_core>, [
    <draconicevolution:draconium_block:1>,
    <ic2:quantum_helmet>.anyDamage(),
    <draconicevolution:draconium_block:1>,
    <draconicevolution:draconium_block:1>,
    <twilightforest:yeti_helmet>.anyDamage(),
    <thaumcraft:void_robe_helm>.anyDamage(),
    <bloodmagic:living_armour_helmet>.anyDamage(),
    <draconicevolution:wyvern_core>,
    <botania:terrasteelhelm>.anyDamage(),
    <twilightforest:arctic_helmet>.anyDamage(),
    <deepmoblearning:glitch_infused_helmet>.anyDamage(),
    <draconicevolution:draconium_block:1>,
  ]);
mods.extendedcrafting.CombinationCrafting.addRecipe(<draconicevolution:wyvern_chest>,
  1000000000, 1000000, <draconicevolution:wyvern_energy_core>, [
    <draconicevolution:draconium_block:1>,
    <ic2:quantum_chestplate>.anyDamage(),
    <draconicevolution:draconium_block:1>,
    <draconicevolution:draconium_block:1>,
    <twilightforest:yeti_chestplate>.anyDamage(),
    <thaumcraft:void_robe_chest>.anyDamage(),
    <bloodmagic:living_armour_chest>.anyDamage(),
    <draconicevolution:wyvern_core>,
    <botania:terrasteelchest>.anyDamage(),
    <twilightforest:arctic_chestplate>.anyDamage(),
    <deepmoblearning:glitch_infused_chestplate>.anyDamage(),
    <draconicevolution:draconium_block:1>,
  ]);
mods.extendedcrafting.CombinationCrafting.addRecipe(<draconicevolution:wyvern_legs>,
  1000000000, 1000000, <draconicevolution:wyvern_energy_core>, [
    <draconicevolution:draconium_block:1>,
    <ic2:quantum_leggings>.anyDamage(),
    <draconicevolution:draconium_block:1>,
    <draconicevolution:draconium_block:1>,
    <twilightforest:yeti_leggings>.anyDamage(),
    <thaumcraft:void_robe_legs>.anyDamage(),
    <bloodmagic:living_armour_leggings>.anyDamage(),
    <draconicevolution:wyvern_core>,
    <botania:terrasteellegs>.anyDamage(),
    <twilightforest:arctic_leggings>.anyDamage(),
    <deepmoblearning:glitch_infused_leggings>.anyDamage(),
    <draconicevolution:draconium_block:1>,
  ]);
mods.extendedcrafting.CombinationCrafting.addRecipe(<draconicevolution:wyvern_boots>,
  1000000000, 1000000, <draconicevolution:wyvern_energy_core>, [
    <draconicevolution:draconium_block:1>,
    <ic2:quantum_boots>.anyDamage(),
    <draconicevolution:draconium_block:1>,
    <draconicevolution:draconium_block:1>,
    <twilightforest:yeti_boots>.anyDamage(),
    <thaumicaugmentation:void_boots>.anyDamage(),
    <bloodmagic:living_armour_boots>.anyDamage(),
    <draconicevolution:wyvern_core>,
    <botania:terrasteelboots>.anyDamage(),
    <twilightforest:arctic_boots>.anyDamage(),
    <deepmoblearning:glitch_infused_boots>.anyDamage(),
    <draconicevolution:draconium_block:1>,
  ]);

// Draconic
mods.extendedcrafting.CombinationCrafting.addRecipe(<draconicevolution:draconic_helm>,
  2147483647, 1000000, <avaritia:block_resource:2>, [
    <extrautils2:angelring>.anyDamage(),
    <draconicevolution:wyvern_helm>.anyDamage(),
    <draconicevolution:awakened_core>,
    <draconicevolution:awakened_core>,
    <draconicevolution:draconic_block>,
    <draconicevolution:draconic_block>,
    <draconicevolution:draconic_energy_core>,
    <draconicevolution:draconic_energy_core>,
    <thermalexpansion:frame:148>,
    <extendedcrafting:material:32>,
    <astralsorcery:itemcape>.anyDamage()]);
mods.extendedcrafting.CombinationCrafting.addRecipe(<draconicevolution:draconic_chest>,
  2147483647, 1000000, <avaritia:block_resource:2>, [
    <extrautils2:angelring>.anyDamage(),
    <draconicevolution:wyvern_chest>.anyDamage(),
    <draconicevolution:awakened_core>,
    <draconicevolution:awakened_core>,
    <draconicevolution:draconic_block>,
    <draconicevolution:draconic_block>,
    <draconicevolution:draconic_energy_core>,
    <draconicevolution:draconic_energy_core>,
    <thermalexpansion:frame:148>,
    <extendedcrafting:material:32>,
    <astralsorcery:itemcape>.anyDamage()]);
mods.extendedcrafting.CombinationCrafting.addRecipe(<draconicevolution:draconic_legs>,
  2147483647, 1000000, <avaritia:block_resource:2>, [
    <extrautils2:angelring>.anyDamage(),
    <draconicevolution:wyvern_legs>.anyDamage(),
    <draconicevolution:awakened_core>,
    <draconicevolution:awakened_core>,
    <draconicevolution:draconic_block>,
    <draconicevolution:draconic_block>,
    <draconicevolution:draconic_energy_core>,
    <draconicevolution:draconic_energy_core>,
    <thermalexpansion:frame:148>,
    <extendedcrafting:material:32>,
    <astralsorcery:itemcape>.anyDamage()]);
mods.extendedcrafting.CombinationCrafting.addRecipe(<draconicevolution:draconic_boots>,
  2147483647, 1000000, <avaritia:block_resource:2>, [
    <extrautils2:angelring>.anyDamage(),
    <draconicevolution:wyvern_boots>.anyDamage(),
    <draconicevolution:awakened_core>,
    <draconicevolution:awakened_core>,
    <draconicevolution:draconic_block>,
    <draconicevolution:draconic_block>,
    <draconicevolution:draconic_energy_core>,
    <draconicevolution:draconic_energy_core>,
    <thermalexpansion:frame:148>,
    <extendedcrafting:material:32>,
    <astralsorcery:itemcape>.anyDamage()]);

// ######################################################################
//
// Recycling armor and related items
//
// ######################################################################

val DKS = 'enderio:item_alloy_ingot:6';
val ENS = 'enderio:item_alloy_ingot:8';
val FLE = 'redstonearsenal:material:32';
val PSI = 'psi:material:1';
val IRN = 'minecraft:iron_ingot';
val SLR = 'enderio:item_alloy_endergy_ingot:3';

// Recycling armor and items list
val itemsToRecycle as string[] = [
// Item name                             |amount| recycle output ore  | recycled metal OR other recycle method
  'enderio:item_dark_steel_treetap', '6', DKS, 'dark_steel',
  'enderio:item_dark_steel_crook', '2', DKS, 'dark_steel',
  'enderio:item_dark_steel_hand', '5', DKS, 'dark_steel',
  'enderio:item_dark_steel_shield', '5', DKS, 'dark_steel',
  'enderio:item_dark_steel_helmet', '5', DKS, 'dark_steel',
  'enderio:item_dark_steel_chestplate', '8', DKS, 'dark_steel',
  'enderio:item_dark_steel_leggings', '7', DKS, 'dark_steel',
  'enderio:item_dark_steel_boots', '4', DKS, 'dark_steel',
  'enderio:item_end_steel_sword', '2', ENS, 'end_steel',
  'enderio:item_end_steel_pickaxe', '3', ENS, 'end_steel',
  'enderio:item_end_steel_axe', '3', ENS, 'end_steel',
  'enderio:item_end_steel_helmet', '5', ENS, 'end_steel',
  'enderio:item_end_steel_chestplate', '8', ENS, 'end_steel',
  'enderio:item_end_steel_leggings', '7', ENS, 'end_steel',
  'enderio:item_end_steel_boots', '4', ENS, 'end_steel',
  'enderio:item_end_steel_shield', '5', ENS, 'end_steel',
  'redstonearsenal:armor.helmet_flux', '20', FLE, 'fluxed_electrum',
  'redstonearsenal:armor.plate_flux', '32', FLE, 'fluxed_electrum',
  'redstonearsenal:armor.legs_flux', '28', FLE, 'fluxed_electrum',
  'redstonearsenal:armor.boots_flux', '16', FLE, 'fluxed_electrum',
  'redstonearsenal:tool.wrench_flux', '3', FLE, 'fluxed_electrum',
  'redstonearsenal:tool.bow_flux', '9', FLE, 'fluxed_electrum',
  'redstonearsenal:tool.fishing_rod_flux', '2', FLE, 'fluxed_electrum',
  'redstonearsenal:tool.shield_flux', '6', FLE, 'fluxed_electrum',
  'psi:psimetal_shovel', '1', PSI, 'psimetal',
  'psi:psimetal_pickaxe', '2', PSI, 'psimetal',
  'psi:psimetal_axe', '2', PSI, 'psimetal',
  'psi:psimetal_sword', '1', PSI, 'psimetal',
  'psi:psimetal_exosuit_helmet', '4', PSI, 'psimetal',
  'psi:psimetal_exosuit_chestplate', '6', PSI, 'psimetal',
  'psi:psimetal_exosuit_leggings', '5', PSI, 'psimetal',
  'psi:psimetal_exosuit_boots', '2', PSI, 'psimetal',
  'iceandfire:troll_weapon.axe', '8', IRN, 'iron',
  'bloodmagic:living_armour_helmet', '5', IRN, 'iron',
  'bloodmagic:living_armour_chest', '8', IRN, 'iron',
  'bloodmagic:living_armour_leggings', '7', IRN, 'iron',
  'bloodmagic:living_armour_boots', '4', IRN, 'iron',
  'enderio:item_stellar_alloy_sword', '2', SLR, 'stellar_alloy',
  'enderio:item_stellar_alloy_pickaxe', '3', SLR, 'stellar_alloy',
  'enderio:item_stellar_alloy_axe', '3', SLR, 'stellar_alloy',
  'enderio:item_stellar_alloy_helmet', '4', SLR, 'stellar_alloy',
  'enderio:item_stellar_alloy_boots', '4', SLR, 'stellar_alloy',
  'enderio:item_stellar_alloy_chestplate', '7', SLR, 'stellar_alloy',
  'enderio:item_stellar_alloy_leggings', '6', SLR, 'stellar_alloy',
  'ic2:quantum_boots', '1', 'thermalfoundation:material:135', 'iridium',
  'ic2:quantum_chestplate', '1', 'thermalfoundation:material:135', 'iridium',
  'ic2:quantum_helmet', '1', 'thermalfoundation:material:135', 'iridium',
  'ic2:quantum_leggings', '1', 'thermalfoundation:material:135', 'iridium',
  'iceandfire:troll_weapon.hammer', '8', 'mechanics:heavy_ingot', '',
  'animus:kama_diamond', '8', 'minecraft:diamond', '',
  'botania:manaweavehelm', '20', 'botania:manaresource:16', '!saw',
  'botania:manaweavechest', '32', 'botania:manaresource:16', '!saw',
  'botania:manaweavelegs', '28', 'botania:manaresource:16', '!saw',
  'botania:manaweaveboots', '16', 'botania:manaresource:16', '!saw',
  'twilightforest:arctic_boots', '4', 'twilightforest:arctic_fur', '!saw',
  'twilightforest:arctic_leggings', '7', 'twilightforest:arctic_fur', '!saw',
  'twilightforest:arctic_chestplate', '8', 'twilightforest:arctic_fur', '!saw',
  'twilightforest:arctic_helmet', '5', 'twilightforest:arctic_fur', '!saw',
  'twilightforest:yeti_boots', '4', 'twilightforest:alpha_fur', '!saw',
  'twilightforest:yeti_leggings', '7', 'twilightforest:alpha_fur', '!saw',
  'twilightforest:yeti_chestplate', '8', 'twilightforest:alpha_fur', '!saw',
  'twilightforest:yeti_helmet', '5', 'twilightforest:alpha_fur', '!saw',
  'twilightforest:naga_leggings', '7', 'twilightforest:naga_scale', '!saw',
  'twilightforest:naga_chestplate', '8', 'twilightforest:naga_scale', '!saw',
  'rats:archeologist_hat', '4', 'thermalfoundation:material:801', '',
  'quark:archaeologist_hat', '4', 'thermalfoundation:material:801', '',
  'rats:pirat_cutlass', '4', 'thermalfoundation:material:133', 'nickel',
  'rats:piper_hat', '10', 'minecraft:paper', '!saw',
  'rats:pirat_hat', '5', 'minecraft:wool:15', '!saw',
  'deepmoblearning:glitch_infused_boots', '4', 'deepmoblearning:glitch_fragment', '',
  'deepmoblearning:glitch_infused_chestplate', '8', 'deepmoblearning:glitch_fragment', '',
  'deepmoblearning:glitch_infused_helmet', '5', 'deepmoblearning:glitch_fragment', '',
  'deepmoblearning:glitch_infused_leggings', '7', 'deepmoblearning:glitch_fragment', '',
  'deepmoblearning:glitch_infused_sword', '2', 'deepmoblearning:glitch_fragment', '',
  'endreborn:armour_boots_dragon', '4', 'endreborn:dragon_scales', '',
  'endreborn:armour_chestplate_dragon', '8', 'endreborn:dragon_scales', '',
  'endreborn:armour_helmet_dragon', '4', 'endreborn:dragon_scales', '',
  'endreborn:armour_leggings_dragon', '6', 'endreborn:dragon_scales', '',
  'endreborn:tool_magnifier', '2', 'endreborn:dragon_scales', '',
  'ic2:nano_boots', '2', 'ic2:crafting:15', '!shapeless',
  'ic2:nano_chestplate', '3', 'ic2:crafting:15', '!shapeless',
  'ic2:nano_helmet', '2', 'ic2:crafting:15', '!shapeless',
  'ic2:nano_leggings', '3', 'ic2:crafting:15', '!shapeless',
  'thaumcraft:fortress_helm', '7', 'thaumcraft:ingot', 'thaumium',
  'thaumcraft:fortress_chest', '12', 'thaumcraft:ingot', 'thaumium',
  'thaumcraft:fortress_legs', '10', 'thaumcraft:ingot', 'thaumium',
  'ic2:hazmat_helmet', '4', 'ic2:crafting', '!saw',
  'ic2:hazmat_chestplate', '6', 'ic2:crafting', '!saw',
  'ic2:hazmat_leggings', '6', 'ic2:crafting', '!saw',
  'ic2:rubber_boots', '6', 'ic2:crafting', '!saw',
  'ic2:tool_box', '2', 'thermalfoundation:material:163', 'bronze',
  'nuclearcraft:helm_hazmat', '2', 'nuclearcraft:part', '!shapeless',
  'nuclearcraft:chest_hazmat', '2', 'nuclearcraft:part', '!shapeless',
  'nuclearcraft:legs_hazmat', '2', 'nuclearcraft:part', '!shapeless',
  'nuclearcraft:boots_hazmat', '2', 'nuclearcraft:part', '!shapeless',
  'nuclearcraft:multitool', '2', 'thermalfoundation:material:160', 'steel',
  'qmd:helm_hev', '2', 'nuclearcraft:rad_shielding:2', '!shapeless',
  'qmd:chest_hev', '2', 'nuclearcraft:rad_shielding:2', '!shapeless',
  'qmd:legs_hev', '2', 'nuclearcraft:rad_shielding:2', '!shapeless',
  'qmd:boots_hev', '2', 'nuclearcraft:rad_shielding:2', '!shapeless',
  'qmd:lepton_cannon', '2', 'qmd:ingot2:1', 'neodymium',
  'advancedrocketry:spacehelmet', '2', 'libvulpes:productingot:7', 'titanium',
  'advancedrocketry:spacechestplate', '1', 'libvulpes:productingot:7', 'titanium',
  'advancedrocketry:spaceleggings', '1', 'libvulpes:productingot:7', 'titanium',
  'advancedrocketry:spaceboots', '2', 'libvulpes:productingot:7', 'titanium',
];

// Exceptions for machines that can saw
val sawExcs = 'except: shapeless BlockCutter AdvRockCutter';

// Iterate list and call appropriate functions
for i in 0 .. itemsToRecycle.length {
  if (i % 4 == 0) {
    val item = itemUtils.getItem(itemsToRecycle[i]);
    val count = itemsToRecycle[i + 1] as int;
    val resclItem = getItemstackFromString(itemsToRecycle[i + 2]);
    val option = itemsToRecycle[i + 3];
    val resclLiqd = game.getLiquid(option);

    if (!isNull(item) && !isNull(resclItem)) {
      if (!isNull(resclLiqd)) {
        scripts.process.recycleMetal(item, resclItem * count, resclLiqd * (count * 144), 'no exceptions');
      }
      else if (option == '!saw') {
        scripts.process.saw(item, resclItem * count, sawExcs);
      }
      else if (option == '!shapeless') {
        recipes.addShapeless('Recycle ' ~ item.displayName, resclItem * count, [item]);
      }
      else {
        scripts.process.crush(item, resclItem * count, 'only: IECrusher SagMill Pulverizer', null, null);
      }
    }
    else {
      logger.logWarning('Cant recycle [' ~ itemsToRecycle[i] ~ ']' ~ (isNull(item) ? 'NULL' : '') ~ ' -> [' ~ itemsToRecycle[i + 2] ~ ']' ~ (isNull(resclItem) ? 'NULL' : ''));
    }
  }
}

// Extract binding reagent from armor and Khopesh
// mods.bloodmagic.AlchemyTable.addRecipe(IItemStack output, IItemStack[] inputs, int syphon, int ticks, int minTier);
mods.bloodmagic.AlchemyTable.addRecipe(<bloodmagic:component:8>, [<bloodmagic:living_armour_helmet>], 300, 40, 3);
mods.bloodmagic.AlchemyTable.addRecipe(<bloodmagic:component:8>, [<bloodmagic:living_armour_chest>], 300, 40, 3);
mods.bloodmagic.AlchemyTable.addRecipe(<bloodmagic:component:8>, [<bloodmagic:living_armour_leggings>], 300, 40, 3);
mods.bloodmagic.AlchemyTable.addRecipe(<bloodmagic:component:8>, [<bloodmagic:living_armour_boots>], 300, 40, 3);
mods.bloodmagic.AlchemyTable.addRecipe(<bloodmagic:component:8>, [<animus:kama_bound>], 300, 40, 3);

// Some troll items can be disassembled on crafting table
recipes.addShapeless('Disassemble troll column', <extrautils2:compressedcobblestone> * 4, [<iceandfire:troll_weapon.column>]);
recipes.addShapeless('Disassemble troll column_forest', <additionalcompression:cobblestonemossy_compressed> * 4, [<iceandfire:troll_weapon.column_forest>]);
recipes.addShapeless('Disassemble troll column_frost', <quark:biome_cobblestone:1> * 36, [<iceandfire:troll_weapon.column_frost>]);
recipes.addShapeless('Disassemble troll trunk', <twilightforest:giant_log>, [<iceandfire:troll_weapon.trunk>]);
recipes.addShapeless('Disassemble troll trunk_frost', <integrateddynamics:menril_log> * 36, [<iceandfire:troll_weapon.trunk_frost>]);

// ######################################################################
//
// Thaumcraft (with addons) armor crafting recipes changes
//
// ######################################################################

// [Void robe armor set]
mods.thaumcraft.Infusion.removeRecipe(<thaumcraft:void_robe_helm>);
mods.thaumcraft.Infusion.registerRecipe(
  'VoidRobeHelm', // Name
  'VOIDROBEARMOR', // Research
  <thaumcraft:void_robe_helm>, // Output
  3, // Instability
  Aspects('25🔩 25🔮 25〇 25💪 25👽 25🦉 25👁️'),
  <thaumicaugmentation:thaumium_robes_hood:*>, // CentralItem
  [<thaumcraft:salis_mundus>, <thaumcraft:fabric>, <thaumcraft:plate:3>, <thaumcraft:plate:3>, <thaumcraft:plate:3>]
);
mods.thaumcraft.Infusion.removeRecipe(<thaumcraft:void_robe_chest>);
mods.thaumcraft.Infusion.registerRecipe(
  'VoidRobeChest', // Name
  'VOIDROBEARMOR', // Research
  <thaumcraft:void_robe_chest>, // Output
  3, // Instability
  Aspects('35🔩 35🔮 35〇 25💪 25👽'),
  <thaumicaugmentation:thaumium_robes_chestplate:*>, // CentralItem
  [<thaumcraft:salis_mundus>, <thaumcraft:fabric>, <thaumcraft:plate:3>, <thaumcraft:plate:3>, <thaumcraft:plate:3>, <thaumcraft:plate:3>]
);
mods.thaumcraft.Infusion.removeRecipe(<thaumcraft:void_robe_legs>);
mods.thaumcraft.Infusion.registerRecipe(
  'VoidRobeLegs', // Name
  'VOIDROBEARMOR', // Research
  <thaumcraft:void_robe_legs>, // Output
  3, // Instability
  Aspects('25🔩 25🔮 25〇 25💪 25👽'),
  <thaumicaugmentation:thaumium_robes_leggings:*>, // CentralItem
  [<thaumcraft:salis_mundus>, <thaumcraft:fabric>, <thaumcraft:plate:3>, <thaumcraft:plate:3>, <thaumcraft:plate:3>, <thaumcraft:plate:3>, <thaumcraft:plate:3>]
);

// [Void fortress armor set]
mods.thaumcraft.Infusion.removeRecipe(<thaumicwonders:void_fortress_helm>);
mods.thaumcraft.Infusion.registerRecipe(
  'void_fortress_helm', // Name
  'TWOND_VOID_FORTRESS_ARMOR', // Research
  <thaumicwonders:void_fortress_helm>, // Output
  3, // Instability
  Aspects('50🧨 30❤️ 50〇'),
  <thaumcraft:fortress_helm:*>, // CentralItem
  [<thaumcraft:void_helm:*>, <minecraft:ghast_tear>, <thaumcraft:salis_mundus>, <harvestcraft:hardenedleatheritem>]
);
mods.thaumcraft.Infusion.removeRecipe(<thaumicwonders:void_fortress_chest>);
mods.thaumcraft.Infusion.registerRecipe(
  'void_fortress_chest', // Name
  'TWOND_VOID_FORTRESS_ARMOR', // Research
  <thaumicwonders:void_fortress_chest>, // Output
  3, // Instability
  Aspects('50🧨 30❤️ 50〇'),
  <thaumcraft:fortress_chest:*>, // CentralItem
  [<thaumcraft:void_chest:*>, <thaumcraft:salis_mundus>, <harvestcraft:hardenedleatheritem>, <harvestcraft:hardenedleatheritem>]
);
mods.thaumcraft.Infusion.removeRecipe(<thaumicwonders:void_fortress_legs>);
mods.thaumcraft.Infusion.registerRecipe(
  'void_fortress_legs', // Name
  'TWOND_VOID_FORTRESS_ARMOR', // Research
  <thaumicwonders:void_fortress_legs>, // Output
  3, // Instability
  Aspects('50🧨 30❤️ 50〇'),
  <thaumcraft:fortress_legs:*>, // CentralItem
  [<thaumcraft:void_legs:*>, <thaumcraft:salis_mundus>, <harvestcraft:hardenedleatheritem>, <harvestcraft:hardenedleatheritem>]
);

// ######################################################################
//
// Cosmetic equipment
//
// ######################################################################

for cosmetic in [
  <iceandfire:armor_blue_boots>,
  <iceandfire:armor_blue_chestplate>,
  <iceandfire:armor_blue_helmet>,
  <iceandfire:armor_blue_leggings>,
  <iceandfire:armor_bronze_boots>,
  <iceandfire:armor_bronze_chestplate>,
  <iceandfire:armor_bronze_helmet>,
  <iceandfire:armor_bronze_leggings>,
  <iceandfire:armor_gray_boots>,
  <iceandfire:armor_gray_chestplate>,
  <iceandfire:armor_gray_helmet>,
  <iceandfire:armor_gray_leggings>,
  <iceandfire:armor_green_boots>,
  <iceandfire:armor_green_chestplate>,
  <iceandfire:armor_green_helmet>,
  <iceandfire:armor_green_leggings>,
  <iceandfire:armor_red_boots>,
  <iceandfire:armor_red_chestplate>,
  <iceandfire:armor_red_helmet>,
  <iceandfire:armor_red_leggings>,
  <iceandfire:armor_sapphire_boots>,
  <iceandfire:armor_sapphire_chestplate>,
  <iceandfire:armor_sapphire_helmet>,
  <iceandfire:armor_sapphire_leggings>,
  <iceandfire:armor_silver_boots>,
  <iceandfire:armor_silver_chestplate>,
  <iceandfire:armor_silver_helmet>,
  <iceandfire:armor_silver_leggings>,
  <iceandfire:armor_white_boots>,
  <iceandfire:armor_white_chestplate>,
  <iceandfire:armor_white_helmet>,
  <iceandfire:armor_white_leggings>,
  <iceandfire:deathworm_red_boots>,
  <iceandfire:deathworm_red_chestplate>,
  <iceandfire:deathworm_red_helmet>,
  <iceandfire:deathworm_red_leggings>,
  <iceandfire:deathworm_white_boots>,
  <iceandfire:deathworm_white_chestplate>,
  <iceandfire:deathworm_white_helmet>,
  <iceandfire:deathworm_white_leggings>,
  <iceandfire:deathworm_yellow_boots>,
  <iceandfire:deathworm_yellow_chestplate>,
  <iceandfire:deathworm_yellow_helmet>,
  <iceandfire:deathworm_yellow_leggings>,
  <iceandfire:dragonsteel_fire_boots>,
  <iceandfire:dragonsteel_fire_chestplate>,
  <iceandfire:dragonsteel_fire_helmet>,
  <iceandfire:dragonsteel_fire_leggings>,
  <iceandfire:dragonsteel_ice_boots>,
  <iceandfire:dragonsteel_ice_chestplate>,
  <iceandfire:dragonsteel_ice_helmet>,
  <iceandfire:dragonsteel_ice_leggings>,
  <iceandfire:forest_troll_leather_boots>,
  <iceandfire:forest_troll_leather_chestplate>,
  <iceandfire:forest_troll_leather_helmet>,
  <iceandfire:forest_troll_leather_leggings>,
  <iceandfire:frost_troll_leather_boots>,
  <iceandfire:frost_troll_leather_chestplate>,
  <iceandfire:frost_troll_leather_helmet>,
  <iceandfire:frost_troll_leather_leggings>,
  <iceandfire:mountain_troll_leather_boots>,
  <iceandfire:mountain_troll_leather_chestplate>,
  <iceandfire:mountain_troll_leather_helmet>,
  <iceandfire:mountain_troll_leather_leggings>,
  <iceandfire:myrmex_desert_boots>,
  <iceandfire:myrmex_desert_chestplate>,
  <iceandfire:myrmex_desert_helmet>,
  <iceandfire:myrmex_desert_leggings>,
  <iceandfire:myrmex_jungle_boots>,
  <iceandfire:myrmex_jungle_chestplate>,
  <iceandfire:myrmex_jungle_helmet>,
  <iceandfire:myrmex_jungle_leggings>,
  <iceandfire:tide_blue_boots>,
  <iceandfire:tide_blue_chestplate>,
  <iceandfire:tide_blue_helmet>,
  <iceandfire:tide_blue_leggings>,
  <iceandfire:tide_bronze_boots>,
  <iceandfire:tide_bronze_chestplate>,
  <iceandfire:tide_bronze_helmet>,
  <iceandfire:tide_bronze_leggings>,
  <iceandfire:tide_deepblue_boots>,
  <iceandfire:tide_deepblue_chestplate>,
  <iceandfire:tide_deepblue_helmet>,
  <iceandfire:tide_deepblue_leggings>,
  <iceandfire:tide_green_boots>,
  <iceandfire:tide_green_chestplate>,
  <iceandfire:tide_green_helmet>,
  <iceandfire:tide_green_leggings>,
  <iceandfire:tide_purple_boots>,
  <iceandfire:tide_purple_chestplate>,
  <iceandfire:tide_purple_helmet>,
  <iceandfire:tide_purple_leggings>,
  <iceandfire:tide_red_boots>,
  <iceandfire:tide_red_chestplate>,
  <iceandfire:tide_red_helmet>,
  <iceandfire:tide_red_leggings>,
  <iceandfire:tide_teal_boots>,
  <iceandfire:tide_teal_chestplate>,
  <iceandfire:tide_teal_helmet>,
  <iceandfire:tide_teal_leggings>,
] as IItemStack[] {
  cosmetic.maxDamage = 1;
  for i in 2 .. 10 { cosmetic.removeTooltipLine(i); }
  scripts.lib.tooltip.desc.tooltip(cosmetic, 'cosmetic_equipment');
}
