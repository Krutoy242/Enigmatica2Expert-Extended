#modloaded dropt
#reloadable

import crafttweaker.item.IItemStack;
import mods.dropt.Dropt;

/*

Special drop rule for Advanced Rocketry Geodes
Luck account up to VII level

Manually add block drops info.

*/

function addDrop(block as IItemStack, drop as IItemStack[], exponent as double = 1.5, tool as string = null) as void {
  val blockStr = block.definition.id ~ ':' ~ block.metadata;
  val list = Dropt.list(blockStr.replaceAll(':', '_'));

  val rule = Dropt.rule()
    .matchBlocks([blockStr])
    .addDrop(Dropt.drop()
      .selector(Dropt.weight(1), 'REQUIRED')
      .items([block])
    );

  if (!isNull(tool)) {
    rule.matchHarvester(Dropt.harvester().type('PLAYER').mainHand('BLACKLIST', [], tool));
  }

  var logStr = '';
  for i in 0 .. 8 {
    val a = max(1, min(64, (pow((i as double), exponent) * 2.0) as int));
    val b = max(2, min(64, (pow((i as double), exponent) * 4.0) as int));
    rule.addDrop(Dropt.drop()
      .selector(Dropt.weight(pow(10, i)), 'EXCLUDED', i)
      .items(drop, Dropt.range(a, b))
    );
    logStr += '[' ~ a ~ ', ' ~ b ~ '],';
  }

  list.add(rule);

  if (utils.DEBUG) {
    val dropArr = mods.zenutils.StringList.empty();
    for d in drop { dropArr.add(d.commandString.replaceAll('<|>.*', '')); }
    utils.log('Modify drop;'
      ~ ' Block: ' ~ block.commandString.replaceAll('<|>.*', '')
      ~ ' Drop: ' ~ toString(dropArr) ~ ' [' ~ logStr ~ ']');
  }
}
