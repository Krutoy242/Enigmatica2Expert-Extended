#modloaded thaumadditions
#loader mixin

import native.net.minecraft.entity.projectile.EntityThrowable;
import native.net.minecraft.item.Item;
import native.net.minecraft.item.ItemStack;
import native.net.minecraft.util.math.RayTraceResult;

/*
Remove how scythe handle collision and let it handle only by event menager
*/
#mixin {targets: "org.zeith.thaumicadditions.entity.EntityMithminiteScythe"}
zenClass MixinEntityMithminiteScythe extends EntityThrowable {
    // onImpact
    #mixin Overwrite
    function func_70184_a(result as RayTraceResult) as void {
        return;
    }
}

/*
Fix Mithminite Hood trying to mend unrepairable items.

Specifically fixes issue where it would downgrade CoFH Fluxbores.
Created by ChaosStrikez for Thaumic Additions 12.7.9.
https://github.com/jchung01/meatballcraft/blob/e40d3983b96270b346202a729e27030dff285ba7/scripts/mixin/thaumic_additions.zs

Permission granted to use script by ChaosStrikez & Sainagh (from MeatballCraft modpack)
*/
#mixin {targets: "org.zeith.thaumicadditions.events.LivingEventsTAR"}
zenClass MixinLivingEventsTAR {
  #mixin Redirect
  #{
  #  method: "pickupXP",
  #  at: {
  #    value: "INVOKE",
  #    target: "Lnet/minecraft/item/Item;isDamaged(Lnet/minecraft/item/ItemStack;)Z"
  #  }
  #}
  function checkRepairable(instance as Item, stack as ItemStack) as bool {
    return instance.isRepairable() && !stack.hasSubtypes && stack.isItemDamaged();
  }
}
