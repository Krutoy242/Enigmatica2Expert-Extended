#modloaded immersiveengineering alfinivia biomesoplenty
#priority -100

import crafttweaker.block.IBlockState;
import crafttweaker.item.IItemStack;
import crafttweaker.liquid.ILiquidStack;
import crafttweaker.player.IPlayer;
import crafttweaker.world.IBlockPos;
import crafttweaker.world.IFacing;
import crafttweaker.world.IWorld;

import mods.alfinivia.ImmersiveEngineering.addChemthrowerEffect;

// -----------------------------------------------------
// Basalt remake for Basalt Sediment Alt
// -----------------------------------------------------
val throwerRecipes = {
  <liquid:moltensalt>: {
    { <blockstate:ic2:resource>: <ic2:resource> }: { <blockstate:advancedrocketry:basalt>: <advancedrocketry:basalt> },
    { <blockstate:minecraft:grass>: <minecraft:grass> }: { <blockstate:biomesoplenty:grass:variant=silty>: <biomesoplenty:grass:4> },
    { <blockstate:minecraft:dirt:variant=dirt>: <minecraft:dirt> }: { <blockstate:biomesoplenty:dirt:coarse=false,variant=silty>: <biomesoplenty:dirt:2> },
    { <blockstate:minecraft:dirt:variant=coarse_dirt>: <minecraft:dirt:1> }: { <blockstate:biomesoplenty:dirt:coarse=true,variant=silty>: <biomesoplenty:dirt:10> },
    { <blockstate:minecraft:farmland>: <minecraft:farmland> }: { <blockstate:biomesoplenty:farmland_1>: <biomesoplenty:farmland_1> },
    { <blockstate:biomesoplenty:farmland_0>: <biomesoplenty:farmland_0> }: { <blockstate:biomesoplenty:farmland_1>: <biomesoplenty:farmland_1> },
    { <blockstate:extrautils2:decorativebedrock:type=bedrock_cobblestone>: <extrautils2:decorativebedrock:2> } : { <blockstate:minecraft:bedrock>: <minecraft:bedrock> },
    { <blockstate:quark:iron_plate:variant=iron_plate>: <quark:iron_plate> }: { <blockstate:quark:iron_plate:variant=rusty_iron_plate>: <quark:iron_plate:1> },
  },
  // Somehow, recipes with other liquids not working
  // <liquid:water> : {
  //   { <blockstate:minecraft:stonebrick:variant=stonebrick>: <minecraft:stonebrick> }: { <blockstate:minecraft:stonebrick:variant=mossy_stonebrick>: <minecraft:stonebrick:1> },
  //   { <blockstate:minecraft:cobblestone>: <minecraft:cobblestone> }: { <blockstate:minecraft:mossy_cobblestone>: <minecraft:mossy_cobblestone> },
  //   // {  }: {  },
  // },
} as IItemStack[IBlockState][IItemStack[IBlockState]][ILiquidStack];

for liquid, conversions in throwerRecipes {
  for inputs, outputs in conversions {
    for inB, inS in inputs {
      for outB, outS in outputs {
        scripts.jei.mod.immersiveengineering.addChemthrower(liquid, inS, outS);
      }
    }
  }

  addChemthrowerEffect(liquid, false, false,
    // IChemEntityEffect
    function (target,shooter,throwerstack,fluid) {},

    // IChemBlockEffect
    function (world as IWorld, pos as IBlockPos, side as IFacing, shooter as IPlayer, throwerstack as IItemStack, fluid as ILiquidStack) as void {
      if (world.remote) return;
      val blockState = world.getBlockState(pos);
      for inputs, outputs in throwerRecipes[liquid] {
        for inB, inS in inputs {
          for outB, outS in outputs {
            if (inB.matches(blockState)) {
              world.destroyBlock(pos, false);
              world.setBlockState(outB, pos);
            }
          }
        }
      }
    }
  );
}

addChemthrowerEffect(<fluid:ic2construction_foam>, false, false,
  // IChemEntityEffect
  function (target,shooter,throwerstack,fluid) {},

  // IChemBlockEffect
  function (world as IWorld, pos as IBlockPos, side as IFacing, shooter as IPlayer, throwerstack as IItemStack, fluid as ILiquidStack) as void {
    if (world.remote) return;

    val target = pos.getOffset(side, 1);
    if (world.isAirBlock(target) || world.getBlockState(target).material.replaceable) {
      world.setBlockState(<blockstate:ic2:foam:type=normal>, target);
    }
  }
);

addChemthrowerEffect(<fluid:xu_demonic_metal>, false, false,
  // IChemEntityEffect
  function (target,shooter,throwerstack,fluid) {},

  // IChemBlockEffect
  function (world as IWorld, pos as IBlockPos, side as IFacing, shooter as IPlayer, throwerstack as IItemStack, fluid as ILiquidStack) as void {
    if (world.remote) return;

    if (scripts.do.portal_spread.tick.currentDirection.update(0, -1)) {
      scripts.do.portal_spread.tick.spreadBlock(world, pos, true);
    }
  }
);
