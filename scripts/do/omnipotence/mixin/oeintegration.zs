#loader mixin
#modloaded oeintegration scalinghealth

import native.oreexcavation.events.EventExcavate;
import native.net.silentchaos512.scalinghealth.utils.SHPlayerDataHandler;
import mixin.CallbackInfo;

#mixin {targets: "atm.bloodworkxgaming.oeintegration.Handler.EventHandler"}
zenClass MixinOmniOEEventHandler {
    #mixin Inject {method: "onExcavateEvent", at: {value: "HEAD"}, cancellable: true}
    function onExcavateEventHead(eventExcavate as EventExcavate.Pre, ci as CallbackInfo) as void {
        val player = eventExcavate.getAgent().player;
        if (!isNull(player)) {
            val data = SHPlayerDataHandler.get(player);
            if (!isNull(data) && data.difficulty >= 1000.0) {
                ci.cancel();
            }
        }
    }
}
