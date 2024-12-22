#priority 1
#reloadable

import crafttweaker.player.IPlayer;

zenClass Op {
  zenConstructor(){}
  
  var messageSended as bool[string] = {};
  var registered as bool = false;

  function register() as void {
    if (registered) return;
    registered = true;

    events.onPlayerLoggedIn(function (e as crafttweaker.event.PlayerLoggedInEvent) {
      if (e.player.world.remote) return;
      if(!isNull(this.messageSended[e.player.uuid])) return;

      e.player.world.catenation().sleep(20 * 20).then(function (world, ctx) {
        if(!isNull(this.messageSended[e.player.uuid])) return;
        e.player.sendRichTextMessage(crafttweaker.text.ITextComponent.fromTranslation('e2ee.warn.wrong_installation'));
        this.messageSended[e.player.uuid] = true;
      }).start();
    });
  }
}

static op as Op = Op();
