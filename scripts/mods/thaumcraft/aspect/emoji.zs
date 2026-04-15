/*

Turn aspect lists into string with Emojis
for better readability and more colorful source files ^_^

*/

#modloaded thaumcraft
#priority 4000
#reloadable

import thaumcraft.aspect.CTAspectStack;
import native.java.util.regex.Pattern;

zenClass CAspect {
  zenConstructor() {}

  // Modded aspects that will be defaulted to vanilla TC's ones if mod is absent
  var caeles as CTAspectStack = <aspect:humanus>;
  var exitium as CTAspectStack = <aspect:perditio>;
  var fluctus as CTAspectStack = <aspect:motus>;
  var imperium as CTAspectStack = <aspect:machina>;
  var infernum as CTAspectStack = <aspect:ignis>;
  var sonus as CTAspectStack = <aspect:alkimia>;
  var ventus as CTAspectStack = <aspect:permutatio>;
  var visum as CTAspectStack = <aspect:auram>;
}

global Aspect as CAspect = CAspect();

static emojiMap as CTAspectStack[string] = {
  '💨': <aspect:aer>,
  '👽': <aspect:alienis>,
  '⚗️': <aspect:alkimia>,
  'ඞ': <aspect:amogus>,
  '💧': <aspect:aqua>,
  '✨': <aspect:auram>,
  '🗡️': <aspect:aversio>,
  '🐺': <aspect:bestia>,
  '☀️': Aspect.caeles,
  '🧠': <aspect:cognitio>,
  '✊': <aspect:desiderium>,
  '🐲': <aspect:draco>,
  '💀': <aspect:exanimis>,
  '💣': Aspect.exitium,
  '🔨': <aspect:fabrico>,
  '♒': Aspect.fluctus,
  '🧊': <aspect:gelum>,
  '🌱': <aspect:herba>,
  '👨': <aspect:humanus>,
  '🔥': <aspect:ignis>,
  '🙌': Aspect.imperium,
  '🧨': Aspect.infernum,
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
  '🛎️': Aspect.sonus,
  '👻': <aspect:spiritus>,
  '🌑': <aspect:tenebrae>,
  '⛰️': <aspect:terra>,
  '〇': <aspect:vacuos>,
  '🍃': Aspect.ventus,
  '❤️': <aspect:victus>,
  '🔗': <aspect:vinculum>,
  '👁️': Aspect.visum,
  '🍇': <aspect:vitium>,
  '💎': <aspect:vitreus>,
  '🕊️': <aspect:volatus>,
};

static aspectToEmoji as string[string] = {};

for char, aspect in emojiMap {
  aspectToEmoji[aspect.internal.name.toLowerCase()] = char;
}

static numberPattern as Pattern = Pattern.compile('^\\d+');

global Aspects as function(string)CTAspectStack[] = function(aspects as string) as CTAspectStack[] {
  val aStacks as string[] = aspects.trim().split('\\s+');
  if (aStacks.length <= 0) return [] as CTAspectStack[];
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
