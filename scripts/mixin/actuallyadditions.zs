#modloaded actuallyadditions
#loader mixin

import native.de.ellpeck.actuallyadditions.api.ActuallyAdditionsAPI;
import native.de.ellpeck.actuallyadditions.api.internal.IAtomicReconstructor;
import native.de.ellpeck.actuallyadditions.api.recipe.WeightedOre;
import native.net.minecraft.block.Block;
import native.net.minecraft.block.state.IBlockState;
import native.net.minecraft.init.Blocks;
import native.net.minecraft.util.math.BlockPos;
import native.net.minecraft.world.World;

#mixin {targets: "de.ellpeck.actuallyadditions.mod.items.InitItems"}
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

#mixin {targets: "de.ellpeck.actuallyadditions.mod.items.ItemFillingWand"}
zenClass MixinItemFillWand {
    #mixin ModifyConstant {method: "func_77663_a", constant: {intValue: 1500}}
    function lessEnergyConsumption(value as int) as int {
        return 100;
    }
}

#mixin {targets: "de.ellpeck.actuallyadditions.mod.items.ItemPotionRing"}
zenClass MixinItemPotionRing {
    #mixin ModifyConstant {method: "func_77663_a", constant: {longValue: 10}}
    function buffDuration(value as long) as long {
        return 10000L;
    }
}

/*
Convert only End Stone => End ores.
Convert cost set to `150,000` RF.
*/
#mixin {targets: "de.ellpeck.actuallyadditions.mod.items.lens.LensMining"}
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

#mixin {targets: "de.ellpeck.actuallyadditions.mod.tile.TileEntityBioReactor"}
zenClass MixinTileEntityBioReactor {
    #mixin ModifyConstant {method: "updateEntity", constant: {intValue: 2}}
    function buffPowerGeneration(value as int) as int {
        return 4; // producePerTick = (amount * 4)²
    }
}

#mixin {targets: "de.ellpeck.actuallyadditions.mod.tile.TileEntityDisplayStand"}
zenClass MixinTileEntityDisplayStand {
    #mixin ModifyConstant {method: "<init>", constant: {intValue: 80000}}
    function buffCapacity(value as int) as int {
        return 320000;
    }

    #mixin ModifyConstant {method: "<init>", constant: {intValue: 1000}}
    function buffTransferRate(value as int) as int {
        return 2000;
    }
}

#mixin {targets: "de.ellpeck.actuallyadditions.mod.items.ItemDrill"}
zenClass MixinAAItemDrill {
    #mixin ModifyConstant {method: "*", constant: { intValue: 4 }}
    function increaseMiningLevel(value as int) as int {
        return 7;
    }
}

/*
Remove Crusher since its whole functionality copied with EU2 crusher
that actually better since can be upgraded
*/
#mixin {targets: "de.ellpeck.actuallyadditions.mod.crafting.CrusherCrafting"}
zenClass MixinCrusherCrafting {
    #mixin Static
    #mixin Overwrite
    function init() as void {
        // NO-OP
    }
}

/*
Set maximum harvest level for [Auto-Breaker] [Phantom Breaker] [Long-Range Breaker]
to prevent exploiting and skip mining levels
*/
#mixin {targets: "de.ellpeck.actuallyadditions.mod.tile.TileEntityBreaker", priority: 2000}
zenClass MixinTileEntityBreaker {
    #mixin ModifyVariable
    #{
    #    method: "doWork",
    #    at: {value: "STORE", ordinal: 0},
    #    name: "stateToBreak"
    #}
    function checkHarvestLevel(stateToBreak as IBlockState) as IBlockState {
        return stateToBreak.block.getHarvestLevel(stateToBreak) > 10
            ? native.net.minecraft.init.Blocks.AIR.defaultState
            : stateToBreak;
    }
}

#mixin
# {
#     priority: 2000,
#     targets: [
#         "de.ellpeck.actuallyadditions.mod.tile.TileEntityPhantomPlacer",
#         "de.ellpeck.actuallyadditions.mod.tile.TileEntityDirectionalBreaker"
# ]}
zenClass MixinTileEntityPhantomPlacerAndBreaker {
    #mixin Redirect
    #{
    #    method: "doWork",
    #    at: {
    #        value: "INVOKE",
    #        target: "Lnet/minecraft/block/state/IBlockState;func_185887_b(Lnet/minecraft/world/World;Lnet/minecraft/util/math/BlockPos;)F"
    #    }
    #}
    function checkHarvestLevel(stateToBreak as IBlockState, world as World, pos as BlockPos) as float {
        return stateToBreak.block.getHarvestLevel(stateToBreak) > 10
            ? -1.0f
            : stateToBreak.getBlockHardness(world, pos);
    }
}
