#modloaded mia
#loader mixin

import native.net.minecraft.entity.player.EntityPlayer;

// This mixin prevents the mod "Minor Integrations & Additions" from changing player's step height.
#mixin {targets: "com.github.sokyranthedragon.mia.events.Size_BaseEvents"}
zenClass MixinSize_BaseEvents_StepHeight {
    #mixin Static
    #mixin Redirect
    #{
    #    method: "onPlayerTickFirst",
    #    at: {
    #        value: "FIELD",
    #        target: "Lnet/minecraft/entity/player/EntityPlayer;field_70138_W:F",
    #        opcode: 181
    #    }
    #}
    function onPlayerTickFirst_removeStepHeightChange(player as EntityPlayer, value as float) as void {
        // NO-OP
    }

    #mixin Static
    #mixin Redirect
    #{
    #    method: "onPlayerTick",
    #    at: {
    #        value: "FIELD",
    #        target: "Lnet/minecraft/entity/player/EntityPlayer;field_70138_W:F",
    #        opcode: 181
    #    }
    #}
    function onPlayerTick_removeStepHeightChange(player as EntityPlayer, value as float) as void {
        // NO-OP
    }
}
