#modloaded randomthings
#reloadable

/**
 * Floo Network – fireplace name display
 *
 * On right-click of a Floo Brick (master):
 *  – shows the full fireplace name with scrambled chars,
 *    ~50% of them obfuscated (§k)
 *  – output in action bar (above hotbar) instead of chat
 *  – green SPELL_MOB particles at the clicked block
 */

import crafttweaker.event.PlayerInteractBlockEvent;
import crafttweaker.util.IRandom;
import native.lumien.randomthings.tileentity.TileEntityFlooBrick;
import native.lumien.randomthings.handler.floo.FlooNetworkHandler;
import native.net.minecraft.util.EnumParticleTypes;

// Scrambles chars and obfuscates ~50% of them
function scrambleName(name as string, rand as IRandom) as string {
  val len = name.length();
  if (len <= 1) return name;

  // Build index list, Fisher-Yates shuffle
  val idx = [] as [int];
  for i in 0 .. len {
    idx.add(i);
  }
  var i = len - 1;
  while i > 0 {
    idx.swap(i, rand.nextInt(i + 1));
    i -= 1;
  }

  // Build result: obfuscated chars with §k, rest as-is
  var result = '§2';  // white color
  for i in 0 .. len {
    val ch = name.substring(idx[i], idx[i] + 1);
    if (rand.nextInt(2) == 0) {
      result ~= '§k' ~ ch ~ '§r§2';
    }
    else {
      result ~= ch;
    }
  }
  result ~= '§r';
  return '☐ ' ~ result ~ ' §2☐';
}

events.register(function (e as PlayerInteractBlockEvent) {
  // Main hand only – avoid double-fire
  if (e.hand != 'MAIN_HAND') return;
  if (e.world.isRemote()) return;
  if (isNull(e.block) || e.block.definition.id != 'randomthings:floobrick') return;

  val te = e.world.native.getTileEntity(e.position.native);
  if (te instanceof TileEntityFlooBrick) {
    val flooTe = te as TileEntityFlooBrick;
    val uuid = flooTe.getFirePlaceUid();
    if (!isNull(uuid)) {
      val handler = FlooNetworkHandler.get(e.world.native);
      if (!isNull(handler)) {
        val name = handler.getNameFromUUID(uuid);
        if (!isNull(name) && name.length() > 0) {
          // Show scrambled name above hotbar
          val msg = scrambleName(name, e.world.random);
          e.player.sendStatusMessage(format.darkGreen(msg), true);

          // Green SPELL_MOB particle at block center
          (e.world.native as native.net.minecraft.world.WorldServer).spawnParticle(
            EnumParticleTypes.SPELL_MOB,
            0.5 + e.position.x,
            1.0 + e.position.y,
            0.5 + e.position.z,
            10, 0.5, 0, 0.5, 0,
            [0, 255, 0]
          );

          // Sharp flame whoosh sound
          e.player.sendPlaySoundPacket('minecraft:entity.blaze.shoot', 'ambient', e.position, 0.5f, 2.0f);
        }
      }
    }
  }
});
