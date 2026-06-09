/*
Bridge that allows using zs reloadable functions inside mixins
*/
#modloaded botania
#loader mixin
#priority 100

import native.net.minecraft.tileentity.TileEntity;
import native.vazkii.botania.common.block.subtile.functional.SubTileLoonuim;

zenClass Op {
  // supertile is protected and lootTable is private in SubTileLoonuim,
  // so they must be forwarded from the mixin script.
  static looniumOnUpdate as function(SubTileLoonuim,TileEntity,string)void;
}
