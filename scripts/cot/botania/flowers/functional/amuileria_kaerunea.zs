#modloaded botania
#priority 900
#reloadable

import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemDefinition;
import crafttweaker.item.IItemStack;
import crafttweaker.util.Math;
import crafttweaker.world.IBlockPos;
import crafttweaker.world.IWorld;
import mods.randomtweaker.cote.SubTileEntityInGame;
import native.net.minecraft.entity.effect.EntityLightningBolt;
import native.net.minecraft.util.EnumParticleTypes;
import native.net.minecraft.world.WorldServer;

static manaCostPerLightning as int = 1000;

// Actual Ingredient => Result recipes
static recipeMap as IItemStack[IIngredient] = {};

// Fast input definition lookup map for performance
static lookupMap as bool[IItemDefinition] = {};

for input, output in {
  <item:appliedenergistics2:material:0> : <item:appliedenergistics2:material:1>,
  <item:appliedenergistics2:material:10>: <item:appliedenergistics2:material:1>,
  <thermalfoundation:bait:1>: <thermalfoundation:bait:2>,
  <thermalfoundation:fertilizer:1>: <thermalfoundation:fertilizer:2>,
  <appliedenergistics2:quartz_ore>: <appliedenergistics2:charged_quartz_ore>,
  <harvestcraft:creeperwingsitem>: <rats:charged_creeper_chunk>,
} as IItemStack[IItemStack] {
  add(input, output);
}

function add(input as IIngredient, output as IItemStack) as void {
  recipeMap[input] = output;
  for item in input.items { lookupMap[item.definition] = true; }

  if (scriptStatus() == 0) { // Run only on initializing game
    scripts.jei.crafting_hints.addInsOutCatl([input], output, <botania:specialflower>.withTag({type: 'amuileria_kaerunea'}));
  }
}

<cotSubTile:amuileria_kaerunea>.onUpdate = function (subtile, world, pos) {
  if (world.remote
    || !world.worldInfo.isThundering()
    || world.worldInfo.worldTotalTime % 20 != 0
  ) {
    return;
  }

  charge(world, pos, subtile);
};

events.onEntityItemDeath(function (e as mods.zenutils.event.EntityItemDeathEvent) {
  if (e.item.world.remote
    || isNull(e.damageSource)
    || e.damageSource.damageType != 'lightningBolt'
  ) {
    return;
  }

  // Raw input check
  val item = e.item;
  if (isNull(item)
    || isNull(item.item)
    || isNull(item.item.definition)
    || !(lookupMap has item.item.definition)
  ) {
    return;
  }

  // More precipes ingredient check
  for input, output in recipeMap {
    if (!(input has item.item)) continue;

    val entityItem = output
      .withAmount(item.item.amount)
      .createEntityItem(e.item.world, item.x as float, item.y as float, item.z as float);
    entityItem.isInvulnerable = true;

    e.item.world.spawnEntity(entityItem);
    break;
  }
});

function charge(world as IWorld, pos as IBlockPos, subtile as SubTileEntityInGame) as void {
  if (isNull(subtile.data.charge)) subtile.setCustomData({charge: 0});
  if (subtile.data.charge < 4) {
    subtile.setCustomData({charge: 1 + subtile.data.charge});
    (world.native as WorldServer).spawnParticle(EnumParticleTypes.END_ROD, 0.5 + pos.x, 0.5 + pos.y, 0.5 + pos.z, 20, 0.25, 0.25, 0.25, 0, 0);
    return;
  }

  if (subtile.getMana() < manaCostPerLightning) return;

  var makeThunder = false;
  for item in world.getEntityItems() {
    if (isNull(item)
      || isNull(item.item)
      || Math.abs(item.y - pos.y) > 1
      || Math.abs(item.x - pos.x - 0.5) > 2
      || Math.abs(item.z - pos.z - 0.5) > 2
      || !item.alive
      || !(lookupMap has item.item.definition)
    ) {
      continue;
    }

    for input, _ in recipeMap {
      if (input has item.item) {
        makeThunder = true;
        break;
      }
    }

    if (makeThunder) break;
  }

  if (makeThunder) {
    val lightning = EntityLightningBolt(world, pos.x, pos.y, pos.z, false);
    world.native.addWeatherEffect(lightning);
    subtile.setCustomData({charge: 0});
  }
  else {
    (world.native as WorldServer).spawnParticle(EnumParticleTypes.CRIT_MAGIC, 0.5f + pos.x, 1.2 + pos.y, 0.5f + pos.z, 5, 0.4, 0.4, 0.4, 0, 0);
  }
}
