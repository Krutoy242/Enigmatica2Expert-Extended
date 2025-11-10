#reloadable
#ignoreBracketErrors
#modloaded roidtweaker

import crafttweaker.player.IPlayer;
import crafttweaker.item.IItemStack;

val chopRecipes = {
  'emberroot:rootsonespriteboss': <mysticalagriculture:crafting:3>,
  'twilightforest:castle_guardian': <mekanism:saltblock>,
} as IItemStack[string];

events.onEntityLivingDamage(function (e as crafttweaker.event.EntityLivingDamageEvent) {
  val mob = e.entity;
  if (
    isNull(mob)
    || isNull(mob.world)
    || mob.world.remote
    || e.amount <= 0
    || isNull(e.damageSource)
    || isNull(e.damageSource.trueSource)
    || isNull(mob.definition)
  ) return;

  // Convert player
  val _player = e.damageSource.trueSource;
  if (!(_player instanceof IPlayer)) return;
  val player as IPlayer = _player;

  val result = chopRecipes[mob.definition.id];
  if (isNull(result)) return;

  val amount = e.amount / 5.0f;
  if (amount < 1.0f && mob.world.getRandom().nextDouble() > amount) return;
  utils.geyser(
    mob.world, result,
    mob.position.x, mob.position.y, mob.position.z,
    max(1, amount as int),
    mob.motionX, mob.motionY, mob.motionZ, 2
  );

  player.sendPlaySoundPacket('minecraft:entity.sheep.shear', 'ambient', mob.position, 1.0f, 1.0f);
});
