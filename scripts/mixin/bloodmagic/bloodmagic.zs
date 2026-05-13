#modloaded bloodmagic
#loader mixin

import mixin.CallbackInfoReturnable;
import native.net.minecraft.block.Block;
import native.net.minecraft.block.BlockDynamicLiquid;
import native.net.minecraft.block.state.IBlockState;
import native.net.minecraft.entity.monster.EntityZombie;
import native.net.minecraft.entity.player.EntityPlayer;
import native.net.minecraft.init.Blocks;
import native.net.minecraft.item.ItemStack;
import native.net.minecraftforge.fluids.Fluid;
import native.net.minecraftforge.fluids.FluidRegistry;
import native.net.minecraftforge.items.IItemHandler;
import native.WayofTime.bloodmagic.ritual.IMasterRitualStone;
import native.WayofTime.bloodmagic.ritual.imperfect.IImperfectRitualStone;
import scripts.mixin.bloodmagic.shared.Op;

#mixin { targets: 'WayofTime.bloodmagic.ritual.types.imperfect.ImperfectRitualZombie' }
zenClass MixinImperfectRitualZombie {
  #mixin Inject
  #{
  #  method: 'onActivate',
  #  at: {
  #    value: 'INVOKE',
  #    target: 'Lnet/minecraft/world/World;func_72838_d(Lnet/minecraft/entity/Entity;)Z',
  #    shift: 'BEFORE'
  #  },
  #  locals: 'CAPTURE_FAILHARD'
  #}
  function injectBlight(imperfectRitualStone as IImperfectRitualStone, player as EntityPlayer, cir as mixin.CallbackInfoReturnable, zombie as EntityZombie) as void {
    zombie.entityData.setBoolean('ScalingHealth.IsBlight', true);
  }
}

#mixin { targets: 'WayofTime.bloodmagic.ritual.types.RitualAnimalGrowth' }
zenClass MixinRitualAnimalGrowth {
  #mixin ModifyConstant { method: '<init>', constant: { intValue: 7 } }
  function buffRange(value as int) as int {
    return 128;
  }

  #mixin Overwrite
  function getBreedingDecreaseForWill(vengefulWill as double) as int {
    return 60.0 + vengefulWill / 60.0 * 2.0;
  }

  #mixin ModifyConstant { method: 'performRitual', constant: { intValue: 5 } }
  function buffGrowthSpeed(value as int) as int {
    return 60;
  }

  #mixin Redirect
  #{
  #  method: 'performRitual',
  #  at: {
  #    value: 'INVOKE',
  #    target: 'Lnet/minecraftforge/items/IItemHandler;extractItem(IIZ)Lnet/minecraft/item/ItemStack;',
  #    ordinal: 1
  #  }
  #}
  function disableFoodConsumption(handler as IItemHandler, slot as int, amount as int, simulate as bool) as ItemStack {
    return null;
  }

  #mixin ModifyVariable { method: 'performRitual', at: { value: 'STORE' }, name: 'maxGrowths' }
  function removeGrowthLimit(value as int) as int {
    return 2147483647; // Integer.MAX_VALUE
  }
}

#mixin { targets: 'WayofTime.bloodmagic.ritual.types.RitualCobblestone' }
zenClass MixinRitualCobblestone {
  #mixin Inject { method: 'performRitual', at: { value: 'HEAD' } }
  function resetBlock(masterRitualStone as IMasterRitualStone, ci as mixin.CallbackInfo) as void {
    Op.selectedBlock = Blocks.COBBLESTONE.defaultState;
  }

  #mixin Redirect
  #{
  #  method: 'performRitual',
  #  at: {
  #    value: 'INVOKE',
  #    target: 'Lnet/minecraft/item/ItemStack;func_77952_i()I'
  #  }
  #}
  function selectedBlock(catalyst as ItemStack) as int {
    if (isNull(Op.catalystToBlock)) Op.catalystToBlock = Op.init();
    val index = catalyst.itemDamage < Op.catalystToBlock.length ? catalyst.itemDamage : 0;
    Op.selectedBlock = Op.catalystToBlock[index] ?? Blocks.COBBLESTONE.defaultState;
    return -1; // Return -1 to skip the original switch statement logic.
  }

  #mixin Redirect
  #{
  #  method: 'performRitual',
  #  at: {
  #    value: 'INVOKE',
  #    target: 'Lnet/minecraft/block/Block;func_176223_P()Lnet/minecraft/block/state/IBlockState;'
  #  }
  #}
  function useNewBlockState(block as Block) as IBlockState {
    return Op.selectedBlock;
  }
}

#mixin { targets: 'WayofTime.bloodmagic.ritual.types.RitualContainment' }
zenClass MixinRitualContainment {
  #mixin ModifyConstant { method: '<init>', constant: { intValue: 10, ordinal: 0 } }
  function buffHorizontalRange(value as int) as int {
    return 300;
  }

  #mixin ModifyConstant { method: '<init>', constant: { intValue: 10, ordinal: 1 } }
  function buffVerticalRange(value as int) as int {
    return 300;
  }
}

#mixin { targets: 'WayofTime.bloodmagic.ritual.types.RitualCrushing' }
zenClass MixinRitualCrushing {
  #mixin Shadow
  static defaultRefreshTime as int;

  #mixin ModifyConstant { method: '<init>', constant: { intValue: 50 } }
  function setCrushingVolume(value as int) as int {
    return 0;
  }

  #mixin ModifyConstant { method: '<init>', constant: { intValue: 10, ordinal: 0 } }
  function setCrushingHorizontal(value as int) as int {
    return 63;
  }

  #mixin ModifyConstant { method: '<init>', constant: { intValue: 10, ordinal: 1 } }
  function setCrushingVertical(value as int) as int {
    return 255;
  }

  #mixin Static
  #mixin Inject { method: '<clinit>', at: { value: 'RETURN' } }
  function changeDefaultRefreshTime(ci as mixin.CallbackInfo) as void {
    this.defaultRefreshTime = 10;
  }

  #mixin ModifyConstant { method: 'performRitual', constant: { intValue: 3 } }
  function setFortuneLevel(value as int) as int {
    return 8;
  }

  #mixin ModifyConstant { method: 'getRefreshTimeForRawWill', constant: { doubleValue: 40 } }
  function changeRefreshTimeBase(value as double) as double {
    return 10.0;
  }
}

#mixin { targets: 'WayofTime.bloodmagic.ritual.types.RitualLava' }
zenClass MixinRitualLava {
  #mixin Redirect
  #{
  #  method: 'performRitual',
  #  at: {
  #    value: 'INVOKE',
  #    target: 'Lnet/minecraft/block/BlockDynamicLiquid;func_176223_P()Lnet/minecraft/block/state/IBlockState;'
  #  }
  #}
  function replaceLavaBlockWithPyrotheum(lavaBlock as BlockDynamicLiquid) as IBlockState {
    val pyrotheum = FluidRegistry.getFluid('pyrotheum');
    if (isNull(pyrotheum?.getBlock())) {
      return lavaBlock.defaultState;
    }
    return pyrotheum.getBlock().defaultState;
  }

  #mixin Redirect
  #{
  #  method: 'performRitual',
  #  at: {
  #    value: 'FIELD',
  #    target: 'Lnet/minecraftforge/fluids/FluidRegistry;LAVA:Lnet/minecraftforge/fluids/Fluid;',
  #    opcode: 178
  #  }
  #}
  function replaceLavaFluidWithPyrotheum() as Fluid {
    val pyrotheum = FluidRegistry.getFluid('pyrotheum');
    if (isNull(pyrotheum)) {
      return FluidRegistry.LAVA;
    }
    return pyrotheum;
  }
}

#mixin { targets: 'WayofTime.bloodmagic.ritual.types.RitualMagnetic' }
zenClass MixinRitualMagnetic {
  #mixin Inject { method: 'getRadius', at: { value: 'HEAD' }, cancellable: true }
  function getBiggerRadius(block as Block, cir as CallbackInfoReturnable) as void {
    if (isNull(block?.registryName)) return;

    val blockName = block.registryName.toString();
    if (blockName == 'twilightforest:aurora_block') {
      cir.setReturnValue(63);
    }
    else if (blockName == 'twilightforest:castle_rune_brick') {
      cir.setReturnValue(127);
    }
    else if (blockName == 'enderio:block_alloy_endergy') {
      cir.setReturnValue(255);
    }
  }
}

#mixin { targets: 'WayofTime.bloodmagic.ritual.types.RitualMeteor' }
zenClass MixinRitualMeteor {
  #mixin ModifyArg
  #{
  #  method: 'getRadiusModifier',
  #  at: {
  #    value: 'INVOKE',
  #    target: 'Ljava/lang/Math;pow(DD)D'
  #  },
  #  index: 1
  #}
  function fixIntegerDivisionInGetRadiusModifier(b as double) as double {
    return 1.0 / 3.0;
  }
}

#mixin { targets: 'WayofTime.bloodmagic.ritual.types.RitualPlacer' }
zenClass MixinRitualPlacer {
  function getRefreshTime() as int {
    return 1; // default 40
  }

  #mixin Overwrite
  function getRefreshCost() as int {
    return 1; // default 50
  }
}

#mixin { targets: 'WayofTime.bloodmagic.ritual.types.RitualRegeneration' }
zenClass MixinRitualRegeneration {
  #mixin ModifyArg
  #{
  #  method: 'performRitual',
  #  at: {
  #    value: 'INVOKE',
  #    target: 'Lnet/minecraft/potion/PotionEffect;<init>(Lnet/minecraft/potion/Potion;IIZZ)V'
  #  },
  #  index: 2
  #}
  function changeRegenAmplifier(amplifier as int) as int {
    return 9;
  }
}

#mixin { targets: 'WayofTime.bloodmagic.ritual.types.RitualZephyr' }
zenClass MixinRitualZephyr {
  #mixin ModifyConstant { method: '<init>', constant: { intValue: -5 } }
  function changeRadiusStart(value as int) as int {
    return -127;
  }

  #mixin ModifyConstant { method: '<init>', constant: { intValue: 11 } }
  function changeRadiusSize(value as int) as int {
    return 256;
  }

  #mixin ModifyConstant { method: '<init>', constant: { intValue: 10 } }
  function changeMaxDistance(value as int) as int {
    return 255;
  }

  #mixin Overwrite
  function getRefreshTime() as int {
    return 10;
  }
}
