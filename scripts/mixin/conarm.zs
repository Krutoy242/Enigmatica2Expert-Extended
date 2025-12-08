#modloaded conarm
#loader mixin

#mixin {targets: "c4.conarm.common.armor.modifiers.ModEmerald"}
zenClass MixinModEmerald {
    #mixin ModifyConstant {method: "applyEffect", constant: {intValue: 2}}
    function buffDurabilityBonus(value as int) as int {
        return 1;
    }
}

#mixin {targets: "c4.conarm.common.armor.modifiers.ModPowerful"}
zenClass MixinModPowerful {
    // Special note:
    // Different decompilers represents float values casted to double differently.
    // For example, CFT and Vineflower represent 0.15F wrong here
    #mixin ModifyConstant {method: "getAttributeModifiers", constant: {doubleValue: 0.15000000596046448}}
    function buffPowerfulModifier(value as double) as double {
        return 0.5;
    }
}
