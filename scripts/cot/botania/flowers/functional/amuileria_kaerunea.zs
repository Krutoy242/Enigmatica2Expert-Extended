/*
Amuileria kaerunea (Aquilegia caerulea + Kaminari[thunder]) - crafting with lightning
*/

#loader contenttweaker

import crafttweaker.item.IItemStack;
import mods.contenttweaker.VanillaFactory;

static recipesLigthningFlower as IItemStack[string] = {
  'item.appliedenergistics2.material.certus_quartz_crystal'         : <item:appliedenergistics2:material:1>,
  'item.appliedenergistics2.material.purified_certus_quartz_crystal': <item:appliedenergistics2:material:1>,
  'item.appliedenergistics2.material.certus_quartz_crystal_charged' : <item:appliedenergistics2:material:1>,
} as IItemStack[string];

static manaCostPerLightning as int = 1000;

val amuileria_kaerunea = VanillaFactory.createSubTileFunctional('amuileria_kaerunea', 0xFFFF);
amuileria_kaerunea.maxMana = 5000;
amuileria_kaerunea.range = 1;
amuileria_kaerunea.register();
