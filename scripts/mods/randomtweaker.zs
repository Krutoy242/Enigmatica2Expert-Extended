#modloaded randomtweaker tconstruct

import mods.randomtweaker.tconstruct.IBook.changeMaterialItem;
import mods.randomtweaker.tconstruct.IBook.setMaterialPriority;

// changeMaterialItem('sunnarium', <minecraft:double_plant>);
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

for matName, power in scripts.equipment.equipData.defaultWeaponMats {
  setMaterialPriority(matName, power);
}
