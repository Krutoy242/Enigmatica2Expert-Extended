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
    val verticalSpeedModifier = (player.native.capabilities.getFlySpeed() / 0.05F) * 1.5f;
    val verticalMotion = 0.1125f * verticalSpeedModifier;
    if (isJump && !isSneak) player.motionY = verticalMotion;
    if (isSneak && !isJump) player.motionY = -verticalMotion;
  }
});
