// only IE should be required here
#modloaded immersiveengineering

// load after all other deps
#priority -100
#reloadable

import crafttweaker.command.ICommandSender;
import crafttweaker.item.IIngredient;
import native.blusunrize.immersiveengineering.api.ApiUtils;
import native.blusunrize.immersiveengineering.common.crafting.ArcRecyclingThreadHandler;
import native.net.minecraft.item.ItemStack;

static recCache_maxDepth as int = 2;

// ── Cache (map-indexed for O(1) lookup) ──
static cacheKeys as [IIngredient] = [];
static cacheData as double[IIngredient][string] = {};

function clearCache() as void {
  cacheKeys = [] as [IIngredient];
  cacheData = {} as double[IIngredient][string];
}

function replaceInCache(key as IIngredient, outputs as double[IIngredient]) as void {
  if (isNull(key)) return;
  val cmd = key.commandString;
  if (!(cacheData has cmd)) cacheKeys.add(key);
  cacheData[cmd] = outputs;
}

function getCacheSize() as int {
  return cacheKeys.length;
}

// ── Breakdown: ore-dict first, cache second (×0.5) ──
function tryBreakdown(ingr as IIngredient) as double[IIngredient] {
  val items = ingr.items;
  if (items.length == 0) return null;
  val stack = items[0];
  if (isNull(stack) || stack.isEmpty) return null;

  // 1. Direct ore-dict breakdown
  val nativeStack = stack.native as ItemStack;
  if (!isNull(nativeStack)) {
    val direct = ApiUtils.breakStackIntoPreciseIngots(nativeStack);
    if (!isNull(direct)) {
      val ingot = direct[0] as ItemStack;
      if (!isNull(ingot) && !ingot.isEmpty()) {
        val result = {} as double[IIngredient];
        result[ingot.wrapper] = direct[1] as double;
        return result;
      }
    }
  }

  // 2. Cache lookup (×0.5 factor) via O(1) map
  val cmd = ingr.commandString;
  if (cacheData has cmd) {
    val outputs = cacheData[cmd];
    val result = {} as double[IIngredient];
    for mat, amt in outputs {
      result[mat] = amt * 0.5;
    }
    return result;
  }

  return null;
}

// ── Serialization helpers ──
function stackCmd(ingr as IIngredient) as string {
  if (isNull(ingr)) return 'null';
  val items = ingr.items;
  if (items.length > 0 && !isNull(items[0])) {
    val stack = items[0];
    if (stack.isDamageable) return stack.anyDamage().commandString;
    return stack.commandString;
  }
  return toString(ingr);
}

function trimOutputs(outputs as double[IIngredient], maxSlots as int) as double[IIngredient] {
  var pool = outputs;
  var totalSlots = 0;
  for k, v in pool {
    totalSlots = totalSlots + calcJEISlots(v as double, k);
  }
  while totalSlots > maxSlots {
    var minKey as IIngredient = null;
    var minVal = 0.0;
    var first = true;
    for k, v in pool {
      val vv = v as double;
      if (first) {
        minKey = k;
        minVal = vv;
        first = false;
      }
      else if (vv < minVal) {
        minKey = k;
        minVal = vv;
      }
    }
    val newPool = {} as double[IIngredient];
    val minCmd = minKey.commandString;
    for k, v in pool {
      if (k.commandString != minCmd) newPool[k] = v;
    }
    pool = newPool;
    totalSlots = 0;
    for k, v in pool {
      totalSlots = totalSlots + calcJEISlots(v as double, k);
    }
  }
  return pool;
}

function calcJEISlots(amt as double, ingr as IIngredient) as int {
  var slots = 0;
  if (amt >= 1.0) slots = 1;
  val intPart = amt as int;
  val frac = amt - intPart;
  val nuggetCount = (frac * 9) as int;
  if (nuggetCount > 0 && hasNuggetVariant(ingr)) slots = slots + 1;
  return slots;
}

function hasNuggetVariant(ingr as IIngredient) as bool {
  if (isNull(ingr)) return false;
  val items = ingr.items;
  if (items.length == 0 || isNull(items[0])) return false;
  val item = items[0];
  val ores = item.definition.ores;
  if (isNull(ores)) return false;
  for ore in ores {
    val name = ore.name;
    if (isNull(name)) continue;
    if (name.startsWith('ingot')) {
      val nuggetName = name.replace('ingot', 'nugget');
      if (isNull(nuggetName)) continue;
      val nuggetOre = oreDict.get(nuggetName);
      if (!isNull(nuggetOre) && !nuggetOre.empty) return true;
    }
  }
  return false;
}

function filterOutputs(outputs as double[IIngredient]) as double[IIngredient] {
  val result = {} as double[IIngredient];
  for k, v in outputs {
    val amt = v as double;
    if (amt >= 1.0 || hasNuggetVariant(k)) {
      result[k] = v;
    }
  }
  return result;
}

function addLine(linesList as [string], key as IIngredient, outputs as double[IIngredient]) as void {
  val entriesList = [] as [string];
  for k, v in outputs {
    entriesList.add(stackCmd(k) ~ ': ' ~ toString(v));
  }
  val entriesArr = entriesList as string[];
  mods.ctintegration.util.ArrayUtil.sort(entriesArr);
  var mapStr = '{ ';
  var first = true;
  for entryStr in entriesArr {
    if (!first) mapStr ~= ', ';
    first = false;
    mapStr ~= entryStr;
  }
  mapStr ~= ' }';
  linesList.add('add(' ~ stackCmd(key) ~ ', ' ~ mapStr ~ ');');
}

// ── Main dump function ──
function dumpArcRecycling(sender as ICommandSender) as void {
  clearCache();

  // First iterate() call collects all recipe pairs from enumerators (once),
  // subsequent calls use the internal cached list — no re-enumeration.
  for pass in 0 .. recCache_maxDepth {
    val before = getCacheSize();

    scripts.lib.store.recipes.iterate(function (outputs as IIngredient[], inputs as IIngredient[]) as int {
      if (outputs.length == 0 || inputs.length == 0) return scripts.lib.store.recipes.CB_RESULT.CONTINUE;
      val output = outputs[0];

      val outItems = output.items;
      if (outItems.length == 0) return scripts.lib.store.recipes.CB_RESULT.CONTINUE;
      val nativeOut = outItems[0].native as ItemStack;
      if (isNull(nativeOut) || nativeOut.isEmpty()) return scripts.lib.store.recipes.CB_RESULT.CONTINUE;

      val outputsMap = {} as double[IIngredient];
      for input in inputs {
        val breakdown = tryBreakdown(input);
        if (!isNull(breakdown)) {
          for mat, amt in breakdown {
            outputsMap[mat] = amt + (outputsMap has mat ? outputsMap[mat] : 0.0);
          }
        }
      }

      if (outputsMap.length == 0) return scripts.lib.store.recipes.CB_RESULT.CONTINUE;

      val outCount = nativeOut.getCount() as double;
      if (outCount > 1) {
        for mat, amt in outputsMap {
          outputsMap[mat] = amt / outCount;
        }
      }

      val filteredMap = filterOutputs(outputsMap);
      if (filteredMap.length == 0) return scripts.lib.store.recipes.CB_RESULT.CONTINUE;

      replaceInCache(output, trimOutputs(filteredMap, 6));
      return scripts.lib.store.recipes.CB_RESULT.CONTINUE;
    });

    val after = getCacheSize();
    val added = after - before;
    sender.sendMessage('\u00A7e[Recycle] \u00A77Pass \u00A7f' ~ (pass + 1) ~ '/' ~ (recCache_maxDepth + 1) ~ '\u00A77: \u00A7f' ~ after ~ '\u00A77 items cached \u00A78(+\u00A7f' ~ added ~ '\u00A78)');

    if (added == 0) {
      sender.sendMessage('\u00A7e[Recycle] \u00A77No new items, stopping early');
      break;
    }
  }

  // ── Serialize cache (armor/tools only) ──
  val linesList = [] as [string];
  for i, key in cacheKeys {
    val nativeKey = key.items[0].native as ItemStack;
    if (isNull(nativeKey) || nativeKey.isEmpty() || !ArcRecyclingThreadHandler.isValidForRecycling(nativeKey)) continue;
    addLine(linesList, key, trimOutputs(cacheData[key.commandString], 6));
  }

  val linesArr = linesList as string[];
  mods.ctintegration.util.ArrayUtil.sort(linesArr);

  var content = 'Save this into file "scripts/mods/immersiveengineering/recycling.zs"\n'
  ~ '#modloaded immersiveengineering\n'
  ~ '#priority -3000\n'
  ~ '\n'
  ~ 'import crafttweaker.item.IItemStack;\n'
  ~ '\n'
  ~ 'import native.blusunrize.immersiveengineering.common.crafting.ArcRecyclingRecipe;\n'
  ~ 'import native.blusunrize.immersiveengineering.api.crafting.ArcFurnaceRecipe;\n'
  ~ 'import native.java.util.HashMap;\n'
  ~ '\n'
  ~ 'function add(input as IItemStack, outputs as double[IItemStack], time as int = 100, energy as int = 512) as void {\n'
  ~ '  val map as HashMap = HashMap();\n'
  ~ '  for stack, chance in outputs {\n'
  ~ '    map.put(stack.native, chance);\n'
  ~ '  }\n'
  ~ '  ArcFurnaceRecipe.recipeList.add(ArcRecyclingRecipe(map, input.native, time, energy));\n'
  ~ '}\n'
  ~ '\n';

  content ~= mods.zenutils.StaticString.join(linesArr, '\n');
  content ~= '\n\n// Total recipes: ' ~ linesArr.length ~ '\n';

  print(content);

  sender.sendMessage('\u00A7e[Recycle] \u00A7aDone! \u00A7f' ~ getCacheSize() ~ '\u00A77 items cached, \u00A7f' ~ linesArr.length ~ '\u00A77 armor/tools written. \u00A78Check server log.');
}

// ── Command registration ──
val cmd = mods.zenutils.command.ZenCommand.create('dump_arc_recycling');
cmd.requiredPermissionLevel = 0;
cmd.execute = function (command, server, sender, args) {
  sender.sendMessage('\u00A7e[Recycle] \u00A77Starting Arc Furnace recycling dump...');
  dumpArcRecycling(sender);
};
cmd.register();
