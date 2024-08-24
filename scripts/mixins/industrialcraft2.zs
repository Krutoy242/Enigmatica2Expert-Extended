#loader mixin

import native.ic2.api.crops.CropCard;
import native.ic2.api.crops.ICropTile;
import native.ic2.core.item.tool.EntityMiningLaser;

#mixin Mixin
#{targets: "ic2.core.block.wiring.TileEntityChargepadBatBox"}
zenClass MixinTileEntityChargePadBatBox {
    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "<init>",
    #    constant: {intValue: 40000}
    #}
    function buffEnergy(value as int) as int {
        return 160000;
    }
}

#mixin Mixin
#{targets: "ic2.core.block.wiring.TileEntityChargepadCESU"}
zenClass MixinTileEntityChargePadCESU {
    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "<init>",
    #    constant: {intValue: 300000}
    #}
    function buffEnergy(value as int) as int {
        return 600000;
    }
}

#mixin Mixin
#{targets: "ic2.core.block.wiring.TileEntityChargepadMFE"}
zenClass MixinTileEntityChargePadMFE {
    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "<init>",
    #    constant: {intValue: 4000000}
    #}
    function buffEnergy(value as int) as int {
        return 8000000;
    }
}

#mixin Mixin
#{targets: "ic2.core.block.wiring.TileEntityChargepadMFSU"}
zenClass MixinTileEntityChargePadMFSU {
    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "<init>",
    #    constant: {intValue: 40000000}
    #}
    function buffEnergy(value as int) as int {
        return 80000000;
    }
}

#mixin Mixin
#{targets: "ic2.core.block.wiring.TileEntityElectricBatBox"}
zenClass MixinTileEntityElectricBatBox {
    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "<init>",
    #    constant: {intValue: 40000}
    #}
    function buffEnergy(value as int) as int {
        return 160000;
    }
}

#mixin Mixin
#{targets: "ic2.core.block.wiring.TileEntityElectricCESU"}
zenClass MixinTileEntityElectricCESU {
    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "<init>",
    #    constant: {intValue: 300000}
    #}
    function buffEnergy(value as int) as int {
        return 600000;
    }
}

#mixin Mixin
#{targets: "ic2.core.block.wiring.TileEntityElectricMFE"}
zenClass MixinTileEntityElectricMFE {
    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "<init>",
    #    constant: {intValue: 4000000}
    #}
    function buffEnergy(value as int) as int {
        return 8000000;
    }
}

#mixin Mixin
#{targets: "ic2.core.block.wiring.TileEntityElectricMFSU"}
zenClass MixinTileEntityElectricMFSU {
    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "<init>",
    #    constant: {intValue: 40000000}
    #}
    function buffEnergy(value as int) as int {
        return 80000000;
    }
}

#mixin Mixin
#{targets: "ic2.core.crop.TileEntityCrop"}
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

#mixin Mixin
#{targets: "ic2.core.crop.cropcard.CropBaseMetalCommon"}
zenClass MixinCropBaseMetalCommon {
    #mixin ModifyConstant
    #{
    #    method: "getGrowthDuration",
    #    constant: [{intValue: 2000}, {intValue: 800}]
    #}
    function growFaster(value as int) as int {
        return value / 5;
    }
}

#mixin Mixin
#{targets: "ic2.core.crop.cropcard.CropBaseMetalUncommon"}
zenClass MixinCropBaseMetalUncommon {
    #mixin ModifyConstant
    #{
    #    method: "getGrowthDuration",
    #    constant: [{intValue: 2200}, {intValue: 750}]
    #}
    function growFaster(value as int) as int {
        return value / 5;
    }
}

#mixin Mixin
#{targets: "ic2.core.crop.cropcard.CropBaseMushroom"}
zenClass MixinCropBaseMushroom {
    #mixin ModifyConstant
    #{
    #    method: "getGrowthDuration",
    #    constant: {intValue: 200}
    #}
    function growFaster(value as int) as int {
        return value / 2;
    }
}

#mixin Mixin
#{targets: "ic2.core.crop.cropcard.CropCocoa"}
zenClass MixinCropCocoa {
    #mixin ModifyConstant
    #{
    #    method: "getGrowthDuration",
    #    constant: [{intValue: 900}, {intValue: 400}]
    #}
    function growFaster(value as int) as int {
        return value / 5;
    }
}

#mixin Mixin
#{targets: "ic2.core.crop.cropcard.CropColorFlower"}
zenClass MixinCropColorFlower {
    #mixin ModifyConstant
    #{
    #    method: "getGrowthDuration",
    #    constant: [{intValue: 600}, {intValue: 400}]
    #}
    function growFaster(value as int) as int {
        return value / 2;
    }
}

#mixin Mixin
#{targets: "ic2.core.crop.cropcard.CropEating"}
zenClass MixinCropEating {
    #mixin ModifyConstant
    #{
    #    method: "getGrowthDuration",
    #    constant: {floatValue: 1.0}
    #}
    function growFaster(value as float) as float {
        return 0.2f;
    }
}

#mixin Mixin
#{targets: "ic2.core.crop.cropcard.CropHops"}
zenClass MixinCropHops {
    #mixin ModifyConstant
    #{
    #    method: "getGrowthDuration",
    #    constant: {intValue: 600}
    #}
    function growFaster(value as int) as int {
        return 100;
    }
}

#mixin Mixin
#{targets: "ic2.core.crop.cropcard.CropRedWheat"}
zenClass MixinCropRedWheat {
    #mixin ModifyConstant
    #{
    #    method: "getGrowthDuration",
    #    constant: {intValue: 600}
    #}
    function growFaster(value as int) as int {
        return 200;
    }
}

#mixin Mixin
#{targets: "ic2.core.crop.cropcard.CropVenomilia"}
zenClass MixinCropVenomilia {
    #mixin ModifyConstant
    #{
    #    method: "getGrowthDuration",
    #    constant: [{intValue: 600}, {intValue: 400}]
    #}
    function growFaster(value as int) as int {
        return value / 4;
    }
}

#mixin Mixin
#{targets: "ic2.core.item.tfbp.Tfbp$TfbpType"}
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

#mixin Mixin
#{targets: "ic2.core.item.tool.EntityMiningLaser"}
zenClass MixinEntityMiningLaser {
    #mixin ModifyConstant
    #{
    #    method: "explode",
    #    constant: {"floatValue": 5.0}
    #}
    function modifyExplodeValue0(value as float) as float {
        return 3.5f;
    }

    #mixin ModifyConstant
    #{
    #    method: "explode",
    #    constant: {"floatValue": 0.85}
    #}
    function modifyExplodeValue1(value as float) as float {
        return 1.0f;
    }

    #mixin ModifyConstant
    #{
    #    method: "explode",
    #    constant: {"floatValue": 0.55}
    #}
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

#mixin Mixin
#{targets: "ic2.core.item.tool.ItemCropnalyzer"}
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

#mixin Mixin
#{targets: "ic2.core.item.tool.ItemToolMiningLaser"}
zenClass MixinItemToolMiningLaser {
    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "<init>",
    #    constant: {"intValue": 300000}
    #}
    function increaseMaxCharge(value as int) as int {
        return 20000000;
    }

    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "<init>",
    #    constant: {"intValue": 512}
    #}
    function increaseTransferLimit(value as int) as int {
        return 10000000;
    }
    
    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "<init>",
    #    constant: {"intValue": 1250}
    #}
    function increaseEnergyConsumption0(value as int) as int {
        return 20000;
    }

    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "<init>",
    #    constant: {"intValue": 100}
    #}
    function increaseEnergyConsumption1(value as int) as int {
        return 5000;
    }

    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "<init>",
    #    constant: {"intValue": 5000}
    #}
    function increaseEnergyConsumption2(value as int) as int {
        return 30000;
    }

    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "<init>",
    #    constant: {"intValue": 2500}
    #}
    function increaseEnergyConsumption3(value as int) as int {
        return 30000;
    }

    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "<init>",
    #    constant: {"intValue": 10000}
    #}
    function increaseEnergyConsumption4(value as int) as int {
        return 500000;
    }

    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "<init>",
    #    constant: {"intValue": 7500}
    #}
    function increaseEnergyConsumption5(value as int) as int {
        return 0;
    }
}

#mixin Mixin
#{targets: "ic2.core.uu.UuIndex"}
zenClass MixinUuIndex {
    #mixin Overwrite
    function init() as void {
        // NO-OP
    }
}
