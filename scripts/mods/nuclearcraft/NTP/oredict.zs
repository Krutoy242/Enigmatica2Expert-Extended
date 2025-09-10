#modloaded nuclearcraft
#priority 2147483647
#ignoreBracketErrors

import crafttweaker.item.IItemStack;
import crafttweaker.oredict.IOreDictEntry;

function add(ore as IOreDictEntry, item as IItemStack) as void {
  if (isNull(item)) return;
  ore.add(item);
}

add(<ore:ingotElektron60>, <contenttweaker:elektron60_ingot>);
add(<ore:blockElektron60>, <contenttweaker:elektron60_block>);
add(<ore:tbladeSteel>, <nuclearcraft:turbine_rotor_blade_steel>);
add(<ore:tbladeExtreme>, <nuclearcraft:turbine_rotor_blade_extreme>);
add(<ore:tbladeSiCSiCCmC>, <nuclearcraft:turbine_rotor_blade_sic_sic_cmc>);
add(<ore:tbladeSuperAlloy>, <qmd:turbine_blade_super_alloy>);
