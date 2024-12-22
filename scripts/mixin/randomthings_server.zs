#modloaded randomthings
#loader mixin
#sideonly server

import native.net.minecraft.network.NetHandlerPlayServer;

// Fix player stall in the Spectre dimension after teleporting on servers
// https://github.com/ACGaming/UniversalTweaks/issues/460
#mixin {targets: "lumien.randomthings.handler.spectre.SpectreHandler"}
zenClass SpectreHandlerMixin {
  #mixin Redirect
  #{
  #    method: "checkPosition",
  #    at: {
  #       value: "INVOKE",
  #       target: "Lnet/minecraft/network/NetHandlerPlayServer;func_147364_a(DDDFF)V"
  #    }
  #}
  function fixSpectreTeleport(instance as NetHandlerPlayServer, x as double, y as double, z as double, yaw as float, pitch as float) as void {
    instance.player.setLocationAndAngles(x, y, z, yaw, pitch);
  }
}
