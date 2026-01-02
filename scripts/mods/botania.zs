#modloaded botania

import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.potions.IPotion;
import native.net.minecraft.potion.PotionEffect;
import native.vazkii.botania.common.lib.LibBrewNames;
import native.vazkii.botania.common.brew.BrewMod;
import native.vazkii.botania.common.brew.ModPotions;

// ----- Orechid progression -----#

Purge(<botania:elementiumsword>);

// Remove unused ORE
mods.botania.Orechid.removeOre('oreTungsten');

// Remove orechid advanced ore (only leave basic ones)
mods.botania.Orechid.removeOre('oreCoal');
mods.botania.Orechid.removeOre('oreIron');
mods.botania.Orechid.removeOre('oreCopper');
mods.botania.Orechid.removeOre('oreLead');
mods.botania.Orechid.removeOre('oreTin');
mods.botania.Orechid.removeOre('oreOsmium');
mods.botania.Orechid.removeOre('oreSilver');
mods.botania.Orechid.removeOre('oreQuartzBlack');
mods.botania.Orechid.removeOre('oreAluminium');
mods.botania.Orechid.removeOre('oreAluminum');
mods.botania.Orechid.removeOre('oreGold');
mods.botania.Orechid.removeOre('oreNickel');
mods.botania.Orechid.removeOre('oreUranium');
mods.botania.Orechid.removeOre('oreDiamond');
mods.botania.Orechid.removeOre('oreTopaz');
mods.botania.Orechid.removeOre('oreMalachite');
mods.botania.Orechid.removeOre('oreTanzanite');
mods.botania.Orechid.removeOre('oreRuby');
mods.botania.Orechid.removeOre('orePeridot');
mods.botania.Orechid.removeOre('oreEmerald');
mods.botania.Orechid.removeOre('orePlatinum');
mods.botania.Orechid.removeOre('oreMithril');
mods.botania.Orechid.removeOre('oreSapphire');
mods.botania.Orechid.removeOre('oreRedstone');

// Buff Apatite
mods.botania.Orechid.removeOre('oreApatite');
mods.botania.Orechid.addOre('oreApatite', 7000);

// Add Orechid Ingem ores
mods.botania.OrechidIgnem.addOre('oreNetherChargedCertusQuartz', 800);
mods.botania.OrechidIgnem.addOre('oreNetherRuby', 8000);
mods.botania.OrechidIgnem.addOre('oreNetherPeridot', 4000);

// -------------------------------#
// [Orechid] from [Mystical Red Petal][+7]
mods.botania.Apothecary.removeRecipe('excompressum.orechidEvolved');
mods.botania.Apothecary.addRecipe('excompressum.orechidEvolved', [
  <ore:petalGray>,       // Mystical Gray Petal
  <ore:petalYellow>,     // Mystical Yellow Petal
  <ore:petalGreen>,      // Mystical Green Petal
  <ore:petalRed>,        // Mystical Red Petal
  <ore:quicksilver>,     // Quicksilver
  <ore:redstoneRoot>,    // Redstone Root
  <ore:nuggetBrass>,     // Alchemical Brass Nugget
  <ore:nuggetManasteel>, // Manasteel Nugget
]);

// [Orechid Ignem] from [Rune of Autumn][+7]
mods.botania.Apothecary.removeRecipe('orechidIgnem');
mods.botania.Apothecary.addRecipe('orechidIgnem', [
  <ore:petalRed>,       // Mystical Red Petal
  <ore:petalWhite>,     // Mystical White Petal
  <ore:petalPink>,      // Mystical Pink Petal
  <ore:runeAutumnB>,    // Rune of Autumn
  <ore:runeManaB>,      // Rune of Mana
  <ore:redstoneRoot>,   // Redstone Root
  <ore:nuggetThaumium>, // Thaumium Nugget
  <ore:stoneMetamorphic>,
]);

// [Orechid Vacuam] from [Rune of Pride][+7]
mods.botania.Apothecary.removeRecipe('orechidVacuam');
mods.botania.Apothecary.addRecipe('orechidVacuam', [
  <ore:petalYellow>,      // Mystical Yellow Petal
  <ore:petalPurple>,      // Mystical Purple Petal
  <ore:petalBlack>,       // Mystical Black Petal
  <ore:runePrideB>,       // Rune of Pride
  <ore:runeGreedB>,       // Rune of Greed
  <ore:redstoneRoot>,     // Redstone Root
  <ore:nuggetVoid>,       // Void Metal Nugget
  <ore:nuggetTerrasteel>, // Terrasteel Nugget
]);
// -------------------------------#

// Mana Pool
recipes.remove(<botania:pool>);
recipes.addShapedMirrored('Mana Pool',
  <botania:pool>,
  [[<botania:petalblock:8>, <astralsorcery:itemrockcrystalsimple>.anyDamage(), <botania:petalblock>],
    [<ore:livingrock>, null, <ore:livingrock>],
    [<ore:livingrock>, <botania:pool:2>, <ore:livingrock>]]);

// Diluted Mana Pool
recipes.remove(<botania:pool:2>);
recipes.addShapedMirrored('Diluted Mana Pool',
  <botania:pool:2>,
  [[<ore:dyeLightBlue>, <ore:dyeLightBlue>, <ore:dyeLightBlue>],
    [<ore:livingrock>, null, <ore:livingrock>],
    [<ore:livingrock>, <ore:livingrock>, <ore:livingrock>]]);

// Mana Spreaders
// Normal
recipes.remove(<botania:spreader>);
recipes.addShapedMirrored('Mana Spreader',
  <botania:spreader>,
  [[<botania:livingwood:5>, <ore:livingwood>, <ore:livingwood>],
    [<astralsorcery:itemusabledust>, <botania:petalblock:5>, <ore:livingwood>],
    [<botania:livingwood:5>, <ore:livingwood>, <ore:livingwood>]]);

// Elven
recipes.remove(<botania:spreader:2>);
recipes.addShapedMirrored('Elven Mana Spreader',
  <botania:spreader:2>,
  [[<ore:dreamwood>, <ore:dreamwood>, <ore:dreamwood>],
    [<ore:dustAstralStarmetal>, <botania:spreader>, <tconstruct:tough_tool_rod>.withTag({ Material: 'elementium' })],
    [<ore:dreamwood>, <ore:dreamwood>, <ore:dreamwood>]]);

// Gaia
recipes.remove(<botania:spreader:3>);
recipes.addShapedMirrored('Gaia Mana Spreader',
  <botania:spreader:3>,
  [[<botania:bifrostperm>, <botania:bifrostperm>, <botania:bifrostperm>],
    [<ore:eternalLifeEssence>, <botania:spreader:2>, <astralsorcery:itemcoloredlens>.anyDamage()],
    [<botania:bifrostperm>, <botania:bifrostperm>, <botania:bifrostperm>]]);

// Gaia Spirit Duplication
mods.bloodmagic.AlchemyTable.addRecipe(<botania:manaresource:5> * 4,
  [<botania:manaresource:5>, <bloodmagic:item_demon_crystal:1>, <bloodmagic:item_demon_crystal:2>,
    <bloodmagic:item_demon_crystal:3>, <bloodmagic:item_demon_crystal:4>, <bloodmagic:points_upgrade>], 100000, 300, 4);

// Peaceful alt
// [Gaia Spirit] from [Avatar of Ratlantis][+10]
mods.thaumcraft.Infusion.registerRecipe(
  'GaiaSpirit', // Name
  'INFUSION', // Research
  <botania:manaresource:5>, // Output
  10, // Instability
  Aspects('100☀️ 100🐲 100🐀'),
  <rats:idol_of_ratlantis>, // Central Item
  Grid(['pretty',
    'S ◊ ╳',
    '▬   ▬',
    '* ◊ D'], {
    'S': <bloodmagic:item_demon_crystal:4>, // Steadfast Will Crystal
    '◊': <astralsorcery:itemcelestialcrystal:*>,
    '╳': <bloodmagic:item_demon_crystal:1>, // Corrosive Will Crystal
    '▬': <ore:ingotMirion>, // Mirion Ingot
    '*': <bloodmagic:item_demon_crystal:3>, // Vengeful Will Crystal
    'D': <bloodmagic:item_demon_crystal:2>, // Destructive Will Crystal
  }).spiral(1));

// Peaceful alt
// [Dice of Fate] from [Chaos Shard][+4]
mods.thaumcraft.Infusion.registerRecipe(
  'dice', // Name
  'INFUSION', // Research
  <botania:dice>, // Output
  10, // Instability
  Aspects('160☀️ 160🔷'),
  <draconicevolution:chaos_shard>, // Central Item
  Grid(['pretty',
    '  D  ',
    'D   D',
    '  D  '], {
    'D': <cyclicmagic:dice>, // Dice
  }).spiral(1));

for relic in [
  <botania:infinitefruit>,
  <botania:kingkey>,
  <botania:flugeleye>,
  <botania:lokiring>,
  <botania:odinring>,
  <botania:thorring>,
] as IItemStack[] {
  recipes.addShapeless(relic, [relic.anyDamage().reuse(), <botania:dice>]);
}

// Livingrock
mods.botania.PureDaisy.removeRecipe(<botania:livingrock>);
mods.botania.PureDaisy.addRecipe(<thaumcraft:stone_arcane>, <botania:livingrock>);

// Livingwood
mods.botania.PureDaisy.removeRecipe(<botania:livingwood>);
mods.botania.PureDaisy.addRecipe(<astralsorcery:blockinfusedwood>, <botania:livingwood>);

// Obsidian cheaper
mods.botania.PureDaisy.removeRecipe(<minecraft:obsidian>);
mods.botania.PureDaisy.addRecipe(<tconstruct:firewood>, <minecraft:obsidian>);

// Gaia Ingot
recipes.remove(<botania:manaresource:14>);
recipes.addShapedMirrored('Gaia Ingot',
  <botania:manaresource:14>,
  [[<ore:dustMana>, <ore:eternalLifeEssence>, <ore:dustMana>],
    [<ore:eternalLifeEssence>, <ore:ingotTerrasteel>, <ore:eternalLifeEssence>],
    [<ore:ingotManasteel>, <ore:eternalLifeEssence>, <ore:ingotManasteel>]]);

// Gaia Pylon
recipes.remove(<botania:pylon:2>);
recipes.addShapedMirrored('Gaia Pylon',
  <botania:pylon:2>,
  [[<ore:dustMana>, <ore:elvenPixieDust>, <ore:dustMana>],
    [<ore:ingotElvenElementium>, <botania:pylon>, <ore:ingotElvenElementium>],
    [<ore:dustMana>, <ore:elvenPixieDust>, <ore:dustMana>]]);

// Elven Gateway Core
recipes.remove(<botania:alfheimportal>);
mods.astralsorcery.Altar.addConstellationAltarRecipe('enigmatica2expert:shaped/internal/altar/elven_gateway_core',
  <botania:alfheimportal>, 2800, 300, [
    <ore:livingwood>, <botania:livingwood:5>, <ore:livingwood>,
    <botania:livingwood:5>, <botania:petalblock:5>, <botania:livingwood:5>,
    <ore:livingwood>, <botania:livingwood:5>, <ore:livingwood>,
    <ore:nuggetTerrasteel>, <ore:nuggetTerrasteel>, <ore:nuggetTerrasteel>, <ore:nuggetTerrasteel>,
    <astralsorcery:blockmarble:6>, <astralsorcery:blockmarble:6>,
    <ore:ingotAstralStarmetal>, <ore:ingotAstralStarmetal>,
    <astralsorcery:itemcraftingcomponent:4>, <astralsorcery:itemcraftingcomponent:4>,
    <astralsorcery:blockmarble:6>, <astralsorcery:blockmarble:6>]);

// Petal Apothecary
recipes.remove(<botania:altar>);
mods.astralsorcery.Altar.addDiscoveryAltarRecipe('enigmatica2expert:shaped/internal/altar/petal_apothecary',
  <botania:altar>, 200, 450,
  [<minecraft:stone_slab:3>, <botania:petal>, <minecraft:stone_slab:3>,
    null, <ore:cobblestone>, null,
    <ore:cobblestone>, <ore:cobblestone>, <ore:cobblestone>]);

// Runic Altar
recipes.remove(<botania:runealtar>);
mods.astralsorcery.Altar.addDiscoveryAltarRecipe('enigmatica2expert:shaped/internal/altar/runic_altar1',
  <botania:runealtar>, 200, 800,
  [null, <astralsorcery:itemrockcrystalsimple>.anyDamage(), null,
    <botania:livingrock>, <botania:manaresource:1>, <botania:livingrock>,
    <botania:livingrock>, <botania:livingrock>, <botania:livingrock>]);

mods.astralsorcery.Altar.addDiscoveryAltarRecipe('enigmatica2expert:shaped/internal/altar/runic_altar2',
  <botania:runealtar>, 200, 800,
  [null, <astralsorcery:itemrockcrystalsimple>.anyDamage(), null,
    <botania:livingrock>, <botania:manaresource:2>, <botania:livingrock>,
    <botania:livingrock>, <botania:livingrock>, <botania:livingrock>]);

// Super travel belt
recipes.remove(<botania:supertravelbelt>);
recipes.addShaped("Botania Globetrotter's Sash",
  <botania:supertravelbelt>,
  [[null, <botania:manaresource:14>, null],
    [<botania:manaresource:7>, <botania:travelbelt>, <botania:manaresource:7>],
    [null, <thaumcraft:baubles:6>, null]]);

// Knockback belt
recipes.remove(<botania:knockbackbelt>);
recipes.addShaped('Botania Knockback belt', <botania:knockbackbelt>,
  [[null, <ore:ingotManasteel>, null],
    [<ore:runeEarthB>, <thaumcraft:baubles:2>, <ore:runeFireB>],
    [null, null, null]]);

// travel belt
recipes.remove(<botania:travelbelt>);
recipes.addShaped('Botania travel belt',
  <botania:travelbelt>,
  [[null, <ore:ingotManasteel>, null],
    [<ore:runeEarthB>, <thaumcraft:baubles:2>, <ore:runeAirB>],
    [null, null, null]]);

// rings
recipes.remove(<botania:swapring>);
recipes.remove(<botania:manaring>);
recipes.remove(<botania:pixiering>);
recipes.remove(<botania:reachring>);
recipes.remove(<botania:dodgering>);
recipes.remove(<botania:magnetring>);
recipes.remove(<botania:miningring>);
recipes.remove(<botania:waterring>);
recipes.remove(<botania:auraring>);

recipes.addShapeless('Botania ring 1', <botania:swapring>, [<minecraft:clay>, <thaumcraft:baubles:5>]);
recipes.addShapeless('Botania ring 2', <botania:manaring>, [<botania:manatablet>, <thaumcraft:baubles:5>]);
recipes.addShapeless('Botania ring 3', <botania:pixiering>, [<botania:manaresource:8>, <thaumcraft:baubles:5>, <botania:manaresource:7>]);
recipes.addShapeless('Botania ring 4', <botania:reachring>, [<botania:rune:15>, <thaumcraft:baubles:5>, <botania:manaresource:7>]);
recipes.addShapeless('Botania ring 5', <botania:dodgering>, [<botania:rune:3>, <thaumcraft:baubles:5>, <minecraft:emerald>]);
recipes.addShapeless('Botania ring 6', <botania:magnetring>, [<botania:lens:10>, <thaumcraft:cloud_ring>, <astralsorcery:itemcoloredlens:5>, <tconstruct:large_plate>.withTag({ Material: 'starmetal' })]);
recipes.addShapeless('Botania ring 7', <botania:miningring>, [<botania:rune:2>, <thaumcraft:baubles:5>, <minecraft:golden_pickaxe>]);
recipes.addShapeless('Botania ring 8', <botania:waterring>, [<botania:rune>, <thaumcraft:baubles:5>, <minecraft:fish:1>, <minecraft:fish:3>]);
recipes.addShapeless('Botania ring 9', <botania:auraring>, [<botania:rune:8>, <thaumcraft:baubles:5>]);

// Mystical Flower Petal Duplication
recipes.addShapeless('Petal Duplication0', <botania:petal> * 4, [<botania:petal>, <ore:fertilizer>, <ore:fertilizer>, <ore:fertilizer>, <ore:fertilizer>]);
recipes.addShapeless('Petal Duplication1', <botania:petal:1> * 4, [<botania:petal:1>, <ore:fertilizer>, <ore:fertilizer>, <ore:fertilizer>, <ore:fertilizer>]);
recipes.addShapeless('Petal Duplication2', <botania:petal:2> * 4, [<botania:petal:2>, <ore:fertilizer>, <ore:fertilizer>, <ore:fertilizer>, <ore:fertilizer>]);
recipes.addShapeless('Petal Duplication3', <botania:petal:3> * 4, [<botania:petal:3>, <ore:fertilizer>, <ore:fertilizer>, <ore:fertilizer>, <ore:fertilizer>]);
recipes.addShapeless('Petal Duplication4', <botania:petal:4> * 4, [<botania:petal:4>, <ore:fertilizer>, <ore:fertilizer>, <ore:fertilizer>, <ore:fertilizer>]);
recipes.addShapeless('Petal Duplication5', <botania:petal:5> * 4, [<botania:petal:5>, <ore:fertilizer>, <ore:fertilizer>, <ore:fertilizer>, <ore:fertilizer>]);
recipes.addShapeless('Petal Duplication6', <botania:petal:6> * 4, [<botania:petal:6>, <ore:fertilizer>, <ore:fertilizer>, <ore:fertilizer>, <ore:fertilizer>]);
recipes.addShapeless('Petal Duplication7', <botania:petal:7> * 4, [<botania:petal:7>, <ore:fertilizer>, <ore:fertilizer>, <ore:fertilizer>, <ore:fertilizer>]);
recipes.addShapeless('Petal Duplication8', <botania:petal:8> * 4, [<botania:petal:8>, <ore:fertilizer>, <ore:fertilizer>, <ore:fertilizer>, <ore:fertilizer>]);
recipes.addShapeless('Petal Duplication9', <botania:petal:9> * 4, [<botania:petal:9>, <ore:fertilizer>, <ore:fertilizer>, <ore:fertilizer>, <ore:fertilizer>]);
recipes.addShapeless('Petal Duplication10', <botania:petal:10> * 4, [<botania:petal:10>, <ore:fertilizer>, <ore:fertilizer>, <ore:fertilizer>, <ore:fertilizer>]);
recipes.addShapeless('Petal Duplication11', <botania:petal:11> * 4, [<botania:petal:11>, <ore:fertilizer>, <ore:fertilizer>, <ore:fertilizer>, <ore:fertilizer>]);
recipes.addShapeless('Petal Duplication12', <botania:petal:12> * 4, [<botania:petal:12>, <ore:fertilizer>, <ore:fertilizer>, <ore:fertilizer>, <ore:fertilizer>]);
recipes.addShapeless('Petal Duplication13', <botania:petal:13> * 4, [<botania:petal:13>, <ore:fertilizer>, <ore:fertilizer>, <ore:fertilizer>, <ore:fertilizer>]);
recipes.addShapeless('Petal Duplication14', <botania:petal:14> * 4, [<botania:petal:14>, <ore:fertilizer>, <ore:fertilizer>, <ore:fertilizer>, <ore:fertilizer>]);
recipes.addShapeless('Petal Duplication15', <botania:petal:15> * 4, [<botania:petal:15>, <ore:fertilizer>, <ore:fertilizer>, <ore:fertilizer>, <ore:fertilizer>]);

function remakeRune(rune as IItemStack, ingrList as IIngredient[], mana as int) {
  mods.botania.RuneAltar.removeRecipe(rune.anyAmount());
  mods.botania.RuneAltar.addRecipe(rune, ingrList, mana);
}

/* Water */   remakeRune(<botania:rune:0> * 2, [<ore:dustBlizz>, <ore:listAllfishraw>, <ore:gemAquamarine>, <ore:ingotManasteel>, <ore:powderMana>], 5000);
/* Fire */    remakeRune(<botania:rune:1> * 2, [<ore:dustBlaze>, <ore:slimeballMagma>, <ore:gemAmber>, <ore:ingotManasteel>, <ore:powderMana>], 5000);
/* Earth */   remakeRune(<botania:rune:2> * 2, [<ore:dustBasalz>, <biomesoplenty:ash>, <ore:podzol>, <ore:ingotManasteel>, <ore:powderMana>], 5000);
/* Air */     remakeRune(<botania:rune:3> * 2, [<ore:dustBlitz>, <ore:boneDragon>, <twilightforest:raven_feather>, <ore:ingotManasteel>, <ore:powderMana>], 5000);
/* Spring */  remakeRune(<botania:rune:4>,     [<ore:runeWaterB>, <ore:runeFireB>, <astralsorcery:blockinfusedwood>, <ore:flower>, <ore:nitor>], 10000);
/* Summer */  remakeRune(<botania:rune:5>,     [<ore:runeEarthB>, <ore:runeAirB>, <ore:treeSapling>, <ore:nuggetBrass>, <ore:livingwood>], 10000);
/* Autumn */  remakeRune(<botania:rune:6>,     [<ore:runeFireB>, <ore:runeAirB>, <ore:quicksilver>, <minecraft:deadbush>, <ore:stoneMetamorphic>], 10000);
/* Winter */  remakeRune(<botania:rune:7>,     [<ore:runeWaterB>, <ore:runeEarthB>, <mctsmelteryio:iceball> ?? <iceandfire:dragon_ice>, <astralsorcery:itemusabledust>, <ore:blockSalt>], 10000);
/* Mana */    remakeRune(<botania:rune:8>,     [<ore:manaPearl>, <ore:powderMana>, <ore:quartzMana>, <ore:manaDiamond>, <ore:clothManaweave>], 20000);
/* Lust */    remakeRune(<botania:rune:9>,     [<ore:manaDiamond>, <ore:manaDiamond>, <botania:rune:5>, <botania:rune:5>, <botania:rune:3>, <botania:rune:3>], 25000);
/* Gluttony */remakeRune(<botania:rune:10>,    [<ore:manaDiamond>, <ore:manaDiamond>, <botania:rune:7>, <botania:rune:7>, <botania:rune:1>, <botania:rune:1>], 25000);
/* Greed */   remakeRune(<botania:rune:11>,    [<ore:manaDiamond>, <ore:manaDiamond>, <botania:rune:4>, <botania:rune:4>, <botania:rune>, <botania:rune>], 25000);
/* Sloth */   remakeRune(<botania:rune:12>,    [<ore:manaDiamond>, <ore:manaDiamond>, <botania:rune:6>, <botania:rune:6>, <botania:rune:3>, <botania:rune:3>], 25000);
/* Wrath */   remakeRune(<botania:rune:13>,    [<ore:manaDiamond>, <ore:manaDiamond>, <botania:rune:7>, <botania:rune:7>, <botania:rune:2>, <botania:rune:2>], 25000);
/* Envy */    remakeRune(<botania:rune:14>,    [<ore:manaDiamond>, <ore:manaDiamond>, <botania:rune:7>, <botania:rune:7>, <botania:rune>, <botania:rune>], 25000);
/* Pride */   remakeRune(<botania:rune:15>,    [<ore:manaDiamond>, <ore:manaDiamond>, <botania:rune:5>, <botania:rune:5>, <botania:rune:1>, <botania:rune:1>], 25000);

// ----- Sapling Cycling -----#

// Remove vanilla loop
mods.botania.ManaInfusion.removeRecipe(<minecraft:sapling>);

// Add modded in loop
val saplings = [
  <minecraft:sapling:5>,
  <ic2:sapling>,
  <integrateddynamics:menril_sapling>,
  <quark:variant_sapling>,
  <quark:variant_sapling:1>,
  <rustic:sapling>,
  <rustic:sapling:1>,
  <rustic:sapling_apple>,
  <thaumcraft:sapling_greatwood>,
  <thaumcraft:sapling_silverwood>,
  <minecraft:sapling>,
] as IItemStack[];
for i, sapling in saplings {
  if (i != 0) {
    mods.botania.ManaInfusion.addAlchemy(saplings[i], saplings[i - 1], 120);
  }
}

// Dragon Bone conversion for rune recipes
mods.botania.ManaInfusion.addAlchemy(<iceandfire:dragonbone>, <ore:blockBone>, 420);

// Myrmex conversion
mods.botania.ManaInfusion.addAlchemy(<iceandfire:myrmex_desert_resin>, <iceandfire:myrmex_jungle_resin>, 120);
mods.botania.ManaInfusion.addAlchemy(<iceandfire:myrmex_jungle_resin>, <iceandfire:myrmex_desert_resin>, 120);

// Colored Glass -> Quark Cave Crystals
mods.botania.PureDaisy.addRecipe(<ore:blockGlassWhite> , <quark:crystal>);
mods.botania.PureDaisy.addRecipe(<ore:blockGlassRed>   , <quark:crystal:1>);
mods.botania.PureDaisy.addRecipe(<ore:blockGlassOrange>, <quark:crystal:2>);
mods.botania.PureDaisy.addRecipe(<ore:blockGlassYellow>, <quark:crystal:3>);
mods.botania.PureDaisy.addRecipe(<ore:blockGlassLime>  , <quark:crystal:4>);
mods.botania.PureDaisy.addRecipe(<ore:blockGlassCyan>  , <quark:crystal:5>);
mods.botania.PureDaisy.addRecipe(<ore:blockGlassBlue>  , <quark:crystal:6>);
mods.botania.PureDaisy.addRecipe(<ore:blockGlassPurple>, <quark:crystal:7>);
mods.botania.PureDaisy.addRecipe(<ore:blockGlassBlack> , <quark:crystal:8>);

// --------------------------
// Mana diamond from Rat Diamond recipe
mods.botania.ManaInfusion.addInfusion(<botania:manaresource:2>, <rats:rat_diamond>, 10000);

// Way cheaper tiny potato dupe
mods.botania.ManaInfusion.removeRecipe(<botania:tinypotato>);
mods.botania.ManaInfusion.addInfusion(<botania:tinypotato> * 640, <minecraft:potato>, 64);

// High-tech potato recipe
mods.qmd.target_chamber.addRecipe(
  <botania:tinypotato>, null,
  (<particle:proton> * 2000000) ^ 100000000,
  <botania_tweaks:compressed_tiny_potato_8>,
  null, null, null, null,
  200000000, 1.0, 0
);

// [Faint Amaranth] from [Goldenrod]
mods.botania.ManaInfusion.addInfusion(<astralsorcery:blockcustomflower>, <biomesoplenty:flower_1:1>, 10000);

// Melt Gaia's Head to receive Dark Matter
scripts.process.melt(<botania:gaiahead>, <liquid:dark_matter> * (144 * 3), 'except: Melter');

// Way cheaper because all mods ca spawn vanilla animals
// [Cocoon of Caprice]*4 from [Pumpkin][+2]
craft.remake(<botania:cocoon> * 4, ['pretty',
  'W B W',
  'W P W',
  'W B W'], {
  'W': <ore:petalWhite>, // Mystical White Petal
  'B': <actuallyadditions:item_hairy_ball>, // Ball of Fur
  'P': <ore:cropPumpkin>, // Pumpkin
});

// Cheaper to compete other timers
// [Hovering Hourglass] from [Redstone Torch][+3]
craft.remake(<botania:hourglass>, ['pretty',
  'G ‚ G',
  'W ♥ W',
  'G ‚ G'], {
  'G': <ore:paneGlass>, // Glass Pane
  '‚': <ore:nuggetGold>, // Gold Nugget
  'W': <ore:petalWhite>, // Mystical White Petal
  '♥': <ore:torchRedstoneActive>, // Redstone Torch
});

// [Black Hole Talisman] from [/dev/null][+3]
recipes.removeByRecipeName("botania:blackholetalisman_0");
craft.make(<botania:blackholetalisman>, ['pretty',
  'M L M',
  '  /  ',
  'M E M'], {
  'M': <ore:petalMagenta>,                // Mystical Magenta Petal
  'L': <randomthings:ingredient:5>,       // Luminous Powder
  '/': <openblocks:dev_null>, // /dev/null
  'E': <ore:bEnderAirBottle>,             // Ender Air Bottle
});

// Alt recipe for magic-only space exploration
// [Dilithium Crystal] from [Dilithium Dust]
mods.botania.ManaInfusion.addInfusion(<libvulpes:productgem>, <ore:dustDilithium>, 10000);

// 🚒 Inworld crafting
recipes.remove(<botania:bifrostperm>);
furnace.addRecipe(<botania:bifrostperm>, <botania:bifrost>, 1.0);

// ////////////////////////////////////////////////////////////////
// Rods rework
// ////////////////////////////////////////////////////////////////

// [Rod of the Shifting Crust] from [Rune of Fire][+2]
craft.remake(<botania:exchangerod>, ['pretty',
  '  s F',
  '  T s',
  'T    '], {
  's': <ore:stone>,          // Stone
  'F': <ore:runeFireB>,      // Rune of Fire
  'T': <ore:livingwoodTwig>, // Livingwood Twig
});

recipes.removeByRecipeName('botania:cobblerod');    recipes.addShaped(<botania:cobblerod>, [[null, null, <ore:cobblestone>], [null, <ore:livingwoodTwig>, null], [<ore:livingwoodTwig>, null, null]]);
recipes.removeByRecipeName('botania:dirtrod');      recipes.addShaped(<botania:dirtrod>, [[null, <minecraft:dirt>], [<ore:livingwoodTwig>, null]]);
recipes.removeByRecipeName('botania:diviningrod');  recipes.addShaped(<botania:diviningrod>, [[null, <ore:livingwoodTwig>, <ore:gemDiamondRat>], [null, <ore:livingwoodTwig>, <ore:livingwoodTwig>], [<ore:livingwoodTwig>, null, null]]);
recipes.removeByRecipeName('botania:firerod');      recipes.addShaped(<botania:firerod>, [[null, <minecraft:blaze_powder>], [<ore:livingwoodTwig>, null]]);
recipes.removeByRecipeName('botania:gravityrod');   recipes.addShaped(<botania:gravityrod>, [[null, <ore:dreamwoodTwig>, null], [null, <ore:cropWheat>, <ore:dreamwoodTwig>], [<ore:dreamwoodTwig>, null, null]]);
recipes.removeByRecipeName('botania:missilerod');   recipes.addShaped(<botania:missilerod>, [[null, <ore:elvenDragonstone>, <ore:elvenDragonstone>], [null, <ore:dreamwoodTwig>, <ore:elvenDragonstone>], [<ore:dreamwoodTwig>, null, null]]);
recipes.removeByRecipeName('botania:smeltrod');     recipes.addShaped(<botania:smeltrod>, [[null, <minecraft:blaze_rod>, null], [null, <ore:livingwoodTwig>, <minecraft:blaze_rod>], [<ore:livingwoodTwig>, null, null]]);
recipes.removeByRecipeName('botania:terraformrod'); recipes.addShaped(<botania:terraformrod>, [[null, null, <ore:ingotTerrasteel>], [null, <botania:dirtrod>, null], [<botania:grassseeds>, null, null]]);
recipes.removeByRecipeName('botania:tornadorod');   recipes.addShaped(<botania:tornadorod>, [[null, <ore:feather>], [<ore:livingwoodTwig>, null]]);
recipes.removeByRecipeName('botania:waterrod');     recipes.addShaped(<botania:waterrod>, [[null, <minecraft:potion>.withTag({Potion: 'minecraft:water'})], [<ore:livingwoodTwig>, null]]);
recipes.removeByRecipeName('botania:skydirtrod');   recipes.addShapeless(<botania:skydirtrod>, [<botania:dirtrod>, <ore:elvenPixieDust>]);
// ////////////////////////////////////////////////////////////////
// To avoid flooding inventory with tens of variants,
// we make them drom common items
for i in 0 .. 16 {
  scripts.lib.dropt.addDrop(
    <botania:mushroom>.definition.makeStack(i),
    [<botania:petal>.definition.makeStack(i)],
    1.25, 'shears;-1;-1');
}
// ////////////////////////////////////////////////////////////////

// New flowers crafting recipes
mods.botania.Apothecary.addRecipe(<botania:specialflower>.withTag({type: "campanimia"}), [
<botania:rune:1>,
<botania:rune:2>,
<botania:rune:3>,
<botania:rune>,
<botania:petal:14>,
<botania:petal:2>,
<botania:petal:4>,
]);
recipes.addShapeless(<botania:floatingspecialflower>.withTag({type: "campanimia"}), [<botania:specialflower>.withTag({type: "campanimia"}), <botania:floatingspecialflower:*>]);

mods.botania.Apothecary.addRecipe(<botania:specialflower>.withTag({type: "nuclianthus"}), [
<botania:petal:13>,
<botania:petal:4>,
<botania:petal:4>,
<botania:petal:1>,
<botania:manaresource:8>,
<botania:rune:6>,
<botania:rune:6>,
]);
recipes.addShapeless(<botania:floatingspecialflower>.withTag({type: "nuclianthus"}), [<botania:specialflower>.withTag({type: "nuclianthus"}), <botania:floatingspecialflower:*>]);

mods.botania.Apothecary.addRecipe(<botania:specialflower>.withTag({type: "rokku_eryngium"}), [
<botania:manaresource:5>,
<botania:manaresource:9>,
<botania:rune:11>,
<botania:rune:12>,
<botania:petal:11>,
<botania:petal>,
<botania:petal>,
]);
recipes.addShapeless(<botania:floatingspecialflower>.withTag({type: "rokku_eryngium"}), [<botania:specialflower>.withTag({type: "rokku_eryngium"}), <botania:floatingspecialflower:*>]);

mods.botania.Apothecary.addRecipe(<botania:specialflower>.withTag({type: "jikanacea"}), [
<astralsorcery:itemcraftingcomponent:4>,
<botania:rune:14>,
<botania:rune:9>,
<botania:petal:2>,
<botania:petal:4>,
<botania:petal:4>,
<thaumicaugmentation:material:5>,
<botania:manaresource:9>,
]);
recipes.addShapeless(<botania:floatingspecialflower>.withTag({type: "jikanacea"}), [<botania:specialflower>.withTag({type: "jikanacea"}), <botania:floatingspecialflower:*>]);

mods.botania.Apothecary.addRecipe(<botania:specialflower>.withTag({type: "echinacenko"}), [
<botania:petal:2>,
<botania:petal:2>,
<botania:petal:5>,
<botania:rune:10>,
<botania:rune:12>,
<botania:manaresource:1>,
]);
recipes.addShapeless(<botania:floatingspecialflower>.withTag({type: "echinacenko"}), [<botania:specialflower>.withTag({type: "echinacenko"}), <botania:floatingspecialflower:*>]);

mods.botania.Apothecary.addRecipe(<botania:specialflower>.withTag({type: "antirrhift"}), [
<botania:manaresource:8>,
<botania:rune:15>,
<botania:petal:2>,
<botania:petal>,
<botania:petal>,
<thaumicaugmentation:material:5>,
<thaumicaugmentation:material:5>,
]);
recipes.addShapeless(<botania:floatingspecialflower>.withTag({type: "antirrhift"}), [<botania:specialflower>.withTag({type: "antirrhift"}), <botania:floatingspecialflower:*>]);

mods.botania.Apothecary.addRecipe(<botania:specialflower>.withTag({type: "amuileria_kaerunea"}), [
<botania:manaresource:9>,
<botania:rune:8>,
<minecraft:end_rod>,
<botania:petal:3>,
<botania:petal:3>,
<botania:petal:4>,
<botania:petal>,
]);
recipes.addShapeless(<botania:floatingspecialflower>.withTag({type: "amuileria_kaerunea"}), [<botania:specialflower>.withTag({type: "amuileria_kaerunea"}), <botania:floatingspecialflower:*>]);

BrewMod(LibBrewNames.SPEED,           0x59B7FF, 4000, [<potion:minecraft:speed>          .makePotionEffect(864000, 3)]);
mods.botania.Brew.removeRecipe(LibBrewNames.SPEED);
mods.botania.Brew.addRecipe([<minecraft:nether_wart>, <minecraft:sugar>, <actuallyadditions:item_dust:7>], LibBrewNames.SPEED);
BrewMod(LibBrewNames.STRENGTH,        0xEE3F3F, 4000, [<potion:minecraft:strength>       .makePotionEffect(72000, 3)]);
mods.botania.Brew.removeRecipe(LibBrewNames.STRENGTH);
mods.botania.Brew.addRecipe([<minecraft:nether_wart>, <minecraft:blaze_powder>, <astralsorcery:itemusabledust>], LibBrewNames.STRENGTH);
BrewMod(LibBrewNames.HASTE,           0xF4A432, 4000, [<potion:minecraft:haste>          .makePotionEffect(864000, 3)]);
mods.botania.Brew.removeRecipe(LibBrewNames.HASTE);
mods.botania.Brew.addRecipe([<minecraft:nether_wart>, <minecraft:prismarine_crystals>, <actuallyadditions:item_dust:7>], LibBrewNames.HASTE);
BrewMod(LibBrewNames.HEALING,         0xFF5ECC, 6000, [<potion:minecraft:instant_health> .makePotionEffect(1, 19)]);
mods.botania.Brew.removeRecipe(LibBrewNames.HEALING);
mods.botania.Brew.addRecipe([<minecraft:nether_wart>, <minecraft:speckled_melon>, <thaumcraft:quicksilver>], LibBrewNames.HEALING);
BrewMod(LibBrewNames.JUMP_BOOST,      0x32F46D, 4000, [<potion:minecraft:jump_boost>     .makePotionEffect(864000, 3)]);
mods.botania.Brew.removeRecipe(LibBrewNames.JUMP_BOOST);
mods.botania.Brew.addRecipe([<minecraft:nether_wart>, <minecraft:rabbit_foot>, <actuallyadditions:item_dust:7>], LibBrewNames.JUMP_BOOST);
BrewMod(LibBrewNames.REGEN,           0xFD6488, 7000, [<potion:minecraft:regeneration>   .makePotionEffect(72000, 3)]);
mods.botania.Brew.removeRecipe(LibBrewNames.REGEN);
mods.botania.Brew.addRecipe([<minecraft:nether_wart>, <minecraft:ghast_tear>, <astralsorcery:itemusabledust>], LibBrewNames.REGEN);
BrewMod(LibBrewNames.REGEN_WEAK,      0xFD6488, 9000, [<potion:minecraft:regeneration>   .makePotionEffect(864000, 0)]);
mods.botania.Brew.removeRecipe(LibBrewNames.REGEN_WEAK);
mods.botania.Brew.addRecipe([<minecraft:nether_wart>, <minecraft:ghast_tear>, <actuallyadditions:item_dust:7>], LibBrewNames.REGEN_WEAK);
BrewMod(LibBrewNames.RESISTANCE,      0xB44E17, 4000, [<potion:minecraft:resistance>     .makePotionEffect(864000, 1)]);
mods.botania.Brew.removeRecipe(LibBrewNames.RESISTANCE);
mods.botania.Brew.addRecipe([<minecraft:nether_wart>, <minecraft:quartz>, <actuallyadditions:item_dust:7>], LibBrewNames.RESISTANCE);
BrewMod(LibBrewNames.FIRE_RESISTANCE, 0xF86900, 4000, [<potion:minecraft:fire_resistance>.makePotionEffect(864000, 0)]);
mods.botania.Brew.removeRecipe(LibBrewNames.FIRE_RESISTANCE);
mods.botania.Brew.addRecipe([<minecraft:nether_wart>, <minecraft:magma_cream>, <actuallyadditions:item_dust:7>], LibBrewNames.FIRE_RESISTANCE);
BrewMod(LibBrewNames.WATER_BREATHING, 0x84A7CF, 4000, [<potion:minecraft:water_breathing>.makePotionEffect(864000, 0)]);
mods.botania.Brew.removeRecipe(LibBrewNames.WATER_BREATHING);
mods.botania.Brew.addRecipe([<minecraft:nether_wart>, <minecraft:fish:3>, <actuallyadditions:item_dust:7>], LibBrewNames.WATER_BREATHING);
BrewMod(LibBrewNames.INVISIBILITY,    0xAEAEAE, 8000, [<potion:minecraft:invisibility>   .makePotionEffect(864000, 0)]).setNotBloodPendantInfusable();
mods.botania.Brew.removeRecipe(LibBrewNames.INVISIBILITY);
mods.botania.Brew.addRecipe([<minecraft:nether_wart>,<minecraft:golden_carrot>, <minecraft:fermented_spider_eye>, <actuallyadditions:item_dust:7>], LibBrewNames.INVISIBILITY);
BrewMod(LibBrewNames.NIGHT_VISION,    0x7C4BEB, 4000, [<potion:minecraft:night_vision>   .makePotionEffect(864000, 0)]);
mods.botania.Brew.removeRecipe(LibBrewNames.NIGHT_VISION);
mods.botania.Brew.addRecipe([<minecraft:nether_wart>, <minecraft:golden_carrot>, <actuallyadditions:item_dust:7>], LibBrewNames.NIGHT_VISION);
BrewMod(LibBrewNames.ABSORPTION,      0xF2EB23, 7000, [<potion:minecraft:absorption>     .makePotionEffect(72000, 9)]).setNotBloodPendantInfusable().setNotIncenseInfusable();
mods.botania.Brew.removeRecipe(LibBrewNames.ABSORPTION);
mods.botania.Brew.addRecipe([<minecraft:nether_wart>, <minecraft:golden_apple>, <astralsorcery:itemusabledust>], LibBrewNames.ABSORPTION);
BrewMod(LibBrewNames.WARP_WARD,       0xFBBDFF, 25000,[<potion:thaumcraft:warpward>.makePotionEffect(1728000, 0)]).setNotBloodPendantInfusable();
mods.botania.Brew.removeRecipe(LibBrewNames.WARP_WARD);
mods.botania.Brew.addRecipe([<minecraft:nether_wart>, <thaumadditions:odour_powder>, <actuallyadditions:item_dust:7>,<thaumcraft:amber>], LibBrewNames.WARP_WARD);

BrewMod(LibBrewNames.SOUL_CROSS,       10000,[PotionEffect(ModPotions.soulCross, 72000, 0)]);
mods.botania.Brew.removeRecipe(LibBrewNames.SOUL_CROSS);
mods.botania.Brew.addRecipe([<minecraft:nether_wart>, <ore:boneWither>, <randomthings:ingredient:7>], LibBrewNames.SOUL_CROSS);
BrewMod(LibBrewNames.FEATHER_FEET,     7000, [PotionEffect(ModPotions.featherfeet, 864000, 0)]);
mods.botania.Brew.removeRecipe(LibBrewNames.FEATHER_FEET);
mods.botania.Brew.addRecipe([<minecraft:nether_wart>, <minecraft:feather>, <actuallyadditions:item_dust:7>], LibBrewNames.FEATHER_FEET);
BrewMod(LibBrewNames.EMPTINESS,        30000,[PotionEffect(ModPotions.emptiness, 864000, 0)]);
mods.botania.Brew.removeRecipe(LibBrewNames.EMPTINESS);
mods.botania.Brew.addRecipe([<minecraft:nether_wart>, <thaumcraft:shimmerleaf>, <actuallyadditions:item_dust:7>, <darkutils:material>], LibBrewNames.EMPTINESS);
BrewMod(LibBrewNames.BLOODTHIRST,      20000,[PotionEffect(ModPotions.bloodthrst, 72000, 0)]);
mods.botania.Brew.removeRecipe(LibBrewNames.BLOODTHIRST);
mods.botania.Brew.addRecipe([<minecraft:nether_wart>, <thaumcraft:vishroom>, <actuallyadditions:item_dust:7>, <darkutils:material>], LibBrewNames.BLOODTHIRST);
BrewMod(LibBrewNames.ALLURE,           2000, [PotionEffect(ModPotions.allure, 864000, 0)]);
mods.botania.Brew.removeRecipe(LibBrewNames.ALLURE);
mods.botania.Brew.addRecipe([<minecraft:nether_wart>, <harvestcraft:fishtrapbaititem>, <actuallyadditions:item_dust:7>], LibBrewNames.ALLURE);
//BrewMod(LibBrewNames.CLEAR,            4000, [PotionEffect(ModPotions.clear, 0, 0)]);
mods.botania.Brew.removeRecipe(LibBrewNames.CLEAR);
mods.botania.Brew.addRecipe([<minecraft:nether_wart>, <ore:listAllmilk>, <thaumcraft:quicksilver>], LibBrewNames.CLEAR);

BrewMod('chronos',             0xD3D3D3, 10000, [PotionEffect(<potion:contenttweaker:chronos>, 36000, 0)]);
mods.botania.Brew.addRecipe([<minecraft:nether_wart>, <twilightforest:magic_leaves>, <contenttweaker:compressed_white_sand>, <astralsorcery:itemusabledust>], 'chronos');
BrewMod('darkness_resistance', 0xFFF58A, 5000, [PotionEffect(<potion:contenttweaker:darkness_resistance>, 864000, 0)]);
mods.botania.Brew.addRecipe([<minecraft:nether_wart>, <twilightforest:torchberries>, <actuallyadditions:item_dust:7>], 'darkness_resistance');
BrewMod('easyculty',           0x009900, 5000, [PotionEffect(<potion:contenttweaker:easyculty>, 72000, 0)]);
mods.botania.Brew.addRecipe([<minecraft:nether_wart>, <biomesoplenty:shroompowder>, <cyclicmagic:heart_toxic>, <thaumcraft:void_seed>], 'easyculty');

BrewMod(LibBrewNames.OVERLOAD, 0x232323, 12000, [
  <potion:minecraft:strength>.makePotionEffect(12000, 9),
  <potion:minecraft:speed>   .makePotionEffect(12000, 4),
  <potion:minecraft:weakness>.makePotionEffect(24000, 1),
  <potion:minecraft:hunger>  .makePotionEffect(6000,  1)
]);
mods.botania.Brew.removeRecipe(LibBrewNames.OVERLOAD);
mods.botania.Brew.addRecipe([<minecraft:nether_wart>, <rustic:ginseng>, <rustic:wind_thistle>, <biomesoplenty:double_plant:2>, <botania:manaresource:23>], LibBrewNames.OVERLOAD);

BrewMod("scarlet_veil", 0xFF0000, 12000, [
    <potion:minecraft:health_boost>  .makePotionEffect(24000, 19),
    <potion:quark:resilience>        .makePotionEffect(24000, 3),
    <potion:minecraft:blindness>     .makePotionEffect(24000, 0),
    <potion:thaumcraft:blurredvision>.makePotionEffect(24000, 0)
]);
mods.botania.Brew.addRecipe([<minecraft:nether_wart>, <rustic:blood_orchid>, <rustic:ironberries>, <extrautils2:redorchid>, <botania:manaresource:23>], "scarlet_veil");

BrewMod("calamity", 0x8B00FF, 15000, [
    <potion:potioncore:chance>  .makePotionEffect(10, 3),
    <potion:tconevo:immortality>.makePotionEffect(600, 0),
    <potion:potioncore:curse>   .makePotionEffect(10, 3),
    <potion:minecraft:unluck>   .makePotionEffect(1200, 0)
]);
mods.botania.Brew.addRecipe([<minecraft:nether_wart>, <rustic:horsetail>, <rustic:marsh_mallow>, <endreborn:item_lormyte_crystal>, <botania:manaresource:23>], "calamity");

BrewMod("warbound", 0xFFD700, 10000, [
    <potion:minecraft:absorption>.makePotionEffect(24000, 19),
    <potion:minecraft:resistance>.makePotionEffect(24000, 3),
    <potion:bloodmagic:deafness> .makePotionEffect(24000, 0),
    <potion:minecraft:slowness>  .makePotionEffect(24000, 1)
]);
mods.botania.Brew.addRecipe([<minecraft:nether_wart>, <rustic:tomato>, <rustic:aloe_vera>, <rustic:honeycomb>, <botania:manaresource:23>], "warbound");

BrewMod("depthbound", 0x1F8EFF, 12000, [
    <potion:minecraft:water_breathing>   .makePotionEffect(24000, 0),
    <potion:cyclicmagic:potion.swimspeed>.makePotionEffect(24000, 3),
    <potion:potioncore:drown>            .makePotionEffect(24000, 0),
    <potion:bloodmagic:grounded>         .makePotionEffect(24000, 0)
]);
mods.botania.Brew.addRecipe([<minecraft:nether_wart>, <rustic:mooncap_mushroom>, <rustic:core_root>, <biomesoplenty:coral:1>, <botania:manaresource:23>], "depthbound");

BrewMod("sanguine_oath", 0x8B0000, 12000, [
    <potion:contenttweaker:self_sacrifice>.makePotionEffect(12000, 2),
    <potion:minecraft:regeneration>       .makePotionEffect(12000, 9),
    <potion:minecraft:nausea>             .makePotionEffect(600, 0),
    <potion:thaumcraft:thaumarhia>        .makePotionEffect(600, 0)
]);
mods.botania.Brew.addRecipe([<minecraft:nether_wart>, <rustic:chamomile>, <rustic:cohosh>, <scalinghealth:crystalshard>, <botania:manaresource:23>], "sanguine_oath");

BrewMod("aerial_delirium", 0xFF69B4, 12000, [
    <potion:potioncore:flight>       .makePotionEffect(24000, 0),
    <potion:potioncore:slow_fall>    .makePotionEffect(24000, 0),
    <potion:potioncore:perplexity>   .makePotionEffect(24000, 0),
    <potion:minecraft:mining_fatigue>.makePotionEffect(24000, 3)
]);
mods.botania.Brew.addRecipe([<minecraft:nether_wart>, <rustic:olives>, <rustic:deathstalk_mushroom>, <iceandfire:pixie_dust>, <botania:manaresource:23>], "aerial_delirium");
