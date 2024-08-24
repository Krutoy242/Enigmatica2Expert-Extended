#loader mixin

import native.thaumcraft.api.golems.parts.GolemMaterial;
import mixin.CallbackInfo;
import mixin.CallbackInfoReturnable;

#mixin Mixin
#{targets: "thaumcraft.api.golems.parts.GolemMaterial"}
zenClass MixinGolemMaterial {
    #mixin Static
    #mixin Inject
    #{
    #    method: "register",
    #    at: {value: "HEAD"}
    #}
    function modifyNumericValues(material as GolemMaterial, ci as CallbackInfo) as void {
        material.healthMod = material.healthMod * 2;
        material.armor = material.armor * material.armor / 10 + material.armor;
        material.damage = material.damage * material.damage / 2 + material.damage;
    }
}

#mixin Mixin
#{targets: "thaumcraft.common.blocks.basic.BlockStonePorous"}
zenClass MixinBlockStonePorous {
    #mixin ModifyConstant
    #{
    #    method: "getDrops",
    #    constant: {intValue: 15}
    #}
    function modifyDropCount0(value as int) as int {
        return 5;
    }

    #mixin ModifyConstant
    #{
    #    method: "getDrops",
    #    constant: {intValue: 13}
    #}
    function modifyDropCount1(value as int) as int {
        return 3;
    }
}

#mixin Mixin
#{targets: "thaumcraft.common.blocks.misc.BlockFluidDeath"}
zenClass MixinBlockFluidDeath {
    #mixin ModifyArg
    #{
    #    method: "func_180634_a",
    #    at: {
    #        value: "INVOKE",
    #        target: "Lnet/minecraft/entity/Entity;func_70097_a(Lnet/minecraft/util/DamageSource;F)Z"
    #    }
    #}
    function modifyDamageValue(value as float) as float {
        return 40.0f - (4.0f - (value - 1.0f)) * 5.0f;
    }
}

#mixin Mixin
#{targets: "thaumcraft.common.entities.monster.EntityPech"}
zenClass MixinEntityPech {
    #mixin ModifyConstant
    #{
    #    method: "getValue",
    #    constant: {intValue: 32}
    #}
    function modifyValue0(value as int) as int {
        return 256;
    }

    #mixin ModifyConstant
    #{
    #    method: "getValue",
    #    constant: {intValue: 2}
    #}
    function modifyValue1(value as int) as int {
        return 4;
    }
}

#mixin Mixin
#{targets: "thaumcraft.common.tiles.crafting.TileThaumatoriumTop"}
zenClass MixinTileThaumatoriumTop {
    #mixin Inject
    #{
    #    method: "func_191420_l",
    #    at: {value: "HEAD"},
    #    cancellable: true
    #}
    function avoidNPE(cir as CallbackInfoReturnable) as void {
        if (isNull(this0.thaumatorium)) {
            cir.setReturnValue(true);
        }
    }
}

#mixin Mixin
#{targets: "thaumcraft.common.tiles.devices.TileLampFertility"}
zenClass MixinTileLampFertility {
    #mixin ModifyConstant
    #{
    #    method: "updateAnimals",
    #    constant: {intValue: 5}
    #}
    function modifyChargeLoss(value as int) as int {
        return 1;
    }
}

#mixin Mixin
#{targets: "thaumcraft.common.tiles.devices.TileMirror"}
zenClass MixinTileMirror {
    #mixin ModifyConstant
    #{
    #    method: "checkInstability",
    #    constant: {intValue: 100}
    #}
    function modifyCountModulo(value as int) as int {
        return 5;
    }
}

#mixin Mixin
#{targets: "thaumcraft.common.tiles.devices.TileMirrorEssentia"}
zenClass MixinTileMirrorEssentia {
    #mixin ModifyConstant
    #{
    #    method: "checkInstability",
    #    constant: {intValue: 100}
    #}
    function modifyCountModulo(value as int) as int {
        return 5;
    }
}

#mixin Mixin
#{targets: "thaumcraft.common.tiles.devices.TileVisGenerator"}
zenClass MixinTileVisGenerator {
    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "<init>",
    #    constant: [{intValue: 1000}, {intValue: 20}]
    #}
    function buffEnergyHandler(value as int) as int {
        return value * 10;
    }

    #mixin ModifyConstant
    #{
    #    method: "func_73660_a",
    #    constant: {intValue: 20}
    #}
    function increaseOutputSpeed(value as int) as int {
        return value * 10;
    }

    #mixin ModifyConstant
    #{
    #    method: "recharge",
    #    constant: {floatValue: 1000}
    #}
    function increaseConversationRatio(value as float) as float {
        return value * 10;
    }
}

