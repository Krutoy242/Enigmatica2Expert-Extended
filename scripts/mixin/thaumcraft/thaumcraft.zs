#modloaded thaumcraft
#loader mixin

import native.net.minecraftforge.event.world.BlockEvent.HarvestDropsEvent;
import native.thaumcraft.common.lib.enchantment.EnumInfusionEnchantment;
import native.java.lang.Object;

#mixin {targets: "thaumcraft.common.tiles.devices.TileLampFertility"}
zenClass MixinTileLampFertility {
    #mixin ModifyConstant {method: "updateAnimals", constant: {intValue: 5}}
    function speedUpFluxSelfCleansing(value as int) as int {
        return 1;
    }
}

#mixin {targets: "thaumcraft.common.lib.events.ToolEvents"}
zenClass MixinToolEvents {
    #mixin Static
    #mixin Redirect
    #{
    #    method: "harvestBlockEvent",
    #    at: {
    #        value: "INVOKE",
    #        target: "Ljava/util/List;contains(Ljava/lang/Object;)Z",
    #        ordinal: 0
    #    }
    #}
    function buffRefining(list as [Object], obj as Object, event as HarvestDropsEvent) as bool {
        if (obj == EnumInfusionEnchantment.REFINING && (list has obj)) {
            val heldItem = event.harvester.getHeldItem(event.harvester.activeHand);
            scripts.mixin.thaumcraft.shared.Op.doRefining(event, heldItem);
        }
        return false;
    }
}
