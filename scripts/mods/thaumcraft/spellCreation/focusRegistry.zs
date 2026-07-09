#modloaded thaumcraft
#loader mixin

import mixin.CallbackInfo;
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
