#modloaded industrialforegoing
#loader mixin

import mixin.Operation;
import mixin.CallbackInfo;
import native.com.buuz135.industrial.tile.block.CustomOrientedBlock;
import native.com.buuz135.industrial.tile.world.LaserDrillTile;
import native.net.minecraft.item.ItemStack;
import native.net.ndrei.teslacorelib.inventory.EnergyStorage;

/*
  [Petrified Fuel Generator] remembers the fuel it is burning as `new ItemStack(item, 1)`,
  which silently drops metadata and NBT. OME Tweaks' generator overhaul re-reads the burn
  time from that remembered copy, so a fuel with meta != 0 — like [Burn Singularity]
  <avaritia:singularity:12> — resolves to meta 0, gets a burn time of 0, and the machine
  ends up with a 0 RF/t release rate. Drawing its GUI then divides by that rate and crashes.
  Keep the whole stack so the remembered fuel matches what is actually burning.
*/
#mixin { targets: 'com.buuz135.industrial.tile.generator.AbstractFuelGenerator' }
zenClass MixinAbstractFuelGenerator {
  #mixin Shadow
  var current as ItemStack;

  #mixin WrapMethod { method: 'getFirstFuel' }
  function getFirstFuel(replace as bool, original as Operation) as ItemStack {
    val stack = original.call(replace) as ItemStack;
    if (!replace || stack.isEmpty()) return stack;

    val remembered = stack.copy();
    remembered.setCount(1);
    current = remembered;
    return stack;
  }
}

/*
  [Laser Drill] can keep a 50,000 RF buffer created before its block is available.
  Restore the block's configured capacity, including on existing drills.
  Raise input from 4,000 to 100,000 RF per receive call so upgraded drills
  can charge while running.
*/
#mixin { targets: 'net.ndrei.teslacorelib.tileentities.ElectricTileEntity' }
zenClass MixinElectricTileEntityLaserDrill {
  #mixin Shadow
  var energyStorage as EnergyStorage;

  #mixin Inject { method: 'innerUpdate()V', at: { value: 'HEAD' } }
  function applyLaserDrillCapacity(ci as CallbackInfo) as void {
    if (!(this0 instanceof LaserDrillTile)) return;
    if (isNull(this0.world) || this0.world.isRemote) return;

    val block = this0.getBlockType();
    if (!(block instanceof CustomOrientedBlock)) return;
    val capacity = (block as CustomOrientedBlock).getEnergyBuffer();
    if (capacity <= 0) return;

    var changed = false;
    if (energyStorage.capacity != capacity) {
      energyStorage.setCapacity(capacity);
      changed = true;
    }
    if (energyStorage.getEnergyInputRate() != 100000l) {
      energyStorage.setEnergyInputRate(100000l);
      changed = true;
    }
    if (changed) this0.forceSync();
  }
}
