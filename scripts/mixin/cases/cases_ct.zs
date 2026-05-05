/*

Improving formatting of opening case messages,
allowing them to be used with message-repeating mods like MC2Discord

*/

#modloaded cases ftbquests
#reloadable

import crafttweaker.data.IData;
import native.com.mojang.authlib.GameProfile;
import native.net.minecraft.item.ItemStack;

scripts.mixin.common.shared.Op.casesGotItemMsg
= function (player as GameProfile, item as ItemStack) as void {
  val playerMP = server.getPlayerByUsername(player.name);
  val name = playerMP?.nickname() ?? player.name;
  val data as IData = [{
      text : '### `',
      extra: [
        {text: name, color: 'aqua'},
        '` has just opened a ',
        scripts.lib.tellraw.item(<ftbquests:lootcrate>.withTag({type: 'mythic'}).withDisplayName('Mythic'), 'light_purple'),
        ' 🟪 and got *［',
        scripts.lib.tellraw.item(item.wrapper, 'gold'),
        '］*',
      ],
      color: 'gray',
    }];
    val jsonText = data.toJson();
    server.commandManager.executeCommand(server, `/tellraw @a ${jsonText}`);
  };
