#modloaded botania_tweaks
#priority -1

import crafttweaker.item.IItemStack;
import crafttweaker.oredict.IOreDictEntry;
import thaumcraft.aspect.CTAspectStack;

import mods.botaniatweaks.Agglomeration;
import mods.botaniatweaks.AgglomerationMultiblock;
import mods.botaniatweaks.AgglomerationRecipe;
import crafttweaker.util.Math.abs;

static aspects as CTAspectStack[][] = [
  Aspects('💨 ⛰️ 🔥 💧 ⟁ ⚡'),
  Aspects('〇 🕯️ 🏃 🧊 💎 🔩 ❤️ ⚰️ 💪 🔄'),
  Aspects('🐺 💀 🌱 🛠️ 🔮 👻 🌑 🔗 🕊️'),
] as CTAspectStack[][];

function hashedAspect(tier as int, hash as int) as CTAspectStack {
  return aspects[tier][hash % aspects[tier].length];
}

static agglMultiblock as AgglomerationMultiblock = AgglomerationMultiblock
  .create().checker(<twilightforest:aurora_block>, <minecraft:diamond_block>)
  .edgeReplace(<tconstruct:metal>);

// Helper Transmutation for Cobalt -> Diamond
// mods.astralsorcery.LightTransmutation.addTransmutation(IItemStack stackIn, IItemStack stackOut, double cost);
mods.astralsorcery.LightTransmutation.addTransmutation(<tconstruct:metal>, <minecraft:diamond_block>, 50);

function magicProcessing(nativeClusterOreEntry as IOreDictEntry, ore_name as string) as void {
  val hash = abs(ore_name.hashCode());
  val dirtyGem = oreDict['dirtyGem' ~ ore_name].firstItem;
  if (isNull(dirtyGem)) return; // 🛑

  var currItem as IItemStack = nativeClusterOreEntry.firstItem;
  var prevItem as IItemStack = null;
  var k = 0;

  val processList = [
    oreDict['crystalAbyss' ~ ore_name].firstItem,
    oreDict['rockyChunk' ~ ore_name].firstItem,
    oreDict['chunk' ~ ore_name].firstItem,
    oreDict['dustAlch' ~ ore_name].firstItem,
  ] as IItemStack[];

  //  ██████╗
  // ██╔═████╗
  // ██║██╔██║
  // ████╔╝██║
  // ╚██████╔╝
  //  ╚═════╝
  scripts.process.beneficiate(dirtyGem, ore_name, 12, { meltingExceptions: scripts.vars.meltingExceptions }, 4);

  // manual furnance
  val ingotOrGem = utils.getSomething(ore_name, ['ingot', 'gem', 'dust', 'any'], 12);
  if (!isNull(ingotOrGem)) furnace.addRecipe(ingotOrGem, dirtyGem);

  //  ██╗
  // ███║
  // ╚██║
  //  ██║
  //  ██║
  //  ╚═╝
  prevItem = currItem;
  currItem = processList[k]; k += 1;
  if (isNull(currItem)) return; // 🛑
  val crystalShard = oreDict['crystalShard' ~ ore_name].firstItem; if (isNull(crystalShard)) return; // 🛑
  furnace.addRecipe(dirtyGem * 1, currItem);

  // mods.astralsorcery.StarlightInfusion.addInfusion(IItemStack input, IItemStack output, boolean consumeMultiple, float consumptionChance, int craftingTickTime);
  mods.astralsorcery.StarlightInfusion.addInfusion(prevItem, crystalShard, false, 0.1, 10);
  mods.inworldcrafting.FluidToItem.transform(crystalShard, <fluid:astralsorcery.liquidstarlight>, [prevItem], true);
  craft.shapeless(currItem, 'cccc', { c: crystalShard });
  craft.shapeless(currItem * 2, 'cccccccc', { c: crystalShard });
  scripts.process.compress(crystalShard * 7, currItem * 2, 'only: Compactor');

  // ██████╗
  // ╚════██╗
  //  █████╔╝
  // ██╔═══╝
  // ███████╗
  // ╚══════╝
  prevItem = currItem;
  currItem = processList[k]; k += 1;
  if (isNull(currItem)) return; // 🛑
  furnace.addRecipe(dirtyGem * 4, currItem);

  val biomeStone = itemUtils.getItem('botania:biomestonea', hash % 8);
  val a_recipe = AgglomerationRecipe.create();
  a_recipe.output(currItem);
  a_recipe.color1(0x1010FF).color2(0x0FFF3F).multiblock(agglMultiblock);
  a_recipe.inputs(Grid(['qO'], {
    O: biomeStone,
    q: prevItem * 3,
  }).shapeless());
  a_recipe.manaCost(75000);
  Agglomeration.addRecipe(a_recipe);

  // ██████╗
  // ╚════██╗
  //  █████╔╝
  //  ╚═══██╗
  // ██████╔╝
  // ╚═════╝
  prevItem = currItem;
  currItem = processList[k]; k += 1;
  if (isNull(currItem)) return; // 🛑
  furnace.addRecipe(dirtyGem * 10, currItem);

  // mods.bloodmagic.AlchemyTable.addRecipe(IItemStack output, IItemStack[] inputs, int syphon, int ticks, int minTier);
  mods.bloodmagic.AlchemyTable.addRecipe(currItem * 2, [
    prevItem, prevItem, <bloodmagic:component:8>, prevItem, prevItem, <bloodmagic:cutting_fluid:1>,
  ], 5000, 40, 4);

  // ██╗  ██╗
  // ██║  ██║
  // ███████║
  // ╚════██║
  //      ██║
  //      ╚═╝
  prevItem = currItem;
  currItem = processList[k]; k += 1;
  if (isNull(currItem)) return; // 🛑
  furnace.addRecipe(dirtyGem * 48, currItem);

  mods.thaumcraft.Infusion.registerRecipe(
    'Benefication_' ~ prevItem.definition.id, // name
    'INFUSION', // research
    currItem, // output
    3, // instability
    [hashedAspect(0, hash) * 120, hashedAspect(1, hash) * 40, hashedAspect(2, hash) * 10], // aspects
    <thaumcraft:nugget:10>, // centralItem
    Grid(['qqOqqO'], { O: <ore:quicksilver>, q: prevItem }).shapeless() // recipe
  );
}
