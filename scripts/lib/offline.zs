/**
 *
 * Bunch of functions that allow save and load values from a player,
 * even if player not online.
 *
 * @author: Krutoy242
 *
 */

#priority 3000
#reloadable
#modloaded zenutils roidtweaker

import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.world.IWorld;
import crafttweaker.player.IPlayer;

// /////////////////////////////////////////////////////////////////////////////
zenClass WrappedFunc {
  var fnc as function(IPlayer,string)string;
  zenConstructor(fnc_ as function(IPlayer,string)string) { fnc = fnc_; }
}
zenClass WrappedFuncMap {
  val map as WrappedFunc[string] = {};
  zenConstructor() {}
  function set(key as string, fnc as function(IPlayer,string)string) as void {
    map[key] = WrappedFunc(fnc);
  }
}
// /////////////////////////////////////////////////////////////////////////////

zenClass Op {
  // Functions to get value from the player
  val getRegistry as WrappedFuncMap = WrappedFuncMap();
  val setRegistry as WrappedFuncMap = WrappedFuncMap();

  // ///////////////////////////////
  // Private
  // ///////////////////////////////
  zenConstructor() {
    // Apply saved data to joined player
    events.onPlayerLoggedIn(function (e as crafttweaker.event.PlayerLoggedInEvent) {
      if (e.player.world.remote) return;
      for key, fnc in setRegistry.map {
        val value = this.get(e.player.uuid, key);
        if(!isNull(value)) fnc.fnc(e.player, value);
      }
    });

    // Save data to logged out player
    events.onPlayerLoggedOut(function (e as crafttweaker.event.PlayerLoggedOutEvent) {
      if (e.player.world.remote) return;
      this.save(e.player);
    });

    // Emergency saving to prevent loss of data on server crash
    events.register(function (e as crafttweaker.event.PlayerTickEvent) {
      if (e.player.world.remote || e.phase != 'END' || e.player.world.time % 20 != 0) return;
      this.save(e.player);
    });
  }

  function save(player as IPlayer) as void {
    for key, fnc in getRegistry.map {
      set(player.uuid, key, fnc.fnc(player, null));
    }
  }

  // ///////////////////////////////
  // PUBLIC
  // ///////////////////////////////

  // Get value of specified player assuming he is offline
  function get(uuid as string, key as string, default as string = null, onFake as string = null) as string {
    if (isNull(uuid) || uuid == '') return default; // no player provided
    val owner = server.getPlayerByUUID(uuid);

    if (!isNull(owner)) {
      if (owner.fake) return onFake; // fake player
      return getRegistry.map[key].fnc(owner, null);
    }

    val overworld = IWorld.getFromID(0);
    val data = overworld.getCustomWorldData();
    if (isNull(data) || isNull(data.offline)) return default;
    val values = data.offline.memberGet(uuid);
    if (isNull(values)) return default;
    val value = values.memberGet(key);
    if (isNull(value)) return default;
    return value.asString();
  }

  // Set value for specified player, assuming he is offline
  function set(uuid as string, key as string, value as string) as void {
    if (isNull(uuid)) return; // no player provided
    val owner = server.getPlayerByUUID(uuid);
    if (!isNull(owner)) {
      setRegistry.map[key].fnc(owner, value);
      return;
    }

    val overworld = IWorld.getFromID(0);
    overworld.setCustomWorldData(overworld.getCustomWorldData().deepUpdate({
      offline: {
        [uuid]: {
          [key]: value
        },
      }
    }, mods.zenutils.DataUpdateOperation.MERGE));
  }
}

static op as Op = Op();