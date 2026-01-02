#modloaded loottweaker
#ignoreBracketErrors

val location = 'minecraft:chests/simple_dungeon';

scripts.lib.loot.removePools(location,
  ['ic2',
    'openmods_inject_pool',
    'manuscript',
    'lavacharm',
    'summoningpendulum',
    'slimecube',
    'spectrecoil_number',
    'rats:contaminated_food',
    'token_fragment',
    'Ender IO',
    'rat_upgrade_basic',
    'botania_inject_pool',
    'pool2']
);

scripts.lib.loot.clearPool(location, 'main');
scripts.lib.loot.addLootToPool(location, 'main', {
  <botania:avatar>                                                                                                 : [10, 0, 1, 1],
  <botania:manabomb>                                                                                               : [5, 0, 1, 1],
  <botania:teruterubozu>                                                                                           : [20, 0, 1, 1],
  <cyclicmagic:soulstone>                                                                                          : [20, 0, 1, 1],
  <ic2:crystal_memory>.withTag({Pattern: {id: 'astralsorcery:itemcelestialcrystal', Count: 1, Damage: 0 as short}}): [2, 0, 1, 1],
  <ic2:crystal_memory>.withTag({Pattern: {id: 'extendedcrafting:material', Count: 1, Damage: 140 as short}})       : [2, 0, 1, 1],
  <ic2:crystal_memory>.withTag({Pattern: {id: 'extrautils2:ingredients', Count: 1, Damage: 10 as short}})          : [2, 0, 1, 1],
  <ic2:crystal_memory>.withTag({Pattern: {id: 'ic2:misc_resource', Count: 1, Damage: 1 as short}})                 : [2, 0, 1, 1],
  <ic2:crystal_memory>.withTag({Pattern: {id: 'industrialforegoing:pink_slime', Count: 1, Damage: 0 as short}})    : [2, 0, 1, 1],
  <ic2:crystal_memory>.withTag({Pattern: {id: 'rftools:shape_card', Count: 1 as byte, Damage: 0 as short}})        : [2, 0, 1, 1],
  <ic2:crystal_memory>.withTag({Pattern: {id: 'teslacorelib:base_addon', Count: 1 as byte, Damage: 0 as short}})   : [2, 0, 1, 1],
  <thaumcraft:bellows>                                                                                             : [20, 0, 1, 1],
  <thaumcraft:curio:6>                                                                                             : [5, 0, 1, 1],
  <thaumcraft:vis_battery>                                                                                         : [10, 0, 1, 1],
  <thaumicaugmentation:vis_regenerator>                                                                            : [10, 0, 1, 1],

  <botania:brewvial>.withTag({brewKey: "strength"}) : [5, 0, 1, 1],
  <botania:brewvial>.withTag({brewKey: "soulCross"}): [5, 0, 1, 1],
});
scripts.lib.loot.addLootToPool(location, 'main', scripts.loot.preMadeLoot.sigils);
scripts.lib.loot.addLootToPool(location, 'main', scripts.loot.preMadeLoot.ancientTomes);
loottweaker.LootTweaker.getTable(location).getPool('main').setRolls(1, 2);

scripts.lib.loot.clearPool(location, 'pool1');
scripts.lib.loot.addLootToPool(location, 'pool1', {
  <betteranimalsplus:bear_skin_black>                                                                              : [5, 0, 1, 3],
  <betteranimalsplus:bear_skin_brown>                                                                              : [5, 0, 1, 3],
  <betteranimalsplus:bear_skin_kermode>                                                                            : [5, 0, 1, 3],
  <betteranimalsplus:wolf_pelt_arctic>                                                                             : [5, 0, 1, 3],
  <betteranimalsplus:wolf_pelt_black>                                                                              : [5, 0, 1, 3],
  <betteranimalsplus:wolf_pelt_brown>                                                                              : [5, 0, 1, 3],
  <betteranimalsplus:wolf_pelt_red>                                                                                : [5, 0, 1, 3],
  <betteranimalsplus:wolf_pelt_snowy>                                                                              : [5, 0, 1, 3],
  <betteranimalsplus:wolf_pelt_timber>                                                                             : [5, 0, 1, 3],
  <enderio:item_material:56>                                                                                       : [5, 0, 1, 1],
  <extrautils2:suncrystal:250>                                                                                     : [20, 0, 1, 1],
  <iceandfire:siren_tear>                                                                                          : [3, 0, 1, 1],
  <randomthings:ingredient:11>                                                                                     : [5, 0, 1, 1],
  <randomthings:spectresapling>                                                                                    : [10, 0, 1, 2],
  <rustic:fluid_bottle>.withTag({Fluid: {FluidName: 'ale', Amount: 1000, Tag: {Quality: 1.00 as float}}})          : [5, 0, 1, 1],
  <rustic:fluid_bottle>.withTag({Fluid: {FluidName: 'ambrosia', Amount: 1000, Tag: {Quality: 1.00 as float}}})     : [5, 0, 1, 1],
  <rustic:fluid_bottle>.withTag({Fluid: {FluidName: 'cider', Amount: 1000, Tag: {Quality: 1.00 as float}}})        : [5, 0, 1, 1],
  <rustic:fluid_bottle>.withTag({Fluid: {FluidName: 'ironwine', Amount: 1000, Tag: {Quality: 1.00 as float}}})     : [5, 0, 1, 1],
  <rustic:fluid_bottle>.withTag({Fluid: {FluidName: 'mead', Amount: 1000, Tag: {Quality: 1.00 as float}}})         : [5, 0, 1, 1],
  <rustic:fluid_bottle>.withTag({Fluid: {FluidName: 'wildberrywine', Amount: 1000, Tag: {Quality: 1.00 as float}}}): [5, 0, 1, 1],
  <rustic:fluid_bottle>.withTag({Fluid: {FluidName: 'wine', Amount: 1000, Tag: {Quality: 1.00 as float}}})         : [5, 0, 1, 1],
  <tconstruct:materials:18>                                                                                        : [50, 0, 2, 6],
  <thaumadditions:dawn_totem>                                                                                      : [5, 0, 1, 1],
  <thaumadditions:jar_eldritch>                                                                                    : [10, 0, 1, 1],
  <thaumadditions:twilight_totem>                                                                                  : [5, 0, 1, 1],
});
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.badFood);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.goodFood);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.magicConsumables);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.techComponents);

scripts.lib.loot.addSpecialTool(location, <tconstruct:cleaver>, ['xu_magical_wood', 'terrasteel', 'silver', 'bloodbone'], 'Broken Hero sword');
scripts.lib.loot.addRandomCapacitor(location, 0.15f);
