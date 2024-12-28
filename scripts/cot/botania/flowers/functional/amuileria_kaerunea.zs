/*
Amuileria kaerunea (Aquilegia caerulea + Kaminari[thunder]) - crafting with lightning
*/

#loader contenttweaker

import crafttweaker.damage.IDamageSource;
import crafttweaker.data.IData;
import crafttweaker.item.IItemStack;
import crafttweaker.util.Math;
import crafttweaker.world.IBlockPos;
import crafttweaker.world.IWorld;
import mods.contenttweaker.Color;
import mods.contenttweaker.VanillaFactory;
import mods.randomtweaker.cote.BlockAdded;
import mods.randomtweaker.cote.ISubTileEntity;
import mods.randomtweaker.cote.ISubTileEntityFunctional;
import mods.randomtweaker.cote.SubTileEntityInGame;

static recipesLigthningFlower as IItemStack[string] = {
'item.appliedenergistics2.material.certus_quartz_crystal': <item:appliedenergistics2:material:1>,
'item.appliedenergistics2.material.purified_certus_quartz_crystal': <item:appliedenergistics2:material:1>,
'item.appliedenergistics2.material.certus_quartz_crystal_charged': <item:appliedenergistics2:material:1>,
} as IItemStack[string];

static manaCostPerLightning as int = 1000;

var amuileria_kaerunea = VanillaFactory.createSubTileFunctional("amuileria_kaerunea", 0xffff);
amuileria_kaerunea.maxMana = 5000;
amuileria_kaerunea.range = 1;
amuileria_kaerunea.register();
