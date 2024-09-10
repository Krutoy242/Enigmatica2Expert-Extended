#loader mixin

#mixin Mixin
#{targets: "net.blay09.mods.excompressum.tile.TileAutoSieve"}
zenClass MixinTileAutoSieve {
    #mixin ModifyConstant
    #{
    #    method: "<init>",
    #    constant: {intValue: 32000}
    #}
    function buffBattery(value as int) as int {
        return 10000000;
    }
}
