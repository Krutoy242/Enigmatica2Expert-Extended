#modloaded scalinghealth

import crafttweaker.item.IIngredient;

Purge(<scalinghealth:difficultychanger>);
Purge(<scalinghealth:difficultychanger:1>);

// Heart dust
val HD = <scalinghealth:heartdust>;
val HS = <scalinghealth:crystalshard>;
// [Heart Dust] from [Pestle and Mortar][+1]
craft.reshapeless(HD, 'A***', {
  'A': <ore:pestleAndMortar>,        // Pestle and Mortar
  '*': HS, // Heart Crystal Shard
});
mods.rats.recipes.addGemcutterRatRecipe(HS, HD);
scripts.process.crush(HS * 2, HD, 'only: eu2Crusher', [HD], [0.2f]);
scripts.process.crush(HS    , HD, 'only: SagMill Pulverizer', [HD, HD, HD], [0.8f, 0.4f, 0.2f]);

// Peaceful alt
mods.inworldcrafting.ExplosionCrafting.explodeBlockRecipe(<scalinghealth:crystalore>, <minecraft:redstone_ore>, 1);
