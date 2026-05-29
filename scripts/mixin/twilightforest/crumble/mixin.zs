#modloaded twilightforest
#loader mixin

import mixin.CallbackInfoReturnable;
import native.net.minecraft.entity.EntityLivingBase;
import native.net.minecraft.item.ItemStack;
import native.net.minecraft.util.math.BlockPos;
import native.net.minecraft.world.World;

// Mixin replaces the hardcoded Crumble Horn logic
// with an extensible handler system + fallback for hand-minable blocks.
//
// Original horn worked from a hardcoded table: specific blocks -> specific results.
// Now any mod can register its own crumble handler,
// and if none match, the block breaks as if mined by hand (when possible).
//
// Architecture:
//   shared.zs    — bridge: list of handlers [function(World, BlockPos, IBlockState, EntityLivingBase, ItemStack)bool]
//   exnihilo.zs  — registers an ExNihiloCreatio hammer recipe handler
//   mixin.zs     — entry point: calls handlers in order, then fallback
#mixin {targets: "twilightforest.item.ItemTFCrumbleHorn"}
zenClass MixinItemTFCrumbleHorn {
  #mixin Inject {method: "crumbleBlock", at: {value: "HEAD"}, cancellable: true}
  function injectCrumble(stack as ItemStack, world as World, living as EntityLivingBase, pos as BlockPos, cir as CallbackInfoReturnable) as void {
    // Preserve original chance: 1/5 (20%) to attempt a crumble.
    // Original: private static final int CHANCE_CRUMBLE = 5
    if (world.rand.nextInt(5) != 0) return;

    val handlers = scripts.mixin.twilightforest.crumble.shared.CrumbleOp.handlers;
    if (handlers.length == 0) return;

    val state = world.getBlockState(pos);
    if (state.block.isAir(state, world, pos)) return;

    for handler in handlers {
      if (handler(world, pos, state, living, stack)) {
        this0.postTrigger(living, stack, world, pos);
        cir.setReturnValue(true);
        return;
      }
    }
  }
}
