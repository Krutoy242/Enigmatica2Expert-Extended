#modloaded opencomputers
#loader mixin

import native.mezz.jei.api.recipe.IRecipeCategoryRegistration;
import native.mezz.jei.api.IModRegistry;

#mixin { targets: 'li.cil.oc.integration.opencomputers.DriverUpgradeTank$' }
zenClass MixinDriverUpgradeTank {
  #mixin ModifyConstant { method: 'createEnvironment', constant: { intValue: 16000 } }
  function modifyCapacity(value as int) as int {
    return 2000000000;
  }
}

#mixin { targets: 'li.cil.oc.server.component.UpgradeTractorBeam$Common' }
zenClass MixinUpgradeTractorBeam {
  #mixin Static
  #mixin ModifyConstant { method: '<init>', constant: { intValue: 3 } }
  function modifyPickupRadius(value as int) as int {
    return 16;
  }
}

#mixin { targets: 'li.cil.oc.server.machine.luac.LuaStateFactory' }
zenClass MixinLuaStateFactory {
  #mixin Inject { method: 'init', at: { value: 'HEAD' }, cancellable: true }
  function skipUnusedLibs(ci as mixin.CallbackInfo) as void {
    if (this0.version() as string != '53') ci.cancel();
  }
}

#mixin { targets: 'li.cil.oc.integration.jei.ModPluginOpenComputers' }
zenClass MixinModPluginOpenComputers {
  #mixin Overwrite
  function registerCategories(registry as IRecipeCategoryRegistration) as void {
    // NO-OP
  }
}

#mixin { targets: 'li.cil.oc.integration.jei.ManualUsageHandler$' }
zenClass MixinManualUsageHandler {
  #mixin Overwrite
  function getRecipes(registry as IModRegistry) as [any] {
    return [];
  }
}

#mixin { targets: 'li.cil.oc.integration.jei.CallbackDocHandler$' }
zenClass MixinCallbackDocHandler {
  #mixin Overwrite
  function getRecipes(registry as IModRegistry) as [any] {
    return [];
  }
}
