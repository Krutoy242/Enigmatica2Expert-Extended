/*
Jikanacea (Echinacea + jikan[time]) - extends durration of time in a bottle effect
*/

#modloaded botania
#loader contenttweaker

import crafttweaker.entity.IEntity;
import crafttweaker.util.Math;
import crafttweaker.world.IBlockPos;
import crafttweaker.world.IWorld;
import mods.contenttweaker.VanillaFactory;
import mods.randomtweaker.cote.SubTileEntityInGame;

static manaCostMultipier as int = 2000;

val jikanacea = VanillaFactory.createSubTileFunctional('jikanacea', 0x640064);
jikanacea.maxMana = manaCostMultipier * 64;
jikanacea.range = 8;
jikanacea.onUpdate = function (subtile, world, pos) {
  if (world.remote
    || world.worldInfo.worldTotalTime  % 300 != 0) {
    return;
  }

  findAndExtendEntitiesForMana(world, pos, subtile);
};
jikanacea.register();

function findAndExtendEntitiesForMana(world as IWorld, pos as IBlockPos, subtile as SubTileEntityInGame) as void {
  for entity in world.getEntities() {
    if (isNull(entity)
      || Math.abs(entity.x - pos.x - 0.5) > 8.2
      || Math.abs(entity.y - pos.y) > 8.2
      || Math.abs(entity.z - pos.z - 0.5) > 8.2
      || isNull(entity.definition)
      || entity.definition.name != 'timeAccelerator'
      || entity.nbt.remainingTime > 300) {
      continue;
    }
    val cost = entity.nbt.timeRate * manaCostMultipier;
    if (subtile.getMana() >= cost) updateTimeAndTakeMana(subtile, entity, cost);
    if (subtile.getMana() < manaCostMultipier) return;
  }
}

function updateTimeAndTakeMana(subtile as SubTileEntityInGame, entity as IEntity, cost as int) as void {
  subtile.consumeMana(cost);
  entity.updateNBT({remainingTime: 500});
}
