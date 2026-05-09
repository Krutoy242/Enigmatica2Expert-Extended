#loader contenttweaker
#modloaded storagedrawers framedcompactdrawers

// Hand Framing Tool — frame drawers in-world without crafting tables.
// Adapted from Eutro's original Nomifactory implementation (LGPL-3.0)
// via Divine Journey 2's port. Sticks/refill mechanic removed (unlimited use).
// https://github.com/Nomifactory/Nomifactory/blob/5a07e6edf47338ef4c62a2d4efcb8890d2d81278/overrides/scripts/HandFramingTool.zs
// https://github.com/Divine-Journey-2/Divine-Journey-2/blob/28210952eb6dcb961a790d472f5bb2c1611c88fd/overrides/scripts/ContentTweaker/HandFramingTool.zs

import mods.contenttweaker.VanillaFactory.createItem;
import mods.contenttweaker.IItemUse;
import mods.contenttweaker.World;
import mods.contenttweaker.Player;
import mods.contenttweaker.BlockPos;
import mods.contenttweaker.Hand;
import mods.contenttweaker.Facing;
import mods.contenttweaker.ActionResult;

import crafttweaker.util.Position3f;
import crafttweaker.block.IBlockDefinition;
import crafttweaker.block.IBlockState;
import crafttweaker.block.IBlock;
import crafttweaker.data.IData;

function isFrameable(block as IBlockDefinition) as bool {
  if (isNull(block) || isNull(block.id)) return false;
  return block.id.startsWith('framedcompactdrawers')
    || block.id == 'fluiddrawers:tank'
    || block.id == 'fluiddrawers:tank_custom'
    || block.id == 'storagedrawers:customdrawers'
    || block.id == 'storagedrawers:customtrim'
    || block.id == 'storagedrawers:basicdrawers'
    || block.id == 'storagedrawers:trim'
    || block.id == 'storagedrawers:compdrawers'
    || block.id == 'storagedrawers:controller'
    || block.id == 'storagedrawers:controllerslave';
}

function isReframing(block as IBlockDefinition) as bool {
  if (isNull(block) || isNull(block.id)) return false;
  return block.id.startsWith('framedcompactdrawers')
    || block.id == 'fluiddrawers:tank_custom'
    || block.id == 'storagedrawers:customdrawers'
    || block.id == 'storagedrawers:customtrim';
}

function orElse(tag as IData, other as IData) as IData {
  return isNull(tag) ? other : tag;
}

function makeFramedState(state as IBlockState) as IBlockState {
  val id as string = state.block.definition.id;
  if (id == 'storagedrawers:trim') {
    return <block:storagedrawers:customtrim>.block.definition.defaultState;
  }
  var meta as int = state.meta;
  var def as IBlockDefinition = <block:storagedrawers:customdrawers>.block.definition;
  if (id == 'storagedrawers:basicdrawers') {
    def = <block:storagedrawers:customdrawers>.block.definition;
  }
  else if (id == 'storagedrawers:compdrawers') {
    def = <block:framedcompactdrawers:framed_compact_drawer>.block.definition;
  }
  else if (id == 'fluiddrawers:tank') {
    def = <block:fluiddrawers:tank_custom>.block.definition;
  }
  else if (id == 'storagedrawers:controllerslave') {
    def = <block:framedcompactdrawers:framed_slave>.block.definition;
  }
  else if (id == 'storagedrawers:controller') {
    def = <block:framedcompactdrawers:framed_drawer_controller>.block.definition;
    meta = meta - 2;
  }
  return def.getStateFromMeta(meta);
}

// Strips storage NBT so frame swap doesn't lose contents incorrectly:
// returns a sanitized copy where stringly-typed primitives are zeroed.
function overrideData(data as IData) as IData {
  if (isNull(data)) return data;

  if (!isNull(data as IData[string])) {
    val dataMap = data as IData[string];
    val built as IData[string] = {};
    val dataString = data as string;
    if (dataMap has dataString && dataMap[dataString] as string == dataString) {
      return 0 as IData;
    }
    for k, v in dataMap {
      built[k] = overrideData(v);
    }
    val ret as any[any] = built;
    return ret as IData;
  }

  if (!isNull(data as [IData])) {
    var built = [] as IData;
    for v in data as [IData] {
      built += [overrideData(v)];
    }
    return built;
  }

  return '' as IData;
}

val hft = createItem('hand_framing_tool');
hft.maxStackSize = 1;
hft.onItemUse = function (player as Player, world as World, pos as BlockPos, hand as Hand, facing as Facing, blockHit as Position3f) {
  val ctstate = world.getBlockState(pos);
  val definition as IBlockDefinition = ctstate.block.definition;
  if (isFrameable(definition)) {
    var state as IBlockState = definition.getStateFromMeta(ctstate.meta);
    val tag as IData = player.currentItem.tag;
    if (isNull(tag) || isNull(tag.MatS)) return ActionResult.fail();

    if (!isReframing(definition)) {
      state = makeFramedState(state);
    }

    val block as IBlock = world.getBlock(pos);
    val blockTag as IData = orElse(block.data, {}) + {
      'MatS': tag.MatS,
      'MatF': orElse(tag.MatF, ''),
      'MatT': orElse(tag.MatT, ''),
    };

    world.setBlockState(definition.getStateFromMeta(ctstate.meta), overrideData(block.data), pos); // clear storage
    world.setBlockState(<block:minecraft:air>, pos); // ensure re-render
    world.setBlockState(state, blockTag, pos);
    return ActionResult.success();
  }
  return ActionResult.pass();
} as IItemUse;
hft.register();
