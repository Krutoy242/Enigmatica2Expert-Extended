#modloaded immersiveengineering ic2
#ignoreBracketErrors

import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.oredict.IOreDictEntry;

import mods.immersiveengineering.MetalPress;

static anyHammer as IIngredient = <immersiveengineering:tool> | <ic2:forge_hammer>.anyDamage();

// *======= Metal Plates =======*
val platesData = {
  Iron        : <thermalfoundation:material:32>,
  Gold        : <thermalfoundation:material:33>,
  Uranium     : <immersiveengineering:metal:35>,
  ElectrumFlux: <redstonearsenal:material:128>,
  Copper      : <thermalfoundation:material:320>,
  Tin         : <thermalfoundation:material:321>,
  Silver      : <thermalfoundation:material:322>,
  Lead        : <thermalfoundation:material:323>,
  Aluminum    : <thermalfoundation:material:324>,
  Nickel      : <thermalfoundation:material:325>,
  Platinum    : <thermalfoundation:material:326>,
  Iridium     : <thermalfoundation:material:327>,
  Mithril     : <thermalfoundation:material:328>,
  Steel       : <thermalfoundation:material:352>,
  Electrum    : <thermalfoundation:material:353>,
  Invar       : <thermalfoundation:material:354>,
  Bronze      : <thermalfoundation:material:355>,
  Constantan  : <thermalfoundation:material:356>,
  Signalum    : <thermalfoundation:material:357>,
  Lumium      : <thermalfoundation:material:358>,
  Enderium    : <thermalfoundation:material:359>,
  Brass       : <thaumcraft:plate>,
  Thaumium    : <thaumcraft:plate:2>,
  Void        : <thaumcraft:plate:3>,
  Mithrillium : <thaumadditions:mithrillium_plate>,
  Adaminite   : <thaumadditions:adaminite_plate>,
  Mithminite  : <thaumadditions:mithminite_plate>,
  Silicon     : <libvulpes:productplate:3>,
} as IItemStack[string];

for oreName, plate in platesData {
  if(isNull(plate)) continue;
  recipes.remove(plate);
  val ingot = oreDict['ingot' ~ oreName];
  recipes.addShapeless('plate EngHammer ' ~ oreName, plate, [ingot, ingot, anyHammer]);

  if (plate.definition.id.matches('(thermalfoundation|immersiveengineering).*'))
    MetalPress.addRecipe(plate, ingot, <immersiveengineering:mold>, 125, 1);
}

for plate, ores in {
  <immersiveengineering:metal:30>: [<ore:plateCopper>],
  <immersiveengineering:metal:31>: [<ore:plateAluminum>, <ore:plateAluminium>],
  <immersiveengineering:metal:32>: [<ore:plateLead>],
  <immersiveengineering:metal:33>: [<ore:plateSilver>],
  <immersiveengineering:metal:34>: [<ore:plateNickel>],
  <immersiveengineering:metal:36>: [<ore:plateConstantan>],
  <immersiveengineering:metal:37>: [<ore:plateElectrum>],
  <immersiveengineering:metal:38>: [<ore:plateSteel>],
  <immersiveengineering:metal:39>: [<ore:plateIron>],
  <immersiveengineering:metal:40>: [<ore:plateGold>],
} as IOreDictEntry[][IItemStack] {
  mods.immersiveengineering.MetalPress.removeRecipe(plate);
  Purge(plate).ores(ores);
}

recipes.addShapeless('steel_casing_with_tool', <ic2:casing:5> * 2, [<ore:plateSteel>, anyHammer]);

// High-tech recipes for Casings
for input, output in {
  <ore:plateBronze>: <ic2:casing:0>,
  <ore:plateCopper>: <ic2:casing:1>,
  <ore:plateGold>: <ic2:casing:2>,
  <ore:plateIron>: <ic2:casing:3>,
  <ore:plateLead>: <ic2:casing:4>,
  <ore:plateSteel>: <ic2:casing:5>,
  <ore:plateTin>: <ic2:casing:6>,
} as IItemStack[IOreDictEntry] {
  MetalPress.addRecipe(output * 2, input, <immersiveengineering:mold>, 125, 1);

  mods.advancedrocketry.RecipeTweaker.forMachine('RollingMachine').builder()
    .inputOre(input, 16)
    .outputItem(output * 64)
    .power(10000)
    .timeRequired(60)
    .build();
}

// Sticks and Plates from Small Plate Press
val smallPlatePressBuilder = mods.advancedrocketry.RecipeTweaker.forMachine('SmallPlatePresser').builder();
smallPlatePressBuilder.copy().inputOre(<ore:cobblestone>).outputItem(<ore:stickStone>.firstItem * 6).build();
smallPlatePressBuilder.copy().input(<mekanism:plasticblock:15>).outputItem(<mekanism:polyethene:3> * 6).build();
smallPlatePressBuilder.copy().input(<quark:obsidian_pressure_plate>).outputItem(<ic2:plate:6> * 2).build();
