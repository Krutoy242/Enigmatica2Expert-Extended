/*
  If there is no thaumadditions, fallback its aspects to vanilla
*/
#modloaded !thaumadditions thaumcraft
#priority 3500
#reloadable

import thaumcraft.aspect.CTAspectStack;

val emojiMap = scripts.mods.thaumcraft.aspect.emoji.emojiMap;

emojiMap['☀️'] = <aspect:humanus>;
emojiMap['💣'] = <aspect:perditio>;
emojiMap['♒'] = <aspect:motus>;
emojiMap['🙌'] = <aspect:machina>;
emojiMap['🧨'] = <aspect:ignis>;
emojiMap['🛎️'] = <aspect:alkimia>;
emojiMap['🍃'] = <aspect:permutatio>;
emojiMap['👁️'] = <aspect:auram>;
