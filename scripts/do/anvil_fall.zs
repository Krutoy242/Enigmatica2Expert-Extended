#modloaded requious advancedrocketry
#reloadable

import crafttweaker.entity.IEntityDefinition;
import crafttweaker.event.EntityLivingDamageEvent;

static entityMap as int[IEntityDefinition] = {
  <entity:minecraft:wolf>               : 0,
  <entity:minecraft:chicken>            : 1,
  // cow                                : 2, // Cow cant be crafted if Cooking For Blockheads installed. Event just dont happens
  <entity:minecraft:creeper>            : 3,
  <entity:minecraft:skeleton>           : 4,
  <entity:minecraft:zombie_pigman>      : 5,
  <entity:minecraft:bat>                : 6,
  <entity:minecraft:zombie>             : 7,
  <entity:minecraft:witch>              : 8,
  <entity:minecraft:villager>           : 9,
  <entity:minecraft:ocelot>             : 10,
  <entity:minecraft:sheep>              : 11,
  <entity:minecraft:blaze>              : 12,
  <entity:minecraft:silverfish>         : 13,
  <entity:minecraft:spider>             : 14,
  <entity:minecraft:cave_spider>        : 15,
  <entity:minecraft:slime>              : 16,
  <entity:minecraft:ghast>              : 17,
  <entity:minecraft:enderman>           : 18,
  <entity:minecraft:magma_cube>         : 19,
  <entity:minecraft:squid>              : 20,
  <entity:minecraft:mooshroom>          : 21,
  <entity:minecraft:villager_golem>     : 22,
  <entity:minecraft:snowman>            : 23,
  <entity:minecraft:pig>                : 24,
  <entity:minecraft:endermite>          : 25,
  <entity:minecraft:guardian>           : 26,
  <entity:minecraft:rabbit>             : 27,
  <entity:minecraft:polar_bear>         : 28,
  <entity:minecraft:shulker>            : 29,
  <entity:minecraft:horse>              : 30,
  <entity:minecraft:skeleton_horse>     : 31,
  <entity:minecraft:zombie_horse>       : 32,
  <entity:minecraft:donkey>             : 33,
  <entity:minecraft:mule>               : 34,
  <entity:minecraft:llama>              : 35,
  <entity:minecraft:elder_guardian>     : 36,
  <entity:minecraft:wither_skeleton>    : 37,
  <entity:minecraft:stray>              : 38,
  <entity:minecraft:husk>               : 39,
  <entity:minecraft:zombie_villager>    : 40,
  <entity:minecraft:evocation_illager>  : 41,
  <entity:minecraft:vex>                : 42,
  <entity:minecraft:vindication_illager>: 43,
} as int[IEntityDefinition]$orderly;

// Run only on initializing game
if(scriptStatus() == 0) {
  for entityDef, num in entityMap {
    scripts.jei.crafting_hints.addInsOutCatl(
      [entityDef.asIngr(), null, null, <minecraft:anvil>, <advancedrocketry:basalt>],
      <openblocks:trophy:2>.withTag({ entity_id: entityDef.id })
    );
  }
}

events.register(function (e as EntityLivingDamageEvent) {
  val mob = e.entity;
  if (
    isNull(mob)
    || isNull(mob.world)
    || mob.world.remote
    || isNull(mob.definition)
    || isNull(e.damageSource)
    || isNull(e.damageSource.damageType)
    || e.damageSource.damageType != 'anvil'
    || !mob.definition.id.startsWith('minecraft:')
  ) return;

  val blockUnderPos = mob.position.getOffset(down, 1);
  val blockState = mob.world.getBlockState(blockUnderPos);
  if (isNull(blockState) || blockState != <blockstate:advancedrocketry:basalt>) return;

  val trophyIndex = entityMap[mob.definition];
  if (isNull(trophyIndex)) return;

  mob.world.removeEntity(mob);
  mob.world.destroyBlock(blockUnderPos, false);
  mob.world.setBlockState(<blockstate:openblocks:trophy>, {
    entity_id  : mob.definition.id,
    trophyIndex: trophyIndex as int,
  }, blockUnderPos);
});
