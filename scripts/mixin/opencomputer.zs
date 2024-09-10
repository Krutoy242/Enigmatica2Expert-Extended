#loader mixin

#mixin Mixin
#{targets: "li.cil.oc.integration.opencomputers.DriverUpgradeTank$"}
zenClass MixinDriverUpgradeTank {
    #mixin ModifyConstant
    #{
    #    method: "createEnvironment",
    #    constant: {intValue: 16000}
    #}
    function modifyCapacity(value as int) as int {
        return 20000000;
    }
}

#mixin Mixin
#{targets: "li.cil.oc.server.component.UpgradeTractorBeam$Common"}
zenClass MixinUpgradeTractorBeam {
    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "<init>",
    #    constant: {intValue: 3}
    #}
    function modifyPickupRadius(value as int) as int {
        return 16;
    }
}

