/*

Turn aspect lists into string with Emojis
for better readability and more colorful source files ^_^

*/

#modloaded thaumcraft
#priority 4000
#reloadable
#ignoreBracketErrors

import thaumcraft.aspect.CTAspectStack;
import native.java.util.regex.Pattern;

// Only vanilla TC aspects should be registered here
// Modded aspects should be handled in their own files with respective #modloaded
static emojiMap as CTAspectStack[string] = {
  '💨': <aspect:aer>,
  '👽': <aspect:alienis>,
  '⚗️': <aspect:alkimia>,
  'ඞ': <aspect:amogus>,
  '♾️': <aspect:ascension>,
  '💧': <aspect:aqua>,
  '✨': <aspect:auram>,
  '🗡️': <aspect:aversio>,
  '🐺': <aspect:bestia>,
  '☀️': <aspect:caeles>,
  '🧠': <aspect:cognitio>,
  '✊': <aspect:desiderium>,
  '🐲': <aspect:draco>,
  '💀': <aspect:exanimis>,
  '💣': <aspect:exitium>,
  '🔨': <aspect:fabrico>,
  '♒': <aspect:fluctus>,
  '🧊': <aspect:gelum>,
  '🌱': <aspect:herba>,
  '👨': <aspect:humanus>,
  '🔥': <aspect:ignis>,
  '🙌': <aspect:imperium>,
  '🧨': <aspect:infernum>,
  '🛠️': <aspect:instrumentum>,
  '🕯️': <aspect:lux>,
  '⚙️': <aspect:machina>,
  '🔷': <aspect:mana>,
  '🔩': <aspect:metallum>,
  '⚰️': <aspect:mortuus>,
  '🏃': <aspect:motus>,
  '🦄': <aspect:mythus>,
  '⟁': <aspect:ordo>,
  '⚡': <aspect:perditio>,
  '🔄': <aspect:permutatio>,
  '💪': <aspect:potentia>,
  '🔮': <aspect:praecantatio>,
  '🛡️': <aspect:praemunio>,
  '🐀': <aspect:rattus>,
  '🩸': <aspect:sanguis>,
  '🦉': <aspect:sensus>,
  '🛎️': <aspect:sonus>,
  '👻': <aspect:spiritus>,
  '🌑': <aspect:tenebrae>,
  '🗯️': <aspect:terminus>,
  '⛰️': <aspect:terra>,
  '〇': <aspect:vacuos>,
  '🍃': <aspect:ventus>,
  '❤️': <aspect:victus>,
  '🔗': <aspect:vinculum>,
  '👁️': <aspect:visum>,
  '🍇': <aspect:vitium>,
  '💎': <aspect:vitreus>,
  '🕊️': <aspect:volatus>,
};

static aspectToEmoji as string[string] = {};

for char, aspect in emojiMap {
  aspectToEmoji[aspect.internal.name.toLowerCase()] = char;
}

static numberPattern as Pattern = Pattern.compile('^\\d+');

global Aspects as function(string)CTAspectStack[] = function (aspects as string) as CTAspectStack[] {
  val aStacks as string[] = aspects.trim().split('\\s+');
  if (aStacks.length <= 0) return [];
  val result = arrayOf(aStacks.length, null as CTAspectStack) as CTAspectStack[];
  for i, aStack in aStacks {
    if (aStack.length() < 1) {
      logger.logWarning(`Empty aspect string in: ${aspects}`);
      continue;
    }
    var aspect as CTAspectStack = null;
    val matcher = numberPattern.matcher(aStack);
    if (matcher.find()) {
      val numberStr = matcher.group(0) as string;
      val aspectAmount = numberStr as int;
      aspect = emojiMap[aStack.substring(numberStr.length())];
      if (!isNull(aspect))
        aspect = aspectAmount == 1 ? aspect : aspect * aspectAmount;
    }
    else {
      aspect = emojiMap[aStack];
    }
    if (isNull(aspect)) {
      logger.logWarning(`Aspect not found: ${aStack}`);
      continue;
    }
    result[i] = aspect;
  }
  return result;
};
