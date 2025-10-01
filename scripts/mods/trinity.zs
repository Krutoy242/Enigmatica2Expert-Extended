#modloaded trinity
#ignoreBracketErrors

import crafttweaker.item.IItemStack;

scripts.process.fill(<trinity:empty_fusion_bomb>, <fluid:liquidfusionfuel> * 1000, <trinity:fusion_bomb>, 'only: NCInfuser Transposer');
scripts.process.fill(<trinity:empty_fusion_bomb>, <fluid:deuterium-tritium_mixture> * 1000, <trinity:fusion_bomb>, 'only: Transposer');

// Contaminated Food alt
craft.make(<rats:contaminated_food> * 8, [
  'ooo',
  'oio',
  'ooo'], {
  o: <minecraft:apple>,
  i: <trinity:radioactive_earth>,
});

// Contaminated Food alt
craft.make(<rats:contaminated_food> * 64, [
  'ooo',
  'oio',
  'ooo'], {
  o: <ore:compressedCropApple1x>,
  i: <trinity:radioactive_earth2>,
});

// Non-tech alt
# [Vitrified Sand] from [Oxidized Ferric Sand][+6]
mods.thaumcraft.Infusion.registerRecipe(
  "vitrifiedsand", # Name
  "INFUSION", # Research
  <advancedrocketry:vitrifiedsand>, # Output
  1, # Instability
  Aspects('40⚡ 40💣'),
  <advancedrocketry:hotturf>, # Central Item
  Grid(["pretty",
  "s Q s",
  "P   P",
  "s Q s"], {
  "s": <ore:compressed2xSand>, # Sand
  "Q": <immersiveengineering:stone_decoration:9>, # Quickdry Concrete
  "P": <thaumcraft:stone_porous>, # Porous Stone
}).spiral(1));

# [Trinitite-covered Sand] from [Vitrified Sand][+1]
craft.shapeless(<trinity:trinitite>, "VO", {
  "V": <advancedrocketry:vitrifiedsand>, # Vitrified Sand
  "O": <botania:overgrowthseed>,         # Overgrowth Seed
});

// Replace Trinitite drop with Luck one
scripts.lib.dropt.addDrop(<trinity:trinitite>, [<trinity:trinitite_shard>]);

// Fix Trinity blocks have tool type "Pickaxe" instead of "pickaxe"
val pickaxeHarvestLevelItems = [
  <trinity:trinitite>,
  <trinity:thermonuclear_core_pu239>,
  <trinity:bomb_u233>,
  <trinity:bomb_u235>,
  <trinity:bomb_np237>,
  <trinity:bomb_pu239>,
  <trinity:bomb_am242>,
  <trinity:bomb_cm247>,
  <trinity:bomb_bk248>,
  <trinity:bomb_cf249>,
  <trinity:bomb_cf251>,
  <trinity:bomb_antimatter>,
  <trinity:salted_bomb_u233>,
  <trinity:salted_bomb_u235>,
  <trinity:salted_bomb_np237>,
  <trinity:salted_bomb_pu239>,
  <trinity:salted_bomb_am242>,
  <trinity:salted_bomb_cm247>,
  <trinity:salted_bomb_bk248>,
  <trinity:salted_bomb_cf249>,
  <trinity:salted_bomb_cf251>,
  <trinity:salted_core_u233>,
  <trinity:salted_core_u235>,
  <trinity:salted_core_np237>,
  <trinity:salted_core_pu239>,
  <trinity:salted_core_am242>,
  <trinity:salted_core_cm247>,
  <trinity:salted_core_bk248>,
  <trinity:salted_core_cf249>,
  <trinity:salted_core_cf251>,
  <trinity:core_u233>,
  <trinity:core_u235>,
  <trinity:core_np237>,
  <trinity:core_pu239>,
  <trinity:core_am242>,
  <trinity:core_cm247>,
  <trinity:core_bk248>,
  <trinity:core_cf249>,
  <trinity:core_cf251>,
] as IItemStack[];

for item in pickaxeHarvestLevelItems {
  item.asBlock().definition.setHarvestLevel("pickaxe", 1);
}
