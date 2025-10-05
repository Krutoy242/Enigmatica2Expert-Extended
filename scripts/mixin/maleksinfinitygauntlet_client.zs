#modloaded maleksinfinitygauntlet itemborders
#loader mixin
#sideonly client

import native.net.minecraft.item.ItemStack;
import native.net.minecraftforge.fml.common.registry.ForgeRegistries;
import mixin.CallbackInfoReturnable;

#mixin {targets: "com.anthonyhilyard.itemborders.util.Selectors"}
zenClass MixinSelectors {
    #mixin Static
    #mixin Inject {method: "itemMatches", at: {value: "HEAD"}, cancellable: true}
    function skipIfItemUnregistered(item as ItemStack, selector as string, cir as CallbackInfoReturnable) as void {
        if (isNull(item) || isNull(ForgeRegistries.ITEMS.getKey(item.getItem()))) {
            cir.setReturnValue(false);
        }
    }
}
