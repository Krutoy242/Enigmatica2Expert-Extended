#loader mixin
#modloaded cases ftbquests

import native.net.minecraft.entity.player.EntityPlayer;
import native.net.minecraft.item.ItemStack;
import native.net.minecraft.nbt.NBTTagCompound;
import native.net.minecraft.util.EnumHand;
import native.net.minecraftforge.fml.common.network.simpleimpl.IMessage;
import native.net.minecraftforge.fml.common.network.simpleimpl.SimpleNetworkWrapper;
import native.ru.radviger.cases.network.message.MessagePlayerGotItem;
import native.ru.radviger.cases.Cases;

/*
Make it possible to use spin animation on other items
not only cases from the mod
*/
#mixin { targets: 'ru.radviger.cases.proxy.CommonProxy' }
zenClass MixinCommonProxy {
  var player as EntityPlayer = null;

  #mixin Redirect
  #{
  #  method: 'handleSpinStart',
  #  at    : {
  #    value : 'INVOKE',
  #    target: 'net/minecraft/entity/player/EntityPlayer.func_184586_b(Lnet/minecraft/util/EnumHand;)Lnet/minecraft/item/ItemStack;'
  #  }
  #}
  function alwaysReturnCorrectCase(player as EntityPlayer, hand as EnumHand) as ItemStack {
    this.player = player;
    val stack = ItemStack(Cases.ITEM_CASE);
    val tag = NBTTagCompound();
    tag.setString('caseName', 'mythic');
    stack.setTagCompound(tag);
    return stack;
  }

  #mixin Redirect
  #{
  #  method: 'handleSpinStart',
  #  at    : {
  #    value : 'INVOKE',
  #    target: 'net/minecraft/item/ItemStack.func_190918_g(I)V'
  #  }
  #}
  function alwaysConsumeHeldItem(item as ItemStack, amount as int) as void {
    val heldItem = player.getHeldItem(player.getActiveHand());
    heldItem.shrink(amount);
  }

  /*
    Allows messages about opening crate being visible from Discord and improve formatting
  */
  #mixin Redirect
  #{
  #  method: 'handleSpinDone',
  #  at    : {
  #    value : 'INVOKE',
  #    target: 'net/minecraftforge/fml/common/network/simpleimpl/SimpleNetworkWrapper.sendToAll(Lnet/minecraftforge/fml/common/network/simpleimpl/IMessage;)V'
  #  }
  #}
  function sendGlobalMessage(NET as SimpleNetworkWrapper, msg as IMessage) as void {
    val message = msg as MessagePlayerGotItem;
    scripts.mixin.common.shared.Op.casesGotItemMsg(message.player, message.result);
  }
}
