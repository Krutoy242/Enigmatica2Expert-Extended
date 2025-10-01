#modloaded enderio

import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.liquid.ILiquidStack;
import crafttweaker.oredict.IOreDictEntry;

// Remove Weak Conduits and unused alloys
/*
0 - Crude Steel
5 - Energetic Silver
6 - Vivid alloy
*/
for s in [
  'block_alloy_endergy',
  'item_alloy_endergy_nugget',
  'item_alloy_endergy_ingot',
  'item_alloy_endergy_ball',
] as string[] {
  for i in [0, 5] as int[] {
    Purge(itemUtils.getItem('enderio:' ~ s, i));
  }
}

for fluid in [<liquid:crude_steel>, <liquid:energetic_silver>] as ILiquidStack[] {
  mods.nuclearcraft.IngotFormer.removeRecipeWithInput(fluid * 144);
  for n in [144, 16, 144 * 9] as int[] {
    mods.nuclearcraft.Melter.removeRecipeWithOutput(fluid * n);
  }
}

// Remove Unused alloy recipes
mods.nuclearcraft.AlloyFurnace.removeRecipeWithOutput(<enderio:item_alloy_endergy_ingot:1>);
mods.nuclearcraft.AlloyFurnace.removeRecipeWithOutput(<enderio:item_alloy_endergy_ingot:2>);
mods.nuclearcraft.AlloyFurnace.removeRecipeWithOutput(<enderio:item_alloy_endergy_ingot:3> * 2);
mods.nuclearcraft.AlloyFurnace.removeRecipeWithOutput(<enderio:item_alloy_endergy_ingot:5>);
mods.nuclearcraft.AlloyFurnace.removeRecipeWithOutput(<enderio:item_alloy_endergy_ingot:6>);

Purge(<enderio:item_endergy_conduit>);
Purge(<enderio:item_endergy_conduit:1>);
Purge(<enderio:item_endergy_conduit:2>);
Purge(<enderio:item_endergy_conduit:3>);
Purge(<enderio:item_endergy_conduit:4>);
Purge(<enderio:item_endergy_conduit:5>);
Purge(<enderio:item_endergy_conduit:6>);
Purge(<enderio:item_endergy_conduit:7>);
Purge(<enderio:item_capacitor_grainy>);
Purge(<enderio:item_capacitor_silver>);
Purge(<enderio:item_capacitor_energetic_silver>);
Purge(<enderio:item_capacitor_vivid>);
recipes.removeByRecipeName('enderio:capacitor_crystalline_alt');

// Remove liquids of removed alloys
mods.tconstruct.Melting.removeRecipe(<liquid:crude_steel>);
mods.tconstruct.Melting.removeRecipe(<liquid:energetic_silver>);

function getBlockOrNine(ore as IOreDictEntry) as IIngredient {
  val itemName = ore.name.replaceAll('^(item|ingot)', 'block');
  val blockOre = oreDict.get(itemName);
  if(isNull(blockOre) || isNull(blockOre.firstItem)) return (ore as IIngredient) * 9;
  return blockOre.firstItem as IIngredient;
}

val alloyTiers = [
  [<ore:ingotVibrantAlloy>],
  // [Output, input1, input2]
  [<ore:ingotCrystallineAlloy>     , <ore:itemPulsatingPowder>   , <ore:ingotSentientMetal>]   ,
  [<ore:ingotCrystallinePinkSlime> , <ore:itemEnderCrystalPowder>, <ore:ingotPinkMetal>]       ,
  [<ore:ingotMelodicAlloy>         , <ore:itemVibrantPowder>     , <ore:ingotThermoconducting>],
  [<ore:ingotStellarAlloy>         , <ore:itemPrecientPowder>    , <ore:ingotUUMatter>]        ,
] as IOreDictEntry[][];

val ALLOY_RESULT_AMOUNT = 2;

for i, list in alloyTiers {
  if (list.length < 3) continue;

  scripts.process.alloy([
    list[1],
    alloyTiers[i - 1][0],
    list[2]
  ], list[0].firstItem * ALLOY_RESULT_AMOUNT, 'AdvRockArc');

  val outBlock = getBlockOrNine(list[0]);
  scripts.process.alloy([
    getBlockOrNine(list[1]),
    getBlockOrNine(alloyTiers[i - 1][0]),
    getBlockOrNine(list[2]),
  ], outBlock.items[0] * (outBlock.amount * ALLOY_RESULT_AMOUNT), 'only: AdvRockArc');
}

// [Stellar Energy Conduit]*8 from [Infinity Reagent][+2]
craft.remake(<enderio:item_endergy_conduit:11> * 8, ['pretty',
  'C I C',
  '‚ ‚ ‚',
  'C I C'], {
  'C': <ore:itemConduitBinder>, // Conduit Binder
  'I': <ore:itemInfinityGoop>, // Infinity Reagent
  '‚': <ore:nuggetStellarAlloy>, // Stellar Alloy Nugget
});

// Stepped conduit recipes
// Stellar alloy is exception - it have only 1 ingot in recipe
val BDR = <ore:itemConduitBinder>;
val GP = <ore:itemInfinityGoop>;
val eAlloys = [
  <ore:ingotCrystallineAlloy>,
  <ore:ingotCrystallinePinkSlime>,
  <ore:ingotMelodicAlloy>,
  <ore:nuggetStellarAlloy>,
] as IIngredient[];
val eCndts = [
  <enderio:item_power_conduit:2>,
  <enderio:item_endergy_conduit:8>,
  <enderio:item_endergy_conduit:9>,
  <enderio:item_endergy_conduit:10>,
  <enderio:item_endergy_conduit:11>,
] as IItemStack[];

for i in 0 .. eAlloys.length {
  recipes.addShaped('Cheaper ' ~ getItemName(eCndts[i + 1]), eCndts[i + 1] * 8, [[BDR, i == 3 ? GP : BDR, BDR], [eAlloys[i], eCndts[i], eAlloys[i]], [BDR, i == 3 ? GP : BDR, BDR]]);
}

//////////////////////////////////////////////////
//            Ludicrite replacement             //
//////////////////////////////////////////////////
// Liquids recipe
mods.tconstruct.Alloy.addRecipe(<liquid:vivid_alloy> * 144, [
  <fluid:alumite> * 144,
  <fluid:enrichedlava> * 144,
  <fluid:plutonium_242> * 144,
  <fluid:mutagen> * 144,
  <fluid:enderium> * 144,
]);

// Multiblock Machine recipe
mods.advancedrocketry.RecipeTweaker.forMachine('PrecisionAssembler').builder()
  .inputOre(<ore:blockEnderium>) // Block of Enderium
  .input(<ore:blockAlumite>) // Alumite Block
  .input(<draconicevolution:infused_obsidian>) // Draconium Infused Obsidian
  .input(<ore:blockPlutonium242>) // Plutonium-242 Block
  .inputLiquid(<fluid:mutagen> * 1000)
  .outputItem(<enderio:block_alloy_endergy:6>)
  .power(160000)
  .timeRequired(20)
  .build();
//////////////////////////////////////////////////
