/**
 * @file Portal Spread recipe maker
 * 
 * Use Stick with NBT tags to create recipes. You must be in creative mode.
 * 
 * - [Shift] + [Right click] to select one or many input block states
 * - [Right click] to select one or many output block states
 * - [Left click] to add block as output and finish recipe
 * 
 * Resulting recipe would be printed into crafttweaker.log file
 * 
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

#reloadable
#modloaded zenutils

import crafttweaker.block.IBlockState;
import crafttweaker.player.IPlayer;

// Singleton class just to get acces to changing values
zenClass CurrentRecipe {
  zenConstructor() {}
  var input as IBlockState[] = [];
  var output as IBlockState[] = [];
}

static currentRecipe as CurrentRecipe = CurrentRecipe();

events.onPlayerInteractBlock(function(e as crafttweaker.event.PlayerInteractBlockEvent){
  if (isNull(e.world)  || e.world.remote) return;
  if (isNull(e.player) || !e.player.creative) return;

  val currentItem = e.item;
  if (isNull(currentItem)) return;
  if (
    currentItem.definition.id != 'minecraft:stick'
    || !currentItem.hasTag
  ) return;
  
  val state = e.world.getBlockState(e.position);
  if (isNull(state)) return;

  if (e.player.isSneaking) {
    currentRecipe.input = currentRecipe.input + state;
    e.player.sendMessage("§8Added input "~state.commandString);
  } else {
    addOutput(e.player, state);
  }
  e.cancel();
});

function addOutput(player as IPlayer, state as IBlockState) {
  currentRecipe.output = currentRecipe.output + state;
  player.sendMessage("§7Added output "~state.commandString);
}

events.onBlockBreak(function(e as crafttweaker.event.BlockBreakEvent){
  if(
    e.player.world.remote
    || isNull(e.player.currentItem)
    || e.player.currentItem.definition.id != 'minecraft:stick'
    || !e.player.currentItem.hasTag
  ) return;

  if(currentRecipe.input.length < 1) return;
  
  addOutput(e.player, e.blockState);

  val ml = currentRecipe.input.length>1 || currentRecipe.output.length>1;
  val lf = ml ? '\n' : '';
  val cm = ml ? ',' : '';
  val tb = ml ? '  ' : '';
  var s = 'setStates(0, -1, ['~lf;
  for state in currentRecipe.input { s += tb ~ state.commandString.toLowerCase()~cm~lf; }

  s += '], ['~lf;
  for state in currentRecipe.output { s += tb ~ state.commandString.toLowerCase()~cm~lf; }
  s += ']);'~lf;

  print('Portal Spread Recipe:\n'~s);
  e.player.sendMessage("§3Printed recipe "~currentRecipe.input.length~' => '~currentRecipe.output.length);

  currentRecipe.input = [];
  currentRecipe.output = [];
  e.cancel();
});
