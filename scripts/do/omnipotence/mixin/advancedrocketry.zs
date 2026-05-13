#loader mixin
#modloaded zenutils scalinghealth advancedrocketry

import native.net.minecraft.entity.EntityLivingBase;
import native.net.minecraft.entity.player.EntityPlayer;
import native.net.silentchaos512.scalinghealth.utils.SHPlayerDataHandler;

#mixin { targets: 'zmaster587.advancedRocketry.atmosphere.AtmosphereNeedsSuit' }
zenClass MixinAtmosphereNeedsSuit {
  #mixin Inject { method: 'isImmune', at: { value: 'HEAD' }, cancellable: true }
  function omnipotentBreathAnywhere(entity as EntityLivingBase, cir as mixin.CallbackInfoReturnable) as void {
    if (entity instanceof EntityPlayer
            && SHPlayerDataHandler.get(entity as EntityPlayer).difficulty >= 1000.0
    ) {
      cir.setReturnValue(true);
    }
  }
}
