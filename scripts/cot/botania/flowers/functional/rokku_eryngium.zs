/*
Rokku Eryngium (Eryngium + Rokku) - flower that cuts astral rock crystals (actually automates grindstone)
*/

#modloaded botania zenutils
#loader contenttweaker

import crafttweaker.data.IData;
import crafttweaker.entity.IEntityItem;
import crafttweaker.item.IItemStack;
import crafttweaker.util.Math;
import crafttweaker.world.IBlockPos;
import crafttweaker.world.IWorld;
import mods.contenttweaker.VanillaFactory;
import mods.randomtweaker.cote.SubTileEntityInGame;
import mods.zenutils.DataUpdateOperation.OVERWRITE;
import native.net.minecraft.util.EnumParticleTypes;
import native.net.minecraft.world.WorldServer;

static validCrystalNames as IItemStack[string] = {
  'item.itemcelestialcrystal' : <item:astralsorcery:itemcelestialcrystal>,
  'item.itemrockcrystalsimple': <item:astralsorcery:itemrockcrystalsimple>,
} as IItemStack[string];

static manaCostPerCut as int = 1000;

val rokku_eryngium = VanillaFactory.createSubTileFunctional('rokku_eryngium', 0xFFFFFF);
rokku_eryngium.hasMini = false;
rokku_eryngium.maxMana = 1000;
rokku_eryngium.range = 1;
rokku_eryngium.onUpdate = function (subtile, world, pos) {
  if (world.remote
    || world.worldInfo.worldTotalTime % 20 != 5) {
    return;
  }
  if (isNull(subtile.data)
    || isNull(subtile.data.crystalProperties)
    || subtile.data.crystalProperties.collectiveCapability == -1) {
    pickCrystal(world, pos, subtile);
  }
  else {
    if (subtile.getMana() < manaCostPerCut) return;
    subtile.consumeMana(manaCostPerCut);
    workOnCrystal(world, pos, subtile);
  }
};
rokku_eryngium.onBlockHarvested = function (world, pos, state, player) {
  if (world.remote) return;
  val subtile = world.getSubTileEntityInGame(pos);
  if (!isNull(subtile.data)
    && !isNull(subtile.data.crystalProperties)
    && subtile.data.crystalProperties.collectiveCapability != -1) {
    dropCrystal(world, pos, subtile);
  }
};
rokku_eryngium.register();

function pickCrystal(world as IWorld, pos as IBlockPos, subtile as SubTileEntityInGame) as void {
  val crystal = findCrystal(world, pos);
  if (isNull(crystal)) return;
  crystal.setDead();
  subtile.setCustomData(crystal.item.tag.astralsorcery + {name: crystal.item.name, status: 'work'});
  crystal.setDead();
  scripts.lib.sound.play('minecraft:entity.item.pickup', pos, world);
}

function findCrystal(world as IWorld, pos as IBlockPos) as IEntityItem {
  val items = world.getEntityItems();
  for item in items {
    if (isNull(item)
      || isNull(item.item)
      || !item.isAlive()
      || !(validCrystalNames has item.item.name)
      || Math.abs(item.x - pos.x - 0.5) > 1
      || Math.abs(item.y - pos.y) > 1
      || Math.abs(item.z - pos.z - 0.5) > 1
      || item.item.tag.astralsorcery.crystalProperties.collectiveCapability == 100) {
      continue;
    }
    return item;
  }
  return null;
}

function workOnCrystal(world as IWorld, pos as IBlockPos, subtile as SubTileEntityInGame) as void {
  val sizeChange = 3 + world.random.nextInt(2);
  val cuttingChange = 1 + world.random.nextInt(2);
  if (subtile.data.crystalProperties.size <= sizeChange) {
    breakCrystal(world, pos, subtile);
    return;
  }
  cutCrystal(world, pos, subtile, sizeChange, cuttingChange);
}

function dropCrystal(world as IWorld, pos as IBlockPos, subtile as SubTileEntityInGame) as void {
  world.spawnEntity(validCrystalNames[subtile.getCustomData().name]
    .withTag({astralsorcery: {crystalProperties: subtile.data.crystalProperties}})
    .createEntityItem(world, pos.x, pos.y + 0.3f, pos.z));
  subtile.setCustomData({crystalProperties: {collectiveCapability: -1}} as IData);
}

function breakCrystal(world as IWorld, pos as IBlockPos, subtile as SubTileEntityInGame) as void {
  subtile.setCustomData({crystalProperties: {collectiveCapability: -1}} as IData);
  scripts.lib.sound.play('minecraft:entity.item.break', pos, world);
}

function cutCrystal(world as IWorld, pos as IBlockPos, subtile as SubTileEntityInGame, sizeChange as int, cuttingChange as int) as void {
  subtile.setCustomData(cutData(subtile.data, sizeChange, cuttingChange));
  (world.native as WorldServer).spawnParticle(EnumParticleTypes.BLOCK_CRACK , 0.5f + pos.x, 0.7f + pos.y, 0.5f + pos.z, 1, 0.0, 0.0, 0.0, 0, 35);
  scripts.lib.sound.play('minecraft:entity.wither.break_block', pos, world);
}

function cutData(data as IData, sizeChange as int, cuttingChange as int) as IData {
  return data.deepUpdate({crystalProperties: {size: data.crystalProperties.size - sizeChange, collectiveCapability: Math.min((data.crystalProperties.collectiveCapability + cuttingChange) as int, 100)}}, {crystalProperties: {size: OVERWRITE, collectiveCapability: OVERWRITE}});
}
