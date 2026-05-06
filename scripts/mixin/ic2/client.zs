#modloaded ic2
#loader mixin
#sideonly client

import mixin.CallbackInfo;
import native.ic2.api.crops.Crops;
import native.ic2.core.item.ItemCropSeed;
import native.net.minecraft.entity.EntityLivingBase;
import native.net.minecraft.item.ItemStack;
import native.net.minecraft.util.ResourceLocation;
import native.net.minecraft.world.World;

/*

Change model+texture depending on seed ID

Textures provided by the resource pack:
https://curseforge.com/minecraft/texture-packs/ic2-seedbag-display

*/
#mixin {targets: "ic2.core.item.ItemCropSeed"}
zenClass ItemCropSeedMixin {
    #mixin Inject {method: "<init>", at: {value: "RETURN"}}
    function addPropertyOverride(ci as CallbackInfo) as void {
        val item = this0 as ItemCropSeed;

        val cropIdMap as float[string] = {
            acacia_sapling: 1.0f,
            aurelia: 2.0f,
            beetroots: 3.0f,
            birch_sapling: 4.0f,
            blackthorn: 5.0f,
            blazereed: 6.0f,
            bobs_yer_uncle_ranks_berries: 7.0f,
            brown_mushroom: 8.0f,
            carrots: 9.0f,
            cocoa: 10.0f,
            coffee: 11.0f,
            corium: 12.0f,
            corpse_plant: 13.0f,
            creeper_weed: 14.0f,
            cyazint: 15.0f,
            cyprium: 16.0f,
            dandelion: 17.0f,
            dark_oak_sapling: 18.0f,
            diareed: 19.0f,
            eatingplant: 20.0f,
            egg_plant: 21.0f,
            ender_blossom: 22.0f,
            ferru: 23.0f,
            flax: 24.0f,
            hops: 25.0f,
            jungle_sapling: 26.0f,
            meat_rose: 27.0f,
            melon: 28.0f,
            milk_wart: 29.0f,
            nether_wart: 30.0f,
            oak_sapling: 31.0f,
            oil_berries: 32.0f,
            plumbiscus: 33.0f,
            potato: 34.0f,
            pumpkin: 35.0f,
            red_mushroom: 36.0f,
            redwheat: 37.0f,
            reed: 38.0f,
            rose: 39.0f,
            shining: 40.0f,
            slime_plant: 41.0f,
            spidernip: 42.0f,
            spruce_sapling: 43.0f,
            stagnium: 44.0f,
            stickreed: 45.0f,
            tearstalks: 46.0f,
            terra_wart: 47.0f,
            tulip: 48.0f,
            venomilia: 49.0f,
            weed: 50.0f,
            wheat: 51.0f,
            withereed: 52.0f,
        };

        item.addPropertyOverride(ResourceLocation("crop_id"), function (stack as ItemStack, world as World, entity as EntityLivingBase) as float {
            val crop = item.getCropFromStack(stack);
            if (isNull(crop?.id)) return 0.0f;
            if (cropIdMap has crop.id) return cropIdMap[crop.id as string] as float;
            return 0.0f;
        });
    }
}
