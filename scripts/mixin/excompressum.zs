#loader mixin

#mixin Mixin
#{targets: "net.blay09.mods.excompressum.tile.TileAutoSieve"}
zenClass MixinTileAutoSieve {
    #mixin ModifyConstant
    #{
    #    method: "<init>",
    #    constant: {intValue: 32000}
    #}
    function increaseCapacityAndConsumption(value as int) as int {
        return 10000000; // Consumption automatically calculated as `x/100`
    }
}
