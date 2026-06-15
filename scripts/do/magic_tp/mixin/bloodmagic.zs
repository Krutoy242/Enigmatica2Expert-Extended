#norun // unfinished feature
#modloaded bloodmagic
#loader mixin

import mixin.CallbackInfo;
import mixin.CallbackInfoReturnable;
import native.java.util.UUID;
import native.net.minecraft.block.state.IBlockState;
import native.net.minecraft.entity.Entity;
import native.net.minecraft.entity.player.EntityPlayer;
import native.net.minecraft.util.math.BlockPos;
import native.net.minecraft.world.World;
import native.WayofTime.bloodmagic.ritual.IMasterRitualStone;
import native.WayofTime.bloodmagic.teleport.PortalLocation;
import scripts.do.magic_tp.mixin.shared.Op;

/*
* Send 'exit not found' when a player enters a portal block with no linked destination.
* Cooldown per player (100 ticks) avoids spam every tick.
*/
#mixin { targets: 'WayofTime.bloodmagic.block.BlockDimensionalPortal' }
zenClass MixinBlockDimensionalPortal {
  #mixin Inject
  #{
  #  method: 'func_180634_a',
  #  at: { value: 'RETURN' }
  #}
  function portalCollideFeedback(world as World, pos as BlockPos, state as IBlockState, entity as Entity, ci as CallbackInfo) as void {
    Op.onPortalCollide(world, pos, entity);
  }
}

/*
* Store the activating player before RitualPortal.activateRitual() calls
* LocationsHandler.addLocation(), so the addLocation mixin can send feedback
* to the correct player.
*/
#mixin { targets: 'WayofTime.bloodmagic.ritual.types.RitualPortal' }
zenClass MixinRitualPortalActivate {
  #mixin Inject { method: 'activateRitual', at: { value: 'HEAD' } }
  function storePlayer(mrs as IMasterRitualStone, player as EntityPlayer, owner as UUID, cir as CallbackInfoReturnable) as void {
    Op.currentActivatingPlayer = player;
  }
}

/*
* When LocationsHandler.addLocation() successfully registers a new portal
* location and the linked set reaches size 2, the second side has been found.
* Notify the player who activated this ritual.
*/
#mixin { targets: 'WayofTime.bloodmagic.ritual.portal.LocationsHandler' }
zenClass MixinLocationsHandler {
  #mixin ModifyReturnValue
  #{
  #  method: 'addLocation',
  #  at: { value: 'RETURN' }
  #}
  function afterAddLocation(added as bool, name as string, loc as PortalLocation) as bool {
    if (added) {
      Op.onPortalLinked(name);
      Op.cachePortalKey(name);
    }
    return added;
  }
}

/*
* Track portal removal so the debug cache can stay in sync.
*/
#mixin { targets: 'WayofTime.bloodmagic.ritual.portal.LocationsHandler' }
zenClass MixinLocationsHandlerRemove {
  #mixin Inject
  #{
  #  method: 'removeLocation',
  #  at: { value: 'RETURN' }
  #}
  function afterRemoveLocation(name as string, loc as PortalLocation, cir as CallbackInfoReturnable) as void {
    // NO-OP
  }
}
