#loader mixin

#mixin Mixin
#{targets: "cofh.thermalinnovation.item.ItemDrill"}
zenClass MixinItemDrill {
    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "<clinit>",
    #    constant: {intValue: 2, ordinal: 0}
    #}
    function buffMiningLevel0(value as int) as int {
        return 6;
    }

    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "<clinit>",
    #    constant: {intValue: 2, ordinal: 1}
    #}
    function buffMiningLevel1(value as int) as int {
        return 7;
    }

    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "<clinit>",
    #    constant: {intValue: 3, ordinal: 0}
    #}
    function buffMiningLevel2(value as int) as int {
        return 8;
    }

    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "<clinit>",
    #    constant: {intValue: 3, ordinal: 2}
    #}
    function buffMiningLevel3(value as int) as int {
        return 9;
    }

    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "<clinit>",
    #    constant: {intValue: 4, ordinal: 1}
    #}
    function buffMiningLevel4(value as int) as int {
        return 10;
    }
}