#modloaded customfishing

import crafttweaker.item.IItemStack;
import crafttweaker.liquid.ILiquidStack;
import mods.customfishing.FishingInCustomLiquid.inLiquidItemChancePoolDimBiome;

val fishing = {
  <fluid:pyrotheum>: {
    <mysticalagriculture:chunk:17>: 0.5,
    <ic2:dust:16>: 0.5,
    <mysticalagriculture:fire_essence>: 0.5,
    <thaumcraft:crystal_essence>.withTag({Aspects: [{amount: 1, key: "ignis"}]}): 0.5,
    <quark:soul_bead>: 0.5,
    <tconstruct:shard>.withTag({Material: "fierymetal"}): 0.2,
  },
  <fluid:cheese>: {
    <rats:token_piece>: 0.2,
  },
  <fluid:poison>: {
    // TODO
  },
  <fluid:stone>: {
    // TODO
  },
  <fluid:sand>: {
    // TODO
  },
  <fluid:electronics>: {}, // Defined below
} as float[IItemStack][ILiquidStack]$orderly;

for item in <ore:foodCheese>.items {
  fishing[<fluid:cheese>][item] = 0.5f;
}

for i in 0 .. 34 {
  fishing[<fluid:electronics>][<item:opencomputers:upgrade:${i}>] = 0.2f;
}

for fluid, tuple in fishing {
  for item, chance in tuple {
    inLiquidItemChancePoolDimBiome(fluid, '', item, chance, '', null);
  }
}
