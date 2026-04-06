#modloaded quark
#loader mixin

import native.java.util.Random;
import native.net.minecraft.item.Item;
import native.net.minecraft.item.ItemStack;
import native.net.minecraft.util.ResourceLocation;
import native.net.minecraft.village.MerchantRecipe;
import native.net.minecraft.village.MerchantRecipeList;
import native.net.minecraft.entity.item.EntityItem;

#mixin {targets: "vazkii.quark.world.entity.EntityArchaeologist"}
zenClass MixinEntityArchaeologist {
    #mixin Shadow
    var buyingList as MerchantRecipeList;

    #mixin Overwrite
    function populateBuyingList() as void {
        if (isNull(buyingList)) buyingList = MerchantRecipeList();

        addTrade('emerald'                    , 2 , 5, 'book'                                               , 4, 6);
        addTrade('emerald'                    , 2 , 6, 'diamond'                                            , 0, 1);
        addTrade('emerald'                    , 0 , 1, 'iceandfire:dread_torch'                             , 0, 1);
        addTrade('emerald'                    , 0 , 1, 'iceandfire:dragonbone'                              , 1, 3);
        addTrade('emerald'                    , 2 , 8, 'iceandfire:manuscript'                              , 0, 4);
        addTrade('emerald'                    , 2 , 4, 'rustic:vase'                                        , 1, 3);
        addTrade('emerald'                    , 8 , 8, 'forestry:digger_bag_t2'                             , 0, 1);
        addTrade('emerald'                    , 8 , 8, 'forestry:miner_bag_t2'                              , 0, 1);
        addTrade('emerald'                    , 0, 10, 'astralsorcery:itemknowledgeshare'                   , 0, 1);
        addTrade('emerald'                    , 0, 10, 'thaumcraft:loot_urn_uncommon'                       , 0, 1);
        addTrade('emerald'                    , 6, 12, 'oeintegration:excavatemodifier'                     , 0, 1);
        addTrade('emerald'                    , 4, 18, 'chisel:chisel_hitech'                               , 0, 1);
        addTrade('emerald'                    , 4, 22, 'actuallyadditions:item_drill_upgrade_three_by_three', 0, 1);
        addTrade('emerald'                    , 4, 24, 'actuallyadditions:item_drill_upgrade_five_by_five'  , 0, 1);
        addTrade('emerald'                    , 4, 26, 'iceandfire:dread_key'                               , 0, 1);
        addTrade('book'                       , 3 , 6, 'emerald'                                            , 0, 1);
        addTrade('coal'                       , 5 , 5, 'emerald'                                            , 0, 1);
        addTrade('iron_ingot'                 , 3 , 8, 'emerald'                                            , 0, 1);
        addTrade('gold_ingot'                 , 2 , 6, 'emerald'                                            , 0, 1);
        addTrade('forestry:bronze_shovel'     , 0 , 1, 'emerald'                                            , 4, 10);
        addTrade('forestry:bronze_pickaxe'    , 0 , 1, 'emerald'                                            , 5, 13);
        addTrade('cyclicmagic:dynamite_mining', 0 , 1, 'emerald'                                            , 2, 4);
        addTrade('ic2:dynamite'               , 0 , 1, 'emerald'                                            , 0, 1);
        addTrade('ic2:dynamite_sticky'        , 0 , 1, 'emerald'                                            , 0, 1);
        addTrade('cyclicmagic:dynamite_safe'  , 0 , 1, 'emerald'                                            , 3, 6);
        addTrade('cyclicmagic:ender_tnt_6'    , 0 , 1, 'emerald'                                            , 4, 8);
        addTrade('tconstruct:throwball:1'     , 0 , 1, 'emerald'                                            , 3, 9);
    }
    
    function addTrade(
        inpId as string, inpMin as int, inpMax as int,
        outId as string, outMin as int, outMax as int
    ) as void {
        val r = this0.world.rand;
        val inpCount = inpMin + r.nextInt(inpMax - inpMin + 1);
        val outCount = outMin + r.nextInt(outMax - outMin + 1);
        if (inpCount <= 0 || outCount <= 0) return;

        val inpL = inpId.split(':');
        val inpItem = inpL.length <= 1
            ? Item.REGISTRY.getObject(ResourceLocation('minecraft', inpL[0])) as Item
            : Item.REGISTRY.getObject(ResourceLocation(inpL[0], inpL[1]));
        if (isNull(inpItem)) {
            print('Skipping Archaeologist trade. No item: ' ~ inpId);
            return;
        }

        val outL = outId.split(':');
        val outItem = outL.length <= 1
            ? Item.REGISTRY.getObject(ResourceLocation('minecraft', outL[0])) as Item
            : Item.REGISTRY.getObject(ResourceLocation(outL[0], outL[1]));
        if (isNull(outItem)) {
            print('Skipping Archaeologist trade. No item: ' ~ outId);
            return;
        }

        buyingList.add(MerchantRecipe(
            ItemStack(inpItem, inpCount, inpL.length < 3 ? 0 : inpL[2]),
            ItemStack(outItem, outCount, outL.length < 3 ? 0 : outL[2])
        ));
        print('Added Archaeologist trade: ' ~ inpId ~ ' ' ~ inpMin ~ '-' ~ inpMax ~ ' => ' ~ outId ~ ' ' ~ outMin ~ '-' ~ outMax);
    }
}

//Restore default minecraft logic (quark hardcoded some logic with created always cooked frog leg) 
#mixin {targets: "vazkii.quark.world.entity.EntityFrog"}
zenClass MixinEntityFrogDrop {
    #mixin Overwrite
    function func_70099_a(stack as ItemStack, offsetY as float) as EntityItem {
        if (stack.isEmpty()) return null;

        val entityitem = EntityItem(this0.world, this0.posX, this0.posY + offsetY, this0.posZ, stack);

        entityitem.setDefaultPickupDelay();
        this0.world.spawnEntity(entityitem);

        return entityitem;
    }
}
