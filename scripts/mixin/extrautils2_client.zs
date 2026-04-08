#modloaded extrautils2 redcore
#loader mixin
#sideonly client

import native.dev.redstudio.redcore.utils.OptiNotFine;

/*
Disable enchantment effect from placed Creative Harvest only when shaders are active
*/
#mixin {targets: "com.rwtema.extrautils2.tile.TileCreativeHarvest"}
zenClass MixinTileCreativeHarvest {
    #mixin Overwrite
    function shouldShowEnchantment() as bool {
        return !OptiNotFine.shadersEnabled();
    }
}
