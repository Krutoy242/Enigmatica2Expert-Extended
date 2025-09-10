#loader nc_preinit
#modloaded nuclearcraft

import scripts.mods.nuclearcraft.NTP.coilclasses.LiquidStabilizerInfo;
import scripts.mods.nuclearcraft.NTP.coilclasses.StabilizerInfo;
import scripts.mods.nuclearcraft.NTP.coilstabilizerlist.LiquidStabilizerInfoList;
import scripts.mods.nuclearcraft.NTP.coilstabilizerlist.StabilizerInfoList;

function registerStabilizer(info as StabilizerInfo) {
  val naming = info.name;
  val lowercase = naming.toLowerCase();
  mods.nuclearcraft.Registration.registerTurbineCoil(`${lowercase}stabilizer`, info.efficiency, info.rule);
}

for info in StabilizerInfoList {
  registerStabilizer(info);
}

function registerLiquidStabilizer(info as LiquidStabilizerInfo) {
  val naming = info.name;
  val lowercase = naming.toLowerCase();
  mods.nuclearcraft.Registration.registerTurbineCoil(`${lowercase}stabilizer`, info.efficiency, info.rule);
}

for info in LiquidStabilizerInfoList {
  registerLiquidStabilizer(info);
}

mods.nuclearcraft.Registration.registerTurbineCoil('basestabilizer', 0.20, 'one basemagnet coil');
mods.nuclearcraft.Registration.registerTurbineCoil('antideuteriumstabilizer', 2.50, 'one antihydrogenmagnet coil || one iodinestabilizer coil');
