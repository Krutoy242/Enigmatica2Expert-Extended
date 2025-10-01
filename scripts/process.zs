// ######################################################################
//
// process.zs
//
// Collects all machines's functions in one place
// using:
//   scripts.process.{action}([args]);
//
// Variable "exceptions" tells what machines should be excluded from adding recipes,
//   case unsensetive. Also can be reverted with keyword "only:" from left.
//   See functions body to see machine names.
//   Keyword "strict:" try to remove old recipe before add new (replacing recipe)
//   Warning: only few machines have "strict" functions.
//
//  "exceptions" variable examples:
// "macerator"                - recipe will me added in all machines except Macerator
// "MaceRATor"                - same as above
// "Except: Macerator oh my"  - same as above
// "macerator, SagMill"       - recipe will me added in all machines except Macerator and SagMill
// "only: Macerator"          - recipe will be added to Macerator only
// "only: Macerator SagMill"  - recipe will be added to Macerator and SagMill only
// "strict: Macerator"        - recipe will be added to Macerator only, but removed old recipe first
// "maceratorSagMill"         - wrong, words should be delimited with word boundrys
// "only: blockCutter strict: shapeless" - added to blockCutter and shapeless,
//    but shapeless would be removed first
//
// ######################################################################

#modloaded jaopca mekanism
#priority 50
#reloadable

import crafttweaker.data.IData;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.liquid.ILiquidStack;
import crafttweaker.util.Math.max;
import crafttweaker.util.Math.min;

import scripts.processUtils.wholesCalc;
import scripts.processWork.work;
import scripts.processWork.workEx;

// ######################################################################
//
// Helpers
//
// ######################################################################

// Multiply item amount on double value
function iF(output as IItemStack, mult as double) as IItemStack {
  if (isNull(output)) { return null; }
  return output * max(1, min(output.maxStackSize, (output.amount as double * mult) as int));
}

static fluidSteps as double[] = [144, 666, 100, 250] as double[];

// Multiply liquid amount on double value
function lF(output as ILiquidStack, mult as double) as ILiquidStack {
  if (isNull(output)) { return null; }
  val damount = output.amount as double;
  var dresult = 0.0;
  val dmult = damount * mult;
  for step in fluidSteps {
    if (dresult == 0.0 && damount % step == 0) {
      dresult = max(step, step * ((dmult / step) as int));
    }
  }
  if (dresult == 0) { dresult = dmult; }

  return output * (dresult as int);
}

// ######################################################################
//
// Aliases functions
//
// ######################################################################

// Use sawblade to split item into pieces
// 📦 → 📦
function saw(input as IIngredient, output as IItemStack, exceptions as string = null, extra as IItemStack = null, extraChance as float = 0.0f, opts as IData = null) {
  work(['shapeless', 'BlockCutter', 'mekSawmill', 'TESawmill', 'AdvRockCutter'],
    exceptions, [input], null, [output], null, [extra], [extraChance], opts);
}

// Takes Wood Log and saw it
// Item amount recalculated automatically
// Always output one type of wood dust
// 📦 → 📦
function sawWood(input as IIngredient, output as IItemStack, exceptions as string = null) {
  val pulp = <ore:dustWood>.firstItem;
  val amount = output.amount;

  work(['shapeless']    , exceptions, [input], null, [output * (amount * 2)] , null, [pulp], null);
  work(['BlockCutter']  , exceptions, [input], null, [output * (amount * 4)] , null, [pulp], null);
  work(['mekSawmill']   , exceptions, [input], null, [output * (amount * 4)] , null, [pulp], null);
  work(['TESawmill']    , exceptions, [input], null, [output * (amount * 6)] , null, [pulp], null);
  work(['AdvRockCutter'], exceptions, [input], null, [output * (amount * 10)], null, [pulp], null);
}

// Crush (grind) item to get it dusts and byproducts
// 📦 → 📦 + [📦]?
function crush(input as IIngredient, output as IItemStack, exceptions as string = null, extra as IItemStack[] = null, extraChance as float[] = null, opts as IData = null) {
  for machine in [
    'Macerator',
    'IECrusher', 'SagMill',
    'AEGrinder', 'ThermalCentrifuge',
    'Pulverizer', 'mekCrusher', 'crushingBlock',
  ] as string[] {
    workEx(machine, exceptions, [input], null, [output], null, extra, extraChance, opts);
  }
}

// Compress item to another
// 📦 → 📦
function compress(input as IIngredient, output as IItemStack, exceptions as string = null) {
  work(['Compressor', 'Compactor'], exceptions, [input], null, [output], null, null, null);
}

// Enrich or Extract item from another
// 📦 → 📦
function extract(input as IIngredient, output as IItemStack, exceptions as string = null) {
  work(['extractor', 'mekEnrichment'], exceptions, [input], null, [output], null, null, null);
}

// Mash item. Use sharp knives on soft objects to turn them into pile of pieces
// 📦 → 📦
function mash(input as IIngredient, output as IItemStack, exceptions as string = null) {
  workEx('MetalPress', exceptions, [input], null, [output], null, null, null, { mold: 'unpack' });
}

// Alloy two or more metals into one
// [📦+] → 📦
function alloy(input as IIngredient[], output as IItemStack, exceptions as string = null, extra as IItemStack[] = null, extraChance as float[] = null, opts as IData = null) {
  work(['alloyFurnace', 'induction', 'alloySmelter', 'ArcFurnace', 'AdvRockArc', 'kiln'],
    exceptions, input, null, [output], null, extra, extraChance, opts);
}

// Takes plant or seed and grow it
// 📦 → 📦 + 📦?
function grow(input as IIngredient, output as IItemStack, exceptions as string = null,
  secondaryOutput as IItemStack = null, secondaryChance as float = 1.0f) {
  workEx('Insolator', exceptions, [input, <thermalfoundation:fertilizer>], null, [output * min(64, output.amount * 3)], null, [secondaryOutput], [secondaryChance], { energy: 4800 });
  workEx('Insolator', exceptions, [input, <thermalfoundation:fertilizer:1>], null, [output * min(64, output.amount * 6)], null, [secondaryOutput], [secondaryChance], { energy: 7200 });
  workEx('Insolator', exceptions, [input, <thermalfoundation:fertilizer:2>], null, [output * min(64, output.amount * 9)], null, [secondaryOutput], [secondaryChance], { energy: 9600 });
}

// Crushing rocks (like granite, andesite, etc..) to obtain dusts
// 📦 → [📦📦📦]
function crushRock(input as IIngredient, output as IItemStack[], chances as float[] = null, exceptions as string = null) {
  work(['rockCrusher', 'crushingBlock'], exceptions, [input], null, null, null, output, chances);
}

// Takes soft or moist item, squeeze it to get liquid or another item
// 📦 → 💧? + 📦?
function squeeze(input as IIngredient[], fluidOutput as ILiquidStack, exceptions as string = null, itemOutput as IItemStack = null) {
  work(['CrushingTub']       , exceptions, input, null, [iF(itemOutput, 0.5)]        , [lF(fluidOutput, 0.5)]     , null  , null);
  work(['Squeezer']          , exceptions, input, null, [iF(itemOutput, 0.5)]        , [lF(fluidOutput, 0.666667)], null  , null);
  work(['ForestrySqueezer']  , exceptions, input, null, [iF(itemOutput, 0.5)]        , [lF(fluidOutput, 0.9)]     , null  , null);
  work(['TECentrifuge']      , exceptions, input, null, [iF(itemOutput, 0.75)]       , [fluidOutput]              , null  , null);
  work(['IndustrialSqueezer'], exceptions, input, null, [itemOutput]                 , [fluidOutput]              , null  , null);
}

// Solute (mix, dissolve) 1+ items in 1+ liquids to get new 1+ liquids
// [📦+] ⤵
//         [💧+]
// [💧+]  ⤴
function solution(inputItems as IIngredient[], inputLiquids as ILiquidStack[], outputLiquids as ILiquidStack[], inputChance as float[] = null, exceptions as string = null, options as IData = null) {
  work(['vat', 'canner', 'fluidenricher', 'highoven', 'ChemicalReactor', 'Mixer'],
    exceptions, inputItems, inputLiquids, null, outputLiquids, null, inputChance, options);
}

// Electrolyze
// 💧 → [💧+]
function electrolyze(inputLiquid as ILiquidStack, outputLiquids as ILiquidStack[], exceptions as string = null, options as IData = null) {
  work([
    'ElectrolytiCcrucible',
    'ElectrolyticSeparator',
    'AdvRockElectrolyzer',
  ], exceptions, null, [inputLiquid], null, outputLiquids, null, null, options);
}

// Evaporate (dry) liquid to leave precipitate
// 💧 → 📦
function evaporate(inputLiquid as ILiquidStack, output as IItemStack, exceptions as string = null) {
  work(['EvaporatingBasin'],      exceptions, null, [inputLiquid], [iF(output, 0.5)],  null, null, null);
  work(['DryingBasin'],           exceptions, null, [inputLiquid], [iF(output, 0.75)], null, null, null);
  work(['MechanicalDryingBasin'], exceptions, null, [inputLiquid], [iF(output, 1.0)],  null, null, null);
}

// Perform recycling on item made from metal
// Output can be liquid or item form, based on machine
// 📦 → 📦|💧
function recycleMetal(input as IIngredient, output as IItemStack, liquid as ILiquidStack = null, exceptions as string = null) {
  work(['ArcFurnace'], exceptions, [input], null, [output], null, null, null);
  work(['induction']  , exceptions, [input, <minecraft:sand>], null, [output], null, [itemUtils.getItem('thermalfoundation:material', 864)], [0.1f]);

  if (!isNull(liquid)) {
    work(['smeltery'], exceptions, [input], null, [output], [lF(liquid, 0.75)], null, null);
  }
}

// Melts item in liquid form
// 📦 → 💧
function melt(input as IIngredient, output as ILiquidStack, exceptions as string = null, options as IData = null) {
  work(['smeltery', 'melter', 'crucible'], exceptions, [input], null, null, [output], null, null, options);
}

// Fill an item with liquid
// 📦 ⤵
//     📦
// 💧  ⤴
function fill(itemInput as IIngredient, fluidInput as ILiquidStack, output as IItemStack, exceptions as string = null, skip as bool = false) {
  val newAmount1 = min(1000, lF(fluidInput, 1.6).amount);
  val newAmount2 = min(1000, lF(fluidInput, 1.4).amount);
  work(['Casting']              , exceptions, [itemInput], [skip ? fluidInput : lF(fluidInput, 1.8)]    , [output], null, null, null);
  work(['DryingBasin']          , exceptions, [itemInput], [skip ? fluidInput : fluidInput * newAmount1], [output], null, null, null);
  work(['MechanicalDryingBasin'], exceptions, [itemInput], [skip ? fluidInput : fluidInput * newAmount2], [output], null, null, null);
  work(['NCInfuser']            , exceptions, [itemInput], [skip ? fluidInput : lF(fluidInput, 1.2)]    , [output], null, null, null);
  work(['Transposer']           , exceptions, [itemInput], [skip ? fluidInput : fluidInput]             , [output], null, null, null);
}

// Perfor some magic over item(s) to create new item(s)
// [📦+] → [📦+]
function magic(input as IIngredient[], output as IItemStack[], exceptions as string = null) {
  work(['starlightInfuser'], exceptions, input, null, output, null, null, null);
}

// Takes raw material (like Ore block) and enrich (process, treat) it to get materials
// 📦 → 📦|💧
function beneficiate(
  _input as IIngredient,   // Raw item (mostly ore) that would be processed (amount account)
  _oreName as string,      // Ore name of this material, for example "Gold"
  _amount as double = 1.0, // Amount of default simple output (like smelting ore in furnace)
  opts as IData = null,    // Special options
  step as int = 1          // Each next tier of machine add this amount to output
) {
  val calc = wholesCalc(_input.amount, _amount);
  val amount = calc.outs as int;
  val newOutAmount = _input.amount * calc.ins as int;
  val input = (newOutAmount == 1 && _input.amount == 1) ? _input : _input * newOutAmount;

  val oreName = (_oreName == 'Aluminum') ? 'Aluminium' : _oreName;

  val exceptions = D(opts).getString('exceptions', '');

  // Determine extra output based on JAOPCA
  val JA = mods.jaopca.JAOPCA.getOre(oreName);
  val extraChances = [
    min(1.0, 1.0 / 6 * amount),
    min(1.0, 0.1  * amount),
    min(1.0, 0.05 * amount)] as float[];

  // Infernal Furnace
  if (!isNull(JA)) {
    val outTriple = (amount as double * calc.out1 as double) as int;
    val nuggetExtra = utils.getSomething(JA.secondExtraName, ['nugget'], outTriple);
    if (!isNull(nuggetExtra)) {
      val input1 = input.itemArray[0].anyAmount();
      workEx('infernalfurnace', exceptions, [input1], null, null, null, [nuggetExtra * min(nuggetExtra.amount, 24)], extraChances, null);
    }
  }

  // Crush Dust or Gem
  val dustOrGem = utils.getSomething(oreName, ['dust', 'gem', 'any'], amount + step);
  if (!isNull(dustOrGem)) {
    var extraList = [] as IItemStack[];
    if (!isNull(JA)) {
      var cx as IItemStack = null;
      cx = utils.getSomething(JA.extraName,       ['dust', 'gem'], 1); if (!isNull(cx)) extraList += cx;
      cx = utils.getSomething(JA.secondExtraName, ['dust', 'gem'], 1); if (!isNull(cx)) extraList += cx;
      cx = utils.getSomething(JA.thirdExtraName,  ['dust', 'gem'], 1); if (!isNull(cx)) extraList += cx;
    }

    // All crushing methods except sag mill
    crush(input, dustOrGem, `${exceptions} macerator thermalCentrifuge crushingBlock SAGMill`, extraList, extraChances);

    // Sag mill separately since work too fast and too much output
    val sagmillChances = floatArrayOf(extraChances.length, 1.0f);
    for i, chance in extraChances { sagmillChances[i] = chance / 2.0f; }
    crush(input, dustOrGem * (3.0 / 4 * dustOrGem.amount) as int, 'only: SAGMill', extraList, sagmillChances, { bonusType: 'MULTIPLY_OUTPUT' });

    if (extraList.length >= 3) {
      workEx('massspectrometer', null, [input], null, [
        dustOrGem * min(64, dustOrGem.amount * 2),
      ], null, [
        extraList[0] * min(64, extraList[0].amount * 2),
        extraList[1] * min(64, extraList[1].amount * 2),
        extraList[2] * min(64, extraList[2].amount * 2),
      ], null, opts);
      workEx('massspectrometer', null, [input], [<fluid:terrestrial> * 16], [
        dustOrGem,
      ], null, [
        extraList[0] * min(64, extraList[0].amount * 6),
        extraList[1] * min(64, extraList[1].amount * 6),
        extraList[2] * min(64, extraList[2].amount * 6),
      ], null, opts);
    }
  }

  // Crush IC2
  val crushedOrDust = utils.getSomething(oreName, ['crushed', 'dust', 'any'], amount + step);
  if (!isNull(crushedOrDust)) {
    crush(input, crushedOrDust, 'only: macerator', null, null);
  }

  // Magic
  val ingotOrGem = utils.getSomething(oreName, ['ingot', 'gem', 'any'], amount + step * 2);
  if (!isNull(ingotOrGem)) {
    magic([input], [ingotOrGem], exceptions);
  }

  // Melt
  val molten as ILiquidStack = !isNull(JA) ? JA.getLiquidStack('molten') : null;
  val altLiquid as ILiquidStack = game.getLiquid((oreName == 'Aluminium' ? 'Aluminum' : oreName).toLowerCase());
  val liquid = isNull(molten) ? altLiquid : molten;
  if (!isNull(liquid) && !isNull(JA)) {
    val meltingExceptions = D(opts).get('meltingExceptions', { d: [] }).asList();
    var meltAllowed = true;
    for meltExc in meltingExceptions { if (meltExc.asString() == oreName) meltAllowed = false; }
    if (meltAllowed) {
      if (JA.oreType.toLowerCase() == 'ingot') { melt(input * 1, liquid * (144 * (amount + step) / input.amount), exceptions); }
      if (JA.oreType.toLowerCase() == 'gem')   { melt(input * 1, liquid * (666 * (amount + step) / input.amount), exceptions); }
    }
  }

  // Mekanism machines can't work with NBT tags for inputs
  // So check if we have NBT first
  if (!input.itemArray[0].hasTag) {
    val clump = utils.getSomething(oreName, ['clump'], amount + step * 2);
    if (!isNull(clump)) {
      workEx('mekpurification', exceptions, [input], null, [clump], null, null, null, null);
    }

    val slurryName = 'slurry' ~ oreName;
    val slurry = mods.mekanism.MekanismHelper.getGas(slurryName);
    if (!isNull(slurry)) {
      val gasAmount = (amount + step * 4) * 200;
      workEx('mekdissolution', exceptions, [input], null, null, null, null, null, { gasOutput: slurryName, gasOutputAmount: gasAmount });
    }

    val shard = utils.getSomething(oreName, ['shard'], amount + step * 3);
    if (!isNull(shard)) {
      workEx('mekinjection', exceptions, [input], null, [shard], null, null, null, null);
    }
  }
}
