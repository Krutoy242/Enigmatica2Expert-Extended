#sideonly client
#reloadable
#priority -1500
#modloaded botania scalinghealth

import mods.randomtweaker.botania.IBotaniaFXHelper;
import mods.zenutils.NetworkHandler;
import crafttweaker.util.Math;
import crafttweaker.world.IWorld;
import crafttweaker.data.IData;

static PI2 as double = 6.283185307179586;

function showStarAndFlare(x as double,y as double,z as double, sizeMultiplier as double = 1.0) as void {
  IBotaniaFXHelper.sparkleFX(
    x, y, z, // position
    1, 0.8, 0, // color
    Math.min(20.0, Math.max(0.25, sizeMultiplier * 4)), // size
    60, // life
    false);
  IBotaniaFXHelper.wispFX(
    x, y, z, // position
    1, 0.8, 0, // color
    Math.min(5.0, Math.max(0.1, sizeMultiplier * 0.5)), // size
    0, 0.05, 0, // motion
    2.0 // life
  );
}

function playAcquireSound(world as IWorld, vectorData as IData, volume as float, pitch as float) as void {
  world.playSound('botania:potioncreate', 'ambient',
    crafttweaker.util.Position3f.create(vectorData.x, vectorData.y, vectorData.z),
    volume, pitch, true);
}

NetworkHandler.registerServer2ClientMessage('acquire', function(player, byteBuf) {
  val data = byteBuf.readData();
  val value = isNull(data.value) ? 1.0 : data.value;

  val sqrtValue = Math.sqrt(value);
  val particleAmount = sqrtValue + 4;
  for i in 0 .. particleAmount {
    val angle = i as double / particleAmount * PI2;
    val x = data.x as double + Math.cos(angle);
    val z = data.z as double + Math.sin(angle);
    showStarAndFlare(x, data.y, z, sqrtValue);
  }

  playAcquireSound(player.world, data, sqrtValue / 64 + 0.1, 0.8 / (sqrtValue / 10 + 1));
});

NetworkHandler.registerServer2ClientMessage('acquire_star_and_flare', function(player, byteBuf) {
  val data = byteBuf.readData();
  val value = isNull(data.value) ? 1.0 : data.value;
  val sqrtValue = Math.sqrt(value);
  
  showStarAndFlare(data.x, data.y, data.z, sqrtValue);
  if (sqrtValue > 0.1) playAcquireSound(player.world, data, sqrtValue / 64 + 0.1, 0.5);
});
