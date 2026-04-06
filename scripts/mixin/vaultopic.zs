#modloaded baubles vaultopic
#loader mixin

import native.baubles.api.BaubleType;
import native.baubles.api.BaublesApi;
import native.baubles.api.IBauble;
import native.net.minecraft.item.ItemStack;
import native.wolforce.vaultopic.ItemVICE;
import native.wolforce.vaultopic.ItemVIEW;
import native.wolforce.vaultopic.client.Keybinds;

#mixin {targets: "wolforce.vaultopic.ItemVICE"}
zenClass MixinItemVICEAsBauble extends IBauble {

    function getBaubleType(stack as ItemStack) as BaubleType {
        return BaubleType.TRINKET;
    }

}

//Client side logic searching player inventory for VICE item
#mixin {targets: "wolforce.vaultopic.client.Keybinds"}
zenClass MixinVICEInventorySearchForClient {
    #mixin Inject {method: "canVice", at: {value: "HEAD"}, cancellable: true}
    function canViceWithBaubles(player as native.net.minecraft.client.entity.EntityPlayerSP, info as mixin.CallbackInfoReturnable) as void {
        val baubles = BaublesApi.getBaubles(player);
        for i in 0 .. baubles.getSizeInventory() {
            val stack = baubles.getStackInSlot(i);
            if (!isNull(stack) && stack.getItem() instanceof ItemVICE) {
                info.setReturnValue(true);
                return;
            }
        }
    }
}

#mixin {targets: "wolforce.vaultopic.ItemVIEW"}
zenClass MixinItemVIEWAsBauble extends IBauble {

    function getBaubleType(stack as ItemStack) as BaubleType {
        return BaubleType.TRINKET;
    }

}

//Client side logic searching player inventory for VIEW item
#mixin {targets: "wolforce.vaultopic.client.Keybinds"}
zenClass MixinVIEWInventorySearchForClient {
    #mixin Inject {method: "canView", at: {value: "HEAD"}, cancellable: true}
    function canViceWithBaubles(player as native.net.minecraft.client.entity.EntityPlayerSP, info as mixin.CallbackInfoReturnable) as void {
        val baubles = BaublesApi.getBaubles(player);
        for i in 0 .. baubles.getSizeInventory() {
            val stack = baubles.getStackInSlot(i);
            if (!isNull(stack) && stack.getItem() instanceof ItemVIEW) {
                info.setReturnValue(true);
                return;
            }
        }
    }
}

//Server side logic
#mixin {targets: "wolforce.vaultopic.VU"}
zenClass MixinVICEPlayerHasItem {
    #mixin Static
    #mixin Overwrite
    function playerHasItem(player as native.net.minecraft.entity.player.EntityPlayer, item as native.net.minecraft.item.Item) as bool {

        for stack in player.inventory.offHandInventory {
            if (!isNull(stack) && stack.getItem() == item) return true;
        }

        for stack in player.inventory.mainInventory {
            if (!isNull(stack) && stack.getItem() == item) return true;
        }

        val baubles = BaublesApi.getBaubles(player);
        for i in 0 .. baubles.getSizeInventory() {
            val stack = baubles.getStackInSlot(i);
            if (!isNull(stack) && stack.getItem() == item) return true;
        }

        return false;
    }
}
