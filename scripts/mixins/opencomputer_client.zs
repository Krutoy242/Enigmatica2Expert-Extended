#loader mixin
#sideonly client

#mixin Mixin
#{targets: "li.cil.oc.common.item.UpgradeTank"}
zenClass MixinUpgradeTank {
    #mixin ModifyConstant
    #{
    #    method: "tooltipLines",
    #    constant: {stringValue: "/16000"}
    #}
    function modifyTooltip(value as string) as string {
        return "/20000000";
    }
}