#modloaded loottweaker
#ignoreBracketErrors
#priority 10

import crafttweaker.data.IData;
import crafttweaker.item.IItemStack;
import crafttweaker.item.WeightedItemStack;
import crafttweaker.util.IRandom;
import crafttweaker.util.Math;
import loottweaker.LootContext;
import loottweaker.vanilla.loot.Conditions;
import loottweaker.vanilla.loot.Functions;
import mods.zentoolforge.Toolforge;
import mods.zenutils.DataUpdateOperation.APPEND;
import mods.zenutils.DataUpdateOperation.REMOVE;
import modtweaker.tconstruct.ITICMaterial;

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

function removePools(tableName as string, stringList as string[]) as void {
  val table = loottweaker.LootTweaker.getTable(tableName);
  for str in stringList {
    table.removePool(str);
  }
}

function removeEtriesFromPool(tableName as string, poolName as string, stringList as string[]) as void {
  val pool = loottweaker.LootTweaker.getTable(tableName).getPool(poolName);
  for str in stringList {
    pool.removeEntry(str);
  }
}

function clearPool(tableName as string, poolName as string) as void {
  loottweaker.LootTweaker.getTable(tableName).getPool(poolName).clearEntries();
}

function addLootToPool(tableName as string, poolName as string, lootTable as int[][IItemStack]) as void {
  val pool = loottweaker.LootTweaker.getTable(tableName).getPool(poolName);
  for key, value in lootTable {
    if (isNull(key)) continue;
    val weight = value[0];
    val luckQuality = value[1];
    pool.addItemEntry(
      key, weight, luckQuality,
      [Functions.setCount(value[2], value[3])],
      []
    );
  }
}

function addSpecialTool(tableName as string, tool as IItemStack, materials as string[], displayName as string) as void {
  val pool = loottweaker.LootTweaker.getTable(tableName).addPool('specialTool', 1.0f, 1.0f, 0.0f, 0.0f);
  pool.addConditions([Conditions.randomChance(0.05)]);
  pool.addItemEntry(tool, 1, 0,
    [Functions.zenscript(function (input as IItemStack, rng as IRandom, context as LootContext) as IItemStack {
      var materialList = [] as ITICMaterial[];
      for material in materials { materialList += Toolforge.getMaterialFromID(material); }
      return scripts.equipment.utils_tcon.addModifier(Toolforge.buildTool(tool.definition, materialList).withDisplayName(displayName), 'tconevo.artifact');
    })], []);
}

function addRandomCapacitor(tableName as string, chance as float) as void {
  val pool = loottweaker.LootTweaker.getTable(tableName).addPool('enderIOCapacitor', 1.0f, 1.0f, 0.0f, 0.0f);
  pool.addItemEntry(<enderio:item_basic_capacitor:4>, 1, 0, [{"function":"enderio:set_capacitor"}], []);
  pool.addConditions([Conditions.randomChance(chance)]);
}

function addAncientTomes(tableName as string, poolName as string, weight as int) as void{
  loottweaker.LootTweaker.getTable(tableName).getPool(poolName).addItemEntry(<quark:ancient_tome>, weight, 0, [{"function":"quark:enchant_tome"}], []);
}

/*
██████╗  █████╗  ██████╗██╗  ██╗██████╗  █████╗  ██████╗██╗  ██╗    ██╗  ██╗ █████╗ ███╗   ██╗██╗     ██████╗ ███████╗██████╗
██╔══██╗██╔══██╗██╔════╝██║ ██╔╝██╔══██╗██╔══██╗██╔════╝██║ ██╔╝    ██║  ██║██╔══██╗████╗  ██║██║     ██╔══██╗██╔════╝██╔══██╗
██████╔╝███████║██║     █████╔╝ ██████╔╝███████║██║     █████╔╝     ███████║███████║██╔██╗ ██║██║     ██║  ██║█████╗  ██████╔╝
██╔══██╗██╔══██║██║     ██╔═██╗ ██╔═══╝ ██╔══██║██║     ██╔═██╗     ██╔══██║██╔══██║██║╚██╗██║██║     ██║  ██║██╔══╝  ██╔══██╗
██████╔╝██║  ██║╚██████╗██║  ██╗██║     ██║  ██║╚██████╗██║  ██╗    ██║  ██║██║  ██║██║ ╚████║███████╗██████╔╝███████╗██║  ██║
╚═════╝ ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝     ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝    ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚═════╝ ╚══════╝╚═╝  ╚═╝
*/

function addBackpackPool(tableName as string) as void {
  loottweaker.LootTweaker.getTable(tableName).addPool('lootBackpack', 1.0f, 1.0f, 0.0f, 0.0f);
}

function addBackpackEmpty(tableName as string, weight as int = 1) as void {
  loottweaker.LootTweaker.getTable(tableName).getPool('lootBackpack').addEmptyEntry(weight, 0, [], 'empty');
}

function addBackpackWithLoot(tableName as string, lootCommon as IData[], lootUncommon as IData[], lootRare as IData[], weight as int = 1) as void {
  loottweaker.LootTweaker.getTable(tableName).getPool('lootBackpack').addItemEntry(
    <travelersbackpack:travelers_backpack>,
    weight, 0,
    [Functions.zenscript(function (input as IItemStack, rng as IRandom, context as LootContext) as IItemStack {
      var dataTag = [] as IData;
      var slots = [] as IData;
      for i in 0 .. 48 {
        slots += [i];
      }

      for i in 0 .. rng.nextInt(48) {
        var table as IData[] = [];
        val number = rng.nextInt(100);
        if (number > 97) { table = lootRare; }
        else if (number > 80) { table = lootUncommon; }
        else { table = lootCommon; }
        val x = slots[rng.nextInt(slots.length)];
        slots = slots.deepUpdate([x], REMOVE);
        val item = table[rng.nextInt(table.length)];
        if (isNull(item)) continue;
        var dataToAdd as IData = {Slot: x, Count: rng.nextInt(item.tab[0], item.tab[1]), id: item.item.id};
        if (!isNull(item.item.tag)) dataToAdd = dataToAdd + {tag: item.item.tag};
        if (!isNull(item.item.Damage)) dataToAdd = dataToAdd + {Damage: item.item.Damage};

        dataTag = dataTag.deepUpdate([dataToAdd], APPEND);
      }
      return input.withTag({Items: dataTag});
    })],
    [],
    'lootBackpack'
  );
}

function addBackpackForestryWithLoot(bagType as IItemStack, tableName as string, lootCommon as IData[], lootUncommon as IData[], lootRare as IData[], weight as int = 1) as void {
  loottweaker.LootTweaker.getTable(tableName).getPool('lootBackpack').addItemEntry(
    bagType,
    weight, 0,
    [Functions.zenscript(function (input as IItemStack, rng as IRandom, context as LootContext) as IItemStack {
      var dataTag = [] as IData;
      var slots = [] as IData;
      if (bagType.definition.id.endsWith('t2')) {
        slots = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18',
          'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
        ] as IData;
      }
      else {
        slots = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e'] as IData;
      }

      for i in 0 .. rng.nextInt(slots.length) {
        var table as IData[] = [];
        val number = 4.0 - Math.log(rng.nextInt(1, 65)) / Math.log(4);
        if (number > 3) { table = lootRare; }
        else if (number > 2) { table = lootUncommon; }
        else { table = lootCommon; }
        val x = slots[rng.nextInt(slots.length)];
        slots = slots.deepUpdate([x], REMOVE);
        val item = table[rng.nextInt(table.length)];
        if (isNull(item)) continue;
        var dataToAdd as IData = {Count: rng.nextInt(item.tab[0], item.tab[1]), id: item.item.id};
        if (!isNull(item.item.tag)) dataToAdd = dataToAdd + {tag: item.item.tag};
        if (!isNull(item.item.Damage)) dataToAdd = dataToAdd + {Damage: item.item.Damage};
        dataTag = dataTag.deepUpdate({[x]: dataToAdd}, APPEND);
      }
      return input.withTag({Slots: dataTag});
    })],
    [],
    `lootBackpackForestry${bagType.definition.id}`
  );
}

function addBackpackCyclicWithLoot(tableName as string, lootCommon as IData[], lootUncommon as IData[], lootRare as IData[], weight as int = 1) as void {
  loottweaker.LootTweaker.getTable(tableName).getPool('lootBackpack').addItemEntry(
    <cyclicmagic:storage_bag>,
    weight, 0,
    [Functions.zenscript(function (input as IItemStack, rng as IRandom, context as LootContext) as IItemStack {
      var dataTag = [] as IData;
      var slots = [] as IData;
      for i in 0 .. 76 {
        slots += [i];
      }

      for i in 0 .. rng.nextInt(76) {
        var table as IData[] = [];
        val number = 4.0 - Math.log(rng.nextInt(1, 65)) / Math.log(4);
        if (number > 3) { table = lootRare; }
        else if (number > 2) { table = lootUncommon; }
        else { table = lootCommon; }
        val x = slots[rng.nextInt(slots.length)];
        slots = slots.deepUpdate([x], REMOVE);
        val item = table[rng.nextInt(table.length)];
        if (isNull(item)) continue;
        var dataToAdd as IData = {Slot: x, Count: rng.nextInt(item.tab[0], item.tab[1]), id: item.item.id};
        if (!isNull(item.item.tag)) dataToAdd = dataToAdd + {tag: item.item.tag};
        if (!isNull(item.item.Damage)) dataToAdd = dataToAdd + {Damage: item.item.Damage};

        dataTag = dataTag.deepUpdate([dataToAdd], APPEND);
      }
      return input.withTag({ItemInventory: dataTag});
    })],
    [],
    'lootBackpackCyclic'
  );
}
