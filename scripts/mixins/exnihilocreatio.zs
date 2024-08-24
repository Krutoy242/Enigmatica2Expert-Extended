#loader mixin

import native.java.lang.Integer;
import native.net.minecraft.world.WorldProvider;

#mixin Mixin
#{targets: "exnihilocreatio.modules.forestry.registry.HiveRequirements"}
zenClass MixinHiveRequirements {
    #mixin Shadow
    var dimension as Integer;

    #mixin Redirect
    #{
    #   method: "check",
    #   at: {
    #       value: "INVOKE",
    #       target: "Lnet/minecraft/world/WorldProvider;getDimension()I"
    #   }
    #}
    function removeDimCheck(provider as WorldProvider) as int {
        return dimension as int;
    }
}
