#priority 100
#modloaded thaumcraft ic2

import crafttweaker.player.IPlayer;
import crafttweaker.util.Math;
import native.com.blamejared.compat.thaumcraft.handlers.ThaumCraft;
import native.ic2.core.crop.TileEntityCrop;
import native.net.minecraft.entity.Entity;
import native.net.minecraft.util.SoundCategory;
import native.net.minecraft.util.math.BlockPos;
import native.net.minecraft.util.math.RayTraceResult;
import native.net.minecraft.world.World;
import native.net.minecraftforge.fml.common.network.NetworkRegistry;
import native.thaumcraft.api.aspects.Aspect;
import native.thaumcraft.api.casters.FocusEffect;
import native.thaumcraft.api.casters.NodeSetting;
import native.thaumcraft.api.casters.Trajectory;
import native.thaumcraft.client.fx.ParticleEngine;
import native.thaumcraft.client.fx.particles.FXGeneric;
import native.thaumcraft.common.lib.SoundsTC;
import native.thaumcraft.common.lib.network.PacketHandler;
import native.thaumcraft.common.lib.network.fx.PacketFXFocusPartImpact;

zenClass SpellBloomia extends FocusEffect {

    zenConstructor() {
        super();
    }

    //======================
    //Set up some basic info
    //======================

    function getResearch() as string {
        return 'BLOOMIA';
    }
    
    function getKey() as string {
        return 'thaumcraft.BLOOMIA';
    }

    //===================================
    //Set up focalmanipulator spell stats
    //===================================

    function getAspect() as Aspect {
        return ThaumCraft.getAspect(Aspects('🌱')[0]);
    }

    function getComplexity() as int {
        return 15;
    }

    function createSettings() as NodeSetting[] {
        return [
            NodeSetting('tendency', 'focus.common.tendency', NodeSetting.NodeSettingIntList([-1, 1], ['focus.common.negative', 'focus.common.positive'])),
            NodeSetting('stat',     'focus.common.stat',     NodeSetting.NodeSettingIntList([1, 2, 3], ['focus.common.growth', 'focus.common.resistance', 'focus.common.gain']))
        ];
    }

    //==========================
    //Set up executable function
    //==========================

    function execute(target as RayTraceResult, trajectory as Trajectory, finalPower as float, num as int) as bool {

        val pkg = this.getPackage();
        val world = pkg.world;

        PacketHandler.INSTANCE.sendToAllAround(PacketFXFocusPartImpact(target.hitVec.x, target.hitVec.y, target.hitVec.z, [getKey()]), NetworkRegistry.TargetPoint(world.provider.getDimension(), target.hitVec.x, target.hitVec.y, target.hitVec.z, 64.0));

        if(target.typeOfHit != RayTraceResult.Type.BLOCK) return false;

        val block = world.getTileEntity(target.getBlockPos());
        if(isNull(block) || !(block instanceof TileEntityCrop)) return false;

        val caster = pkg.getCaster().wrapper;
        if(!(caster instanceof IPlayer)) return false;

        val player as IPlayer = caster;
        val inventory = player.getPlayerInventoryItemHandler();
        val fertilizer = <ic2:crop_res:2>.native;

        var found = false;

        for i in 0 .. inventory.size {
          val stack = inventory.getStackInSlot(i).native;
          if(!stack.isEmpty() && stack.isItemEqual(fertilizer)) {
            stack.shrink(1);
            inventory.setStackInSlot(i, stack);
            found = true;
            break;
          }
        }

        if(!found) return false;

        val tileCrop = block as TileEntityCrop;
        val stat = this.getSettingValue('stat');
        val tendency = this.getSettingValue('tendency');
        val rand = world.rand;

        val delta = (rand.nextFloat(2.4f) - 0.1f) * tendency;

        if(stat == 1) {
          tileCrop.setStatGrowth(keepInStatsRange(tileCrop.getStatGrowth() + delta));
        }
        else if(stat == 2) {
          tileCrop.setStatResistance(keepInStatsRange(tileCrop.getStatResistance() + delta));
        }
        else if(stat == 3) {
          tileCrop.setStatGain(keepInStatsRange(tileCrop.getStatGain() + delta));
        }

        if(rand.nextInt(10) == 0) tileCrop.setStatGrowth(keepInStatsRange(tileCrop.getStatGrowth() - tendency));
        if(rand.nextInt(10) == 0) tileCrop.setStatResistance(keepInStatsRange(tileCrop.getStatResistance() - tendency));
        if(rand.nextInt(10) == 0) tileCrop.setStatGain(keepInStatsRange(tileCrop.getStatGain() - tendency));

        world.playSound(null, BlockPos(target.hitVec.x, target.hitVec.y, target.hitVec.z), SoundsTC.wand, SoundCategory.AMBIENT, 1.0f, rand.nextFloat() * 0.4f + 0.8f);
        return true;
    }

    function keepInStatsRange(i as int) as int{
        return Math.min(Math.max(i , 0), 31);
    }

    function onCast(caster as Entity) {
        
    }

    //==================
    //Particle rendering
    //==================

    function renderParticleFX(world as World, posX as double, posY as double, posZ as double, motionX as double, motionY as double, motionZ as double) as void {
        val fb as FXGeneric = FXGeneric(world, posX, posY, posZ, motionX, motionY, motionZ);
    
        fb.setMaxAge(8); 
        fb.setRBGColorF(0.545f + (world.rand.nextFloat() - 0.5f) * 0.1f, 0.78f + (world.rand.nextFloat() - 0.5f) * 0.1f, 0.388f + (world.rand.nextFloat() - 0.5f) * 0.1f);
        fb.setGridSize(16); 
        fb.setParticles(72 + world.rand.nextInt(4), 1, 1);
        fb.setScale(2.0 + world.rand.nextFloat() * 4.0); 
        fb.setLoop(false);
        fb.setSlowDown(0.9);
        fb.setGravity(0.0);
        fb.setRotationSpeed(world.rand.nextFloat(), 0.0);
    
        ParticleEngine.addEffectWithDelay(world, fb, world.rand.nextInt(4));
    }

}
