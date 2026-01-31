#modloaded loottweaker

import crafttweaker.item.IItemStack;
import crafttweaker.util.IRandom;
import loottweaker.LootContext;
import loottweaker.vanilla.loot.Functions;

// Add garanteed grapple wand in some shrines
scripts.lib.loot.addLootToPool('astralsorcery:chest_shrine', 'astralsorcery:chest_shrine', {
  <astralsorcery:itemgrapplewand>: [1, 0, 1, 1],
});

scripts.lib.loot.clearPool('astralsorcery:shooting_star', 'astralsorcery:shooting_star');
scripts.lib.loot.addLootToPool('astralsorcery:shooting_star', 'astralsorcery:shooting_star', {
  <astralsorcery:itemcraftingcomponent:2>: [10, 0, 1, 3],
  <astralsorcery:itemcraftingcomponent:4>: [10, 0, 1, 3],
  <astralsorcery:itemusabledust:1>       : [10, 0, 7, 16],
  <astralsorcery:itemusabledust>         : [10, 0, 7, 16],
  <botania:manaresource:23>              : [10, 0, 1, 3],
  <botania:manaresource:2>               : [10, 0, 1, 3],
  <contenttweaker:blasted_coal>          : [10, 0, 1, 4],
  <enderio:item_material:36>             : [10, 0, 1, 3],
  <enderio:item_material:37>             : [10, 0, 1, 3],
  <fluxnetworks:flux>                    : [10, 0, 7, 16],
  <psi:material>                         : [10, 0, 1, 3],
  <qmd:dust>                             : [10, 0, 5, 8],
  <scalinghealth:heartdust>              : [10, 0, 2, 8],
  <thaumicwonders:primordial_grain>      : [10, 0, 2, 5],
});
loottweaker.LootTweaker.getTable('astralsorcery:shooting_star').getPool('astralsorcery:shooting_star').setRolls(3, 7);

loottweaker.LootTweaker.getTable('astralsorcery:shooting_star').addPool('extraItem', 1.0f, 1.0f, 0.0f, 0.0f).addItemEntry(<thaumcraft:primordial_pearl>, 1, 0,
  [Functions.zenscript(function (input as IItemStack, rng as IRandom, context as LootContext) as IItemStack {
    return input.withDamage(rng.nextInt(2, 7));
  })], []);
scripts.lib.loot.addLootToPool('astralsorcery:shooting_star', 'extraItem', {
  <warptheory:item_cleanser>        : [2, 0, 1, 1],
  <randomthings:spectrekey>         : [1, 0, 1, 1],
  <quark:diamond_heart>             : [2, 0, 1, 1],
  <thaumcraft:causality_collapser>  : [2, 0, 1, 3],
  <thaumicwonders:primal_destroyer>.withTag({infench: [{lvl: 3 as short, id: 6 as short}, {lvl: 2 as short, id: 14 as short}], hunger: 69}): [1, 0, 1, 1],
});
