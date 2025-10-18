#modloaded zenutils
#reloadable

import native.net.minecraftforge.event.entity.player.PlayerContainerEvent;
import native.net.minecraft.entity.player.EntityPlayerMP;

/**
 * Server-side whitelist for container classes. Any container class name matching these
 * regular expression patterns will be allowed to open. All others will be immediately closed.
 */
static whitelist as string[] = [
];

events.register(function (e as PlayerContainerEvent.Open) {
  val player = e.getEntityPlayer().wrapper;
  if (!player.hasGameStage('nogui')) return;
  
  // Ensure we are on the server
  if (isNull(player.world) || player.world.remote) return;

  val container = e.getContainer();
  if (isNull(container)) return;
  
  val containerClass = typeof(container);

  // 1. Whitelist Check: If the container class matches any pattern, allow it.
  for pattern in whitelist {
    if (containerClass.matches(pattern)) {
      return;
    }
  }

  // 2. Close: If it's not on the whitelist, close the container.
  utils.log('NoGUI (Server): Closing container ' ~ containerClass);
  
  // Cast to EntityPlayerMP to access server-side methods
  val playerMP = player.native as EntityPlayerMP;
  playerMP.closeContainer();
});
