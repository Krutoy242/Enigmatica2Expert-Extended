#modloaded thaumadditions

import crafttweaker.data.IData;
import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;
import mods.zenutils.DataUpdateOperation.APPEND;
import mods.zenutils.DataUpdateOperation.MERGE;
import mods.zenutils.DataUpdateOperation.REMOVE;
import mods.zenutils.DataUpdateOperation.OVERWRITE;

mods.thaumcraft.Infusion.removeRecipe(<minecraft:golden_apple:1>);

scripts.process.sawWood(<thaumcraft:taint_log>, <thaumadditions:taintwood_planks>, 'only: TESawmill'); 

val toHide = [
  'aer',
  'alienis',
  'alkimia',
  'amogus',
  'aqua',
  'auram',
  'aversio',
  'bestia',
  'caeles',
  'cognitio',
  'desiderium',
  'draco',
  'exanimis',
  'exitium',
  'fabrico',
  'fluctus',
  'gelum',
  'herba',
  'humanus',
  'ignis',
  'imperium',
  'infernum',
  'instrumentum',
  'lux',
  'machina',
  'mana',
  'metallum',
  'mortuus',
  'motus',
  'mythus',
  'ordo',
  'perditio',
  'permutatio',
  'potentia',
  'praecantatio',
  'praemunio',
  'rattus',
  'sanguis',
  'sensus',
  'sonus',
  'spiritus',
  'tenebrae',
  'terra',
  'vacuos',
  'ventus',
  'vinculum',
  'visum',
  'victus',
  'volatus',
  'vitium',
  'vitreus',
] as string[];

for item in toHide {
  mods.thaumcraft.Crucible.removeRecipe('thaumadditions:'~item~'_vis_seed');
}

/*
___ _  _ ____ _  _ _  _ ____ ___  ___  _ ___ _ ____ _  _ ____ 
 |  |__| |__| |  | |\/| |__| |  \ |  \ |  |  | |  | |\ | [__  
 |  |  | |  | |__| |  | |  | |__/ |__/ |  |  | |__| | \| ___] 
                                                              
*/

<minecraft:spawn_egg>.withTag({EntityTag: {id: "thaumadditions:blue_wolf"}})
                                                .setAspects(<aspect:bestia>*20        ,<aspect:auram>*20      ,<aspect:mana>*10); 
<entity:thaumadditions:blue_wolf>               .setAspects(<aspect:bestia>*20        ,<aspect:auram>*20      ,<aspect:mana>*10);

<thaumadditions:mithrillium_ingot>              .setAspects(<aspect:metallum>*15  ,<aspect:mana>*10           ,<aspect:praecantatio>*10 ,<aspect:ordo>*2      ,<aspect:vitreus>*3);
<thaumadditions:mithrillium_block>              .setAspects(<aspect:metallum>*150 ,<aspect:mana>*100          ,<aspect:praecantatio>*100,<aspect:ordo>*20     ,<aspect:vitreus>*30);
<thaumadditions:mithrillium_plate>              .setAspects(<aspect:metallum>*15  ,<aspect:mana>*10           ,<aspect:praecantatio>*10 ,<aspect:ordo>*2      ,<aspect:vitreus>*3, <aspect:instrumentum>*2);
<thaumadditions:adaminite_ingot>                .setAspects(<aspect:metallum>*15  ,<aspect:infernum>*66       ,<aspect:sanguis>*10      ,<aspect:spiritus>*10 ,<aspect:vitium>*3);
<thaumadditions:adaminite_block>                .setAspects(<aspect:metallum>*150 ,<aspect:infernum>*666      ,<aspect:sanguis>*100     ,<aspect:spiritus>*100,<aspect:vitium>*30);
<thaumadditions:adaminite_plate>                .setAspects(<aspect:metallum>*15  ,<aspect:infernum>*66       ,<aspect:sanguis>*10      ,<aspect:spiritus>*10 ,<aspect:vitium>*3, <aspect:instrumentum>*2);
<thaumadditions:mithminite_ingot>               .setAspects(<aspect:metallum>*15  ,<aspect:draco>*10          ,<aspect:mythus>*10       ,<aspect:caeles>*10   ,<aspect:auram>*20);
<thaumadditions:mithminite_block>               .setAspects(<aspect:metallum>*150 ,<aspect:draco>*100         ,<aspect:mythus>*100      ,<aspect:caeles>*100  ,<aspect:auram>*200);
<thaumadditions:mithminite_plate>               .setAspects(<aspect:metallum>*15  ,<aspect:draco>*10          ,<aspect:mythus>*10       ,<aspect:caeles>*10   ,<aspect:auram>*20, <aspect:instrumentum>*2);
<thaumadditions:puriflower>                     .setAspects(<aspect:auram>*10     ,<aspect:herba>*20          ,<aspect:praecantatio>*10 ,<aspect:sensus>*20);

/*
██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██████╗ ███████╗███╗   ██╗ ██████╗██╗  ██╗
██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██╔══██╗██╔════╝████╗  ██║██╔════╝██║  ██║
██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██████╔╝█████╗  ██╔██╗ ██║██║     ███████║
██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██╔══██╗██╔══╝  ██║╚██╗██║██║     ██╔══██║
╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██████╔╝███████╗██║ ╚████║╚██████╗██║  ██║
 ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═══╝ ╚═════╝╚═╝  ╚═╝
*/

// [Thaumonomicon Lectern] from [Lectern][+2]
craft.remake(<thaumadditions:thaumic_lectern>, ['pretty',
  '  T  ',
  '# L #',
  '# # #'], {
  'T': <thaumcraft:thaumonomicon>, // Thaumonomicon
  '#': <thaumcraft:slab_greatwood>, // Greatwood Slab
  'L': <iceandfire:lectern>, // Lectern
});

// [Crystal crusher]
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:crystal_crusher>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('crystal_crusher',
  'CRYSTALCRUSHER',
  50,
  [<aspect:perditio> * 6, <aspect:terra> * 3],
  <thaumadditions:crystal_crusher>,
  Grid(['pretty',
    'S S S',
    '  C  ',
    'T T T'], {
    'S': <thaumcraft:slab_arcane_stone>, // Arcane slab
    'C': <thaumcraft:mechanism_complex>, // Complex mechanism
    'T': <ore:plateThaumium>, // Thaumium plate
  }).shaped());

// [Essentia pistol]
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:essentia_pistol>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('essentia_pistol',
  'ESSENTIAPISTOL',
  100,
  [<aspect:aer>],
  <thaumadditions:essentia_pistol>,
  Grid(['pretty',
    'D S S',
    'W B M',
    'W    '], {
    'D': <thaumadditions:aura_disperser>, // Aura disperser
    'B': <minecraft:stone_button>, // Stone button
    'W': <thaumcraft:plank_greatwood>, // Greatwood plank
    'S': <thaumcraft:slab_arcane_stone>, // Arcane slab
    'M': <thaumcraft:mechanism_simple>, // Simple mechanism
  }).shaped());

// [Void thaumometer]
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:void_thaumometer>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('void_thaumometer',
  'VOIDTHAUMOMETER',
  100,
  [<aspect:aer>, <aspect:ignis>, <aspect:aqua>, <aspect:terra>, <aspect:ordo>, <aspect:perditio>],
  <thaumadditions:void_thaumometer>,
  Grid(['pretty',
    '  V  ',
    'V G V',
    '  V  '], {
    'V': <ore:ingotVoid>, // Void metal ingot
    'G': <ore:paneGlass>, // Glass pane
  }).shaped());

// [Vis scribing tools]
mods.thaumcraft.ArcaneWorkbench.removeRecipe(<thaumadditions:vis_scribing_tools>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('vis_scribing_tools',
  'VISSCRIBINGTOOLS',
  100,
  [<aspect:aer>, <aspect:ignis>, <aspect:aqua>, <aspect:terra>, <aspect:ordo>, <aspect:perditio>],
  <thaumadditions:vis_scribing_tools>,
  Grid(['pretty',
    '  P  ',
    'P S G',
    '  G A'], {
    'P': <thaumcraft:crystal_essence>.withTag({ Aspects: [{ amount: 1, key: 'praecantatio' }] }), // Phial of praecantatio
    'S': <thaumcraft:scribing_tools>, // Scribing tools
    'G': <ore:blockGlass>, // Glass
    'A': <thaumcraft:phial:1>.withTag({ Aspects: [{ amount: 10, key: 'auram' }] }), // Phial of auram
  }).shaped());

// [Seal]
mods.thaumcraft.ArcaneWorkbench.removeRecipe('thaumadditions:seal');
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('seal',
  'SEAL',
  10,
  [],
  <thaumadditions:seal> * 2,
  Grid(['pretty',
    '  V  ',
    'V G V',
    '  V  '], {
    'V': <ore:nuggetGold>, // Gold nugget
    'G': <ore:wool>, // Any wool
  }).shaped());

// [Crystal bag]
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:crystal_bag>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('crystal_bag',
  'CRYSTALBAG',
  100,
  [<aspect:aer>, <aspect:ignis>, <aspect:aqua>, <aspect:terra>, <aspect:ordo>, <aspect:perditio>],
  <thaumadditions:crystal_bag>,
  Grid(['pretty',
    'F Q F',
    'F P F',
    'F F F'], {
    'F': <thaumcraft:fabric>, // Enchanted fabric
    'P': <thaumcraft:focus_pouch>, // Focus pouch
    'Q': <thaumcraft:quicksilver>, // Quicksilver
  }).shaped());

// [Fragnant pendant]
mods.thaumcraft.ArcaneWorkbench.removeRecipe('thaumadditions:fragnant_pendant');
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('fragnant_pendant',
  'FRAGNANTPENDANT',
  50,
  [<aspect:aer>, <aspect:ordo>, <aspect:aqua>],
  <thaumadditions:fragnant_pendant>,
  Grid(['pretty',
    '  F  ',
    'S B F',
    'A O  '], {
    'B': <thaumcraft:baubles:4>, // Amulet
    'F': <thaumcraft:filter>, // Essentia filter
    'A': <thaumcraft:amber>, // Amber gem
    'O': <thaumadditions:odour_powder>, // Odour powder
    'S': <thaumcraft:salis_mundus>, // Salis mudus
  }).shaped());

// [Dawn totem]
mods.thaumcraft.ArcaneWorkbench.removeRecipe(<thaumadditions:dawn_totem>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('dawn_totem',
  'TOTEMANCY',
  100,
  [<aspect:aer>, <aspect:ordo>],
  <thaumadditions:dawn_totem> * 4,
  Grid(['pretty',
    'W V W',
    'Q L Q',
    'W S W'], {
    'L': <thaumcraft:condenser_lattice>, // Lattice
    'V': <thaumcraft:vis_resonator>, // Vis resonator
    'S': <thaumcraft:shimmerleaf>, // Simmerleaf
    'Q': <thaumcraft:quicksilver>, // Quicksilver
    'W': <thaumcraft:plank_silverwood>, // Silverwood plank
  }).shaped());

// [Twilight totem]
mods.thaumcraft.ArcaneWorkbench.removeRecipe(<thaumadditions:twilight_totem>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('twilight_totem',
  'TOTEMANCY',
  100,
  [<aspect:terra>, <aspect:perditio>],
  <thaumadditions:twilight_totem> * 4,
  Grid(['pretty',
    'W V W',
    'Q L Q',
    'W S W'], {
    'L': <thaumcraft:condenser_lattice_dirty>, // Tainted lattice
    'V': <thaumcraft:vis_resonator>, // Vis resonator
    'S': <thaumcraft:vishroom>, // Vishroom
    'Q': <thaumcraft:quicksilver>, // Quicksilver
    'W': <thaumadditions:taintwood_planks>, // Taintedwood planks
  }).shaped());

// [Crystal bore]
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:crystal_bore>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('crystal_bore',
  'CRYSTALBORE',
  20,
  [<aspect:terra>, <aspect:perditio>, <aspect:ordo>],
  <thaumadditions:crystal_bore>,
  Grid(['pretty',
    'B V B',
    'M R M',
    'L L L'], {
    'L': <actuallyadditions:item_misc:5>, // Black quartz block
    'M': <thaumcraft:mechanism_simple>, // Simple mechanism
    'R': <thaumcraft:morphic_resonator>, // Resonator
    'B': <ore:plateBrass>, // Brass plate
    'V': <thaumcraft:vis_resonator>, // Vis resonator
  }).shaped());

// [Crystal lamp]
mods.thaumcraft.ArcaneWorkbench.removeRecipe(<thaumadditions:crystal_lamp>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('crystal_lamp',
  'CRYSTALLAMP',
  10,
  [],
  <thaumadditions:crystal_lamp>,
  Grid(['pretty',
    'G   G',
    '  N  ',
    'G   G'], {
    'N': <ore:nitor>, // Nitor
    'G': <thaumcraft:plank_greatwood>, // Greatwood plank
  }).shaped());

// [Crystal growth chamber]
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:growth_chamber>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('growth_chamber',
  'GROWTHCHAMBER',
  50,
  [<aspect:aer>, <aspect:ignis>, <aspect:aqua>, <aspect:terra>, <aspect:ordo>, <aspect:perditio>],
  <thaumadditions:growth_chamber>,
  Grid(['pretty',
    'B V B',
    'M A M',
    'T R T'], {
    'V': <thaumcraft:vis_resonator>, // Vis resonator
    'M': <thaumcraft:mechanism_simple>, // Simple mechanism
    'R': <thaumcraft:morphic_resonator>, // Resonator
    'B': <ore:plateBrass>, // Brass plate
    'T': <thaumcraft:plate:2>, // Thaumium plate
    'A': <thaumcraft:metal_alchemical>, // Alchemical construct
  }).shaped());

// [Knowledge tome] - replacement for thaumic tinkerer tome of knowledge
mods.thaumcraft.ArcaneWorkbench.removeRecipe('thaumadditions:knowledge_tome');
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('knowledge_tome',
  'TT_SHARE_TOME',
  10,
  [],
  <thaumadditions:knowledge_tome>,
  [Grid(['SCT'], {
    'C': <thaumcraft:curio:1>, // Curio (alchemy)
    'S': <thaumcraft:scribing_tools:*>, // Scribing tools
    'T': <thaumcraft:thaumonomicon>, // Thaumonomicon
  }).shapeless()]);

// [Seal globe]
mods.thaumcraft.ArcaneWorkbench.removeRecipe('thaumadditions:seal_globe');
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('seal_globe',
  'SEALGLOBE',
  100,
  [<aspect:aer>, <aspect:ignis>, <aspect:aqua>, <aspect:terra>, <aspect:ordo>, <aspect:perditio>],
  <thaumadditions:seal_globe>,
  Grid(['pretty',
    'G G G',
    'G V G',
    'C T C'], {
    'G': <ore:blockGlass>, // Glass
    'C': <ore:ingotCopper>, // Copper ingot
    'V': <thaumcraft:vis_resonator:*>, // Vis resonator
    'T': <thaumcraft:thaumometer>, // Thaumometer
  }).shaped());

// [Bone eye] - wand for chester
mods.thaumcraft.ArcaneWorkbench.removeRecipe(<thaumadditions:bone_eye>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('bone_eye',
  'CHESTER',
  100,
  [<aspect:aer>, <aspect:ordo>],
  <thaumadditions:bone_eye>,
  Grid(['pretty',
    '  Q S',
    '  T Q',
    'B    '], {
    'Q': <ore:gemQuartz>, // Quartz
    'T': <ore:ingotThaumium>, // Thaumium ingot
    'S': <minecraft:spider_eye>, // Spider eye
    'B': <ore:bone>, // Bone
  }).shaped());

// [Essentia sink]
recipes.removeByRecipeName('hammercore:thaumadditions_recipestar.20');
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('essentia_sink',
  'SHADOWBEAM',
  100,
  [<aspect:ignis>, <aspect:aqua> * 3],
  <thaumadditions:essentia_sink>,
  Grid(['pretty',
    'J V J',
    'T W T',
    '  B  '], {
    'V': <thaumcraft:tube_valve>, // Valve (tube)
    'J': <thaumcraft:jar_brace>, // Jar brace
    'W': <thaumcraft:table_wood>, // Table
    'B': <thaumcraft:slab_greatwood>, // Greatwood plank slab
    'T': <thaumcraft:tube>, // Essentia tube
  }).shaped());

// [Mithrillium smelter]
mods.thaumcraft.ArcaneWorkbench.removeRecipe(<thaumadditions:mithrillium_smelter>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('mithrillium_smelter',
  'SMELTERMITHRILLIUM',
  500,
  [<aspect:ignis> * 6, <aspect:aqua> * 3],
  <thaumadditions:mithrillium_smelter>,
  Grid(['pretty',
    'B S B',
    'P C P',
    'P P P'], {
    'S': <thaumcraft:smelter_void:*>, // Void smelter
    'B': <ore:plateBrass>, // Brass plate
    'P': <thaumadditions:mithrillium_plate:*>, // Mithrillium plate
    'C': <thaumadditions:mithrillium_resonator>, // Mithrillium resonator
  }).shaped());

// [Adaminite smelter]
mods.thaumcraft.ArcaneWorkbench.removeRecipe(<thaumadditions:adaminite_smelter>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('adaminite_smelter',
  'SMELTERADAMINITE',
  666,
  [<aspect:ignis> * 12, <aspect:aqua> * 6],
  <thaumadditions:adaminite_smelter>,
  Grid(['pretty',
    'B S B',
    'P C P',
    'P P P'], {
    'S': <thaumadditions:mithrillium_smelter:*>, // Mithrillium smelter
    'B': <ore:plateBrass>, // Brass plate
    'P': <thaumadditions:adaminite_plate>, // Adaminite plate
    'C': <bloodmagic:lava_crystal>, // Lava crystal
  }).shaped());

// [Mithminite smelter]
mods.thaumcraft.ArcaneWorkbench.removeRecipe(<thaumadditions:mithminite_smelter>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('mithminite_smelter',
  'SMELTERMITHMINITE',
  1500,
  [<aspect:ignis> * 24, <aspect:aqua> * 12],
  <thaumadditions:mithminite_smelter>,
  Grid(['pretty',
    'B S B',
    'P C P',
    'P P P'], {
    'S': <thaumadditions:adaminite_smelter:*>, // Adaminite smelter
    'B': <ore:plateBrass>, // Brass plate
    'P': <thaumadditions:mithminite_plate:*>, // Mithminite plate
    'C': <thaumadditions:crystal_block>.withTag({ Aspect: 'amogus' }), // Crystal block of [Amogus essentia]
  }).shaped());

mods.thaumcraft.ArcaneWorkbench.removeRecipe(<thaumadditions:jar_brass>);
mods.thaumcraft.ArcaneWorkbench.removeRecipe(<thaumadditions:jar_thaumium>);
mods.thaumcraft.ArcaneWorkbench.removeRecipe(<thaumadditions:jar_eldritch>);
mods.thaumcraft.ArcaneWorkbench.removeRecipe(<thaumadditions:jar_mithrillium>);
mods.thaumcraft.ArcaneWorkbench.removeRecipe(<thaumadditions:jar_adaminite>);
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:jar_mithminite>);

// [Brass jar]
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('jar_brass',
  'JARBRASS',
  7,
  [],
  <thaumadditions:jar_brass>,
  Grid(['pretty',
    'U U U',
    'G J G',
    'G G G'], {
    'U': <ore:nuggetBrass>,
    'J': <thaumcraft:jar_normal>,
    'G': <ore:paneGlass>,
  }).shaped());

// [Thaumium jar]
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('jar_thaumium',
  'JARTHAUMIUM',
  15,
  [],
  <thaumadditions:jar_thaumium>,
  Grid(['pretty',
    'U U U',
    'G J G',
    'G G G'], {
    'U': <ore:nuggetThaumium>,
    'J': <thaumcraft:jar_normal>,
    'G': <ore:paneGlass>,
  }).shaped());
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('jar_thaumium_alt',
  'JARTHAUMIUM',
  10,
  [],
  <thaumadditions:jar_thaumium>,
  Grid(['pretty',
    'G U G',
    'G J G',
    'G G G'], {
    'U': <ore:nuggetThaumium>,
    'J': <thaumadditions:jar_brass>,
    'G': <ore:paneGlass>,
  }).shaped()
);

// [Void jar]
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('jar_eldritch',
  'JARVOID',
  100,
  [],
  <thaumadditions:jar_eldritch>,
  Grid(['pretty',
    'U U U',
    'G J G',
    'G G G'], {
    'U': <ore:nuggetVoid>,
    'J': <thaumcraft:jar_normal>,
    'G': <ore:paneGlass>,
  }).shaped());
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('jar_eldritch_alt',
  'JARVOID',
  50,
  [],
  <thaumadditions:jar_eldritch>,
  Grid(['pretty',
    'G U G',
    'G J G',
    'G G G'], {
    'U': <ore:nuggetVoid>,
    'J': <thaumadditions:jar_thaumium>,
    'G': <ore:paneGlass>,
  }).shaped());

// [Mithrillium jar]
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('jar_mithrillium',
  'JARMITHRILLIUM',
  500,
  [],
  <thaumadditions:jar_mithrillium>,
  Grid(['pretty',
    'U U U',
    'G J G',
    'G G G'], {
    'U': <ore:nuggetMithrillium>,
    'J': <thaumcraft:jar_normal>,
    'G': <ore:paneGlass>,
  }).shaped());
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('jar_mithrillium_alt',
  'JARMITHRILLIUM',
  250,
  [],
  <thaumadditions:jar_mithrillium>,
  Grid(['pretty',
    'G U G',
    'G J G',
    'G G G'], {
    'U': <ore:nuggetMithrillium>,
    'J': <thaumadditions:jar_eldritch>,
    'G': <ore:paneGlass>,
  }).shaped());

// [Adaminite jar]
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('jar_adaminite',
  'JARADAMINITE',
  666,
  [],
  <thaumadditions:jar_adaminite>,
  Grid(['pretty',
    'U U U',
    'G J G',
    'G G G'], {
    'U': <ore:nuggetAdaminite>,
    'J': <thaumcraft:jar_normal>,
    'G': <ore:paneGlass>,
  }).shaped());
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('jar_adaminite_alt',
  'JARADAMINITE',
  333,
  [],
  <thaumadditions:jar_adaminite>,
  Grid(['pretty',
    'G U G',
    'G J G',
    'G G G'], {
    'U': <ore:nuggetAdaminite>,
    'J': <thaumadditions:jar_mithrillium>,
    'G': <ore:paneGlass>,
  }).shaped());

// [Mithminite jar]
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('jar_mithminite',
  'JARMITHMINITE',
  1000,
  [],
  <thaumadditions:jar_mithminite>,
  Grid(['pretty',
    'U U U',
    'G J G',
    'G G G'], {
    'U': <ore:nuggetMithminite>,
    'J': <thaumcraft:jar_normal>,
    'G': <ore:paneGlass>,
  }).shaped());
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('jar_mithminite_alt',
  'JARMITHMINITE',
  500,
  [],
  <thaumadditions:jar_mithminite>,
  Grid(['pretty',
    'G U G',
    'G J G',
    'G G G'], {
    'U': <ore:nuggetMithminite>,
    'J': <thaumadditions:jar_adaminite>,
    'G': <ore:paneGlass>,
  }).shaped());

// [Adaminite fabric]
mods.thaumcraft.ArcaneWorkbench.removeRecipe(<thaumadditions:adaminite_fabric>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('adaminite_fabric',
  'ADAMINITEFABRIC',
  66,
  [],
  <thaumadditions:adaminite_fabric> * 4,
  Grid(['pretty',
    '  F  ',
    'F I F',
    '  F  '], {
    'I': <thaumadditions:adaminite_ingot>,
    'F': <thaumcraft:fabric>,
  }).shaped());

// [Mithminite fabric]
mods.thaumcraft.ArcaneWorkbench.removeRecipe(<thaumadditions:mithminite_fabric>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('mithminite_fabric',
  'MITHMINITEFABRIC',
  400,
  [],
  <thaumadditions:mithminite_fabric> * 2,
  Grid(['pretty',
    '  F  ',
    'F I F',
    '  F  '], {
    'I': <thaumadditions:mithminite_ingot>,
    'F': <thaumadditions:adaminite_fabric>,
  }).shaped());

// [Entity cell]
mods.thaumcraft.ArcaneWorkbench.removeRecipe(<thaumadditions:dna_sample>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('dna_sample',
  'SPAWNER@1',
  100,
  [],
  <thaumadditions:dna_sample>,
  Grid(['pretty',
    '  I  ',
    'F   F',
    '  F  '], {
    'I': <thaumicaugmentation:material:5>, // Impetus jewel
    'F': <thaumcraft:fabric>,
  }).shaped());

/*
 ██████╗██████╗ ██╗   ██╗ ██████╗██╗██████╗ ██╗     ███████╗
██╔════╝██╔══██╗██║   ██║██╔════╝██║██╔══██╗██║     ██╔════╝
██║     ██████╔╝██║   ██║██║     ██║██████╔╝██║     █████╗
██║     ██╔══██╗██║   ██║██║     ██║██╔══██╗██║     ██╔══╝
╚██████╗██║  ██║╚██████╔╝╚██████╗██║██████╔╝███████╗███████╗
 ╚═════╝╚═╝  ╚═╝ ╚═════╝  ╚═════╝╚═╝╚═════╝ ╚══════╝╚══════╝
*/

// [Odour powder]
mods.thaumcraft.Crucible.removeRecipe(<thaumadditions:odour_powder>);
mods.thaumcraft.Crucible.registerRecipe(
  'odour', // Name
  'FRAGNANTPENDANT', // Research
  <thaumadditions:odour_powder> * 4, // Output
  <thaumcraft:bath_salts>, // Input
  [<aspect:exitium> * 5, <aspect:ordo> * 5, <aspect:fluctus> * 10]
);

// [Blue bone]
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:blue_bone>);
mods.thaumcraft.Crucible.registerRecipe(
  'blue_bone', // Name
  'BASEALCHEMY', // Research
  <thaumadditions:blue_bone>, // Output
  <minecraft:bone>, // Input
  [<aspect:mana> * 10]
);

// [Blood shard] alt recipe
mods.thaumcraft.Crucible.registerRecipe(
  'weak_shard_alt', // Name
  'ADAMINITE', // Research
  <bloodmagic:blood_shard>, // Output
  <twilightforest:carminite>, // Input
  [<aspect:sanguis> * 20]
);

// [Crystal water] recipe
mods.thaumcraft.Crucible.removeRecipe(<forge:bucketfilled>.withTag({ FluidName: 'crystal_water', Amount: 1000 }));
mods.thaumcraft.Crucible.registerRecipe(
  'crystal_water', // Name
  'CRYSTALWATER', // Research
  <forge:bucketfilled>.withTag({ FluidName: 'crystal_water', Amount: 1000 }), // Output
  <minecraft:bucket>, // Input
  [<aspect:vitreus> * 10, <aspect:desiderium> * 4, <aspect:permutatio> * 6]
);

/*
██╗███╗   ██╗███████╗██╗   ██╗███████╗██╗ ██████╗ ███╗   ██╗
██║████╗  ██║██╔════╝██║   ██║██╔════╝██║██╔═══██╗████╗  ██║
██║██╔██╗ ██║█████╗  ██║   ██║███████╗██║██║   ██║██╔██╗ ██║
██║██║╚██╗██║██╔══╝  ██║   ██║╚════██║██║██║   ██║██║╚██╗██║
██║██║ ╚████║██║     ╚██████╔╝███████║██║╚██████╔╝██║ ╚████║
╚═╝╚═╝  ╚═══╝╚═╝      ╚═════╝ ╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝
*/

// [Arcane cake]
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:cake>);
mods.thaumcraft.Infusion.registerRecipe(
  'arcanecake', // Name
  'ACANECAKE', // Research
  <thaumadditions:cake>, // Output
  1, // Instability
  [<aspect:victus> * 20, <aspect:praecantatio> * 15, <aspect:desiderium> * 30, <aspect:ventus> * 15, <aspect:imperium> * 30],
  <minecraft:cake>, // CentralItem
  [<thaumcraft:primordial_pearl>.anyDamage(), <thaumcraft:quicksilver>, <thaumcraft:salis_mundus>, <thaumcraft:quicksilver>]
);

// [Aura disperser]
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:aura_disperser>);
mods.thaumcraft.Infusion.registerRecipe(
  'aura_disperser', // Name
  'AURADISPENSER', // Research
  <thaumadditions:aura_disperser>, // Output
  1, // Instability
  [<aspect:ventus> * 30, <aspect:imperium> * 50, <aspect:machina> * 25, <aspect:fluctus> * 15],
  <minecraft:dispenser>, // CentralItem
  [<thaumcraft:vishroom>, <thaumcraft:shimmerleaf>, <thaumadditions:salt_essence>.withTag({ Aspects: [{ amount: 9, key: 'auram' }] }), <thaumcraft:mechanism_simple>]
);

// [Void pickaxe]
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:void_elemental_pickaxe>);
mods.thaumcraft.Infusion.registerRecipe(
  'void_pickaxe', // Name
  'VOIDPICKAXE', // Research
  <thaumadditions:void_elemental_pickaxe>.withTag({ infench: [{ lvl: 1 as short, id: 4 as short }, { lvl: 2 as short, id: 3 as short }] }), // Output
  5, // Instability
  [<aspect:exitium> * 100, <aspect:ignis> * 80, <aspect:sensus> * 60, <aspect:alienis> * 40],
  <thaumcraft:elemental_pick>.anyDamage(), // CentralItem
  [<thaumcraft:primordial_pearl>.anyDamage(), <thaumcraft:plate:3>, <thaumcraft:plate:3>]
);

// [Void axe]
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:void_elemental_axe>);
mods.thaumcraft.Infusion.registerRecipe(
  'void_axe', // Name
  'VOIDAXE', // Research
  <thaumadditions:void_elemental_axe>.withTag({ infench: [{ lvl: 1 as short, id: 2 as short }, { lvl: 1 as short, id: 0 as short }] }), // Output
  5, // Instability
  [<aspect:herba> * 200, <aspect:aqua> * 100, <aspect:alienis> * 40],
  <thaumcraft:elemental_axe>.anyDamage(), // CentralItem
  [<thaumcraft:primordial_pearl>.anyDamage(), <thaumcraft:plate:3>, <thaumcraft:plate:3>]
);

// [Void shovel]
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:void_elemental_shovel>);
mods.thaumcraft.Infusion.registerRecipe(
  'void_shovel', // Name
  'VOIDSHOVEL', // Research
  <thaumadditions:void_elemental_shovel>.withTag({ infench: [{ lvl: 1 as short, id: 1 as short }] }), // Output
  5, // Instability
  [<aspect:exitium> * 100, <aspect:terra> * 100, <aspect:fabrico> * 80, <aspect:alienis> * 40],
  <thaumcraft:elemental_shovel>.anyDamage(), // CentralItem
  [<thaumcraft:primordial_pearl>.anyDamage(), <thaumcraft:plate:3>, <thaumcraft:plate:3>]
);

// [Void hoe]
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:void_elemental_hoe>);
mods.thaumcraft.Infusion.registerRecipe(
  'void_hoe', // Name
  'VOIDHOE', // Research
  <thaumadditions:void_elemental_hoe>, // Output
  5, // Instability
  [<aspect:herba> * 200, <aspect:victus> * 100, <aspect:alienis> * 40],
  <thaumcraft:elemental_hoe>.anyDamage(), // CentralItem
  [<thaumcraft:primordial_pearl>.anyDamage(), <thaumcraft:plate:3>, <thaumcraft:plate:3>]
);

// [Void seeds/crop]
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:void_seed>);
mods.thaumcraft.Infusion.registerRecipe(
  'void_crop', // Name
  'VOIDCROP', // Research
  <thaumadditions:void_seed>, // Output
  8, // Instability
  [<aspect:aer> * 20, <aspect:ignis> * 20, <aspect:aqua> * 20, <aspect:terra> * 20, <aspect:ordo> * 20, <aspect:perditio> * 20, <aspect:caeles> * 50, <aspect:tenebrae> * 100],
  <thaumcraft:elemental_hoe>.anyDamage(), // CentralItem
  [<thaumcraft:primordial_pearl>.anyDamage(), <botania:specialflower>.withTag({ type: 'excompressum.orechidEvolved' }), <thaumcraft:metal_void>, <botania:specialflower>.withTag({ type: 'orechidIgnem' }), <thaumcraft:salis_mundus>, <botania:specialflower>.withTag({ type: 'orechidVacuam' })]
);

// [Void anvil]
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:void_anvil>);
mods.thaumcraft.Infusion.registerRecipe(
  'void_anvil', // Name
  'VOIDANVIL', // Research
  <thaumadditions:void_anvil>, // Output
  5, // Instability
  [<aspect:caeles> * 20, <aspect:metallum> * 100, <aspect:alienis> * 150],
  <cyclicmagic:block_anvil_magma>, // CentralItem
  [<thaumcraft:plate:3>, <thaumcraft:plate:3>, <thaumcraft:plate:3>, <thaumcraft:plate:3>]
);

// [Void mirror]
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:wormhole_mirror>);
mods.thaumcraft.Infusion.registerRecipe(
  'void_mirror', // Name
  'VOIDMIRROR', // Research
  <thaumadditions:wormhole_mirror>, // Output
  5, // Instability
  [<aspect:imperium> * 100, <aspect:visum> * 80, <aspect:alienis> * 40],
  <thaumcraft:hand_mirror>, // CentralItem
  [<thaumadditions:void_thaumometer>, <thaumcraft:plate:3>, <thaumcraft:plate:3>]
);

// [Traveller belt]
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:traveller_belt>);
mods.thaumcraft.Infusion.registerRecipe(
  'traveller_belt', // Name
  'TRAVELLERBELT', // Research
  <thaumadditions:traveller_belt>, // Output
  2, // Instability
  [<aspect:motus> * 100, <aspect:volatus> * 100],
  <thaumcraft:baubles:2>, // CentralItem
  [<thaumcraft:crystal_essence>.withTag({ Aspects: [{ amount: 1, key: 'aer' }] }), <thaumcraft:crystal_essence>.withTag({ Aspects: [{ amount: 1, key: 'aer' }] }), <ore:fish>, <ore:feather>, <thaumcraft:fabric>, <thaumcraft:fabric>]
);

// [Striding belt]
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:striding_belt>);
mods.thaumcraft.Infusion.registerRecipe(
  'striding_belt', // Name
  'STRIDINGBELT', // Research
  <thaumadditions:striding_belt>, // Output
  3, // Instability
  [<aspect:mana> * 50, <aspect:fluctus> * 100, <aspect:sonus> * 50, <aspect:volatus> * 50, <aspect:ventus> * 50],
  <thaumadditions:traveller_belt>, // CentralItem
  [
    <ore:feather>,
    <thaumcraft:amber_block>,
    <ore:feather>,
    <botania:spark>,
    <ore:feather>,
    <thaumcraft:amber_block>,
    <ore:feather>,
    <thaumcraft:inlay>,
  ]
);

// [Meteor belt]
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:meteor_belt>);
mods.thaumcraft.Infusion.registerRecipe(
  'meteor_belt', // Name
  'METEORBELT', // Research
  <thaumadditions:meteor_belt>, // Output
  5, // Instability
  [<aspect:infernum> * 200, <aspect:fluctus> * 50, <aspect:motus> * 200, <aspect:caeles> * 25, <aspect:sanguis> * 100],
  <thaumadditions:striding_belt>, // CentralItem
  [<twilightforest:carminite>, <thaumadditions:zeith_fur>, <twilightforest:carminite>, <bloodmagic:slate:1>, <twilightforest:carminite>, <thaumadditions:zeith_fur>, <twilightforest:carminite>, <bloodmagic:slate:1>]
);

// [Chester]
<thaumadditions:chester>.addTooltip("§6Can be retrieved by Bone-eye§r");
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:chester>);
mods.thaumcraft.Infusion.registerRecipe(
  'chester', // Name
  'CHESTER', // Research
  <thaumadditions:chester>, // Output
  2, // Instability
  [<aspect:imperium> * 80, <aspect:victus> * 50, <aspect:motus> * 40, <aspect:vacuos> * 20, <aspect:machina> * 10],
  <thaumcraft:hungry_chest>, // CentralItem
  [<thaumcraft:brain>, <thaumcraft:log_greatwood>, <thaumcraft:ingot>, <thaumcraft:log_greatwood>, <thaumcraft:morphic_resonator>, <thaumcraft:log_greatwood>, <thaumcraft:ingot>, <thaumcraft:log_greatwood>]
);

// [Flux concentrator]
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:flux_concentrator>);
mods.thaumcraft.Infusion.registerRecipe(
  'flux_concentrator', // Name
  'FLUXCONCENTRATOR', // Research
  <thaumadditions:flux_concentrator>, // Output
  2, // Instability
  [<aspect:permutatio> * 50, <aspect:machina> * 30, <aspect:vitium> * 100],
  <thaumcraft:mechanism_complex>, // CentralItem
  [<thaumcraft:vishroom>, <thaumcraft:morphic_resonator>, <thaumcraft:vishroom>, <thaumcraft:bellows>]
);

// [Mithrillium block]
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:mithrillium_ingot>);
mods.thaumcraft.Infusion.registerRecipe(
  'mithrillium_ingot', // Name
  'MITHRILLIUM', // Research
  <thaumadditions:mithrillium_block>, // Output
  3, // Instability
  [<aspect:mana> * 200, <aspect:alienis> * 100, <aspect:praecantatio> * 150],
  <thaumcraft:metal_void>, // CentralItem
  [<botania:quartztypemana>, <botania:quartztypemana>, <thaumicaugmentation:material:5>, <botania:quartztypemana>, <botania:quartztypemana>, <thaumicaugmentation:material:5>]
);

// [Adaminite block]
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:adaminite_ingot>);
mods.thaumcraft.Infusion.registerRecipe(
  'adaminite_ingot', // Name
  'ADAMINITE', // Research
  <thaumadditions:adaminite_block>, // Output
  5, // Instability
  [<aspect:sanguis> * 100, <aspect:infernum> * 666, <aspect:spiritus> * 50],
  <thaumadditions:mithrillium_block>, // CentralItem
  [<bloodmagic:blood_shard>, <bloodmagic:slate>, <tconstruct:materials:11>, <bloodmagic:blood_shard>, <bloodmagic:slate>, <tconstruct:materials:11>]
);

// [Mithminite ingot]
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:mithminite_ingot>);
mods.thaumcraft.Infusion.registerRecipe(
  'mithminite_ingot', // Name
  'MITHMINITE', // Research
  <thaumadditions:mithminite_block>, // Output
  8, // Instability
  [<aspect:draco> * 200, <aspect:caeles> * 200, <aspect:mythus> * 200, <aspect:praecantatio> * 300],
  <thaumadditions:adaminite_block>, // CentralItem
  [<ore:dragonscaleBlock>, <thaumcraft:quicksilver>, <iceandfire:pixie_dust>, <ore:dragonscaleBlock>, <thaumcraft:quicksilver>, <iceandfire:pixie_dust>]
);

// [Mithrillium resonator]
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:mithrillium_resonator>);
mods.thaumcraft.Infusion.registerRecipe(
  'mithrillium_resonator', // Name
  'MITHRILLIUM', // Research
  <thaumadditions:mithrillium_resonator>, // Output
  4, // Instability
  [<aspect:imperium> * 20, <aspect:mana> * 30],
  <thaumcraft:morphic_resonator>, // CentralItem
  [<thaumadditions:mithrillium_plate>, <thaumadditions:mithrillium_plate>, <thaumicaugmentation:material:5>]
);

// [Shadow enchanter]
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:shadow_enchanter>);
mods.thaumcraft.Infusion.registerRecipe(
  'shadow_enchanter', // Name
  'SHADOWENCHANTER', // Research
  <thaumadditions:shadow_enchanter>, // Output
  6, // Instability
  [<aspect:caeles> * 50, <aspect:praecantatio> * 100, <aspect:instrumentum> * 100, <aspect:cognitio> * 500],
  <cyclicmagic:block_enchanter>, // CentralItem
  [<thaumadditions:mithrillium_resonator>, <extrautils2:ingredients:12>, <thaumcraft:mechanism_complex>, <thaumadditions:mithrillium_resonator>, <extrautils2:ingredients:12>, <thaumcraft:mechanism_complex>, <thaumicwonders:disjunction_cloth>]
);

// [Beheader]
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:the_beheader>);
mods.thaumcraft.Infusion.registerRecipe(
  'the_beheader', // Name
  'BEHEADER', // Research
  <thaumadditions:the_beheader>, // Output
  3, // Instability
  [<aspect:mortuus> * 100, <aspect:spiritus> * 50, <aspect:exanimis> * 100],
  <thaumcraft:void_axe>, // CentralItem
  [<ore:itemSkull>, <ore:itemSkull>, <thaumadditions:mithrillium_plate>, <ore:itemSkull>, <ore:itemSkull>, <thaumadditions:mithrillium_plate>]
);

// [Shadow beam staff]
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:shadow_beam_staff>);
mods.thaumcraft.Infusion.registerRecipe(
  'shadow_beam_staff', // Name
  'SHADOWBEAM', // Research
  <thaumadditions:shadow_beam_staff>, // Output
  4, // Instability
  [<aspect:alienis> * 300, <aspect:potentia> * 150, <aspect:praecantatio> * 100, <aspect:draco> * 20],
  <iceandfire:dragonbone>, // CentralItem
  [<thaumadditions:mithrillium_plate>, <biomesoplenty:gem:4>, <biomesoplenty:gem:4>, <thaumadditions:mithrillium_plate>, <thaumadditions:mithrillium_resonator>]
);

// [Adaminite sword]
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:adaminite_sword>);
mods.thaumcraft.Infusion.registerRecipe(
  'adaminite_sword', // Name
  'ADAMINITESWORD', // Research
  <thaumadditions:adaminite_sword>, // Output
  6, // Instability
  [<aspect:infernum> * 666, <aspect:aversio> * 100, <aspect:potentia> * 200, <aspect:caeles> * 50, <aspect:draco> * 50, <aspect:sanguis> * 150],
  <thaumcraft:void_sword>, // CentralItem
  [<thaumadditions:adaminite_plate>, <thaumadditions:adaminite_plate>, <thaumadditions:adaminite_plate>, <bloodmagic:slate:3>]
);

// [Essentia combiner]
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:aspect_combiner>);
mods.thaumcraft.Infusion.registerRecipe(
  'aspect_combiner', // Name
  'COMBINER', // Research
  <thaumadditions:aspect_combiner>, // Output
  2, // Instability
  [<aspect:praecantatio> * 50, <aspect:alkimia> * 200, <aspect:machina> * 100, <aspect:visum> * 50, <aspect:imperium> * 100],
  <thaumcraft:centrifuge>, // CentralItem
  [<thaumadditions:mithrillium_resonator>, <thaumcraft:mechanism_complex>, <thaumcraft:filter>, <thaumcraft:alumentum>, <thaumictinkerer:energetic_nitor>, <thaumcraft:filter>]
);

// [Aura charger]
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:aura_charger>);
mods.thaumcraft.Infusion.registerRecipe(
  'aura_charger', // Name
  'AURACHARGER', // Research
  <thaumadditions:aura_charger>, // Output
  5, // Instability
  [<aspect:auram> * 200, <aspect:machina> * 50, <aspect:alienis> * 100, <aspect:fluctus> * 100],
  <thaumadditions:aura_disperser>, // CentralItem
  [<thaumadditions:adaminite_plate>, <thaumcraft:mechanism_complex>, <thaumadditions:adaminite_plate>, <thaumadditions:mithrillium_resonator>]
);

// [Mithminite scythe blade]
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:mithminite_blade>);
mods.thaumcraft.Infusion.registerRecipe(
  'mithminite_blade', // Name
  'MITHMINITESCYTHE', // Research
  <thaumadditions:mithminite_blade>, // Output
  6, // Instability
  [<aspect:aversio> * 200, <aspect:exanimis> * 100, <aspect:mortuus> * 100, <aspect:infernum> * 666, <aspect:sanguis> * 200],
  <thaumadditions:mithminite_ingot>, // CentralItem
  [<thaumadditions:mithminite_plate>, <thaumicaugmentation:material:5>, <thaumadditions:mithminite_plate>, <thaumicaugmentation:material:5>]
);

// [Mithminite scythe handle]
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:mithminite_handle>);
mods.thaumcraft.Infusion.registerRecipe(
  'mithminite_handle', // Name
  'MITHMINITESCYTHE', // Research
  <thaumadditions:mithminite_handle>, // Output
  6, // Instability
  [<aspect:mana> * 200, <aspect:motus> * 100, <aspect:potentia> * 200, <aspect:spiritus> * 100, <aspect:mythus> * 100],
  <iceandfire:dragonbone>, // CentralItem
  [<thaumadditions:mithminite_plate>, <bloodmagic:item_demon_crystal>, <thaumadditions:mithminite_plate>, <bloodmagic:item_demon_crystal>]
);

// [Mithminite scythe] final craft
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:mithminite_scythe>);
mods.thaumcraft.Infusion.registerRecipe(
  'mithminite_scythe', // Name
  'MITHMINITESCYTHE', // Research
  <thaumadditions:mithminite_scythe>, // Output
  13, // Instability
  [<aspect:draco> * 200, <aspect:caeles> * 200, <aspect:amogus> * 100],
  <thaumcraft:crystal_essence>.withTag({ Aspects: [{ amount: 1, key: 'amogus' }] }), // CentralItem
  [<thaumadditions:mithminite_handle>, <thaumadditions:mithminite_plate>, <thaumadditions:mithminite_blade>, <thaumadditions:mithminite_plate>]
);

// [Entity summoner]
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:entity_summoner>);
mods.thaumcraft.Infusion.registerRecipe(
  'entity_summoner', // Name
  'SPAWNER', // Research
  <thaumadditions:entity_summoner>, // Output
  3, // Instability
  [<aspect:victus> * 100, <aspect:spiritus> * 100, <aspect:alienis> * 100, <aspect:imperium> * 100],
  <enderio:item_broken_spawner>, // CentralItem
  [<thaumcraft:mechanism_complex>, <thaumicaugmentation:material:5>, <thaumadditions:twilight_totem>, <thaumcraft:mechanism_complex>, <thaumicaugmentation:material:5>, <thaumadditions:dawn_totem>]
);

// [Vis recharge]
mods.thaumcraft.Infusion.registerRecipe(
  'recharge_charm', // Name
  'VISCHARM', // Research
  <thaumadditions:recharge_charm>, // Output
  2, // Instability
  [<aspect:auram> * 80, <aspect:vacuos> * 60],
  <thaumcraft:verdant_charm:*>, // CentralItem
  [<thaumcraft:crystal_essence>.withTag({ Aspects: [{ amount: 1, key: 'vacuos' }] }), <thaumcraft:vis_resonator>, <minecraft:potion>.withTag({ Potion: 'potioncore:strong_bless' }), <thaumcraft:crystal_essence>.withTag({ Aspects: [{ amount: 1, key: 'auram' }] })]
);

<thaumadditions:recharge_charm>.removeTooltipLine(2);

// [Boots of traveller]
mods.thaumcraft.Infusion.removeRecipe(<thaumcraft:traveller_boots>);
mods.thaumcraft.Infusion.registerRecipe(
  'BootsTraveller', // Name
  'BOOTSTRAVELLER', // Research
  <thaumcraft:traveller_boots>, // Output
  1, // Instability
  [<aspect:volatus> * 100, <aspect:motus> * 100],
  <thaumcraft:cloth_boots:*>, // CentralItem
  [<thaumcraft:crystal_essence>.withTag({ Aspects: [{ amount: 1, key: 'aer' }] }), <thaumcraft:crystal_essence>.withTag({ Aspects: [{ amount: 1, key: 'aer' }] }), <thaumcraft:fabric>, <thaumcraft:fabric>, <ore:feather>, <ore:fish>]
);

/*
 ██████╗ ████████╗██╗  ██╗███████╗██████╗
██╔═══██║╚══██╔══╝██║  ██║██╔════╝██╔══██╗
██║   ██║   ██║   ███████║█████╗  ██████╔╝
██║   ██║   ██║   ██╔══██║██╔══╝  ██╔══██╗
╚██████╔╝   ██║   ██║  ██║███████╗██║  ██║
 ╚═════╝    ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
*/

// [Puriflower] - THATS A BOTANIA FLOWER NOT THAUMCRAFT!!!
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:puriflower>);
mods.botania.Apothecary.addRecipe(<thaumadditions:puriflower>,
  [<thaumadditions:dawn_totem>, <thaumcraft:shimmerleaf>, <thaumcraft:vishroom>, <thaumcraft:crystal_essence>.withTag({ Aspects: [{ amount: 1, key: 'herba' }] }), <ore:petalBlue>, <ore:petalLightBlue>, <ore:petalLightBlue>, <ore:petalGreen>, <ore:petalGreen>, <ore:petalLime>]
);

val bookWithAllKnowledge = <thaumadditions:knowledge_tome>.withTag({
  KnowledgeOwner    : 'Thaumaturge Cow',
  KnowledgeTimestamp: '01.01.23',
  Knowledge         : [
    { C: 1 as byte, K: 'BASEGOLEMANCY' },
    { C: 1 as byte, K: 'INFUSIONBOOST' },
    { C: 1 as byte, K: 'MATSTUDCLAY' },
    { C: 1 as byte, K: 'MITHMINITEFABRIC' },
    { C: 1 as byte, K: 'SANESOAP' },
    { C: 1 as byte, K: 'UNLOCKALCHEMY' },
    { C: 1 as byte, K: 'BASEARTIFICE' },
    { C: 1 as byte, K: 'BOOTSTRAVELLER' },
    { C: 1 as byte, K: 'TAINT_MEAT' },
    { C: 1 as byte, K: 'STRIDINGBELT' },
    { C: 1 as byte, K: 'THAUMOSTATIC_GYROSCOPE' },
    { C: 1 as byte, K: 'ARCANEEAR' },
    { C: 1 as byte, K: 'INFUSIONANCIENT' },
    { C: 1 as byte, K: 'TT_ESSENTIA_FUNNEL' },
    { C: 1 as byte, K: 'JARVOID' },
    { C: 1 as byte, K: 'SEALHARVEST' },
    { C: 1 as byte, K: 'MIRROR' },
    { C: 1 as byte, K: 'VOIDPICKAXE' },
    { C: 1 as byte, K: 'VOIDSIPHON' },
    { C: 1 as byte, K: 'ADAMINITE' },
    { C: 1 as byte, K: '!TaintSeed' },
    { C: 1 as byte, K: 'GOLEMLOGISTICS' },
    { C: 1 as byte, K: 'FOCUS_WATER' },
    { C: 1 as byte, K: 'TWOND_COALESCENCE_MATRIX' },
    { C: 1 as byte, K: 'MIRRORHAND' },
    { C: 1 as byte, K: 'TWOND_NV_GOGGLES' },
    { C: 1 as byte, K: 'WARDED_ARCANA' },
    { C: 1 as byte, K: 'VISSCRIBINGTOOLS' },
    { C: 1 as byte, K: 'VOID_RECHARGE_PEDESTAL' },
    { C: 1 as byte, K: 'TCONEVO_PRIMALMETAL' },
    { C: 1 as byte, K: 'PRIMPEARL' },
    { C: 1 as byte, K: 'TWOND_STRUCTURE_DIVINER' },
    { C: 1 as byte, K: 'CHESTER' },
    { C: 1 as byte, K: 'BOOTS' },
    { C: 1 as byte, K: 'MINDBIOTHAUMIC' },
    { C: 1 as byte, K: 'BEHEADER' },
    { C: 1 as byte, K: 'TAR_CRYSTAL_BLOCK' },
    { C: 1 as byte, K: 'VOID_STONE_USAGE' },
    { C: 1 as byte, K: 'FOCUSBOLT' },
    { C: 1 as byte, K: 'INFUSIONENCHANTMENT' },
    { C: 1 as byte, K: 'TT_ENERGETIC_NITOR' },
    { C: 1 as byte, K: 'ELYTRA_HARNESS' },
    { C: 1 as byte, K: 'TT_DISLOCATE' },
    { C: 1 as byte, K: 'TWOND_PANACEA' },
    { C: 1 as byte, K: 'INFERNALFURNACE' },
    { C: 1 as byte, K: 'VOIDAXE' },
    { C: 1 as byte, K: 'FOCUS_SHIELD' },
    { C: 1 as byte, K: 'ESSENTIASMELTER' },
    { C: 1 as byte, K: 'TWOND_VOID_FORTRESS_ARMOR' },
    { C: 1 as byte, K: 'RIFT_FEEDER' },
    { C: 1 as byte, K: 'FOCUSPOUCH' },
    { C: 1 as byte, K: 'DIOPTRA' },
    { C: 1 as byte, K: 'SEALEMPTY' },
    { C: 1 as byte, K: 'VIS_BATTERY_AUGMENT' },
    { C: 1 as byte, K: 'CRYSTALBORE' },
    { C: 1 as byte, K: 'RIFT_MOVING' },
    { C: 1 as byte, K: 'CONTROLSEALS' },
    { C: 1 as byte, K: 'IMPETUS' },
    { C: 1 as byte, K: '!TaintCrawler' },
    { C: 1 as byte, K: 'GOLEMVISION' },
    { C: 1 as byte, K: 'TWOND_PRIMORDIAL_ACCRETION_CHAMBER' },
    { C: 1 as byte, K: '!ThaumSlime' },
    { C: 1 as byte, K: 'SMELTERADAMINITE' },
    { C: 1 as byte, K: 'FOCUSSPELLBAT' },
    { C: 1 as byte, K: 'SEALGUARD' },
    { C: 1 as byte, K: 'RUNICSHIELDING' },
    { C: 1 as byte, K: 'ELDRITCH_SPIRE' },
    { C: 1 as byte, K: 'HUNGRYCHEST' },
    { C: 1 as byte, K: 'MITHMINITESCYTHE' },
    { C: 1 as byte, K: 'CRYSTALWATER' },
    { C: 1 as byte, K: 'INFUSION' },
    { C: 1 as byte, K: 'CURIOSITYBAND' },
    { C: 1 as byte, K: 'SEALBREAK' },
    { C: 1 as byte, K: 'FRAGNANTPENDANT' },
    { C: 1 as byte, K: 'VOIDSHOVEL' },
    { C: 1 as byte, K: 'VISBATTERY' },
    { C: 1 as byte, K: 'SHADOWBEAM' },
    { C: 1 as byte, K: 'CELESTIAL_OBSERVER' },
    { C: 1 as byte, K: 'FOCUSPLAN' },
    { C: 1 as byte, K: 'TWOND_FLUX_DISTILLER' },
    { C: 1 as byte, K: 'JARTHAUMIUM' },
    { C: 1 as byte, K: 'HARNESS_BASE' },
    { C: 1 as byte, K: 'ELEMENTALTOOLS' },
    { C: 1 as byte, K: 'MIA.VOID_CREATOR' },
    { C: 1 as byte, K: 'INFUSIONSTABLE' },
    { C: 1 as byte, K: '!BrainyZombie' },
    { C: 1 as byte, K: 'FOCUSGREATER' },
    { C: 1 as byte, K: 'TT_TRANSVECTOR_INTERFACE' },
    { C: 1 as byte, K: 'TWOND_ALKAHEST' },
    { C: 1 as byte, K: 'BOTTLETAINT' },
    { C: 1 as byte, K: 'CHARMUNDYING' },
    { C: 1 as byte, K: 'JARBRAIN' },
    { C: 1 as byte, K: 'THAUMIUM_ROBES' },
    { C: 1 as byte, K: 'MATSTUDWOOD' },
    { C: 1 as byte, K: 'VOIDSEERPEARL' },
    { C: 1 as byte, K: 'WORKBENCHCHARGER' },
    { C: 1 as byte, K: 'RIFT_STUDIES' },
    { C: 1 as byte, K: 'BASICTURRET' },
    { C: 1 as byte, K: 'TAR_SEAL_SYMBOLS' },
    { C: 1 as byte, K: 'BELT' },
    { C: 1 as byte, K: 'SMELTERMITHMINITE' },
    { C: 1 as byte, K: 'IMPETUS_MIRROR' },
    { C: 1 as byte, K: 'MATSTUDTHAUMIUM' },
    { C: 1 as byte, K: '!Pech' },
    { C: 1 as byte, K: 'IMPROVEDSMELTING2' },
    { C: 1 as byte, K: 'GAUNTLET_THAUMIUM' },
    { C: 1 as byte, K: 'JARMITHRILLIUM' },
    { C: 1 as byte, K: 'CRYSTALBAG' },
    { C: 1 as byte, K: 'AURADISPENSER' },
    { C: 1 as byte, K: 'COMBINER' },
    { C: 1 as byte, K: 'IMPETUS_GATE' },
    { C: 1 as byte, K: 'FOCUSADVANCED' },
    { C: 1 as byte, K: 'FOCUS_WARD' },
    { C: 1 as byte, K: 'SEAL_COPIER' },
    { C: 1 as byte, K: 'TWOND_CATALYZATION_CHAMBER' },
    { C: 1 as byte, K: 'HOOD' },
    { C: 1 as byte, K: 'POTIONSPRAYER' },
    { C: 1 as byte, K: 'MINDCLOCKWORK' },
    { C: 1 as byte, K: 'THAUMATORIUM' },
    { C: 1 as byte, K: 'ACANECAKE' },
    { C: 1 as byte, K: 'TT_BLACK_QUARTZ' },
    { C: 1 as byte, K: 'FOCUSELEMENTAL' },
    { C: 1 as byte, K: 'BASEELDRITCH' },
    { C: 1 as byte, K: 'JARADAMINITE' },
    { C: 1 as byte, K: 'CRYSTALFARMER' },
    { C: 1 as byte, K: 'STARFIELD_GLASS_FRACTURE' },
    { C: 1 as byte, K: 'KNOWLEDGETYPES' },
    { C: 1 as byte, K: 'PRIMORDIAL_WISP' },
    { C: 1 as byte, K: 'JARMITHMINITE' },
    { C: 1 as byte, K: 'FORTIFIED_GLASS' },
    { C: 1 as byte, K: 'TWOND_EVERBURNING_URN' },
    { C: 1 as byte, K: 'TT_THAUMIC_MAGNETS' },
    { C: 1 as byte, K: 'ELDRITCH_EPIPHANY' },
    { C: 1 as byte, K: '!VOIDSTONE' },
    { C: 1 as byte, K: 'PURIFLOWER' },
    { C: 1 as byte, K: 'TWOND_BASE' },
    { C: 1 as byte, K: 'LAMPFERTILITY' },
    { C: 1 as byte, K: 'GOLEMDIRECT' },
    { C: 1 as byte, K: 'CLOUDRING' },
    { C: 1 as byte, K: 'VOIDANVIL' },
    { C: 1 as byte, K: 'ARCANEBORE' },
    { C: 1 as byte, K: 'EXPERIENCE_MODIFIER' },
    { C: 1 as byte, K: 'UNLOCKARTIFICE' },
    { C: 1 as byte, K: 'FOCUSEXCHANGE' },
    { C: 1 as byte, K: '!Wisp' },
    { C: 1 as byte, K: 'TWOND_HEXAMITE' },
    { C: 1 as byte, K: 'TWOND_BONE_BOW' },
    { C: 1 as byte, K: 'FOCUSFLUX' },
    { C: 1 as byte, K: 'FOCUSHEAL' },
    { C: 1 as byte, K: 'VERDANTCHARMS' },
    { C: 1 as byte, K: 'EMPTINESS_MODIFIER' },
    { C: 1 as byte, K: 'ARCANE_TERRAFORMER' },
    { C: 1 as byte, K: 'GOLEMCLIMBER' },
    { C: 1 as byte, K: 'TCONEVO_BASE' },
    { C: 1 as byte, K: 'THAUMOSTATIC_HARNESS' },
    { C: 1 as byte, K: '!TARBlueWolf' },
    { C: 1 as byte, K: 'THEORYRESEARCH' },
    { C: 1 as byte, K: 'SEALSTOCK' },
    { C: 1 as byte, K: 'IMPETUS_MATRIX' },
    { C: 1 as byte, K: 'FOCUSCURSE' },
    { C: 1 as byte, K: 'RIFT_POWER' },
    { C: 1 as byte, K: 'TWOND_MEATY_ORB' },
    { C: 1 as byte, K: 'FLUX' },
    { C: 1 as byte, K: 'ENTERING_FRACTURE' },
    { C: 1 as byte, K: 'MITHMINITE' },
    { C: 1 as byte, K: 'TT_TABLET' },
    { C: 1 as byte, K: 'FOCUSBREAK' },
    { C: 1 as byte, K: 'TWOND_ALIENIST_STONE' },
    { C: 1 as byte, K: 'SEAL' },
    { C: 1 as byte, K: 'SEALCOLLECT' },
    { C: 1 as byte, K: 'CrimsonRites' },
    { C: 1 as byte, K: 'FOCUSPROJECTILE' },
    { C: 1 as byte, K: 'ESSENTIATRANSPORT' },
    { C: 1 as byte, K: 'IMPROVEDSMELTING' },
    { C: 1 as byte, K: 'UNLOCKAUROMANCY' },
    { C: 1 as byte, K: 'TT_SPELLBINDING_CLOTH' },
    { C: 1 as byte, K: 'MORE_AUROMANCY' },
    { C: 1 as byte, K: 'TWOND_VOID_PORTAL' },
    { C: 1 as byte, K: 'TOTEMANCY' },
    { C: 1 as byte, K: '!CrimsonCultist' },
    { C: 1 as byte, K: 'CRYSTALLAMP' },
    { C: 1 as byte, K: 'FIRSTSTEPS' },
    { C: 1 as byte, K: 'MITHRILLIUM' },
    { C: 1 as byte, K: 'TWOND_CLEANSING_CHARM' },
    { C: 1 as byte, K: '!Firebat' },
    { C: 1 as byte, K: 'ESSENTIASMELTERTHAUMIUM' },
    { C: 1 as byte, K: 'MIRRORESSENTIA' },
    { C: 1 as byte, K: 'FLUXCLEANUP' },
    { C: 1 as byte, K: 'TWOND_ORE_DIVINER' },
    { C: 1 as byte, K: 'RIFTCLOSER' },
    { C: 1 as byte, K: 'LAMPGROWTH' },
    { C: 1 as byte, K: 'FOCUSMINE' },
    { C: 1 as byte, K: 'AURACHARGER' },
    { C: 1 as byte, K: 'VOIDHOE' },
    { C: 1 as byte, K: 'SEALBUTCHER' },
    { C: 1 as byte, K: '!TWOND_CORRUPTION_AVATAR' },
    { C: 1 as byte, K: 'SEALUSE' },
    { C: 1 as byte, K: 'SEALSTORE' },
    { C: 1 as byte, K: 'RIFT_MANAGEMENT' },
    { C: 1 as byte, K: 'TWOND_DISJUNCTION_CLOTH' },
    { C: 1 as byte, K: 'UNLOCKINFUSION' },
    { C: 1 as byte, K: 'ARCANESPA' },
    { C: 1 as byte, K: 'BOOTS_VOID' },
    { C: 1 as byte, K: 'TWOND_PRIMORDIAL_ACCELERATOR' },
    { C: 1 as byte, K: 'TWOND_VOID_BEACON' },
    { C: 1 as byte, K: 'GOLEMFLYER' },
    { C: 1 as byte, K: 'PRIMALCRUSHER' },
    { C: 1 as byte, K: 'TWOND_TRANSMUTER_STONE' },
    { C: 1 as byte, K: 'TWOND_METEORB' },
    { C: 1 as byte, K: 'ALUMENTUM' },
    { C: 1 as byte, K: 'TRAVELLERBELT' },
    { C: 1 as byte, K: 'HEDGEALCHEMY' },
    { C: 1 as byte, K: 'TUBES' },
    { C: 1 as byte, K: 'TWOND_LETHE_WATER' },
    { C: 1 as byte, K: 'TT_PRISMARINE' },
    { C: 1 as byte, K: 'ADAMINITESWORD' },
    { C: 1 as byte, K: 'STARFIELD_GLASS_MIRROR' },
    { C: 1 as byte, K: 'IMPULSE_CANNON_AUGMENT_BURST' },
    { C: 1 as byte, K: 'FOCUSANCIENT' },
    { C: 1 as byte, K: 'IMPULSE_CANNON_AUGMENT_RAILGUN' },
    { C: 1 as byte, K: 'REDSTONERELAY' },
    { C: 1 as byte, K: 'WARP' },
    { C: 1 as byte, K: 'SMELTERMITHRILLIUM' },
    { C: 1 as byte, K: 'GRAPPLEGUN' },
    { C: 1 as byte, K: 'PAVINGSTONES' },
    { C: 1 as byte, K: '!EldritchGuardian' },
    { C: 1 as byte, K: 'FORTRESSMASK' },
    { C: 1 as byte, K: 'FOCUSSPLIT' },
    { C: 1 as byte, K: 'ADAMINITEFABRIC' },
    { C: 1 as byte, K: 'EVERFULLURN' },
    { C: 1 as byte, K: 'GROWTHCHAMBER' },
    { C: 1 as byte, K: 'TT_SHARE_TOME' },
    { C: 1 as byte, K: 'PRIMAL_CUTTER' },
    { C: 1 as byte, K: 'ADVANCEDTURRET' },
    { C: 1 as byte, K: 'VOIDTHAUMOMETER' },
    { C: 1 as byte, K: 'TCONEVO_TCONINFUSIONENCH' },
    { C: 1 as byte, K: 'ORE' }, { C: 1 as byte, K: 'FOCUSRIFT' },
    { C: 1 as byte, K: 'AUTOCASTER' },
    { C: 1 as byte, K: 'TT_DISSIMULATION' },
    { C: 1 as byte, K: 'WARD_OPENERS' },
    { C: 1 as byte, K: 'MATSTUDBRASS' },
    { C: 1 as byte, K: 'GAUNTLET_VOID' },
    { C: 1 as byte, K: 'SEAL_SECURE' },
    { C: 1 as byte, K: 'STABILITY_FIELD_GENERATOR' },
    { C: 1 as byte, K: 'UNLOCKELDRITCH' },
    { C: 1 as byte, K: 'MORE_GOLEMANCY' },
    { C: 1 as byte, K: 'ARCANELAMP' },
    { C: 1 as byte, K: 'TWOND_TIMEWINDER' },
    { C: 1 as byte, K: 'BELLOWS' },
    { C: 1 as byte, K: 'MATSTUDIRON' },
    { C: 1 as byte, K: 'ARCANE_DOOR' },
    { C: 1 as byte, K: 'METALLURGY' },
    { C: 1 as byte, K: 'VISSALT' },
    { C: 1 as byte, K: 'BASEINFUSION' },
    { C: 1 as byte, K: 'THAUMIC_AUGMENTATION_BASE' },
    { C: 1 as byte, K: 'TWOND_DIMENSIONAL_RIPPER' },
    { C: 1 as byte, K: 'VOIDROBEARMOR' },
    { C: 1 as byte, K: 'SEALLUMBER' },
    { C: 1 as byte, K: 'GLASS_TUBE' },
    { C: 1 as byte, K: 'VOIDCROP' },
    { C: 1 as byte, K: 'IMPETUS_GENERATOR' },
    { C: 1 as byte, K: '!EldritchCrab' },
    { C: 1 as byte, K: 'TWOND_NETHER_HEDGE' },
    { C: 1 as byte, K: 'CELESTIALSCANNING' },
    { C: 1 as byte, K: 'FOCUSSCATTER' },
    { C: 1 as byte, K: 'MORPHIC_TOOL' },
    { C: 1 as byte, K: 'TT_REPAIRER' },
    { C: 1 as byte, K: 'TWOND_END_HEDGE' },
    { C: 1 as byte, K: 'CLEANSING_AMULET' },
    { C: 1 as byte, K: 'METALPURIFICATION' },
    { C: 1 as byte, K: 'BATHSALTS' },
    { C: 1 as byte, K: 'WARD_KEYS' },
    { C: 1 as byte, K: 'GOLEMBREAKER' },
    { C: 1 as byte, K: 'TT_TELEKENESIS' },
    { C: 1 as byte, K: 'LIQUIDDEATH' },
    { C: 1 as byte, K: 'PURE_TEAR' },
    { C: 1 as byte, K: 'BASEAUROMANCY' },
    { C: 1 as byte, K: 'FOCUSCLOUD' },
    { C: 1 as byte, K: 'VISGENERATOR' },
    { C: 1 as byte, K: 'FLUXRIFT' },
    { C: 1 as byte, K: 'METEORBELT' },
    { C: 1 as byte, K: 'FOCUS_LIGHT' },
    { C: 1 as byte, K: 'MORPHIC_ARMOR' },
    { C: 1 as byte, K: 'TWOND_FLYING_CARPET' },
    { C: 1 as byte, K: 'ROBE' },
    { C: 1 as byte, K: 'SEALPROVIDE' },
    { C: 1 as byte, K: 'WARDEDJARS' },
    { C: 1 as byte, K: 'VISCHARM' },
    { C: 1 as byte, K: 'ELYTRA_BOOSTER' },
    { C: 1 as byte, K: 'ESSENTIAPISTOL' },
    { C: 1 as byte, K: 'RECHARGEPEDESTAL' },
    { C: 1 as byte, K: 'BASEALCHEMY' },
    { C: 1 as byte, K: 'FRENZY_MODIFIER' },
    { C: 1 as byte, K: 'INFUSIONELDRITCH' },
    { C: 1 as byte, K: 'GAUNTLET_AUGMENTATION' },
    { C: 1 as byte, K: 'LEVITATOR' },
    { C: 1 as byte, K: 'TWOND_MADNESS_ENGINE' },
    { C: 1 as byte, K: 'FLUXCONCENTRATOR' },
    { C: 1 as byte, K: 'STARFIELD_GLASS_RIFT' },
    { C: 1 as byte, K: 'VISAMULET' },
    { C: 1 as byte, K: 'TWOND_INSPIRATION_ENGINE' },
    { C: 1 as byte, K: 'TWOND_PRIMAL_DESTROYER' },
    { C: 1 as byte, K: 'CENTRIFUGE' },
    { C: 1 as byte, K: '!Taintacle' },
    { C: 1 as byte, K: 'ARCANEPATTERNCRAFTER' },
    { C: 1 as byte, K: 'SPAWNER' },
    { C: 1 as byte, K: '!TaintSwarm' },
    { C: 1 as byte, K: 'JARBRASS' },
    { C: 1 as byte, K: 'PLANTS' },
    { C: 1 as byte, K: 'VIS_REGENERATOR' },
    { C: 1 as byte, K: 'TWOND_PRIMAL_ARROWS' },
    { C: 1 as byte, K: 'DIMENSIONAL_MODIFIERS' },
    { C: 1 as byte, K: 'FRACTURE_THEORY' },
    { C: 1 as byte, K: 'TWOND_FLUX_CAPACITOR' },
    { C: 1 as byte, K: 'UNLOCKGOLEMANCY' },
    { C: 1 as byte, K: 'MORE_MECHANISMS' },
    { C: 1 as byte, K: 'TT_ENCHANTER' },
    { C: 1 as byte, K: 'SHADOWENCHANTER' },
    { C: 1 as byte, K: 'ARMORFORTRESS' },
    { C: 1 as byte, K: 'IMPULSE_CANNON' },
    { C: 1 as byte, K: 'THAUMOSTATIC_GIRDLE' },
    { C: 1 as byte, K: 'TWOND_MYSTIC_GARDENING' },
    { C: 1 as byte, K: 'SEALGLOBE' },
    { C: 1 as byte, K: 'ESSENTIASMELTERVOID' },
    { C: 1 as byte, K: 'MATSTUDVOID' },
    { C: 1 as byte, K: 'VOIDMIRROR' },
    { C: 1 as byte, K: 'CRYSTALCRUSHER' },
    { C: 1 as byte, K: 'RIFT_MONITOR' },
    { C: 1 as byte, K: 'GOLEMCOMBATADV' },
    { C: 1 as byte, K: 'ITEM_GRATE' },
    { C: 1 as byte, K: 'WARP_PAPER' },
    { C: 1 as byte, K: 'GOD_WRAITH' },
    { C: 1 as byte, K: 'FLUX_STRIKE' },
    { C: 1 as byte, K: 'PURE_SMITE' },
    { C: 1 as byte, K: 'LOOT_STEALER' },
    { C: 1 as byte, K: 'ORE_PURIFIER' },
    { C: 1 as byte, K: 'FIRST_STAND' },
    { C: 1 as byte, K: 'CREATION_PASSIVE_VANILLA' },
    { C: 1 as byte, K: 'CREATION_HOSTILE_VANILLA' },
    { C: 1 as byte, K: 'CREATION_HOSTILE_VANILLA_NETHER' },
    { C: 1 as byte, K: 'CREATION_HOSTILE_VANILLA_END' },
    { C: 1 as byte, K: 'CREATION_HOSTILE_ELEMENTALS' },
  ],
});

// Make sure player getting ALL THE RESEARCH when using Cow written tome
events.onPlayerInteract(function (e as crafttweaker.event.PlayerInteractEvent) {
  if (
    isNull(e)
    || isNull(e.player.world)
    || e.player.world.remote
    || isNull(e.item)
    || e.item.definition.id != 'thaumadditions:knowledge_tome'
    || !e.item.hasTag
    || isNull(e.item.tag.KnowledgeOwner)
    || e.item.tag.KnowledgeOwner.asString() != 'Thaumaturge Cow'
  ) return;

  mods.contenttweaker.Commands.call('/thaumcraft research @p all', e.player, e.player.world, false, true);
});

// [Tome of Sharing] from [Tome of Sharing][+3]
craft.make(bookWithAllKnowledge, ['pretty',
  '▬ § ▬',
  '§ T §',
  'R R R'], {
  '▬': <ore:dragonsteelIngot>, // Dragonsteel Ingot
  '§': scripts.mods.bibliocraft_books.bookWrittenBy_ingr['Cow'], // A book written by a Cow
  'T': <thaumadditions:knowledge_tome>, // Tome of Sharing
  'R': <rats:marbled_cheese_raw>, // Raw Marbled Cheese
});

mods.randomtweaker.thaumadditions.IFluxConcentrator.addRecipes(<thaumcraft:condenser_lattice>, <thaumcraft:condenser_lattice_dirty>);
mods.randomtweaker.thaumadditions.IFluxConcentrator.addRecipes(<thaumadditions:dawn_totem>, <thaumadditions:twilight_totem>);
mods.randomtweaker.thaumadditions.IFluxConcentrator.addRecipes(<ore:stone>, <thaumcraft:taint_rock>);
mods.randomtweaker.thaumadditions.IFluxConcentrator.addRecipes(<ore:dirt>, <thaumcraft:taint_soil>);

# Mithrillium, Adamanite, Mithminite melting and casting
scripts.process.melt(<thaumadditions:mithrillium_nugget>	,<liquid:mithrillium> * 16);
scripts.process.melt(<thaumadditions:mithrillium_ingot>		,<liquid:mithrillium> * 144);
scripts.process.melt(<thaumadditions:mithrillium_plate>		,<liquid:mithrillium> * 144);
scripts.process.melt(<thaumadditions:mithrillium_block>		,<liquid:mithrillium> * 1296);

scripts.process.melt(<thaumadditions:adaminite_nugget>, <liquid:adaminite> * 16);
scripts.process.melt(<thaumadditions:adaminite_ingot>, <liquid:adaminite> * 144);
scripts.process.melt(<thaumadditions:adaminite_plate>, <liquid:adaminite> * 144);
scripts.process.melt(<thaumadditions:adaminite_block>, <liquid:adaminite> * 1296);

scripts.process.melt(<thaumadditions:mithminite_nugget>, <liquid:mithminite> * 16);
scripts.process.melt(<thaumadditions:mithminite_ingot>, <liquid:mithminite> * 144);
scripts.process.melt(<thaumadditions:mithminite_plate>, <liquid:mithminite> * 144);
scripts.process.melt(<thaumadditions:mithminite_block>, <liquid:mithminite> * 1296);

// Mithrillium, Adamanite, Mithminite casting
mods.tconstruct.Casting.addTableRecipe(<thaumadditions:mithrillium_nugget>, <tconstruct:cast_custom:1>, <liquid:mithrillium>, 16, false, 40);
mods.tconstruct.Casting.addTableRecipe(<thaumadditions:mithrillium_ingot>, <tconstruct:cast_custom>, <liquid:mithrillium>, 144, false, 200);
mods.tconstruct.Casting.addTableRecipe(<thaumadditions:mithrillium_plate>, <tconstruct:cast_custom:3>, <liquid:mithrillium>, 144, false, 200);
mods.tconstruct.Casting.addBasinRecipe(<thaumadditions:mithrillium_block>, null, <liquid:mithrillium>, 1296, false, 800);

mods.tconstruct.Casting.addTableRecipe(<thaumadditions:adaminite_nugget>, <tconstruct:cast_custom:1>, <liquid:adaminite>, 16, false, 40);
mods.tconstruct.Casting.addTableRecipe(<thaumadditions:adaminite_ingot>, <tconstruct:cast_custom>, <liquid:adaminite>, 144, false, 200);
mods.tconstruct.Casting.addTableRecipe(<thaumadditions:adaminite_plate>, <tconstruct:cast_custom:3>, <liquid:adaminite>, 144, false, 200);
mods.tconstruct.Casting.addBasinRecipe(<thaumadditions:adaminite_block>, null, <liquid:adaminite>, 1296, false, 800);

mods.tconstruct.Casting.addTableRecipe(<thaumadditions:mithminite_nugget>, <tconstruct:cast_custom:1>, <liquid:mithminite>, 16, false, 40);
mods.tconstruct.Casting.addTableRecipe(<thaumadditions:mithminite_ingot>, <tconstruct:cast_custom>, <liquid:mithminite>, 144, false, 200);
mods.tconstruct.Casting.addTableRecipe(<thaumadditions:mithminite_plate>, <tconstruct:cast_custom:3>, <liquid:mithminite>, 144, false, 200);
mods.tconstruct.Casting.addBasinRecipe(<thaumadditions:mithminite_block>, null, <liquid:mithminite>, 1296, false, 800);

// Mithminite scythe augmentation
<thaumadditions:mithminite_scythe>.removeTooltip('12 Melee Damage');
<thaumadditions:mithminite_scythe>.removeTooltip('14 Ranged Damage');
<thaumadditions:mithminite_scythe>.removeTooltip('.*-.*');
// <thaumadditions:mithminite_scythe>.removeTooltip(".Shimmer.*"); //In case if someone would want to disable Shimmer enchant tooltip, uncommend line on the left

static loreColor as string[string] = {
  aer         : '§eaer§r',
  alienis     : '§5alienis§r',
  alkimia     : '§3alkimia§r',
  amogus      : '§famogus§r',
  aqua        : '§baqua§r',
  auram       : '§dauram§r',
  aversio     : '§caversio§r',
  bestia      : '§6bestia§r',
  caeles      : '§bcaeles§r',
  cognitio    : '§6cognitio§r',
  desiderium  : '§edesiderium§r',
  draco       : '§bdraco§r',
  exanimis    : '§2exanimis§r',
  exitium     : '§7exitium§r',
  fabrico     : '§2fabrico§r',
  fluctus     : '§7fluctus§r',
  gelum       : '§fgelum§r',
  herba       : '§aherba§r',
  humanus     : '§fhumanus§r',
  ignis       : '§cignis§r',
  imperium    : '§6imperium§r',
  infernum    : '§4infernum§r',
  instrumentum: '§9instrumentum§r',
  lux         : '§elux§r',
  machina     : '§7machina§r',
  mana        : '§bmana§r',
  metallum    : '§7metallum§r',
  mortuus     : '§4mortuus§r',
  motus       : '§fmotus§r',
  mythus      : '§emythus§r',
  ordo        : '§fordo§r',
  perditio    : '§8perditio§r',
  permutatio  : '§2permutatio§r',
  potentia    : '§fpotentia§r',
  praecantatio: '§dpraecantatio§r',
  praemunio   : '§3praemunio§r',
  rattus      : '§0rattus§r',
  sanguis     : '§4sanguis§r',
  sensus      : '§asensus§r',
  sonus       : '§6sonus§r',
  spiritus    : '§7spiritus§r',
  tenebrae    : '§0tenebrae§r',
  terra       : '§2terra§r',
  vacuos      : '§8vacuos§r',
  ventus      : '§fventus§r',
  vinculum    : '§6vinculum§r',
  visum       : '§avisum§r',
  victus      : '§cvictus§r',
  volatus     : '§fvolatus§r',
  vitium      : '§5vitium§r',
  vitreus     : '§bvitreus§r',
} as string[string];

static loreUnColor as string[string] = {
  '§eaer§r'         : 'aer',
  '§5alienis§r'     : 'alienis',
  '§3alkimia§r'     : 'alkimia',
  '§famogus§r'      : 'amogus',
  '§baqua§r'        : 'aqua',
  '§dauram§r'       : 'auram',
  '§caversio§r'     : 'aversio',
  '§6bestia§r'      : 'bestia',
  '§bcaeles§r'      : 'caeles',
  '§6cognitio§r'    : 'cognitio',
  '§edesiderium§r'  : 'desiderium',
  '§bdraco§r'       : 'draco',
  '§2exanimis§r'    : 'exanimis',
  '§7exitium§r'     : 'exitium',
  '§2fabrico§r'     : 'fabrico',
  '§7fluctus§r'     : 'fluctus',
  '§fgelum§r'       : 'gelum',
  '§aherba§r'       : 'herba',
  '§fhumanus§r'     : 'humanus',
  '§cignis§r'       : 'ignis',
  '§6imperium§r'    : 'imperium',
  '§4infernum§r'    : 'infernum',
  '§9instrumentum§r': 'instrumentum',
  '§elux§r'         : 'lux',
  '§7machina§r'     : 'machina',
  '§bmana§r'        : 'mana',
  '§7metallum§r'    : 'metallum',
  '§4mortuus§r'     : 'mortuus',
  '§fmotus§r'       : 'motus',
  '§emythus§r'      : 'mythus',
  '§fordo§r'        : 'ordo',
  '§8perditio§r'    : 'perditio',
  '§2permutatio§r'  : 'permutatio',
  '§fpotentia§r'    : 'potentia',
  '§dpraecantatio§r': 'praecantatio',
  '§3praemunio§r'   : 'praemunio',
  '§0rattus§r'      : 'rattus',
  '§4sanguis§r'     : 'sanguis',
  '§asensus§r'      : 'sensus',
  '§6sonus§r'       : 'sonus',
  '§7spiritus§r'    : 'spiritus',
  '§0tenebrae§r'    : 'tenebrae',
  '§2terra§r'       : 'terra',
  '§8vacuos§r'      : 'vacuos',
  '§fventus§r'      : 'ventus',
  '§6vinculum§r'    : 'vinculum',
  '§avisum§r'       : 'visum',
  '§cvictus§r'      : 'victus',
  '§fvolatus§r'     : 'volatus',
  '§5vitium§r'      : 'vitium',
  '§bvitreus§r'     : 'vitreus',
} as string[string];

static rgbAspect as int[][string] = {
  '0': [0, 0, 0], // BLACK
  '1': [0, 0, 170], // DARKBLUE
  '2': [0, 170, 0], // DARKGREEN
  '3': [0, 170, 170], // DARKAQUA
  '4': [170, 0, 0], // DARKRED
  '5': [170, 0, 170], // DARKPURPLE
  '6': [255, 170, 0], // GOLD
  '7': [170, 170, 170], // GRAY
  '8': [85, 85, 85], // DARKGRAY
  '9': [85, 85, 255], // BLUE
  'a': [85, 255, 85], // GREEN
  'b': [85, 255, 255], // AQUA
  'c': [255, 85, 85], // RED
  'd': [255, 85, 255], // LIGHTPURPLE
  'e': [255, 255, 85], // YELLOW
  'f': [255, 255, 255], // WHITE
} as int[][string];

function calcColor(lore as IData) as int {
  val l = lore.length;
  var r = 0;
  var g = 0;
  var b = 0;
  for i in 0 .. l - 1 {
    val rgb = rgbAspect[lore[i][1]];
    r += rgb[0];
    g += rgb[1];
    b += rgb[2];
  }
  return r / l * 65536 + g / l * 256 + b / l;
}

function haveLoremError(lorem as IData) as bool{
  if(lorem.length==0) return false;
  
  for i in 0 .. lorem.length{
    if(!(loreUnColor has lorem[i])) return true;
  }

  return false;
}

recipes.addShapeless('augmentMithminiteScythe', <thaumadditions:mithminite_scythe>,
  [<thaumadditions:mithminite_scythe>.marked('scythe'), <thaumadditions:seal_symbol>.marked('seal')],
  function (out, ins, cInfo) {
  val scythe = ins.scythe;
    val lorem as IData = (isNull(scythe.tag) || isNull(scythe.tag.display) || isNull(scythe.tag.display.Lore)) ? [] : scythe.tag.display.Lore;
    if(haveLoremError(lorem)) return <thaumadditions:mithminite_scythe>;
    if (lorem.length > 7 || lorem has loreColor[ins.seal.tag.Aspect]) return null;

    var newTag = scythe.tag;

    newTag = newTag.deepUpdate({ display: { Lore: [loreColor[ins.seal.tag.Aspect]] } }, APPEND)                             //Add aspect lore
    .deepUpdate({ enchantmentColor: calcColor(lorem + [loreColor[ins.seal.tag.Aspect]]) }, {enchantmentColor: OVERWRITE});  //Update enchantment color
    
    if(lorem.length == 0) newTag += { ench: [{ lvl: 1 as short, id: 30 as short }] };                                       //Add Shimmer

    return scythe.withTag(newTag);

  },
  null);

//#################################################################################

function removeOnlyShimmer(data as IData) as IData{
  var result as IData = [];
    for i in 0 .. data.length{
    if(data[i].id!=30){
      result = result + [data[i]] as IData;
    }
  }
  return result;
}

recipes.addShapeless('REMOVEaugmentMithminiteScythe', <thaumadditions:seal_symbol>,
  [<thaumadditions:mithminite_scythe>
    .transformNew(
      function (item) {
        val lore = item.tag.display.Lore;
        if(haveLoremError(lore)) return <thaumadditions:mithminite_scythe>;
        var newTag = item.tag;

        if(lore.length == 1){
          newTag = newTag.deepUpdate({ display: { Lore: [lore[lore.length - 1]] } }, { display: { Lore: REMOVE } })
          .deepUpdate({ enchantmentColor: 0 }, REMOVE);
          if(newTag.ench.length==1)
          {newTag -= {ench: []};}
          else
          {newTag = newTag.deepUpdate({ench: removeOnlyShimmer(newTag.ench)},{ench: OVERWRITE});}
        } else {
          newTag = newTag.deepUpdate({ display: { Lore: lore.deepUpdate([lore[lore.length - 1]], REMOVE) } }, { display: { Lore: OVERWRITE } })
          .deepUpdate({ enchantmentColor: calcColor(lore.deepUpdate([lore[lore.length - 1]], REMOVE)) },{enchantmentColor: OVERWRITE});
        }

        return item.withTag(newTag);

      })
    .marked('scythe'),
  ]
  , function (out, ins, cInfo) {
  val scythe = ins.scythe;
    if (isNull(scythe) || isNull(scythe.tag) || isNull(scythe.tag.display) || isNull(scythe.tag.display.Lore)) {
      return null;
    }
    val lore = scythe.tag.display.Lore;
    val index = lore.length;
    if (index == 0) return null;

    val aspectWithColor = lore[index - 1];
    val aspect = loreUnColor[aspectWithColor];

    return out.withTag({ Aspect: aspect });
  }
  , null);

// Mithminite scythe hints
scripts.jei.crafting_hints.add1to1(<ore:listAllmeatraw>, <contenttweaker:protein_pill>, <thaumadditions:mithminite_scythe>.withLore(['§2fabrico§r']));
scripts.jei.crafting_hints.add1to1(<ore:listAllfruit>, <contenttweaker:fruit_pill>, <thaumadditions:mithminite_scythe>.withLore(['§2fabrico§r']));
scripts.jei.crafting_hints.add1to1(<ore:listAllgrain>, <contenttweaker:grain_pill>, <thaumadditions:mithminite_scythe>.withLore(['§2fabrico§r']));
scripts.jei.crafting_hints.add1to1(<ore:listAllveggie>, <contenttweaker:vegetable_pill>, <thaumadditions:mithminite_scythe>.withLore(['§2fabrico§r']));
scripts.jei.crafting_hints.add1to1(<ore:foodCheese>, <contenttweaker:dairy_pill>, <thaumadditions:mithminite_scythe>.withLore(['§2fabrico§r']));

scripts.jei.crafting_hints.add1to1(<entity:thaumcraft:golem>.asIngr(), null, <thaumadditions:mithminite_scythe>.withLore(['§7machina§r']));

scripts.jei.crafting_hints.add1to1(<entity:minecraft:zombie_villager>.asIngr(), <entity:minecraft:villager>.asStack(), <thaumadditions:mithminite_scythe>.withLore(['§fhumanus§r']));

scripts.jei.crafting_hints.addInsOutCatl([<minecraft:arrow>, <minecraft:fire_charge>], null, <thaumadditions:mithminite_scythe>.withLore(['§2permutatio§r']));

scripts.jei.crafting_hints.add1to1(<entity:minecraft:cow>.asIngr() | <entity:minecraft:chicken>.asIngr() | <entity:minecraft:sheep>.asIngr() | <entity:minecraft:pig>.asIngr(), null, <thaumadditions:mithminite_scythe>.withLore(['§cvictus§r']));


// [Adaminite armor set]
mods.thaumcraft.ArcaneWorkbench.removeRecipe(<thaumadditions:adaminite_hood>);
mods.thaumcraft.Infusion.registerRecipe(
  'adaminite_hood', // Name
  'ADAMINITEFABRIC', // Research
  <thaumadditions:adaminite_hood>, // Output
  6, // Instability
  [<aspect:infernum> * 100, <aspect:sanguis> * 100, <aspect:spiritus> * 50],
  <thaumcraft:void_robe_helm:*>, // CentralItem
  [<thaumicwonders:void_fortress_helm:*>, <bloodmagic:item_demon_crystal>, <bloodmagic:slate:3>, <thaumadditions:adaminite_fabric>, <thaumadditions:adaminite_fabric>, <thaumadditions:adaminite_fabric>]
);
mods.thaumcraft.ArcaneWorkbench.removeRecipe(<thaumadditions:adaminite_robe>);
mods.thaumcraft.Infusion.registerRecipe(
  'adaminite_robe', // Name
  'ADAMINITEFABRIC', // Research
  <thaumadditions:adaminite_robe>, // Output
  6, // Instability
  [<aspect:infernum> * 100, <aspect:sanguis> * 100, <aspect:mortuus> * 50],
  <thaumcraft:void_robe_chest:*>, // CentralItem
  [<thaumicwonders:void_fortress_chest:*>, <bloodmagic:item_demon_crystal>, <bloodmagic:slate:3>, <thaumadditions:adaminite_fabric>, <thaumadditions:adaminite_fabric>, <thaumadditions:adaminite_fabric>, <thaumadditions:adaminite_fabric>]
);
mods.thaumcraft.ArcaneWorkbench.removeRecipe(<thaumadditions:adaminite_belt>);
mods.thaumcraft.Infusion.registerRecipe(
  'adaminite_belt', // Name
  'ADAMINITEFABRIC', // Research
  <thaumadditions:adaminite_belt>, // Output
  6, // Instability
  [<aspect:infernum> * 100, <aspect:sanguis> * 100, <aspect:ordo> * 50],
  <thaumcraft:void_robe_legs:*>, // CentralItem
  [<thaumicwonders:void_fortress_legs:*>, <bloodmagic:item_demon_crystal>, <bloodmagic:slate:3>, <thaumadditions:adaminite_fabric>, <thaumadditions:adaminite_fabric>, <thaumadditions:adaminite_fabric>]
);
mods.thaumcraft.ArcaneWorkbench.removeRecipe(<thaumadditions:adaminite_boots>);
mods.thaumcraft.Infusion.registerRecipe(
  'adaminite_boots', // Name
  'ADAMINITEFABRIC', // Research
  <thaumadditions:adaminite_boots>, // Output
  6, // Instability
  [<aspect:infernum> * 100, <aspect:sanguis> * 100, <aspect:motus> * 50],
  <thaumicaugmentation:void_boots:*>, // CentralItem
  [<thaumcraft:void_boots:*>, <bloodmagic:item_demon_crystal>, <bloodmagic:slate:3>, <thaumadditions:adaminite_fabric>, <thaumadditions:adaminite_fabric>]
);

function makeArmor(
  name as string,
  research as string,
  armor as IItemStack,
  aspects as thaumcraft.aspect.CTAspectStack[],
  central as IIngredient,
  ingrs as IIngredient[]
) as void {
  armor.addEnchantment(<enchantment:advancedrocketry:spacebreathing>.makeEnchantment(1));
  mods.thaumcraft.Infusion.registerRecipe(name, research, armor, 10, aspects, central, ingrs);
}

//
mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:mithminite_hood>);
makeArmor(
  'mithminite_hood', // Name
  'HOOD', // Research
  <thaumadditions:mithminite_hood>, // Output
  [
    <aspect:caeles> * 100,
    <aspect:praemunio> * 50,
    <aspect:visum> * 200,
    <aspect:sensus> * 200,
    <aspect:amogus> * 42,
  ],
  <thaumadditions:adaminite_hood:*>, // CentralItem
  [
    <thaumcraft:sanity_checker>,
    <thaumadditions:zeith_fur>,
    <thaumadditions:mithminite_fabric>,
    <thaumadditions:mithminite_fabric>,
    <thaumadditions:mithminite_fabric>,
    <thaumadditions:zeith_fur>,
    <thaumadditions:fragnant_pendant>,
    <thaumadditions:seal_globe>,
  ]);

mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:mithminite_robe>);
makeArmor(
  'mithminite_robe', // Name
  'ROBE', // Research
  <thaumadditions:mithminite_robe>.withTag({ air: 36000 }),
  [
    <aspect:caeles> * 100,
    <aspect:praemunio> * 50,
    <aspect:victus> * 200,
    <aspect:draco> * 200,
    <aspect:amogus> * 42,
  ],
  <thaumadditions:adaminite_robe:*>, // CentralItem
  [
    <thaumadditions:mithminite_fabric>,
    <thaumadditions:zeith_fur>,
    <thaumadditions:mithminite_fabric>,
    <thaumicaugmentation:thaumostatic_harness:*>,
    <thaumadditions:mithminite_fabric>,
    <thaumadditions:zeith_fur>,
    <thaumadditions:mithminite_fabric>,
    <thaumicwonders:panacea:1>,
  ]);

mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:mithminite_belt>);
makeArmor(
  'mithminite_belt', // Name
  'BELT', // Research
  <thaumadditions:mithminite_belt>, // Output
  [
    <aspect:caeles> * 100,
    <aspect:praemunio> * 50,
    <aspect:volatus> * 200,
    <aspect:ventus> * 200,
    <aspect:amogus> * 42,
  ],
  <thaumadditions:adaminite_belt:*>, // CentralItem
  [
    <thaumadditions:mithminite_fabric>,
    <thaumadditions:zeith_fur>,
    <thaumadditions:mithminite_fabric>,
    <thaumicwonders:flying_carpet:*>,
    <thaumadditions:mithminite_fabric>,
    <thaumadditions:zeith_fur>,
  ]);

mods.thaumcraft.Infusion.removeRecipe(<thaumadditions:mithminite_boots>);
makeArmor(
  'mithminite_boots', // Name
  'BOOTS', // Research
  <thaumadditions:mithminite_boots>, // Output
  [
    <aspect:caeles> * 100,
    <aspect:praemunio> * 50,
    <aspect:sonus> * 200,
    <aspect:exitium> * 200,
    <aspect:amogus> * 42,
  ],
  <thaumadditions:adaminite_boots:*>, // CentralItem
  [
    <thaumadditions:mithminite_fabric>,
    <thaumadditions:zeith_fur>,
    <thaumadditions:zeith_fur>,
    <thaumadditions:mithminite_fabric>,
    <thaumicaugmentation:research_notes>,
  ]);
