/*
Nuclianthus (Helianthus + nuclear) - botanical reactor
Generates power using nuclear fuel (produces nuclear waste)
Catch: if buffer is overflowing (for some mana amount wasted - but heals overtime) it explodes KABOOM!!!

Stats:
Mana per 1 sec: H/t*eff
Time working: as on fuel
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
import native.nc.enumm.IFissionFuelEnum;
import native.nc.item.ItemFissionFuel;
import native.net.minecraft.util.EnumParticleTypes;
import native.net.minecraft.world.WorldServer;

static fuelsList as int[][string] = {
/*
Fromat:
fuel:name [duration, heat/t, effciency]
*/

  // IC2 fuels
  'ic2.nuclear.uranium': [7600,  100, 120],    // Enriched uranium
  'ic2.nuclear.mox'    : [45600, 140, 135],    // MOX

} as int[][string];

static fuelDurationMultiplier as double = 0.5; //It's not nerfed, this getter always returns doubled amount, that's why it's 0.5
static fuelManaGenerationMultiplier as double = 1.0;
static overHeatLimit as int = 10000;

val nuclianthus = VanillaFactory.createSubTileGenerating('nuclianthus', 0xFFFF00);
nuclianthus.maxMana = 10000;
nuclianthus.passiveFlower = false;
nuclianthus.range = 1;
nuclianthus.onUpdate = function (subtile, world, pos) {
  if (world.remote) return;
  isWorking(subtile) ? generate(world, pos, subtile) : pickUpFuel(world, pos, subtile);
};
nuclianthus.register();

function isWorking(subtile as SubTileEntityInGame) as bool {
  return !(isNull(subtile.data)
    || isNull(subtile.data.Status)
    || subtile.data.Status != 'work');
}

function generate(world as IWorld, pos as IBlockPos, subtile as SubTileEntityInGame) as void {
  if (subtile.data.FuelData.duration > 0) {
    val manaGenerated = (subtile.data.FuelData.production / 20) as int;
    val heatGenerated = Math.max(manaGenerated + subtile.getMana() - subtile.getMaxMana(), 0);
    subtile.setCustomData(subtile.data.deepUpdate({Overheat: (Math.max((subtile.data.Overheat + heatGenerated - 10) as int , 0)), FuelData: {duration: subtile.data.FuelData.duration - 2}},{FuelData: {duration: OVERWRITE}, Overheat: OVERWRITE}));
    subtile.addMana(manaGenerated);
    if (world.random.nextInt(5) > 2) scripts.lib.sound.play('minecraft:block.lava.pop', pos, world);
    makeParticleRing(world ,0.5f + pos.x, 1.2 + pos.y, 0.5f + pos.z, pow((subtile.data.FuelData.duration as double), 0.5) / 10.0, pow((subtile.data.FuelData.maxDuration as double), 0.5) / 10.0, ((subtile.data.Overheat as float) / 10000) - 1, (((10000 - subtile.data.Overheat) as float) / 10000));
    if (subtile.data.Overheat > overHeatLimit) world.performExplosion(null, pos.x, pos.y, pos.z, 6.0f, true, true);
  }
  else {
    dropFuelWaste(world, pos, subtile);
  }
}

function makeParticleRing(world as IWorld, x as double, y as double, z as double, circleLength as double, max as double, r as float, g as float) as void{
  for i in 0 .. circleLength {
    (world.native as WorldServer).spawnParticle(EnumParticleTypes.REDSTONE, x + 0.5*Math.cos(6.28 * (i as double / max)), y, z + 0.5*Math.sin(6.28 * (i as double / max)), 0, r, g, 0, 1, 0);
  }
}

function pickUpFuel(world as IWorld, pos as IBlockPos, subtile as SubTileEntityInGame) as void {
  if(world.worldInfo.worldTotalTime % 20 != 3) return;
  val fuel = findFuel(world, pos);
  if (isNull(fuel)) return;
  val fuelData = getFuelData(fuel.item);
  if (isNull(fuelData)) return;
  val newData = {
    Status   : 'work',
    FuelData : {duration: (fuelDurationMultiplier * fuelData[0]) as int , production: (fuelManaGenerationMultiplier * fuelData[1] * fuelData[2] / 100) as int, maxDuration: (fuelDurationMultiplier * fuelData[0]) as int},
    Overheat : getSubtileHeat(subtile),
    WasteName: getFuelWasteOreDictName(fuel.item),
  } as IData;
  subtile.setCustomData(newData);
  scripts.lib.sound.play('minecraft:entity.item.pickup', pos, world);

  fuel.item.amount == 1 ? fuel.setDead() : fuel.item.mutable().shrink(1);
}

function getFuelData(item as IItemStack) as int[] {
  if (fuelsList has item.name) return fuelsList[item.name];

  val itemFuelNC = item.native.getItem();

  if (itemFuelNC instanceof ItemFissionFuel) {
    val fuelEnum = (itemFuelNC as ItemFissionFuel).values[item.metadata] as IFissionFuelEnum;
    return [fuelEnum.getBaseTime(), fuelEnum.getBaseHeat(), (fuelEnum.getBaseEfficiency() * 100) as int];
  }

  return null;
}

function getSubtileHeat(subtile as SubTileEntityInGame) as int {
  if (isNull(subtile.data)
    || isNull(subtile.data.Overheat)) {
    return 0;
  }
  return subtile.data.Overheat as int;
}

function getFuelWasteOreDictName(item as IItemStack) as string {
  for ore in item.ores {
    if (ore.name.startsWith('ingot')) return ore.name.replaceFirst('ingot', 'ingotDepleted');
  }
}

function findFuel(world as IWorld, pos as IBlockPos) as IEntityItem {
  val items = world.getEntityItems();
  for item in items {
    if (isNull(item)
      || isNull(item.item)
      || Math.abs(item.x - pos.x - 0.5) > 2
      || Math.abs(item.y - pos.y) > 1
      || Math.abs(item.z - pos.z - 0.5) > 2
      || !item.alive) {
      continue;
    }
    for ore in item.item.ores {
      if (ore.name == 'fuelReactor') return item;
    }
  }
  return null;
}

function dropFuelWaste(world as IWorld, pos as IBlockPos, subtile as SubTileEntityInGame) as void {
  world.spawnEntity(oreDict.get(subtile.data.WasteName).firstItem.createEntityItem(world, pos.x, pos.y + 0.3f, pos.z));
  subtile.setCustomData({Status: 'pickUp'} as IData);
}
