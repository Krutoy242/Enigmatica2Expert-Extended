#modloaded thaumcraft
#priority 999
#sideonly client

import native.net.minecraft.world.World;
import native.thaumcraft.api.casters.FocusEffect;
import native.thaumcraft.client.fx.ParticleEngine;
import native.thaumcraft.client.fx.particles.FXGeneric;
import scripts.mods.thaumcraft.spellCreation.spellFX.SpellFX;

/*
  Client-only particle rendering for the Thaumcraft spells.
  Bodies are the original renderParticleFX contents, moved here so the
  dedicated server never parses the client-only FXGeneric / ParticleEngine
  natives. See spellFX.zs for the why.
*/

SpellFX.apiaryAcceleration = function(effect as FocusEffect, world as World, posX as double, posY as double, posZ as double, motionX as double, motionY as double, motionZ as double) as void {
  val fb as FXGeneric = FXGeneric(world, posX, posY, posZ, motionX, motionY, motionZ);
  fb.setMaxAge(8);
  fb.setRBGColorF(0.95f + world.rand.nextFloat() * 0.05f, 0.95f + world.rand.nextFloat() * 0.05f, 0.0f + world.rand.nextFloat() * 0.05f);
  fb.setGridSize(16);
  fb.setParticles(72 + world.rand.nextInt(4), 1, 1);
  fb.setScale(2.0 + world.rand.nextFloat() * 4.0);
  fb.setLoop(false);
  fb.setSlowDown(0.9);
  fb.setGravity(0.0);
  fb.setRotationSpeed(world.rand.nextFloat(), 0.0);
  ParticleEngine.addEffectWithDelay(world, fb, world.rand.nextInt(4));
};

SpellFX.blackout = function(effect as FocusEffect, world as World, posX as double, posY as double, posZ as double, motionX as double, motionY as double, motionZ as double) as void {
  val fb as FXGeneric = FXGeneric(world, posX, posY, posZ, motionX * 0.5, motionY * 0.5, motionZ * 0.5);
  fb.setMaxAge(pow(2, effect.getSettingValue('range')) * 200);
  fb.setRBGColorF(0.05f + world.rand.nextFloat() * 0.01, 0.05f + world.rand.nextFloat() * 0.01, 0.05f + world.rand.nextFloat() * 0.01);
  fb.setGridSize(16);
  fb.setParticles(72 + world.rand.nextInt(4), 1, 1);
  fb.setScale(20.0f + world.rand.nextFloat() * 4.0);
  fb.setLoop(false);
  fb.setSlowDown(0.8);
  fb.setGravity(0.0f);
  fb.setRotationSpeed(world.rand.nextFloat(), 0.1f);
  ParticleEngine.addEffectWithDelay(world, fb, world.rand.nextInt(4));
};

SpellFX.bloomia = function(effect as FocusEffect, world as World, posX as double, posY as double, posZ as double, motionX as double, motionY as double, motionZ as double) as void {
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
};

SpellFX.buttercatch = function(effect as FocusEffect, world as World, posX as double, posY as double, posZ as double, motionX as double, motionY as double, motionZ as double) as void {
  val fb as FXGeneric = FXGeneric(world, posX, posY, posZ, motionX, motionY, motionZ);
  fb.setMaxAge(8);
  fb.setRBGColorF(0.784f + (world.rand.nextFloat() - 0.5f) * 0.05f, 0.784f + (world.rand.nextFloat() - 0.5f) * 0.05f, 0.784f + (world.rand.nextFloat() - 0.5f) * 0.05f);
  fb.setGridSize(16);
  fb.setParticles(72 + world.rand.nextInt(4), 1, 1);
  fb.setScale(2.0 + world.rand.nextFloat() * 4.0);
  fb.setLoop(false);
  fb.setSlowDown(0.9);
  fb.setGravity(0.0);
  fb.setRotationSpeed(world.rand.nextFloat(), 0.0);
  ParticleEngine.addEffectWithDelay(world, fb, world.rand.nextInt(4));
};

SpellFX.chronostasis = function(effect as FocusEffect, world as World, posX as double, posY as double, posZ as double, motionX as double, motionY as double, motionZ as double) as void {
  val fb as FXGeneric = FXGeneric(world, posX, posY, posZ, motionX * 0.5, motionY * 0.5, motionZ * 0.5);
  fb.setMaxAge(50);
  fb.setRBGColorF(0.095f + world.rand.nextFloat() * 0.01f, 0.095f + world.rand.nextFloat() * 0.01f, 0.435f + world.rand.nextFloat() * 0.01f);
  fb.setGridSize(16);
  fb.setParticles(72 + world.rand.nextInt(4), 1, 1);
  fb.setScale(20.0f + world.rand.nextFloat() * 4.0);
  fb.setLoop(false);
  fb.setSlowDown(0.8);
  fb.setGravity(0.0f);
  fb.setRotationSpeed(world.rand.nextFloat(), 0.1f);
  ParticleEngine.addEffectWithDelay(world, fb, world.rand.nextInt(4));
};

SpellFX.crossbreed = function(effect as FocusEffect, world as World, posX as double, posY as double, posZ as double, motionX as double, motionY as double, motionZ as double) as void {
  val fb as FXGeneric = FXGeneric(world, posX, posY, posZ, motionX, motionY, motionZ);
  fb.setMaxAge(8);
  fb.setRBGColorF(0.863f + (world.rand.nextFloat() - 0.5f) * 0.05f, 0.698f + (world.rand.nextFloat() - 0.5f) * 0.05f, 0.314f + (world.rand.nextFloat() - 0.5f) * 0.05f);
  fb.setGridSize(16);
  fb.setParticles(72 + world.rand.nextInt(4), 1, 1);
  fb.setScale(2.0 + world.rand.nextFloat() * 4.0);
  fb.setLoop(false);
  fb.setSlowDown(0.9);
  fb.setGravity(0.0);
  fb.setRotationSpeed(world.rand.nextFloat(), 0.0);
  ParticleEngine.addEffectWithDelay(world, fb, world.rand.nextInt(4));
};

SpellFX.crystalize = function(effect as FocusEffect, world as World, posX as double, posY as double, posZ as double, motionX as double, motionY as double, motionZ as double) as void {
  val fb as FXGeneric = FXGeneric(world, posX, posY, posZ, motionX, motionY, motionZ);
  fb.setMaxAge(8);
  fb.setRBGColorF(0.863f + (world.rand.nextFloat() - 0.5f) * 0.05f, 0.698f + (world.rand.nextFloat() - 0.5f) * 0.05f, 0.314f + (world.rand.nextFloat() - 0.5f) * 0.05f);
  fb.setGridSize(16);
  fb.setParticles(72 + world.rand.nextInt(4), 1, 1);
  fb.setScale(2.0 + world.rand.nextFloat() * 4.0);
  fb.setLoop(false);
  fb.setSlowDown(0.9);
  fb.setGravity(0.0);
  fb.setRotationSpeed(world.rand.nextFloat(), 0.0);
  ParticleEngine.addEffectWithDelay(world, fb, world.rand.nextInt(4));
};

SpellFX.efreetFlame = function(effect as FocusEffect, world as World, posX as double, posY as double, posZ as double, motionX as double, motionY as double, motionZ as double) as void {
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
};

SpellFX.enderRift = function(effect as FocusEffect, world as World, posX as double, posY as double, posZ as double, motionX as double, motionY as double, motionZ as double) as void {
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
};

SpellFX.explosion = function(effect as FocusEffect, world as World, posX as double, posY as double, posZ as double, motionX as double, motionY as double, motionZ as double) as void {
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
};

SpellFX.feralis = function(effect as FocusEffect, world as World, posX as double, posY as double, posZ as double, motionX as double, motionY as double, motionZ as double) as void {
  val fb as FXGeneric = FXGeneric(world, posX, posY, posZ, motionX, motionY, motionZ);
  fb.setMaxAge(8);
  fb.setRBGColorF(0.863f + (world.rand.nextFloat() - 0.5f) * 0.05f, 0.698f + (world.rand.nextFloat() - 0.5f) * 0.05f, 0.314f + (world.rand.nextFloat() - 0.5f) * 0.05f);
  fb.setGridSize(16);
  fb.setParticles(72 + world.rand.nextInt(4), 1, 1);
  fb.setScale(2.0 + world.rand.nextFloat() * 4.0);
  fb.setLoop(false);
  fb.setSlowDown(0.9);
  fb.setGravity(0.0);
  fb.setRotationSpeed(world.rand.nextFloat(), 0.0);
  ParticleEngine.addEffectWithDelay(world, fb, world.rand.nextInt(4));
};

SpellFX.vampirysm = function(effect as FocusEffect, world as World, posX as double, posY as double, posZ as double, motionX as double, motionY as double, motionZ as double) as void {
  val fb as FXGeneric = FXGeneric(world, posX, posY, posZ, motionX, motionY, motionZ);
  fb.setMaxAge(8);
  fb.setRBGColorF(0.47 + world.rand.nextFloat() * 0.05, 0.07 + world.rand.nextFloat() * 0.02, 0.07 + world.rand.nextFloat() * 0.02);
  fb.setGridSize(16);
  fb.setParticles(72 + world.rand.nextInt(4), 1, 1);
  fb.setScale(2.0 + world.rand.nextFloat() * 4.0);
  fb.setLoop(false);
  fb.setSlowDown(0.9);
  fb.setGravity(0.0);
  fb.setRotationSpeed(world.rand.nextFloat(), 0.0);
  ParticleEngine.addEffectWithDelay(world, fb, world.rand.nextInt(4));
};
