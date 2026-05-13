#modloaded enderio

import mods.chisel.Carving.addVariation;
import crafttweaker.item.IItemStack;

val items = [
  // fused_glass
  <enderio:block_dark_fused_glass>,
  <enderio:block_enlightened_fused_glass>,
  <enderio:block_fused_glass>,

  <enderio:block_holy_dark_fused_glass>,
  <enderio:block_holy_enlightened_fused_glass>,
  <enderio:block_holy_fused_glass>,

  <enderio:block_not_holy_dark_fused_glass>,
  <enderio:block_not_holy_enlightened_fused_glass>,
  <enderio:block_not_holy_fused_glass>,

  <enderio:block_not_pasture_dark_fused_glass>,
  <enderio:block_not_pasture_enlightened_fused_glass>,
  <enderio:block_not_pasture_fused_glass>,

  <enderio:block_pasture_dark_fused_glass>,
  <enderio:block_pasture_enlightened_fused_glass>,
  <enderio:block_pasture_fused_glass>,

  <enderio:block_not_unholy_dark_fused_glass>,
  <enderio:block_not_unholy_enlightened_fused_glass>,
  <enderio:block_not_unholy_fused_glass>,

  <enderio:block_unholy_dark_fused_glass>,
  <enderio:block_unholy_enlightened_fused_glass>,
  <enderio:block_unholy_fused_glass>,

  // fused_quartz
  <enderio:block_dark_fused_quartz>,
  <enderio:block_enlightened_fused_quartz>,
  <enderio:block_fused_quartz>,

  <enderio:block_holy_dark_fused_quartz>,
  <enderio:block_holy_enlightened_fused_quartz>,
  <enderio:block_holy_fused_quartz>,

  <enderio:block_not_holy_dark_fused_quartz>,
  <enderio:block_not_holy_enlightened_fused_quartz>,
  <enderio:block_not_holy_fused_quartz>,

  <enderio:block_not_pasture_dark_fused_quartz>,
  <enderio:block_not_pasture_enlightened_fused_quartz>,
  <enderio:block_not_pasture_fused_quartz>,

  <enderio:block_pasture_dark_fused_quartz>,
  <enderio:block_pasture_enlightened_fused_quartz>,
  <enderio:block_pasture_fused_quartz>,

  <enderio:block_not_unholy_dark_fused_quartz>,
  <enderio:block_not_unholy_enlightened_fused_quartz>,
  <enderio:block_not_unholy_fused_quartz>,

  <enderio:block_unholy_dark_fused_quartz>,
  <enderio:block_unholy_enlightened_fused_quartz>,
  <enderio:block_unholy_fused_quartz>,
] as IItemStack[];

for i in 0 .. items.length {
  val name = 'eio_glass_' ~ (i / 3) as int;
  val def = items[i].definition;
  for meta in 0 .. 16 {
    addVariation(name, def.makeStack(meta));
  }
}
