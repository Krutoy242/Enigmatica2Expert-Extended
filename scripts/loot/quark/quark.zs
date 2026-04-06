#modloaded loottweaker quark
#ignoreBracketErrors

import loottweaker.LootTweaker;

scripts.lib.loot.addLootToPool('quark:chests/pirate_chest', 'quark:pirate_ship', {
  <cyclicmagic:dynamite_safe>  : [30, 0, 5, 64],
  <cyclicmagic:dynamite_mining>: [10, 0, 5, 64],
  <cyclicmagic:ender_tnt_6>    : [20, 0, 5, 64],
  <ic2:dynamite>               : [60, 0, 5, 64],
  <ic2:dynamite_sticky>        : [50, 0, 5, 64],
  <quark:arrow_explosive>      : [80, 0, 5, 64],
  <tconstruct:throwball:1>     : [5,  3, 5, 64],
  <mekanism:obsidiantnt>       : [5,  3, 5, 64],
});

scripts.lib.loot.tweak('quark:entities/crab', 'legs', 'quark:crab_leg', null, [<harvestcraft:crabrawitem>], [1,3], false, 1, true);

//scripts.lib.loot.removePools('quark:entities/frog', ['main']);
//LootTweaker.getTable('quark:entities/frog').addPool("meat", 1, 1, 0, 0);
scripts.lib.loot.tweak('quark:entities/frog', 'main', null, null, [<quark:frog_leg>], [1,2], false, 1, true);
