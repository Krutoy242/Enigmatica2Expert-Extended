#modloaded ic2
#loader mixin

import native.ic2.api.crops.CropCard;
import native.ic2.api.crops.ICropTile;
import native.ic2.core.item.tool.EntityMiningLaser;
import native.ic2.core.crop.cropcard.GenericCropCard;
import native.ic2.core.recipe.ScrapboxRecipeManager;
import native.net.minecraft.item.ItemStack;

#mixin {targets: "ic2.core.block.wiring.TileEntityChargepadBatBox"}
zenClass MixinTileEntityChargePadBatBox {
    #mixin Static
    #mixin ModifyConstant {method: "<init>", constant: {intValue: 40000}}
    function buffEnergy(value as int) as int {
        return 160000;
    }
}

#mixin {targets: "ic2.core.block.wiring.TileEntityChargepadCESU"}
zenClass MixinTileEntityChargePadCESU {
    #mixin Static
    #mixin ModifyConstant {method: "<init>", constant: {intValue: 300000}}
    function buffEnergy(value as int) as int {
        return 600000;
    }
}

#mixin {targets: "ic2.core.block.wiring.TileEntityChargepadMFE"}
zenClass MixinTileEntityChargePadMFE {
    #mixin Static
    #mixin ModifyConstant {method: "<init>", constant: {intValue: 4000000}}
    function buffEnergy(value as int) as int {
        return 8000000;
    }
}

#mixin {targets: "ic2.core.block.wiring.TileEntityChargepadMFSU"}
zenClass MixinTileEntityChargePadMFSU {
    #mixin Static
    #mixin ModifyConstant {method: "<init>", constant: {intValue: 40000000}}
    function buffEnergy(value as int) as int {
        return 80000000;
    }
}

#mixin {targets: "ic2.core.block.wiring.TileEntityElectricBatBox"}
zenClass MixinTileEntityElectricBatBox {
    #mixin Static
    #mixin ModifyConstant {method: "<init>", constant: {intValue: 40000}}
    function buffEnergy(value as int) as int {
        return 160000;
    }
}

#mixin {targets: "ic2.core.block.wiring.TileEntityElectricCESU"}
zenClass MixinTileEntityElectricCESU {
    #mixin Static
    #mixin ModifyConstant {method: "<init>", constant: {intValue: 300000}}
    function buffEnergy(value as int) as int {
        return 600000;
    }
}

#mixin {targets: "ic2.core.block.wiring.TileEntityElectricMFE"}
zenClass MixinTileEntityElectricMFE {
    #mixin Static
    #mixin ModifyConstant {method: "<init>", constant: {intValue: 4000000}}
    function buffEnergy(value as int) as int {
        return 8000000;
    }
}

#mixin {targets: "ic2.core.block.wiring.TileEntityElectricMFSU"}
zenClass MixinTileEntityElectricMFSU {
    #mixin Static
    #mixin ModifyConstant {method: "<init>", constant: {intValue: 40000000}}
    function buffEnergy(value as int) as int {
        return 80000000;
    }
}

#mixin {targets: "ic2.core.crop.TileEntityCrop"}
zenClass MixinTileEntityCrop {
    #mixin Redirect
    #{
    #    method: "performTick",
    #    at: {
    #       value: "INVOKE",
    #       target: "Lic2/api/crops/CropCard;getGrowthDuration(Lic2/api/crops/ICropTile;)I"
    #    }
    #}
    function growFaster(crop as CropCard, tile as ICropTile) as int {
        return crop.getGrowthDuration(tile) / 10;
    }
}

#mixin {targets: "ic2.core.item.tool.ItemCropnalyzer"}
zenClass MixinItemCropnalyzer {
    #mixin Redirect
    #{
    #    method: "onItemUseFirst",
    #    at: {
    #       value: "INVOKE",
    #       target: "Lic2/api/crops/CropCard;getGrowthDuration(Lic2/api/crops/ICropTile;)I"
    #    }
    #}
    function showGrowFasterInfo(cropCard as CropCard, tile as ICropTile) as int {
        return cropCard.getGrowthDuration(tile) / 10;
    }
}

#mixin {targets: "ic2.core.crop.cropcard.CropBaseMetalCommon"}
zenClass MixinCropBaseMetalCommon {
    #mixin ModifyConstant {method: "getGrowthDuration", constant: [{intValue: 2000}, {intValue: 800}]}
    function growFaster(value as int) as int {
        return value / 5;
    }
}

#mixin {targets: "ic2.core.crop.cropcard.CropBaseMetalUncommon"}
zenClass MixinCropBaseMetalUncommon {
    #mixin ModifyConstant {method: "getGrowthDuration", constant: [{intValue: 2200}, {intValue: 750}]}
    function growFaster(value as int) as int {
        return value / 5;
    }
}

#mixin {targets: "ic2.core.crop.cropcard.CropBaseMushroom"}
zenClass MixinCropBaseMushroom {
    #mixin ModifyConstant {method: "getGrowthDuration", constant: {intValue: 200}}
    function growFaster(value as int) as int {
        return value / 2;
    }
}

#mixin {targets: "ic2.core.crop.cropcard.CropCocoa"}
zenClass MixinCropCocoa {
    #mixin ModifyConstant {method: "getGrowthDuration", constant: [{intValue: 900}, {intValue: 400}]}
    function growFaster(value as int) as int {
        return value / 5;
    }
}

#mixin {targets: "ic2.core.crop.cropcard.CropColorFlower"}
zenClass MixinCropColorFlower {
    #mixin ModifyConstant {method: "getGrowthDuration", constant: [{intValue: 600}, {intValue: 400}]}
    function growFaster(value as int) as int {
        return value / 2;
    }
}

#mixin {targets: "ic2.core.crop.cropcard.CropEating"}
zenClass MixinCropEating {
    #mixin ModifyConstant {method: "getGrowthDuration", constant: {floatValue: 1.0}}
    function growFaster(value as float) as float {
        return 0.2f;
    }
}

#mixin {targets: "ic2.core.crop.cropcard.CropHops"}
zenClass MixinCropHops {
    #mixin ModifyConstant {method: "getGrowthDuration", constant: {intValue: 600}}
    function growFaster(value as int) as int {
        return 100;
    }
}

#mixin {targets: "ic2.core.crop.cropcard.CropRedWheat"}
zenClass MixinCropRedWheat {
    #mixin ModifyConstant {method: "getGrowthDuration", constant: {intValue: 600}}
    function growFaster(value as int) as int {
        return 200;
    }
}

#mixin {targets: "ic2.core.crop.cropcard.CropVenomilia"}
zenClass MixinCropVenomilia {
    #mixin ModifyConstant {method: "getGrowthDuration", constant: [{intValue: 600}, {intValue: 400}]}
    function growFaster(value as int) as int {
        return value / 4;
    }
}

#mixin {targets: "ic2.core.crop.IC2Crops"}
zenClass MixinIC2Crops {
    #mixin Static
    #mixin Redirect
    #{
    #    method: "registerCrops",
    #    at: {
    #        value: "INVOKE",
    #        target: "Lic2/core/crop/cropcard/GenericCropCard;register()Lic2/core/crop/cropcard/GenericCropCard;"
    #    },
    #    slice: {
    #        from: {
    #            value: "INVOKE",
    #            target: "Lic2/core/crop/cropcard/GenericCropCard;create(Ljava/lang/String;)Lic2/core/crop/cropcard/GenericCropCard;",
    #            ordinal: 3
    #        },
    #        to: {
    #            value: "INVOKE",
    #            target: "Lic2/core/crop/cropcard/GenericCropCard;create(Ljava/lang/String;)Lic2/core/crop/cropcard/GenericCropCard;",
    #            ordinal: 4
    #        }
    #    }
    #}
    function modifyCorpsePlant(crop as GenericCropCard) as GenericCropCard {
        return crop.setGrowthSpeed(150).register();
    }

    #mixin Static
    #mixin Redirect
    #{
    #    method: "registerCrops",
    #    at: {
    #        value: "INVOKE",
    #        target: "Lic2/core/crop/cropcard/GenericCropCard;register()Lic2/core/crop/cropcard/GenericCropCard;"
    #    },
    #    slice: {
    #        from: {
    #            value: "INVOKE",
    #            target: "Lic2/core/crop/cropcard/GenericCropCard;create(Ljava/lang/String;)Lic2/core/crop/cropcard/GenericCropCard;",
    #            ordinal: 4
    #        },
    #        to: {
    #            value: "INVOKE",
    #            target: "Lic2/core/crop/cropcard/GenericCropCard;create(Ljava/lang/String;)Lic2/core/crop/cropcard/GenericCropCard;",
    #            ordinal: 5
    #        }
    #    }
    #}
    function modifyCreeperWeed(crop as GenericCropCard) as GenericCropCard {
        return crop.setGrowthSpeed(200).register();
    }

    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "registerCrops",
    #    constant: {intValue: 900},
    #    slice: {
    #        from: {
    #            value: "INVOKE",
    #            target: "Lic2/core/crop/cropcard/GenericCropCard;create(Ljava/lang/String;)Lic2/core/crop/cropcard/GenericCropCard;",
    #            ordinal: 6
    #        },
    #        to: {
    #            value: "INVOKE",
    #            target: "Lic2/core/crop/cropcard/GenericCropCard;create(Ljava/lang/String;)Lic2/core/crop/cropcard/GenericCropCard;",
    #            ordinal: 7
    #        }
    #    }
    #}
    function modifyEggPlant(value as int) as int {
        return 100;
    }

    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "registerCrops",
    #    constant: {intValue: 1500},
    #    slice: {
    #        from: {
    #            value: "INVOKE",
    #            target: "Lic2/core/crop/cropcard/GenericCropCard;create(Ljava/lang/String;)Lic2/core/crop/cropcard/GenericCropCard;",
    #            ordinal: 8
    #        },
    #        to: {
    #            value: "INVOKE",
    #            target: "Lic2/core/crop/cropcard/GenericCropCard;create(Ljava/lang/String;)Lic2/core/crop/cropcard/GenericCropCard;",
    #            ordinal: 9
    #        }
    #    }
    #}
    function modifyMeatRose(value as int) as int {
        return 50;
    }

    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "registerCrops",
    #    constant: {intValue: 900},
    #    slice: {
    #        from: {
    #            value: "INVOKE",
    #            target: "Lic2/core/crop/cropcard/GenericCropCard;create(Ljava/lang/String;)Lic2/core/crop/cropcard/GenericCropCard;",
    #            ordinal: 9
    #        },
    #        to: {
    #            value: "INVOKE",
    #            target: "Lic2/core/crop/cropcard/GenericCropCard;create(Ljava/lang/String;)Lic2/core/crop/cropcard/GenericCropCard;",
    #            ordinal: 10
    #        }
    #    }
    #}
    function modifyMilkWart(value as int) as int {
        return 300;
    }

    #mixin Static
    #mixin Redirect
    #{
    #    method: "registerCrops",
    #    at: {
    #        value: "INVOKE",
    #        target: "Lic2/core/crop/cropcard/GenericCropCard;register()Lic2/core/crop/cropcard/GenericCropCard;"
    #    },
    #    slice: {
    #        from: {
    #            value: "INVOKE",
    #            target: "Lic2/core/crop/cropcard/GenericCropCard;create(Ljava/lang/String;)Lic2/core/crop/cropcard/GenericCropCard;",
    #            ordinal: 11
    #        },
    #        to: {
    #            value: "INVOKE",
    #            target: "Lic2/core/crop/cropcard/GenericCropCard;create(Ljava/lang/String;)Lic2/core/crop/cropcard/GenericCropCard;",
    #            ordinal: 13
    #        }
    #    }
    #}
    function modifySlimePlantAndSpidernip(crop as GenericCropCard) as GenericCropCard {
        return crop.setGrowthSpeed(300).register();
    }
}

#mixin {targets: "ic2.core.item.tfbp.Tfbp$TfbpType"}
zenClass MixinTfbpType {
    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "<clinit>",
    #    constant: [
    #      {doubleValue: 2000.0},
    #      {doubleValue: 4000.0},
    #      {doubleValue: 2500.0},
    #      {doubleValue: 3000.0},
    #      {doubleValue: 8000.0}
    #    ]
    #}
    function decreaseConsumption(value as double) as double {
        return value / 20.0;
    }
}

#mixin {targets: "ic2.core.item.tool.EntityMiningLaser"}
zenClass MixinEntityMiningLaser {
    #mixin ModifyConstant {method: "explode", constant: {"floatValue": 5.0}}
    function modifyExplodeValue0(value as float) as float {
        return 3.5f;
    }

    #mixin ModifyConstant {method: "explode", constant: {"floatValue": 0.85}}
    function modifyExplodeValue1(value as float) as float {
        return 1.0f;
    }

    #mixin ModifyConstant {method: "explode", constant: {"floatValue": 0.55}}
    function modifyExplodeValue2(value as float) as float {
        return 0.0f;
    }

    #mixin Redirect
    #{
    #    method: "hitEntity",
    #    at: {
    #        value: "FIELD",
    #        target: "Lic2/core/item/tool/EntityMiningLaser;power:F",
    #        opcode: 180,
    #        ordinal: 1
    #    }
    #}
    function modifyExplodeValue2(item as EntityMiningLaser) as float {
        return 5.0f;
    }
}

#mixin {targets: "ic2.core.item.tool.ItemToolMiningLaser"}
zenClass MixinItemToolMiningLaser {
    #mixin Static
    #mixin ModifyConstant {method: "<init>", constant: {"intValue": 300000}}
    function increaseMaxCharge(value as int) as int {
        return 20000000;
    }

    #mixin Static
    #mixin ModifyConstant {method: "<init>", constant: {"intValue": 512}}
    function increaseTransferLimit(value as int) as int {
        return 10000000;
    }
    
    #mixin ModifyConstant {method: "func_77659_a", constant: {"intValue": 1250}}
    function increaseEnergyConsumption0(value as int) as int {
        return 20000;
    }

    #mixin ModifyConstant {method: "func_77659_a", constant: {"intValue": 100}}
    function increaseEnergyConsumption1(value as int) as int {
        return 5000;
    }

    #mixin ModifyConstant {method: "func_77659_a", constant: {"intValue": 5000}}
    function increaseEnergyConsumption2(value as int) as int {
        return 30000;
    }

    #mixin ModifyConstant {method: "func_77659_a", constant: {"intValue": 2500}}
    function increaseEnergyConsumption3(value as int) as int {
        return 30000;
    }

    #mixin ModifyConstant {method: "func_77659_a", constant: {"intValue": 10000}}
    function increaseEnergyConsumption4(value as int) as int {
        return 500000;
    }

    #mixin ModifyConstant {method: "func_77659_a", constant: {"intValue": 7500}}
    function increaseEnergyConsumption5(value as int) as int {
        return 0;
    }
}

#mixin {targets: "ic2.core.item.ItemBatteryChargeHotbar"}
zenClass MixinItemBatteryChargeHotbar {
    #mixin Static
    #mixin ModifyArg
    #{
    #   method: "<init>",
    #   at: {
    #       value: "INVOKE",
    #       target: "Lic2/core/item/ItemBattery;<init>(Lic2/core/ref/ItemName;DDI)V"
    #   },
    #   index: 1
    #}
    function buffMaxCharge(value as double) as double {
        return value * 2.0;
    }

    #mixin Static
    #mixin ModifyArg
    #{
    #   method: "<init>",
    #   at: {
    #       value: "INVOKE",
    #       target: "Lic2/core/item/ItemBattery;<init>(Lic2/core/ref/ItemName;DDI)V"
    #   },
    #   index: 2
    #}
    function buffTransferLimit(value as double) as double {
        return value * 10.0;
    }
}

/*
Remove UU-values calculating on game load
Fix strange bug, when predefined values was rewritten with wrong ones.
Also, this would remove some small UU recipes, like wooden slabs or buttons.
*/
#mixin {targets: "ic2.core.uu.UuIndex"}
zenClass MixinUuIndex {
    #mixin Overwrite
    function init() as void {
        // NO-OP
    }
}


#mixin {targets: "ic2.core.recipe.ScrapboxRecipeManager"}
zenClass MixinScrapboxRecipeManager {
    #mixin Redirect
    #{
    #   method: "addBuiltinDrops",
    #   at: {
    #       value: "INVOKE",
    #       target: "Lic2/core/recipe/ScrapboxRecipeManager;addDrop(Lnet/minecraft/item/ItemStack;F)V"
    #   }
    #}
    function removeWrongOutput(manager as ScrapboxRecipeManager, item as ItemStack, chance as float) as void {
        if (item.item.registryName.namespace == 'ic2' && (
            item.item.registryName.path == 'dust'
            || item.item.registryName.path == 'resource'
        )) return;
        manager.addDrop(item, chance);
    }
}
