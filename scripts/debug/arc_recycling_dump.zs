#modloaded immersiveengineering
#reloadable

import native.net.minecraftforge.fml.common.registry.ForgeRegistries;
import native.net.minecraft.item.crafting.IRecipe;
import native.net.minecraft.item.ItemStack;
import native.blusunrize.immersiveengineering.common.crafting.ArcRecyclingThreadHandler;

function dumpArcRecycling() as void {
  val linesList = [] as [string];

  val recipes as [IRecipe] = ForgeRegistries.RECIPES.getValuesCollection();
  for recipe in recipes {
    val output = recipe.getRecipeOutput();
    if (output.isEmpty()) continue;
    if (!ArcRecyclingThreadHandler.isValidForRecycling(output)) continue;
    val calc = ArcRecyclingThreadHandler.getRecycleCalculation(output, recipe);
    if (isNull(calc)) continue;

    val inputStack = calc.getStack();
    val outputsMap = calc.getOutputs();
    if (outputsMap.isEmpty()) continue;

    val entriesList = [] as [string];
    for _entry in outputsMap.entrySet() {
      val entry = _entry as native.java.util.Map.Entry;
      val key = entry.key as ItemStack;
      val value = toString(entry.value) as double;
      entriesList.add(key.wrapper.commandString ~ ': ' ~ value);
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

    val inputStr = inputStack.wrapper.commandString;

    linesList.add('add(' ~ inputStr ~ ', ' ~ mapStr ~ ');');
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
}

val cmd = mods.zenutils.command.ZenCommand.create('dump_arc_recycling');
cmd.requiredPermissionLevel = 0;
cmd.execute = function (command, server, sender, args) {
  dumpArcRecycling();
};
cmd.register();
