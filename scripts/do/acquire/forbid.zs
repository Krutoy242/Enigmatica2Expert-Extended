#reloadable
#priority -1400
#modloaded zenutils ctintegration

import crafttweaker.block.IBlockDefinition;
import crafttweaker.item.IItemStack;

import scripts.do.acquire.events.pushRegistry;
import scripts.do.acquire.events.blockDefRegistry;
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

  function events(onEvents as string) as Forbidder {
    if (futile) return this;

    val evts = onEvents.split('\\s+');

    // Check for existing events
    for event in evts {
     if (!(['pickup', 'open', 'look', 'craft', 'place', 'use', 'hold', 'replicate'] as string[] has event))
      logger.logWarning('Acquire error: trying to add absent acquiring event: "'~event~'"');
    }

    for stack in stacks {
      for event in evts { pushRegistry(event, stack); }

      if (evts has 'place' || evts has 'look') {
        val block = stack.asBlock();
        if (!isNull(block)) {
          val blockDef = block.definition;
          if (!isNull(blockDef)) {
            if (evts has 'place') {
              if(isNull(blockDefRegistry.place)) blockDefRegistry['place'] = {};
              blockDefRegistry.place[blockDef] = true;
            }
            if (evts has 'look') {
              if(isNull(blockDefRegistry.look)) blockDefRegistry['look'] = {};
              blockDefRegistry.look[blockDef] = true;
            }
          }
        }
      }
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
}