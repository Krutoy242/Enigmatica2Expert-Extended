#modloaded jaopca
#priority -10

import crafttweaker.data.IData;
import crafttweaker.item.IIngredient;

import scripts.category.magicProcessing.magicProcessing;
import scripts.process.beneficiate;

function getOreName(name as string, part as string) as string {
  if (name.matches(part ~ '[A-Z]\\w+')) return name.substring(part.length);
  return null;
}

// Pairs of ore names and respective liquid
val ore_liquid_exceptions = {
  Aluminium      : 'aluminum',
  AstralStarmetal: 'starmetal',
} as string[string];

for ore_entry in oreDict {
  if (ore_entry.empty) continue;

  val name = ore_entry.name;

  // Ex Nihilo ore pieces conversion to ores
  var ore_name = getOreName(name, 'piece');
  if (!isNull(ore_name)) {
    if (ore_name == 'Aluminum') continue;
    val oreBlock = oreDict.get('ore' ~ ore_name);
    if (isNull(oreBlock) || oreBlock.empty) continue;

    for item in oreBlock.items {
      val asBlock = item.asBlock();
      val asBlockDef = asBlock.definition;
      if (isNull(asBlockDef) || asBlockDef.id == 'minecraft:air') continue;
      val oreBlockState = asBlockDef.getStateFromMeta(item.damage);
      val baseChance = 1.0 / 3.0;
      scripts.do.burnt_in_fluid.add(ore_entry, oreBlockState, 'stone', baseChance);
      break;
    }
    continue;
  }

  // Native clusters processing
  ore_name = getOreName(name, 'cluster');
  if (!isNull(ore_name)) {
    if (ore_name == 'Aluminum') continue;
    
    val dirtyGem = oreDict['dirtyGem' ~ ore_name].firstItem;
    if (isNull(dirtyGem)) continue;

    recipes.addShaped('beneficate native ' ~ ore_name, dirtyGem, [
      [ore_entry, ore_entry, ore_entry],
      [ore_entry, ore_entry, ore_entry]]);

    // Fix gems melting recipes
    //   Standart JAOPCA's furnace recipes for Ores that outputs
    // gems instead of ingots have empty output, so add it forced
    val smelted = utils.smelt(ore_entry);
    if (isNull(smelted)) {
      furnace.remove(<*>, ore_entry);
      val gem = utils.getSomething(ore_name, ['ingot', 'gem', 'dust', 'any'], 2);
      if (!isNull(gem)) furnace.addRecipe(gem, ore_entry);
    }

    magicProcessing(ore_entry, ore_name);
    continue;
  }

  // Crushed Ore Smeltery compat
  ore_name = getOreName(name, 'crushedPurified');
  if (!isNull(ore_name)) {
    if (ore_name == 'Aluminum') continue;
    val exception = ore_liquid_exceptions[ore_name];
    val liquid = game.getLiquid(isNull(exception) ? ore_name.toLowerCase() : exception);
    if (isNull(liquid)) continue;

    mods.tconstruct.Melting.addRecipe(liquid * 144, ore_entry);

    val unpurified = oreDict.get('crushed' ~ ore_name);
    if (isNull(unpurified) || unpurified.empty) continue;
    
    mods.tconstruct.Melting.addRecipe(liquid * 144, unpurified);
    continue;
  }

  // Dense plates in Thermal Expansion Compactor
  ore_name = getOreName(name, 'plateDense');
  if (!isNull(ore_name)) {
    if (ore_name == 'Aluminum') continue;
    val inpOre = (ore_name == 'Obsidian')
      ? (<minecraft:obsidian> * 3) as IIngredient
      : oreDict['block' ~ ore_name];
    if (inpOre.items.length <= 0) continue;
    scripts.process.compress(inpOre, ore_entry.firstItem, 'only: Compactor');
    mods.immersiveengineering.MetalPress.addRecipe(ore_entry.firstItem, oreDict['plate' ~ ore_name], <immersiveengineering:mold:6>, 16000, 9);
    continue;
  }

  // Dirty ore additional IC2 compat
  ore_name = getOreName(name, 'dustDirty');
  if (!isNull(ore_name)) {
    if (ore_name == 'Aluminum') continue;

    val output = oreDict.get('crushedPurified' ~ ore_name);
    if (isNull(output) || output.empty) continue;

    mods.ic2.OreWasher.addRecipe([output.firstItem], ore_entry);

    continue;
  }

  // Small Plate Press
  ore_name = getOreName(name, 'plate');
  if (!isNull(ore_name)) {
    if (ore_name == 'Aluminum' || ore_name == 'Concrete') continue;

    val second = oreDict.get('block' ~ ore_name);
    if (isNull(second) || second.empty) continue;

    mods.advancedrocketry.RecipeTweaker.forMachine('SmallPlatePresser').builder()
      .inputOre(second).outputItem(utils.oreToItem(ore_entry) * 6).build();

    continue;
  }
  
  ore_name = getOreName(name, 'blockSheetmetal');
  if (!isNull(ore_name)) {
    if (ore_name == 'Aluminum') continue;

    val output = oreDict.get('stick' ~ ore_name);
    if (isNull(output) || output.empty) continue;

    mods.advancedrocketry.RecipeTweaker.forMachine('SmallPlatePresser').builder()
      .inputOre(ore_entry).outputItem(output.firstItem).build();

    continue;
  }
  
  ore_name = getOreName(name, 'stick');
  if (!isNull(ore_name)) {
    if (ore_name == 'Aluminum') continue;

    val block = oreDict.get('block' ~ ore_name);
    if (isNull(block) || block.empty) continue;
    mods.advancedrocketry.RecipeTweaker.forMachine('Lathe').builder()
      .inputOre(block).outputItem(ore_entry.firstItem * 64).power(100000).timeRequired(10).build();

    continue;
  }
}


// static benOpts as IData = {
//   exceptions       : 'Pulverizer StarlightInfuser',
//   meltingExceptions: scripts.vars.meltingExceptions,
// } as IData;
// 
// for ore_name, outputs in {
// /*Inject_js!!!!!!!{
// val clusters = Object.entries(getByOreKind('cluster')).filter(([base])=>!['Yellorium','Aluminum'].includes(base))
// val furnInputs = new Set(getUnchangedFurnaceRecipes().map(r=>r.input))
// val noFurn = new Set(clusters.map(([,tm])=>tm.commandString).filter(cs=>!furnInputs.has(cs)))

// return clusters.map(([base,tm])=>{
//   val result = noFurn.has(tm.commandString) ? getSomething(base, ["ingot", "gem", "dust", "any"], ["cluster", "ore"]) : undefined
//   return [
//   `${base}`,
//   `: [${tm.commandString}`,
//   `, ${result?.withAmount(countBaseOutput(base, 2)) ?? 'null'}`,
//   `],${result ? ' # '+result.display : ''}`
// ]})
// }*/
// Aluminium          : [<jaopca:item_clusteraluminium>          , <thermalfoundation:material:132> * 2       ], # Aluminum Ingot
// Amber              : [<jaopca:item_clusteramber>              , <biomesoplenty:gem:7> * 4                  ], # Amber
// Amethyst           : [<jaopca:item_clusteramethyst>           , <biomesoplenty:gem> * 4                    ], # Ender Amethyst
// Apatite            : [<jaopca:item_clusterapatite>            , <forestry:apatite> * 20                    ], # Apatite
// Aquamarine         : [<jaopca:item_clusteraquamarine>         , <astralsorcery:itemcraftingcomponent> * 8  ], # Aquamarine
// Ardite             : [<jaopca:item_clusterardite>             , <tconstruct:ingots:1> * 2                  ], # Ardite Ingot
// AstralStarmetal    : [<jaopca:item_clusterastralstarmetal>    , <astralsorcery:itemcraftingcomponent:1> * 2], # Starmetal Ingot
// Boron              : [<jaopca:item_clusterboron>              , <nuclearcraft:ingot:5> * 2                 ], # Boron Ingot
// CertusQuartz       : [<jaopca:item_clustercertusquartz>       , <appliedenergistics2:material> * 6         ], # Certus Quartz Crystal
// ChargedCertusQuartz: [<jaopca:item_clusterchargedcertusquartz>, <appliedenergistics2:material:1> * 4       ], # Charged Certus Quartz Crystal
// Coal               : [<jaopca:item_clustercoal>               , <minecraft:coal> * 10                      ], # Coal
// Cobalt             : [<jaopca:item_clustercobalt>             , <tconstruct:ingots> * 2                    ], # Cobalt Ingot
// Diamond            : [<jaopca:item_clusterdiamond>            , <minecraft:diamond> * 4                    ], # Diamond
// Dilithium          : [<jaopca:item_clusterdilithium>          , <libvulpes:productgem> * 2                 ], # Dilithium Crystal
// DimensionalShard   : [<jaopca:item_clusterdimensionalshard>   , <rftools:dimensional_shard> * 6            ], # Dimensional Shard
// Draconium          : [<jaopca:item_clusterdraconium>          , <draconicevolution:draconium_ingot> * 2    ], # Draconium Ingot
// Emerald            : [<jaopca:item_clusteremerald>            , <minecraft:emerald> * 4                    ], # Emerald
// Iridium            : [<jaopca:item_clusteriridium>            , <thermalfoundation:material:135> * 2       ], # Iridium Ingot
// Lapis              : [<jaopca:item_clusterlapis>              , <minecraft:dye:4> * 20                     ], # Lapis Lazuli
// Lithium            : [<jaopca:item_clusterlithium>            , <nuclearcraft:ingot:6> * 2                 ], # Lithium Ingot
// Magnesium          : [<jaopca:item_clustermagnesium>          , <nuclearcraft:ingot:7> * 2                 ], # Magnesium Ingot
// Malachite          : [<jaopca:item_clustermalachite>          , <biomesoplenty:gem:5> * 4                  ], # Malachite
// Mithril            : [<jaopca:item_clustermithril>            , <thermalfoundation:material:136> * 2       ], # Mana Infused Ingot
// Nickel             : [<jaopca:item_clusternickel>             , <thermalfoundation:material:133> * 2       ], # Nickel Ingot
// Osmium             : [<jaopca:item_clusterosmium>             , <mekanism:ingot:1> * 2                     ], # Osmium Ingot
// Peridot            : [<jaopca:item_clusterperidot>            , <biomesoplenty:gem:2> * 4                  ], # Peridot
// Platinum           : [<jaopca:item_clusterplatinum>           , <thermalfoundation:material:134> * 2       ], # Platinum Ingot
// QuartzBlack        : [<jaopca:item_clusterquartzblack>        , <actuallyadditions:item_misc:5> * 4        ], # Black Quartz
// Redstone           : [<jaopca:item_clusterredstone>           , <extrautils2:ingredients> * 20             ], # Resonating Redstone Crystal
// Ruby               : [<jaopca:item_clusterruby>               , <biomesoplenty:gem:1> * 4                  ], # Ruby
// Sapphire           : [<jaopca:item_clustersapphire>           , <biomesoplenty:gem:6> * 4                  ], # Sapphire
// Tanzanite          : [<jaopca:item_clustertanzanite>          , <biomesoplenty:gem:4> * 4                  ], # Tanzanite
// Thorium            : [<jaopca:item_clusterthorium>            , <nuclearcraft:ingot:3> * 2                 ], # Thorium Ingot
// Titanium           : [<jaopca:item_clustertitanium>           , <libvulpes:productingot:7> * 2             ], # Titanium Ingot
// Topaz              : [<jaopca:item_clustertopaz>              , <biomesoplenty:gem:3> * 4                  ], # Topaz
// Uranium            : [<jaopca:item_clusteruranium>            , <immersiveengineering:metal:5> * 2         ], # Uranium Ingot
// Iron               : [<thaumcraft:cluster>                    , <minecraft:iron_ingot> * 2                 ], # Iron Ingot
// Gold               : [<thaumcraft:cluster:1>                  , <minecraft:gold_ingot> * 2                 ], # Gold Ingot
// Copper             : [<thaumcraft:cluster:2>                  , null                                       ],
// Tin                : [<thaumcraft:cluster:3>                  , null                                       ],
// Silver             : [<thaumcraft:cluster:4>                  , null                                       ],
// Lead               : [<thaumcraft:cluster:5>                  , null                                       ],
// Cinnabar           : [<thaumcraft:cluster:6>                  , <thaumcraft:quicksilver> * 2               ], # Quicksilver
// Quartz             : [<thaumcraft:cluster:7>                  , <minecraft:quartz> * 6                     ], # Nether Quartz
// /**/
// } as IItemStack[][string] {
//   val ore_entry = oreDict.get("cluster" ~ ore_name);
//   beneficiate(ore_entry, ore_name, 3, benOpts);
//   magicProcessing(ore_entry, ore_name);

//   # Fix gems melting recipes
//   #   Standart JAOPCA's furnace recipes for Ores that outputs
//   # gems instead of ingots have empty output, so add it forced
//   var smelted = utils.smelt(ore_entry);
//   if (isNull(smelted)) {
//     furnace.remove(<*>, ore_entry);
//     var gem = utils.getSomething(ore_name, ["gem", "dust", "any"], 2);
//     if(!isNull(gem)) furnace.addRecipe(gem, ore_entry, 3.0);
//   }
// }
