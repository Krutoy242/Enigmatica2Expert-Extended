#loader mixin

#mixin Mixin
#{targets: "de.ellpeck.actuallyadditions.mod.items.InitItems"}
zenClass MixinInitItems {
    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "init",
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
    function buffBattery(value as int) as int {
        return value * 10;
    }
}

#mixin Mixin
#{targets: "de.ellpeck.actuallyadditions.mod.items.ItemFillingWand"}
zenClass MixinItemFillWand {
    #mixin ModifyConstant
    #{
    #    method: "func_77663_a",
    #    constant: {intValue: 1500}
    #}
    function lessEnergyConsumption(value as int) as int {
        return 100;
    }
}

#mixin Mixin
#{targets: "de.ellpeck.actuallyadditions.mod.items.ItemPotionRing"}
zenClass MixinItemPotionRing {
    #mixin ModifyConstant
    #{
    #    method: "func_77663_a",
    #    constant: {longValue: 10}
    #}
    function lessFrequency(value as long) as long {
        return 1000L;
    }
}

#mixin Mixin
#{targets: "de.ellpeck.actuallyadditions.mod.items.lens.LensMining"}
zenClass MixinLensMining {
    #mixin Static
    #mixin Redirect
    #{
    #    method: "init",
    #    at: {
    #        value: "INVOKE",
    #        target: "Lde/ellpeck/actuallyadditions/api/ActuallyAdditionsAPI;addMiningLensStoneOre(Ljava/lang/String;I)V"
    #    }
    #}
    function removeRegisteredOres(name as string, weight as int) as void {
        // NO-OP
    }

    #mixin Static
    #mixin Redirect
    #{
    #    method: "init",
    #    at: {
    #        value: "INVOKE",
    #        target: "Lde/ellpeck/actuallyadditions/api/ActuallyAdditionsAPI;addMiningLensNetherOre(Ljava/lang/String;I)V"
    #    }
    #}
    function removeRegisteredNetherOres(name as string, weight as int) as void {
        // NO-OP
    }
}

#mixin Mixin
#{targets: "de.ellpeck.actuallyadditions.mod.tile.TileEntityBioReactor"}
zenClass MixinTileEntityBioReactor {
    #mixin ModifyConstant
    #{
    #    method: "updateEntity",
    #    constant: {intValue: 2}
    #}
    function buffFuel(value as int) as int {
        return 4;
    }
}

#mixin Mixin
#{targets: "de.ellpeck.actuallyadditions.mod.tile.TileEntityDisplayStand"}
zenClass MixinTileEntityDisplayStand {
    #mixin ModifyConstant
    #{
    #    method: "<init>",
    #    constant: {intValue: 80000}
    #}
    function buffBattery0(value as int) as int {
        return 320000;
    }

    #mixin ModifyConstant
    #{
    #    method: "<init>",
    #    constant: {intValue: 1000}
    #}
    function buffBattery1(value as int) as int {
        return 2000;
    }
}
