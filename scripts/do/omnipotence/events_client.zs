#sideonly client
#reloadable
#modloaded zenutils

import crafttweaker.event.PlayerTickEvent;
import native.net.minecraft.client.Minecraft.minecraft.gameSettings;

val op as scripts.do.omnipotence.op.Op = scripts.do.omnipotence.op.op;

events.register(function (e as PlayerTickEvent) {
  if (e.phase != 'END' || !e.player.world.remote) return;

  val player = e.player;

  if (!op.isPlayerOmnipotent(player)) return;

  // Inertia cancellation
  if (player.moveForward == 0 && player.moveStrafing == 0 && player.native.capabilities.isFlying) {
    player.motionX *= 0.5;
    player.motionZ *= 0.5;
  }

  // Vertical boost
  if (!player.onGround && player.native.capabilities.isFlying && player.motionY != 0) {
    val isJump = gameSettings.keyBindJump.isKeyDown();
    val isSneak = gameSettings.keyBindSneak.isKeyDown();
    if (isJump && !isSneak) player.motionY = 0.225f * 1.5f;
    if (isSneak && !isJump) player.motionY = -0.225f * 1.5f;
  }
});
