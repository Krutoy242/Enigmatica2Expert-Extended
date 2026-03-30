#priority 950
#modloaded forestry requious

import crafttweaker.item.IItemStack;
import mods.requious.AssemblyRecipe;

// Hint about Caterpillars, Butterflies and Serums
scripts.jei.crafting_hints.addInsOutCatl([<forestry:butterfly_ge:*>], <forestry:caterpillar_ge>);
scripts.jei.crafting_hints.addInsOutCatl([<forestry:butterfly_ge:*>], <forestry:serum_ge>, <forestry:escritoire>);
scripts.jei.crafting_hints.addInsOutCatl([<forestry:caterpillar_ge:*>], <forestry:serum_ge>, <forestry:escritoire>);
scripts.jei.crafting_hints.addInsOutCatl([<forestry:cocoon_ge:*>], <forestry:serum_ge>, <forestry:escritoire>);

scripts.jei.crafting_hints.addInsOutCatl([
  <gendustry:gene_sample>.withTag({species: "rootTrees", allele: "forestry.fireproofTrue", chromosome: 9}),
  <ore:logNonfireproof>,
  ], <ore:logFireproof>.firstItem);

// -----------------------------------------------------------------------
// -----------------------------------------------------------------------
val x = <assembly:forestry_farm>;
x.setJEIItemSlot(0, 0, 'item_in');
x.setJEIDurationSlot(1, 0, 'duration', scripts.jei.requious.getVisSlots(11, 1));
for i in 0 .. 11 {
  x.addJEICatalyst(<forestry:ffarm:3>.withTag({ FarmBlock: i }));
}

static fertilizers as IItemStack[] = [
/* Inject_js(
(()=>{
let t = config('config/forestry/farm.cfg').fertilizers.items
  .map(l=>l.split(';'))
let max =       Math.max(...t.map(l=>l[1]))
let qnt = max / Math.min(...t.map(l=>l[1])) + 1
return t
  .sort((a,b)=>b[1]-a[1])
  .map(([id,value])=>`  <${id}> * ${
    Math.max(1, qnt * max / value | 0)
  },`)
  .join('\n')
})()
) */
  <thermalfoundation:fertilizer:2> * 37,
  <mysticalagriculture:mystical_fertilizer> * 55,
  <mysticalagriculture:fertilized_essence> * 83,
  <thermalfoundation:fertilizer:1> * 166,
  <industrialforegoing:fertilizer> * 277,
  <botania:fertilizer> * 370,
  <forestry:fertilizer_compound> * 666,
  <actuallyadditions:item_fertilizer> * 1332,
  <ic2:crop_res:2> * 1332,
  <thermalfoundation:fertilizer> * 1332,
/**/
];

for input in fertilizers {
  x.addJEIRecipe(AssemblyRecipe.create(function (container) {})
    .requireItem('item_in', input)
  );
}
