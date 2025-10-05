/*
Antirrhift (Antirrhinum + Shift) - flower that speed's up mana transportation

While it is not exacly generating flower - it helps with generation of mana.
I need to set is a generating flower, to ensure binding to funtional spreader.
(funtional flower is binded to mana pool) In lexica botania it will be marked as functional flower!
*/

#modloaded botania
#loader contenttweaker

import mods.contenttweaker.VanillaFactory;
import native.net.minecraft.world.World;
import native.vazkii.botania.common.block.tile.mana.TilePool;
import native.vazkii.botania.common.block.tile.mana.TileSpreader;

static manaTransportEfficiency as float = 0.8f;

val antirrhift = VanillaFactory.createSubTileGenerating('antirrhift', 0xFFC8FF);
antirrhift.maxMana = 0;
antirrhift.passiveFlower = false;
antirrhift.range = 4;
antirrhift.onUpdate = function (subtile, world, pos) {
  if (world.remote) return;
  if (!subtile.isValidBinding()) return;
  // get mana buffer
  val nWorld = world as World;
  val manaBuffer = nWorld.getTileEntity(subtile.getBindingForCrT());
  if (!(manaBuffer instanceof TileSpreader)) return;
  val tileBuffer = manaBuffer as TileSpreader;
  if (isNull(tileBuffer.getBinding())) return;
  // get manapool
  val manaPool = nWorld.getTileEntity(tileBuffer.getBinding());
  if (!(manaPool instanceof TilePool)) return;
  val tilePool = manaPool as TilePool;
  if (tilePool.isFull()) return;
  // mana calculations
  val manaToAdd = manaTransportEfficiency * tileBuffer.getCurrentMana();
  val spaceInPool = tilePool.getAvailableSpaceForMana();
  if (manaToAdd > spaceInPool) return;
  // transport mana
  tilePool.recieveMana(manaToAdd);
  tileBuffer.recieveMana(-1 * tileBuffer.getCurrentMana());
};
antirrhift.register();
