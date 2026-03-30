#ignoreBracketErrors
#modloaded bloodmagic requious
#priority 950

import crafttweaker.entity.IEntityDefinition;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import mods.randomtweaker.jei.IJeiUtils;
import mods.requious.AssemblyRecipe;
import mods.zenutils.StringList;

import scripts.commands.perf.util.naturalInt;
import scripts.mixin.bloodmagic.shared.Op;

// -----------------------------------------------------------------------
// -----------------------------------------------------------------------
val x = <assembly:meteor>;
x.addJEICatalyst(<bloodmagic:ritual_diviner:1>.withTag({ current_ritual: 'meteor' }));
x.setJEIDurationSlot(1, 1, 'duration', scripts.jei.requious.getVisGauge(1, 8));
x.setJEIItemSlot (0, 1, 'f0');
x.setJEIFluidSlot(0, 0, 'f1');

var k = 0;
for _y in 0 .. 3 {
  for _x in 2 .. 9 {
    x.setJEIItemSlot(_x, _y, 'output');
    k += 1;
  }
}

/* Inject_js(
globSync('config/bloodmagic/meteors/*.json')
.map(loadJson)
.map((f) => {
  const weightName = f.components
    .map(c => [c.weight, c.oreName])
    .sort(([a], [b]) => b - a)
  const volume = 4.0 / 3.0 * Math.PI * (0.2 + f.radius) ** 3
  const totalWeight = weightName.reduce((acc, [w]) => acc + w, 0)
  return [
    `addMeteor(`,
    `<${f.catalystStack.registryName.domain}:${f.catalystStack.registryName.path}:${f.catalystStack.meta}>`,
    `, `,
    f.cost,
    `, [`,
    `${
      weightName
      .map(([weight, name]) => `<ore:${name}> * ${weight / totalWeight * volume | 0}`)
      .join(', ')
    }]);`,
  ]
}).sort((a, b) => b[2] - a[2])
) */
addMeteor(<minecraft:iron_block:0>        , 300000 , [<ore:oreIron> * 529, <ore:oreCopper> * 264, <ore:oreTin> * 185, <ore:oreRedstone> * 132, <ore:oreAluminum> * 132, <ore:oreLead> * 105, <ore:oreSilver> * 92, <ore:oreLapis> * 79, <ore:oreGold> * 39]);
addMeteor(<thermalfoundation:storage:7>   , 500000 , [<ore:mica> * 196, <ore:oreIridium> * 130, <ore:orePlatinum> * 91, <ore:oreMithril> * 65, <ore:oreRutile> * 45, <ore:oreAstralStarmetal> * 32, <ore:oreDraconium> * 26]);
addMeteor(<immersiveengineering:storage:5>, 550000 , [<ore:oreBoron> * 108, <ore:oreThorium> * 93, <ore:oreLithium> * 62, <ore:oreMagnesium> * 46]);
addMeteor(<minecraft:emerald_block:0>     , 700000 , [<ore:oreAmber> * 27, <ore:oreDiamond> * 22, <ore:oreLapis> * 20, <ore:oreCertusQuartz> * 20, <ore:oreCinnabar> * 15, <ore:oreCoal> * 3, <ore:oreRuby> * 3, <ore:orePeridot> * 3, <ore:oreTopaz> * 3, <ore:oreTanzanite> * 3, <ore:oreMalachite> * 3, <ore:oreSapphire> * 3, <ore:oreApatite> * 3, <ore:oreQuartzBlack> * 3]);
addMeteor(<tconstruct:metal:1>            , 850000 , [<ore:oreCobalt> * 62, <ore:oreArdite> * 62, <ore:oreQuartz> * 55, <ore:oreNetherCoal> * 48, <ore:oreNetherRedstone> * 40, <ore:oreNetherLapis> * 37, <ore:oreNetherIron> * 33, <ore:oreNetherGold> * 29, <ore:oreNetherTin> * 25, <ore:oreNetherAluminum> * 22, <ore:oreNetherCopper> * 22, <ore:oreNetherLead> * 22, <ore:oreNetherDiamond> * 22, <ore:oreNetherNickel> * 18, <ore:oreNetherSilver> * 18, <ore:oreNetherCertusQuartz> * 18, <ore:oreNetherChargedCertusQuartz> * 14, <ore:oreNetherPlatinum> * 11, <ore:oreNetherOsmium> * 11, <ore:oreNetherUranium> * 11]);
addMeteor(<jaopca:block_blockdilithium:0> , 1000000, [<ore:sandOxidisedFerric> * 182, <ore:oreEndDilithium> * 91, <ore:oreClathrateEnder> * 36]);
/**/

function addMeteor(catalyst as IItemStack, cost as int, oreList as IIngredient[]) as void {
  val ass = AssemblyRecipe.create(function (container) {
    for ore in oreList {
      container.addItemOutput('output', ore.items[0] * ore.amount);
    }
  });
  ass.requireItem('f0', catalyst);
  ass.requireFluid('f1', <fluid:lifeessence> * cost);
  <assembly:meteor>.addJEIRecipe(ass);
}

// -----------------------------------------------------------------------

var p = mods.jei.JEI.createJei('le_vulcanos_frigius', 'Le Vulcanos Frigius');
p.setBackground(IJeiUtils.createBackground(4 * 18, 1 * 18));
p.addRecipeCatalyst(<bloodmagic:ritual_diviner>.withTag({current_ritual: 'cobblestone'}));
p.addRecipeCatalyst(<bloodmagic:arcane_ashes>);
p.setIcon(<bloodmagic:ritual_diviner>.withTag({current_ritual: 'cobblestone'}));
p.addSlot(IJeiUtils.createItemSlot('input', 0, 0, true, false));
p.addElement(IJeiUtils.createArrowElement(24, 1, 0));
p.addSlot(IJeiUtils.createItemSlot('output', 3 * 18, 0, false, false));
p.setModid('bloodmagic');
p.register();

function addModifier(i as int, result as IItemStack) as void {
  if (isNull(result)) {
    logger.logWarning('BloodMagic JEI error: le_vulcanos_frigius ritual cant found modifier №' ~ i);
    return;
  }
  mods.jei.JEI.createJeiRecipe('le_vulcanos_frigius')
    .addInput(<bloodmagic:component>.definition.makeStack(i))
    .addOutput(result)
    .build();
}

if (isNull(Op.catalystToBlock)) Op.catalystToBlock = Op.init();
for i, block in Op.catalystToBlock {
  if (isNull(block)) continue;
  addModifier(i, scripts.do.portal_spread.utils.stateToItem(block));
}

p = mods.jei.JEI.createJei('sacrificial_values', 'Sacrificial Values');
p.setBackground(IJeiUtils.createBackground(4 * 18, 1 * 18));
p.addRecipeCatalyst(<bloodmagic:dagger_of_sacrifice>);
p.addRecipeCatalyst(<bloodmagic:ritual_diviner:1>.withTag({current_ritual: 'well_of_suffering'}));
p.setIcon(<bloodmagic:dagger_of_sacrifice>);
p.addSlot(IJeiUtils.createItemSlot('input', 0, 0, true, false));
p.addElement(IJeiUtils.createArrowElement(24, 1, 0));
p.addSlot(IJeiUtils.createLiquidSlot('output', 3 * 18, 0, false, false));
p.setModid('bloodmagic');
p.register();

/* Inject_js(
config('config/bloodmagic/bloodmagic.cfg')
  .values.sacrificialValues
  .map(s => s.split(';'))
  .sort(([,a], [,b]) => a - b)
  .map(([id, value]) => {
    if (id.split(':').length <= 1) id = `minecraft:${id}`
    return `sacrifice(<entity:${id}>, ${value});`
  })
) */
sacrifice(<entity:minecraft:enderman>, 10);
sacrifice(<entity:minecraft:slime>, 15);
sacrifice(<entity:minecraft:villager>, 100);
sacrifice(<entity:minecraft:cow>, 100);
sacrifice(<entity:minecraft:chicken>, 100);
sacrifice(<entity:minecraft:horse>, 100);
sacrifice(<entity:minecraft:sheep>, 100);
sacrifice(<entity:minecraft:wolf>, 100);
sacrifice(<entity:minecraft:ocelot>, 100);
sacrifice(<entity:minecraft:pig>, 100);
sacrifice(<entity:minecraft:rabbit>, 100);
sacrifice(<entity:betteranimalsplus:badger>, 1500);
sacrifice(<entity:betteranimalsplus:blackbear>, 1500);
sacrifice(<entity:betteranimalsplus:boar>, 1500);
sacrifice(<entity:betteranimalsplus:bobbit_worm>, 1500);
sacrifice(<entity:betteranimalsplus:brownbear>, 1500);
sacrifice(<entity:betteranimalsplus:coyote>, 1500);
sacrifice(<entity:betteranimalsplus:crab>, 1500);
sacrifice(<entity:betteranimalsplus:deer>, 1500);
sacrifice(<entity:betteranimalsplus:eel_freshwater>, 1500);
sacrifice(<entity:betteranimalsplus:eel_saltwater>, 1500);
sacrifice(<entity:betteranimalsplus:feralwolf>, 1500);
sacrifice(<entity:betteranimalsplus:fox>, 1500);
sacrifice(<entity:betteranimalsplus:goat>, 1500);
sacrifice(<entity:betteranimalsplus:goose>, 1500);
sacrifice(<entity:betteranimalsplus:hirschgeist>, 1500);
sacrifice(<entity:betteranimalsplus:horseshoecrab>, 1500);
sacrifice(<entity:betteranimalsplus:jellyfish>, 1500);
sacrifice(<entity:betteranimalsplus:lammergeier>, 1500);
sacrifice(<entity:betteranimalsplus:lamprey>, 1500);
sacrifice(<entity:betteranimalsplus:moose>, 1500);
sacrifice(<entity:betteranimalsplus:nautilus>, 1500);
sacrifice(<entity:betteranimalsplus:pheasant>, 1500);
sacrifice(<entity:betteranimalsplus:reindeer>, 1500);
sacrifice(<entity:betteranimalsplus:shark>, 1500);
sacrifice(<entity:betteranimalsplus:songbird>, 1500);
sacrifice(<entity:betteranimalsplus:squirrel>, 1500);
sacrifice(<entity:betteranimalsplus:tarantula>, 1500);
sacrifice(<entity:betteranimalsplus:turkey>, 1500);
sacrifice(<entity:betteranimalsplus:walrus>, 1500);
sacrifice(<entity:betteranimalsplus:whale>, 1500);
sacrifice(<entity:betteranimalsplus:zotzpyre>, 1500);
sacrifice(<entity:emberroot:deers>, 1500);
sacrifice(<entity:quark:crab>, 1500);
sacrifice(<entity:quark:frog>, 1500);
sacrifice(<entity:rats:rat>, 1500);
sacrifice(<entity:twilightforest:bighorn_sheep>, 1500);
sacrifice(<entity:twilightforest:bunny>, 1500);
sacrifice(<entity:twilightforest:deer>, 1500);
sacrifice(<entity:twilightforest:raven>, 1500);
sacrifice(<entity:twilightforest:penguin>, 2000);
sacrifice(<entity:twilightforest:squirrel>, 2000);
sacrifice(<entity:twilightforest:tiny_bird>, 2000);
sacrifice(<entity:iceandfire:if_cockatrice>, 3000);
sacrifice(<entity:iceandfire:firedragon>, 5000);
sacrifice(<entity:iceandfire:icedragon>, 5000);
/**/

function sacrifice(entity as IEntityDefinition, value as int) as void {
  if (isNull(entity)) return;
  mods.jei.JEI.createJeiRecipe('sacrificial_values')
    .addInput(entity.asSoul())
    .addOutput(<fluid:lifeessence> * value)
    .build();
}
