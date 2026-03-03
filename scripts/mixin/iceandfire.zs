#modloaded iceandfire
#loader mixin

import native.com.github.alexthe666.iceandfire.entity.EntityMyrmexBase.BasicTrade;
import native.net.minecraft.entity.passive.EntityVillager.PriceInfo;
import native.net.minecraft.item.Item;
import native.net.minecraft.item.ItemStack;
import native.net.minecraft.util.ResourceLocation;
import native.net.minecraftforge.fml.common.registry.VillagerRegistry.VillagerCareer;
import native.net.minecraftforge.fml.common.registry.VillagerRegistry.VillagerProfession;

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

#mixin {targets: "com.github.alexthe666.iceandfire.entity.IafVillagerRegistry"}
zenClass MixinIafVillagerRegistry {

    #mixn Shadow
    var fisherman as VillagerProfession;
    #mixn Shadow    
    var craftsman as VillagerProfession;
    #mixn Shadow    
    var shaman as VillagerProfession;
    #mixn Shadow    
    var desertMyrmexWorker as VillagerProfession;
    #mixn Shadow    
    var jungleMyrmexWorker as VillagerProfession;
    #mixn Shadow    
    var desertMyrmexSoldier as VillagerProfession;
    #mixn Shadow    
    var jungleMyrmexSoldier as VillagerProfession;
    #mixn Shadow    
    var desertMyrmexSentinel as VillagerProfession;
    #mixn Shadow    
    var jungleMyrmexSentinel as VillagerProfession;
    #mixn Shadow    
    var desertMyrmexRoyal as VillagerProfession;
    #mixn Shadow    
    var jungleMyrmexRoyal as VillagerProfession;
    #mixn Shadow    
    var desertMyrmexQueen as VillagerProfession;
    #mixn Shadow    
    var jungleMyrmexQueen as VillagerProfession;

    var career as VillagerCareer = null;

    #mixin Overwrite
    function init() as void {
        val defTexture = 'minecraft:textures/entity/zombie_villager/zombie_farmer.png';

        fisherman = VillagerProfession("iceandfire:fisherman", "iceandfire:textures/models/snowvillager/fisherman.png", defTexture);
        career = VillagerCareer(fisherman, "fisherman");
        this0.register(fisherman, 0);

        craftsman = VillagerProfession("iceandfire:craftsman", "iceandfire:textures/models/snowvillager/craftsman.png", defTexture);
        career = VillagerCareer(craftsman, "craftsman");
        this0.register(craftsman, 1);

        shaman = VillagerProfession("iceandfire:shaman", "iceandfire:textures/models/snowvillager/shaman.png", defTexture);
        career = VillagerCareer(shaman, "shaman");
        this0.register(shaman, 2);

        desertMyrmexWorker = VillagerProfession("iceandfire:desertMyrmexWorker", defTexture, defTexture);
        career = VillagerCareer(desertMyrmexWorker, "desert_myrmex_worker");
        addTrade(1, 'chisel:limestone2:7'                   , 16, 32  , 'iceandfire:myrmex_desert_resin'   , 1, 1);
        addTrade(1, 'tconstruct:slime_dirt'                 , 16, 32  , 'iceandfire:myrmex_desert_resin'   , 1, 2);
        addTrade(2, 'tconstruct:slime_dirt:3'               , 40, 64  , 'iceandfire:myrmex_desert_resin'   , 1, 2);
        addTrade(2, 'minecraft:deadbush'                    , 10, 20  , 'iceandfire:myrmex_desert_resin'   , 1, 2);
        addTrade(3, 'forestry:mulch'                        ,  5, 10  , 'iceandfire:myrmex_desert_resin'   , 1, 2);
        addTrade(3, 'nuclearcraft:dark_chocolate'           ,  3, 8   , 'iceandfire:myrmex_desert_resin'   , 5, 9);
        addTrade(4, 'forestry:peat'                         ,  2, 4   , 'iceandfire:myrmex_desert_resin'   , 1, 2);
        addTrade(5, 'forestry:bituminous_peat'              ,  1, 2   , 'iceandfire:myrmex_desert_resin'   , 4, 8);
        addTrade(5, 'nuclearcraft:wasteland_earth'          , 32, 64  , 'iceandfire:myrmex_desert_resin'   , 4, 8);
        addTrade(6, 'twilightforest:huge_stalk'             ,  4, 7   , 'iceandfire:myrmex_desert_resin'   , 3, 9);

        jungleMyrmexWorker = VillagerProfession("iceandfire:jungleMyrmexWorker", defTexture, defTexture);
        career = VillagerCareer(jungleMyrmexWorker, "jungle_myrmex_worker");
        addTrade(1, 'biomesoplenty:bamboo_thatching'        ,  2, 8   , 'iceandfire:myrmex_jungle_resin'   , 1, 3);
        addTrade(1, 'tconstruct:slime_dirt:1'               , 16, 32  , 'iceandfire:myrmex_jungle_resin'   , 1, 2);
        addTrade(2, 'tconstruct:slime_dirt:2'               , 16, 32  , 'iceandfire:myrmex_jungle_resin'   , 1, 2);
        addTrade(2, 'cyclicmagic:stone_pebble'              , 10, 64  , 'iceandfire:myrmex_jungle_resin'   , 2, 3);
        addTrade(3, 'nuclearcraft:unsweetened_chocolate'    ,  3, 8   , 'iceandfire:myrmex_jungle_resin'   , 4, 9);
        addTrade(3, 'nuclearcraft:milk_chocolate'           ,  1, 3   , 'iceandfire:myrmex_jungle_resin'   , 4, 9);
        addTrade(4, 'ic2:misc_resource:4'                   ,  5, 15  , 'iceandfire:myrmex_jungle_resin'   , 2, 4);
        addTrade(5, 'forestry:bituminous_peat'              ,  1, 2   , 'iceandfire:myrmex_jungle_resin'   , 4, 8);
        addTrade(5, 'quark:biome_cobblestone:2'             ,  2, 7   , 'iceandfire:myrmex_jungle_resin'   , 4, 8);
        addTrade(6, 'quark:gravisand'                       ,  2, 8   , 'iceandfire:myrmex_jungle_resin'   , 2, 6);

        desertMyrmexSoldier = VillagerProfession("iceandfire:desertMyrmexSoldier", defTexture, defTexture);
        career = VillagerCareer(desertMyrmexSoldier, "desert_myrmex_soldier");
        addTrade(1, 'iceandfire:myrmex_desert_resin'          , 1, 5   , 'minecraft:bone'                   , 1, 15);
        addTrade(1, 'iceandfire:myrmex_desert_resin'          , 1, 3   , 'minecraft:feather'                , 1, 3);
        addTrade(1, 'iceandfire:myrmex_desert_resin'          , 1, 3   , 'minecraft:string'                 , 1, 3);
        addTrade(2, 'iceandfire:myrmex_desert_resin'          , 5, 7   , 'minecraft:gunpowder'              , 1, 3);
        addTrade(2, 'iceandfire:myrmex_desert_resin'          , 3, 6   , 'minecraft:rabbit'                 , 1, 1);
        addTrade(2, 'iceandfire:myrmex_desert_resin'          , 1, 3   , 'minecraft:dye:2'                  , 1, 3);
        addTrade(3, 'iceandfire:myrmex_desert_resin'          , 1, 3   , 'minecraft:iron_nugget'            , 1, 3);
        addTrade(3, 'iceandfire:myrmex_desert_resin'          , 3, 6   , 'minecraft:chicken'                , 1, 1);
        addTrade(4, 'iceandfire:myrmex_desert_resin'          , 1, 3   , 'minecraft:gold_nugget'            , 1, 3);
        addTrade(4, 'iceandfire:myrmex_desert_resin'          , 5, 13  , 'iceandfire:fire_dragon_blood'     , 1, 3);
        addTrade(5, 'iceandfire:troll_tusk'                   , 1, 1   , 'iceandfire:myrmex_desert_resin'   , 5, 15);
        addTrade(5, 'iceandfire:myrmex_desert_resin'          , 20, 50 , 'minecraft:skull'                  , 1, 1);
        addTrade(6, 'iceandfire:myrmex_desert_resin'          , 30, 60 , 'minecraft:skull:2'                , 1, 1);
        addTrade(6, 'iceandfire:myrmex_desert_resin'          , 45, 64 , 'minecraft:skull:4'                , 1, 1);
        addTrade(10,'iceandfire:myrmex_desert_resin_glass'    , 1, 3   , 'enderio:block_enderman_skull'     , 1, 1);
        addTrade(10,'iceandfire:myrmex_desert_resin_glass'    , 2, 6   , 'enderio:item_material:47'         , 6, 12);
        addTrade(10,'iceandfire:myrmex_desert_resin_glass'    , 2, 6   , 'enderio:item_material:46'         , 6, 12);

        jungleMyrmexSoldier = VillagerProfession("iceandfire:jungleMyrmexSoldier", defTexture, defTexture);
        career = VillagerCareer(jungleMyrmexSoldier, "jungle_myrmex_soldier");
        addTrade(1, 'iceandfire:myrmex_jungle_resin'          , 1, 5   , 'minecraft:bone'                   , 1, 15);
        addTrade(1, 'iceandfire:myrmex_jungle_resin'          , 1, 3   , 'minecraft:feather'                , 1, 3);
        addTrade(1, 'iceandfire:myrmex_jungle_resin'          , 1, 3   , 'minecraft:string'                 , 1, 3);
        addTrade(2, 'iceandfire:myrmex_jungle_resin'          , 5, 7   , 'minecraft:gunpowder'              , 1, 3);
        addTrade(2, 'iceandfire:myrmex_jungle_resin'          , 3, 6   , 'minecraft:rabbit'                 , 1, 1);
        addTrade(2, 'iceandfire:myrmex_jungle_resin'          , 1, 3   , 'minecraft:dye:2'                  , 1, 3);
        addTrade(3, 'iceandfire:myrmex_jungle_resin'          , 1, 3   , 'minecraft:iron_nugget'            , 1, 3);
        addTrade(3, 'iceandfire:myrmex_jungle_resin'          , 3, 6   , 'minecraft:chicken'                , 1, 1);
        addTrade(4, 'iceandfire:myrmex_jungle_resin'          , 1, 3   , 'minecraft:gold_nugget'            , 1, 3);
        addTrade(4, 'iceandfire:myrmex_jungle_resin'          , 5, 13  , 'iceandfire:ice_dragon_blood'      , 1, 3);
        addTrade(5, 'iceandfire:troll_tusk'                   , 1, 1   , 'iceandfire:myrmex_jungle_resin'   , 5, 15);
        addTrade(5, 'iceandfire:myrmex_jungle_resin'          , 20, 50 , 'minecraft:skull'                  , 1, 1);
        addTrade(6, 'iceandfire:myrmex_jungle_resin'          , 30, 60 , 'minecraft:skull:2'                , 1, 1);
        addTrade(6, 'iceandfire:myrmex_jungle_resin'          , 45, 64 , 'minecraft:skull:4'                , 1, 1);
        addTrade(10,'iceandfire:myrmex_jungle_resin_glass'    , 1, 3   , 'enderio:block_enderman_skull'     , 1, 1);
        addTrade(10,'iceandfire:myrmex_jungle_resin_glass'    , 2, 6   , 'enderio:item_material:47'         , 6, 12);
        addTrade(10,'iceandfire:myrmex_jungle_resin_glass'    , 2, 6   , 'enderio:item_material:46'         , 6, 12);

        desertMyrmexSentinel = VillagerProfession("iceandfire:desertMyrmexSentinel", defTexture, defTexture);
        career = VillagerCareer(desertMyrmexSentinel, "desert_myrmex_sentinel");
        addTrade(1, 'forestry:fruits:1'              , 32, 64 , 'iceandfire:myrmex_desert_resin'         , 32, 64);
        addTrade(1, 'forestry:fruits:2'              , 32, 64 , 'iceandfire:myrmex_desert_resin'         , 32, 64);
        addTrade(1, 'forestry:fruits:4'              ,  2,  4 , 'iceandfire:myrmex_desert_resin'         , 32, 64);
        addTrade(1, 'forestry:fruits:6'              ,  1,  2 , 'iceandfire:myrmex_desert_resin'         , 32, 64);
        addTrade(2, 'forestry:butterfly_ge'          , 1, 1   , 'iceandfire:myrmex_desert_resin_glass'   , 2, 3);
        addTrade(3, 'thermalfoundation:material:832' , 1, 3   , 'iceandfire:myrmex_desert_resin'         , 32, 64);
        addTrade(4, 'forestry:propolis'              , 1, 3   , 'iceandfire:myrmex_desert_resin'         , 32, 64);
        addTrade(5, 'forestry:propolis:2'            , 1, 3   , 'iceandfire:myrmex_desert_resin'         , 32, 64);
        addTrade(6, 'forestry:crafting_material:5'   , 1, 4   , 'iceandfire:myrmex_desert_resin_glass'   , 1, 1);
        addTrade(7, 'tconstruct:edible:31'           , 1, 5   , 'iceandfire:myrmex_desert_resin_glass'   , 1, 2);
        addTrade(7, 'tconstruct:edible:32'           , 1, 5   , 'iceandfire:myrmex_desert_resin_glass'   , 1, 2);
        addTrade(7, 'tconstruct:edible:33'           , 1, 5   , 'iceandfire:myrmex_desert_resin_glass'   , 1, 2);

        jungleMyrmexSentinel = VillagerProfession("iceandfire:jungleMyrmexSentinel", defTexture, defTexture);
        career = VillagerCareer(jungleMyrmexSentinel, "jungle_myrmex_sentinel");
        addTrade(1, 'forestry:fruits'                , 32, 64 , 'iceandfire:myrmex_jungle_resin'         , 8, 32);
        addTrade(1, 'forestry:fruits:3'              , 32, 64 , 'iceandfire:myrmex_jungle_resin'         , 32, 64);
        addTrade(1, 'forestry:fruits:5'              ,  2,  4 , 'iceandfire:myrmex_jungle_resin'         , 32, 64);
        addTrade(1, 'forestry:fruits:6'              ,  1,  2 , 'iceandfire:myrmex_jungle_resin'         , 32, 64);
        addTrade(2, 'forestry:butterfly_ge'          , 1, 1   , 'iceandfire:myrmex_jungle_resin_glass'   , 2, 3);
        addTrade(3, 'thermalfoundation:material:833' , 10, 40 , 'iceandfire:myrmex_jungle_resin'         , 32, 64);
        addTrade(4, 'forestry:propolis:1'            , 1, 3   , 'iceandfire:myrmex_jungle_resin'         , 32, 64);
        addTrade(5, 'forestry:propolis:3'            , 1, 3   , 'iceandfire:myrmex_jungle_resin'         , 32, 64);
        addTrade(6, 'forestry:crafting_material:5'   , 1, 4   , 'iceandfire:myrmex_jungle_resin_glass'   , 1, 1);
        addTrade(7, 'tconstruct:edible:30'           , 1, 5   , 'iceandfire:myrmex_jungle_resin_glass'   , 1, 2);
        addTrade(7, 'tconstruct:edible:34'           , 1, 5   , 'iceandfire:myrmex_jungle_resin_glass'   , 1, 2);
        addTrade(7, 'tconstruct:edible:33'           , 1, 5   , 'iceandfire:myrmex_jungle_resin_glass'   , 1, 2);

        desertMyrmexRoyal = VillagerProfession("iceandfire:desertMyrmexRoyal", defTexture, defTexture);
        career = VillagerCareer(desertMyrmexRoyal, "desert_myrmex_royal");
        addTrade(1,    'iceandfire:manuscript'                   , 1, 1   , 'iceandfire:myrmex_desert_resin'        , 4, 6);
        addTrade(1,    'iceandfire:myrmex_desert_resin'          , 1, 3   , 'ic2:crafting:23'                       , 50, 64);
        addTrade(1,    'iceandfire:myrmex_desert_resin'          , 50, 64 , 'ic2:crafting:24'                       , 50, 64);
        addTrade(5,    'iceandfire:myrmex_desert_resin_glass'    , 1, 3   , 'tconevo:edible'                        , 24, 48);
        addTrade(5,    'iceandfire:myrmex_desert_resin_glass'    , 1, 3   , 'thermalfoundation:fertilizer:2'        , 8, 16);
        addTrade(5,    'iceandfire:myrmex_desert_resin_glass'    , 1, 3   , 'iceandfire:shiny_scales'               , 32, 64);
        addTrade(5,    'iceandfire:myrmex_desert_resin_glass'    , 1, 3   , 'minecraft:sponge'                      , 12, 48);
        addTrade(5,    'iceandfire:myrmex_desert_resin_glass'    , 1, 3   , 'botania:manaresource:23'               , 1, 1);
        addTrade(10,   'iceandfire:myrmex_desert_resin_glass'    , 20, 30 , 'thermalfoundation:material:832'        , 10, 30);
        addTrade(10,   'iceandfire:myrmex_desert_resin_glass'    , 50, 64 , 'thermalfoundation:material:865'        , 1, 3);
        addTrade(10,   'iceandfire:myrmex_desert_resin_glass'    , 30, 40 , 'thermalfoundation:material:866'        , 1, 3);
        addTrade(10,   'iceandfire:myrmex_desert_resin_glass'    , 30, 64 , 'gendustry:honey_drop:15'               , 3, 9);
        addTrade(100,  'iceandfire:myrmex_desert_resin_glass'    , 50, 64 , 'environmentaltech:litherite_crystal'   , 1, 3);
        addTrade(1000, 'iceandfire:myrmex_desert_resin_glass'    , 50, 64 , 'qmd:isotope:6'                         , 1, 3);

        jungleMyrmexRoyal = VillagerProfession("iceandfire:jungleMyrmexRoyal", defTexture, defTexture);
        career = VillagerCareer(jungleMyrmexRoyal, "jungle_myrmex_royal");
        addTrade(1,    'iceandfire:manuscript'                   , 1, 1   , 'iceandfire:myrmex_jungle_resin'        , 4, 6);
        addTrade(1,    'iceandfire:myrmex_jungle_resin'          , 1, 3   , 'ic2:crafting:23'                       , 50, 64);
        addTrade(5,    'iceandfire:myrmex_jungle_resin'          , 50, 64 , 'ic2:crafting:24'                       , 50, 64);
        addTrade(5,    'iceandfire:myrmex_jungle_resin_glass'    , 1, 3   , 'tconevo:edible'                        , 24, 48);
        addTrade(5,    'iceandfire:myrmex_jungle_resin_glass'    , 1, 3   , 'thermalfoundation:fertilizer:2'        , 8, 16);
        addTrade(5,    'iceandfire:myrmex_jungle_resin_glass'    , 1, 3   , 'iceandfire:shiny_scales'               , 32, 64);
        addTrade(5,    'iceandfire:myrmex_jungle_resin_glass'    , 1, 3   , 'minecraft:sponge'                      , 12, 48);
        addTrade(5,    'iceandfire:myrmex_jungle_resin_glass'    , 1, 3   , 'botania:manaresource:23'               , 1, 1);
        addTrade(10,   'iceandfire:myrmex_jungle_resin_glass'    , 20, 30 , 'thermalfoundation:material:832'        , 10, 30);
        addTrade(10,   'iceandfire:myrmex_jungle_resin_glass'    , 50, 64 , 'thermalfoundation:material:865'        , 1, 3);
        addTrade(10,   'iceandfire:myrmex_jungle_resin_glass'    , 30, 40 , 'thermalfoundation:material:866'        , 1, 3);
        addTrade(10,   'iceandfire:myrmex_jungle_resin_glass'    , 30, 64 , 'gendustry:honey_drop:16'               , 3, 9);
        addTrade(100,  'iceandfire:myrmex_jungle_resin_glass'    , 50, 64 , 'environmentaltech:litherite_crystal'   , 1, 3);
        addTrade(1000, 'iceandfire:myrmex_jungle_resin_glass'    , 50, 64 , 'qmd:isotope:6'                         , 1, 3);

        desertMyrmexQueen = VillagerProfession("iceandfire:desertMyrmexQueen", defTexture, defTexture);
        career = VillagerCareer(desertMyrmexQueen, "desert_myrmex_queen");
        addTrade(1, 'iceandfire:myrmex_desert_resin'    , 1 , 10 , 'iceandfire:myrmex_desert_egg'           , 1, 1);
        addTrade(2, 'iceandfire:myrmex_desert_resin'    , 10, 20 , 'iceandfire:myrmex_desert_egg:1'         , 1, 1);
        addTrade(3, 'iceandfire:myrmex_desert_resin'    , 20, 30 , 'iceandfire:myrmex_desert_egg:2'         , 1, 1);
        addTrade(4, 'iceandfire:myrmex_desert_resin'    , 30, 40 , 'iceandfire:myrmex_desert_egg:3'         , 1, 1);
        addTrade(5, 'iceandfire:myrmex_desert_resin'    , 50, 64 , 'iceandfire:myrmex_desert_egg:4'         , 1, 1);
        addTrade(6, 'forestry:pollen_fertile'           , 4, 8   , 'iceandfire:myrmex_desert_resin_glass'   , 8, 16);
        addTrade(6, 'forestry:serum_ge'                 , 1, 1   , 'iceandfire:myrmex_desert_resin_glass'   , 16, 32);

        jungleMyrmexQueen = VillagerProfession("iceandfire:jungleMyrmexQueen", defTexture, defTexture);
        career = VillagerCareer(jungleMyrmexQueen, "jungle_myrmex_queen");
        addTrade(1, 'iceandfire:myrmex_jungle_resin'    , 1 , 10 , 'iceandfire:myrmex_jungle_egg'           , 1, 1);
        addTrade(2, 'iceandfire:myrmex_jungle_resin'    , 10, 20 , 'iceandfire:myrmex_jungle_egg:1'         , 1, 1);
        addTrade(3, 'iceandfire:myrmex_jungle_resin'    , 20, 30 , 'iceandfire:myrmex_jungle_egg:2'         , 1, 1);
        addTrade(4, 'iceandfire:myrmex_jungle_resin'    , 30, 40 , 'iceandfire:myrmex_jungle_egg:3'         , 1, 1);
        addTrade(5, 'iceandfire:myrmex_jungle_resin'    , 50, 64 , 'iceandfire:myrmex_jungle_egg:4'         , 1, 1);
        addTrade(6, 'forestry:pollen_fertile'           , 4, 8   , 'iceandfire:myrmex_jungle_resin_glass'   , 8, 16);
        addTrade(6, 'forestry:serum_ge'                 , 1, 1   , 'iceandfire:myrmex_jungle_resin_glass'   , 16, 32);
    }

    function addTrade(
        lvl as int,
        inpId as string, inpMin as int, inpMax as int,
        outId as string, outMin as int, outMax as int
    ) as void {
        val inpL = inpId.split(':');
        val inpItem = Item.REGISTRY.getObject(ResourceLocation(inpL[0], inpL[1])) as Item;
        if (isNull(inpItem)) {
            print('Skipping Myrmex trade. No item: ' ~ inpId);
            return;
        }

        val outL = outId.split(':');
        val outItem = Item.REGISTRY.getObject(ResourceLocation(outL[0], outL[1])) as Item;
        if (isNull(outItem)) {
            print('Skipping Myrmex trade. No item: ' ~ outId);
            return;
        }

        career.addTrade(lvl, BasicTrade(
            ItemStack(inpItem, 1, inpL.length < 3 ? 0 : inpL[2]),
            ItemStack(outItem, 1, outL.length < 3 ? 0 : outL[2]),
            PriceInfo(inpMin, inpMax),
            PriceInfo(outMin, outMax)
        ));
        print('Added Myrmex trade: ' ~ inpId ~ ' ' ~ inpMin ~ '-' ~ inpMax ~ ' => ' ~ outId ~ ' ' ~ outMin ~ '-' ~ outMax);
    }
}
