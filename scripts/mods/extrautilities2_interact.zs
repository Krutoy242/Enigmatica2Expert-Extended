#modloaded extrautils2
#reloadable

// Fix Error when you have a full inventory and try to fill buckets
// from the Drum, the buckets just disappear instead of falling to the ground
events.onPlayerInteractBlock(function (e as crafttweaker.event.PlayerInteractBlockEvent) {
  if (isNull(e.item)) return;
  if (e.block.definition.id != 'extrautils2:drum') return;

  for i in 0 .. 36 {
    if (isNull(e.player.getInventoryStack(i))) {
      return;
    }
  }

  e.player.sendRichTextMessage(crafttweaker.text.ITextComponent.fromTranslation('e2ee.eu2_drum_error'));
  e.cancel();
});

// Forbid golden lasso to interract with some entities
val lassoBlacklist = {
  'thaumadditions:chester': true,
} as bool[string];
events.onPlayerInteractEntity(function (e as crafttweaker.event.PlayerInteractEntityEvent) {
  if (
    isNull(e.item)
    || isNull(e.item.definition)
    || e.item.definition.id != 'extrautils2:goldenlasso'
    || isNull(e.target)
    || isNull(e.target.definition)
    || isNull(lassoBlacklist[e.target.definition.id])
  ) return;

  e.cancel();
});
