#modloaded thaumicwonders tconstruct
#priority -1 // For oredict iteration

import crafttweaker.item.IItemStack;
import crafttweaker.recipes.IRecipeFunction;
import mods.thaumicwonders.MeatyOrb;
import mods.thaumicwonders.CatalyzationChamber;

<entity:thaumicwonders:corruption_avatar>.addDrop(<thaumictinkerer:kamiresource:2>, 13, 25);

// Cast quicksilver back to gem
recipes.removeByRecipeName('thaumicwonders:quicksilver_bucket');
recipes.removeByRecipeName('thaumicwonders:quicksilver_bucket_deconstruct');
mods.tconstruct.Casting.addTableRecipe(<thaumcraft:quicksilver>, <tconstruct:cast_custom:2>, <liquid:fluid_quicksilver>, 125, false, 1);
scripts.process.melt(<thaumcraft:quicksilver>, <liquid:fluid_quicksilver> * 125);

// [Flux Capacitor] from [Vis Battery][+4]
mods.thaumcraft.Infusion.removeRecipe(<thaumicwonders:flux_capacitor>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe(
  'flux_capacitor', // Name
  'TWOND_FLUX_CAPACITOR', // Research
  200, // Vis cost
  Aspects('⛰️ 🔥'),
  <thaumicwonders:flux_capacitor>, // Output
  Grid(['pretty',
    '  *  ',
    'F V F',
    '  *  '], {
    '*': <ore:oreCrystalTaint>, // Flux Crystal
    'F': <thaumcraft:condenser_lattice>, // Flux Condenser Lattice
    'V': <thaumcraft:vis_battery>, // Vis Battery
  }).shaped());

// [Flux Distiller] from [Flux Condenser][+8]
mods.thaumcraft.ArcaneWorkbench.removeRecipe(<thaumicwonders:flux_distiller>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe(
  'flux_distiller', // Name
  'TWOND_FLUX_DISTILLER', // Research
  750, // Vis cost
  Aspects('8💨 8💧 8⟁'),
  <thaumicwonders:flux_distiller>, // Output
  Grid(['pretty',
    '□ F □',
    'C l C',
    '□ c □'], {
    '□': <ore:plateVoid>, // Void Metal Plate
    'F': <thaumcraft:condenser_lattice>, // Flux Condenser Lattice
    'C': <thaumcraft:mechanism_complex>, // Complex Arcane Mechanism
    'l': <thaumcraft:condenser>, // Flux Condenser
    'c': <thaumcraft:metal_alchemical>, // Alchemical Construct
  }).shaped());

// ---------------------------------------------------------
// Trans Stones rework
// ---------------------------------------------------------
static transStoneMaxDamage as int = 32766;

val transStones = [
  <thaumicwonders:alchemist_stone>,
  <thaumicwonders:transmuter_stone>,
  <thaumicwonders:alienist_stone>,
] as IItemStack[];

static getBonused as function(int,int)int = function (durA as int, durB as int) as int {
  return durA + durB + 0.05 * transStoneMaxDamage; // Vanilla anvil math
};

static getOutDurab as function(IItemStack,IItemStack)int = function (a as IItemStack, b as IItemStack) as int {
  if (a.damage == 0 && b.damage == 0) return -1 as int;
  val durA = a.maxDamage - a.damage;
  val durB = b.maxDamage - b.damage;
  return max(0, a.maxDamage - getBonused(durA, durB));
};

static stoneCombiningRecipeFunc as IRecipeFunction = function (out, ins, cInfo) {
  if (isNull(ins.a) || isNull(ins.b)) return null;
  val newDur = getOutDurab(ins.a, ins.b);
  return newDur < 0 ? null : out.withDamage(newDur);
} as IRecipeFunction;

for i, stone in transStones {
  // JEI recipe
  val maxDmg = stone.maxDamage;
  val quartStone = stone.withDamage(maxDmg as double * 0.75);
  recipes.addShapeless('stone jei ' ~ i,
    stone.withDamage(
      maxDmg - getBonused(maxDmg / 4, maxDmg / 4)
    ),
    [quartStone, quartStone]
  );

  // Actual combining recipe
  recipes.addHiddenShapeless('stone combining ' ~ i,
    stone, [stone.anyDamage().marked('a'), stone.anyDamage().marked('b')],
    stoneCombiningRecipeFunc, null
  );
}

// [Alienist's Stone] from [Starmetal Ingot][+7]
mods.thaumcraft.Infusion.removeRecipe(<thaumicwonders:alienist_stone>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe(
  'alienist_stone', // Name
  'TWOND_ALIENIST_STONE@1', // Research
  10, // Vis cost
  Aspects('5💨 5💧'),
  <thaumicwonders:alienist_stone>.withDamage(transStoneMaxDamage - 128), // Output
  Grid(['pretty',
    '  ˛  ',
    'ͺ - ‚',
    '  ͵  '], {
    '˛': <ore:nuggetVoid>, // Void Metal Nugget
    'ͺ': <ore:nuggetMalachite>, // Malachite Nugget
    '-': <ore:ingotAstralStarmetal>,
    '‚': <ore:nuggetTopaz>, // Topaz Nugget
    '͵': <ore:nuggetDraconium>, // Draconium Nugget
  }).shaped());

// [Alchemist's Stone] from [Phial of Ordo Essentia]*5[+2]
mods.thaumcraft.Crucible.removeRecipe(<thaumicwonders:alchemist_stone>);
mods.thaumcraft.Crucible.registerRecipe(
  'alchemist_stone', // Name
  'TWOND_CATALYZATION_CHAMBER@2', // Research
  <thaumicwonders:alchemist_stone>.withDamage(transStoneMaxDamage - 128), // Output
  <ore:ingotSilver>, // Input
  Aspects('20⟁ 10⚗️')
);

// [Transmuter's Stone] from [Phial of Permutatio Essentia]*5[+2]
mods.thaumcraft.Crucible.removeRecipe(<thaumicwonders:transmuter_stone>);
mods.thaumcraft.Crucible.registerRecipe(
  'transmuter_stone', // Name
  'TWOND_TRANSMUTER_STONE@1', // Research
  <thaumicwonders:transmuter_stone>.withDamage(transStoneMaxDamage - 128), // Output
  <ore:ingotElectrum>, // Input
  Aspects('20🔄 20⚗️')
);

events.onPlayerPickupItem(function (e as crafttweaker.event.PlayerPickupItemEvent) {
  if (e.player.world.remote) return;
  if (isNull(e.item) || isNull(e.item.item)) return;

  val id = e.item.item.definition.id;
  if (
    id != 'thaumicwonders:alienist_stone'
    && id != 'thaumicwonders:alchemist_stone'
    && id != 'thaumicwonders:transmuter_stone'
  ) return;

  // e.player.sendMessage('Picked up');
  for i in 0 .. e.player.inventorySize {
    val item = e.player.getInventoryStack(i);
    if (isNull(item) || item.definition.id != id) continue;
    val newDur = getOutDurab(item, e.item.item);
    if (newDur < 0) continue;
    e.item.item.mutable().shrink(1);
    item.mutable().withDamage(newDur);
    e.cancel();
    return;
  }
});

// ---------------------------------------------------------
// Unbreakable stones
// ---------------------------------------------------------
// Sadly, but Infusion recipes bugging with this stones.
// This may be caused by huge Damage value

// [Alchemist's Stone] from [Alchemist's Stone][+7]
craft.make(<thaumicwonders:alchemist_stone>.withTag({ Unbreakable: 1 as byte } as crafttweaker.data.IData + utils.shiningTag(14602026)), ['pretty',
  '▬ e ▬',
  '□ o □',
  '▬ ▲ ▬'], {
  'o': <thaumicwonders:alchemist_stone>, // Central Item
  '▬': <ore:ingotGlitch>, // Glitch Infused Ingot
  'e': <thaumcraft:pech_wand>, // Pech Wand
  '□': <ore:plateMithrillium>, // Mithrillium Plate
  '▲': <ore:dustMana>, // Mana Dust
});

// [Transmuter's Stone] from [Transmuter's Stone][+7]
craft.make(<thaumicwonders:transmuter_stone>.withTag({ Unbreakable: 1 as byte } as crafttweaker.data.IData + utils.shiningTag(14602026)), ['pretty',
  '▬ e ▬',
  '□ o □',
  '▬ ▲ ▬'], {
  'o': <thaumicwonders:transmuter_stone>, // Central Item
  '▬': <ore:ingotGlitch>, // Glitch Infused Ingot
  'e': <thaumcraft:pech_wand>, // Pech Wand
  '□': <ore:plateMithrillium>, // Mithrillium Plate
  '▲': <ore:dustMana>, // Mana Dust
});

// [Alienist's Stone] from [Alienist's Stone][+7]
craft.make(<thaumicwonders:alienist_stone>.withTag({ Unbreakable: 1 as byte } as crafttweaker.data.IData + utils.shiningTag(14602026)), ['pretty',
  '▬ e ▬',
  '□ o □',
  '▬ ▲ ▬'], {
  'o': <thaumicwonders:alienist_stone>, // Central Item
  '▬': <ore:ingotGlitch>, // Glitch Infused Ingot
  'e': <thaumcraft:pech_wand>, // Pech Wand
  '□': <ore:plateMithrillium>, // Mithrillium Plate
  '▲': <ore:dustMana>, // Mana Dust
});

// [Alkahest vat]
mods.thaumcraft.Crucible.removeRecipe(<thaumicwonders:alkahest_vat>);
mods.thaumcraft.Infusion.registerRecipe(
  'alkahest_vat', // Name
  'TWOND_ALKAHEST', // Research
  <thaumicwonders:alkahest_vat>, // Output
  5, // Instability
  Aspects('100⚗️ 25☀️ 100🧨 50♒ 200✨'),
  <thaumcraft:crucible>, // CentralItem
  [
    <thaumicaugmentation:material:5>,
    <thaumadditions:aura_disperser> ?? <deepmoblearning:pristine_matter_enderman>,
    <thaumicaugmentation:material:5>,
    <thaumadditions:crystal_block>.withTag({ Aspect: 'visum' }) ?? <deepmoblearning:pristine_matter_enderman>,
    <thaumicaugmentation:material:5>,
    <thaumadditions:aura_disperser> ?? <deepmoblearning:pristine_matter_enderman>,
    <thaumicaugmentation:material:5>,
    <thaumadditions:aura_charger> ?? <deepmoblearning:pristine_matter_enderman>,
  ]
);

// [Creative Essentia Jar] from [Black Hole Talisman][+7]
craft.remake(<thaumicwonders:creative_essentia_jar>, ['pretty',
  'B D V D B',
  'S I M I S',
  'T M l M T',
  'S I M I S',
  'B D A D B'], {
  'B': <bloodmagic:decorative_brick:1>, // Bloodstone Brick
  'D': <bloodmagic:points_upgrade>, // Draft of Angelus
  'V': <thaumicwonders:void_beacon>, // Void Beacon
  'S': <thaumicaugmentation:starfield_glass:1>, // Starfield Glass (Dimensional Fracture)
  'I': <thaumicaugmentation:impetus_mirror>, // Impetus Mirror
  'M': <thaumadditions:jar_mithminite> ?? <extrautils2:snowglobe:1>, // Mithminite Fortified Jar
  'l': <botania:blackholetalisman>, // Black Hole Talisman
  'A': <thaumicwonders:alkahest_vat>, // Alkahest Vat
  'T': <contenttweaker:meat_singularity>.withTag({ completed: 1 as byte }),
});

// [Primordial siphon]
mods.thaumcraft.Infusion.removeRecipe(<thaumicwonders:primordial_siphon>);
mods.thaumcraft.Infusion.registerRecipe(
  'primordial_siphon', // Name
  'TWOND_PRIMORDIAL_SIPHON@1', // Research
  <thaumicwonders:primordial_siphon>, // Output
  3, // Instability
  Aspects('75⚡ 75💨 75⟁ 75⛰️ 75💧 75🔥 50🔷'),
  <thaumcraft:void_siphon>, // Central Item
  Grid(['rM'], {
    'r': <thaumcraft:nugget:10>, // Rare earth
    'M': <botania:manaresource:2>, // Mana diamond
}).spiral(1));

// [Vis capacitor]
mods.thaumcraft.Infusion.removeRecipe(<thaumicwonders:alienist_stone>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe(
  'vis_capacitor', // Name
  'TWOND_VIS_CAPACITOR', // Research
  75, // Vis cost
  Aspects('3💨 3💧 3⟁'),
  <thaumicwonders:vis_capacitor>, // Output
  Grid(['pretty',
    '  G  ',
    'T B T',
    '  R  '], {
    'B': <thaumcraft:vis_battery>, // Vis battery
    'G': <thaumicwonders:primordial_grain>, // Primordial grain
    'R': <thaumcraft:vis_resonator>, // Vis resonator
    'T': <thaumcraft:plate:2>, // Thaumium plate
}).shaped());

// [Primal destroyer]
mods.thaumcraft.Infusion.removeRecipe(<thaumicwonders:primal_destroyer>);
mods.thaumcraft.Infusion.registerRecipe(
  'primal_destroyer', // Name
  'TWOND_PRIMAL_DESTROYER@1', // Research
  <thaumicwonders:primal_destroyer>.withTag({infench: [{lvl: 3 as short, id: 6 as short}, {lvl: 2 as short, id: 14 as short}]}), // Output
  5, // Instability
  Aspects('75⚡ 75💨 75⟁ 75⛰️ 75💧 75🔥 50🔷'),
  <iceandfire:dragonbone>, // Central Item
  Grid(['RFNVGVEF'], {
    'F': <thaumadditions:zeith_fur>, // Blue wolf fur
    'N': <thaumictinkerer:kamiresource:1>, // Nether shard
    'G': <thaumicwonders:primordial_grain>, // Primordial grain
    'E': <thaumictinkerer:kamiresource>, // Ender shard
    'R': <rats:ratlantean_flame>, // Ratlantean Spirit Flame
    'V': <thaumcraft:plate:3>, // Void metal plate
}).spiral(1));

// [Void beacon]
mods.thaumcraft.Infusion.removeRecipe(<thaumicwonders:void_beacon>);
mods.thaumcraft.Infusion.registerRecipe(
  'void_beacon', // Name
  'TWOND_VOID_BEACON', // Research
  <thaumicwonders:void_beacon>, // Output
  4, // Instability
  Aspects('75⚡ 75💨 75⟁ 75⛰️ 75💧 75🔥 50🔷'),
  <minecraft:beacon>, // Central Item
  Grid(['IPIPIPIP'], {
    'I': <thaumicaugmentation:material:5>, // Impetus jewel
    'P': <tconevo:metal:20>, // Primal metal
}).spiral(1));

// Remove unnecessary recipes

mods.thaumcraft.Crucible.removeRecipe('thaumicwonders:entropyblazepowder');
mods.thaumcraft.Crucible.removeRecipe('thaumicwonders:entropybonemeal');
mods.thaumcraft.Crucible.removeRecipe('thaumicwonders:entropysunflower');
mods.thaumcraft.Crucible.removeRecipe('thaumicwonders:entropylilac');
mods.thaumcraft.Crucible.removeRecipe('thaumicwonders:entropyrose');
mods.thaumcraft.Crucible.removeRecipe('thaumicwonders:entropypeony');
mods.thaumcraft.Crucible.removeRecipe('thaumicwonders:entropysugar');

mods.thaumcraft.Crucible.removeRecipe('thaumicwonders:orderwool');
mods.thaumcraft.Crucible.removeRecipe('thaumicwonders:orderglowstone');
mods.thaumcraft.Crucible.removeRecipe('thaumicwonders:ordermagma');
mods.thaumcraft.Crucible.removeRecipe('thaumicwonders:orderquartz');
mods.thaumcraft.Crucible.removeRecipe('thaumicwonders:ordersandstone');
mods.thaumcraft.Crucible.removeRecipe('thaumicwonders:orderprismarine');
mods.thaumcraft.Crucible.removeRecipe('thaumicwonders:orderchorus');

mods.thaumcraft.Crucible.removeRecipe('thaumicwonders:avariccoal');
mods.thaumcraft.Crucible.removeRecipe('thaumicwonders:avaricdiamond');
mods.thaumcraft.Crucible.removeRecipe('thaumicwonders:avaricemerald');
mods.thaumcraft.Crucible.removeRecipe('thaumicwonders:avaricquartz');
mods.thaumcraft.Crucible.removeRecipe('thaumicwonders:avaricamber');

mods.thaumcraft.Crucible.removeRecipe('thaumicwonders:hedge_dragons_breath');

mods.thaumicwonders.MeatyOrb.removeAll();
for item in <ore:listAllmeatraw>.items {
  if(!isNull(item)) mods.thaumicwonders.MeatyOrb.add(item, 1);
}

mods.thaumicwonders.CatalyzationChamber.removeAll();

val clusterList = [
  <jaopca:item_clusteraluminium>,
  <jaopca:item_clusteramber>,
  <jaopca:item_clusteramethyst>,
  <jaopca:item_clusteranglesite>,
  <jaopca:item_clusterapatite>,
  <jaopca:item_clusteraquamarine>,
  <jaopca:item_clusterardite>,
  <jaopca:item_clusterastralstarmetal>,
  <jaopca:item_clusterbenitoite>,
  <jaopca:item_clusterboron>,
  <jaopca:item_clustercertusquartz>,
  <jaopca:item_clusterchargedcertusquartz>,
  <jaopca:item_clustercoal>,
  <jaopca:item_clustercobalt>,
  <jaopca:item_clusterdiamond>,
  <jaopca:item_clusterdilithium>,
  <jaopca:item_clusterdimensionalshard>,
  <jaopca:item_clusterdraconium>,
  <jaopca:item_clusteremerald>,
  <jaopca:item_clusteriridium>,
  <jaopca:item_clusterlapis>,
  <jaopca:item_clusterlithium>,
  <jaopca:item_clustermagnesium>,
  <jaopca:item_clustermalachite>,
  <jaopca:item_clustermithril>,
  <jaopca:item_clusternickel>,
  <jaopca:item_clusterosmium>,
  <jaopca:item_clusterperidot>,
  <jaopca:item_clusterplatinum>,
  <jaopca:item_clusterquartzblack>,
  <jaopca:item_clusterredstone>,
  <jaopca:item_clusterruby>,
  <jaopca:item_clustersapphire>,
  <jaopca:item_clustertanzanite>,
  <jaopca:item_clusterthorium>,
  <jaopca:item_clustertitanium>,
  <jaopca:item_clustertopaz>,
  <jaopca:item_clustertrinitite>,
  <jaopca:item_clustertungsten>,
  <jaopca:item_clusteruranium>,
  <thaumcraft:cluster:1>,
  <thaumcraft:cluster:2>,
  <thaumcraft:cluster:3>,
  <thaumcraft:cluster:4>,
  <thaumcraft:cluster:5>,
  <thaumcraft:cluster:6>,
  <thaumcraft:cluster:7>,
  <thaumcraft:cluster>
] as IItemStack[];

for itemCluster in clusterList {
  for oreEntry in itemCluster.ores {
    if (oreEntry.name.matches("^cluster.*")) {

      val oreOre = oreDict.get(oreEntry.name.replaceFirst("cluster", "ore"));
      if (!oreOre.empty) mods.thaumicwonders.CatalyzationChamber.addAlchemistRecipe(oreOre.firstItem, itemCluster);

      val oreShard = oreDict.get(oreEntry.name.replaceFirst("cluster", "crystalShard"));
      if (!oreShard.empty) mods.thaumicwonders.CatalyzationChamber.addAlienistRecipe(itemCluster, oreShard.firstItem);

      break;
    }
  }
}

val orePrefixList = [
  'block',
  'ingot',
  'dust',
  'nugget',
  'ore',
  '',
] as string[];

val oreSufixList = {
  'Draconium':'AstralStarmetal',
  'Aluminium':'Titanium',
  'coal':'bitumen',
  'Ardite':'Cobalt',
  'Dilithium':'DimensionalShard',
  'Redstone':'Ruby',
  'Iron':'Gold',
  'Lead':'Silver',
  'Peridot':'Emerald',
  'Xorcite':'Aquamarine',
  'Iridium':'Platinum',
  'CertusQuartz':'ChargedCertusQuartz',
  'Uranium':'Thorium',
  'Copper':'Tin',
  'Diamond':'Sapphire',
} as string[string];

for item1, item2 in oreSufixList {
  for orePrefix in orePrefixList{
    val ore1 = oreDict.get(orePrefix ~ item1);
    val ore2 = oreDict.get(orePrefix ~ item2);
    val item1 = utils.oreToItem(ore1);
    val item2 = utils.oreToItem(ore2);
    if(!ore1.empty && !isNull(item2)){
      mods.thaumicwonders.CatalyzationChamber.addTransmuterRecipe(ore1, item2);
    }
    if(!ore2.empty && !isNull(item1)){
      mods.thaumicwonders.CatalyzationChamber.addTransmuterRecipe(ore2, item1);
    }
  }
} 
