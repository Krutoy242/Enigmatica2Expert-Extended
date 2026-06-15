#modloaded integratedtunnels
#loader mixin

#mixin { targets: 'org.cyclops.integratedtunnels.part.aspect.TunnelAspectWriteBuilders$Energy' }
zenClass MixinTunnelAspectWriteBuildersEnergy  {
  #mixin Static
  #mixin ModifyConstant { method: '<clinit>', constant: { intValue: 1000 } }
  function buffDefaultEnergyRate(value as int) as int {
    return 2147483647; // Integer.MAX_VALUE
  }
}