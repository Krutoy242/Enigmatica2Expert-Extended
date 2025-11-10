// This script handles entity drops for entities that do not have a loot table.
// You should usse scripts.lib.loot.tweak() whenever loot table exist.
// It uses the EntityLivingDeathDropsEvent to add drops on the fly.

#reloadable
#ignoreBracketErrors

import crafttweaker.entity.IEntityDefinition;
import crafttweaker.item.WeightedItemStack;
import crafttweaker.player.IPlayer;

val eventDrops as int[string][WeightedItemStack][IEntityDefinition] = {
  <entity:emberroot:deers>           : { <betteranimalsplus:antler> % 50: { min: 1, max: 1, playerOnly: 1 }},
  <entity:emberroot:withercat>       : { <extrautils2:ingredients:11>: { min: 1, max: 3 }},
  <entity:betteranimalsplus:zotzpyre>: {
    <harvestcraft:hardenedleatheritem> % 70: { min: 1, max: 3 },
    <harvestcraft:netherwingsitem>         : { min: 1, max: 3, playerOnly: 1 },
  },
  <entity:betteranimalsplus:badger>: {
    <randomthings:fertilizeddirt>: { min: 1, max: 2 },
    <rats:garbage_pile>          : { min: 1, max: 3 },
  },
  <entity:betteranimalsplus:bobbit_worm>  : { <iceandfire:sea_serpent_scales_bronze> % 20: { min: 1, max: 1, playerOnly: 1 }},
  <entity:betteranimalsplus:fox>          : { <mysticalagriculture:chunk:8>: { min: 1, max: 3, playerOnly: 1 }},
  <entity:betteranimalsplus:goose>        : { <bibliocraft:bell> % 5: { min: 1, max: 1, playerOnly: 1 }},
  <entity:betteranimalsplus:horseshoecrab>: { <iceandfire:sea_serpent_scales_bronze> % 50: { min: 1, max: 1 }},
  <entity:betteranimalsplus:songbird>     : { <twilightforest:raven_feather>: { min: 1, max: 3 }},
  <entity:betteranimalsplus:tarantula>    : { <randomthings:ingredient:1> % 50: { min: 1, max: 1, playerOnly: 1 }},
  <entity:biomesoplenty:wasp>             : { <extrautils2:spike_gold> % 50: { min: 1, max: 1, playerOnly: 1 }},
  <entity:botania:pink_wither>            : {
    <enderio:item_alloy_endergy_ingot:4>  : { min: 2, max: 6 },
    <industrialforegoing:pink_slime_ingot>: { min: 3, max: 9 },
  },
  <entity:botania:pixie>                   : { <jaopca:item_dusttinytitanium>: { min: 1, max: 3, playerOnly: 1 }},
  <entity:endreborn:chronologist>          : { <deepmoblearning:living_matter_extraterrestrial>: { min: 1, max: 2, playerOnly: 1 }},
  <entity:openblocks:mini_me>              : { <scalinghealth:crystalshard>: { min: 4, max: 8 }},
  <entity:plustic:blindbandit>             : { <randomthings:ingredient:13>: { min: 10, max: 30 }},
  <entity:plustic:supremeleader>           : { <mechanics:bursting_powder>: { min: 10, max: 30 }},
  <entity:rats:pirat_boat>                 : { <actuallyadditions:block_misc:4>: { min: 1, max: 3, playerOnly: 1 }},
  <entity:rats:plague_cloud>               : { <quark:soul_bead>: { min: 1, max: 3 }},
  <entity:thaumcraft:firebat>              : { <randomthings:flootoken>: { min: 1, max: 3 }},
  <entity:thaumcraft:thaumslime>           : { <thermalexpansion:florb>.withTag({ Fluid: 'liquiddna' }) % 30: { min: 1, max: 1, playerOnly: 1 }},
  <entity:thaumicwonders:corruption_avatar>: { <thaumictinkerer:kamiresource:2>: { min: 13, max: 25 }},
  <entity:twilightforest:stable_ice_core>  : { <mysticalagriculture:ice_essence>: { min: 4, max: 12 }},
  <entity:twilightforest:unstable_ice_core>: { <forestry:crafting_material:5>: { min: 3, max: 9 }},
};

events.register(function (event as crafttweaker.event.EntityLivingDeathDropsEvent) {
  if (isNull(event.entity) || isNull(event.entity.definition)) return;
  val random = event.entity.world.random;

  for entityDef, itemData in eventDrops {
    if (isNull(entityDef)) continue;
    if (entityDef.id != event.entity.definition.id) continue;

    for wStack, dropData in itemData {
      if (isNull(wStack)) continue;
      if (!isNull(dropData.playerOnly) && dropData.playerOnly as int >= 1) {
        if (isNull(event.damageSource) || isNull(event.damageSource.trueSource) || !(event.damageSource.trueSource instanceof IPlayer)) {
          continue;
        }
      }

      if (wStack.chance >= 1.0f || random.nextFloat() < wStack.chance) {
        val min = dropData.min as int;
        val max = dropData.max as int;
        val amount = min + random.nextInt(max - min + 1);
        if (amount > 0) {
          event.addItem(wStack.stack * amount);
        }
      }
    }
  }
});
