/*
Jikanacea (Echinacea + jikan[time]) - extends durration of time in a bottle effect
*/
#loader contenttweaker

import crafttweaker.entity.IEntity;
import crafttweaker.util.Math;
import crafttweaker.world.IBlockPos;
import crafttweaker.world.IWorld;
import mods.contenttweaker.Color;
import mods.contenttweaker.VanillaFactory;
import mods.randomtweaker.cote.BlockAdded;
import mods.randomtweaker.cote.ISubTileEntity;
import mods.randomtweaker.cote.ISubTileEntityFunctional;
import mods.randomtweaker.cote.SubTileEntityInGame;

static manaCostMultipier as int = 300;

var jikanacea = VanillaFactory.createSubTileFunctional("jikanacea", 0x640064);
jikanacea.maxMana = 9600;
jikanacea.range = 8;
jikanacea.onUpdate = function(subtile, world, pos) {
    if(world.isRemote()
    || world.time%300!=0) return;

    findAndExtendEntitiesForMana(world, pos, subtile);
    return;
};
jikanacea.register();

function findAndExtendEntitiesForMana(world as IWorld, pos as IBlockPos, subtile as SubTileEntityInGame) as void{
    for entity in world.getEntities() {
        if(isNull(entity)
        || Math.abs(entity.x - pos.x - 0.5) > 8.2
        || Math.abs(entity.y - pos.y) > 8.2
        || Math.abs(entity.z - pos.z - 0.5) > 8.2
        || isNull(entity.definition)
        || entity.definition.name!='timeAccelerator'
        || entity.nbt.remainingTime > 300) continue;
        val cost = entity.nbt.timeRate * manaCostMultipier;
        if(subtile.getMana() >= cost) updateTimeAndTakeMana(subtile, entity, cost);
        if(subtile.getMana() < manaCostMultipier) return;
    }
}

function updateTimeAndTakeMana(subtile as SubTileEntityInGame, entity as IEntity, cost as int) as void{
    subtile.consumeMana(cost);
    entity.updateNBT({remainingTime: 500});
}
