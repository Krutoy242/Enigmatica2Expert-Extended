#ignoreBracketErrors
#modloaded bpopener
#sideonly client

import crafttweaker.item.IItemStack;
import mods.bpopener.BPOpener.addEntry;

function add(item as IItemStack, shift as bool = false) as void {
  if (isNull(item)) return;
  addEntry(item, shift);
}

add(<actuallyadditions:item_bag>);
add(<actuallyadditions:item_void_bag>);
add(<actuallyadditions:item_crafter_on_a_stick>);
add(<appliedenergistics2:portable_cell>);
add(<appliedenergistics2:wireless_terminal>);
add(<cyclicmagic:sack_ender>);
add(<cyclicmagic:storage_bag>);
add(<danknull:dank_null_0>, true);
add(<danknull:dank_null_1>, true);
add(<danknull:dank_null_2>, true);
add(<danknull:dank_null_3>, true);
add(<danknull:dank_null_4>, true);
add(<danknull:dank_null_5>, true);
add(<danknull:dank_null_6>, true);
add(<enderstorage:ender_pouch>);
add(<forestry:adventurer_bag_t2>);
add(<forestry:adventurer_bag>);
add(<forestry:apiarist_bag>);
add(<forestry:builder_bag_t2>);
add(<forestry:builder_bag>);
add(<forestry:digger_bag_t2>);
add(<forestry:digger_bag>);
add(<forestry:forester_bag_t2>);
add(<forestry:forester_bag>);
add(<forestry:hunter_bag_t2>);
add(<forestry:hunter_bag>);
add(<forestry:lepidopterist_bag>);
add(<forestry:miner_bag_t2>);
add(<forestry:miner_bag>);
add(<littletiles:container>);
add(<openblocks:dev_null>, true);
add(<rftools:storage_module_tablet:1>);
add(<thaumcraft:hand_mirror>);
add(<thaumcraft:focus_pouch>);
add(<thaumictinkerer:focus_pouch>);
add(<thaumadditions:crystal_bag>);
add(<thermalexpansion:satchel:*>);
add(<travelersbackpack:travelers_backpack:*>);
add(<botania:flowerbag>);
add(<aeadditions:terminal.universal.wireless>);
add(<aeadditions:terminal.gas.wireless>);
add(<ae2fc:wireless_fluid_pattern_terminal>);
add(<appliedenergistics2:wireless_terminal>);
add(<appliedenergistics2:wireless_crafting_terminal>);
add(<appliedenergistics2:wireless_pattern_terminal>);
add(<appliedenergistics2:wireless_fluid_terminal>);
add(<computercraft:pocket_computer>);
add(<enderio:item_inventory_remote:*>);
add(<scannable:scanner>, true);
