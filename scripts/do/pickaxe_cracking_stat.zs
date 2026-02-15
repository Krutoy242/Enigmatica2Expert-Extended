#loader preinit
#modloaded zenutils

mods.zenutils.PlayerStat.create(
  'stat.cracked_blocks',
  crafttweaker.text.ITextComponent.fromTranslation('stat.cracked_blocks'),
  function(n as int) as string {
    return n as string;
  });
