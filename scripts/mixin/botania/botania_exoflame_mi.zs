#modloaded botania magicultureintegrations
#loader mixin

import mixin.CallbackInfo;
import native.net.minecraft.tileentity.TileEntity;
import native.net.minecraft.util.math.BlockPos;
import native.net.minecraft.world.World;
import native.com.invadermonky.magicultureintegrations.api.tile.IHeatableTile;
import native.com.invadermonky.magicultureintegrations.api.tile.IBoostableTile;

// Boost MI-compatible tiles to 10x speed.
// MI injects a synthetic handler into SubTileExoflame.onUpdate. Standard Mixin
// injection points (ModifyConstant, WrapOperation, ModifyArg) cannot target
// instructions inside synthetic methods created by other mixins, so we apply
// the extra +4 cook time at TAIL of onUpdate (on top of MI's +1).
#mixin { targets: 'vazkii.botania.common.block.subtile.functional.SubTileExoflame' }
zenClass MixinSubTileExoflameMI {
  #mixin Inject
  #{
  #  method: 'onUpdate',
  #  at: { value: 'TAIL' }
  #}
  function boostMITiles(ci as CallbackInfo) as void {
    // MI and vanilla both boost every 2 ticks
    if (this0.ticksExisted % 2 != 0) return;
    if (this0.mana <= 2) return;

    val world = this0.supertile.func_145831_w() as World;
    val center = this0.getPos() as BlockPos;

    for x in -5 .. 6 {
      for y in -2 .. 3 {
        for z in -5 .. 6 {
          val tile = world.func_175625_s(center.func_177982_a(x, y, z));
          if (isNull(tile)) continue;

          // IHeatableTile: MI already applied +1, add +4 more
          if (tile instanceof IHeatableTile) {
            val heatable = tile as IHeatableTile;
            if (heatable.canSmeltHeatable() && heatable.getBurnTimeHeatable() > 0) {
              heatable.boostCookTimeHeatable(4);
              heatable.updateTileHeatable();
            }
          }

          // IBoostableTile: MI already applied +1, add +4 more
          if (tile instanceof IBoostableTile) {
            val boostable = tile as IBoostableTile;
            if (boostable.canSmeltBoostable()) {
              boostable.boostCookTimeBoostable(4);
              boostable.updateTileBoostable();
            }
          }
        }
      }
    }
  }
}
