#modloaded thaumcraft
#loader mixin

import native.java.lang.Math;
import native.net.minecraft.block.Block;
import native.net.minecraft.init.Blocks;
import native.net.minecraft.util.math.BlockPos;
import native.net.minecraft.world.World;
import native.net.minecraftforge.event.world.BlockEvent.HarvestDropsEvent;
import native.thaumcraft.api.blocks.BlocksTC;
import native.thaumcraft.api.crafting.IInfusionStabiliser;
import native.thaumcraft.api.crafting.IInfusionStabiliserExt;
import native.thaumcraft.common.blocks.basic.BlockPillar;
import native.thaumcraft.common.blocks.devices.BlockPedestal;
import native.thaumcraft.common.lib.enchantment.EnumInfusionEnchantment;
import native.java.lang.Object;

#mixin { targets: 'thaumcraft.common.tiles.devices.TileLampFertility' }
zenClass MixinTileLampFertility {
  #mixin ModifyConstant { method: 'updateAnimals', constant: { intValue: 5 } }
  function speedUpFluxSelfCleansing(value as int) as int {
    return 1;
  }
}

#mixin { targets: 'thaumcraft.common.lib.events.ToolEvents' }
zenClass MixinToolEvents {
  #mixin Static
  #mixin Redirect
  #{
  #  method: 'harvestBlockEvent',
  #  at: {
  #    value: 'INVOKE',
  #    target: 'Ljava/util/List;contains(Ljava/lang/Object;)Z',
  #    ordinal: 0
  #  }
  #}
  function buffRefining(list as [Object], obj as Object, event as HarvestDropsEvent) as bool {
    if (obj == EnumInfusionEnchantment.REFINING && (list has obj)) {
      val heldItem = event.harvester.getHeldItem(event.harvester.activeHand);
      scripts.mixin.thaumcraft.shared.Op.doRefining(event, heldItem);
    }
    return false;
  }
}

/*
 * Based on MatrixMixin from ThaumTweaks by GrigLog:
 * https://github.com/GrigLog/ThaumTweaks/blob/ab2af465fb93bd13ec47f8b12ad18674b8a1ea0e/src/main/java/griglog/thaumtweaks/mixins/blocks/MatrixMixin.java
 * Rewritten in Zenscript for this modpack.
 * Licensed under MIT (see LICENSE).
*/
#mixin { targets: 'thaumcraft.common.tiles.crafting.TileInfusionMatrix' }
zenClass MatrixMixin {
  #mixin Overwrite
  function getSurroundings() as void {
    this0.pedestals.clear();
    this0.tempBlockCount.clear();
    this0.problemBlocks.clear();
    this0.cycleTime = 10;
    this0.stabilityReplenish = 0.0f;
    this0.costMult = 1.0f;

    val stuff as [BlockPos] = [] as [BlockPos];

    //try {
    findAffectors(stuff);
    iterateFoundAffectors(stuff);
    checkPillarMaterials();
    checkBoostStones();
    checkPedestalMaterials();
    this0.countDelay = Math.max(1, this0.cycleTime / 2);
    //} catch (Exception var17) {
    //}
  }

  function findAffectors(stuff as [BlockPos]) as void {
    for xx in -8 .. 9 {
      for zz in -8 .. 9 {
        for yy in -3 .. 8 {
          if (xx != 0 || zz != 0) {
            val pos as BlockPos = BlockPos(this0.pos.getX() + xx, this0.pos.getY() - yy, this0.pos.getZ() + zz);
            val block as Block = this0.world.getBlockState(pos).getBlock();
            if (block instanceof BlockPedestal) {
              this0.pedestals.add(pos);
            }

            //try {
            if (block == Blocks.SKULL || (block instanceof IInfusionStabiliser && (block as IInfusionStabiliser).canStabaliseInfusion(this0.getWorld(), pos))) {
              stuff.add(pos);
            }
            //} catch (Exception var15) {
            //}
          }
        }
      }
    }
  }

  function iterateFoundAffectors(stuff as [BlockPos]) as void {
    while !stuff.isEmpty() {
      val pos = stuff[0];
      //try {
      val posSym as BlockPos = BlockPos(2 * this0.pos.getX() - pos.getX(), pos.getY(), 2 * this0.pos.getZ() - pos.getZ());
      val b1 as Block = this0.world.getBlockState(pos).getBlock();
      val b2 as Block = this0.world.getBlockState(posSym).getBlock();

      affectStability(pos, posSym, b1, b2);
      stuff.remove(pos);
      stuff.remove(posSym);
      //} catch (Exception var16) {
      //}
    }
  }

  function affectStability(pos as BlockPos, posSym as BlockPos, b1 as Block, b2 as Block) as void {
    var amt1 = 0.1f;
    var amt2 = 0.1f;
    if (b1 instanceof IInfusionStabiliserExt) {
      amt1 = (b1 as IInfusionStabiliserExt).getStabilizationAmount(this0.getWorld(), pos);
    }

    if (b2 instanceof IInfusionStabiliserExt) {
      amt2 = (b2 as IInfusionStabiliserExt).getStabilizationAmount(this0.getWorld(), posSym);
    }

    if (b1 == b2 && amt1 == amt2) {
      if (b1 instanceof IInfusionStabiliserExt && (b1 as IInfusionStabiliserExt).hasSymmetryPenalty(this0.getWorld(), pos, posSym)) {
        this0.stabilityReplenish -= (b1 as IInfusionStabiliserExt).getSymmetryPenalty(this0.getWorld(), pos);
        this0.problemBlocks.add(pos);
      }
      else {
        this0.stabilityReplenish += this0.calcDeminishingReturns(b1, amt1);
      }
    }
    else {
      this0.stabilityReplenish -= Math.max(amt1, amt2);
      this0.problemBlocks.add(pos);
    }
  }

  function checkPillarMaterials() as void {
    if (this0.world.getBlockState(this0.pos.add(-1, -2, -1)).getBlock() instanceof BlockPillar && this0.world.getBlockState(this0.pos.add(1, -2, -1)).getBlock() instanceof BlockPillar && this0.world.getBlockState(this0.pos.add(1, -2, 1)).getBlock() instanceof BlockPillar && this0.world.getBlockState(this0.pos.add(-1, -2, 1)).getBlock() instanceof BlockPillar) {
      if (this0.world.getBlockState(this0.pos.add(-1, -2, -1)).getBlock() == BlocksTC.pillarAncient && this0.world.getBlockState(this0.pos.add(1, -2, -1)).getBlock() == BlocksTC.pillarAncient && this0.world.getBlockState(this0.pos.add(1, -2, 1)).getBlock() == BlocksTC.pillarAncient && this0.world.getBlockState(this0.pos.add(-1, -2, 1)).getBlock() == BlocksTC.pillarAncient) {
        //this0.cycleTime -= 1;
        this0.costMult -= 0.2f;
        this0.stabilityReplenish -= 0.1f;
      }

      if (this0.world.getBlockState(this0.pos.add(-1, -2, -1)).getBlock() == BlocksTC.pillarEldritch && this0.world.getBlockState(this0.pos.add(1, -2, -1)).getBlock() == BlocksTC.pillarEldritch && this0.world.getBlockState(this0.pos.add(1, -2, 1)).getBlock() == BlocksTC.pillarEldritch && this0.world.getBlockState(this0.pos.add(-1, -2, 1)).getBlock() == BlocksTC.pillarEldritch) {
        this0.cycleTime -= 2;
        this0.costMult += 0.2;
        this0.stabilityReplenish += 0.2f;
      }
    }
  }

  function checkBoostStones() as void {
    var dCycleTime as double = 0.0;
    val m = [[-1,-1], [1,-1], [-1,1], [1,1]];
    for a in m {
      val b as Block = this0.world.getBlockState(this0.pos.add(a[0], -3, a[1])).getBlock();
      if (b == BlocksTC.matrixSpeed) {
        dCycleTime -= 1;
        this0.costMult += 0.1;
      }
      if (b == BlocksTC.matrixCost) {
        dCycleTime += 1;
        this0.costMult -= 0.1;
      }
    }
    this0.cycleTime += dCycleTime;
  }

  function checkPedestalMaterials() as void {
    for pedPos in this0.pedestals {
      val x = this0.pos.getX() - pedPos.getX();
      val z = this0.pos.getZ() - pedPos.getZ();
      val block as Block = this0.world.getBlockState(pedPos).getBlock();
      if (block == BlocksTC.pedestalEldritch) {
        this0.costMult -= 0.003;
      }

      if (block == BlocksTC.pedestalAncient) {
        this0.costMult += 0.002;
      }
    }
  }
}

#mixin { targets: 'thaumcraft.common.world.ThaumcraftWorldGenerator' }
zenClass MixinThaumcraftWorldGenerator {
  #mixin ModifyExpressionValue
  #{
  #  method: 'generateOres',
  #  at: {
  #    value: 'FIELD',
  #    target: 'Lthaumcraft/common/config/ModConfig$CONFIG_WORLD;generateCrystals:Z',
  #    opcode: 178
  #  }
  #}
  #mixin Local { parameter: 1, type: 'Lnet/minecraft/world/World;', argsOnly: true }
  function doNotGenerateCrystalsInNonMagicDimensions(original as bool, world as World) as bool {
    if (!original) return false;

    val dim = world.provider.dimension as int;
    for d in scripts.lib.dim.Op.tagsMap['MAGIC'] {
      if (d == dim) return true;
    }
    return false;
  }
}
