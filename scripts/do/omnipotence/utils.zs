#modloaded zenutils
#priority 3000
#reloadable

import crafttweaker.player.IPlayer;
import crafttweaker.entity.AttributeModifier;

function setAttribute(player as IPlayer, id as string, uuid as string, value as double, operation as int = 0/* ADD */) as void {
  val attribute = player.getAttribute(id);
  val modifier = attribute.getModifier(uuid);
  if (isNull(modifier))
    attribute.applyModifier(AttributeModifier.createModifier('Omnipotence', value, operation, uuid));
}

function remAttribute(player as IPlayer, id as string, uuid as string) as void {
  val attribute = player.getAttribute(id);
  attribute.removeModifier(uuid);
}

function grantAdvancement(player as IPlayer, id as string) as void {
  server.commandManager.executeCommandSilent(server, '/advancement grant @p only ' ~ id);
}
