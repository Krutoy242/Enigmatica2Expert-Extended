#modloaded integratedtunnels
#loader mixin

/*
Increase default energy transfer rate in Energy Exporters/Importers
from 1000 to Integer.MAX_VALUE so players don't have to manually
set it each time
*/
#mixin { targets: 'org.cyclops.integratedtunnels.part.aspect.TunnelAspectWriteBuilders$Energy' }
zenClass MixinTunnelAspectWriteBuilders_Energy {
  #mixin Static
  #mixin ModifyConstant
  #{
  #  method: '<clinit>',
  #  constant: { intValue: 1000 }
  #}
  function maxEnergyRate(value as int) as int {
    return 2147483647;
  }
}
