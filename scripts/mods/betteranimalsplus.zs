#modloaded betteranimalsplus

<betteranimalsplus:pheasant_egg>.maxStackSize = 64;
<betteranimalsplus:turkey_egg>.maxStackSize = 64;
<betteranimalsplus:goose_egg>.maxStackSize = 64;
<betteranimalsplus:golden_goose_egg>.maxStackSize = 64;

// --------------------------------
// Hand Of Fate usage description
// --------------------------------
val handOfFatelocalized = mods.zenutils.I18n.format(scripts.lib.tooltip.desc.local(<betteranimalsplus:handoffate>),
  <minecraft:flint_and_steel>.displayName,
  <minecraft:nether_wart>.displayName,
  <betteranimalsplus:antler>.displayName,
  <betteranimalsplus:venisonraw>.displayName
);
<betteranimalsplus:handoffate>.addTooltip(handOfFatelocalized);
mods.jei.JEI.addDescription(<betteranimalsplus:handoffate>, handOfFatelocalized);

scripts.jei.crafting_hints.addInsOutCatl(
  [
    <minecraft:flint_and_steel>,
    <minecraft:nether_wart>,
    <betteranimalsplus:antler>,
    <betteranimalsplus:venisonraw>,
  ],
  <entity:betteranimalsplus:hirschgeist>.asStack(),
  <betteranimalsplus:handoffate>
);
// --------------------------------

scripts.lib.loot.tweak('betteranimalsplus:wolf_timber', 'wolf_timber', 'betteranimalsplus:wolf_pelt_timber', null, [<betteranimalsplus:wolf_pelt_timber>], [1, 3]);
scripts.lib.loot.tweak('twilightforest:entities/deer', 'main', null, null, [<betteranimalsplus:antler> % 50], [1, 1], true);

<ore:pelt>.addItems([
  <betteranimalsplus:bear_skin_black>,
  <betteranimalsplus:bear_skin_brown>,
  <betteranimalsplus:bear_skin_kermode>,
  <betteranimalsplus:wolf_pelt_arctic>,
  <betteranimalsplus:wolf_pelt_black>,
  <betteranimalsplus:wolf_pelt_brown>,
  <betteranimalsplus:wolf_pelt_red>,
  <betteranimalsplus:wolf_pelt_snowy>,
  <betteranimalsplus:wolf_pelt_timber>,
]);

// Tallow
scripts.process.squeeze([<betteranimalsplus:blubber>], <liquid:lubricant> * 50, 'except: CrushingTub Squeezer', null);

// Blubber
mods.thaumcraft.Crucible.registerRecipe('Tallow from blubber', 'HEDGEALCHEMY@1', <thaumcraft:tallow> * 8, <betteranimalsplus:blubber>, Aspects('4🔥'));

// [Music Disc] from [Music Disc][+1]
craft.reshapeless(<betteranimalsplus:record_crab_rave>, 'Cr', {
  'C': <ore:foodCrabraw>, // Raw Crab
  'r': <ore:record>, // Music Disc
});

// Do not unify Venison so we could summon Hirschgeist
// scripts.lib.loot.tweak("betteranimalsplus:deer","deer-venison","betteranimalsplus:venisonraw", <betteranimalsplus:venisonraw>, [<harvestcraft:venisonrawitem>], [1,3]);
// scripts.lib.loot.tweak("betteranimalsplus:reindeer","reindeer","betteranimalsplus:venisonraw", <betteranimalsplus:venisonraw>, [<harvestcraft:venisonrawitem>], [1,3]);
// scripts.lib.loot.tweak("betteranimalsplus:moose","moose-venison","betteranimalsplus:venisonraw", <betteranimalsplus:venisonraw>, [<harvestcraft:venisonrawitem>], [2,5]);
recipes.addShapeless('Venison conversion 1', <betteranimalsplus:venisonraw>, [<harvestcraft:venisonrawitem>]);
recipes.addShapeless('Venison conversion 2', <harvestcraft:venisonrawitem>, [<betteranimalsplus:venisonraw>]);

scripts.lib.loot.tweak('betteranimalsplus:nautilus', 'nautilus', 'minecraft:fish', null, [<harvestcraft:oysterrawitem>], [1, 3]);
scripts.lib.loot.tweak('betteranimalsplus:crab', 'crab', 'betteranimalsplus:crab_meat_raw', <betteranimalsplus:crab_meat_raw>, [<harvestcraft:crabrawitem>], [1, 3]);
scripts.lib.loot.tweak('betteranimalsplus:hirschgeist', 'hirschgeist', null, null, [<randomthings:ingredient:2>, <mysticalagriculture:crafting:2>], [16, 64], false, 200);

// [Raw Turkey] from [Raw Turkey]
craft.make(<betteranimalsplus:turkey_raw>, ['pretty',
  'A A A',
  'A A A',
  'A A A'], {
  'A': <ore:listAllturkeyraw>, // Raw Turkey
});

// Exploration alternative to easy steel
scripts.process.melt(<betteranimalsplus:trillium>, <fluid:coal> * 100);

// Bone source
scripts.process.crush(<betteranimalsplus:antler>, <minecraft:bone> * 20, 'only: IECrusher');

<ore:foodCheese>.remove(<betteranimalsplus:cheese>);
<ore:listAllmeatraw>.add(<betteranimalsplus:turkey_leg_raw>);
