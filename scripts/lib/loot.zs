#modloaded loottweaker

import crafttweaker.item.IItemStack;
import crafttweaker.item.WeightedItemStack;
import loottweaker.vanilla.loot.Functions;
import loottweaker.vanilla.loot.Conditions;

#priority 10

// Remove old drop and add new
function tweak(
  table as string,
  poolStr as string,
  entryToRemove as string,
  itemToRemove as IItemStack,
  itemsToAdd as WeightedItemStack[],
  minMax as int[],
  isByPlayer as bool = false,
  poolWeight as int = 1
) {
  // Current pool
  var pool = loottweaker.LootTweaker.getTable(table).getPool(poolStr);

  // Remove old drops if specified
  if (!isNull(entryToRemove))
    pool.removeEntry(entryToRemove);

  // Add new drops
  if (!isNull(itemsToAdd)) {
    for itemToAdd in itemsToAdd {
      var conditions = isByPlayer ? [Conditions.killedByPlayer()] : [];

      if (itemToAdd.chance < 1.0f) {
        conditions += Conditions.randomChance(itemToAdd.chance);
      }

      val smelted = utils.smelt(itemToAdd.stack);
      if (!isNull(smelted)) {
        // Add with smelting function (if smelted item exist)
        pool.addItemEntry(itemToAdd.stack, poolWeight, 0, [
          Functions.parse({
            'function': 'minecraft:furnace_smelt',
            conditions: [
              {
                properties: { 'minecraft:on_fire': true },
                entity: 'this',
                condition: 'minecraft:entity_properties',
              },
            ],
          }),
          Functions.setCount(minMax[0], minMax[1]),
          Functions.lootingEnchantBonus(0, 1, 0),
        ], conditions);
      }
      else {
        // Add non-smelt function
        pool.addItemEntry(itemToAdd.stack, poolWeight, 0, [
          Functions.setCount(minMax[0], minMax[1]),
          Functions.lootingEnchantBonus(0, 1, 0),
        ], conditions);
      }
    }
  }

  // Remove old item from JEI and crafts
  // usually need when unify meat
  if (!isNull(itemToRemove)) {
    Purge(utils.smelt(itemToRemove)).furn();
    Purge(itemToRemove);
  }
}