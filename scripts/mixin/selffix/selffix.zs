/*
Universal `self_fix` auto-repair.

Every bit of tinker tool/armor durability is spent through exactly one method:
  - tools : ToolHelper.damageTool(stack, amount, entity)  (mining, tilling, Tasty-eat,
            ranged, melee, abilities — see AoeToolCore/BowCore/TraitTasty/… all call it)
  - armor : ArmorHelper.damageArmor(stack, source, amount, player, slot)
By injecting at HEAD of those, we catch EVERY durability loss — including the right-click
abilities (mattock tilling, scythe, …) and Tasty eating that the trait's own onToolDamage
callback never sees. We forward to the #reloadable bridge (shared.Op) for the logic.

HEAD (not RETURN) so we repair *before* the loss is applied — the tool never actually
breaks, so no break sound/animation is emitted. For mattock tilling the vanilla hoe has
already flagged the tool Broken (silently, entity==null) before damageTool runs; the HEAD
hook un-breaks it before damageTool's `if(isBroken) return` bails.
*/
#modloaded tconstruct conarm
#loader mixin

import native.net.minecraft.item.ItemStack;
import native.net.minecraft.entity.EntityLivingBase;
import native.net.minecraft.entity.player.EntityPlayer;
import native.net.minecraft.util.DamageSource;
import mixin.CallbackInfo;

#mixin { targets: 'slimeknights.tconstruct.library.utils.ToolHelper' }
zenClass MixinToolHelper {
  #mixin Static
  #mixin Inject { method: 'damageTool', at: { value: 'HEAD' } }
  function selfFix(stack as ItemStack, amount as int, entity as EntityLivingBase, ci as CallbackInfo) as void {
    scripts.mixin.selffix.shared.Op.onToolDamage(stack, amount, entity);
  }
}

#mixin { targets: 'c4.conarm.common.armor.utils.ArmorHelper' }
zenClass MixinArmorHelper {
  #mixin Static
  #mixin Inject
  #{
  #  method: 'damageArmor(Lnet/minecraft/item/ItemStack;Lnet/minecraft/util/DamageSource;ILnet/minecraft/entity/player/EntityPlayer;I)V',
  #  at: { value: 'HEAD' }
  #}
  function selfFix(stack as ItemStack, source as DamageSource, amount as int, player as EntityPlayer, slot as int, ci as CallbackInfo) as void {
    scripts.mixin.selffix.shared.Op.onArmorDamage(stack, amount, player, slot);
  }
}
