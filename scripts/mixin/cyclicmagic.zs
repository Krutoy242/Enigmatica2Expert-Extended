#modloaded cyclicmagic
#loader mixin

import mixin.CallbackInfo;
import native.com.lothrazar.cyclicmagic.block.autouser.TileEntityUser;

#mixin {targets: "com.lothrazar.cyclicmagic.block.forester.TileEntityForester"}
zenClass MixinTileEntityForester {
    #mixin Inject {method: "func_73660_a", at: {value: "HEAD"}, cancellable: true}
    function delayUpdate(ci as mixin.CallbackInfo) as void {
        if(this0.world.getTotalWorldTime() % 11 != 0)
            ci.cancel();
    }
}

/*
Fix User always have shortest use delay after placement,
ignoring AutoUserSmallestTick config option.
*/
#mixin {targets: "com.lothrazar.cyclicmagic.block.autouser.TileEntityUser"}
zenClass MixinTileEntityUser {
    #mixin Inject {method: "<init>", at: {value: "RETURN"}}
    function setInitialTickDelay(ci as CallbackInfo) as void {
        this0.tickDelay = TileEntityUser.MIN_SPEED;
        // this0.timer = this0.tickDelay;
    }
}
