#modloaded thaumcraft thaumicwonders thaumicaugmentation thaumictinkerer
#loader mixin

import native.thaumcraft.api.aspects.Aspect;
import mixin.CallbackInfoReturnable;

#mixin {targets: "thecodex6824.thaumicaugmentation.common.item.foci.FocusEffectVoidShield"}
zenClass MixinFocusEffectVoidShield {
    #mixin Inject {method: "getAspect", at: {value: "HEAD"}, cancellable: true}
    function changeAspect(cir as CallbackInfoReturnable) as void {
        cir.setReturnValue(Aspect.getAspect("caeles"));
    }
}

#mixin {targets: "thaumcraft.common.items.casters.foci.FocusEffectRift"}
zenClass MixinFocusEffectRift {
    #mixin Inject {method: "getAspect", at: {value: "HEAD"}, cancellable: true}
    function changeAspect(cir as CallbackInfoReturnable) as void {
        cir.setReturnValue(Aspect.getAspect("vacuos"));
    }
}

#mixin {targets: "com.verdantartifice.thaumicwonders.common.items.foci.FocusEffectTeleportHome"}
zenClass MixinFocusEffectTeleportHome {
    #mixin Inject {method: "getAspect", at: {value: "HEAD"}, cancellable: true}
    function changeAspect(cir as CallbackInfoReturnable) as void {
        cir.setReturnValue(Aspect.getAspect("humanus"));
    }
}

#mixin {targets: "com.github.sokyranthedragon.mia.integrations.thaumcraft.foci.FocusEffectSizeChange"}
zenClass MixinFocusEffectSizeChange {
    #mixin Inject {method: "getAspect", at: {value: "HEAD"}, cancellable: true}
    function changeAspect(cir as CallbackInfoReturnable) as void {
        cir.setReturnValue(Aspect.getAspect("mythus"));
    }
}

#mixin {targets: "com.github.sokyranthedragon.mia.integrations.thaumcraft.foci.FocusEffectSizeSteal"}
zenClass MixinFocusEffectSizeSteal {

    #mixin Inject {method: "getAspect", at: {value: "HEAD"}, cancellable: true}
    function changeAspect(cir as CallbackInfoReturnable) as void {
        cir.setReturnValue(Aspect.getAspect("mythus"));
    }
}
