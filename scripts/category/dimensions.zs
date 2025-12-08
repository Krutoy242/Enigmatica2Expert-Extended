#modloaded gamestages ftbquests
#reloadable

import crafttweaker.player.IPlayer;
import crafttweaker.text.ITextComponent.fromTranslation;

static health_require as float = 30.0f;

// Check health and add game stage allowing to enter nether
function checkAndGrant(player as IPlayer) as void {
  if (player.maxHealth >= health_require || player.health >= health_require)
    grant(player, true);
}

function grant(player as IPlayer, byHealth as bool = false) as void {
  if (player.hasGameStage('skyblock') || player.hasGameStage('healthy')) return;

  player.addGameStage('healthy');
  if (byHealth) player.sendRichTextMessage(fromTranslation(
    'tooltips.dim_stages.healthy_grant',
    health_require as int,
    (health_require / 2.0f + 0.5f) as int
  ));
  player.sendRichTextMessage(fromTranslation('tooltips.dim_stages.healthy_can'));
}

events.register(function (e as mods.zenutils.ftbq.QuestCompletedEvent) {
  if (isNull(e.quest) || isNull(e.quest.tags) || e.quest.tags.length < 1 || !(e.quest.tags has 'cobalt')) return;
  for player in e.notifyPlayers {
    grant(player);
  }
});

events.onPlayerTick(function (e as crafttweaker.event.PlayerTickEvent) {
  if (e.player.world.remote) return;
  if (e.player.world.getWorldTime() % 10 != 0) return;

  checkAndGrant(e.player);
});

function isForbidTravel(player as IPlayer, dimension as int) as bool {
  checkAndGrant(player);
  if (player.creative) return false;

  val isNether = dimension == -1;
  if (player.hasGameStage('skyblock')) {
    // Show message that player playing skyblock and cant visit any dims
    if (!isAllowedDim(dimension)) {
      player.sendRichTextMessage(fromTranslation('tooltips.dim_stages.restricted'));
      return true;
    }
  }
  else {
    if (isNether && !player.hasGameStage('healthy')) {
      // Show message that player not healthy anough
      player.sendRichTextMessage(fromTranslation(
        'tooltips.dim_stages.healthy',
        health_require as int,
        (health_require / 2.0f + 0.5f) as int
      ));
      return true;
    }
  }

  return false;
}

// Allow listed dimensions and any of RFTools dimensions
static allowedDims as int[] = [
  144, // Compact machines
  -343800852, // Spectre
  2, // Storage Cell
  -2, // Space
  3, // Skyblock
];
function isAllowedDim(dimId as int) as bool {
  if (allowedDims has dimId) return true;
  val providerType = native.net.minecraftforge.common.DimensionManager.getProviderType(dimId);
  if(isNull(providerType)) return false;
  return toString(providerType.getName()) == 'rftools_dimension';
}

events.onEntityTravelToDimension(function (e as crafttweaker.event.EntityTravelToDimensionEvent) {
  if (e.entity.world.remote) return;
  if (!e.entity instanceof IPlayer) return;
  val player as IPlayer = e.entity;
  if (isForbidTravel(player, e.dimension)) e.cancel();
});

// Additional level of protection against unsanctioned traveling methods (like deep dark portal)
events.onPlayerChangedDimension(function (e as crafttweaker.event.PlayerChangedDimensionEvent) {
  if (e.entity.world.remote) return;
  if (!e.player.creative && isForbidTravel(e.player, e.to)) {
    e.player.world.catenation().sleep(20).then(function (world, ctx) {
      server.commandManager.executeCommandSilent(server, '/tpx ' ~ e.player.name ~ ' 3');
      if (!isNull(e.player))
        e.player.addPotionEffect(<potion:cyclicmagic:potion.slowfall>.makePotionEffect(40, 0));
    }).start();
  }
});
