#priority 100
#modloaded thaumcraft

import native.com.blamejared.compat.thaumcraft.handlers.ThaumCraft;
import native.net.minecraft.block.Block;
import native.net.minecraft.entity.Entity;
import native.net.minecraft.entity.player.EntityPlayer;
import native.net.minecraft.util.ResourceLocation;
import native.net.minecraft.util.SoundCategory;
import native.net.minecraft.util.SoundEvent;
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
import native.thaumcraft.common.lib.network.PacketHandler;
import native.thaumcraft.common.lib.network.fx.PacketFXFocusPartImpact;
import native.net.minecraft.item.ItemBlock;
import native.net.minecraft.item.ItemStack;
import native.net.minecraft.item.crafting.FurnaceRecipes;
import native.net.minecraft.init.SoundEvents;

zenClass SpellEfreetFlame extends FocusEffect {

  zenConstructor() {
    super();
  }

  //======================
  //Set up some basic info
  //======================

  function getResearch() as string {
    return 'EFREET_FLAME';
  }
    
  function getKey() as string {
    return 'thaumcraft.EFREET_FLAME';
  }

  //===================================
  //Set up focalmanipulator spell stats
  //===================================
    
  function getAspect() as Aspect {
    return ThaumCraft.getAspect(Aspects('🧨')[0]);
  }

  function getComplexity() as int {
    return  5;
  }

  function createSettings() as NodeSetting[] {
    return [];
  }

  //==========================
  //Set up executable function
  //==========================

  function execute(target as RayTraceResult, trajectory as Trajectory, finalPower as float, num as int) as bool {
    PacketHandler.INSTANCE.sendToAllAround(PacketFXFocusPartImpact(target.hitVec.x, target.hitVec.y, target.hitVec.z, [getKey()]), NetworkRegistry.TargetPoint(this.getPackage().world.provider.getDimension(), target.hitVec.x, target.hitVec.y, target.hitVec.z, 64.0));
    val world = this.getPackage().world;
    if(target.typeOfHit == RayTraceResult.Type.BLOCK){
    val pos = target.getBlockPos();
    val state = world.getBlockState(pos);
    val blockStack = ItemStack(state.getBlock(), 1, state.getBlock().getMetaFromState(state));
    val result = FurnaceRecipes.instance().getSmeltingResult(blockStack);
      if(!result.isEmpty() && result.getItem() instanceof ItemBlock) {
        world.setBlockState(pos, Block.getBlockFromItem(result.getItem()).getStateFromMeta(result.getItemDamage()), 3);
        world.playSound(null, pos, SoundEvents.ITEM_FLINTANDSTEEL_USE, SoundCategory.BLOCKS, 0.6f, 1.0f);
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
    val fb as FXGeneric = FXGeneric(world, posX, posY, posZ, motionX, motionY, motionZ);
    
    fb.setMaxAge(8); 
    fb.setRBGColorF(0.4706f + (world.rand.nextFloat() - 0.5f) * 0.05f, 0.4706f + (world.rand.nextFloat() - 0.5f) * 0.05f, 0.4706f + (world.rand.nextFloat() - 0.5f) * 0.05f);
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
