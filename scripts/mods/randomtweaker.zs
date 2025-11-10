#modloaded tconstruct

import mods.randomtweaker.tconstruct.IBook.changeMaterialItem;
import mods.randomtweaker.tconstruct.IBook.setMaterialPriority;

import scripts.equipment.equipData.defaultWeaponMats;

changeMaterialItem('sunnarium', <minecraft:double_plant>);
// changeMaterialItem('dark_matter', ???);
// changeMaterialItem('red_matter', ???);
changeMaterialItem('fusewood', <botania:shimmerwoodplanks>);
changeMaterialItem('bloodwood', <animus:blockbloodwood>);
changeMaterialItem('ghostwood', <iceandfire:dreadwood_log>);
changeMaterialItem('darkwood', <advancedrocketry:alienwood>);
changeMaterialItem('xu_magical_wood', <extrautils2:decorativesolidwood:1>);
changeMaterialItem('xu_demonic_metal', <extrautils2:ingredients:11>);
changeMaterialItem('xu_enchanted_metal', <extrautils2:ingredients:12>);
changeMaterialItem('xu_evil_metal', <extrautils2:ingredients:17>);

// Find median power
var length = 0;
for m, p in defaultWeaponMats { length += 1; }
var medianPower = 0;
var k = 0;
for m, p in defaultWeaponMats { if (k == length / 2) { medianPower = p; break; } k += 1; }

// Sort entries and place unknown materials in center of the list
for matName, power in defaultWeaponMats {
  setMaterialPriority(matName, power - medianPower);
}
