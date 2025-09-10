#reloadable
#modloaded appliedenergistics2 qmd

import crafttweaker.item.IItemDefinition;
import crafttweaker.item.IItemStack;

val morphiteAEBlacklist = [
  <appliedenergistics2:charged_quartz_ore>.definition,
  <appliedenergistics2:chiseled_quartz_block>.definition,
  <appliedenergistics2:chiseled_quartz_slab>.definition,
  <appliedenergistics2:chiseled_quartz_stairs>.definition,
  <appliedenergistics2:material>.definition,
  <appliedenergistics2:quartz_block>.definition,
  <appliedenergistics2:quartz_ore>.definition,
  <appliedenergistics2:quartz_pillar_slab>.definition,
  <appliedenergistics2:quartz_pillar_stairs>.definition,
  <appliedenergistics2:quartz_pillar>.definition,
  <appliedenergistics2:quartz_slab>.definition,
  <appliedenergistics2:quartz_stairs>.definition,
] as IItemDefinition[];

for item in loadedMods['appliedenergistics2'].items {
  val id = item.definition.id;
  if (
    morphiteAEBlacklist has item.definition
    || item.hasTag
    || id.contains('creative')
  ) continue;
  val count = id.contains(':paint_ball') ? 64
    : id.contains(':part') ? (
      item.damage < 20 ? 32 // Cable
      : (item.damage >= 20 && item.damage < 60) ? 16 // Cables
      : (item.damage >= 60 && item.damage < 160) ? 8 // Smart dense & fibers
      : (item.damage >= 500 && item.damage < 520) ? 8 // Dense
      : 1
    ) : 1;
  scripts.do.morphite.recipe.result.add(count > 1 ? item * count : item);
}

static morphiteARBlacklist as IItemStack[] = [
  <advancedrocketry:concrete>,
  <libvulpes:creativepowerbattery>,
  <libvulpes:metal0:6>,
  <libvulpes:metal0:7>,
  <libvulpes:ore0:4>,
  <libvulpes:ore0:5>,
  <libvulpes:ore0:9>,
  <libvulpes:ore0:10>,
  <libvulpes:ore0>,
  <libvulpes:productdust:1>,
  <libvulpes:productdust:2>,
  <libvulpes:productdust:3>,
  <libvulpes:productdust:4>,
  <libvulpes:productdust:5>,
  <libvulpes:productdust:6>,
  <libvulpes:productdust:9>,
  <libvulpes:productdust:10>,
  <libvulpes:productgear:6>,
  <libvulpes:productingot:4>,
  <libvulpes:productingot:5>,
  <libvulpes:productingot:6>,
  <libvulpes:productingot:9>,
  <libvulpes:productingot:10>,
  <libvulpes:productnugget:4>,
  <libvulpes:productnugget:5>,
  <libvulpes:productnugget:6>,
  <libvulpes:productnugget:9>,
  <libvulpes:productnugget:10>,
  <libvulpes:productrod:1>,
  <libvulpes:productrod:6>,
];

function addAR(item as IItemStack, blacklist as IItemStack[]) as void {
  val id = item.definition.id;
  if (item.hasTag) return;
  for black in blacklist { if (black.matches(item)) return; }
  val count = id.contains('structuremachine') ? 64 : 1;
  scripts.do.morphite.recipe.result.add(count > 1 ? item * count : item);
}

for item in loadedMods['libvulpes'].items { addAR(item, morphiteARBlacklist); }
for item in loadedMods['advancedrocketry'].items { addAR(item, morphiteARBlacklist); }

val TEWhitelist = [
  <thermalexpansion:machine>.definition,
  <thermalexpansion:device>.definition,
  <thermalexpansion:cell>.definition,
  <thermalfoundation:upgrade>.definition,
  <thermalexpansion:augment>.definition,
] as IItemDefinition[];

for item in loadedMods['thermalexpansion'].items {
  val id = item.definition.id;
  if (!(TEWhitelist has item.definition)) continue;
  scripts.do.morphite.recipe.result.add(item);
}

for item in loadedMods['thermalfoundation'].items {
  val id = item.definition.id;
  if (!(TEWhitelist has item.definition) || <thermalfoundation:upgrade:256> has item) continue;
  scripts.do.morphite.recipe.result.add(item);
}
