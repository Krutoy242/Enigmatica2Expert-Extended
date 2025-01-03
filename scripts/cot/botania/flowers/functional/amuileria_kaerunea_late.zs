#loader crafttweaker
#reloadable

import crafttweaker.item.IItemStack;
import crafttweaker.util.Math;
import crafttweaker.world.IBlockPos;
import crafttweaker.world.IWorld;
import mods.randomtweaker.cote.SubTileEntityInGame;
import native.net.minecraft.util.EnumParticleTypes;
import native.net.minecraft.world.WorldServer;

static recipesLigthningFlower as IItemStack[string] = {
} as IItemStack[string];

static manaCostPerLightning as int = 1000;

val amuileria_kaerunea = <cotSubTile:amuileria_kaerunea>;

amuileria_kaerunea.onUpdate = function (subtile, world, pos) {
  if (!world.worldInfo.isThundering()) return;
  if (world.isRemote()) return;
  if (world.worldInfo.worldTotalTime % 100 == 17) charge(world, pos, subtile);
};

events.onEntityItemDeath(function (e as mods.zenutils.event.EntityItemDeathEvent) {
  val world = e.item.world;
  if (world.isRemote()) return;
  val damageSource = e.damageSource;
  if (isNull(damageSource)) return;
  if (damageSource.damageType != 'lightningBolt') return;
  val item = e.item;
  if (isNull(item)) return;
  if (!(recipesLigthningFlower has item.item.name)) return;
  val newEntity = recipesLigthningFlower[item.item.name].withAmount(item.item.amount).createEntityItem(world, item.x as float, item.y as float, item.z as float);
  world.spawnEntity(newEntity);
});

function charge(world as IWorld, pos as IBlockPos, subtile as SubTileEntityInGame) as void {
  if (isNull(subtile.data.charge)) subtile.setCustomData({charge: 0});
  if (subtile.data.charge < 4) {
    subtile.setCustomData({charge: (subtile.data.charge as int + 1)});
    return;
  }

  var makeThunder = false;
  if (subtile.getMana() < manaCostPerLightning) return;
  for item in world.getEntityItems() {
    if (isNull(item)
      || isNull(item.item)
      || Math.abs(item.x - pos.x - 0.5) > 2
      || Math.abs(item.y - pos.y) > 1
      || Math.abs(item.z - pos.z - 0.5) > 2
      || !item.alive
      || !(recipesLigthningFlower has item.item.name)) {
      continue;
    }
    item.updateNBT({amuileria: 1});
    makeThunder = true;
    continue;
  }

  if (makeThunder) {
    server.commandManager.executeCommandSilent(server, `/summon minecraft:lightning_bolt ${pos.x} ${pos.y} ${pos.z}`);
    subtile.setCustomData({charge: 0});
  }
  else {
    (world.native as WorldServer).spawnParticle(EnumParticleTypes.CRIT_MAGIC, 0.5f + pos.x, 1.2 + pos.y, 0.5f + pos.z, 5, 0.4, 0.4, 0.4, 0, 0);
  }
}

val lightningRecipes = {
  <item:appliedenergistics2:material:0> : <item:appliedenergistics2:material:1>,
  <item:appliedenergistics2:material:10>: <item:appliedenergistics2:material:1>,
} as IItemStack[IItemStack];

for item, result in lightningRecipes {
  registerThunderRecipe(item, result);
  scripts.jei.crafting_hints.addInsOutCatl([item], result, <botania:specialflower>.withTag({type: 'amuileria_kaerunea'}));
}

function registerThunderRecipe(item as IItemStack, result as IItemStack) as void {
  if (recipesLigthningFlower has item.name) {
    return;
  }
  recipesLigthningFlower[item.name] = result;
  if (!(recipesLigthningFlower has result.name)) recipesLigthningFlower[result.name] = result;
}
