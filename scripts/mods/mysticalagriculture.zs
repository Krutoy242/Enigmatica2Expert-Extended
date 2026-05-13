#modloaded mysticalagriculture
#ignoreBracketErrors

import crafttweaker.block.IBlockState;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.liquid.ILiquidStack;
import thaumcraft.aspect.CTAspectStack;

// [Inferium Seeds] from [Seeds][+1]
craft.remake(<mysticalagriculture:tier1_inferium_seeds>, ['pretty',
  'W W W',
  'W h W',
  'W W W'], {
  'W': <ic2:crop_res:5>, // Weed
  'h': <ore:seed>, // Seeds
});

// [Witherproof Block]*16 from [Black Dye][+1]
craft.remake(<mysticalagriculture:witherproof_block> * 16, ['pretty',
  'R R R',
  'R B R',
  'R R R'], {
  'R': <enderio:block_reinforced_obsidian>, // Reinforced Obsidian
  'B': <ore:dyeBlack>,                      // Black Dye
});

// [Witherproof Glass]*16 from [Black Dye][+2]
craft.remake(<mysticalagriculture:witherproof_glass> * 16, ['pretty',
  'R ■ R',
  '■ B ■',
  'R ■ R'], {
  'R': <enderio:block_reinforced_obsidian>, // Reinforced Obsidian
  '■': <ore:blockGlassBlack>,               // Dark Glass
  'B': <ore:dyeBlack>,                      // Black Dye
});

// [Ultimate Furnace] from [Supremium Furnace][+3]
craft.remake(<mysticalagriculture:ultimate_furnace>, ['pretty',
  '▲ W ▲',
  'W § W',
  '▲ B ▲'], {
  '▲': <ore:dustWither>,                        // Wither Ash
  'W': <mysticalagradditions:stuff:1>,          // Withering Soul
  '§': <mysticalagriculture:supremium_furnace>, // Supremium Furnace
  'B': <endreborn:sword_shard>,                 // Broken Sword Part
});

// [Growth Accelerator] from [Mana Diamond][+2]
craft.remake(<mysticalagriculture:growth_accelerator>, ['pretty',
  '■ ‚ ■',
  '‚ D ‚',
  '■ ‚ ■'], {
  '■': <ore:blockInferiumEssence>, // Block of Inferium Essence
  '‚': <ore:nuggetMithrillium>,    // Mithrillium Nugget
  'D': <ore:manaDiamond>,          // Mana Diamond
});

recipes.remove(<mysticalagriculture:master_infusion_crystal>);
mods.astralsorcery.Altar.addConstellationAltarRecipe(
  '[Master Infusion Crystal] from [Block of Terrasteel][+11]',
  <mysticalagriculture:master_infusion_crystal>,
  3000 /* Starlight */, 600 /* CraftTickTime */,
  Grid([
    'o▀r'
    + 'B*■'
    + 'G▄l'
    + 'SSSS'
    + '◊◊PPPP◊◊'], {
    'o': <ore:runeSlothB>,                        // Rune of Sloth
    '▀': <botania:storage:3>,                     // Block of Mana Diamond
    'r': <ore:runePrideB>,                        // Rune of Pride
    'B': <botania:storage:2>,                     // Block of Elementium
    '*': <matc:supremiumcrystal>.anyDamage(),     // Supremium Infusion Crystal
    '■': <botania:storage>,                       // Block of Manasteel
    'G': <ore:runeGreedB>,                        // Rune of Greed
    '▄': <botania:storage:1>,                     // Block of Terrasteel
    'l': <ore:runeGluttonyB>,                     // Rune of Gluttony
    'S': <botania:spark>,                         // Spark
    '◊': <astralsorcery:itemcraftingcomponent:4>, // Resonating Gem
    'P': <ore:manaPearl>,                         // Mana Pearl
  }).shapeless(true));

// *======= Crafting Seeds =======*
val essenceByTier = [
  <ore:essenceInferium>,
  <ore:essencePrudentium>,
  <ore:essenceIntermedium>,
  <ore:essenceSuperium>,
  <ore:essenceSupremium>,
  <ore:essenceInsanium>,
] as IIngredient[];

val seedIngrByTier = [
  <ic2:crop_res:5>,                  // Weed
  <randomthings:ingredient:5>,
  <ore:gemXorcite>,                  // Xorcite Shard
  <bloodmagic:component:28>,         // Simple Lengthening Catalyst
  <ore:carminite>,                   // Carminite
  <actuallyadditions:item_misc:24>,  // Empowered Canola Seed
] as IIngredient[];

for i in 0 .. 6 {
  val shape = Grid(['pretty',
    'o w o',
    'w ! w',
    'o w o'], {
    '!': <mysticalagriculture:crafting>.definition.makeStack(i + 16),
    'w': essenceByTier[i],
    'o': seedIngrByTier[i],
  }).shaped();
  val output = i == 5
    ? <mysticalagradditions:insanium:1>
    : <mysticalagriculture:crafting>.definition.makeStack(i + 17);
  recipes.remove(output);
  if (i == 5) scripts.mods.forestry.Carpenter.addRecipe(output, shape, 40, <liquid:sewage> * 1000);
  else recipes.addShaped(output, shape);
}

// *======= Universal Recipe =======*

/*
	Astral Sorcery altair pattern:

	9   13  21  14  10

	15  0   1   2   16

	22  3   4   5   23

	17  6   7   8   18

	11  19  24  20  12
*/

static L as IIngredient[string] = {
  '¹': <mysticalagriculture:crafting:17>,
  '²': <mysticalagriculture:crafting:18>,
  '³': <mysticalagriculture:crafting:19>,
  '⁴': <mysticalagriculture:crafting:20>,
  '⁵': <mysticalagriculture:crafting:21>,
  '⁶': <mysticalagradditions:insanium:1>,

  '₁': <ore:essenceTier1>,
  '₂': <ore:essenceTier2>,
  '₃': <ore:essenceTier3>,
  '₄': <ore:essenceTier4>,
  '₅': <ore:essenceTier5>,

  '1': <ore:blockInferiumEssence>,
  '2': <ore:blockPrudentiumEssence>,
  '3': <ore:blockIntermediumEssence>,
  '4': <ore:blockSuperiumEssence>,
  '5': <ore:blockSupremiumEssence>,
  '6': <ore:blockInsaniumEssence>,

  '▪': <ore:ingotSuperium>,
  '▬': <ore:ingotSupremium>,
  '‗': <ore:ingotInsanium>,
  '┉': <ore:ingotCrystaltine>,
} as IIngredient[string];

static curr_tier as int = 1 as int;

function addTieredRecipe(
  output as IItemStack,
  ingrs as IIngredient[],
  constelation as string = null
) as void {
  if (isNull(output)) return;
  val tier = curr_tier;

  recipes.remove(output);

  L['○'] = ingrs[0];
  L['□'] = ingrs[ingrs.length == 1 ? 0 : 1];
  L['╳'] = ingrs.length == 3 ? ingrs[2] : L['○₁₂₃₄₅'[tier - 1]];

  if (tier == 1) {
    recipes.addShapedMirrored(output, Grid([
      '╳1╳',
      '□¹□',
      '╳1╳'], L).shaped());
  }
  else

    if (tier == 2) {
      val grid = Grid([
        '╳2╳'
        + '2²2'
        + '╳2╳'
        + '○○□□'], L);
      mods.astralsorcery.Altar.addAttunementAltarRecipe(
        craft.uniqueRecipeName(output, grid),	output, 500, 200, grid.shapeless());
    }
    else

      if (tier == 3) {
        val grid = Grid([
          '╳3╳'
          + '3³3'
          + '╳3╳'
          + '○○□□'], L);
        mods.astralsorcery.Altar.addAttunementAltarRecipe(
          craft.uniqueRecipeName(output, grid),	output, 500, 200, grid.shapeless());
      }
      else

        if (tier == 4) {
          val grid = Grid([
            '╳4╳'
            + '4⁴4'
            + '╳4╳'
            + '○○□□'
            + '▪▪▪▪▪▪▪▪'], L);
          mods.astralsorcery.Altar.addConstellationAltarRecipe(
            craft.uniqueRecipeName(output, grid),	output, 1500, 250, grid.shapeless());
        }
        else

          if (tier == 5) {
            val grid = Grid([
              '╳5╳'
              + '5⁵5'
              + '╳5╳'
              + '○○□□'
              + '▬▬▬▬▬▬▬▬'
              + '○○□□'
              + '☼'], L);
            mods.astralsorcery.Altar.addTraitAltarRecipe(
              craft.uniqueRecipeName(output, grid),	output, 3500, 300,
              grid.shapeless(), 'astralsorcery.constellation.' ~ constelation
            );
          }
          else

            if (tier == 6) {
              L['▲'] = ingrs[min(ingrs.length, 2) - 1];
              val grid = Grid([
                '₅6₅'
                + '6⁶6'
                + '₅6₅'
                + '┉┉‗‗'
                + '○○□□▲▲○○'
                + '‗‗‗‗'
                + '☼'], L);
              mods.astralsorcery.Altar.addTraitAltarRecipe(
                craft.uniqueRecipeName(output, grid),	output, 5500, 600,
                grid.shapeless(), 'astralsorcery.constellation.' ~ constelation
              );
            }
}

// *======= Seeds Tier 1 =======*
curr_tier = 1;
addTieredRecipe(<mysticalagriculture:basalt_seeds>,         [<chisel:basalt2:7>, <mysticalagriculture:crafting>]);
addTieredRecipe(<mysticalagriculture:nature_seeds>,         [<mysticalagriculture:crafting:6>, <ore:ingotInferium>]);
addTieredRecipe(itemUtils.getItem('mysticalcreations:creosolite_seeds'), [<openblocks:tank>.withTag({ tank: { FluidName: 'creosote', Amount: 24000 } }) ?? Bucket('creosote'), <ore:runeEarthB>]);

// *======= Seeds Tier 2 =======*
curr_tier = 2;
addTieredRecipe(<mysticalagriculture:tier2_inferium_seeds>, [<ore:blockInferiumEssence>]);
addTieredRecipe(<mysticalagriculture:aluminum_seeds>,       [<ore:blockAluminum>,<ore:runeWaterB>]);
addTieredRecipe(<mysticalagriculture:copper_seeds>,         [<ore:blockCopper>,<ore:runeFireB>]);
addTieredRecipe(<mysticalagriculture:mystical_flower_seeds>,[<ore:manaDiamond>, <ore:manaPearl>, <mysticalagriculture:crafting:10>]);
addTieredRecipe(<mysticalagriculture:apatite_seeds>,        [<ore:blockApatite>,<ore:runeWaterB>]);
addTieredRecipe(<mysticalagriculture:coal_seeds>,           [<ore:blockCoal>,<ore:runeEarthB>]);
addTieredRecipe(<mysticalagriculture:tin_seeds> ,           [<ore:blockTin> ,<ore:runeSummerB>]);
addTieredRecipe(<mysticalagriculture:sky_stone_seeds> ,     [<appliedenergistics2:material:45>, <ore:runeSummerB>]);
addTieredRecipe(<mysticalagriculture:nether_seeds> ,        [<ore:blockNetherWart> ,<ore:runeAutumnB>]);
addTieredRecipe(<mysticalagriculture:certus_quartz_seeds> , [<ore:blockCertusQuartz> ,<ore:runeEarthB>]);

// *======= Seeds Tier 3 =======*
curr_tier = 3;
addTieredRecipe(<mysticalagriculture:tier3_inferium_seeds>, [<ore:blockPrudentiumEssence>]);
addTieredRecipe(<mysticalagriculture:sulfur_seeds>,         [Bucket('sulfur'),<ore:runeAirB>]);
addTieredRecipe(<mysticalagriculture:aquamarine_seeds> ,    [<ore:oreAquamarine> , <ore:runeSpringB>]);
addTieredRecipe(<mysticalagriculture:obsidian_seeds> ,      [<ore:plateDenseObsidian> ,<ore:runeAutumnB>]);
addTieredRecipe(<mysticalagriculture:redstone_seeds> ,      [<ore:blockRedstone> ,<ore:runeAutumnB>]);
addTieredRecipe(<mysticalagriculture:glowstone_seeds> ,     [<ore:glowstone> , <ore:runeWinterB>]);
addTieredRecipe(<mysticalagriculture:nether_quartz_seeds> , [<ore:blockQuartz> ,<ore:runeSummerB>]);
addTieredRecipe(<mysticalagriculture:iron_seeds> ,          [<ore:blockFakeIron> ,<ore:runeSummerB>]);
addTieredRecipe(<mysticalagriculture:lead_seeds> ,          [<ore:blockLead> , <ore:runeWinterB>]);
addTieredRecipe(<mysticalagriculture:silver_seeds> ,        [<ore:blockSilver> ,<ore:runeSpringB>]);
addTieredRecipe(<mysticalagriculture:knightslime_seeds> ,   [<ore:blockKnightslime> ,<ore:runeWinterB>]);
addTieredRecipe(<mysticalagriculture:steeleaf_seeds> ,      [<ore:blockSteel>, <ore:runeSpringB>]);
addTieredRecipe(<mysticalagriculture:ironwood_seeds> ,      [<twilightforest:block_storage>, <ore:runeSummerB>]);
addTieredRecipe(<mysticalagriculture:black_quartz_seeds> ,  [<ore:blockQuartzBlack> , <ore:runeAutumnB>]);
addTieredRecipe(<mysticalagriculture:end_seeds>,            [<excompressum:compressed_block:10> ,<ore:runeWinterB>]);
addTieredRecipe(itemUtils.getItem('mysticalagriculture:starmetal_seeds'), [<ore:blockAstralStarmetal> ,<ore:runeAutumnB>]);

// *======= Seeds Tier 4 =======*
curr_tier = 4;
addTieredRecipe(<mysticalagriculture:tier4_inferium_seeds>, [<ore:blockIntermediumEssence>]);
addTieredRecipe(<mysticalagriculture:thaumium_seeds>,       [<ore:blockThaumium> ,<ore:runeWrathB>]);
addTieredRecipe(<mysticalagriculture:ruby_seeds>,           [<biomesoplenty:gem_block:1> ,<ore:runeEnvyB>]);
addTieredRecipe(<mysticalagriculture:fiery_ingot_seeds>,    [<thaumcraft:jar_normal>.withTag({ Aspects: [{ amount: 250, key: 'infernum' }] }), <ore:runeManaB>]);
addTieredRecipe(<mysticalagriculture:knightmetal_seeds>,    [<twilightforest:knightmetal_block>, <ore:runeManaB>]);
addTieredRecipe(<mysticalagriculture:fluix_seeds>,          [<appliedenergistics2:fluix_block> ,<ore:runeManaB>]);
addTieredRecipe(<mysticalagriculture:ardite_seeds>,         [<ore:blockArdite> ,<ore:runeWrathB>]);
addTieredRecipe(<mysticalagriculture:peridot_seeds>,        [<biomesoplenty:gem_block:2> ,<ore:runeGluttonyB>]);
addTieredRecipe(<mysticalagriculture:cobalt_seeds>,         [<ore:blockCobalt> ,<ore:runeWrathB>]);
addTieredRecipe(<mysticalagriculture:sapphire_seeds>,       [<biomesoplenty:gem_block:6> ,<ore:runePrideB>]);
addTieredRecipe(<mysticalagriculture:lapis_lazuli_seeds>,   [<ore:blockLapis> ,<ore:runeSlothB>]);
addTieredRecipe(<mysticalagriculture:gold_seeds>,           [<ore:blockGold> ,<ore:runeSlothB>]);
addTieredRecipe(<mysticalagriculture:amber_seeds>,          [<ore:blockAmber> ,<ore:runeGluttonyB>]);
addTieredRecipe(<mysticalagriculture:topaz_seeds>,          [<biomesoplenty:gem_block:3> ,<ore:runeGluttonyB>]);
addTieredRecipe(<mysticalagriculture:osmium_seeds>,         [<ore:blockOsmium> ,<ore:runeEnvyB>]);
addTieredRecipe(<mysticalagriculture:boron_seeds>,          [<ore:blockBoron> ,<ore:runeEnvyB>]);
addTieredRecipe(<mysticalagriculture:lithium_seeds>,        [<ore:blockLithium> ,<ore:runeEnvyB>]);
addTieredRecipe(<mysticalagriculture:magnesium_seeds>,      [<ore:blockMagnesium> ,<ore:runeEnvyB>]);
addTieredRecipe(<mysticalagriculture:thorium_seeds>,        [<ore:blockThorium> ,<ore:runeEnvyB>]);
addTieredRecipe(<mysticalagriculture:malachite_seeds>,      [<biomesoplenty:gem_block:5> ,<ore:runePrideB>]);
addTieredRecipe(<mysticalagriculture:tanzanite_seeds>,      [<biomesoplenty:gem_block:4> ,<ore:runeLustB>]);
addTieredRecipe(<mysticalagriculture:nickel_seeds>,         [<ore:blockNickel> ,<ore:runeGreedB>]);
addTieredRecipe(<mysticalagriculture:fluxed_electrum_seeds>,[<ore:blockElectrumFlux> ,<ore:runeGreedB>]);
addTieredRecipe(<mysticalagriculture:diamond_seeds>,        [<ore:blockDiamond> ,<ore:runePrideB>]);
addTieredRecipe(<mysticalagriculture:ender_amethyst_seeds>, [<ore:blockAmethyst>, <astralsorcery:itemcoloredlens:2>]);
addTieredRecipe(<mysticalagriculture:void_metal_seeds>,     [<ore:blockVoid>]);
addTieredRecipe(<mysticalagriculture:rock_crystal_seeds>,   [<astralsorcery:itemcelestialcrystal:*>], 'mineralis');
addTieredRecipe(<mysticalagriculture:uranium_seeds>,        [<ore:blockUranium>], 'mineralis');

// *======= Seeds Tier 5 =======*
curr_tier = 5;
L['☼'] = <minecraft:nether_star>;
addTieredRecipe(<mysticalagriculture:tier5_inferium_seeds>, [<ore:blockSuperiumEssence>], 'aevitas');
addTieredRecipe(<mysticalagriculture:platinum_seeds>,       [<ore:blockPlatinum>], 'mineralis');
addTieredRecipe(<mysticalagriculture:draconium_seeds>,      [<ore:blockDraconium>], 'mineralis');

// *======= Seeds Tier 6 =======*
curr_tier = 6;
addTieredRecipe(<mysticalagradditions:tier6_inferium_seeds>    , [<ore:blockSupremiumEssence>   , <astralsorcery:itemcoloredlens:2>, <botania:prism>],'aevitas');
addTieredRecipe(<mysticalagriculture:iridium_seeds>            , [<ore:blockIridium>            , <astralsorcery:itemcoloredlens:2>],'mineralis');
addTieredRecipe(<mysticalagriculture:enderium_seeds>           , [<ore:blockEnderium>           , <astralsorcery:itemcoloredlens:2>],'mineralis');
addTieredRecipe(<mysticalagriculture:terrasteel_seeds>         , [<botania:storage:1>           , <botania:laputashard>, <botania:prism>],'mineralis');
addTieredRecipe(<mysticalagradditions:neutronium_seeds>				 , [<ore:ingotCosmicNeutronium>]  , 'mineralis');

L['☼'] = <ore:blockNetherStar>;
addTieredRecipe(<mysticalagradditions:awakened_draconium_seeds>, [<ore:blockDraconiumAwakened>  , <astralsorcery:itemcoloredlens:2>, <draconicevolution:wyvern_energy_core>] ,'mineralis');
addTieredRecipe(<mysticalagradditions:nether_star_seeds>       , [<ore:blockNetherStar>         , <astralsorcery:itemcoloredlens:2>], 'aevitas');
addTieredRecipe(<mysticalagradditions:dragon_egg_seeds>        , [<mysticalagradditions:stuff:3>], 'aevitas');
addTieredRecipe(itemUtils.getItem('mysticalcreations:ultimate_seeds') , [<ore:blockUltimate>], 'horologium');

// Remake crystals to consume previous level
val crystals = [
  <mysticalagriculture:infusion_crystal>,
  <matc:inferiumcrystal>,
  <matc:prudentiumcrystal>,
  <matc:intermediumcrystal>,
  <matc:superiumcrystal>,
  <matc:supremiumcrystal>,
] as IItemStack[];

// Infusion crystals
val prospetry = <mysticalagriculture:crafting:5> | <mysticalagriculture:crafting:39>;
for i in 0 .. 5 {
  craft.remake(crystals[i + 1], ['ABA','BCB','ABA'], {
    A: prospetry,
    B: itemUtils.getItem('mysticalagriculture:crafting', i),
    C: crystals[i].anyDamage().noReturn().marked('marked') },
  function (out, ins, cInfo) {
    if (ins has 'marked' && !isNull(ins.marked) && ins.marked.isDamageable && out.isDamageable) {
      return out.withDamage(ins.marked.damage);
    }
    return out;
  });
}

// 🚒 Inworld smelting
scripts.do.inworld_smelting.add(<mysticalagriculture:prosperity_ore>, <astralsorcery:blockcustomore>);

// ######################################################################
//
// Harder Supremium armor
//
// ######################################################################

val liquidAmount = [4,6,5,4] as int[];
val bases = [
  <contenttweaker:supremium_helmet_base>  ,
  <contenttweaker:supremium_chest_base>   ,
  <contenttweaker:supremium_leggings_base>,
  <contenttweaker:supremium_boots_base>   ,
] as IItemStack[];
val cores = [
  <conarm:helmet_core>.withTag({ Material: 'ma.supremium' }),
  <conarm:chest_core>.withTag({ Material: 'ma.supremium' }),
  <conarm:leggings_core>.withTag({ Material: 'ma.supremium' }),
  <conarm:boots_core>.withTag({ Material: 'ma.supremium' }),
] as IItemStack[];

val castNames = [
  'conarm:helmet_core',
  'conarm:chest_core',
  'conarm:leggings_core',
  'conarm:boots_core',
] as string[];

for i in 0 .. 4 {
  val l = 144 * liquidAmount[i];

  // Replace casting of cores to Base ones
  mods.tconstruct.Casting.removeTableRecipe(cores[i]);
  mods.tconstruct.Casting.addTableRecipe(bases[i], <tconstruct:cast>.withTag({ PartType: castNames[i] }), <liquid:supremium>, l, false);

  // Add core base melting
  mods.tconstruct.Melting.addRecipe(<liquid:supremium> * l, bases[i]);

  // Add recipe of making core from base
  mods.roidtweaker.minecraft.Anvil.addRecipe(<mysticalagriculture:master_infusion_crystal>, bases[i], cores[i], 350);
}

// Missed 4 types of dyes
val dyeEssence = { x: <mysticalagriculture:dye_essence> } as IIngredient[string];
craft.make(<biomesoplenty:green_dye> * 4, ['pretty',
  'x    ',
  '  x  ',
  'x    '], dyeEssence);
craft.make(<biomesoplenty:brown_dye> * 4, ['pretty',
  '  x  ',
  '    x',
  '  x  '], dyeEssence);
craft.make(<biomesoplenty:blue_dye> * 4, ['pretty',
  '    x',
  '  x  ',
  '    x'], dyeEssence);
craft.make(<biomesoplenty:white_dye> * 4, ['pretty',
  '  x  ',
  'x    ',
  '  x  '], dyeEssence);

// Squeeze cow essence
scripts.process.squeeze([<mysticalagriculture:cow_essence>], <liquid:milk> * 250);

// Squeeze water essence
scripts.process.squeeze([<mysticalagriculture:water_essence>], <liquid:water> * 250);

// Melt fire
scripts.process.melt(<mysticalagriculture:fire_essence>, <liquid:lava> * 250);

// Saplings from essence
// ----------------------------
val defGroup = [
  <mysticalagriculture:wood_essence>,
  <mysticalagriculture:wood_essence>,
  <mysticalagriculture:nature_essence>,
] as IIngredient[];

val uniq_biomesoplenty = scripts.lib.unique.Unique(defGroup + <biomesoplenty:biome_essence>);
val uniq_tconstruct    = scripts.lib.unique.Unique(defGroup + <ore:slimeball>);
val uniq_other         = scripts.lib.unique.Unique(defGroup + <mysticalagriculture:nature_essence>);

/* Inject_js(
getByOredict('treeSapling')
.filter(o=>
  !'minecraft|harvestcraft|twilightforest|randomthings|forestry|advancedrocketry|integrateddynamics'
  .split('|').includes(o.owner)
)
.filter(o=>o.commandString != '<biomesoplenty:sapling_1:7>')
.map((o,i)=>[
  `recipes.addShaped('sap #${i}', `,
  o.commandString,
  ' * ', o.owner==='biomesoplenty'?10:6,
  `, uniq_${
    ['biomesoplenty','tconstruct'].includes(o.owner) ? o.owner : 'other'
  }.next());`
])
) */
recipes.addShaped('sap #0',  <biomesoplenty:sapling_0>        * 10, uniq_biomesoplenty.next());
recipes.addShaped('sap #1',  <biomesoplenty:sapling_0:1>      * 10, uniq_biomesoplenty.next());
recipes.addShaped('sap #2',  <biomesoplenty:sapling_0:2>      * 10, uniq_biomesoplenty.next());
recipes.addShaped('sap #3',  <biomesoplenty:sapling_0:3>      * 10, uniq_biomesoplenty.next());
recipes.addShaped('sap #4',  <biomesoplenty:sapling_0:4>      * 10, uniq_biomesoplenty.next());
recipes.addShaped('sap #5',  <biomesoplenty:sapling_0:5>      * 10, uniq_biomesoplenty.next());
recipes.addShaped('sap #6',  <biomesoplenty:sapling_0:6>      * 10, uniq_biomesoplenty.next());
recipes.addShaped('sap #7',  <biomesoplenty:sapling_0:7>      * 10, uniq_biomesoplenty.next());
recipes.addShaped('sap #8',  <biomesoplenty:sapling_1>        * 10, uniq_biomesoplenty.next());
recipes.addShaped('sap #9',  <biomesoplenty:sapling_1:1>      * 10, uniq_biomesoplenty.next());
recipes.addShaped('sap #10', <biomesoplenty:sapling_1:2>      * 10, uniq_biomesoplenty.next());
recipes.addShaped('sap #11', <biomesoplenty:sapling_1:3>      * 10, uniq_biomesoplenty.next());
recipes.addShaped('sap #12', <biomesoplenty:sapling_1:4>      * 10, uniq_biomesoplenty.next());
recipes.addShaped('sap #13', <biomesoplenty:sapling_1:5>      * 10, uniq_biomesoplenty.next());
recipes.addShaped('sap #14', <biomesoplenty:sapling_1:6>      * 10, uniq_biomesoplenty.next());
recipes.addShaped('sap #15', <biomesoplenty:sapling_2>        * 10, uniq_biomesoplenty.next());
recipes.addShaped('sap #16', <biomesoplenty:sapling_2:1>      * 10, uniq_biomesoplenty.next());
recipes.addShaped('sap #17', <biomesoplenty:sapling_2:2>      * 10, uniq_biomesoplenty.next());
recipes.addShaped('sap #18', <biomesoplenty:sapling_2:3>      * 10, uniq_biomesoplenty.next());
recipes.addShaped('sap #19', <biomesoplenty:sapling_2:4>      * 10, uniq_biomesoplenty.next());
recipes.addShaped('sap #20', <biomesoplenty:sapling_2:5>      * 10, uniq_biomesoplenty.next());
recipes.addShaped('sap #21', <biomesoplenty:sapling_2:6>      * 10, uniq_biomesoplenty.next());
recipes.addShaped('sap #22', <biomesoplenty:sapling_2:7>      * 10, uniq_biomesoplenty.next());
recipes.addShaped('sap #23', <extrautils2:ironwood_sapling>   * 6 , uniq_other.next());
recipes.addShaped('sap #24', <extrautils2:ironwood_sapling:1> * 6 , uniq_other.next());
recipes.addShaped('sap #25', <ic2:sapling>                    * 6 , uniq_other.next());
recipes.addShaped('sap #26', <quark:variant_sapling>          * 6 , uniq_other.next());
recipes.addShaped('sap #27', <quark:variant_sapling:1>        * 6 , uniq_other.next());
recipes.addShaped('sap #28', <rustic:sapling>                 * 6 , uniq_other.next());
recipes.addShaped('sap #29', <rustic:sapling:1>               * 6 , uniq_other.next());
recipes.addShaped('sap #30', <rustic:sapling_apple>           * 6 , uniq_other.next());
recipes.addShaped('sap #31', <thaumcraft:sapling_greatwood>   * 6 , uniq_other.next());
recipes.addShaped('sap #32', <thaumcraft:sapling_silverwood>  * 6 , uniq_other.next());
recipes.addShaped('sap #33', <tconstruct:slime_sapling>       * 6 , uniq_tconstruct.next());
recipes.addShaped('sap #34', <tconstruct:slime_sapling:1>     * 6 , uniq_tconstruct.next());
recipes.addShaped('sap #35', <tconstruct:slime_sapling:2>     * 6 , uniq_tconstruct.next());
/**/

// ----------------------------

// Remove previous 1 -> 4
recipes.removeByRecipeName('mysticalagriculture:core/compression/inferium_essence_from');
recipes.removeByRecipeName('mysticalagriculture:core/compression/prudentium_essence_from');
recipes.removeByRecipeName('mysticalagriculture:core/compression/intermedium_essence_from');
recipes.removeByRecipeName('mysticalagriculture:core/compression/superium_essence_from');
recipes.removeByRecipeName('mysticalagradditions:insanium_essence_from');

// 1 -> 4 required crystal
val essesnses = [
  <ore:essenceInsanium>.firstItem,
  <ore:essenceSupremium>.firstItem,
  <ore:essenceSuperium>.firstItem,
  <ore:essenceIntermedium>.firstItem,
  <ore:essencePrudentium>.firstItem,
  <ore:essenceInferium>.firstItem,
] as IItemStack[];

// Create ingredient for any crystal
var anyDamageCrystal as IIngredient = <ore:infusionCrystal>.itemArray[0].anyDamage();
for i, it in <ore:infusionCrystal>.itemArray {
  if (i == 0) continue;
  anyDamageCrystal = anyDamageCrystal.or(it.anyDamage());
}

for i, ess in essesnses {
  if (i == 0) continue;
  craft.shapeless(ess * 4, 'AB', { A: anyDamageCrystal, B: essesnses[i - 1] });
}

// New Crystals entry
mods.rats.recipes.addChefRatRecipe(<ore:quartzMana>.firstItem, <mysticalagriculture:infusion_crystal>);
mods.botania.ManaInfusion.addConjuration(<mysticalagriculture:infusion_crystal>, <astralsorcery:blockcelestialcollectorcrystal:*>, 25000);

// [Fertilized Essence] from [Phyto-Gro]*2[+4]
craft.reshapeless(<mysticalagriculture:fertilized_essence> * 8, 'rF*ef', {
  '*': anyDamageCrystal, // Inferium Infusion Crystal
  'r': <actuallyadditions:item_fertilizer>, // Fertilizer
  'F': <ic2:crop_res:2>,                    // Fertilizer
  'e': <forestry:fertilizer_compound>,      // Fertilizer
  'f': <thermalfoundation:fertilizer>,      // Phyto-Gro
});

// Better enderpearl recipe
recipes.removeByRecipeName('mysticalagriculture:ender_pearl');
craft.shapeless(<minecraft:ender_pearl> * 6, 'AAA', { A: <mysticalagriculture:enderman_essence> });

// Base essence harder to use more magic
recipes.removeByRecipeName('mysticalagriculture:crafting_16');
scripts.process.solution(
  [<ore:shardProsperity>, <ore:nuggetManasteel>, <ore:dustAstralStarmetal>],
  [<liquid:brass> * 144],
  [<liquid:base_essence> * 1440],
  [0.5, 0.5, 0.5, 3300], 'only: highoven'
);

// [Base Essence Ingot] from [Stardust][+3]
mods.advancedrocketry.RecipeTweaker
  .forMachine('ElectricArcFurnace')
  .builder()
  .inputOre(<ore:ingotBrass>, 4)
  .inputOre(<ore:shardProsperity>, 2)
  .inputOre(<ore:nuggetManasteel>, 2)
  .inputOre(<ore:dustAstralStarmetal>, 2)
  .outputItem(<mysticalagriculture:crafting:32> * 40)
  .build();

// [Base Crafting Seed] Harder to encourage Villager Trades
craft.remake(<mysticalagriculture:crafting:16>, ['pretty',
  'l s l'], {
  'l': <ore:shardProsperity>,
  's': <ore:seed>,
});

// Watering Cans WAAAAY cheaper
val watering_ingrs = {
  'e': <mysticalagriculture:watering_can>,   // Inferium Watering Can
  'p': <mysticalagriculture:watering_can:1>, // Prudentium Watering Can
  '§': <mysticalagriculture:watering_can:2>, // Intermedium Watering Can
  'b': <mysticalagriculture:watering_can:3>, // Superium Watering Can
  'B': <actuallyadditions:item_water_bowl>,  // Bowl of Water
  'I': <ore:essenceInferium>,                // Inferium Essence
  'P': <ore:essencePrudentium>,              // Prudentium Essence
  'n': <ore:essenceIntermedium>,             // Intermedium Essence
  'u': <ore:essenceSuperium>,                // Superium Essence
  'S': <ore:essenceSupremium>,               // Supremium Essence
} as IIngredient[string];

// [Inferium Watering Can] from [Bowl of Water][+1]
craft.remake(<mysticalagriculture:watering_can>, ['pretty',
  'I    ',
  'I B I',
  '  I I'], watering_ingrs
);
craft.reshapeless(<mysticalagriculture:watering_can:1>, 'eP', watering_ingrs);
craft.reshapeless(<mysticalagriculture:watering_can:2>, 'pn', watering_ingrs);
craft.reshapeless(<mysticalagriculture:watering_can:3>, '§u', watering_ingrs);
craft.reshapeless(<mysticalagriculture:watering_can:4>, 'bS', watering_ingrs);

// [Mud Ball]*16 from [Water Essence]*2[+1]
craft.make(<biomesoplenty:mudball> * 16, ['pretty',
  'i T i',
  'T   T',
  'i T i'], {
  'i': <mysticalagriculture:dirt_essence>,  // Dirt Essence
  'T': <mysticalagriculture:water_essence>, // Water Essence
});

// [Wood Pile]*8 from [Wood Essence]
craft.make(<forestry:wood_pile> * 12, ['pretty',
  'T   T',
  'T   T',
  'T   T'], {
  'T': <mysticalagriculture:wood_essence>, // Wood Essence
});

// [Slime Ball]*8 from [Water Essence]*2[+1]
craft.make(<tconstruct:edible:1> * 8, ['pretty',
  '  T  ',
  'T i T',
  '  T  '], {
  'T': <mysticalagriculture:slime_essence>, // Slime Essence
  'i': <mysticalagriculture:water_essence>, // Water Essence
});

// [Slime Ball]*8 from [Obsidian Essence]*2[+1]
craft.make(<tconstruct:edible:2> * 8, ['pretty',
  '  T  ',
  'T i T',
  '  T  '], {
  'T': <mysticalagriculture:slime_essence>,    // Slime Essence
  'i': <mysticalagriculture:obsidian_essence>, // Obsidian Essence
});

// [Coagulated Blood]*8 from [Zombie Essence]*2[+1]
craft.make(<tconstruct:edible:3> * 8, ['pretty',
  '  T  ',
  'T i T',
  '  T  '], {
  'T': <mysticalagriculture:slime_essence>,  // Slime Essence
  'i': <mysticalagriculture:zombie_essence>, // Zombie Essence
});

// [Slime Ball]*8 from [Fire Essence]*2[+1]
craft.make(<tconstruct:edible:4> * 8, ['pretty',
  '  T  ',
  'T i T',
  '  T  '], {
  'T': <mysticalagriculture:slime_essence>, // Slime Essence
  'i': <mysticalagriculture:fire_essence>,  // Fire Essence
});

// [Slime in a Bucket] from [Bucket][+1]
craft.make(<quark:slime_bucket>, ['pretty',
  '  T  ',
  'T ~ T',
  '  T  '], {
  'T': <mysticalagriculture:slime_essence>, // Slime Essence
  '~': <minecraft:bucket>,                  // Bucket
});

// [Mystical String] from [Industrial Hemp Fiber][+1]
craft.reshapeless(<mysticalagriculture:crafting:23>, 'HP', {
  'P': <mysticalagriculture:crafting:39>,
  'H': <ore:fiberHemp>,       // Industrial Hemp Fiber
});

// Adventure way to obtain Prudentium Essence
scripts.do.entity_kill_entity.add('minecraft:slime', 'betteranimalsplus:feralwolf', <mysticalagriculture:crafting:2>);

val mobChunks = {
  'minecraft:zombie'  : 6,
  'minecraft:pig'     : 7,
  'minecraft:chicken' : 8,
  'minecraft:cow'     : 9,
  'minecraft:sheep'   : 10,
  'minecraft:slime'   : 11,
  'minecraft:skeleton': 12,
  'minecraft:creeper' : 13,
  'minecraft:spider'  : 14,
  'minecraft:rabbit'  : 15,
  'minecraft:guardian': 16,
  'minecraft:blaze'   : 17,
  'minecraft:ghast'   : 18,
  'minecraft:enderman': 19,
} as int[string];
for id, meta in mobChunks {
  recipes.addShapeless(<mysticalagriculture:chunk>.definition.makeStack(meta) * 4, [
    <ore:craftingToolForgeHammer>,
    <enderio:item_broken_spawner>.withTag({ entityId: id }),
  ]);
}

// Other spawners
recipes.addShapeless(<mysticalagriculture:chunk:5> * 12, [
  <ore:craftingToolForgeHammer>,
  <enderio:item_broken_spawner>,
]);

// [Withering Soul] from [Black Stained Glass Pane][+1]
craft.make(<mysticalagradditions:stuff:1>, ['pretty',
  'T T T',
  'T G T',
  'T T T'], {
  'T': <mysticalagradditions:nether_star_essence>, // Nether Star Essence
  'G': <ore:paneGlassBlack>, // Black Stained Glass Pane
});

// ---------------------------------
// Furnaces rework
// ---------------------------------
// Now they are silmply compressed
val furnaceByTier = [
  <minecraft:furnace>,
  <mysticalagriculture:inferium_furnace>,
  <mysticalagriculture:prudentium_furnace>,
  <mysticalagriculture:intermedium_furnace>,
  <mysticalagriculture:superium_furnace>,
  <mysticalagriculture:supremium_furnace>,
] as IItemStack[];

for i, item in furnaceByTier {
  if (i == 0) continue;
  val prev = furnaceByTier[i - 1];
  recipes.remove(item);
  recipes.addShapeless('4x' ~ craft.uniqueRecipeName(item), item, [prev, prev, prev, prev]);
  recipes.addShapeless('1x' ~ craft.uniqueRecipeName(item), prev * 4, [item]);
}
// ---------------------------------

// --------------------------------------------
// Essence remake
// --------------------------------------------
function remakeBlock(recName as string, output as IBlockState, ingrs as IIngredient[], fluid as string = 'stone') as void {
  if (!isNull(recName)) recipes.removeByRecipeName(recName);
  scripts.do.burnt_in_fluid.add(ingrs[0], output, fluid, 1.0, !(ingrs[0] has <mysticalagriculture:rock_crystal_essence>));
}

function makeSmelt(recName as string, output as ILiquidStack, ingrs as IIngredient[]) as void {
  mods.tconstruct.Melting.addRecipe(output, ingrs[0]);
  mods.thermalexpansion.Crucible.addRecipe(output, ingrs[0].items[0], 1000);
}

function remakeSimple(recName as string, output as IIngredient, ingrs as IIngredient[]) as void {

}

function remakeFluid(recName as string, output as ILiquidStack, ingrs as IIngredient[]) as void {
  recipes.removeByRecipeName(recName);
  mods.inworldcrafting.FluidToFluid.transform(output, <liquid:fluid_quicksilver>, ingrs);
  scripts.processWork.work(['Mixer'], null,
    [ingrs[0]], [<liquid:fluid_quicksilver> * 1000],
    null, [output * 1000], null, null);
}

function remakeAltair(recName as string, output as IIngredient, ingrs as IIngredient[]) as void {
  recipes.removeByRecipeName(recName);
  val A = ingrs[0];
  mods.astralsorcery.Altar.addDiscoveryAltarRecipe(
    'enigmatica2expert:shaped/internal/altar/' ~ output.items[0].definition.id.split(':')[1],
    output.items[0], 150, 50, [
      A, A, A,
      A,null,A,
      A, A, A,
    ]);
}

function remakeCrucible(recName as string, output as IIngredient, ingrs as IIngredient[], aspects as CTAspectStack[]) as void {
  recipes.removeByRecipeName(recName);
  mods.thaumcraft.Crucible.registerRecipe(recName, 'BASEALCHEMY', output.items[0], ingrs[0], aspects);
}

function remakeManapool(recName as string, output as IIngredient, ingrs as IIngredient[]) as void {
  recipes.removeByRecipeName(recName);
  mods.botania.ManaInfusion.addInfusion(output.items[0], ingrs[0], 100);
}

function makeArcane(output as IItemStack, grid as string[], ingrs as IIngredient[string], aspects as CTAspectStack[]) as void {
  if (isNull(output)) return;
  mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe(
    craft.uniqueRecipeName(output),
    'FIRSTSTEPS', // Research
    10, // Vis cost
    aspects,
    output,
    Grid(grid, ingrs).shaped()
  );
}

function remakeArcane(recName as string, output as IItemStack, grid as string[], ingrs as IIngredient[string], aspects as CTAspectStack[]) as void {
  recipes.removeByRecipeName(recName);
  makeArcane(output, grid, ingrs, aspects);
}

/* Inject_js{
if(cmd.block.trim().length > 10) return cmd.block
return getUnchangedTableRecipes()
  .filter(r => r.input.match(/<mysticalagr(?:iculture|additions):[^>]+>/))
  .map(r => ({
    rec  : r,
    ingrs: r.input.split(/, /g).map(s => s.replace(/\[|\]/g, '')),
  }))
  .filter(({ ingrs }) => ingrs.every(s => s.match(/null|<(mysticalagr(?:iculture|additions):[^>]+)>/)))
  .map(({ rec, ingrs }) => {
    const ing = ingrs.filter(s => !s.match('null'))
    const re = Object.entries(_.countBy(ing))
    if (!re.every(([item]) => item.includes('essence'))) return null

    const outOres = [...getItemOredictSet(rec.out_id, rec.out_meta)]
    const outBases = outOres
      .map(s => s.replace(/^[a-z]+([A-Z].+)/, '$1')).filter(Boolean)
    const outBaseOreBlocks = outBases.map(b => getByOreBase(b).ore).filter(Boolean)

    const outFluid = outBases.map(s => s.toLowerCase()).find(b => isFluidExist(b))

    const fnc = outBaseOreBlocks.length
      ? 'remakeBlock'
      : outFluid
        ? 'remakeFluid'
        : 'remakeSimple'
    const output = outBaseOreBlocks.length
      ? outBaseOreBlocks[0].commandString
      : outFluid
        ? `<fluid:${outFluid}>`
        : rec.output

    return [
      fnc, '(',
      `"${rec.name}"`,
      ', ',
      output,
      ', [',
      re.map(p => p.filter(o => o != 1).join(' * ')).join(', '),
      ']);',
    ]
  })
  .filter(Boolean)
  .sort((a, b) => naturalSort(a[0], b[0]) || naturalSort(a[4], b[4]))
} */
// remakeFluid ("mysticalagriculture:beef"                 , <fluid:meat>                              , [<mysticalagriculture:cow_essence>]);
// remakeFluid ("mysticalagriculture:chicken"              , <fluid:meat>                              , [<mysticalagriculture:chicken_essence>]);
// remakeFluid ("mysticalagriculture:clay_ball"            , <fluid:clay>                              , [<mysticalagriculture:water_essence> * 2, <mysticalagriculture:dirt_essence>]);
// remakeFluid ("mysticalagriculture:dirt_1"               , <fluid:dirt>                              , [<mysticalagriculture:dirt_essence>]);
// remakeFluid ("mysticalagriculture:dirt_2"               , <fluid:dirt>                              , [<mysticalagriculture:dirt_essence>]);
// remakeFluid ("mysticalagriculture:dirt"                 , <fluid:dirt>                              , [<mysticalagriculture:dirt_essence>]);
remakeAltair('mysticalagriculture:glowstone_dust'       , <minecraft:glowstone_dust> * 48                    , [<mysticalagriculture:glowstone_essence>]);
// remakeFluid ("mysticalagriculture:ice"                  , <fluid:ice>                               , [<mysticalagriculture:ice_essence>]);
remakeManapool ('mysticalagriculture:ingotenderium'        , <thermalfoundation:material:231>                          , [<mysticalagriculture:enderium_essence>]);
remakeFluid ('mysticalagriculture:ingots'               , <fluid:knightslime>                       , [<mysticalagriculture:knightslime_essence> * 10]);
remakeManapool ('mysticalagriculture:ingotthaumium'        , <thaumcraft:nugget:6>                          , [<mysticalagriculture:thaumium_essence>]);
remakeManapool ('mysticalagriculture:manaresource'         , <botania:manaresource:18>                        , [<mysticalagriculture:terrasteel_essence>]);
// remakeFluid ("mysticalagriculture:mutton"               , <fluid:meat>                              , [<mysticalagriculture:sheep_essence>]);
remakeFluid ('mysticalagriculture:obsidian'             , <fluid:obsidian>                          , [<mysticalagriculture:obsidian_essence> * 2]);
// remakeFluid ("mysticalagriculture:porkchop"             , <fluid:meat>                              , [<mysticalagriculture:pig_essence>]);
// remakeFluid ("mysticalagriculture:rabbit"               , <fluid:meat>                              , [<mysticalagriculture:rabbit_essence>]);
// remakeFluid ("mysticalagriculture:sand_1"               , <fluid:sand>                              , [<mysticalagriculture:dirt_essence> * 2, <mysticalagriculture:fire_essence>]);
// remakeFluid ("mysticalagriculture:sand"                 , <fluid:sand>                              , [<mysticalagriculture:fire_essence> * 2, <mysticalagriculture:dirt_essence>]);
// remakeFluid ("mysticalagriculture:soul_sand"            , <fluid:sand>                              , [<mysticalagriculture:nether_essence>]);
remakeBlock   ('mysticalagriculture:stone'                , <blockstate:additionalcompression:stone_compressed:level=1>, [<mysticalagriculture:stone_essence>]);
remakeBlock   ('mysticalagriculture:gemquartzblack'       , <blockstate:actuallyadditions:block_misc:type=ore_black_quartz>          , [<mysticalagriculture:black_quartz_essence> * 7]);
remakeBlock   ('mysticalagriculture:crystalcertusquartz'  , <blockstate:appliedenergistics2:quartz_ore>          , [<mysticalagriculture:certus_quartz_essence>]);
remakeBlock   ('mysticalagriculture:blockcustomore'       , <blockstate:astralsorcery:blockcustomore:oretype=rock_crystal>, [<mysticalagriculture:rock_crystal_essence>]);
// remakeBlock   ("mysticalagriculture:itemcraftingcomponent", <blockstate:astralsorcery:blockcustomsandore>        , [<mysticalagriculture:aquamarine_essence>]);
remakeBlock   ('mysticalagriculture:gem'                  , <blockstate:biomesoplenty:gem_ore:variant=amethyst>  , [<mysticalagriculture:ender_amethyst_essence>]);
remakeBlock   ('mysticalagriculture:gemruby'              , <blockstate:biomesoplenty:gem_ore:variant=ruby>      , [<mysticalagriculture:ruby_essence>]);
remakeBlock   ('mysticalagriculture:gemperidot'           , <blockstate:biomesoplenty:gem_ore:variant=peridot>   , [<mysticalagriculture:peridot_essence>]);
remakeBlock   ('mysticalagriculture:gemtopaz'             , <blockstate:biomesoplenty:gem_ore:variant=topaz>     , [<mysticalagriculture:topaz_essence>]);
remakeBlock   ('mysticalagriculture:gemtanzanite'         , <blockstate:biomesoplenty:gem_ore:variant=tanzanite> , [<mysticalagriculture:tanzanite_essence>]);
remakeBlock   ('mysticalagriculture:gemmalachite'         , <blockstate:biomesoplenty:gem_ore:variant=malachite> , [<mysticalagriculture:malachite_essence>]);
remakeBlock   ('mysticalagriculture:gemsapphire'          , <blockstate:biomesoplenty:gem_ore:variant=sapphire>  , [<mysticalagriculture:sapphire_essence>]);
remakeBlock   ('mysticalagriculture:gemamber'             , <blockstate:thaumcraft:ore_amber>                    , [<mysticalagriculture:amber_essence>]);
remakeBlock   ('mysticalagriculture:ingotdraconium'       , <blockstate:draconicevolution:draconium_ore>         , [<mysticalagriculture:draconium_essence>]);
remakeBlock   ('mysticalagriculture:gemapatite'           , <blockstate:forestry:resources>                      , [<mysticalagriculture:apatite_essence>]);
// remakeBlock   ("mysticalagriculture:ingotosmium"          , <blockstate:mekanism:oreblock>                       , [<mysticalagriculture:osmium_essence>]);
remakeBlock   ('mysticalagriculture:coal'                 , <blockstate:minecraft:coal_ore>                      , [<mysticalagriculture:coal_essence>]);
remakeBlock   ('mysticalagriculture:diamond'              , <blockstate:minecraft:diamond_ore>                   , [<mysticalagriculture:diamond_essence>]);
remakeBlock   ('mysticalagriculture:gold_ingot'           , <blockstate:minecraft:gold_ore>                      , [<mysticalagriculture:gold_essence>]);
remakeBlock   ('mysticalagriculture:iron_ingot'           , <blockstate:minecraft:iron_ore>                      , [<mysticalagriculture:iron_essence>]);
remakeBlock   ('mysticalagriculture:dye_13'               , <blockstate:minecraft:lapis_ore>                     , [<mysticalagriculture:lapis_lazuli_essence>]);
remakeBlock   ('mysticalagriculture:quartz'               , <blockstate:minecraft:quartz_ore>                    , [<mysticalagriculture:nether_quartz_essence>]);
remakeBlock   ('mysticalagriculture:redstone'             , <blockstate:minecraft:redstone_ore>                  , [<mysticalagriculture:redstone_essence>]);
remakeBlock   ('mysticalagriculture:ingots_1'             , <blockstate:tconstruct:ore:type=ardite>              , [<mysticalagriculture:ardite_essence>]);
remakeBlock   ('mysticalagriculture:ingots_2'             , <blockstate:tconstruct:ore>                          , [<mysticalagriculture:cobalt_essence>]);
remakeBlock   ('mysticalagriculture:ingotcopper'          , <blockstate:thermalfoundation:ore:type=copper>       , [<mysticalagriculture:copper_essence>]);
remakeBlock   ('mysticalagriculture:ingottin'             , <blockstate:thermalfoundation:ore:type=tin>          , [<mysticalagriculture:tin_essence>]);
remakeBlock   ('mysticalagriculture:ingotsilver'          , <blockstate:thermalfoundation:ore:type=silver>       , [<mysticalagriculture:silver_essence>]);
remakeBlock   ('mysticalagriculture:ingotaluminum'        , <blockstate:thermalfoundation:ore:type=aluminum>     , [<mysticalagriculture:aluminum_essence>]);
remakeBlock   ('mysticalagriculture:ingotnickel'          , <blockstate:thermalfoundation:ore:type=nickel>       , [<mysticalagriculture:nickel_essence>]);
remakeManapool('mysticalagriculture:ingotplatinum'        , <thermalfoundation:material:198>, [<mysticalagriculture:platinum_essence>]);
remakeBlock   ('mysticalagriculture:ingotiridium'         , <blockstate:thermalfoundation:ore:type=iridium>      , [<mysticalagriculture:iridium_essence>]);
remakeBlock   ('mysticalagriculture:ingoturanium'         , <blockstate:immersiveengineering:ore:type=uranium>   , [<mysticalagriculture:uranium_essence>]);
remakeBlock   (null      															    , <blockstate:nuclearcraft:ore:type=boron>             , [<mysticalagriculture:boron_essence>]);
remakeBlock   (null      															    , <blockstate:nuclearcraft:ore:type=lithium>           , [<mysticalagriculture:lithium_essence>]);
remakeBlock   (null      															    , <blockstate:nuclearcraft:ore:type=magnesium>         , [<mysticalagriculture:magnesium_essence>]);
remakeBlock   (null      															    , <blockstate:nuclearcraft:ore:type=thorium>           , [<mysticalagriculture:thorium_essence>]);
remakeManapool('mysticalagriculture:ingotknightmetal', <twilightforest:armor_shard> * 3, [<mysticalagriculture:knightmetal_essence>]);
remakeCrucible('mysticalagriculture:ingotironwood', <twilightforest:root:1> * 2, [<mysticalagriculture:ironwood_essence>], Aspects('❤️'));
// remakeSimple("mysticalagriculture:apple"                , <minecraft:apple> * 8                     , [<mysticalagriculture:nature_essence> * 3                                            ]);
// remakeSimple("mysticalagriculture:arrow"                , <minecraft:arrow> * 8                     , [<mysticalagriculture:skeleton_essence> * 3                                          ]);
remakeBlock   ('mysticalagriculture:basalt2'              , <blockstate:contenttweaker:compressed_basalt_double> , [<mysticalagriculture:basalt_essence>]);
// remakeSimple("mysticalagriculture:beetroot"             , <minecraft:beetroot> * 12                 , [<mysticalagriculture:nature_essence> * 3                                            ]);
// remakeSimple("mysticalagriculture:blaze_rod"            , <minecraft:blaze_rod> * 3                 , [<mysticalagriculture:blaze_essence> * 5                                             ]);
// remakeSimple("mysticalagriculture:blockmarble"          , <astralsorcery:blockmarble> * 16          , [<mysticalagriculture:marble_essence> * 8, <mysticalagriculture:aquamarine_essence>  ]);
// remakeSimple("mysticalagriculture:bone"                 , <minecraft:bone> * 8                      , [<mysticalagriculture:skeleton_essence> * 5                                          ]);
// remakeSimple("mysticalagriculture:brown_mushroom"       , <minecraft:brown_mushroom> * 8            , [<mysticalagriculture:nature_essence> * 2, <mysticalagriculture:dirt_essence>        ]);
// remakeSimple("mysticalagriculture:cactus"               , <minecraft:cactus> * 16                   , [<mysticalagriculture:nature_essence> * 7                                            ]);
// remakeSimple("mysticalagriculture:carrot"               , <minecraft:carrot> * 12                   , [<mysticalagriculture:nature_essence> * 3                                            ]);
// remakeSimple("mysticalagriculture:chorus_fruit"         , <minecraft:chorus_fruit> * 2              , [<mysticalagriculture:end_essence> * 2, <mysticalagriculture:nature_essence>         ]);
// remakeSimple("mysticalagriculture:cobblestone"          , <minecraft:cobblestone> * 32              , [<mysticalagriculture:stone_essence> * 8                                             ]);
remakeAltair('mysticalagriculture:crystalfluix'         , <appliedenergistics2:material:7> * 12      , [<mysticalagriculture:fluix_essence>]);
remakeAltair('mysticalagriculture:dustsaltpeter'        , <thermalfoundation:material:772> * 12      , [<mysticalagriculture:saltpeter_essence>]);
remakeAltair('mysticalagriculture:dustsulfur'           , <thermalfoundation:material:771> * 12      , [<mysticalagriculture:sulfur_essence>]);
// remakeSimple("mysticalagriculture:dye_1"                , <minecraft:dye> * 4                       , [<mysticalagriculture:dye_essence> * 3                                               ]);
// remakeSimple("mysticalagriculture:dye_2"                , <minecraft:dye:1> * 4                     , [<mysticalagriculture:dye_essence> * 3                                               ]);
// remakeSimple("mysticalagriculture:dye_3"                , <minecraft:dye:5> * 4                     , [<mysticalagriculture:dye_essence> * 3                                               ]);
// remakeSimple("mysticalagriculture:dye_4"                , <minecraft:dye:6> * 4                     , [<mysticalagriculture:dye_essence> * 3                                               ]);
// remakeSimple("mysticalagriculture:dye_5"                , <minecraft:dye:7> * 4                     , [<mysticalagriculture:dye_essence> * 3                                               ]);
// remakeSimple("mysticalagriculture:dye_6"                , <minecraft:dye:8> * 4                     , [<mysticalagriculture:dye_essence> * 3                                               ]);
// remakeSimple("mysticalagriculture:dye_7"                , <minecraft:dye:9> * 4                     , [<mysticalagriculture:dye_essence> * 3                                               ]);
// remakeSimple("mysticalagriculture:dye_8"                , <minecraft:dye:10> * 4                    , [<mysticalagriculture:dye_essence> * 3                                               ]);
// remakeSimple("mysticalagriculture:dye_9"                , <minecraft:dye:11> * 4                    , [<mysticalagriculture:dye_essence> * 3                                               ]);
// remakeSimple("mysticalagriculture:dye_10"               , <minecraft:dye:12> * 4                    , [<mysticalagriculture:dye_essence> * 3                                               ]);
// remakeSimple("mysticalagriculture:dye_11"               , <minecraft:dye:13> * 4                    , [<mysticalagriculture:dye_essence> * 3                                               ]);
// remakeSimple("mysticalagriculture:dye_12"               , <minecraft:dye:14> * 4                    , [<mysticalagriculture:dye_essence> * 3                                               ]);
// remakeSimple("mysticalagriculture:dye"                  , <minecraft:dye:3> * 8                     , [<mysticalagriculture:nature_essence> * 3                                            ]);
// remakeSimple("mysticalagriculture:egg"                  , <minecraft:egg> * 8                       , [<mysticalagriculture:chicken_essence> * 3                                           ]);
// remakeSimple("mysticalagriculture:end_stone"            , <minecraft:end_stone> * 12                , [<mysticalagriculture:end_essence> * 8                                               ]);
// remakeSimple("mysticalagriculture:ender_pearl"          , <minecraft:ender_pearl> * 3               , [<mysticalagriculture:enderman_essence> * 8                                          ]);
// remakeSimple("mysticalagriculture:feather"              , <minecraft:feather> * 8                   , [<mysticalagriculture:chicken_essence> * 3                                           ]);
// remakeSimple("mysticalagriculture:fish"                 , <minecraft:fish> * 4                      , [<mysticalagriculture:guardian_essence> * 3                                          ]);
// remakeSimple("mysticalagriculture:flint"                , <minecraft:flint> * 8                     , [<mysticalagriculture:stone_essence> * 2, <mysticalagriculture:fire_essence> * 2     ]);
// remakeSimple("mysticalagriculture:flower_1"             , <botania:flower:1> * 6                    , [<mysticalagriculture:mystical_flower_essence> * 3                                   ]);
// remakeSimple("mysticalagriculture:flower_2"             , <botania:flower:2> * 6                    , [<mysticalagriculture:mystical_flower_essence> * 3                                   ]);
// remakeSimple("mysticalagriculture:flower_3"             , <botania:flower:3> * 6                    , [<mysticalagriculture:mystical_flower_essence> * 3                                   ]);
// remakeSimple("mysticalagriculture:flower_4"             , <botania:flower:4> * 6                    , [<mysticalagriculture:mystical_flower_essence> * 3                                   ]);
// remakeSimple("mysticalagriculture:flower_5"             , <botania:flower:5> * 6                    , [<mysticalagriculture:mystical_flower_essence> * 3                                   ]);
// remakeSimple("mysticalagriculture:flower_6"             , <botania:flower:6> * 6                    , [<mysticalagriculture:mystical_flower_essence> * 3                                   ]);
// remakeSimple("mysticalagriculture:flower_7"             , <botania:flower:7> * 6                    , [<mysticalagriculture:mystical_flower_essence> * 3                                   ]);
// remakeSimple("mysticalagriculture:flower_8"             , <botania:flower:8> * 6                    , [<mysticalagriculture:mystical_flower_essence> * 3                                   ]);
// remakeSimple("mysticalagriculture:flower_9"             , <botania:flower:9> * 6                    , [<mysticalagriculture:mystical_flower_essence> * 3                                   ]);
// remakeSimple("mysticalagriculture:flower_10"            , <botania:flower:10> * 6                   , [<mysticalagriculture:mystical_flower_essence> * 3                                   ]);
// remakeSimple("mysticalagriculture:flower_11"            , <botania:flower:11> * 6                   , [<mysticalagriculture:mystical_flower_essence> * 3                                   ]);
// remakeSimple("mysticalagriculture:flower_12"            , <botania:flower:12> * 6                   , [<mysticalagriculture:mystical_flower_essence> * 3                                   ]);
// remakeSimple("mysticalagriculture:flower_13"            , <botania:flower:13> * 6                   , [<mysticalagriculture:mystical_flower_essence> * 3                                   ]);
// remakeSimple("mysticalagriculture:flower_14"            , <botania:flower:14> * 6                   , [<mysticalagriculture:mystical_flower_essence> * 3                                   ]);
// remakeSimple("mysticalagriculture:flower_15"            , <botania:flower:15> * 6                   , [<mysticalagriculture:mystical_flower_essence> * 3                                   ]);
// remakeSimple("mysticalagriculture:flower"               , <botania:flower> * 6                      , [<mysticalagriculture:mystical_flower_essence> * 3                                   ]);
remakeCrucible('mysticalagriculture:ghast_tear'         , <minecraft:ghast_tear>                    , [<mysticalagriculture:ghast_essence>], Aspects('💀'));
// remakeSimple("mysticalagriculture:grass"                , <minecraft:grass> * 8                     , [<mysticalagriculture:dirt_essence> * 4, <mysticalagriculture:nature_essence>        ]);
// remakeSimple("mysticalagriculture:gravel"               , <minecraft:gravel> * 16                   , [<mysticalagriculture:dirt_essence> * 2, <mysticalagriculture:stone_essence> * 2     ]);
// remakeSimple("mysticalagriculture:gunpowder"            , <minecraft:gunpowder> * 6                 , [<mysticalagriculture:creeper_essence> * 3                                           ]);
remakeManapool('mysticalagriculture:ingotelectrumflux'    , <redstonearsenal:material:64>        , [<mysticalagriculture:fluxed_electrum_essence>]);
remakeManapool('mysticalagriculture:ingotfiery'           , <twilightforest:fiery_ingot>, [<mysticalagriculture:fiery_ingot_essence>]);
remakeBlock('mysticalagriculture:ingotlead'            , <blockstate:thermalfoundation:ore:type=lead>, [<mysticalagriculture:lead_essence>]);
remakeManapool('mysticalagriculture:ingotsteeleaf'        , <twilightforest:steeleaf_ingot>, [<mysticalagriculture:steeleaf_essence>]);
remakeManapool('mysticalagriculture:ingotvoid'            , <thaumcraft:nugget:7>                  , [<mysticalagriculture:void_metal_essence>]);
// remakeSimple("mysticalagriculture:leather"              , <minecraft:leather> * 8                   , [<mysticalagriculture:cow_essence> * 4                                               ]);
// remakeSimple("mysticalagriculture:limestone2"           , <chisel:limestone2:7> * 24                , [<mysticalagriculture:limestone_essence> * 8                                         ]);
remakeArcane('mysticalagriculture:log'                  , <minecraft:log> * 64                      , ['eee'], { e: <mysticalagriculture:wood_essence> }, []);
remakeArcane('mysticalagriculture:log_1'                , <minecraft:log:1> * 64                    , ['','eee'], { e: <mysticalagriculture:wood_essence> }, []);
remakeArcane('mysticalagriculture:log_2'                , <minecraft:log:2> * 64                    , ['','','eee'], { e: <mysticalagriculture:wood_essence> }, []);
remakeArcane('mysticalagriculture:log_3'                , <minecraft:log:3> * 64                    , ['e','e','e'], { e: <mysticalagriculture:wood_essence> }, []);
remakeArcane('mysticalagriculture:log2'                 , <minecraft:log2> * 64                     , [' e',' e',' e'], { e: <mysticalagriculture:wood_essence> }, []);
remakeArcane('mysticalagriculture:log2_1'               , <minecraft:log2:1> * 64                   , ['  e','  e','  e'], { e: <mysticalagriculture:wood_essence> }, []);
// remakeSimple("mysticalagriculture:marble2"              , <chisel:marble2:7> * 16                   , [<mysticalagriculture:marble_essence> * 8                                            ]);
// remakeSimple("mysticalagriculture:melon_block"          , <minecraft:melon_block> * 8               , [<mysticalagriculture:nature_essence> * 9                                            ]);
// remakeSimple("mysticalagriculture:menril_berries"       , <integrateddynamics:menril_berries> * 12  , [<mysticalagriculture:menril_essence> * 3                                            ]);
// remakeSimple("mysticalagriculture:menril_log"           , <integrateddynamics:menril_log> * 16      , [<mysticalagriculture:menril_essence> * 3                                            ]);
// remakeSimple("mysticalagriculture:menril_sapling"       , <integrateddynamics:menril_sapling> * 4   , [<mysticalagriculture:menril_essence> * 2, <mysticalagriculture:nature_essence>      ]);
// remakeSimple("mysticalagriculture:mossy_cobblestone"    , <minecraft:mossy_cobblestone> * 16        , [<mysticalagriculture:stone_essence> * 4, <mysticalagriculture:nature_essence>       ]);
// remakeSimple("mysticalagriculture:mycelium"             , <minecraft:mycelium> * 16                 , [<mysticalagriculture:nature_essence> * 3, <mysticalagriculture:dirt_essence> * 5    ]);
// remakeSimple("mysticalagriculture:nether_brick"         , <minecraft:nether_brick> * 16             , [<mysticalagriculture:nether_essence> * 4                                            ]);
// remakeSimple("mysticalagriculture:nether_wart"          , <minecraft:nether_wart> * 6               , [<mysticalagriculture:nether_essence> * 2, <mysticalagriculture:nature_essence>      ]);
// remakeSimple("mysticalagriculture:netherrack"           , <minecraft:netherrack> * 32               , [<mysticalagriculture:nether_essence> * 5                                            ]);
// remakeSimple("mysticalagriculture:packed_ice"           , <minecraft:packed_ice> * 8                , [<mysticalagriculture:ice_essence> * 4                                               ]);
// remakeSimple("mysticalagriculture:potato"               , <minecraft:potato> * 12                   , [<mysticalagriculture:nature_essence> * 3                                            ]);
// remakeSimple("mysticalagriculture:prismarine_crystals"  , <minecraft:prismarine_crystals> * 16      , [<mysticalagriculture:guardian_essence> * 4                                          ]);
// remakeSimple("mysticalagriculture:prismarine_shard"     , <minecraft:prismarine_shard> * 12         , [<mysticalagriculture:guardian_essence> * 3                                          ]);
// remakeSimple("mysticalagriculture:pumpkin"              , <minecraft:pumpkin> * 16                  , [<mysticalagriculture:nature_essence> * 8                                            ]);
// remakeSimple("mysticalagriculture:purpur_block"         , <minecraft:purpur_block> * 12             , [<mysticalagriculture:end_essence> * 4                                               ]);
makeSmelt('mysticalagriculture:quicksilver', <fluid:fluid_quicksilver> * 250, [<mysticalagriculture:quicksilver_essence>]);
// remakeSimple("mysticalagriculture:rabbit_foot"          , <minecraft:rabbit_foot>                   , [<mysticalagriculture:rabbit_essence> * 5                                            ]);
// remakeSimple("mysticalagriculture:rabbit_hide"          , <minecraft:rabbit_hide> * 8               , [<mysticalagriculture:rabbit_essence> * 3                                            ]);
// remakeSimple("mysticalagriculture:red_mushroom"         , <minecraft:red_mushroom> * 8              , [<mysticalagriculture:nature_essence> * 2, <mysticalagriculture:dirt_essence>        ]);
// remakeSimple("mysticalagriculture:reeds"                , <minecraft:reeds> * 16                    , [<mysticalagriculture:nature_essence> * 6                                            ]);
// remakeSimple("mysticalagriculture:rotten_flesh"         , <minecraft:rotten_flesh> * 12             , [<mysticalagriculture:zombie_essence> * 3                                            ]);
// remakeSimple("mysticalagriculture:sapling_1"            , <minecraft:sapling:1> * 4                 , [<mysticalagriculture:wood_essence> * 2, <mysticalagriculture:nature_essence>        ]);
// remakeSimple("mysticalagriculture:sapling_2"            , <minecraft:sapling:2> * 4                 , [<mysticalagriculture:wood_essence> * 2, <mysticalagriculture:nature_essence>        ]);
// remakeSimple("mysticalagriculture:sapling_3"            , <minecraft:sapling:3> * 4                 , [<mysticalagriculture:wood_essence> * 2, <mysticalagriculture:nature_essence>        ]);
// remakeSimple("mysticalagriculture:sapling_4"            , <minecraft:sapling:4> * 4                 , [<mysticalagriculture:wood_essence> * 2, <mysticalagriculture:nature_essence>        ]);
// remakeSimple("mysticalagriculture:sapling_5"            , <minecraft:sapling:5> * 4                 , [<mysticalagriculture:wood_essence> * 2, <mysticalagriculture:nature_essence>        ]);
// remakeSimple("mysticalagriculture:sapling"              , <minecraft:sapling> * 4                   , [<mysticalagriculture:wood_essence> * 2, <mysticalagriculture:nature_essence>        ]);
makeSmelt('mysticalagriculture:sky_stone_block', <fluid:sky_stone> * 288, [<mysticalagriculture:sky_stone_essence>]);
// remakeSimple("mysticalagriculture:slate"                , <rustic:slate> * 24                       , [<mysticalagriculture:slate_essence> * 8                                             ]);
// remakeSimple("mysticalagriculture:slime_ball"           , <minecraft:slime_ball> * 8                , [<mysticalagriculture:slime_essence> * 5                                             ]);
// remakeSimple("mysticalagriculture:snow"                 , <minecraft:snow> * 12                     , [<mysticalagriculture:ice_essence> * 3                                               ]);
// remakeSimple("mysticalagriculture:spider_eye"           , <minecraft:spider_eye> * 3                , [<mysticalagriculture:spider_essence> * 5                                            ]);
// remakeSimple("mysticalagriculture:stone_1"              , <minecraft:stone:1> * 16                  , [<mysticalagriculture:stone_essence> * 4, <mysticalagriculture:nether_quartz_essence>]);
// remakeSimple("mysticalagriculture:stone_2"              , <minecraft:stone:3> * 16                  , [<mysticalagriculture:nether_quartz_essence>, <mysticalagriculture:stone_essence> * 4]);
// remakeSimple("mysticalagriculture:stone_3"              , <minecraft:stone:5> * 16                  , [<mysticalagriculture:stone_essence> * 4, <mysticalagriculture:nether_quartz_essence>]);
// remakeSimple("mysticalagriculture:stonebrick_2"         , <minecraft:stonebrick:1> * 16             , [<mysticalagriculture:stone_essence> * 4, <mysticalagriculture:nature_essence>       ]);
// remakeSimple("mysticalagriculture:string"               , <minecraft:string> * 8                    , [<mysticalagriculture:spider_essence> * 3                                            ]);
// remakeSimple("mysticalagriculture:tallgrass"            , <minecraft:tallgrass:1> * 8               , [<mysticalagriculture:nature_essence> * 3                                            ]);
// remakeSimple("mysticalagriculture:vine"                 , <minecraft:vine> * 16                     , [<mysticalagriculture:nature_essence> * 3                                            ]);
// remakeSimple("mysticalagriculture:waterlily"            , <minecraft:waterlily> * 8                 , [<mysticalagriculture:nature_essence> * 7                                            ]);
// remakeSimple("mysticalagriculture:wheat"                , <minecraft:wheat> * 12                    , [<mysticalagriculture:nature_essence> * 3                                            ]);
// remakeSimple("mysticalagriculture:wool"                 , <minecraft:wool> * 6                      , [<mysticalagriculture:sheep_essence> * 9                                             ]);
// remakeSimple("mysticalagriculture:xp_droplet"           , <mysticalagriculture:xp_droplet> * 8      , [<mysticalagriculture:experience_essence> * 8                                        ]);
/**/

// --------------------
// Sheep + Cow
val cowIngrs = {
  'C': <mysticalagriculture:cow_essence>, // Cow Essence
  'S': <mysticalagriculture:sheep_essence>, // Sheep Essence
} as IIngredient[string];

recipes.removeByRecipeName('mysticalagriculture:beef');
recipes.removeByRecipeName('mysticalagriculture:mutton');
recipes.removeByRecipeName('mysticalagriculture:leather');
recipes.removeByRecipeName('mysticalagriculture:wool');

makeArcane(<minecraft:beef> * 8, ['CCC'], cowIngrs, []);
makeArcane(<minecraft:leather> * 16, ['CC', 'CC'], cowIngrs, []);
makeArcane(<betteranimalsplus:antler> * 8, ['CC', 'SS'], cowIngrs, []);
makeArcane(<harvestcraft:venisonrawitem> * 8, ['CSC'], cowIngrs, []);
makeArcane(<harvestcraft:freshmilkitem> * 64, [' C ', 'C C', ' C '], cowIngrs, []);
makeArcane(<minecraft:wool> * 16, ['SSS'], cowIngrs, []);
makeArcane(<minecraft:mutton> * 8, ['','SSS'], cowIngrs, []);
// --------------------
// Chickens

recipes.removeByRecipeName('mysticalagriculture:chicken');
recipes.removeByRecipeName('mysticalagriculture:egg');
recipes.removeByRecipeName('mysticalagriculture:feather');

function chickEss(ingrs as IIngredient[][], output as IItemStack, visCost as int = 1, aspects as CTAspectStack[] = null) as void {
  if (isNull(output)) return;
  mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe(
    craft.uniqueRecipeName(output),
    'FIRSTSTEPS',
    visCost,
    isNull(aspects) ? [] : aspects,
    output,
    ingrs
  );
}

val CE = <mysticalagriculture:chicken_essence>;
val uniqChick = scripts.lib.unique.Unique([CE, CE, CE]);

chickEss(uniqChick.next(), <minecraft:egg> * 8);
chickEss(uniqChick.next(), <minecraft:feather> * 8);
chickEss(uniqChick.next(), <minecraft:chicken> * 4);
chickEss(uniqChick.next(), <betteranimalsplus:pheasant_egg> * 2, 10, Aspects('💨'));
chickEss(uniqChick.next(), <betteranimalsplus:turkey_egg> * 2, 10, Aspects('💨'));
chickEss(uniqChick.next(), <betteranimalsplus:goose_egg> * 2, 10, Aspects('💨'));

chickEss([[CE, <mysticalagriculture:gold_essence>, CE]], <betteranimalsplus:golden_goose_egg>, 5);
chickEss([[CE, <mysticalagriculture:copper_essence>, CE]], <iceandfire:stymphalian_bird_feather>, 10, Aspects('5💨'));
chickEss([[CE, <mysticalagriculture:water_essence>, CE]], <iceandfire:amphithere_feather>, 10, Aspects('5💨'));
chickEss([[CE, <mysticalagriculture:coal_essence>, CE]], <twilightforest:raven_feather>, 10, Aspects('5💨'));
// --------------------------------------------
