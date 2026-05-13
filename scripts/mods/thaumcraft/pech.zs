#ignoreBracketErrors
#modloaded thaumictweaker
#priority 1000

import crafttweaker.item.IItemStack;
import mods.thaumictweaker.PechTrades;

static trades as IItemStack[][][string] = {
  MINER: [[
    <extrautils2:compressedcobblestone:2>,
    <jaopca:item_clustertungsten>,
    <thaumcraft:cluster:4>,
    <jaopca:item_clusterdraconium>,
    <jaopca:item_clustertitanium>,
    <jaopca:item_clusterruby>,
  ], [
    <extrautils2:compresseddirt:2>,
    <jaopca:item_clusteriridium>,
    <jaopca:item_clusterastralstarmetal>,
    <thaumcraft:thaumium_pick>,
    <thaumcraft:thaumium_shovel>,
    <thaumcraft:thaumium_axe>,
  ], [
    <extrautils2:compressednetherrack:2>,
    <jaopca:item_clustermithril>,
    <jaopca:item_clustertanzanite>,
    <astralsorcery:blockcelestialcrystals:4>,
    <thaumcraft:turret:2>,
    <twilightforest:ore_magnet>,
  ], [
    <mysticalagriculture:rock_crystal_essence>,
    <thaumicwonders:transmuter_stone>,
    <twilightforest:twilight_sapling:7>,
    <cyclicmagic:storage_bag>,
    <thaumcraft:elemental_pick>.withTag(utils.sNBT('{infench:[{lvl:1s,id:4s},{lvl:2s,id:3s}]}')),
    <actuallyadditions:quartz_paxel>,
  ], [
    <bloodmagic:demon_crystal>,
    <jaopca:item_crystalshardsilver>,
    <jaopca:item_crystalshardmithril>,
    <astralsorcery:blockgemcrystals:2>,
    <astralsorcery:blockgemcrystals:3>,
    <astralsorcery:blockgemcrystals:4>,
  ]],
  MAGE: [[
    <thaumcraft:phial:1>.withTag(utils.sNBT('{Aspects: [{amount: 10, key: "aer"}]}')),
    <thaumcraft:phial:1>.withTag(utils.sNBT('{Aspects: [{amount: 10, key: "terra"}]}')),
    <thaumcraft:phial:1>.withTag(utils.sNBT('{Aspects: [{amount: 10, key: "ignis"}]}')),
    <thaumcraft:phial:1>.withTag(utils.sNBT('{Aspects: [{amount: 10, key: "aqua"}]}')),
    <thaumcraft:phial:1>.withTag(utils.sNBT('{Aspects: [{amount: 10, key: "perditio"}]}')),
    <thaumcraft:phial:1>.withTag(utils.sNBT('{Aspects: [{amount: 10, key: "ordo"}]}')),
  ], [
    <thaumcraft:cloth_chest>,
    <thaumcraft:cloth_legs>,
    <thaumcraft:cloth_boots>,
    <thaumcraft:thaumometer>,
    <darkutils:charm_null>,
    <darkutils:charm_portal>,
  ], [
    <thaumcraft:goggles>,
    <thaumcraft:baubles:3>,
    <conarm:travel_soul>,
    <cyclicmagic:charm_antidote>,
    <cyclicmagic:charm_boat>,
    <cyclicmagic:charm_fire>,
  ], [
    <thaumcraft:lamp_arcane>,
    <twilightforest:charm_of_life_2>,
    <twilightforest:charm_of_keeping_3>,
    <iceandfire:pixie_dust>,
    <extrautils2:ingredients:12>,
    <thaumicwonders:panacea:1>,
  ], [
    <thaumcraft:pech_wand>,
    <thaumcraft:amulet_vis>,
    <thaumcraft:charm_undying>,
    <botania:overgrowthseed>,
    <randomthings:beans:2>,
    <mysticalagriculture:growth_accelerator>,
  ]],
  ARCHER: [[
    <forestry:hunter_bag>,
    <cyclicmagic:water_candle>,
    <rats:rat_arrow>,
    <forestry:hunter_bag_t2>,
    <thaumcraft:candle_white>,
    <cyclicmagic:sleeping_mat>,
  ], [
    <cyclicmagic:sack_ender>,
    <rustic:silver_lantern>,
    <cyclicmagic:glove_climb>,
    <cyclicmagic:wand_missile>,
    <minecraft:enchanted_book>.withTag(utils.sNBT('{StoredEnchantments: [{lvl: 1s, id: 51}]}')),
    <minecraft:enchanted_book>.withTag(utils.sNBT('{StoredEnchantments: [{lvl: 1s, id: 78}]}')),
  ], [
    <tconstruct:bow_string>.withTag(utils.sNBT('{Material: "soularium"}')),
    <tconstruct:bow_limb>.withTag(utils.sNBT('{Material: "ghostwood"}')),
    <tconstruct:bow_limb>.withTag(utils.sNBT('{Material: "ionite"}')),
    <cyclicmagic:ender_lightning>,
    <tconstruct:bow_string>.withTag(utils.sNBT('{Material: "fluxed_string"}')),
    <endreborn:item_ender_string>,
  ], [
    <conarm:travel_sack>,
    <tconstruct:bow_string>.withTag(utils.sNBT('{Material: "spectre_string"}')),
    <tconstruct:bow_limb>.withTag(utils.sNBT('{Material: "aethium"}')),
    <tconstruct:bow_limb>.withTag(utils.sNBT('{Material: "gelid_gem"}')),
    <cyclicmagic:wand_hypno>,
    <minecraft:enchanted_book>.withTag(utils.sNBT('{StoredEnchantments: [{lvl: 1s, id: 70}]}')),
  ], [
    <minecraft:dragon_breath>,
    <cyclicmagic:storage_bag>,
    <thaumicwonders:bone_bow>,
    <minecraft:enchanted_book>.withTag(utils.sNBT('{StoredEnchantments: [{lvl: 10s, id: 48}]}')),
    <minecraft:enchanted_book>.withTag(utils.sNBT('{StoredEnchantments: [{lvl: 4s, id: 49}]}')),
    <minecraft:enchanted_book>.withTag(utils.sNBT('{StoredEnchantments: [{lvl: 6s, id: 65}]}')),
  ]],
  COMMON: [[
    <mysticalagriculture:inferium_apple> * 2,
    <extrautils2:magicapple> * 4,
    <thaumcraft:curio:1> * 4,
    <rustic:fluid_bottle>.withTag(utils.sNBT('{Fluid: {FluidName: "ironwine", Amount: 1000, Tag: {Quality: 1.0f}}}')),
    <rustic:fluid_bottle>.withTag(utils.sNBT('{Fluid: {FluidName: "wine", Amount: 1000, Tag: {Quality: 1.0f}}}')),
    <rustic:fluid_bottle>.withTag(utils.sNBT('{Fluid: {FluidName: "mead", Amount: 1000, Tag: {Quality: 1.0f}}}')),
  ], [
    <mysticalagriculture:prudentium_apple>,
    <thaumicenergistics:blank_knowledge_core> * 2,
    <thaumcraft:curio:5> * 4,
    <tconstruct:materials:19> * 5,
    <cyclicmagic:apple>,
    <thaumcraft:lamp_arcane>,
  ], [
    <mysticalagriculture:intermedium_apple>,
    <minecraft:golden_apple> * 4,
    <thaumcraft:curio> * 4,
    <thaumcraft:curio:2> * 4,
    <thaumadditions:dawn_totem>,
    <thaumadditions:twilight_totem>,
  ], [
    <mysticalagriculture:superium_apple>,
    <minecraft:golden_apple:1>,
    <thaumcraft:curio:4> * 5,
    <thaumcraft:sanity_soap>,
    <thaumcraft:mechanism_complex>,
    <bloodmagic:soul_snare>,
  ], [
    <mysticalagriculture:supremium_apple>,
    <tinkersaddons:modifier_item:3>,
    <thaumcraft:curio:3> * 6,
    <thaumadditions:zeith_fur> * 3,
    <minecraft:totem_of_undying> * 3,
    <thaumadditions:jar_eldritch>,
  ]],
} as IItemStack[][][string]$orderly;

for type, levels in trades {
  for level, items in levels {
    for item in items {
      if (isNull(item)) continue;
      PechTrades.addTrade(type, level + 1, item);
    }
  }
}
