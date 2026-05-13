#loader mixin
#modloaded bloodmagic
#priority 3000

import native.net.minecraft.block.state.IBlockState;
import native.net.minecraft.block.Block;
import native.net.minecraft.util.ResourceLocation;
import native.net.minecraftforge.fml.common.registry.ForgeRegistries;
import native.net.minecraft.init.Blocks;
import native.net.minecraftforge.registries.IForgeRegistryEntry;

zenClass Op {
  static catalystToBlock as IBlockState[];
  static selectedBlock as IBlockState;

  static init as function()IBlockState[] = function () as IBlockState[] {
    return [
      Blocks.PRISMARINE.defaultState,
      Blocks.OBSIDIAN.defaultState,
      strToBlock('engineersdecor:gas_concrete', 0),
      strToBlock('chisel:concrete_white', 0),
      strToBlock('exnihilocreatio:block_endstone_crushed', 0),
      strToBlock('tconstruct:slime_grass', 1),
      strToBlock('contenttweaker:compressed_coral', 0),
      strToBlock('extrautils2:decorativesolid', 4),
      strToBlock('ic2:resource', 0),
      strToBlock('exnihilocreatio:block_skystone_crushed', 0),
      null,
      strToBlock('exnihilocreatio:block_netherrack_crushed', 0),
      strToBlock('endreborn:block_lormyte_crystal', 0),
      strToBlock('tconstruct:brownstone', 1),
      strToBlock('tconstruct:soil', 0),
      strToBlock('tconstruct:soil', 3),
      strToBlock('quark:biome_cobblestone', 2),
      strToBlock('endreborn:block_entropy_end_stone', 0),
      strToBlock('quark:elder_prismarine', 0),
      null,
      null,
      null,
      null,
      null,
      null,
      strToBlock('tconstruct:soil', 5),
      strToBlock('tconstruct:soil', 2),
      strToBlock('immersivepetroleum:stone_decoration', 0),
      strToBlock('quark:biome_cobblestone', 1),
      strToBlock('quark:biome_cobblestone', 0),
      strToBlock('immersiveengineering:stone_decoration', 5),
      strToBlock('tconstruct:slime_grass', 8),
      strToBlock('quark:slate', 0),
    ];
  };

  static strToBlock as function(string,int)IBlockState = function (id as string, meta as int) as IBlockState {
    val block as IForgeRegistryEntry = ForgeRegistries.BLOCKS.getValue(ResourceLocation(id));
    if (isNull(block) || !(block instanceof Block)) return null;
    return (block as Block).getStateFromMeta(meta);
  };
}
