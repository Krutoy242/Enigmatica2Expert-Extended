#priority 100
#modloaded thaumcraft

import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.util.Math;
import crafttweaker.world.IWorld;
import native.com.blamejared.compat.thaumcraft.handlers.ThaumCraft;
import native.net.minecraft.entity.Entity;
import native.net.minecraft.entity.player.EntityPlayer;
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
import native.thaumcraft.common.lib.network.fx.PacketFXEssentiaSource;
import native.thaumcraft.common.lib.network.fx.PacketFXFocusPartImpact;

zenClass SpellBlackout extends FocusEffect {

  zenConstructor() {
    super();
  }

  //======================
  //Set up some basic info
  //======================

  function getResearch() as string {
    return 'BLACKOUT';
  }
    
  function getKey() as string {
    return 'thaumcraft.BLACKOUT';
  }

  //===================================
  //Set up focalmanipulator spell stats
  //===================================
    
  function getAspect() as Aspect {
    return ThaumCraft.getAspect(Aspects('🌑')[0]);
  }

  function getComplexity() as int {
    return  5 * pow(2, this.getSettingValue('range'));
  }

  function createSettings() as NodeSetting[] {
    return [
      NodeSetting('range', 'focus.common.range',    NodeSetting.NodeSettingIntList( [1, 2, 3, 4], ['20', '40', '80', '160'])),
      NodeSetting('safe',  'focus.common.destroy',  NodeSetting.NodeSettingIntList([0, 1],        ['focus.common.no', 'focus.common.yes']))
    ];
  }

  //==========================
  //Set up executable function
  //==========================

  function execute(target as RayTraceResult, trajectory as Trajectory, finalPower as float, num as int) as bool {
    PacketHandler.INSTANCE.sendToAllAround(PacketFXFocusPartImpact(target.hitVec.x, target.hitVec.y, target.hitVec.z, [getKey()]), NetworkRegistry.TargetPoint(this.getPackage().world.provider.getDimension(), target.hitVec.x, target.hitVec.y, target.hitVec.z, 64.0));
    if(target.typeOfHit == RayTraceResult.Type.BLOCK && this.getPackage().getCaster() instanceof EntityPlayer){
      val player = this.getPackage().getCaster() as EntityPlayer;
      if (player.cooldownTracker.hasCooldown(<thaumcraft:caster_basic>.native.getItem())) return false;
      
      val world = this.getPackage().world;
      val range = 10 * pow(2, this.getSettingValue('range'));
      player.getEntityData().setInteger("BlackoutEffect", range);
      player.cooldownTracker.setCooldown(<thaumcraft:caster_basic>.native.getItem(), range);
      mods.zenutils.CatenationPersistence.startPersistedCatenation("blackoutMechanic", world)
        .withPosition(BlockPos(target.hitVec).wrapper)
        .withPlayer(player.wrapper)
        .start();
      return true;
    }
     
    if(!isNull(target.entityHit) && target.typeOfHit == RayTraceResult.Type.ENTITY){
      val entity = target.entityHit.wrapper;
      if(entity instanceof IEntityLivingBase){
        val entityLivingBase as IEntityLivingBase = entity;
        val potion = <potion:minecraft:blindness>;
        if(!entityLivingBase.isPotionActive(potion)) entityLivingBase.addPotionEffect(potion.makePotionEffect((finalPower * 200) as int, this.getSettingValue('range') - 1));
        return true;
      }
    }
    return false;
  }

  function onCast(caster as Entity) {
  }

  //==================
  //Particle rendering
  //==================

  function renderParticleFX(world as World, posX as double, posY as double, posZ as double, motionX as double, motionY as double, motionZ as double) as void {
    val fb as FXGeneric = FXGeneric(world, posX, posY, posZ, motionX * 0.5, motionY * 0.5, motionZ * 0.5);
    
    fb.setMaxAge(pow(2,this.getSettingValue('range')) * 200);
    fb.setRBGColorF(0.05f + world.rand.nextFloat() * 0.01, 0.05f + world.rand.nextFloat() * 0.01, 0.05f + world.rand.nextFloat() * 0.01);
    fb.setGridSize(16);
    fb.setParticles(72 + world.rand.nextInt(4), 1, 1);
    fb.setScale(20.0f + world.rand.nextFloat() * 4.0);
    fb.setLoop(false);
    fb.setSlowDown(0.8);
    fb.setGravity(0.0f);
    fb.setRotationSpeed(world.rand.nextFloat(), 0.1f);
    
    ParticleEngine.addEffectWithDelay(world, fb, world.rand.nextInt(4));
  }
}

mods.zenutils.CatenationPersistence.registerPersistedCatenation("blackoutMechanic")
  .setCatenationFactory(function(world) {
    return world.catenation().sleepUntil( 
      function(world, context){
        //if(world.time % 10 != 0) return false;
        val startX = context.getPosition().x;
        val startY = context.getPosition().y;
        val startZ = context.getPosition().z;
        val player = context.getPlayer().native;

        if(isNull(player)) return true;
        
        val range = player.getEntityData().getInteger("BlackoutEffect");
        val rangeStep = 1;

        for x in (range * -1) .. range {
          for z in 0 .. (Math.sqrt(range*range - x*x) as int + 1) {
            for y in (Math.min(255 - startY, Math.sqrt((range - rangeStep)*(range - rangeStep) - x*x - z*z) as int) + 1) .. Math.min(255 - startY, Math.sqrt(range*range - x*x - z*z) as int + 1) {
              destroyIfLight(BlockPos(startX + x, startY + y, startZ + z), world, startX, startY, startZ);
              destroyIfLight(BlockPos(startX + x, startY + y, startZ - z), world, startX, startY, startZ);
            } 

            for y in (Math.min(startY, Math.sqrt((range - rangeStep)*(range - rangeStep) - x*x - z*z) as int) + 1) .. Math.min(startY, Math.sqrt(range*range - x*x - z*z) as int + 1) {
              destroyIfLight(BlockPos(startX + x, startY - y, startZ + z), world, startX, startY, startZ);
              destroyIfLight(BlockPos(startX + x, startY - y, startZ - z), world, startX, startY, startZ);
            }
          }
        }

        for x in (range * -1) .. range {
          for z in (Math.sqrt((range - rangeStep)*(range - rangeStep) - x*x) as int) .. (Math.sqrt(range*range - x*x) as int + 1) {
            destroyIfLight(BlockPos(startX + x, startY, startZ + z), world, startX, startY, startZ);
            destroyIfLight(BlockPos(startX + x, startY, startZ - z), world, startX, startY, startZ);
          }
        }

        if(range - rangeStep < 0) return true;
        player.getEntityData().setInteger("BlackoutEffect", range - rangeStep);
        return false;
    }).onStop(function(world, context){
        val player = context.getPlayer();
        if(!isNull(player)) player.native.getEntityData().removeTag("BlackoutEffect");
    }).start();
    })
  .addPositionHolder()
  .addPlayerHolder()
.register();

function destroyIfLight(pos as BlockPos, world as IWorld, startX as int, startY as int, startZ as int) as void{
  val blockState = world.native.getBlockState(pos);
  val block = blockState.getBlock();
  if(blockState.getLightOpacity(world.native, pos) == 0 && block.getDefaultState().getLightValue() > 5 && blockState.getBlockHardness(world.native, pos) < 10) {
    world.native.setBlockToAir(pos);
    world.native.playSound(null, pos, SoundsTC.wind, SoundCategory.AMBIENT, 1.0f, world.random.nextFloat() * 0.4f + 0.8f);
    PacketHandler.INSTANCE.sendToAllAround(
    PacketFXEssentiaSource(BlockPos(startX, startY, startZ), startX - pos.getX(), startY - pos.getY(), startZ - pos.getZ() , 16777113, 20),
    NetworkRegistry.TargetPoint(world.native.provider.getDimension(), pos.getX(), pos.getY(), pos.getZ(), 32.0));
  }
}
