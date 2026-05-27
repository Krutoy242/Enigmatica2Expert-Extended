#modloaded forestry
#loader forestry_charcoal

import crafttweaker.item.IItemStack;

import native.forestry.api.arboriculture.TreeManager;
import native.net.minecraft.block.Block;

/*
  Rebalance Wood Pile wall bonuses.
  Runs after Forestry postInit but before JEI loadComplete,
  so JEI sees the modified wall list.
*/

// Clear default walls for full control
TreeManager.pileWalls.clear();

function addWall(bonus as int, item as IItemStack) as void {
    val mcItem = item?.native?.item;
    if (isNull(mcItem)) return;
    val block = Block.getBlockFromItem(mcItem);
    if (isNull(block)) return;
    TreeManager.charcoalManager.registerWall(block, bonus);
}

// Add all items from an oredict entry as walls with the same bonus
function addOreWall(oreName as string, bonus as int) as void {
    for item in oreDict[oreName]?.items ?? [] {
        addWall(bonus, item);
    }
}

// === Default Forestry walls ===
// addWall(1, <minecraft:netherrack>);
// addWall(2, <minecraft:dirt>);
// addWall(3, <minecraft:clay>);
// addWall(3, <minecraft:stone_slab>);
// addWall(4, <forestry:loam>);
// addWall(5, <forestry:ash_brick>);
// addWall(6, <minecraft:brick_block>);
// addWall(6, <minecraft:nether_brick>);

// === Custom walls ===
addWall(1, <minecraft:netherrack>);
addWall(2, <sonarcore:reinforceddirtbrick>);
addWall(5, <minecraft:brick_block>);
addWall(5, <minecraft:nether_brick>);
addWall(6, <quark:sandy_bricks>);
addWall(8, <forestry:loam>);
addWall(8, <tconstruct:dried_clay:1>);
addWall(12, <twilightforest:underbrick>);
addWall(16, <forestry:ash_brick>);
