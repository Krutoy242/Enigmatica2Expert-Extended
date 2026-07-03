#modloaded thaumcraft
#loader mixin

import mixin.CallbackInfo;
import native.net.minecraft.client.renderer.color.BlockColors;
import native.net.minecraft.client.renderer.color.IItemColor;
import native.net.minecraft.client.renderer.color.ItemColors;
import native.net.minecraft.item.ItemStack;
import native.net.minecraftforge.registries.IForgeRegistry;
import native.thaumcraft.common.items.casters.ItemFocus;

zenClass FocusTierFour {
    static focus4 as ItemFocus;
}

#mixin {targets: "thaumcraft.common.config.ConfigItems"}
zenClass MixinConfigItems {

    #mixin Static
    #mixin Inject {method: "initItems", at: {value: "TAIL"}}
    function onInitItems(registry as IForgeRegistry, ci as CallbackInfo) {
        FocusTierFour.focus4 = ItemFocus("focus_4", 100);
        registry.register(FocusTierFour.focus4);
    }
}

#mixin {targets: "thaumcraft.client.ColorHandler"}
zenClass MixinColorHandler {

    #mixin Static
    #mixin Inject {method: "registerItemColourHandlers", at: {value: "TAIL"}}
    function onRegisterItemColours(blockColors as BlockColors, itemColors as ItemColors, ci as CallbackInfo) {
        
        val itemFocusColourHandler as IItemColor = function(stack as ItemStack, tintIndex as int) as int {
            val item as ItemFocus = stack.getItem() as ItemFocus;
            val color as int = item.getFocusColor(stack);
            return color;
        };
        
        itemColors.registerItemColorHandler(itemFocusColourHandler, FocusTierFour.focus4);
    }
}
