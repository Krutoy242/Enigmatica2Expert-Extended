#modloaded iceandfire tconstruct
#loader mixin

#mixin {targets: "com.github.alexthe666.iceandfire.compat.tinkers.TraitBurn"}
zenClass MixinTraitBurn {
    #mixin ModifyConstant {method: "onHit", constant: {floatValue: 2.0f}}
    function buffBurnDamage(value as float) as float {
        return 20.0f;
    }
}
