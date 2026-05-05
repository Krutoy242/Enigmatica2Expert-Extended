#modloaded zenutils ftblib
#priority 3000
#reloadable

import mods.zenutils.StringList;
import mods.zenutils.StaticString;
import crafttweaker.player.IPlayer;
import crafttweaker.data.IData;
import mods.zenutils.StaticString.format;
import native.java.text.DecimalFormat;

static DF as DecimalFormat = DecimalFormat();
DF.setMaximumFractionDigits(2); // at most 2 decimals
DF.setMinimumFractionDigits(0); // no trailing zeros
DF.setGroupingUsed(false);

/**
 * Naturally sort integer array using serializing function
 * @param fnc must return space-separated string, when last word would be result value
 */
function sortArrayBy(arr as int[], fnc as function(int,int)string) as int[] {
  val list = StringList.empty();
  for i, count in arr {
    list.add(fnc(count, i));
  }
  return sortStrListBy(list, fnc);
}

function sortStrListBy(list as StringList, fnc as function(int,int)string) as int[] {
  val sortedData = list.toArray();
  sortedData.sort();
  sortedData.reverse();

  val result = intArrayOf(sortedData.length, 0);
  for i, line in sortedData {
    val splitted = line.split(' ');
    result[i] = splitted[splitted.length - 1] as int;
  }
  return result;
}

function naturalInt(n as int) as string {
  return StaticString.repeat(0, 10 - (`${n}`).length) ~ n;
}

function message(player as IPlayer, msg as IData) as void {
  player.sendRichTextMessage(crafttweaker.text.ITextComponent.fromData(msg));
}

function tpText(dim as int, x as double, y as double, z as double) as string {
  return `§6⚑ §8Dim §7${dim} §8[§4${DF.format(x)} §3${DF.format(y)} §2${DF.format(z)}§8]`;
}

function tpMessage(
  dim as int, x as double, y as double, z as double, text as string = null,
  extra as IData = null, extraTooltip as string = null
) as IData {
  val posText = tpText(dim, x, y, z);
  val buttonText = text ?? posText;
  val command = `/tpx @p ${x} ${y} ${z} ${dim}`;

  val tpToText = `§8TP to ${posText}`;
  val tooltip = isNull(extraTooltip)
    ? tpToText
    : `${tpToText}\n${extraTooltip}`;

  var btn = button(buttonText, command, tooltip) + {color: 'dark_aqua'} as IData;
  if (!isNull(extra)) btn += {extra: extra};

  return [btn];
}

function button(text as string, clickCommand as string, tooltip as string = null) as IData {
    return {
        text: text,
        clickEvent: { action: 'run_command', value: clickCommand },
        hoverEvent: { action: 'show_text', value: tooltip ?? ('Execute §b' ~ clickCommand) }
    };
}
