/*
  Turn helper bone output of craft.zs into aspect emojis
*/

#reloadable
#modloaded thaumcraft

import crafttweaker.item.IItemStack;
import scripts.craft.grid.Grid;
import native.java.util.regex.Pattern;

static ASPECT_BRACKET_PATTERN as Pattern = Pattern.compile('\\[((?:\\s*<?(?:aspect:|Aspect\\.)\\w+>?\\s*(?:\\*\\s*\\d+\\s*)?,?)+)\\]');
static ASPECT_REF_PATTERN as Pattern = Pattern.compile('(?:<aspect:(\\w+)>|Aspect\\.(\\w+))(?:\\s*\\*\\s*(\\d+))?');

function parseAspects(aspectsString as string) as string {
  val emojiStrings = [] as [string];
  val matcher = ASPECT_REF_PATTERN.matcher(aspectsString);
  while (matcher.find()) {
    var aspectName = matcher.group(1);
    if (isNull(aspectName)) aspectName = matcher.group(2);

    if (!isNull(aspectName)) {
      val amountStr = matcher.group(3);
      val amount = isNull(amountStr) ? 1 : amountStr as int;

      val emoji = scripts.mods.thaumcraft.aspect.emoji.aspectToEmoji[aspectName.toLowerCase()];

      if (isNull(emoji)) {
        logger.logWarning('Aspect Emoji Replacer: Emoji not found for aspect: ' ~ aspectName);
      }
      else {
        emojiStrings.add(amount == 1 ? emoji : (amount ~ emoji));
      }
    }
  }
  return mods.zenutils.StaticString.join(emojiStrings as string[], ' ');
}

craft.pushPostProcessor(function (recipeString as string, output as IItemStack, grid as Grid, style as string[]) as string {
  if (style has 'noAspectEmojis') return recipeString;

  val matcher = ASPECT_BRACKET_PATTERN.matcher(recipeString);

  var lastEnd = 0;
  var result = '';
  while (matcher.find()) {
    result += recipeString.substring(lastEnd, matcher.start());

    val innerContent = matcher.group(1);
    if (!ASPECT_REF_PATTERN.matcher(innerContent).find()) {
      result += matcher.group(0);
    }
    else {
      val emojiString = parseAspects(innerContent);
      if (emojiString.length() > 0) {
        result += "Aspects('" ~ emojiString ~ "')";
      }
      else {
        result += matcher.group(0);
      }
    }
    lastEnd = matcher.end();
  }
  result += recipeString.substring(lastEnd);
  return result;
});
