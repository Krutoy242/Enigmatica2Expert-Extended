#modloaded tconevo

import crafttweaker.item.IItemStack;
import crafttweaker.liquid.ILiquidStack;

for item in loadedMods['tconevo'].items {
  for ore in item.ores {
    if (ore.name.startsWith('gear')) recipes.remove(item);
  }
}

// [Ghostwood Shard]*8 from [Dreadwood Log]
craft.make(<tconstruct:shard>.withTag({ Material: 'ghostwood' }) * 16, ['##'], {
  '#': <iceandfire:dreadwood_log>, // Dreadwood Log
});

// [Ghostwood Shard]*4 from [Dreadwood Planks]
craft.make(<tconstruct:shard>.withTag({ Material: 'ghostwood' }) * 8, ['# ', ' #'], {
  '#': <iceandfire:dreadwood_planks>, // Dreadwood Planks
});

// [Darkwood Shard]*8 from [Lightwood Wood]
craft.make(<tconstruct:shard>.withTag({ Material: 'darkwood' }) * 16, ['##'], {
  '#': <advancedrocketry:alienwood>, // Lightwood Wood
});

// [Darkwood Shard]*4 from [Lightwood planks]
craft.make(<tconstruct:shard>.withTag({ Material: 'darkwood' }) * 8, ['# ', ' #'], {
  '#': <advancedrocketry:planks>, // Lightwood planks
});

mods.tconstruct.Casting.addTableRecipe(
  <tconevo:metal:30>, // [Sentient Ingot]
  <tconevo:material>, // Coalescence Matrix
  <liquid:raw_will>, // Demonic Will
  1000, true);

function recast(block as IItemStack, fluid as ILiquidStack) as void {
  mods.tconstruct.Melting.addRecipe(fluid * 1296, block);
mods.tconstruct.Casting.addBasinRecipe(block, null, fluid, 1296);
}

// Add missed block <=> Molten recipes
recast(<psi:psi_decorative:1>, <liquid:psimetal>);
recast(<botania:storage:0>, <liquid:manasteel>);
recast(<botania:storage:1>, <liquid:terrasteel>);
recast(<botania:storage:2>, <liquid:elementium>);

// Harder recipe to match tier
recipes.removeByRecipeName('tconevo:pink_slimy_mud');
recipes.addShapeless('pink_slimy_mud', <tconevo:earth_material_block>, [
  <ore:slimeballPink>, <ore:slimeballPink>, <ore:slimeballPink>, <ore:slimeballPink>, <rftoolsdim:fake_gravel>, <tconstruct:soil:5>,
]);

// "Vegan" run alt
scripts.process.melt(<tconevo:material:1>, <fluid:if.pink_slime> * 1000);
