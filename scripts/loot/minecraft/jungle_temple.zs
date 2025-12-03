#modloaded loottweaker
#ignoreBracketErrors

val location = 'minecraft:chests/jungle_temple';

scripts.lib.loot.removePools(location,
  ['Ender IO',
    'endreborn_inject_pool',
    'forestry_arboriculture_items',
    'forestry_apiculture_bees',
    'manuscript',
    'slimecube',
    'rats:contaminated_food',
    'token_fragment',
    'rat_upgrade_basic',
    'botania_inject_pool',
    'moms_spaghetti']
);

scripts.lib.loot.clearPool(location, 'main');
scripts.lib.loot.addLootToPool(location, 'main', {
  <rats:piper_hat>                                                       : [5,   0, 1, 1],
  <rats:rat_flute>                                                       : [5,   0, 1, 1],
  <quark:archaeologist_hat>                                              : [5,   0, 1, 1],
  <botania:thirdeye>                                                     : [1,   0, 1, 1],
  <forge:bucketfilled>.withTag({FluidName: 'liquid_death', Amount: 1000}): [5,   0, 1, 1],
  <animus:kama_bound>                                                    : [1,   0, 1, 1],
  <thaumadditions:cake>                                                  : [5,   0, 1, 1],
  <rats:purifying_liquid>                                                : [5,   0, 1, 1],
  <eyeofdragons:eye_of_icedragon>                                        : [5,   0, 1, 1],
  <eyeofdragons:eye_of_firedragon>                                       : [5,   0, 1, 1],
  <botania:overgrowthseed>                                               : [10,  0, 1, 2],
});
scripts.lib.loot.addLootToPool(location, 'main', scripts.loot.preMadeLoot.baubles);
scripts.lib.loot.addLootToPool(location, 'main', scripts.loot.preMadeLoot.ancientTomes);
loottweaker.LootTweaker.getTable(location).getPool('main').setRolls(1, 2);

loottweaker.LootTweaker.getTable(location).addPool('pool1', 1.0f, 2.0f, 0.0f, 0.0f);
scripts.lib.loot.addLootToPool(location, 'pool1', {
  <minecraft:ender_eye>                 : [10,  0, 1, 2],
  <iceandfire:dragonbone>               : [50,  0, 1, 2],
  <iceandfire:manuscript>               : [50,  0, 2, 3],
  <iceandfire:amphithere_feather>       : [50,  0, 2, 5],
  <iceandfire:myrmex_jungle_chitin>     : [20,  0, 2, 5],
  <astralsorcery:itemconstellationpaper>: [30,  0, 1, 1],
  <randomthings:ingredient:1>           : [5,   0, 1, 1],
  <randomthings:beans:2>                : [5,   0, 1, 1],
  <scalinghealth:heartcontainer>        : [5,   0, 1, 1],
});
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.badFood);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.magicConsumables);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.thaumcraftSpells);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.ancientTomes);

scripts.lib.loot.addSpecialTool(location, <tconstruct:arrow>, ['reed', 'sunnarium', 'amphithere_feather'], '§eProvidence Echoes');
