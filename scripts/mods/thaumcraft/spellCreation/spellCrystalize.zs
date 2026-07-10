#priority 100
#modloaded thaumcraft

import crafttweaker.block.IBlock;
import crafttweaker.util.Math;
import crafttweaker.world.IBlockPos;
import crafttweaker.world.IWorld;
import native.com.blamejared.compat.thaumcraft.handlers.ThaumCraft;
import native.net.minecraft.block.state.IBlockState;
import native.net.minecraft.entity.Entity;
import native.net.minecraft.util.math.BlockPos;
import native.net.minecraft.util.math.RayTraceResult;
import native.net.minecraft.world.World;
import native.net.minecraftforge.fml.common.network.NetworkRegistry;
import native.thaumcraft.api.aspects.Aspect;
import native.thaumcraft.api.casters.FocusEffect;
import scripts.mods.thaumcraft.spellCreation.spellFX.SpellFX;
import native.thaumcraft.api.casters.NodeSetting;
import native.thaumcraft.api.casters.Trajectory;
import native.thaumcraft.common.lib.network.PacketHandler;
import native.thaumcraft.common.lib.network.fx.PacketFXFocusPartImpact;
import native.thaumcraft.common.blocks.world.ore.BlockCrystal;

zenClass CrystalizeEffect {
    val crystalize as function(IWorld, IBlockPos)[BlockPos];

    zenConstructor(crystalize as function(IWorld, IBlockPos)[BlockPos]) {
      this.crystalize = crystalize;
    }
}

zenClass SpellCrystalize extends FocusEffect {
    var crystalizeStructures as CrystalizeEffect[string];
    var crystalizeBlocks as IBlockState[string];

    zenConstructor() {
      super();
      
      this.crystalizeStructures = {
        'aer'     : this.CrystalizeEffectAer(),
        'aqua'    : this.CrystalizeEffectAqua(),
        'ignis'   : this.CrystalizeEffectIgnis(),
        'ordo'    : this.CrystalizeEffectOrdo(),
        'perditio': this.CrystalizeEffectPerditio(),
        'terra'   : this.CrystalizeEffectTerra(),
        'vitium'  : this.CrystalizeEffectVitium(),
      } as CrystalizeEffect[string];

      this.crystalizeBlocks = {
        'aer'     : <item:quark:crystal>.asBlock().native.getStateFromMeta(3),
        'aqua'    : <item:quark:crystal>.asBlock().native.getStateFromMeta(5),
        'ignis'   : <item:quark:crystal>.asBlock().native.getStateFromMeta(2),
        'ordo'    : <item:quark:crystal>.asBlock().native.getStateFromMeta(0),
        'perditio': <item:quark:crystal>.asBlock().native.getStateFromMeta(8),
        'terra'   : <item:quark:crystal>.asBlock().native.getStateFromMeta(4),
        'vitium'  : <item:quark:crystal>.asBlock().native.getStateFromMeta(7),
      } as IBlockState[string];
    }

    //======================
    //Set up some basic info
    //======================

    function getResearch() as string {
        return 'CRYSTALIZE';
    }
    
    function getKey() as string {
        return 'thaumcraft.CRYSTALIZE';
    }

    //===================================
    //Set up focalmanipulator spell stats
    //===================================
    
    function getAspect() as Aspect {
        return ThaumCraft.getAspect(Aspects('💎')[0]);
    }

    function getComplexity() as int {
        return 10;
    }

    function createSettings() as NodeSetting[] {
        return [];
    }

    //==========================
    //Set up executable function
    //==========================

    function CrystalizeEffectAer() as CrystalizeEffect {
      return CrystalizeEffect(function(world as IWorld, pos as IBlockPos) as [BlockPos] {
        val list as [BlockPos] = [] as [BlockPos];
        for x in (pos.x - 3) .. (pos.x + 4){
          val distX = Math.sqrt(9 - pow(x-pos.x, 2.0));
          for z in (pos.z - distX) .. (pos.z + distX + 1){
            val distXZ = Math.sqrt(9 - pow(x-pos.x, 2.0) - pow(z-pos.z, 2.0));
            for y in Math.max((pos.y - distXZ), 1) .. Math.min((pos.y + distXZ + 1), 255){
              list.add(BlockPos(x, y, z));
            }
          }
        }
        return list;
      });
    }

    function CrystalizeEffectAqua() as CrystalizeEffect {
      return CrystalizeEffect(function(world as IWorld, pos as IBlockPos) as [BlockPos] {
        val list as [BlockPos] = [] as [BlockPos];
        for x in (pos.x - 3) .. (pos.x + 4){
          val distX = Math.sqrt(15 - pow(x-pos.x, 2.0));
          for z in (pos.z - distX) .. (pos.z + distX + 1){
            val distXZ = Math.sqrt(15 - pow(x-pos.x, 2.0) - pow(z-pos.z, 2.0));
            for y in Math.max((pos.y - distXZ * 3), 1) .. Math.min((pos.y + distXZ * 3 + 1), 255){
              list.add(BlockPos(x, y, z));
            }
          }
        }
        return list;
      });
    }

    function CrystalizeEffectIgnis() as CrystalizeEffect {
      return CrystalizeEffect(function(world as IWorld, pos as IBlockPos) as [BlockPos] {
        val list as [BlockPos] = [] as [BlockPos];
        val rng = world.random;
        for x in (pos.x - 5) .. (pos.x + 6) {
          for z in (pos.z - 5) .. (pos.z + 6) {
            for y in Math.max((pos.y - rng.nextInt(10)), 1) .. Math.min((pos.y + rng.nextInt(10)), 255){
              list.add(BlockPos(x, y, z));
            } 
          }
        }
        return list;
      });
    }

    function CrystalizeEffectOrdo() as CrystalizeEffect {
      return CrystalizeEffect(function(world as IWorld, pos as IBlockPos) as [BlockPos] {
        val list as [BlockPos] = [] as [BlockPos];
        for x in (pos.x - 4) .. (pos.x + 5){
          for z in (pos.z - 4) .. (pos.z + 5){
            for y in Math.max((pos.y - 4), 1) .. Math.min((pos.y + 5), 255){
              val value = (Math.abs(pos.x - x) % 2) + (Math.abs(pos.y - y) % 2) + (Math.abs(pos.z - z) % 2); 
              if(value < 2) continue;
              list.add(BlockPos(x, y, z));
            }
          }
        }
        return list;
      });
    }

    function CrystalizeEffectPerditio() as CrystalizeEffect {
      return CrystalizeEffect(function(world as IWorld, pos as IBlockPos) as [BlockPos] {
        val list as [BlockPos] = [] as [BlockPos];
        val rng = world.random; 
        for i in 0 .. 300 {
          list.add(BlockPos(pos.x + rng.nextInt(-10,11), Math.min(Math.max(pos.y + rng.nextInt(-10,11), 1), 255), pos.z + rng.nextInt(-10,11)));
        }
        return list;
      });
    }

    function CrystalizeEffectTerra() as CrystalizeEffect {
      return CrystalizeEffect(function(world as IWorld, pos as IBlockPos) as [BlockPos] {
        val list as [BlockPos] = [] as [BlockPos];
        for x in (pos.x - 2) .. (pos.x + 3){
          for z in (pos.z - 2) .. (pos.z + 3){
            for y in Math.max((pos.y - 2), 1) .. Math.min((pos.y + 3), 255){
              list.add(BlockPos(x, y, z));
            }
          }
        }
        return list;
      });
    }

    function CrystalizeEffectVitium() as CrystalizeEffect {
      return CrystalizeEffect(function(world as IWorld, pos as IBlockPos) as [BlockPos] {
        val list as [BlockPos] = [] as [BlockPos];
        val rng = world.random; 
        
        for i in 0 .. 12 {
          val fi = rng.nextDouble(0.0, 6.28);
          val psi = rng.nextDouble(0.0, 6.28);
          var x = pos.x as double;
          var y = pos.y as double;
          var z = pos.z as double;
    
          while(pow(x - pos.x, 2) + pow(y - pos.y, 2) + pow(z - pos.z, 2) < 1000){
            val fiNew = rng.nextDouble(fi, fi + 3.14);
            val psiNew = rng.nextDouble(psi, psi + 3.14);
            x += Math.cos(fiNew) * Math.cos(psiNew);
            y += Math.cos(fiNew) * Math.sin(psiNew);
            z += Math.sin(fiNew);
            if (y < 1 || y > 255) break;
            list.add(BlockPos(x, y, z));
          }
        }
        return list;
      });
    }

    function execute(target as RayTraceResult, trajectory as Trajectory, finalPower as float, num as int) as bool {
      val world = this.getPackage().world.wrapper;
      val pos = target.getBlockPos();
      PacketHandler.INSTANCE.sendToAllAround(PacketFXFocusPartImpact(target.hitVec.x, target.hitVec.y, target.hitVec.z, [getKey()]), NetworkRegistry.TargetPoint(world.getDimension(), target.hitVec.x, target.hitVec.y, target.hitVec.z, 64.0));

      if(target.typeOfHit != RayTraceResult.Type.BLOCK) return false;

      val bl = world.native.getBlockState(pos).getBlock();
      if(!bl instanceof BlockCrystal) return false;

      
      val name = (bl as BlockCrystal).aspect.getName().toLowerCase();
      val structurePos = this.crystalizeStructures[name].crystalize(world, pos);
      val crystal = this.crystalizeBlocks[name];

      world.native.destroyBlock(pos, false);

      world.catenation()
        .run(function(world, context) {
          context.data = 0; 
        })
        .sleepUntil(function(world, context){
          if(structurePos.isEmpty()) return true;
          context.data = context.data + 1;
          val bound = structurePos.length - 1;
          for index in 0 .. structurePos.length {
            val posEx = structurePos[bound - index];
            if (pow(posEx.getX() - pos.x, 2.0) + pow(posEx.getY() - pos.y, 2.0) + pow(posEx.getZ() - pos.z, 2.0) < pow(context.data, 1.5)){
              val block as IBlock = world.getBlock(posEx);
              if (!isNull(block) && world.getBlockState(posEx).isReplaceable(world, posEx)) world.setBlockState(crystal, posEx);
              structurePos.removeByIndex(bound - index, bound - index);
            }
          }      
          return false;
        })
        .onStop(function(world, context){}).start();

      return true;
    }

    function onCast(caster as Entity) {
        
    }

    //==================
    //Particle rendering
    //==================

    function renderParticleFX(world as World, posX as double, posY as double, posZ as double, motionX as double, motionY as double, motionZ as double) as void {
        if (!isNull(SpellFX.crystalize)) SpellFX.crystalize(this, world, posX, posY, posZ, motionX, motionY, motionZ);
    }

}


