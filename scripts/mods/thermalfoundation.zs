#modloaded thermalfoundation
#ignoreBracketErrors

import crafttweaker.item.IItemStack;

// Remove since unused
for output, input in {
  <thermalfoundation:material:194>: <thermalfoundation:horse_armor_silver>,
  <thermalfoundation:material:226>: <thermalfoundation:horse_armor_invar>,
  <thermalfoundation:material:228>: <thermalfoundation:horse_armor_constantan>,
  <thermalfoundation:material:195>: <thermalfoundation:horse_armor_lead>,
  <thermalfoundation:material:192>: <thermalfoundation:horse_armor_copper>,
  <thermalfoundation:material:227>: <thermalfoundation:horse_armor_bronze>,
  <thermalfoundation:material:198>: <thermalfoundation:horse_armor_platinum>,
  <thermalfoundation:material:225>: <thermalfoundation:horse_armor_electrum>,
  <thermalfoundation:material:224>: <thermalfoundation:horse_armor_steel>,
  <thermalfoundation:material:197>: <thermalfoundation:horse_armor_nickel>,
  <thermalfoundation:material:193>: <thermalfoundation:horse_armor_tin>,
  <thermalfoundation:material:196>: <thermalfoundation:horse_armor_aluminum>,
} as IItemStack[IItemStack] {
  if (isNull(output) || isNull(input)) continue;
  furnace.remove(output, input);
}

// Faster AdvRockArc recipes
scripts.process.alloy([<ore:blockCopper>, <ore:blockNickel>], <thermalfoundation:storage_alloy:4> * 2, 'only: AdvRockArc');
scripts.process.alloy([<ore:blockCopper> * 3, <ore:blockTin>], <thermalfoundation:storage_alloy:3> * 4, 'only: AdvRockArc');
