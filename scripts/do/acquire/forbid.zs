#reloadable
#priority -1400
#modloaded zenutils scalinghealth

import crafttweaker.block.IBlockDefinition;
import crafttweaker.block.IBlockState;
import crafttweaker.item.IItemStack;
import crafttweaker.block.IBlock;

import scripts.do.acquire.events.pushRegistry;
import scripts.do.acquire.events.blockDefRegistry;
import scripts.do.acquire.events.blockDefAliasRegistry;
import scripts.do.acquire.events.stringRegistry;

/*Inject_js(
(injectInFile('config/itemborders.cfg', 'S:yellow <\n', '\n     >',
  [...new Set(
    [...loadText('crafttweaker.log').matchAll(/^\[\w+\]\[\w+\]\[\w+\] Acquire +([^:]+): <([^>]+)>/gm)]
    .map(([,,item]) => `        ${item}`)
  )]
  .sort(naturalSort)
  .join('\n'))
, '// Done!')
)*/
// Done!
/**/

zenClass Forbidder {
  static blockEvents = ['place', 'look', 'interact'] as string[];

  var stacks as IItemStack[];
  var futile as bool = false;

  zenConstructor() {}

  function stack(stackRepresent as IItemStack) as Forbidder {
    if (isNull(stackRepresent))
      futile = true;
    else
      stacks = [stackRepresent];
    return this;
  }

  function stacks(groupName as string, stacksRepresent as IItemStack[]) as Forbidder {
    stacks = stacksRepresent;
    var some = false;
    for stack in stacksRepresent {
      if (isNull(stack)) continue;
      scripts.do.acquire.data.groups[stack] = groupName;
      some = true;
    }
    if(!some) {
      logger.logWarning('Acquire error: trying to add completely empty list of stacks "' ~ groupName ~ '". Size: ' ~ stacksRepresent.length);
      futile = true;
    }
    return this;
  }

  function value(amount as double) as Forbidder {
    if (!futile)
      for stack in stacks {
        scripts.do.acquire.data.values[stack] = amount;
        val isResidual = amount - amount as int > 0.0;
        val amountStr = isResidual ? amount as string : amount as int;
        stack.addTooltip(`§6+${amountStr}§e✪`);
        utils.log(`Acquire +${amount}: ${stack.commandString}`);
      }
    return this;
  }

  function events(onEvents as string, blockstates as IBlockState[] = null) as Forbidder {
    if (futile) return this;

    val evts = onEvents.split('\\s+');

    // Check for existing events
    for event in evts {
     if (!(['pickup', 'open', 'look', 'craft', 'place', 'use', 'hold', 'replicate', 'interact'] as string[] has event))
      logger.logWarning('Acquire error: trying to add absent acquiring event: "'~event~'"');
    }

    for stack in stacks {
      for event in evts { pushRegistry(event, stack); }
    }

    // Register explicitely defined states
    val hasExplicitStates = !isNull(blockstates) && blockstates.length > 0;
    if (hasExplicitStates) {
      blockDefAliasRegistry[blockstates[0].block.definition] = stacks[0];
      for state in blockstates {
        regBlock(state.block, evts);
      }
    }

    for stack in stacks {
      // Find if its block event
      var hasBlockEvt = false;
      for evtName in blockEvents {
        if(evts has evtName) {
          hasBlockEvt = true;
          break;
        }
      }
      if (!hasBlockEvt) continue;

      val block = stack.asBlock();
      if (isNull(block) && !hasExplicitStates) {
        // Its a block event, has no block representation
        // and no fallback blockstates
        logger.logWarning('Acquire error: registering acquiring for item '~stack.commandString
          ~', and its a block event, but no block representation found'
          ~', and no fallback blockstates found too.');
        continue;
      }

      // Fill special map for block events
      regBlock(block, evts);
    }
    return this;
  }

  function onOpen(classPath as string) as Forbidder {
    if (!futile)
      for stack in stacks {
        stringRegistry[classPath] = stack;
      }
    return this;
  }

  /////////////////////////////////////
  // Private fields
  /////////////////////////////////////
  function regBlock(block as IBlock, evts as string[]) as void {
    val blockDef = block.definition;
    if (!isNull(blockDef)) {
      for evtName in blockEvents {
        if (evts has evtName) {
          if(isNull(blockDefRegistry[evtName])) blockDefRegistry[evtName] = {};
          blockDefRegistry[evtName][blockDef] = true;
        }
      }
    }
  }
}
