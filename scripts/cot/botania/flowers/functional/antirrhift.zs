/* 
Antirrhift (Antirrhinum + Shift) - flower that speed's up mana transportation

While it is not exacly generating flower - it helps with generation of mana.
I need to set is a generating flower, to ensure binding to funtional spreader.
(funtional flower is binded to mana pool) In lexica botania it will be marked as functional flower! 
*/

#loader contenttweaker

import crafttweaker.data.IData;
import crafttweaker.util.Math;
import crafttweaker.world.IBlockPos;
import mods.contenttweaker.VanillaFactory;
import mods.randomtweaker.cote.BlockAdded;
import mods.randomtweaker.cote.ISubTileEntity;
import mods.randomtweaker.cote.ISubTileEntityFunctional;
import mods.randomtweaker.cote.SubTileEntityInGame;
import mods.zenutils.DataUpdateOperation.OVERWRITE;
import native.net.minecraft.world.World;
import native.net.minecraft.tileentity.TileEntity;
import native.vazkii.botania.common.block.tile.mana.TilePool;
import native.vazkii.botania.common.block.tile.mana.TileSpreader;

static manaTransportEfficiency as float = 0.8f;

var antirrhift = VanillaFactory.createSubTileGenerating("antirrhift", 0xffc8ff);
antirrhift.maxMana = 0;
antirrhift.passiveFlower = false;
antirrhift.range = 4;
antirrhift.onUpdate = function(subtile, world, pos) { 
    if(world.isRemote()) return;
    if(!subtile.isValidBinding()) return;
    //get mana buffer
    val nWorld = world as World;
    val manaBuffer = nWorld.getTileEntity(subtile.getBindingForCrT());
    if(!(manaBuffer instanceof TileSpreader)) return;
    val tileBuffer = manaBuffer as TileSpreader;
    if(isNull(tileBuffer.getBinding())) return;
    //get manapool
    val manaPool = nWorld.getTileEntity(tileBuffer.getBinding());
    if(!(manaPool instanceof TilePool)) return;
    val tilePool = manaPool as TilePool;
    if(tilePool.isFull()) return;
    //mana calculations
    val manaToAdd = manaTransportEfficiency * tileBuffer.getCurrentMana();
    val spaceInPool = tilePool.getAvailableSpaceForMana();
    if(manaToAdd > spaceInPool) return;
    //transport mana
    tilePool.recieveMana(manaToAdd);
    tileBuffer.recieveMana(-1*tileBuffer.getCurrentMana());
    return;
};
antirrhift.register();
