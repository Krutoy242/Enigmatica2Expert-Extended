#modloaded thaumcraft
#ignoreBracketErrors

import crafttweaker.item.IItemStack;

/*
██████╗ ███████╗███╗   ███╗ ██████╗ ██╗   ██╗███████╗     █████╗ ██╗     ██╗          █████╗ ███████╗██████╗ ███████╗ ██████╗████████╗███████╗
██╔══██╗██╔════╝████╗ ████║██╔═══██╗██║   ██║██╔════╝    ██╔══██╗██║     ██║         ██╔══██╗██╔════╝██╔══██╗██╔════╝██╔════╝╚══██╔══╝██╔════╝
██████╔╝█████╗  ██╔████╔██║██║   ██║██║   ██║█████╗      ███████║██║     ██║         ███████║███████╗██████╔╝█████╗  ██║        ██║   ███████╗
██╔══██╗██╔══╝  ██║╚██╔╝██║██║   ██║╚██╗ ██╔╝██╔══╝      ██╔══██║██║     ██║         ██╔══██║╚════██║██╔═══╝ ██╔══╝  ██║        ██║   ╚════██║
██║  ██║███████╗██║ ╚═╝ ██║╚██████╔╝ ╚████╔╝ ███████╗    ██║  ██║███████╗███████╗    ██║  ██║███████║██║     ███████╗╚██████╗   ██║   ███████║
╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝ ╚═════╝   ╚═══╝  ╚══════╝    ╚═╝  ╚═╝╚══════╝╚══════╝    ╚═╝  ╚═╝╚══════╝╚═╝     ╚══════╝ ╚═════╝   ╚═╝   ╚══════╝
*/

val removeItemAspectList = [
<actuallyadditions:item_bag>,
<actuallyadditions:item_void_bag>,
<aeadditions:storage.component:1>,
<aeadditions:storage.component:2>,
<aeadditions:storage.component:3>,
<aeadditions:storage.component>,
<aeadditions:storage.physical:1>,
<aeadditions:storage.physical:2>,
<aeadditions:storage.physical:3>,
<aeadditions:storage.physical>,
<akashictome:tome:*>,
<appliedenergistics2:wireless_crafting_terminal>,
<appliedenergistics2:wireless_terminal>,
<bloodmagic:upgrade_trainer>,
<botania:flowerbag:*>,
<botania:flowerbag>,
<conarm:armor_trim>,
<conarm:armorforge>,
<cyclicmagic:storage_bag>,
<enderio:item_soul_vial:1>,
<enderstorage:ender_pouch:*>,
<extrautils2:biomemarker>,
<forestry:adventurer_bag_t2>,
<forestry:adventurer_bag>,
<forestry:apiarist_bag>,
<forestry:builder_bag_t2>,
<forestry:builder_bag>,
<forestry:can:1>,
<forestry:capsule:1>,
<forestry:digger_bag_t2>,
<forestry:digger_bag>,
<forestry:forester_bag_t2>,
<forestry:forester_bag>,
<forestry:hunter_bag_t2>,
<forestry:hunter_bag>,
<forestry:lepidopterist_bag>,
<forestry:miner_bag_t2>,
<forestry:miner_bag>,
<forestry:refractory:1>,
<forge:bucketfilled>,
<gendustry:gene_template>,
<ic2:fluid_cell>,
<immersivepetroleum:schematic>,
<littletiles:container>,
<rftools:storage_module_tablet>,
<rftools:syringe>,
<spiceoflife:lunchbag:*>,
<spiceoflife:lunchbox>,
<tconstruct:shard>,
<tconstruct:toolforge>,
<tconstruct:tooltables:*>,
<thaumadditions:crystal_bag>,
<thaumadditions:dna_sample>,
<thaumadditions:seal_symbol>,
<thaumcraft:focus_pouch:*>,
// <thaumicaugmentation:biome_selector>,
<thermalexpansion:florb:1>,
<thermalexpansion:florb>,
<thermalexpansion:morb>,
<thermalexpansion:satchel:*>,
<travelersbackpack:travelers_backpack:*>,
<endreborn:food_ender_flesh>,
<aeadditions:storage.physical>,
<aeadditions:storage.physical:1>,
<aeadditions:storage.physical:2>,
<aeadditions:storage.physical:3>,
<aeadditions:storage.component>,
<aeadditions:storage.component:1>,
<aeadditions:storage.component:2>,
<aeadditions:storage.component:3>,
<ic2:dust>,
<forestry:ingot_bronze>,
<mekanism:ingot:2>,
] as IItemStack[];
for item in removeItemAspectList {
  if (isNull(item)) continue;
  native.thaumcraft.api.ThaumcraftApi.registerObjectTag(item, null);
}
