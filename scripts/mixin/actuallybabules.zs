#loader mixin

#mixin Mixin
#{targets: "me.jacky1356400.actuallybaubles.ActuallyBaubles"}
zenClass MixinActuallyBaubles {
    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "<clinit>",
    #    constant: [
    #       {intValue: 200000},
    #       {intValue: 1000},
    #       {intValue: 350000},
    #       {intValue: 5000},
    #       {intValue: 600000},
    #       {intValue: 10000},
    #       {intValue: 1000000},
    #       {intValue: 30000},
    #       {intValue: 2000000},
    #       {intValue: 100000}
    #    ]
    #}
    function buffBatteriesCapacity(value as int) as int {
        return value * 10;
    }
}
