#priority 3000
#modloaded zenutils
#reloadable
#ignoreBracketErrors

import crafttweaker.block.IBlockState;
import crafttweaker.item.IItemStack;
import crafttweaker.world.IBlockPos;
import crafttweaker.world.IWorld;

function abs(n as double) as double { return n < 0 ? -n : n; }

// Replaces for blocks that cant be converted into items
static blockRepresentation as IItemStack[string] = {
  'minecraft:double_stone_slab' : <minecraft:stone_slab>,
  'minecraft:double_wooden_slab': <minecraft:wooden_slab>,
  'minecraft:fire'              : <minecraft:flint_and_steel>,
  'minecraft:lava'              : <minecraft:lava_bucket>,
  'minecraft:water'             : <minecraft:water_bucket>,
  'minecraft:lit_redstone_ore'  : <minecraft:redstone_ore>,
  'minecraft:air'               : !isNull(<mechanics:empty>) ? <mechanics:empty> : <minecraft:barrier>,
  'biomesoplenty:blood'         : <forge:bucketfilled>.withTag({ FluidName: 'blood', Amount: 1000 }),
};

// Those blocks cant be safetly used with `block.getItem()`
static weirdBlockNames as string[] = [
  'netherendingores:',
  'ic2:te',
  'draconicevolution:draconium_ore',
];

static dummyPos as IBlockPos = IBlockPos.create(0, 0, 0);

function stateToItem(state as IBlockState, pos as IBlockPos = null, world as IWorld = null) as IItemStack {
  if (
    isNull(state)
    || isNull(state.block)
    || isNull(state.block.definition)
    || state == <blockstate:minecraft:air>
  ) {
    return null;
  }

  val defId = state.block.definition.id;
  var isWeird = false;
  for str in weirdBlockNames {
    if (defId.startsWith(str)) {
      isWeird = true;
      break;
    }
  }
  val item = (
    isWeird && isNull(world)
      ? itemUtils.getItem(defId, state.block.meta)
      : state.block.getItem(world, pos ?? dummyPos, state)
        ?? itemUtils.getItem(defId, state.block.meta)
  ) ?? blockRepresentation[defId];

  if (isNull(item) && utils.DEBUG)
    logger.logWarning(`Cannot find item representation for block: ${defId}`);
  return item;
}

function blockPosToItem(world as IWorld, pos as IBlockPos) as IItemStack {
  if (isNull(world) || isNull(pos)) return null;
  return stateToItem(world.getBlockState(pos), pos, world);
}
