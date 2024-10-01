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

static manaTransportEfficiency as float = 0.8f;

var antirrhift = VanillaFactory.createSubTileGenerating("antirrhift", 0xffc8ff);
antirrhift.maxMana = 0;
antirrhift.passiveFlower = false;
antirrhift.range = 4;
antirrhift.onUpdate = function(subtile, world, pos) { 
    if(world.isRemote()) return;
    if(!subtile.isValidBinding()) return;
    //get mana buffer
    val manaBufferPos = subtile.getBindingForCrT();
    val manaBuffer = world.getBlock(manaBufferPos);
    if(manaBuffer.data.forceClientBindingY == -1) return;
    //get manapool
    val manaPoolPos = toBlockPos(manaBuffer.data.forceClientBindingX, manaBuffer.data.forceClientBindingY, manaBuffer.data.forceClientBindingZ);
    val manaPool = world.getBlock(manaPoolPos);
    if(isNull(manaPool.data.manaCap)) return;
    if(manaPool.data.manaCap == manaPool.data.mana) return;
    //mana calculations
    val manaToAdd = manaTransportEfficiency * manaBuffer.data.mana;
    val newManaInPool = Math.min((manaPool.data.manaCap)  as int , (manaToAdd + manaPool.data.mana)  as int );
    val manaToReturn = (((manaToAdd + manaPool.data.mana - newManaInPool) as float) / manaTransportEfficiency) as int;
    //Update manapool
    world.setBlockState(world.getBlockState(manaPoolPos), manaPool.data.deepUpdate({mana : newManaInPool},{mana : OVERWRITE}), manaPoolPos);
    //Update mana buffer
    world.setBlockState(world.getBlockState(manaBufferPos), manaBuffer.data.deepUpdate({mana : manaToReturn},{mana : OVERWRITE}), manaBufferPos);
    return;
};
antirrhift.register();

function toBlockPos(x as int, y  as int, z  as int) as IBlockPos{
    return crafttweaker.util.Position3f.create(x, y, z) as IBlockPos;
}
