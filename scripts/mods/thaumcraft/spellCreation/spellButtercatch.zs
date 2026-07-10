#priority 100
#modloaded thaumcraft

import native.com.blamejared.compat.thaumcraft.handlers.ThaumCraft;
import native.forestry.api.lepidopterology.IEntityButterfly;
import native.net.minecraft.entity.Entity;
import native.net.minecraft.init.SoundEvents;
import native.net.minecraft.util.SoundCategory;
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

zenClass SpellButtercatch extends FocusEffect {

    zenConstructor() {
        super();
    }

    //======================
    //Set up some basic info
    //======================

    function getResearch() as string {
        return 'BUTTERCATCH';
    }
    
    function getKey() as string {
        return 'thaumcraft.BUTTERCATCH';
    }

    //===================================
    //Set up focalmanipulator spell stats
    //===================================
    
    function getAspect() as Aspect {
        return ThaumCraft.getAspect(Aspects('♒')[0]);
    }

    function getComplexity() as int {
        return this.getSettingValue('range') / 5;
    }

    function createSettings() as NodeSetting[] {
        return [
            NodeSetting('range',     'focus.common.range',      NodeSetting.NodeSettingIntList([25, 75, 125, 250], ['25', '75', '125', '250']))
        ];
    }

    //==========================
    //Set up executable function
    //==========================

    function execute(target as RayTraceResult, trajectory as Trajectory, finalPower as float, num as int) as bool {
        val world = this.getPackage().world;
        val pos = target.getBlockPos() ?? BlockPos(target.hitVec.x, target.hitVec.y, target.hitVec.z);
        val range = this.getSettingValue('range');
        PacketHandler.INSTANCE.sendToAllAround(PacketFXFocusPartImpact(target.hitVec.x, target.hitVec.y, target.hitVec.z, [getKey()]), NetworkRegistry.TargetPoint(world.provider.getDimension(), target.hitVec.x, target.hitVec.y, target.hitVec.z, 64.0));

        var didSomething = false;
        for entity in world.wrapper.getEntities() {
            if (entity.native instanceof IEntityButterfly && entity.native.getDistanceSq(pos) < 250) {
                entity.position = pos.wrapper;
                didSomething = true;
            }
        }
        if (didSomething) world.playSound(null, pos, SoundEvents.ENTITY_ENDERMEN_TELEPORT, SoundCategory.AMBIENT, 1.0f, world.rand.nextFloat() * 0.4f + 0.8f);

        return didSomething;
    }

    function onCast(caster as Entity) {
        
    }

    //==================
    //Particle rendering
    //==================

    function renderParticleFX(world as World, posX as double, posY as double, posZ as double, motionX as double, motionY as double, motionZ as double) as void {
        if (!isNull(SpellFX.buttercatch)) SpellFX.buttercatch(this, world, posX, posY, posZ, motionX, motionY, motionZ);
    }

}
