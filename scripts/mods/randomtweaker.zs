#modloaded randomtweaker
#norun

mods.randomtweaker.tconstruct.IBook.changeMaterialItem('fusewood', <botania:shimmerwoodplanks>);
mods.randomtweaker.tconstruct.IBook.changeMaterialItem('xu_magical_wood', <extrautils2:decorativesolidwood:1>);

for matName, power in scripts.equipment.equipData.defaultWeaponMats {
  mods.randomtweaker.tconstruct.IBook.setMaterialPriority(matName, power);
}
