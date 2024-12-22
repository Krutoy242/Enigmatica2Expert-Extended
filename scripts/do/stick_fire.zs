#reloadable

import native.net.minecraft.util.EnumParticleTypes;

events.onBlockHarvestDrops(function (e as crafttweaker.event.BlockHarvestDropsEvent) {
  if (isNull(e.player) || isNull(e.player.world) || e.player.world.remote) return;
  if (isNull(e.player.currentItem)) return;
  if (e.silkTouch || e.dropChance <= 0 || isNull(e.drops) || e.drops.length != 1) return;

  if (<ore:stickWood> has e.player.currentItem && <ore:slabWood> has e.drops[0].stack) {
    val blockPos = crafttweaker.util.Position3f.create(e.x, e.y, e.z).asBlockPos();
    e.world.setBlockState(<blockstate:minecraft:fire>, blockPos);
    e.player.currentItem.mutable().shrink(1);
    e.drops = [];
  }
});

events.onPlayerBreakSpeed(function (e as crafttweaker.event.PlayerBreakSpeedEvent) {
  if (isNull(e.player) || isNull(e.player.world) || e.player.world.remote) return;
  if (isNull(e.player.currentItem)) return;

  if (e.player.currentItem.definition.id != 'minecraft:stick') return;

  val blockItem = itemUtils.getItem(e.block.definition.id);
  if (isNull(blockItem) || isNull(blockItem.ores) || blockItem.ores.length <= 0 || !(blockItem.ores has <ore:slabWood>)) return;

  (e.player.world.native as native.net.minecraft.world.WorldServer).spawnParticle(
    EnumParticleTypes.SMOKE_NORMAL,
    0.5 + e.x, 0.5 + e.y, 0.5 + e.z, 2, 0.2, 0.1, 0.2, 0.01, 0);
  e.player.currentItem.mutable().shrink(1);
});
