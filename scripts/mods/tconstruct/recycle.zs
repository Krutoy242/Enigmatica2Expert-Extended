#modloaded tconstruct zentoolforge
#norun

import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.util.Math.abs;
import crafttweaker.util.Math.max;
import crafttweaker.util.Math.sqrt;
import mods.zentoolforge.Toolforge;

// -----------------------------------------------------------------------
// ██╗   ██╗ █████╗ ██████╗ ██╗ █████╗ ██████╗ ██╗     ███████╗███████╗
// ██║   ██║██╔══██╗██╔══██╗██║██╔══██╗██╔══██╗██║     ██╔════╝██╔════╝
// ██║   ██║███████║██████╔╝██║███████║██████╔╝██║     █████╗  ███████╗
// ╚██╗ ██╔╝██╔══██║██╔══██╗██║██╔══██║██╔══██╗██║     ██╔══╝  ╚════██║
//  ╚████╔╝ ██║  ██║██║  ██║██║██║  ██║██████╔╝███████╗███████╗███████║
//   ╚═══╝  ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝╚══════╝
// -----------------------------------------------------------------------

// Tools that would be used to recycle
// Must be length of 5
static validToolsList as string[] = [
  // "tconstruct:hammer",
  // "tconstruct:battlesign",
  // "tconstruct:excavator",
  // "tconstruct:frypan",
  'tconstruct:hatchet',
  // "tconstruct:kama",
  // "tconstruct:lumberaxe",
  // "tconstruct:mattock",
  'tconstruct:pickaxe',
  'tconstruct:shovel',
  'tcomplement:chisel',
  'tcomplement:sledge_hammer',
  // "tconevo:tool_sceptre",
  // "exnihilocreatio:crook_tconstruct",
] as string[];

var validTools as IIngredient = itemUtils.getItem(validToolsList[0]).anyDamage();
for i, toolId in validToolsList {
  if (i == 0) continue;
  val tool = itemUtils.getItem(toolId);
  if (isNull(tool)) continue;
  validTools |= tool.anyDamage();
}


// -----------------------------------------------------------------------
// ███╗   ███╗ █████╗ ████████╗██╗  ██╗
// ████╗ ████║██╔══██╗╚══██╔══╝██║  ██║
// ██╔████╔██║███████║   ██║   ███████║
// ██║╚██╔╝██║██╔══██║   ██║   ██╔══██║
// ██║ ╚═╝ ██║██║  ██║   ██║   ██║  ██║
// ╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝
// -----------------------------------------------------------------------
function shard(mat as string, amount as int = 1) as IItemStack {
  return amount > 1
    ? <tconstruct:shard>.withTag({ Material: mat }) * amount
    : <tconstruct:shard>.withTag({ Material: mat });
}

function getShard(
  input as IItemStack,
  tool_lvl as int,
  poverValue as double, // TODO: power should somehow increase output
  durabValue as double
) as IItemStack {
  // Check if input have tags
  val mats_data = D(input.tag).get('TinkerData.Materials');
  if (isNull(mats_data)) return shard('paper');
  val mats = mats_data.asList();

  // Calculate material amount for each parts
  val deconstructed = Toolforge.deconstructTool(input);
  val listCost = [1.0, 1.0, 1.0, 1.0] as double[];
  for i, dec in deconstructed {
    if (isNull(dec.tag.Material)) continue;
    val partCost = scripts.mods.tconstruct.vars.partCosts[dec.definition.id];
    val cost = !isNull(partCost) ? partCost : 1.0;
    listCost[i] = max(1.0, cost * durabValue * 2.0 + 0.5);
  }

  // Return if no mats available
  val listLen = mats.length;
  if (listLen <= 0) return shard('bone');

  // Gather harvest levels of mats
  var listNames = [] as string[];
  var listLevel = [] as int[];
  for i in 0 .. listLen {
    val matName = mats[i].asString();
    val forgeMat = Toolforge.getMaterialFromID(matName);
    listNames += matName;
    listLevel += !isNull(forgeMat)
      ? (forgeMat.hasHeadStats() ? forgeMat.harvestLevelHead : 1)
      : 1;
  }

  // Sort level indexes
  val sorted = utils.sortInt(listLevel);

  // Pick first applicable level
  for i in 0 .. sorted.length {
    val index = sorted[i];
    val lvl = listLevel[index];

    if (tool_lvl >= lvl)
      return <tconstruct:shard>.withTag({ Material: listNames[index] }) * listCost[index];
  }

  // Gear too strong for tools
  return shard('stone');
}

// -----------------------------------------------------------------------
// Functions
// -----------------------------------------------------------------------
function getToolsStats(tool as IItemStack) as double[string] {
  val toolDTagStats = D(tool.tag.Stats);
  return {
    HarvestLevel: toolDTagStats.getInt('HarvestLevel', 0),
    Attack      : toolDTagStats.getFloat('Attack', 0.0f),
    MiningSpeed : toolDTagStats.getFloat('MiningSpeed', 0.0f),
  } as double[string];
}

function getPerfectOrder(input as IItemStack) as int[] {
  val indexes = [0, 1, 2, 3, 4] as int[];
  val result = [0, 1, 2, 3, 4] as int[];
  val hashSrt = input.definition.id ~ input.tag.asString();
  for i in 0 .. 5 {
    val j = i == 4 ? 0 : abs((hashSrt ~ i).hashCode() % (indexes.length - i));
    result[i] = indexes[j];
    indexes[j] = indexes[4 - i];
  }
  return result;
}

function disassemble(ins as IItemStack[string]) as IItemStack {
  // Exit if tools repeats
  for i in 0 .. 4 {
    for j in (i + 1) .. 5 {
      if (ins['t' ~ i].definition.id == ins['t' ~ j].definition.id) return null;
    }
  }

  // Check if tool order match random one
  val indexes = getPerfectOrder(ins.t);
  var matchPositions = 0;
  // utils.log("~~ Perfect tool order: " ~indexes[0]~indexes[1]~indexes[2]~indexes[3]~indexes[4]);
  for i, j in indexes {
    if (ins['t' ~ i].definition.id == validToolsList[j]) matchPositions += 1;
  }
  if (matchPositions < 5) {
    val resultDmg = ins.t.damage + (5 - matchPositions);
    if (resultDmg >= ins.t.maxDamage) return <tconstruct:shard>.withTag({ Material: 'wood' });
    return ins.t.withDamage(resultDmg);
  }

  // 🔨 Tools
  var average_power = 0;
  var average_level = 0;
  for i in 0 .. 5 {
    val stats = getToolsStats(ins['t' ~ i]);
    average_power += stats.Attack + stats.MiningSpeed;
    average_level += stats.HarvestLevel;
  }
  average_power /= 5;
  average_level /= 5;

  // 4️⃣ Amount of Shard Stacks
  val poverValue = max(1.0, sqrt(average_power / 3.0)) as int;
  val durabValue = 1.0 - ins.t.damage as double / ins.t.maxDamage as double;

  val shard = getShard(ins.t, average_level, poverValue, durabValue);

  // 👞 Output shard
  return shard;
}

function getGhostID(item as IItemStack, ads as string) as string {
  val str = item.definition.id ~ item.tag.asString() ~ ads;
  val result = validToolsList[abs(str.hashCode() % validToolsList.length)];
  return result;
}

// -----------------------------------------------------------------------
// ██████╗ ███████╗ ██████╗██╗██████╗ ███████╗███████╗
// ██╔══██╗██╔════╝██╔════╝██║██╔══██╗██╔════╝██╔════╝
// ██████╔╝█████╗  ██║     ██║██████╔╝█████╗  ███████╗
// ██╔══██╗██╔══╝  ██║     ██║██╔═══╝ ██╔══╝  ╚════██║
// ██║  ██║███████╗╚██████╗██║██║     ███████╗███████║
// ╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝╚═╝     ╚══════╝╚══════╝
// -----------------------------------------------------------------------

val T = validTools.only(function (item) { return item.damage < item.maxDamage; }).transformDamage(1);
recipes.addShaped(
  'tcon_Disassembling',
  <tconstruct:shard>, [
    [T.marked('t0'), T.marked('t1'), T.marked('t2')],
    [T.marked('t3'), scripts.mods.tconstruct.vars.allTconEquipment.marked('t'), T.marked('t4')],
  ],
  function (out, ins, cInfo) {
    return disassemble(ins);
  }, null
);

val example_tool = scripts.equipment.utils_tcon.constructTool(
  <tconstruct:lumberaxe>, 'wood', 'manyullyn', 'iron', 'paper'
);

val toolExamples = [
  example_tool,
  example_tool.withDamage(example_tool.maxDamage * 0.75),
] as IItemStack[];

val materialExamples = [
  ['paper', 'paper', 'stone', 'flint'],
  ['knightslime', 'manyullyn', 'pigiron', 'endstone'],
  ['chaotic_metal', 'draconic_metal', 'wyvern_metal', 'draconium'],
] as string[][];

val modifiersExamples = [
  [],
  ['diamond', 'sharpness', 'haste', 'emerald'],
] as string[][];

var k = 0;
for example in toolExamples {
  for modifiers in modifiersExamples {
    for mats in materialExamples {
      val tools = [null, null, null, null, null] as IItemStack[];
      for i, valid in validToolsList {
        tools[i] = scripts.equipment.utils_tcon.constructTool(
          itemUtils.getItem(valid), mats[0], mats[1], mats[2], mats[3], modifiers
        );
      }
      val a = getPerfectOrder(example);
      recipes.addShaped(
        'disassemble_example_' ~ k,
        disassemble({
          t : example,
          t0: tools[a[0]],
          t1: tools[a[1]],
          t2: tools[a[2]],
          t3: tools[a[3]],
          t4: tools[a[4]],
        }), [
          [tools[0], tools[1], tools[2]],
          [tools[3], example, tools[4]],
        ]
      );
      k += 1;
    }
  }
}
