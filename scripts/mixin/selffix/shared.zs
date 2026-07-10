/*
Bridge for the universal `self_fix` auto-repair.

The mixin (selffix.zs) injects into the single durability choke points
(ToolHelper.damageTool / ArmorHelper.damageArmor) and forwards here. The actual
repair logic is assigned in the #reloadable script, so it can be iterated with
`/ct reload` without restarting the game.
*/
#modloaded tconstruct conarm
#loader mixin
#priority 3000

import native.net.minecraft.item.ItemStack;
import native.net.minecraft.entity.EntityLivingBase;
import native.net.minecraft.entity.player.EntityPlayer;

zenClass Op {
  static onToolDamage as function(ItemStack,int,EntityLivingBase)void;
  static onArmorDamage as function(ItemStack,int,EntityPlayer,int)void;
}
