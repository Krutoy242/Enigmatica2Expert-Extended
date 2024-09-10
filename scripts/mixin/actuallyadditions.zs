#loader mixin

import native.net.minecraft.block.state.IBlockState;
import native.net.minecraft.util.math.BlockPos;
import native.net.minecraft.init.Blocks;
import native.de.ellpeck.actuallyadditions.api.internal.IAtomicReconstructor;
import native.de.ellpeck.actuallyadditions.api.ActuallyAdditionsAPI;
import native.de.ellpeck.actuallyadditions.api.recipe.WeightedOre;

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
    function buffBatteriesCapacity(value as int) as int {
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

/*
Convert only End Stone => End ores.
Convert cost set to `150,000` RF.
*/
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
    #    },
    #    slice: {
    #       to: {
    #           value: "INVOKE",
    #           target: "Lde/ellpeck/actuallyadditions/mod/config/values/ConfigStringListValues;getValue()[Ljava/lang/String;"
    #       }
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
    #    },
    #    slice: {
    #       to: {
    #           value: "INVOKE",
    #           target: "Lde/ellpeck/actuallyadditions/mod/config/values/ConfigStringListValues;getValue()[Ljava/lang/String;"
    #       }
    #    }
    #}
    function removeRegisteredNetherOres(name as string, weight as int) as void {
        // NO-OP
    }

    #mixin Redirect
    #{
    #    method: "invoke",
    #    at: {
    #        value: "FIELD",
    #        target: "Lde/ellpeck/actuallyadditions/api/ActuallyAdditionsAPI;STONE_ORES:Ljava/util/List;",
    #        opcode: 178
    #    }
    #}
    function removeStoneTransformation() as [string] {
        return null;
    }

    #mixin ModifyVariable
    #{
    #    method: "invoke",
    #    at: {
    #       value: "JUMP",
    #       opcode: 198,
    #       ordinal: 0,
    #       shift: "BEFORE"
    #    },
    #    name: "ores"
    #}
    function setTransformationOresIfBlockIsEndstone(ores as [WeightedOre], hitState as IBlockState, hitPos as BlockPos, tile as IAtomicReconstructor) as [WeightedOre] {
        if (hitState.block == Blocks.END_STONE) {
            return [
                WeightedOre("oreEndQuartz", 64),
                WeightedOre("oreEndAluminum", 40),
                WeightedOre("oreEndIron", 30),
                WeightedOre("oreEndCobalt", 20),
                WeightedOre("oreEndArdite", 20),
                WeightedOre("oreEndDiamond", 10)
            ] as [WeightedOre];
        }
        return ores;
    }

    #mixin ModifyVariable
    #{
    #    method: "invoke",
    #    at: {
    #       value: "JUMP",
    #       opcode: 198,
    #       ordinal: 0
    #    },
    #    name: "adaptedUse"
    #}
    function setEnergyCost(value as int) as int {
        return 150000;
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
    function buffPowerGeneration(value as int) as int {
        return 4; // producePerTick = (amount * 4)²
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
    function buffCapacity(value as int) as int {
        return 320000;
    }

    #mixin ModifyConstant
    #{
    #    method: "<init>",
    #    constant: {intValue: 1000}
    #}
    function buffTransferRate(value as int) as int {
        return 2000;
    }
}
