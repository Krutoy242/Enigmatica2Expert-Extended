#modloaded zenutils immersiveengineering
#reloadable

/**
 * Fast mineral sampling
 *
 * usage:
 * -player must be sneaking
 * -player must be holding a hammer from TCon in it's main hand
 * -player must be targeting a Sample Drill
 * -The hammer must has an NBT element named "FluxedEnergy", in integar, as its energy value
 *     -This can be achieved by "Flux Infused" modifier from TCon Evo
 * -The energy of this hammer must be no less than `ENERGY_COST`
 *
 * if all matches:
 * -the energy of this hammer will decrease by the value of `ENERGY_COST`
 * -a mineral sample will be generated
 *     -the position that the sample represents is the position of Sample Drill
 * -player will be given this sample
 * -the hammer will recive a cooldown of 20 ticks
 *
 * @author ZZZank
 *
 * @see blusunrize.immersiveengineering.common.blocks.metal.TileEntitySampleDrill
 * @see blusunrize.immersiveengineering.api.tool.ExcavatorHandler
 */

import crafttweaker.data.IData;
import crafttweaker.entity.IEntityEquipmentSlot;
import crafttweaker.event.PlayerInteractBlockEvent;
import native.blusunrize.immersiveengineering.api.tool.ExcavatorHandler;
import native.blusunrize.immersiveengineering.common.blocks.metal.TileEntitySampleDrill;

val ENERGY_COST = 8000 * 10; // base cost is 8000RF, we make it 10 times bigger as the cost of saving time

events.onPlayerInteractBlock(function (event as PlayerInteractBlockEvent) {
  val player = event.player;
  val item = event.item;
  val block = event.block;
  val world = event.world;

  // skip invalid interactions
  if (
    event.canceled
    || player.fake
    || !player.isSneaking
    || event.hand != 'MAIN_HAND'
    || !(<item:tconstruct:hammer>.matches(item))
    || block.definition.id != 'immersiveengineering:metal_device1'
  ) {
    return;
  }

  // energy-based interaction filtering, consume energy
  val energy = item.tag.memberGet('FluxedEnergy') as int;
  if (energy < ENERGY_COST) {
    return;
  }
  player.setItemToSlot(
    IEntityEquipmentSlot.mainHand(),
    item.updateTag({ 'FluxedEnergy': (energy - ENERGY_COST) } as IData)
  );

  // get mineral sample
  val nativeWorld = world.native;
  val nativePlayer = player.native;
  val drill = nativeWorld.getTileEntity(event.position.native) as TileEntitySampleDrill;
  /**
    @see blusunrize.immersiveengineering.common.blocks.metal.TileEntitySampleDrill
    @see blusunrize.immersiveengineering.api.tool.ExcavatorHandler
     */
  val worldInfo = ExcavatorHandler.getMineralWorldInfo(
    nativeWorld,
    nativePlayer.chunkCoordX,
    nativePlayer.chunkCoordZ
  );
    val sample = drill.createCoreSample(
    nativeWorld,
    nativePlayer.chunkCoordX,
    nativePlayer.chunkCoordZ,
    worldInfo
  );

  // give item, and prevent players from clicking multiple times, because one sample is enough for one chunk
  player.give(sample.wrapper);
  player.setCooldown(item, 20);
});
