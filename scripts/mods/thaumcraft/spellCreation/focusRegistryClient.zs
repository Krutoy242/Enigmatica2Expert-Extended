#modloaded thaumcraft
#loader mixin
#priority -100
#sideonly client

import mixin.CallbackInfo;
import native.net.minecraft.client.renderer.color.BlockColors;
import native.net.minecraft.client.renderer.color.IItemColor;
import native.net.minecraft.client.renderer.color.ItemColors;
import native.net.minecraft.item.ItemStack;
import native.thaumcraft.common.items.casters.ItemFocus;
import scripts.mods.thaumcraft.spellCreation.focusRegistry.FocusTierFour;

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
