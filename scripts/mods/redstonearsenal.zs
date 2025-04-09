#modloaded redstonearsenal

recipes.remove(<redstonearsenal:tool.bow_flux>);
recipes.addShapeless('Fluxed Box',
  <redstonearsenal:tool.bow_flux>,
  [
    <enderio:item_dark_steel_bow>.anyDamage(),
    <extrautils2:compoundbow>.anyDamage(),
    <enderio:item_end_steel_bow>.anyDamage(),
    <mekanism:electricbow>.anyDamage(),
    <ore:blockElectrumFlux>,
    <botania:crystalbow>.anyDamage(),
    <bloodmagic:sentient_bow>.anyDamage(),
    <thaumcraft:turret:*>,
    <twilightforest:triple_bow:*> | <twilightforest:seeker_bow:*> | <twilightforest:ice_bow:*>,
  ]);

recipes.remove(<redstonearsenal:material:192>);
mods.rats.recipes.addGemcutterRatRecipe(<enderio:block_reinforced_obsidian>, <redstonearsenal:material:192>);
scripts.processWork.workEx('MetalPress', null, [<enderio:block_reinforced_obsidian>], null, [<redstonearsenal:material:192>], null, null, null, { mold: 'rod' });
scripts.processWork.workEx('AdvRockLathe', null, [<enderio:block_reinforced_obsidian>], null, [<redstonearsenal:material:192> * 4], null, null, null);
