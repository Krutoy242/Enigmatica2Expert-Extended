/*

  Change Unstable Ingot recipe

  Taken from: https://github.com/DoremySwee/Art-of-Enigma/blob/2465b90209ced64f5a1ca65ffdd17b6d60e2206c/scripts/advanced/exu1sigils/UnstableIngotCrafting.zs

*/

#modloaded extrautils2
#norun

import crafttweaker.data.IData;
import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;
import crafttweaker.world.IWorld;

static tagName = 'unstableIngotContainerCounter';

function setPlayerContainerCounter(n as int, player as IPlayer) {
  val data as IData = createEmptyMutableDataMap;
  data.memberSet(tagName, n);
  player.update(data);
}

function getPlayerContainerCounter(player as IPlayer) as int {
  if (player.data in tagName) return player.data.memberGet(tagName).asInt();
  else return 0;
}

events.onPlayerLoggedIn(function (event as crafttweaker.event.PlayerLoggedInEvent) {
  setPlayerContainerCounter(0, event.player);
});

events.onPlayerRespawn(function (event as crafttweaker.event.PlayerRespawnEvent) {
  setPlayerContainerCounter(0, event.player);
});

events.onPlayerOpenContainer(function (event as crafttweaker.event.PlayerOpenContainerEvent) {
  val p as IPlayer = event.player;
  val w as IWorld = p.world;
  if (w.remote) return;
  setPlayerContainerCounter(1 + getPlayerContainerCounter(p), p);
});

function getUnstableIngot(p as IPlayer, w as IWorld) as IItemStack {
  return <extrautils2:unstableingots>.withTag({
    owner: {
      UUIDL: p.getUUIDObject().getLeastSignificantBits() as long,
      Name : p.name,
      UUIDU: p.getUUIDObject().getMostSignificantBits() as long,
    },
    container: getPlayerContainerCounter(p),
    dim      : w.getDimension(),
    time     : w.getWorldTime() as long,
  });
}

recipes.remove(<extrautils2:unstableingots>);
recipes.addShaped('unstable_ingot_unstable', <extrautils2:unstableingots>, [
  [null, <minecraft:diamond>, null],
  [null, <contenttweaker:division_sigil_activated>.anyDamage().transformDamage(), null],
  [null, <minecraft:iron_ingot>, null]],
function (out, ins, info) {
  if (isNull(info.player)) return null;
  return out;
}, function (out, cInfo, player) {
  if (isNull(player)) out.mutable().shrink(1);
  out.mutable().withTag(getUnstableIngot(player, player.world).tag);
});
