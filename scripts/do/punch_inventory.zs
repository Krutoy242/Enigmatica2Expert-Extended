/*
 *
 * ✊ Punch any inventory block to extract/insert items
 *
 * Inspired by Cyclic's "Stardew Furnace" feature. Unlike the original
 * (furnace-only via TileEntityFurnace instanceof check), works with
 * any block that exposes an IItemHandler capability.
 *
 * Cyclic references:
 *   - Event handler:
 *     PlayerAbilitiesModule.java:192 – onLeftClickBlock()
 *     https://github.com/Lothrazar/Cyclic/blob/trunk/1.12/src/main/java/com/lothrazar/cyclicmagic/playerupgrade/PlayerAbilitiesModule.java#L192
 *   - Output extraction:
 *     UtilFurnace.java:75 – extractFurnaceOutput()
 *     https://github.com/Lothrazar/Cyclic/blob/trunk/1.12/src/main/java/com/lothrazar/cyclicmagic/util/UtilFurnace.java#L75
 *   - Item insertion:
 *     UtilFurnace.java:42 – tryMergeStackIntoSlot()
 *     https://github.com/Lothrazar/Cyclic/blob/trunk/1.12/src/main/java/com/lothrazar/cyclicmagic/util/UtilFurnace.java#L42
 *
 * Behaviour differences from Cyclic:
 *   - Works with any IItemHandler block, not just TileEntityFurnace.
 *
 */

#modloaded zenutils
#modloaded openblocks
#priority 3000
#reloadable

import crafttweaker.world.IBlockPos;
import crafttweaker.world.IFacing;
import crafttweaker.world.IWorld;
import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;

val COOLDOWN_TICKS = 2;
static lastActionTime as long[string] = {} as long[string];

events.register(function (event as native.net.minecraftforge.event.entity.player.PlayerInteractEvent.LeftClickBlock) {
  val player = event.entityPlayer as IPlayer;

  // Skip fake / creative players
  if (player.fake || player.creative) return;

  // Only works while wearing technicolor glasses
  if (!scripts.lib.inventory.doesTheyWear(player, <openblocks:technicolor_glasses>)) return;

  val world = event.world as IWorld;

  // Only server-side
  if (world.remote) return;

  val pos  = IBlockPos.create(event.pos.x, event.pos.y, event.pos.z);
  val face = event.face as IFacing;

  val handler = world.getItemHandler(pos, face);
  if (isNull(handler)) return;

  // Prevent repeated activation while holding LMB
  val uuid = player.uuid;
  val currentTime = world.worldInfo.worldTotalTime;
  val lastTime = lastActionTime[uuid];
  if (!isNull(lastTime) && currentTime - lastTime < COOLDOWN_TICKS) {
    event.setCanceled(true);
    return;
  }

  val heldStack = event.itemStack as IItemStack;

  if (isNull(heldStack) || heldStack.isEmpty) {
    // --- Empty hand → extract every slot into player inventory ---
    var extractedAny = false;
    for i in 0 .. handler.size {
      val extracted = handler.extractItem(i, 2147483647, false);
      if (isNull(extracted) || extracted.isEmpty) continue;
      player.give(extracted);
      extractedAny = true;
    }

    // Only react (sound + cancel block damage) when something was taken,
    // so an empty inventory can still be mined normally while sneaking.
    if (extractedAny) {
      player.sendPlaySoundPacket('minecraft:entity.item.pickup', 'player', player.position, 0.5f, 1.0f);
      lastActionTime[uuid] = currentTime;
      event.setCanceled(true);
    }
  }
  else {
    // --- Item in hand → insert into the inventory ---
    val remaining = handler.insertItem(heldStack, false);
    val insertedAny = isNull(remaining) || remaining.isEmpty || remaining.amount < heldStack.amount;

    if (insertedAny) {
      val mainHand = native.net.minecraft.inventory.EntityEquipmentSlot.MAINHAND;
      if (isNull(remaining) || remaining.isEmpty) {
        val Empty = native.net.minecraft.item.ItemStack.field_190927_a;
        event.entityPlayer.setItemStackToSlot(mainHand, Empty);
      }
      else {
        event.entityPlayer.setItemStackToSlot(mainHand, remaining);
      }
      player.sendPlaySoundPacket('minecraft:entity.item.pickup', 'player', player.position, 0.5f, 1.0f);
      lastActionTime[uuid] = currentTime;
      event.setCanceled(true);
    }
  }
});
