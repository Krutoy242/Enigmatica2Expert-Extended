#loader preinit

// Initialize stat parameter for replicator machine
mods.zenutils.PlayerStat.create(
  'stat.replications',
  crafttweaker.text.ITextComponent.fromTranslation('stat.replications'),
  function(mb as int) as string {
    return mods.zenutils.StaticString.format('%,.2f', [0.001 * mb]);
  });
