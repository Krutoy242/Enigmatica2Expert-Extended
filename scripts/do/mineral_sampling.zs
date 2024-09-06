#modloaded zenutils immersiveengineering immersivepetroleum tconevo
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
 * mod requirement:
 * - zenutils: for native java access
 * - immersiveengineering: provides `Mineral Sample`
 * - immersivepetroleum: for oil support
 * - tconevo: allows attaching energy to TCon tools, change this if energy consuming method
 * is altered/removed in the future
 *
 * @author ZZZank
 *
 * @see blusunrize.immersiveengineering.common.blocks.metal.TileEntitySampleDrill
 * @see blusunrize.immersiveengineering.api.tool.ExcavatorHandler
 */

import crafttweaker.data.IData;
import crafttweaker.entity.IEntityEquipmentSlot;
import crafttweaker.event.PlayerInteractBlockEvent;
import crafttweaker.item.IItemStack;

import native.blusunrize.immersiveengineering.api.tool.ExcavatorHandler;
import native.blusunrize.immersiveengineering.common.blocks.metal.TileEntitySampleDrill;
import native.flaxbeard.immersivepetroleum.api.crafting.PumpjackHandler;

import scripts.jei.crafting_hints;

val ENERGY_COST = 8000 * 10; // base cost is 8000RF, we make it 10 times bigger as the cost of saving time

// Recipe hint
val ENERGY_FULL_EXAMPLE = 100000; //must be no smaller than `ENERGY_COST` to prevent display error
crafting_hints.addInsOutsCatl(
  [
    <tconstruct:hammer>.withTag({
      FluxedEnergyMax: ENERGY_FULL_EXAMPLE, 
      Traits: ["tconevo.fluxed"], 
      Modifiers: [
        {identifier: "tconevo.fluxed", color: 11091771, level: 1, modifierUsed: 1 as byte}
      ], 
      FluxedEnergy: ENERGY_FULL_EXAMPLE
    })
  ],
  [
    <tconstruct:hammer>.withTag({
      FluxedEnergyMax: ENERGY_FULL_EXAMPLE, 
      Traits: ["tconevo.fluxed"], 
      Modifiers: [
        {identifier: "tconevo.fluxed", color: 11091771, level: 1, modifierUsed: 1 as byte}
      ], 
      FluxedEnergy: ENERGY_FULL_EXAMPLE - ENERGY_COST
    }),
    <immersiveengineering:coresample>
  ],
  <immersiveengineering:metal_device1:7>
);

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
  var sample = drill.createCoreSample(
    nativeWorld,
    nativePlayer.chunkCoordX,
    nativePlayer.chunkCoordZ,
    worldInfo
  ) as IItemStack;
  //attach oil info
  val oilInfo = PumpjackHandler.getOilWorldInfo(
    nativeWorld,
    nativePlayer.chunkCoordX,
    nativePlayer.chunkCoordZ
  );
  if (!isNull(oilInfo)) {
    sample = sample.withTag(sample.tag + {
      "resType": oilInfo.getType().name,
      "oil": oilInfo.current
    });
  }

  // give item, and prevent players from clicking multiple times, because one sample is enough for one chunk
  player.give(sample);
  player.setCooldown(item, 20);
});
