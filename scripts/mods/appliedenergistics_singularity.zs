#modloaded zenutils appliedenergistics2
#sideonly client

import crafttweaker.text.ITextComponent;

import mods.zenutils.StaticString;
import mods.zenutils.StringList;

// a list of string of length 60, with each element holding an emoji
static EMOJIS as string[] = "─│┌┐└┘├┤┬┴┼═║╒╓╔╕╖╗╘╙╚╛╜╝╞╟╠╡╢╣╤╥╦╧╨╩╪╫╬▀▄█▌▐░▒▓⚠⚡⚥✂✉✎✔✘❄❣❤⭐".split('');

//original picked 100 emojis
// static EMOJIS as string[] = "─│┌┐└┘├┤┬┴┼═║╒╓╔╕╖╗╘╙╚╛╜╝╞╟╠╡╢╣╤╥╦╧╨╩╪╫╬▀▄█▌▐░▒▓♩♪♫♬♭♮⚀⚁⚂⚃⚄⚅⚐⚑☀☁☂☃☄★☆☈☐☑☒☔⚓⚔⚗⚠⚡⚥✂✉✎✔✘❄❣❤⭐⌘⌚⌛⏏☮☯☜☞☠☹☺".split('');

// a list of string of length 10, with each element holding an color formatting code
//disabled colors are commented out for informing devs about unused colors
static COLORS as string[] = [
  // ,"§0"  // black
  // ,"§1"  // dark_blue
  // ,"§2"  // dark_green
  "§3"  // dark_aqua
  // ,"§4"  // dark_red
  ,"§5"  // dark_purple
  ,"§6"  // gold
  ,"§7"  // gray
  // ,"§8"  // dark_gray
  ,"§9"  // blue
  ,"§a"  // green
  ,"§b"  // aqua
  ,"§c"  // red
  ,"§d"  // light_purple
  ,"§e"  // yellow
  // ,"§f"  // white
];

static cutDownLen = EMOJIS.length * COLORS.length;
static splitLen = COLORS.length;

function emojifiedFrequency(frequency as long) as string {
    var freq = frequency;
    if (freq == 0) {
      return '0';
    }
    val parts = StringList.empty();
    if (freq < 0) {
        freq = -freq;
        parts.add("-");
    }
    var hasNext = true;
    while (hasNext) {
        val cut = freq % cutDownLen;
        freq = freq / cutDownLen;
        parts.add(COLORS[cut % splitLen]);
        parts.add(EMOJIS[cut / splitLen]);
        hasNext = (freq != 0);
    }
    return StaticString.join(parts.toArray(), '');
}

<appliedenergistics2:material:48>
  .only(function (item) {
    return item.hasTag && !isNull(item.tag.memberGet("freq"));
  })
  .addAdvancedTooltip(function (item) {
    val freq = item.tag.memberGet("freq").asLong();
    return ITextComponent
      .fromTranslation(
        "tooltips.lang.quantum_entangled_singularity.freq",
        [emojifiedFrequency(freq), freq]
      )
      .unformattedText;
  });
