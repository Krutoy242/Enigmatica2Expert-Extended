#modloaded loottweaker iceandfire

import crafttweaker.item.IItemStack;
import crafttweaker.util.IRandom;
import mods.daomephsta_loot_shared.LootContext;
import loottweaker.vanilla.loot.Conditions;
import loottweaker.vanilla.loot.Functions;

val poolAmphithere = loottweaker.LootTweaker.getTable('iceandfire:amphithere').addPool('blightBonus', 1, 1, 0, 0);
poolAmphithere.addConditions([
  Conditions.zenscript(function(rng as IRandom, context as LootContext) as bool {
    val entity = context.lootedEntity();
    if(isNull(entity)) return false;
    val blight = entity.native.getEntityData().getInteger('ScalingHealth.IsBlight');
    return isNull(blight) ? false : blight == 1;
  })
]);
poolAmphithere.addItemEntry(<scalinghealth:heartcontainer>, 1, 0, [], []);
