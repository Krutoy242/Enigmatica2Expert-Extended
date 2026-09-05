#modloaded chisel
#loader mixin
#sideonly client

import native.net.minecraft.block.Block;
import native.net.minecraft.block.state.IBlockState;
import native.net.minecraft.util.EnumFacing;
import native.net.minecraft.util.math.BlockPos;
import native.net.minecraft.world.World;

/*

Chisel feeds a *block* id into `ParticleDigging$Factory`, which expects a
*blockstate* id (`blockId | meta << 12`). Harmless in vanilla, but
RoughlyEnoughIDs lifts the 4096 block id cap, so anything above it decodes into
an unrelated block and crashes — chiselling Quark's varied bookshelves landed on
`ic2:dynamite` with an illegal `facing`.

*/
#mixin { targets: 'team.chisel.client.util.ClientUtil' }
zenClass MixinClientUtil {
  #mixin Static
  #mixin Redirect
  #{
  #  method: 'addDestroyEffects(Lnet/minecraft/world/World;Lnet/minecraft/util/math/BlockPos;Lnet/minecraft/block/state/IBlockState;)V',
  #  at: {
  #    value: 'INVOKE',
  #    target: 'Lnet/minecraft/block/Block;func_149682_b(Lnet/minecraft/block/Block;)I'
  #  }
  #}
  function destroyEffectStateId(block as Block, world as World, pos as BlockPos, state as IBlockState) as int {
    return Block.getStateId(state);
  }

  #mixin Static
  #mixin Redirect
  #{
  #  method: 'addHitEffects(Lnet/minecraft/world/World;Lnet/minecraft/util/math/BlockPos;Lnet/minecraft/util/EnumFacing;)V',
  #  at: {
  #    value: 'INVOKE',
  #    target: 'Lnet/minecraft/block/Block;func_149682_b(Lnet/minecraft/block/Block;)I'
  #  }
  #}
  function hitEffectStateId(block as Block, world as World, pos as BlockPos, side as EnumFacing) as int {
    return Block.getStateId(world.getBlockState(pos));
  }
}
