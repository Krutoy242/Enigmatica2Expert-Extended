#reloadable
#modloaded zenutils

import crafttweaker.player.IPlayer;

val op as scripts.do.omnipotence.op.Op = scripts.do.omnipotence.op.op;

op.regAttribute('generic.reachDistance', '31f40f75-5c35-4154-89ea-d8024f208034', 5);
op.regAttribute('generic.knockbackResistance', 'de6fd305-c216-4d0e-8d5b-020534e22789', 1);
op.regAttribute('generic.movementSpeed', 'e6d2ed1e-243d-4684-bd9e-268b7c35153a', 0.1);
op.regAttribute('forge.swimSpeed', '9c1f6fe8-94ed-46ce-9307-6647900ae6ad', 2);
op.regAttribute('generic.attackDamage', '8acc3dda-1db0-466b-9acc-8c7453683fe0', 999);
op.regAttribute('generic.maxHealth', '41347cf8-4f1f-4694-a20f-c65769d9148b', 200);
// TODO: Add step assist

op.onGrant(function(player as IPlayer) as void {
  if (player.world.remote) return;

  player.native.capabilities.allowFlying = true;
  player.native.capabilities.isFlying = true;
  player.native.sendPlayerAbilities();

  server.commandManager.executeCommandSilent(server, '/tellraw @a ["# `' ~ player.nickname()
    ~ '` just reached the §e**§lOmnipotence§e**§r ```Congrats!```'
    ~ '"]');
});

op.onRevoke(function(player as IPlayer) as void {
  if (player.world.remote) return;

  player.native.capabilities.allowFlying = false;
  player.native.capabilities.isFlying = false;
  player.native.sendPlayerAbilities();

  server.commandManager.executeCommandSilent(server, '/tellraw @a ["`' ~ player.nickname()
    ~ '` just lost the §e*§lOmnipotence§e*§r'
    ~ '"]');
});

op.onTick(function(player as IPlayer) as void {
  if (player.world.remote) return;
  if (player.foodStats.foodLevel < 19) player.foodStats.addStats(1, 0.1);
  player.heal(10.0f);

  // Keep flying when player wear off items that gives flying
  player.native.capabilities.allowFlying = true;
  player.native.sendPlayerAbilities();
});
