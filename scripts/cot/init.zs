#loader contenttweaker
#priority 9000

import mods.contenttweaker.AxisAlignedBB;
import mods.contenttweaker.BlockMaterial;
import mods.contenttweaker.Color;
import mods.contenttweaker.Item;
import mods.contenttweaker.ItemFood;
import mods.contenttweaker.MaterialSystem;
import mods.contenttweaker.SoundType;
import mods.contenttweaker.VanillaFactory;
import crafttweaker.block.IBlockState;
import crafttweaker.world.IBlockPos;
import mods.contenttweaker.BlockPos;
import mods.contenttweaker.World;

mods.contenttweaker.VanillaFactory.createCreativeTab('other', <item:minecraft:coal:1>).register();

function createBlock(name as string, level as int, blockMaterial as BlockMaterial, blockSoundType as SoundType, lightValue as int = 0) as void {
  val c = VanillaFactory.createBlock(name, blockMaterial);
  c.toolClass = 'pickaxe';
  c.toolLevel = level;
  c.blockHardness = level * 1.6;
  c.blockResistance = level * 1.4;
  c.blockSoundType = blockSoundType;
  c.lightValue = (lightValue as double / 15.0 + 0.00001) as int;
  c.register();
}

function createBlockStone(name as string, level as int, blockMaterial as BlockMaterial) {
  createBlock(name, level, blockMaterial, <soundtype:stone>);
}

function buildItem(name as string) {
  val item = VanillaFactory.createExpandItem(name);
  item.setCreativeTab(<creativetab:other>);
  item.register();
}

/** Crafting Materials **/
for craftMat in [

  // TCon core ingredient
  'supremium_helmet_base',
  'supremium_chest_base',
  'supremium_leggings_base',
  'supremium_boots_base',

  // Compressed mekanism items
  'compressed_glowstone',
  'compressed_ender',
  'compressed_dimensional',

] as string[] {
  buildItem(craftMat);
}

// --------------------------------------------------------------------
// Singularities
// --------------------------------------------------------------------
function buildSingularity(id as string, ore as string, charge as int = 30000, glowing as bool = false) as void {
  val x = VanillaFactory.createExpandItem(`${id}_singularity`);
  x.creativeTab = <creativetab:other>;
  x.maxDamage = 30000;
  x.noRepair = true;
  x.glowing = glowing;
  x.register();

  scripts.cot.def.Op.singularIDs.add(id);
  scripts.cot.def.Op.singularOres.add(ore);
  scripts.cot.def.Op.singularCharges.add(charge);
}

buildSingularity('woodweave', 'plankFireproof', 30000);
buildSingularity('fish', 'listAllfishraw', 3000);
buildSingularity('ball', 'itemBall', 2000000000);
buildSingularity('meat', 'listAllmeatraw', 300000);
buildSingularity('garbage', 'garbage', 10000);
buildSingularity('machine_case', 'machineCase', 20000000);
buildSingularity('ultimate', 'singularity', 400000, true);
// --------------------------------------------------------------------

createBlockStone('compressed_skystone', 6, <blockmaterial:rock>);
createBlockStone('compressed_andesite', 4, <blockmaterial:rock>);
createBlockStone('compressed_diorite', 4, <blockmaterial:rock>);
createBlockStone('compressed_granite', 4, <blockmaterial:rock>);
createBlockStone('compressed_garbage_pile', 4, <blockmaterial:rock>);

createBlockStone('compressed_crushed_skystone', 5, <blockmaterial:rock>);
createBlockStone('compressed_crushed_andesite', 3, <blockmaterial:rock>);
createBlockStone('compressed_crushed_diorite', 3, <blockmaterial:rock>);
createBlockStone('compressed_crushed_granite', 3, <blockmaterial:rock>);
createBlockStone('compressed_dried_sand', 3, <blockmaterial:rock>);
createBlockStone('compressed_gravisand', 5, <blockmaterial:rock>);
createBlockStone('compressed_red_sand', 3, <blockmaterial:rock>);
createBlockStone('compressed_white_sand', 3, <blockmaterial:rock>);
createBlockStone('block_sulfur', 2, <blockmaterial:sand>);
createBlockStone('compressed_block_sulfur', 3, <blockmaterial:sand>);
createBlockStone('compressed_pumpkin', 3, <blockmaterial:cactus>);
createBlockStone('compressed_pumpkin_double', 4, <blockmaterial:cactus>);
createBlockStone('compressed_string', 2, <blockmaterial:cloth>);
createBlockStone('compressed_string_double', 3, <blockmaterial:cloth>);
createBlockStone('compressed_basalt', 3, <blockmaterial:rock>);
createBlockStone('compressed_basalt_double', 5, <blockmaterial:rock>);

createBlockStone('terrestrial_artifact_block', 9, <blockmaterial:rock>);
createBlockStone('silicon_block', 4, <blockmaterial:rock>);

val gemABB = AxisAlignedBB.create(0.3, 0, 0.3, 0.7, 0.9, 0.7);
var b = VanillaFactory.createBlock('anglesite', <blockmaterial:glass>);
b.toolClass = 'pickaxe';
b.toolLevel = 10;
b.blockHardness = 16;
b.blockResistance = 14;
b.blockSoundType = <soundtype:glass>;
b.lightValue = 1;
b.axisAlignedBB = gemABB;
b.entitySpawnable = false;
b.fullBlock = false;
b.lightOpacity = 27;
b.translucent = true;
b.register();

b = VanillaFactory.createBlock('benitoite', <blockmaterial:glass>);
b.toolClass = 'pickaxe';
b.toolLevel = 10;
b.blockHardness = 16;
b.blockResistance = 14;
b.blockSoundType = <soundtype:glass>;
b.lightValue = 1;
b.axisAlignedBB = gemABB;
b.entitySpawnable = false;
b.fullBlock = false;
b.lightOpacity = 27;
b.translucent = true;
b.register();

b = VanillaFactory.createBlock('ore_anglesite', <blockmaterial:rock>);
b.toolClass = 'pickaxe';
b.toolLevel = 11;
b.blockHardness = 20;
b.blockResistance = 18;
b.blockSoundType = <soundtype:stone>;
b.lightValue = 14.0 / 15.0 + 0.00001;
b.register();

b = VanillaFactory.createBlock('ore_benitoite', <blockmaterial:rock>);
b.toolClass = 'pickaxe';
b.toolLevel = 11;
b.blockHardness = 20;
b.blockResistance = 18;
b.blockSoundType = <soundtype:stone>;
b.lightValue = 14.0 / 15.0 + 0.00001;
b.register();

b = VanillaFactory.createBlock('compressed_coral', <blockmaterial:rock>);
b.toolClass = 'pickaxe';
b.toolLevel = 3;
b.blockHardness = 3 * 1.6;
b.blockResistance = 3 * 1.4;
b.blockSoundType = <soundtype:stone>;
b.lightValue = (4.0 / 15.0 + 0.00001) as int;
b.register();

// -------------------------------
// Molten Cheese
// -------------------------------
val moltenCheese = MaterialSystem
  .getMaterialBuilder()
  .setName('Cheese')
  .setColor(Color.fromHex('FEE66F'))
  .build()
  .registerPart('molten')
  .getData();
moltenCheese.addDataValue('temperature', '300');
moltenCheese.addDataValue('density', '1004');
moltenCheese.addDataValue('viscosity', '2000');

// -------------------------------
// Seed
// -------------------------------
val seed_fluid = VanillaFactory.createFluid('seed', 0xFFE3D7C8);
seed_fluid.material = <blockmaterial:water>;
seed_fluid.density = 2009;
seed_fluid.viscosity = 3000;
seed_fluid.temperature = 290;
seed_fluid.stillLocation = 'contenttweaker:fluids/fluid';
seed_fluid.flowingLocation = 'contenttweaker:fluids/fluid_flowing';
seed_fluid.register();

// -------------------------------
// Animal's blocks
// -------------------------------
createBlock('conglomerate_of_coal', 5, <blockmaterial:clay>, <soundtype:ground>);

b = VanillaFactory.createBlock('conglomerate_of_life', <blockmaterial:clay>);
b.toolClass = 'shovel';
b.toolLevel = 3;
b.blockHardness = 3 * 1.6;
b.blockResistance = 3 * 1.4;
b.blockSoundType = <soundtype:ground>;
b.lightValue = (3.0 / 15.0 + 0.00001) as int;
b.register();

b = VanillaFactory.createBlock('conglomerate_of_sun', <blockmaterial:clay>);
b.toolClass = 'shovel';
b.toolLevel = 5;
b.blockHardness = 5 * 1.6;
b.blockResistance = 5 * 1.4;
b.blockSoundType = <soundtype:ground>;
b.lightValue = (3.0 / 15.0 + 0.00001) as int;
b.register();

// -------------------------------
// Animal's items
// -------------------------------
buildItem('empowered_phosphor');
buildItem('saturated_phosphor');
buildItem('blasted_coal');

// -------------------------------
// Nutrition pills
// -------------------------------
function createPill(name as string) {
  val pill = VanillaFactory.createItemFood(name, 50);
  pill.saturation = 0.0f;
  pill.alwaysEdible = true;
  pill.register();
}

createPill('dairy_pill');
createPill('fruit_pill');
createPill('grain_pill');
createPill('protein_pill');
createPill('vegetable_pill');

// -------------------------------
// Other
// -------------------------------
buildItem('any_different_item');
buildItem('any_burnable');
buildItem('ore_phosphor');
buildItem('nugget_phosphor');
buildItem('dust_tiny_gold');
buildItem('dust_tiny_silver');
buildItem('compressed_tallow');

var x = VanillaFactory.createExpandItem('bee_diversity');
x.setCreativeTab(<creativetab:other>);
x.rarity = 'rare';
x.register();

val molten_spectre = VanillaFactory.createFluid('spectre', 0xFF9CC1CE);
molten_spectre.material = <blockmaterial:water>;
molten_spectre.viscosity = 3000;
molten_spectre.density = 6500;
// molten_spectre.colorize = true;
molten_spectre.temperature = 400;
molten_spectre.luminosity = 10;
molten_spectre.color = 0x9CC1CE;
molten_spectre.colorize = true;
// molten_spectre.stillLocation = "base:fluids/molten";
// molten_spectre.flowingLocation = "base:fluids/molten_flowing";
molten_spectre.register();

// -------------------------------
// perfect_fuel
// -------------------------------
val perfect_fuel = VanillaFactory.createFluid('perfect_fuel', 0xFFFFCC00);
perfect_fuel.material = <blockmaterial:lava>;
perfect_fuel.luminosity = 15;
perfect_fuel.viscosity = 8000;
perfect_fuel.temperature = 10000;
perfect_fuel.stillLocation = 'contenttweaker:fluids/fluid';
perfect_fuel.flowingLocation = 'contenttweaker:fluids/fluid_flowing';
perfect_fuel.register();

// -------------------------------
// Knowledge Absorber
// -------------------------------
x = VanillaFactory.createExpandItem('knowledge_absorber');
x.maxStackSize = 1;
x.rarity = 'rare';
x.maxDamage = 9;
x.glowing = true;
x.register();

// -------------------------------
// electronics
// -------------------------------
var f = VanillaFactory.createFluid('electronics', 0xFF0A1410);
f.material = <blockmaterial:lava>;
f.viscosity = 8000;
f.temperature = 2000;
f.colorize = true;
f.stillLocation = 'base:fluids/molten';
f.flowingLocation = 'base:fluids/molten_flowing';
f.register();

// -------------------------------
// terrestrial
// -------------------------------
f = VanillaFactory.createFluid('terrestrial', 0xFFDB0F53);
f.material = <blockmaterial:lava>;
f.viscosity = 8000;
f.temperature = 8000;
f.colorize = true;
f.stillLocation = 'base:fluids/molten';
f.flowingLocation = 'base:fluids/molten_flowing';
f.register();

// -------------------------------
// mithrillium
// -------------------------------
val mr = VanillaFactory.createFluid('mithrillium', Color.fromHex('2B86FC'));
mr.material = <blockmaterial:lava>;
mr.viscosity = 2000;
mr.temperature = 6000;
mr.colorize = true;
mr.luminosity = 7;
mr.stillLocation = 'astralsorcery:blocks/fluid/starlight_still';
mr.flowingLocation = 'astralsorcery:blocks/fluid/starlight_flow';
mr.register();

// -------------------------------
// adaminite
// -------------------------------
val ada = VanillaFactory.createFluid('adaminite', Color.fromHex('AA002D'));
ada.material = <blockmaterial:lava>;
ada.viscosity = 4000;
ada.temperature = 7000;
ada.colorize = true;
ada.luminosity = 3;
ada.stillLocation = 'astralsorcery:blocks/fluid/starlight_still';
ada.flowingLocation = 'astralsorcery:blocks/fluid/starlight_flow';
ada.register();

// -------------------------------
// mithminite
// -------------------------------
val mm = VanillaFactory.createFluid('mithminite', Color.fromHex('ff80b7'));
mm.material = <blockmaterial:lava>;
mm.viscosity = 2000;
mm.temperature = 8000;
mm.colorize = true;
mm.luminosity = 10;
mm.stillLocation = 'astralsorcery:blocks/fluid/starlight_still';
mm.flowingLocation = 'astralsorcery:blocks/fluid/starlight_flow';
mm.register();

// -------------------------------
// Tile Entities
// -------------------------------


// Tile Entity that replace itselt with Bedrock Ore
// to create Bedrock Ores using block string ID instead of numericalID
var te = VanillaFactory.createActualTileEntity(1);
te.register();

var exBlock = VanillaFactory.createExpandBlock('bedrockore', <blockmaterial:rock>);
exBlock.tileEntity = te;
exBlock.blockHardness = -1.00;
exBlock.blockResistance = 18000000.00;
exBlock.register();

// -------------------------------
// New Coins
// -------------------------------

mods.contenttweaker.VanillaFactory.createCreativeTab('coins_tab', <item:thermalfoundation:coin:64>).register();

function buildCoin(name as string, glowing as bool = false) {
  val item = VanillaFactory.createExpandItem(`coin_${name}`) as Item;
  item.setCreativeTab(<creativetab:coins_tab>);
  item.glowing = glowing;
  item.textureLocation = mods.contenttweaker.ResourceLocation.create(`contenttweaker:items/coin/${name}`);
  item.register();
}

function buildFoodyCoin(name as string, foodValue as int, foodSaturation as float) {
  val item = VanillaFactory.createItemFood(`coin_${name}`, foodValue) as ItemFood;
  item.setCreativeTab(<creativetab:coins_tab>);
  item.textureLocation = mods.contenttweaker.ResourceLocation.create(`contenttweaker:items/coin/${name}`);
  item.saturation = foodSaturation;
  item.register();
}

buildCoin('adaminite');
buildCoin('advancedalloy');
buildCoin('alchemicalbrass');
buildCoin('aluminumbrass');
buildCoin('alumite');
buildCoin('awakeneddraconium');
buildCoin('baseessence');
buildCoin('beryllium');
buildCoin('blackiron');
buildCoin('bloodglitchinfused');
buildCoin('bound');
buildCoin('calcium');
buildCoin('chaoticmetal');
buildCoin('chromium');
buildCoin('conductiveiron');
buildCoin('cookedmeat');
buildCoin('crystallinealloy');
buildCoin('crystallinepinkslimealloy');
buildCoin('crystalmatrix');
buildCoin('crystaltine');
buildCoin('darksteel');
buildCoin('demonmetal');
buildFoodyCoin('doublesmore', 6, 9.6);
buildCoin('draconicmetal');
buildCoin('ebonypsimetal');
buildCoin('electricalsteel');
buildCoin('elektron60');
buildCoin('elementium');
buildCoin('enchantedmetal');
buildCoin('ender');
buildCoin('endorium');
buildCoin('endsteel');
buildCoin('energium');
buildCoin('energizedalloy');
buildCoin('enhancedender', true);
buildCoin('essenceinfused');
buildCoin('evilinfusedmetal');
buildCoin('extremealloy');
buildCoin('fakeiron');
buildCoin('ferroboron');
buildCoin('fierymetal');
buildCoin('firedragonsteel');
buildCoin('fluixsteel');
buildCoin('fluxedelectrum');
buildFoodyCoin('foursmore', 12, 47.45);
buildCoin('gaiaspirit');
buildCoin('glitchinfused');
buildCoin('glowstone');
buildCoin('graphite');
buildCoin('hafnium');
buildCoin('hardcarbon');
buildCoin('heavymetal');
buildCoin('hopgraphite');
buildCoin('hslasteel');
buildCoin('icedragonsteel');
buildCoin('inferium');
buildCoin('infinity', true);
buildCoin('insanium');
buildCoin('intermedium');
buildCoin('ironwood');
buildCoin('ivorypsimetal');
buildCoin('knightmetal');
buildCoin('knightslime');
buildCoin('lithiummanganesedioxide');
buildCoin('magnesiumdiboride');
buildCoin('manasteel');
buildCoin('manganese');
buildCoin('manganesedioxide');
buildCoin('manganeseoxide');
buildCoin('manyullyn');
buildCoin('melodicalloy');
buildCoin('mirion');
buildCoin('mithminite');
buildCoin('mithrillium');
buildCoin('neodymium');
buildCoin('neutronium');
buildCoin('nichrome');
buildCoin('niobium');
buildCoin('niobiumtin');
buildCoin('niobiumtitanium');
buildCoin('osgloglas');
buildCoin('osmiridium');
buildCoin('pigiron');
buildCoin('pinkmetal');
buildCoin('potassium');
buildCoin('primalmetal');
buildCoin('prudentium');
buildCoin('psimetal');
buildCoin('pulsatingiron');
buildCoin('redstonealloy');
buildCoin('refinedobsidian');
buildCoin('sentient');
buildFoodyCoin('smore', 4, 3);
buildCoin('sodium');
buildCoin('soularium');
buildCoin('soulium');
buildCoin('spectre');
buildCoin('stainlesssteel');
buildCoin('stellaralloy');
buildCoin('strontium');
buildCoin('superalloy');
buildCoin('superium');
buildCoin('supremium');
buildCoin('terrasteel');
buildCoin('titaniumaluminide');
buildCoin('titaniumiridium');
buildCoin('thaumium');
buildCoin('thermoconductingalloy');
buildCoin('toughalloy');
buildCoin('tungstencarbide');
buildCoin('ultimate', true);
buildCoin('unstable');
buildCoin('uumetal');
buildCoin('vibrantalloy');
buildCoin('voidmetal');
buildCoin('vividalloy');
buildCoin('wyvernmetal');
buildCoin('yttrium');
buildCoin('zinc');
buildCoin('zircaloy');
buildCoin('zirconium');
buildCoin('zirconiummolybdenum');
