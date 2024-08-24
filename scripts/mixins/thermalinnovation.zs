#loader mixin

#mixin Mixin
#{targets: "cofh.thermalinnovation.item.ItemDrill"}
zenClass MixinItemDrill {
    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "<clint>",
    #    constant: {intValue: 2, ordinal: 1}
    #}
    function buffMiningLevel0(value as int) as int {
        return 6;
    }

    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "<clint>",
    #    constant: {intValue: 2, ordinal: 2}
    #}
    function buffMiningLevel1(value as int) as int {
        return 7;
    }

    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "<clint>",
    #    constant: {intValue: 3, ordinal: 1}
    #}
    function buffMiningLevel2(value as int) as int {
        return 8;
    }

    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "<clint>",
    #    constant: {intValue: 3, ordinal: 2}
    #}
    function buffMiningLevel3(value as int) as int {
        return 9;
    }

    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "<clint>",
    #    constant: {intValue: 4, ordinal: 1}
    #}
    function buffMiningLevel4(value as int) as int {
        return 10;
    }
}