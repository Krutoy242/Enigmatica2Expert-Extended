/*
 * 🚫 NoGUI — block every inventory GUI while wearing the technicolor glasses.
 *
 * REQUIREMENTS (read before changing):
 *   - While the glasses are worn, NO GUI may open, *except* those matching the
 *     `whitelist` below (pause menu, JEI, configs, the player's own inventory, …).
 *     This must be class-based, NOT block-based: many inventories are not blocks
 *     (backpacks and other item-opened GUIs, hotkey GUIs, entity GUIs, …), so we
 *     gate on the GUI on the client, where every screen / container passes through
 *     regardless of how it was triggered.
 *   - It must NOT desync / scramble the player inventory.
 *   - The player gets a status (action-bar) message when a GUI is blocked.
 *
 * WHY THIS DESIGN (and why the obvious ones fail):
 *   - Reacting to PlayerContainerEvent.Open on the server and force-closing is too
 *     late: the server has already streamed SPacketWindowItems to the client.
 *   - A server-initiated close (EntityPlayerMP.closeContainer / closeScreen) leaves
 *     the client closing via `closeScreenAndDropStack`, which desyncs the open
 *     container's windowId and scrambles the inventory.
 *   - The ONLY close path that never scrambles is the normal, client-initiated one
 *     (the Esc key): EntityPlayerSP.closeScreen() sends CPacketCloseWindow and the
 *     server reacts through its regular processCloseWindow path.
 *   - Suppressing the render (GuiOpenEvent setGui(null)) removes the flicker but
 *     reliably scrambles the inventory, so we do not do it. A no-flicker close via
 *     Forge RenderTickEvent was also tried and does NOT fire here (ZenUtils' generic
 *     event bridge + native Phase enum compare never matches).
 *
 * HOW IT WORKS (the "flicker, but never scramble" trade-off):
 *   Every client tick (PlayerTickEvent END) we look at the LIVE state and, if a
 *   blocked GUI is up, close it through the normal Esc path. "Blocked" =
 *     - a real server container is open (openContainer.windowId != 0 — this catches
 *       backpacks, machines, entity / item GUIs, not just blocks), AND
 *     - the current screen, if any, is not whitelisted.
 *   The whitelisted client menus (pause, JEI, configs, own inventory) have windowId 0,
 *   so they are never touched.
 *
 *   We re-check LIVE state every tick instead of consuming a one-shot "pending close"
 *   flag. A flag is racy: clicking a block rapidly consumes/resets the flag before the
 *   re-opened container is ready, so that GUI slips through and stays open. Reading
 *   openContainer fresh every tick guarantees any blocked GUI — first open or rapid
 *   re-open — is closed the very next tick. The cost is a ~1 game-tick flicker, which
 *   is the price of never scrambling (the GUI must actually open and close normally so
 *   GuiContainer.onGuiClosed -> Container.onContainerClosed runs).
 *
 * Companion to the punch-to-extract feature (scripts/do/punch_inventory.zs): the
 * glasses make item-handling blocks "punch only" — left-click moves items, the GUI
 * never opens.
 */
#modloaded zenutils openblocks roidtweaker
#priority 3000
#sideonly client
#reloadable

import crafttweaker.player.IPlayer;
import native.net.minecraft.client.entity.EntityPlayerSP;
import native.net.minecraft.inventory.Container;
import native.net.minecraft.client.Minecraft.minecraft.currentScreen;
import crafttweaker.event.PlayerTickEvent;
import mods.zenutils.I18n;

// GUI class names (java regex, full-match) that stay openable while wearing the glasses.
static whitelist as string[] = [
  'net.minecraft.client.gui.Gui(?!Repair).+',          // vanilla menus / info screens (chat, pause, options, …)
  'net.minecraft.client.gui.Screen.+',
  'net.minecraftforge.fml.client.Gui.+',                // Forge config screens
  '.*scalingguis.*',
  '.*nutrition.*',
  'net.minecraft.client.gui.inventory.GuiInventory',   // the player's OWN inventory (needed to manage punched items)
];

function isWhitelisted(guiClass as string) as bool {
  for pattern in whitelist {
    if (guiClass.matches(pattern)) return true;
  }
  return false;
}

function isGlassesPlayer(player as IPlayer) as bool {
  if (isNull(player)) return false;
  if (player.creative) return false;                    // kept in line with the punch feature
  return scripts.lib.inventory.doesTheyWear(player, <openblocks:technicolor_glasses>);
}

// True while we are actively blocking, so the status message shows once per block
// episode instead of every tick. ZS statics are final (reassigning a primitive throws
// IllegalAccessError), so we flip a value inside a map instead.
static blocking as bool[string] = {} as bool[string];
static lastLog as string[string] = {} as string[string];

events.register(function (e as PlayerTickEvent) {
  if (e.phase != 'END') return;

  val player = client.player;
  if (!isGlassesPlayer(player)) { blocking['v'] = false; return; }

  // Read the open container fresh each tick (no stale flag, no rapid-click race).
  val openContainer as Container = player.native.openContainer;
  val hasServerContainer = !isNull(openContainer) && openContainer.windowId != 0;

  // Current screen lets the class whitelist allow a screen even over an open container.
  // If currentScreen is unavailable it just stays null and we fall back to windowId.
  val screen = currentScreen;
  if (!isNull(screen) && isWhitelisted(typeof(screen))) {
    blocking['v'] = false;
    if (utils.DEBUG) {
      val msgAllowed = '[nogui] ALLOWED ' ~ typeof(screen);
      if (isNull(lastLog['v']) || lastLog['v'] != msgAllowed) { lastLog['v'] = msgAllowed; print(msgAllowed); }
    }
    return;
  }

  // Whitelisted client menus (pause / JEI / configs / own inventory) have windowId 0,
  // so a real server container is what we block.
  if (!hasServerContainer) {
    blocking['v'] = false;
    if (utils.DEBUG) {
      val msgNoCont = '[nogui] ALLOWED (no server container, windowId=0)';
      if (isNull(lastLog['v']) || lastLog['v'] != msgNoCont) { lastLog['v'] = msgNoCont; print(msgNoCont); }
    }
    return;
  }

  // A non-whitelisted server container is open — close it via the normal Esc path.
  var screenInfo = '';
  if (!isNull(screen)) screenInfo = ' (' ~ typeof(screen) ~ ')';
  if (utils.DEBUG) {
    val msgBlocked = '[nogui] BLOCKED windowId ' ~ openContainer.windowId ~ screenInfo;
    if (isNull(lastLog['v']) || lastLog['v'] != msgBlocked) { lastLog['v'] = msgBlocked; print(msgBlocked); }
  }
  (player.native as EntityPlayerSP).closeScreen();

  val was = blocking['v'];
  if (isNull(was) || !was as bool) {
    player.sendStatusMessage(I18n.format('e2ee.nogui.blocked', <openblocks:technicolor_glasses>.displayName));
    // Client-local denial beep. IWorld.playSound (roidtweaker) maps to the
    // World.playSound(x,y,z,…,distanceDelay) overload that only WorldClient implements,
    // so it plays for the local player. (IPlayer.playSound excludes self;
    // IPlayer.sendPlaySoundPacket is server-only — neither works here.)
    player.world.playSound('mekanism:etc.error', 'player', player.position.asPosition3f(), 0.8f, 1.0f);
  }
  blocking['v'] = true;
});
