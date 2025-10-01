#norun // WIP for roidtweaker migration

#modloaded roidtweaker

import crafttweaker.item.IItemStack;
import crafttweaker.util.IRandom;
import mods.roidtweaker.minecraft.villager.IVillagerCareer;
import mods.roidtweaker.minecraft.villager.Villager;

function halfTrade(career as IVillagerCareer, level as int, fnc as function(IRandom)IItemStack[]) as function(IRandom)IItemStack[] {
  career.addTradeAdvanced(level, function (r as IRandom) as IItemStack[] {
    if (r.nextFloat() < 0.5) return null;
    return fnc(r);
  });
}

// --- Alchemist Trades ---
val alchemist = Villager.getCareer('extrautils2:alchemist', 'alchemist');

if (!isNull(alchemist)) {
  halfTrade(alchemist, 2, function (r as IRandom) as IItemStack[] {
    return [<minecraft:emerald> * (2 + r.nextInt(7)), <minecraft:nether_wart> * (8 + r.nextInt(9)), null];
  });
  halfTrade(alchemist, 2, function (r as IRandom) as IItemStack[] {
    return [<minecraft:emerald> * (2 + r.nextInt(7)), <ic2:terra_wart> * (8 + r.nextInt(9)), null];
  });
  halfTrade(alchemist, 2, function (r as IRandom) as IItemStack[] {
    return [<minecraft:emerald> * (2 + r.nextInt(7)), <ic2:crop_res:6> * (8 + r.nextInt(9)), null];
  });
  halfTrade(alchemist, 2, function (r as IRandom) as IItemStack[] {
    return [<minecraft:emerald> * (2 + r.nextInt(7)), <minecraft:gunpowder> * (8 + r.nextInt(9)), null];
  });
  halfTrade(alchemist, 2, function (r as IRandom) as IItemStack[] {
    return [<minecraft:emerald> * (2 + r.nextInt(7)), <minecraft:glowstone_dust> * (8 + r.nextInt(9)), null];
  });

  halfTrade(alchemist, 3, function (r as IRandom) as IItemStack[] {
    return [<minecraft:emerald> * (2 + r.nextInt(7)), <rustic:retort> * (1 + r.nextInt(3)), null];
  });
  halfTrade(alchemist, 3, function (r as IRandom) as IItemStack[] {
    return [<minecraft:emerald> * (2 + r.nextInt(7)), <rustic:condenser> * 1, null];
  });
  halfTrade(alchemist, 3, function (r as IRandom) as IItemStack[] {
    return [<minecraft:emerald> * (2 + r.nextInt(7)), <rustic:retort_advanced> * (1 + r.nextInt(3)), null];
  });
  halfTrade(alchemist, 3, function (r as IRandom) as IItemStack[] {
    return [<minecraft:emerald> * (2 + r.nextInt(7)), <rustic:condenser_advanced> * 1, null];
  });

  halfTrade(alchemist, 4, function (r as IRandom) as IItemStack[] {
    return [
      <iceandfire:manuscript> * (1 + r.nextInt(3)),
      <minecraft:emerald> * (2 + r.nextInt(7)),
      <minecraft:paper> * (6 + r.nextInt(9)),
    ];
  });
}

// --- Apiarist Trades ---
val apiarist = Villager.getCareer('forestry:apiarist', 'apiarist');

if (!isNull(apiarist)) {
  halfTrade(apiarist, 5, function (r as IRandom) as IItemStack[] {
    return [<harvestcraft:honeyitem> * (1 + r.nextInt(9)), <minecraft:emerald> * (2 + r.nextInt(5)), null];
  });

  halfTrade(apiarist, 5, function (r as IRandom) as IItemStack[] {
    return [<harvestcraft:grubitem> * (5 + r.nextInt(16)), <minecraft:emerald> * (1 + r.nextInt(6)), null];
  });

  halfTrade(apiarist, 5, function (r as IRandom) as IItemStack[] {
    return [<rustic:honeycomb> * (1 + r.nextInt(5)), <minecraft:emerald> * (2 + r.nextInt(6)), null];
  });

  halfTrade(apiarist, 5, function (r as IRandom) as IItemStack[] {
    return [<rustic:beeswax> * (3 + r.nextInt(8)), <minecraft:emerald> * (1 + r.nextInt(4)), null];
  });

  halfTrade(apiarist, 5, function (r as IRandom) as IItemStack[] {
    return [<minecraft:emerald> * (3 + r.nextInt(5)), <exnihilocreatio:hive> * (1 + r.nextInt(3)), null];
  });
}
