#modloaded storagedrawers
#loader mixin

import native.net.minecraft.block.material.Material;

#mixin { targets: 'com.jaquadro.minecraft.storagedrawers.block.BlockCompDrawers' }
    zenClass MixinBlockCompDrawers {
    #mixin Static
    #mixin Redirect
    #{
    #  method: '<init>',
    #  at: {
    #    value: 'FIELD',
    #    target: 'Lnet/minecraft/block/material/Material;field_151576_e:Lnet/minecraft/block/material/Material;',
    #    opcode: 178
    #  }
    #}
    function useMaterialWood() as Material {
        return Material.WOOD;
    }
}