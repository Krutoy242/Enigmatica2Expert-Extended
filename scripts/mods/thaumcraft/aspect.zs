#modloaded thaumcraft randomtweaker
#reloadable
#priority 3000

import crafttweaker.entity.IEntityDefinition;
import crafttweaker.item.IItemStack;
import native.java.util.regex.Pattern;
import thaumcraft.aspect.CTAspectStack;

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

function set(aspectString as string, item as IItemStack) as void {
  if (isNull(item)) return;
  if (aspectString.length() <= 0) {
    logger.logWarning('Empty aspect list for: ' ~ item.commandString);
    return;
  }
  val aspects = toAspects(aspectString);
  if (aspects.length <= 0) {
    logger.logWarning('Empty aspect list for: ' ~ item.commandString ~ ' aspects: ' ~ aspectString);
    return;
  }
  item.setAspects(aspects);
}

function setEntity(aspectString as string, entity as IEntityDefinition) as void {
  if (isNull(entity)) return;
  if (aspectString.length() <= 0) {
    logger.logWarning('Empty aspect list for entity: ' ~ entity.id);
    return;
  }
  val aspects = toAspects(aspectString);
  if (aspects.length <= 0) {
    logger.logWarning('Empty aspect list for entity: ' ~ entity.id ~ ' aspects: ' ~ aspectString);
    return;
  }
  entity.setAspects(aspects);
  <minecraft:spawn_egg>.withTag({EntityTag: {id: entity.id}}).setAspects(aspects);
}

static numberPattern as Pattern = Pattern.compile('^\\d+');

function toAspects(aspects as string) as CTAspectStack[] {
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
}
