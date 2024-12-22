#modloaded iceandfire
#loader mixin

#mixin {targets: "com.github.alexthe666.iceandfire.entity.EntityDreadThrall"}
zenClass MixinEntityDreadThrall {

    // Remove armor from Dread Thrall
    // Fixes https://github.com/Krutoy242/Enigmatica2Expert-Extended/issues/80

    #mixin Overwrite
    function hasCustomArmorHead() as bool { /* NO-OP */ }

    #mixin Overwrite
    function hasCustomArmorChest() as bool { /* NO-OP */ }

    #mixin Overwrite
    function hasCustomArmorLegs() as bool { /* NO-OP */ }

    #mixin Overwrite
    function hasCustomArmorFeet() as bool { /* NO-OP */ }
}
