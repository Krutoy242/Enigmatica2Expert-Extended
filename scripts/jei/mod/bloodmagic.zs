#priority 950
#modloaded bloodmagic requious

import mods.requious.AssemblyRecipe;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import mods.randomtweaker.jei.IJeiUtils;

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
addMeteor(<jaopca:block_blockdilithium:0> , 1000000, [<ore:sandOxidisedFerric> * 147, <ore:oreEndDilithium> * 73, <ore:oreClathrateRedstone> * 29, <ore:oreClathrateEnder> * 29, <ore:oreClathrateGlowstone> * 29]);
addMeteor(<tconstruct:metal:1>            , 850000 , [<ore:oreCobalt> * 62, <ore:oreArdite> * 62, <ore:oreQuartz> * 55, <ore:oreNetherCoal> * 48, <ore:oreNetherRedstone> * 40, <ore:oreNetherLapis> * 37, <ore:oreNetherIron> * 33, <ore:oreNetherGold> * 29, <ore:oreNetherTin> * 25, <ore:oreNetherAluminum> * 22, <ore:oreNetherCopper> * 22, <ore:oreNetherLead> * 22, <ore:oreNetherDiamond> * 22, <ore:oreNetherNickel> * 18, <ore:oreNetherSilver> * 18, <ore:oreNetherCertusQuartz> * 18, <ore:oreNetherChargedCertusQuartz> * 14, <ore:oreNetherPlatinum> * 11, <ore:oreNetherOsmium> * 11, <ore:oreNetherUranium> * 11]);
addMeteor(<minecraft:emerald_block:0>     , 700000 , [<ore:oreAmber> * 25, <ore:oreDiamond> * 20, <ore:oreLapis> * 18, <ore:oreCertusQuartz> * 18, <ore:oreCinnabar> * 14, <ore:oreProsperity> * 11, <ore:oreCoal> * 3, <ore:oreRuby> * 3, <ore:orePeridot> * 3, <ore:oreTopaz> * 3, <ore:oreTanzanite> * 3, <ore:oreMalachite> * 3, <ore:oreSapphire> * 3, <ore:oreApatite> * 3, <ore:oreQuartzBlack> * 3]);
addMeteor(<immersiveengineering:storage:5>, 550000 , [<ore:oreBoron> * 108, <ore:oreThorium> * 93, <ore:oreLithium> * 62, <ore:oreMagnesium> * 46]);
addMeteor(<thermalfoundation:storage:7>   , 500000 , [<ore:mica> * 196, <ore:oreIridium> * 130, <ore:orePlatinum> * 91, <ore:oreMithril> * 65, <ore:oreRutile> * 45, <ore:oreAstralStarmetal> * 32, <ore:oreDraconium> * 26]);
addMeteor(<minecraft:iron_block:0>        , 300000 , [<ore:oreIron> * 529, <ore:oreCopper> * 264, <ore:oreTin> * 185, <ore:oreRedstone> * 132, <ore:oreAluminum> * 132, <ore:oreLead> * 105, <ore:oreSilver> * 92, <ore:oreLapis> * 79, <ore:oreGold> * 39]);
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

val p = mods.jei.JEI.createJei('le_vulcanos_frigius', 'Le Vulcanos Frigius');
p.setBackground(IJeiUtils.createBackground(4*18, 1*18));
p.addRecipeCatalyst(<bloodmagic:ritual_diviner>.withTag({current_ritual: "cobblestone"}));
p.addRecipeCatalyst(<bloodmagic:arcane_ashes>);
p.setIcon(<bloodmagic:ritual_diviner>.withTag({current_ritual: "cobblestone"}));
p.addSlot(IJeiUtils.createItemSlot('input', 0, 0, true, false));
p.addSlot(IJeiUtils.createItemSlot('input', 18, 0, true, false));
p.addElement(IJeiUtils.createArrowElement(24, 1, 0));
p.addSlot(IJeiUtils.createItemSlot('output', 3*18, 0, false, false));
p.setModid('bloodmagic');
p.register();

function addModifier(i as int, result as IItemStack) as void {
  mods.jei.JEI.createJeiRecipe('le_vulcanos_frigius')
    .addInput(<bloodmagic:component>.definition.makeStack(i))
    .addOutput(result)
    .build();
}

/* Inject_js(
config('config/bloodmagic/bloodmagic.cfg')
  .values.ritualCobblestoneModifiers
  .map((s, i) => [i, s.replace('@', ':')])
  .filter(([,s]) => s !== 'minecraft:cobblestone')
  .map(([i, s]) => `addModifier(${i}, <${s}>);`)
) */
addModifier(0, <minecraft:prismarine>);
addModifier(1, <minecraft:obsidian>);
addModifier(2, <engineersdecor:gas_concrete>);
addModifier(3, <chisel:concrete_white>);
addModifier(4, <exnihilocreatio:block_endstone_crushed>);
addModifier(5, <tconstruct:slime_grass:1>);
addModifier(6, <contenttweaker:compressed_coral>);
addModifier(7, <extrautils2:decorativesolid:4>);
addModifier(8, <ic2:resource>);
addModifier(9, <exnihilocreatio:block_skystone_crushed>);
addModifier(11, <exnihilocreatio:block_netherrack_crushed>);
addModifier(12, <endreborn:block_lormyte_crystal>);
addModifier(13, <tconstruct:brownstone:1>);
addModifier(14, <tconstruct:soil>);
addModifier(15, <tconstruct:soil:3>);
addModifier(16, <quark:biome_cobblestone:2>);
addModifier(17, <endreborn:block_entropy_end_stone>);
addModifier(18, <quark:elder_prismarine>);
addModifier(25, <tconstruct:soil:5>);
addModifier(26, <tconstruct:soil:2>);
addModifier(27, <immersivepetroleum:stone_decoration>);
addModifier(28, <quark:biome_cobblestone:1>);
addModifier(29, <quark:biome_cobblestone>);
addModifier(30, <immersiveengineering:stone_decoration:5>);
addModifier(31, <tconstruct:slime_grass:8>);
addModifier(32, <quark:slate>);
/**/
