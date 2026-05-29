#modloaded requious
#priority -150
#ignoreBracketErrors

import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.world.IVector3d.create as V;
import mods.requious.AssemblyRecipe;
import mods.requious.Color;
import mods.requious.ComponentFace;
import mods.requious.GaugeDirection;
import mods.requious.MachineVisual;
import mods.requious.RecipeContainer;
import mods.requious.SlotVisual;

static MULTIPLIER as int = 3;

// [Infinity_Furnace] from [Infinity_Fuel][+4]
craft.remake(<requious:infinity_furnace>, ['pretty',
  'T R E R T',
  '# ▬ n ▬ #',
  'H r I r H',
  '# ▬ Ϟ ▬ #',
  'T R E R T'], {
  'R': <rats:rat_upgrade_basic_ratlantean>,
  '#': <ore:logSequoia>,                          // Sequoia
  'T': <mysticalagriculture:supremium_furnace>,
  'E': <contenttweaker:empowered_phosphor>,       // Empowered Phosphor
  'r': <rats:idol_of_ratlantis>,
  'H': <scalinghealth:heartcontainer>,            // Heart Container
  'I': <avaritia:singularity:12>,
  '▬': <ore:dragonsteelIngot>,
  'n': <randomthings:spectrecoil_ender>,          // Ender Spectre Coil
  'Ϟ': <randomthings:spectreenergyinjector>,       // Spectre Energy Injector
});

// -----------------------------------------------------------------------
// -----------------------------------------------------------------------

val o = <assembly:infinity_furnace>;
static inpX as int = 3; static inpY as int = 2;
o.setItemSlot(inpX,inpY,ComponentFace.all(),64).setAccess(true,false).setGroup('input');

static outX as int = 5; static outY as int = 2;
o.setItemSlot(outX,outY,ComponentFace.all(),64).setAccess(false,true).setHandAccess(false,true).setGroup('output');
o.setDurationSlot(4,2).setVisual(SlotVisual.createGauge('requious:textures/gui/assembly_gauges.png',2,1,3,1,GaugeDirection.up(),false)).setGroup('duration');

o.setJEIItemSlot(inpX,inpY, 'input');
o.setJEIItemSlot(outX,outY, 'output');
o.setJEIDurationSlot(4,2,'duration', SlotVisual.create(1,1).addPart('requious:textures/gui/assembly_gauges.png',3,1));

o.addVisual(MachineVisual.flame('active'.asVariable(), V(-0.1, -0.1, -0.1), V(1.1, 1.1, 1.1), V(0, 0, 0), 30, 1, 3, Color.normal([96, 56, 134])));

// -------------------------------------------------------------------------------
// -------------------------------------------------------------------------------

function infinFurnace(inp as IIngredient, out as IItemStack) as void {
  if (isNull(inp) || isNull(out) || scripts.do.inworld_smelting.unobtainableAsItem has inp) return;

  val assRecipe = AssemblyRecipe.create(function (c) {
    c.addItemOutput('output', out * min(64, out.amount * MULTIPLIER));
  })
    .requireItem('input', inp)
    .requireDuration('duration', 1);

  <assembly:infinity_furnace>.addJEIRecipe(assRecipe);
}

// Wildcard
static W as int = <minecraft:dirt:*>.damage;

static blacklistedInput as bool[IItemStack] = {} as bool[IItemStack];
static blacklistedWildcard as bool[string] = {} as bool[string];

function blacklist(item as IItemStack) as void {
  if (isNull(item)) return;
  if (item.damage == W)
    blacklistedWildcard[item.definition.id] = true;
  else
    blacklistedInput[item] = true;
}

static cachedOutput as IItemStack[IItemStack] = {} as IItemStack[IItemStack];

function pushToOutput(output as IItemStack, c as RecipeContainer) as bool {
  val outStack = c.machine.getItem(outX, outY);

  // Slot is empty
  if (isNull(outStack)) {
    c.machine.setItem(outX, outY, output);
    return true;
  }

  // Stacks cant be merged
  if (
    outStack.definition.id != output.definition.id
    || outStack.damage != output.damage
    || outStack.tag != output.tag
    || outStack.capNBT != output.capNBT
  ) {
    return false;
  }

  // Not anough space
  if (outStack.maxStackSize - outStack.amount < output.amount) return false;

  // Merge stacks
  c.machine.setItem(outX, outY, outStack.withAmount(outStack.amount + output.amount));
  return true;
}

<assembly:infinity_furnace>.addRecipe(
  AssemblyRecipe.create(function (c) {
    val inputStack = c.machine.getItem(inpX, inpY);
    if (isNull(inputStack)) return;
    val input = inputStack.anyAmount();

    if (!isNull(blacklistedWildcard[input.definition.id])
      || !isNull(blacklistedInput[input])) {
      return;
    }

    var smelted = cachedOutput[input];

    // Add cache
    if (isNull(smelted)) {
      smelted = utils.smelt(input);

      // Item is unsmeltable, mark it
      if (isNull(smelted)) {
        cachedOutput[input] = input;
        return;
      }

      cachedOutput[input] = smelted;
    }
    else if (
      input.definition.id == smelted.definition.id
      && input.damage == smelted.damage
    ) {
      return; // Item is unsmeltable
    }

    if (pushToOutput(smelted * min(64, smelted.amount * MULTIPLIER), c))
      c.machine.setItem(inpX, inpY, inputStack.amount > 1 ? inputStack.withAmount(inputStack.amount - 1) : null);
  })
    .requireWorldCondition('has_input', function (m) {
    val inputStack = m.getItem(inpX, inpY);
      if (isNull(inputStack)) return false;
      val input = inputStack.anyAmount();

      // Skip if blacklisted
      if (!isNull(blacklistedWildcard[input.definition.id])
        || !isNull(blacklistedInput[input])) {
        return false;
      }
      return true;
    }, 1)
    .setActive(5)
    .requireDuration('duration', 1)
);

// Special case for logWood -> Charcoal
infinFurnace(<ore:logWood>, <minecraft:coal:1>);

/* Inject_js{

// Manual antidupe list
const manualBlacklist = new Set(`
biomesoplenty:mud
biomesoplenty:mudball
botania:biomestonea
ic2:dust:3
iceandfire:dread_stone_bricks
minecraft:sponge:1
minecraft:stonebrick
mysticalagriculture:soulstone:1
nuclearcraft:ingot:15
qmd:dust:15
rats:marbled_cheese_brick
rustic:dust_tiny_iron
tcomplement:scorched_block:3
tcomplement:scorched_slab:3
tcomplement:scorched_stairs_brick
tconstruct:brownstone:3
tconstruct:seared:3
thermalfoundation:material:864
trinity:barium
`.trim().split('\n'))

const commandString = (id, meta, nbt, amount) => {
  let s = `<${id}>`
  if (meta && meta != '0') s = s.replace('>', `:${meta}>`)
  if (nbt) s += `.withTag(${nbt})`
  if (amount && parseInt(amount) > 1) s += ` * ${amount}`
  return s
}

let blacklisted = 0
let oredictFiltered = 0

function composeRecipe({ out_id, out_meta, out_tag, out_amount, in_id, in_meta, in_tag, in_amount }) {
  const involved = [[in_id, in_meta], [out_id, out_meta]]

  // Blacklist
  const inpCommandStr = commandString(in_id, in_meta, in_tag, in_amount)
  if (
    involved.some(([id, meta]) => isJEIBlacklisted(id, meta))
    || manualBlacklist.has(in_id + ((in_meta && in_meta !== '*') ? `:${in_meta}` : ''))
    || manualBlacklist.has(in_id)
  )
    return blacklisted++, `blacklist(${inpCommandStr});`

  const in_ore = [...getItemOredictSet(in_id, in_meta).keys()]

  // Just skip
  if (in_ore.includes('logWood')) return `// SKIP: ${inpCommandStr}`

  const out_ore = [...getItemOredictSet(out_id, out_meta).keys()]
  if (in_ore.some((o) => {
    const mat = o.match(/^dust([A-Z].+)/)?.[1]
    return mat && out_ore.some(o => o.replace(/^(ingot|gem)/, '') === mat)
  })
    // Blacklist input
    || ['Oxide', 'Nitride', 'ZA']
      .some(key => in_ore.some(o => o.match(new RegExp(`.+${key}`))))
  ) return oredictFiltered++, `blacklist(${inpCommandStr});`

  return `infinFurnace(${inpCommandStr}, ${commandString(out_id, out_meta, out_tag, out_amount)});`
}

const furnaceRecipes = getFurnaceRecipes()
if (!furnaceRecipes) return undefined
const filtered = furnaceRecipes.map(composeRecipe)

return `
// Total Furnace recipes registered: ${furnaceRecipes.length}
// Blacklisted by JEI or manually: ${blacklisted}
// Filtered by oredict: ${oredictFiltered}
${filtered.join('\n')}`

} */

// Total Furnace recipes registered: 947
// Blacklisted by JEI or manually: 79
// Filtered by oredict: 157
infinFurnace(<actuallyadditions:block_misc:3>, <actuallyadditions:item_misc:5>);
blacklist(<actuallyadditions:item_dust:3>);
blacklist(<actuallyadditions:item_dust:7>);
infinFurnace(<actuallyadditions:item_misc:4>, <actuallyadditions:item_food:15>);
infinFurnace(<actuallyadditions:item_misc:9>, <actuallyadditions:item_food:17>);
infinFurnace(<actuallyadditions:item_misc:20>, <minecraft:iron_ingot> * 2);
infinFurnace(<actuallyadditions:item_misc:21>, <actuallyadditions:item_misc:22>);
blacklist(<advancedrocketry:productdust:1>);
blacklist(<advancedrocketry:productdust>);
infinFurnace(<appliedenergistics2:material:2>, <appliedenergistics2:material:5>);
infinFurnace(<appliedenergistics2:material:3>, <appliedenergistics2:material:5>);
infinFurnace(<appliedenergistics2:material:4>, <minecraft:bread>);
blacklist(<appliedenergistics2:material:49>);
blacklist(<appliedenergistics2:material:51>);
infinFurnace(<appliedenergistics2:sky_stone_block>, <appliedenergistics2:smooth_sky_stone_block>);
infinFurnace(<astralsorcery:blockcustomore:1>, <astralsorcery:itemcraftingcomponent:1>);
infinFurnace(<astralsorcery:blockcustomore>, <mysticalagriculture:prosperity_ore>);
infinFurnace(<astralsorcery:blockcustomsandore>, <astralsorcery:itemcraftingcomponent> * 3);
blacklist(<betteranimalsplus:crab_meat_raw>);
infinFurnace(<betteranimalsplus:eel_meat_raw>, <betteranimalsplus:eel_meat_cooked>);
infinFurnace(<betteranimalsplus:golden_goose_egg>, <minecraft:gold_ingot>);
infinFurnace(<betteranimalsplus:goose_egg>, <betteranimalsplus:fried_egg>);
infinFurnace(<betteranimalsplus:pheasant_egg>, <betteranimalsplus:fried_egg>);
infinFurnace(<betteranimalsplus:pheasantraw>, <betteranimalsplus:pheasantcooked>);
infinFurnace(<betteranimalsplus:turkey_egg>, <betteranimalsplus:fried_egg>);
infinFurnace(<betteranimalsplus:turkey_raw>, <betteranimalsplus:turkey_cooked>);
infinFurnace(<betteranimalsplus:venisonraw>, <betteranimalsplus:venisoncooked>);
infinFurnace(<biomesoplenty:farmland_1>, <twilightforest:uberous_soil>);
infinFurnace(<biomesoplenty:gem_ore:1>, <biomesoplenty:gem:1>);
infinFurnace(<biomesoplenty:gem_ore:2>, <biomesoplenty:gem:2>);
infinFurnace(<biomesoplenty:gem_ore:3>, <biomesoplenty:gem:3>);
infinFurnace(<biomesoplenty:gem_ore:4>, <biomesoplenty:gem:4>);
infinFurnace(<biomesoplenty:gem_ore:5>, <biomesoplenty:gem:5>);
infinFurnace(<biomesoplenty:gem_ore:6>, <biomesoplenty:gem:6>);
infinFurnace(<biomesoplenty:gem_ore>, <biomesoplenty:gem>);
// SKIP: <biomesoplenty:log_0:4>
// SKIP: <biomesoplenty:log_0:5>
// SKIP: <biomesoplenty:log_0:6>
// SKIP: <biomesoplenty:log_0:7>
// SKIP: <biomesoplenty:log_1:4>
// SKIP: <biomesoplenty:log_1:5>
// SKIP: <biomesoplenty:log_1:6>
// SKIP: <biomesoplenty:log_1:7>
// SKIP: <biomesoplenty:log_2:4>
// SKIP: <biomesoplenty:log_2:5>
// SKIP: <biomesoplenty:log_2:6>
// SKIP: <biomesoplenty:log_2:7>
// SKIP: <biomesoplenty:log_3:4>
// SKIP: <biomesoplenty:log_3:5>
// SKIP: <biomesoplenty:log_3:6>
// SKIP: <biomesoplenty:log_3:7>
// SKIP: <biomesoplenty:log_4:5>
blacklist(<biomesoplenty:mud>);
blacklist(<biomesoplenty:mudball>);
infinFurnace(<biomesoplenty:plant_1:6>, <minecraft:dye:2>);
infinFurnace(<biomesoplenty:white_sand>, <minecraft:glass>);
blacklist(<bloodmagic:component:19>);
blacklist(<bloodmagic:component:20>);
infinFurnace(<botania:bifrost>, <botania:bifrostperm>);
blacklist(<botania:biomestonea:8>);
blacklist(<botania:biomestonea:9>);
blacklist(<botania:biomestonea:10>);
blacklist(<botania:biomestonea:11>);
blacklist(<botania:biomestonea:12>);
blacklist(<botania:biomestonea:13>);
blacklist(<botania:biomestonea:14>);
blacklist(<botania:biomestonea:15>);
infinFurnace(<cathedral:claytile>, <cathedral:firedtile>);
infinFurnace(<claybucket:unfiredclaybucket:*>, <claybucket:claybucket>);
infinFurnace(<contenttweaker:ore_phosphor>, <contenttweaker:nugget_phosphor>);
infinFurnace(<cookingforblockheads:recipe_book>, <cookingforblockheads:recipe_book:1>);
blacklist(<draconicevolution:draconium_dust:*>);
infinFurnace(<draconicevolution:draconium_ore:1>, <draconicevolution:draconium_ore> * 2);
infinFurnace(<draconicevolution:draconium_ore:2>, <draconicevolution:draconium_ore> * 2);
blacklist(<enderio:item_material:21>);
blacklist(<enderio:item_material:24>);
blacklist(<enderio:item_material:25>);
blacklist(<enderio:item_material:26>);
blacklist(<enderio:item_material:27>);
blacklist(<enderio:item_material:30>);
blacklist(<enderio:item_material:31>);
blacklist(<enderio:item_material:74>);
blacklist(<enderio:item_owl_egg>);
infinFurnace(<endreborn:block_wolframium_ore:*>, <endreborn:item_ingot_wolframium>);
infinFurnace(<exnihilocreatio:item_material:2>, <exnihilocreatio:item_cooked_silkworm>);
blacklist(<exnihilocreatio:item_ore_ardite:2>);
blacklist(<exnihilocreatio:item_ore_cobalt:2>);
infinFurnace(<extrautils2:decorativesolid:4>, <extrautils2:decorativeglass>);
// SKIP: <extrautils2:ironwood_log:*>
infinFurnace(<forestry:ash>, <tconstruct:materials>);
// SKIP: <forestry:logs.0:*>
// SKIP: <forestry:logs.1:*>
// SKIP: <forestry:logs.2:*>
// SKIP: <forestry:logs.3:*>
// SKIP: <forestry:logs.4:*>
// SKIP: <forestry:logs.5:*>
// SKIP: <forestry:logs.6:*>
// SKIP: <forestry:logs.7:*>
infinFurnace(<forestry:peat>, <forestry:ash>);
infinFurnace(<forestry:resources>, <forestry:apatite>);
blacklist(<gendustry:gene_sample:*>);
blacklist(<gendustry:gene_template:*>);
infinFurnace(<gendustry:honey_drop:5>, <appliedenergistics2:material:5> * 2);
infinFurnace(<harvestcraft:anchovyrawitem:*>, <minecraft:cooked_fish>);
infinFurnace(<harvestcraft:bassrawitem:*>, <minecraft:cooked_fish>);
infinFurnace(<harvestcraft:calamarirawitem:*>, <harvestcraft:calamaricookeditem>);
infinFurnace(<harvestcraft:carprawitem:*>, <minecraft:cooked_fish>);
infinFurnace(<harvestcraft:catfishrawitem:*>, <minecraft:cooked_fish>);
infinFurnace(<harvestcraft:charrrawitem:*>, <minecraft:cooked_fish>);
infinFurnace(<harvestcraft:clamrawitem:*>, <harvestcraft:clamcookeditem>);
infinFurnace(<harvestcraft:crabrawitem:*>, <harvestcraft:crabcookeditem>);
infinFurnace(<harvestcraft:crayfishrawitem:*>, <harvestcraft:crayfishcookeditem>);
infinFurnace(<harvestcraft:duckrawitem:*>, <harvestcraft:duckcookeditem>);
infinFurnace(<harvestcraft:eelrawitem:*>, <minecraft:cooked_fish>);
infinFurnace(<harvestcraft:frograwitem:*>, <harvestcraft:frogcookeditem>);
infinFurnace(<harvestcraft:greenheartfishitem:*>, <minecraft:cooked_fish>);
infinFurnace(<harvestcraft:grouperrawitem:*>, <minecraft:cooked_fish>);
infinFurnace(<harvestcraft:grubitem:*>, <harvestcraft:cookedgrubitem>);
infinFurnace(<harvestcraft:herringrawitem:*>, <minecraft:cooked_fish>);
infinFurnace(<harvestcraft:mudfishrawitem:*>, <minecraft:cooked_fish>);
infinFurnace(<harvestcraft:musselrawitem:*>, <harvestcraft:musselcookeditem>);
infinFurnace(<harvestcraft:octopusrawitem:*>, <harvestcraft:octopuscookeditem>);
infinFurnace(<harvestcraft:oysterrawitem:*>, <harvestcraft:oystercookeditem>);
infinFurnace(<harvestcraft:perchrawitem:*>, <minecraft:cooked_fish>);
infinFurnace(<harvestcraft:rawtofabbititem:*>, <harvestcraft:cookedtofabbititem>);
infinFurnace(<harvestcraft:rawtofaconitem:*>, <harvestcraft:cookedtofaconitem>);
infinFurnace(<harvestcraft:rawtofeakitem:*>, <harvestcraft:cookedtofeakitem>);
infinFurnace(<harvestcraft:rawtofeegitem:*>, <harvestcraft:cookedtofeegitem>);
infinFurnace(<harvestcraft:rawtofenisonitem:*>, <harvestcraft:cookedtofenisonitem>);
infinFurnace(<harvestcraft:rawtofickenitem:*>, <harvestcraft:cookedtofickenitem>);
infinFurnace(<harvestcraft:rawtofishitem:*>, <harvestcraft:cookedtofishitem>);
infinFurnace(<harvestcraft:rawtofuduckitem:*>, <harvestcraft:cookedtofuduckitem>);
infinFurnace(<harvestcraft:rawtofurkeyitem:*>, <harvestcraft:cookedtofurkeyitem>);
infinFurnace(<harvestcraft:rawtofuttonitem:*>, <harvestcraft:cookedtofuttonitem>);
infinFurnace(<harvestcraft:sardinerawitem:*>, <minecraft:cooked_fish>);
infinFurnace(<harvestcraft:scalloprawitem:*>, <harvestcraft:scallopcookeditem>);
infinFurnace(<harvestcraft:shrimprawitem:*>, <harvestcraft:shrimpcookeditem>);
infinFurnace(<harvestcraft:snailrawitem:*>, <harvestcraft:snailcookeditem>);
infinFurnace(<harvestcraft:snapperrawitem:*>, <minecraft:cooked_fish>);
infinFurnace(<harvestcraft:tilapiarawitem:*>, <minecraft:cooked_fish>);
infinFurnace(<harvestcraft:troutrawitem:*>, <minecraft:cooked_fish>);
infinFurnace(<harvestcraft:tunarawitem:*>, <minecraft:cooked_fish>);
infinFurnace(<harvestcraft:turkeyrawitem:*>, <harvestcraft:turkeycookeditem>);
infinFurnace(<harvestcraft:turtlerawitem:*>, <harvestcraft:turtlecookeditem>);
infinFurnace(<harvestcraft:venisonrawitem:*>, <harvestcraft:venisoncookeditem>);
infinFurnace(<harvestcraft:walleyerawitem:*>, <minecraft:cooked_fish>);
infinFurnace(<ic2:crafting:27>, <ic2:crystal_memory>);
infinFurnace(<ic2:crushed:1>, <minecraft:gold_ingot>);
infinFurnace(<ic2:crushed:2>, <minecraft:iron_ingot>);
infinFurnace(<ic2:crushed:3>, <thermalfoundation:material:131>);
infinFurnace(<ic2:crushed:4>, <thermalfoundation:material:130>);
infinFurnace(<ic2:crushed:5>, <thermalfoundation:material:129>);
infinFurnace(<ic2:crushed:6>, <immersiveengineering:metal:5>);
infinFurnace(<ic2:crushed>, <thermalfoundation:material:128>);
blacklist(<ic2:dust:3>);
blacklist(<ic2:dust:11>);
infinFurnace(<ic2:dust:15>, <tconstruct:materials>);
infinFurnace(<ic2:misc_resource:4>, <ic2:crafting>);
infinFurnace(<ic2:mug:1>, <ic2:mug:2>);
infinFurnace(<ic2:purified:1>, <minecraft:gold_ingot>);
infinFurnace(<ic2:purified:2>, <minecraft:iron_ingot>);
infinFurnace(<ic2:purified:3>, <thermalfoundation:material:131>);
infinFurnace(<ic2:purified:4>, <thermalfoundation:material:130>);
infinFurnace(<ic2:purified:5>, <thermalfoundation:material:129>);
infinFurnace(<ic2:purified:6>, <immersiveengineering:metal:5>);
infinFurnace(<ic2:purified>, <thermalfoundation:material:128>);
// SKIP: <ic2:rubber_wood:*>
blacklist(<iceandfire:dread_stone_bricks:*>);
infinFurnace(<iceandfire:frozen_cobblestone:*>, <minecraft:cobblestone>);
infinFurnace(<iceandfire:frozen_dirt:*>, <minecraft:dirt>);
infinFurnace(<iceandfire:frozen_grass_path:*>, <minecraft:grass_path>);
infinFurnace(<iceandfire:frozen_grass:*>, <minecraft:grass>);
infinFurnace(<iceandfire:frozen_gravel:*>, <minecraft:gravel>);
infinFurnace(<iceandfire:frozen_splinters:*>, <minecraft:stick> * 3);
infinFurnace(<iceandfire:frozen_stone:*>, <minecraft:stone>);
infinFurnace(<iceandfire:stymphalian_bird_feather:*>, <thermalfoundation:material:227>);
infinFurnace(<immersiveengineering:material:7>, <thermalfoundation:rockwool:7>);
blacklist(<immersiveengineering:material:18>);
blacklist(<immersiveengineering:metal:14>);
infinFurnace(<immersiveengineering:ore:5>, <immersiveengineering:metal:5>);
infinFurnace(<industrialforegoing:dryrubber:*>, <industrialforegoing:plastic>);
// SKIP: <integrateddynamics:menril_log_filled>
// SKIP: <integrateddynamics:menril_log>
infinFurnace(<jaopca:item_chunkaluminium>, <jaopca:item_dirtygemaluminium> * 10);
infinFurnace(<jaopca:item_chunkamber>, <jaopca:item_dirtygemamber> * 10);
infinFurnace(<jaopca:item_chunkamethyst>, <jaopca:item_dirtygemamethyst> * 10);
infinFurnace(<jaopca:item_chunkanglesite>, <jaopca:item_dirtygemanglesite> * 10);
infinFurnace(<jaopca:item_chunkapatite>, <jaopca:item_dirtygemapatite> * 10);
infinFurnace(<jaopca:item_chunkaquamarine>, <jaopca:item_dirtygemaquamarine> * 10);
infinFurnace(<jaopca:item_chunkardite>, <jaopca:item_dirtygemardite> * 10);
infinFurnace(<jaopca:item_chunkastralstarmetal>, <jaopca:item_dirtygemastralstarmetal> * 10);
infinFurnace(<jaopca:item_chunkbenitoite>, <jaopca:item_dirtygembenitoite> * 10);
infinFurnace(<jaopca:item_chunkboron>, <jaopca:item_dirtygemboron> * 10);
infinFurnace(<jaopca:item_chunkcertusquartz>, <jaopca:item_dirtygemcertusquartz> * 10);
infinFurnace(<jaopca:item_chunkchargedcertusquartz>, <jaopca:item_dirtygemchargedcertusquartz> * 10);
infinFurnace(<jaopca:item_chunkcoal>, <jaopca:item_dirtygemcoal> * 10);
infinFurnace(<jaopca:item_chunkcobalt>, <jaopca:item_dirtygemcobalt> * 10);
infinFurnace(<jaopca:item_chunkcopper>, <jaopca:item_dirtygemcopper> * 10);
infinFurnace(<jaopca:item_chunkdiamond>, <jaopca:item_dirtygemdiamond> * 10);
infinFurnace(<jaopca:item_chunkdilithium>, <jaopca:item_dirtygemdilithium> * 10);
infinFurnace(<jaopca:item_chunkdimensionalshard>, <jaopca:item_dirtygemdimensionalshard> * 10);
infinFurnace(<jaopca:item_chunkdraconium>, <jaopca:item_dirtygemdraconium> * 10);
infinFurnace(<jaopca:item_chunkemerald>, <jaopca:item_dirtygememerald> * 10);
infinFurnace(<jaopca:item_chunkgold>, <jaopca:item_dirtygemgold> * 10);
infinFurnace(<jaopca:item_chunkiridium>, <jaopca:item_dirtygemiridium> * 10);
infinFurnace(<jaopca:item_chunkiron>, <jaopca:item_dirtygemiron> * 10);
infinFurnace(<jaopca:item_chunklapis>, <jaopca:item_dirtygemlapis> * 10);
infinFurnace(<jaopca:item_chunklead>, <jaopca:item_dirtygemlead> * 10);
infinFurnace(<jaopca:item_chunklithium>, <jaopca:item_dirtygemlithium> * 10);
infinFurnace(<jaopca:item_chunkmagnesium>, <jaopca:item_dirtygemmagnesium> * 10);
infinFurnace(<jaopca:item_chunkmalachite>, <jaopca:item_dirtygemmalachite> * 10);
infinFurnace(<jaopca:item_chunkmithril>, <jaopca:item_dirtygemmithril> * 10);
infinFurnace(<jaopca:item_chunknickel>, <jaopca:item_dirtygemnickel> * 10);
infinFurnace(<jaopca:item_chunkosmium>, <jaopca:item_dirtygemosmium> * 10);
infinFurnace(<jaopca:item_chunkperidot>, <jaopca:item_dirtygemperidot> * 10);
infinFurnace(<jaopca:item_chunkplatinum>, <jaopca:item_dirtygemplatinum> * 10);
infinFurnace(<jaopca:item_chunkquartz>, <jaopca:item_dirtygemquartz> * 10);
infinFurnace(<jaopca:item_chunkquartzblack>, <jaopca:item_dirtygemquartzblack> * 10);
infinFurnace(<jaopca:item_chunkredstone>, <jaopca:item_dirtygemredstone> * 10);
infinFurnace(<jaopca:item_chunkruby>, <jaopca:item_dirtygemruby> * 10);
infinFurnace(<jaopca:item_chunksapphire>, <jaopca:item_dirtygemsapphire> * 10);
infinFurnace(<jaopca:item_chunksilver>, <jaopca:item_dirtygemsilver> * 10);
infinFurnace(<jaopca:item_chunktanzanite>, <jaopca:item_dirtygemtanzanite> * 10);
infinFurnace(<jaopca:item_chunkthorium>, <jaopca:item_dirtygemthorium> * 10);
infinFurnace(<jaopca:item_chunktin>, <jaopca:item_dirtygemtin> * 10);
infinFurnace(<jaopca:item_chunktitanium>, <jaopca:item_dirtygemtitanium> * 10);
infinFurnace(<jaopca:item_chunktopaz>, <jaopca:item_dirtygemtopaz> * 10);
infinFurnace(<jaopca:item_chunktrinitite>, <jaopca:item_dirtygemtrinitite> * 10);
infinFurnace(<jaopca:item_chunktungsten>, <jaopca:item_dirtygemtungsten> * 10);
infinFurnace(<jaopca:item_chunkuranium>, <jaopca:item_dirtygemuranium> * 10);
infinFurnace(<jaopca:item_clusteraluminium>, <thermalfoundation:material:132> * 2);
infinFurnace(<jaopca:item_clusteramber>, <thaumcraft:amber> * 3);
infinFurnace(<jaopca:item_clusteramethyst>, <biomesoplenty:gem> * 3);
infinFurnace(<jaopca:item_clusteranglesite>, <contenttweaker:anglesite> * 2);
infinFurnace(<jaopca:item_clusterapatite>, <forestry:apatite> * 17);
infinFurnace(<jaopca:item_clusteraquamarine>, <astralsorcery:itemcraftingcomponent> * 7);
infinFurnace(<jaopca:item_clusterardite>, <tconstruct:ingots:1> * 2);
infinFurnace(<jaopca:item_clusterastralstarmetal>, <astralsorcery:itemcraftingcomponent:1> * 2);
infinFurnace(<jaopca:item_clusterbenitoite>, <contenttweaker:benitoite> * 2);
infinFurnace(<jaopca:item_clusterboron>, <nuclearcraft:ingot:5> * 2);
infinFurnace(<jaopca:item_clustercertusquartz>, <appliedenergistics2:material> * 5);
infinFurnace(<jaopca:item_clusterchargedcertusquartz>, <appliedenergistics2:material:1> * 3);
infinFurnace(<jaopca:item_clustercoal>, <minecraft:coal> * 8);
infinFurnace(<jaopca:item_clustercobalt>, <tconstruct:ingots> * 2);
infinFurnace(<jaopca:item_clusterdiamond>, <minecraft:diamond> * 3);
infinFurnace(<jaopca:item_clusterdilithium>, <libvulpes:productgem> * 2);
infinFurnace(<jaopca:item_clusterdimensionalshard>, <rftools:dimensional_shard> * 7);
infinFurnace(<jaopca:item_clusterdraconium>, <draconicevolution:draconium_ingot> * 2);
infinFurnace(<jaopca:item_clusteremerald>, <minecraft:emerald> * 3);
infinFurnace(<jaopca:item_clusteriridium>, <thermalfoundation:material:135> * 2);
infinFurnace(<jaopca:item_clusterlapis>, <minecraft:dye:4> * 17);
infinFurnace(<jaopca:item_clusterlithium>, <nuclearcraft:ingot:6> * 2);
infinFurnace(<jaopca:item_clustermagnesium>, <nuclearcraft:ingot:7> * 2);
infinFurnace(<jaopca:item_clustermalachite>, <biomesoplenty:gem:5> * 3);
infinFurnace(<jaopca:item_clustermithril>, <thermalfoundation:material:136> * 2);
infinFurnace(<jaopca:item_clusternickel>, <thermalfoundation:material:133> * 2);
infinFurnace(<jaopca:item_clusterosmium>, <mekanism:ingot:1> * 2);
infinFurnace(<jaopca:item_clusterperidot>, <biomesoplenty:gem:2> * 3);
infinFurnace(<jaopca:item_clusterplatinum>, <thermalfoundation:material:134> * 2);
infinFurnace(<jaopca:item_clusterquartzblack>, <actuallyadditions:item_misc:5> * 3);
infinFurnace(<jaopca:item_clusterredstone>, <extrautils2:ingredients> * 17);
infinFurnace(<jaopca:item_clusterruby>, <biomesoplenty:gem:1> * 3);
infinFurnace(<jaopca:item_clustersapphire>, <biomesoplenty:gem:6> * 3);
infinFurnace(<jaopca:item_clustertanzanite>, <biomesoplenty:gem:4> * 3);
infinFurnace(<jaopca:item_clusterthorium>, <nuclearcraft:ingot:3> * 2);
infinFurnace(<jaopca:item_clustertitanium>, <libvulpes:productingot:7> * 2);
infinFurnace(<jaopca:item_clustertopaz>, <biomesoplenty:gem:3> * 3);
infinFurnace(<jaopca:item_clustertrinitite>, <trinity:trinitite_shard> * 2);
infinFurnace(<jaopca:item_clustertungsten>, <qmd:dust> * 2);
infinFurnace(<jaopca:item_clusteruranium>, <immersiveengineering:metal:5> * 2);
infinFurnace(<jaopca:item_crushedaluminium>, <thermalfoundation:material:132>);
infinFurnace(<jaopca:item_crushedardite>, <tconstruct:ingots:1>);
infinFurnace(<jaopca:item_crushedastralstarmetal>, <astralsorcery:itemcraftingcomponent:1>);
infinFurnace(<jaopca:item_crushedboron>, <nuclearcraft:ingot:5>);
infinFurnace(<jaopca:item_crushedcobalt>, <tconstruct:ingots>);
infinFurnace(<jaopca:item_crusheddraconium>, <draconicevolution:draconium_ingot>);
infinFurnace(<jaopca:item_crushediridium>, <thermalfoundation:material:135>);
infinFurnace(<jaopca:item_crushedlithium>, <nuclearcraft:ingot:6>);
infinFurnace(<jaopca:item_crushedmagnesium>, <nuclearcraft:ingot:7>);
infinFurnace(<jaopca:item_crushedmithril>, <thermalfoundation:material:136>);
infinFurnace(<jaopca:item_crushednickel>, <thermalfoundation:material:133>);
infinFurnace(<jaopca:item_crushedosmium>, <mekanism:ingot:1>);
infinFurnace(<jaopca:item_crushedplatinum>, <thermalfoundation:material:134>);
infinFurnace(<jaopca:item_crushedpurifiedaluminium>, <thermalfoundation:material:132>);
infinFurnace(<jaopca:item_crushedpurifiedardite>, <tconstruct:ingots:1>);
infinFurnace(<jaopca:item_crushedpurifiedastralstarmetal>, <astralsorcery:itemcraftingcomponent:1>);
infinFurnace(<jaopca:item_crushedpurifiedboron>, <nuclearcraft:ingot:5>);
infinFurnace(<jaopca:item_crushedpurifiedcobalt>, <tconstruct:ingots>);
infinFurnace(<jaopca:item_crushedpurifieddraconium>, <draconicevolution:draconium_ingot>);
infinFurnace(<jaopca:item_crushedpurifiediridium>, <thermalfoundation:material:135>);
infinFurnace(<jaopca:item_crushedpurifiedlithium>, <nuclearcraft:ingot:6>);
infinFurnace(<jaopca:item_crushedpurifiedmagnesium>, <nuclearcraft:ingot:7>);
infinFurnace(<jaopca:item_crushedpurifiedmithril>, <thermalfoundation:material:136>);
infinFurnace(<jaopca:item_crushedpurifiednickel>, <thermalfoundation:material:133>);
infinFurnace(<jaopca:item_crushedpurifiedosmium>, <mekanism:ingot:1>);
infinFurnace(<jaopca:item_crushedpurifiedplatinum>, <thermalfoundation:material:134>);
infinFurnace(<jaopca:item_crushedpurifiedthorium>, <nuclearcraft:ingot:3>);
infinFurnace(<jaopca:item_crushedpurifiedtungsten>, <endreborn:item_ingot_wolframium>);
infinFurnace(<jaopca:item_crushedthorium>, <nuclearcraft:ingot:3>);
infinFurnace(<jaopca:item_crushedtungsten>, <endreborn:item_ingot_wolframium>);
infinFurnace(<jaopca:item_crystalabyssaluminium>, <jaopca:item_dirtygemaluminium>);
infinFurnace(<jaopca:item_crystalabyssamber>, <jaopca:item_dirtygemamber>);
infinFurnace(<jaopca:item_crystalabyssamethyst>, <jaopca:item_dirtygemamethyst>);
infinFurnace(<jaopca:item_crystalabyssanglesite>, <jaopca:item_dirtygemanglesite>);
infinFurnace(<jaopca:item_crystalabyssapatite>, <jaopca:item_dirtygemapatite>);
infinFurnace(<jaopca:item_crystalabyssaquamarine>, <jaopca:item_dirtygemaquamarine>);
infinFurnace(<jaopca:item_crystalabyssardite>, <jaopca:item_dirtygemardite>);
infinFurnace(<jaopca:item_crystalabyssastralstarmetal>, <jaopca:item_dirtygemastralstarmetal>);
infinFurnace(<jaopca:item_crystalabyssbenitoite>, <jaopca:item_dirtygembenitoite>);
infinFurnace(<jaopca:item_crystalabyssboron>, <jaopca:item_dirtygemboron>);
infinFurnace(<jaopca:item_crystalabysscertusquartz>, <jaopca:item_dirtygemcertusquartz>);
infinFurnace(<jaopca:item_crystalabysschargedcertusquartz>, <jaopca:item_dirtygemchargedcertusquartz>);
infinFurnace(<jaopca:item_crystalabysscoal>, <jaopca:item_dirtygemcoal>);
infinFurnace(<jaopca:item_crystalabysscobalt>, <jaopca:item_dirtygemcobalt>);
infinFurnace(<jaopca:item_crystalabysscopper>, <jaopca:item_dirtygemcopper>);
infinFurnace(<jaopca:item_crystalabyssdiamond>, <jaopca:item_dirtygemdiamond>);
infinFurnace(<jaopca:item_crystalabyssdilithium>, <jaopca:item_dirtygemdilithium>);
infinFurnace(<jaopca:item_crystalabyssdimensionalshard>, <jaopca:item_dirtygemdimensionalshard>);
infinFurnace(<jaopca:item_crystalabyssdraconium>, <jaopca:item_dirtygemdraconium>);
infinFurnace(<jaopca:item_crystalabyssemerald>, <jaopca:item_dirtygememerald>);
infinFurnace(<jaopca:item_crystalabyssgold>, <jaopca:item_dirtygemgold>);
infinFurnace(<jaopca:item_crystalabyssiridium>, <jaopca:item_dirtygemiridium>);
infinFurnace(<jaopca:item_crystalabyssiron>, <jaopca:item_dirtygemiron>);
infinFurnace(<jaopca:item_crystalabysslapis>, <jaopca:item_dirtygemlapis>);
infinFurnace(<jaopca:item_crystalabysslead>, <jaopca:item_dirtygemlead>);
infinFurnace(<jaopca:item_crystalabysslithium>, <jaopca:item_dirtygemlithium>);
infinFurnace(<jaopca:item_crystalabyssmagnesium>, <jaopca:item_dirtygemmagnesium>);
infinFurnace(<jaopca:item_crystalabyssmalachite>, <jaopca:item_dirtygemmalachite>);
infinFurnace(<jaopca:item_crystalabyssmithril>, <jaopca:item_dirtygemmithril>);
infinFurnace(<jaopca:item_crystalabyssnickel>, <jaopca:item_dirtygemnickel>);
infinFurnace(<jaopca:item_crystalabyssosmium>, <jaopca:item_dirtygemosmium>);
infinFurnace(<jaopca:item_crystalabyssperidot>, <jaopca:item_dirtygemperidot>);
infinFurnace(<jaopca:item_crystalabyssplatinum>, <jaopca:item_dirtygemplatinum>);
infinFurnace(<jaopca:item_crystalabyssquartz>, <jaopca:item_dirtygemquartz>);
infinFurnace(<jaopca:item_crystalabyssquartzblack>, <jaopca:item_dirtygemquartzblack>);
infinFurnace(<jaopca:item_crystalabyssredstone>, <jaopca:item_dirtygemredstone>);
infinFurnace(<jaopca:item_crystalabyssruby>, <jaopca:item_dirtygemruby>);
infinFurnace(<jaopca:item_crystalabysssapphire>, <jaopca:item_dirtygemsapphire>);
infinFurnace(<jaopca:item_crystalabysssilver>, <jaopca:item_dirtygemsilver>);
infinFurnace(<jaopca:item_crystalabysstanzanite>, <jaopca:item_dirtygemtanzanite>);
infinFurnace(<jaopca:item_crystalabyssthorium>, <jaopca:item_dirtygemthorium>);
infinFurnace(<jaopca:item_crystalabysstin>, <jaopca:item_dirtygemtin>);
infinFurnace(<jaopca:item_crystalabysstitanium>, <jaopca:item_dirtygemtitanium>);
infinFurnace(<jaopca:item_crystalabysstopaz>, <jaopca:item_dirtygemtopaz>);
infinFurnace(<jaopca:item_crystalabysstrinitite>, <jaopca:item_dirtygemtrinitite>);
infinFurnace(<jaopca:item_crystalabysstungsten>, <jaopca:item_dirtygemtungsten>);
infinFurnace(<jaopca:item_crystalabyssuranium>, <jaopca:item_dirtygemuranium>);
infinFurnace(<jaopca:item_dirtygemaluminium>, <thermalfoundation:material:132> * 12);
infinFurnace(<jaopca:item_dirtygemamber>, <thaumcraft:amber> * 18);
infinFurnace(<jaopca:item_dirtygemamethyst>, <biomesoplenty:gem> * 18);
infinFurnace(<jaopca:item_dirtygemanglesite>, <contenttweaker:anglesite> * 12);
infinFurnace(<jaopca:item_dirtygemapatite>, <forestry:apatite> * 64);
infinFurnace(<jaopca:item_dirtygemaquamarine>, <astralsorcery:itemcraftingcomponent> * 37);
infinFurnace(<jaopca:item_dirtygemardite>, <tconstruct:ingots:1> * 12);
infinFurnace(<jaopca:item_dirtygemastralstarmetal>, <astralsorcery:itemcraftingcomponent:1> * 12);
infinFurnace(<jaopca:item_dirtygembenitoite>, <contenttweaker:benitoite> * 12);
infinFurnace(<jaopca:item_dirtygemboron>, <nuclearcraft:ingot:5> * 12);
infinFurnace(<jaopca:item_dirtygemcertusquartz>, <appliedenergistics2:material> * 27);
infinFurnace(<jaopca:item_dirtygemchargedcertusquartz>, <appliedenergistics2:material:1> * 18);
infinFurnace(<jaopca:item_dirtygemcoal>, <minecraft:coal> * 46);
infinFurnace(<jaopca:item_dirtygemcobalt>, <tconstruct:ingots> * 12);
infinFurnace(<jaopca:item_dirtygemcopper>, <thermalfoundation:material:128> * 12);
infinFurnace(<jaopca:item_dirtygemdiamond>, <minecraft:diamond> * 18);
infinFurnace(<jaopca:item_dirtygemdilithium>, <libvulpes:productgem> * 12);
infinFurnace(<jaopca:item_dirtygemdimensionalshard>, <rftools:dimensional_shard> * 37);
infinFurnace(<jaopca:item_dirtygemdraconium>, <draconicevolution:draconium_ingot> * 12);
infinFurnace(<jaopca:item_dirtygememerald>, <minecraft:emerald> * 18);
infinFurnace(<jaopca:item_dirtygemgold>, <minecraft:gold_ingot> * 12);
infinFurnace(<jaopca:item_dirtygemiridium>, <thermalfoundation:material:135> * 12);
infinFurnace(<jaopca:item_dirtygemiron>, <minecraft:iron_ingot> * 12);
infinFurnace(<jaopca:item_dirtygemlapis>, <minecraft:dye:4> * 64);
infinFurnace(<jaopca:item_dirtygemlead>, <thermalfoundation:material:131> * 12);
infinFurnace(<jaopca:item_dirtygemlithium>, <nuclearcraft:ingot:6> * 12);
infinFurnace(<jaopca:item_dirtygemmagnesium>, <nuclearcraft:ingot:7> * 12);
infinFurnace(<jaopca:item_dirtygemmalachite>, <biomesoplenty:gem:5> * 18);
infinFurnace(<jaopca:item_dirtygemmithril>, <thermalfoundation:material:136> * 12);
infinFurnace(<jaopca:item_dirtygemnickel>, <thermalfoundation:material:133> * 12);
infinFurnace(<jaopca:item_dirtygemosmium>, <mekanism:ingot:1> * 12);
infinFurnace(<jaopca:item_dirtygemperidot>, <biomesoplenty:gem:2> * 18);
infinFurnace(<jaopca:item_dirtygemplatinum>, <thermalfoundation:material:134> * 12);
infinFurnace(<jaopca:item_dirtygemquartz>, <minecraft:quartz> * 27);
infinFurnace(<jaopca:item_dirtygemquartzblack>, <actuallyadditions:item_misc:5> * 18);
infinFurnace(<jaopca:item_dirtygemredstone>, <extrautils2:ingredients> * 64);
infinFurnace(<jaopca:item_dirtygemruby>, <biomesoplenty:gem:1> * 18);
infinFurnace(<jaopca:item_dirtygemsapphire>, <biomesoplenty:gem:6> * 18);
infinFurnace(<jaopca:item_dirtygemsilver>, <thermalfoundation:material:130> * 12);
infinFurnace(<jaopca:item_dirtygemtanzanite>, <biomesoplenty:gem:4> * 18);
infinFurnace(<jaopca:item_dirtygemthorium>, <nuclearcraft:ingot:3> * 12);
infinFurnace(<jaopca:item_dirtygemtin>, <thermalfoundation:material:129> * 12);
infinFurnace(<jaopca:item_dirtygemtitanium>, <libvulpes:productingot:7> * 12);
infinFurnace(<jaopca:item_dirtygemtopaz>, <biomesoplenty:gem:3> * 18);
infinFurnace(<jaopca:item_dirtygemtrinitite>, <trinity:trinitite_shard> * 12);
infinFurnace(<jaopca:item_dirtygemtungsten>, <qmd:dust> * 12);
infinFurnace(<jaopca:item_dirtygemuranium>, <immersiveengineering:metal:5> * 12);
infinFurnace(<jaopca:item_dustalchaluminium>, <jaopca:item_dirtygemaluminium> * 48);
infinFurnace(<jaopca:item_dustalchamber>, <jaopca:item_dirtygemamber> * 48);
infinFurnace(<jaopca:item_dustalchamethyst>, <jaopca:item_dirtygemamethyst> * 48);
infinFurnace(<jaopca:item_dustalchanglesite>, <jaopca:item_dirtygemanglesite> * 48);
infinFurnace(<jaopca:item_dustalchapatite>, <jaopca:item_dirtygemapatite> * 48);
infinFurnace(<jaopca:item_dustalchaquamarine>, <jaopca:item_dirtygemaquamarine> * 48);
infinFurnace(<jaopca:item_dustalchardite>, <jaopca:item_dirtygemardite> * 48);
infinFurnace(<jaopca:item_dustalchastralstarmetal>, <jaopca:item_dirtygemastralstarmetal> * 48);
infinFurnace(<jaopca:item_dustalchbenitoite>, <jaopca:item_dirtygembenitoite> * 48);
infinFurnace(<jaopca:item_dustalchboron>, <jaopca:item_dirtygemboron> * 48);
infinFurnace(<jaopca:item_dustalchcertusquartz>, <jaopca:item_dirtygemcertusquartz> * 48);
infinFurnace(<jaopca:item_dustalchchargedcertusquartz>, <jaopca:item_dirtygemchargedcertusquartz> * 48);
infinFurnace(<jaopca:item_dustalchcoal>, <jaopca:item_dirtygemcoal> * 48);
infinFurnace(<jaopca:item_dustalchcobalt>, <jaopca:item_dirtygemcobalt> * 48);
infinFurnace(<jaopca:item_dustalchcopper>, <jaopca:item_dirtygemcopper> * 48);
infinFurnace(<jaopca:item_dustalchdiamond>, <jaopca:item_dirtygemdiamond> * 48);
infinFurnace(<jaopca:item_dustalchdilithium>, <jaopca:item_dirtygemdilithium> * 48);
infinFurnace(<jaopca:item_dustalchdimensionalshard>, <jaopca:item_dirtygemdimensionalshard> * 48);
infinFurnace(<jaopca:item_dustalchdraconium>, <jaopca:item_dirtygemdraconium> * 48);
infinFurnace(<jaopca:item_dustalchemerald>, <jaopca:item_dirtygememerald> * 48);
infinFurnace(<jaopca:item_dustalchgold>, <jaopca:item_dirtygemgold> * 48);
infinFurnace(<jaopca:item_dustalchiridium>, <jaopca:item_dirtygemiridium> * 48);
infinFurnace(<jaopca:item_dustalchiron>, <jaopca:item_dirtygemiron> * 48);
infinFurnace(<jaopca:item_dustalchlapis>, <jaopca:item_dirtygemlapis> * 48);
infinFurnace(<jaopca:item_dustalchlead>, <jaopca:item_dirtygemlead> * 48);
infinFurnace(<jaopca:item_dustalchlithium>, <jaopca:item_dirtygemlithium> * 48);
infinFurnace(<jaopca:item_dustalchmagnesium>, <jaopca:item_dirtygemmagnesium> * 48);
infinFurnace(<jaopca:item_dustalchmalachite>, <jaopca:item_dirtygemmalachite> * 48);
infinFurnace(<jaopca:item_dustalchmithril>, <jaopca:item_dirtygemmithril> * 48);
infinFurnace(<jaopca:item_dustalchnickel>, <jaopca:item_dirtygemnickel> * 48);
infinFurnace(<jaopca:item_dustalchosmium>, <jaopca:item_dirtygemosmium> * 48);
infinFurnace(<jaopca:item_dustalchperidot>, <jaopca:item_dirtygemperidot> * 48);
infinFurnace(<jaopca:item_dustalchplatinum>, <jaopca:item_dirtygemplatinum> * 48);
infinFurnace(<jaopca:item_dustalchquartz>, <jaopca:item_dirtygemquartz> * 48);
infinFurnace(<jaopca:item_dustalchquartzblack>, <jaopca:item_dirtygemquartzblack> * 48);
infinFurnace(<jaopca:item_dustalchredstone>, <jaopca:item_dirtygemredstone> * 48);
infinFurnace(<jaopca:item_dustalchruby>, <jaopca:item_dirtygemruby> * 48);
infinFurnace(<jaopca:item_dustalchsapphire>, <jaopca:item_dirtygemsapphire> * 48);
infinFurnace(<jaopca:item_dustalchsilver>, <jaopca:item_dirtygemsilver> * 48);
infinFurnace(<jaopca:item_dustalchtanzanite>, <jaopca:item_dirtygemtanzanite> * 48);
infinFurnace(<jaopca:item_dustalchthorium>, <jaopca:item_dirtygemthorium> * 48);
infinFurnace(<jaopca:item_dustalchtin>, <jaopca:item_dirtygemtin> * 48);
infinFurnace(<jaopca:item_dustalchtitanium>, <jaopca:item_dirtygemtitanium> * 48);
infinFurnace(<jaopca:item_dustalchtopaz>, <jaopca:item_dirtygemtopaz> * 48);
infinFurnace(<jaopca:item_dustalchtrinitite>, <jaopca:item_dirtygemtrinitite> * 48);
infinFurnace(<jaopca:item_dustalchtungsten>, <jaopca:item_dirtygemtungsten> * 48);
infinFurnace(<jaopca:item_dustalchuranium>, <jaopca:item_dirtygemuranium> * 48);
blacklist(<jaopca:item_dustamber>);
blacklist(<jaopca:item_dustamethyst>);
blacklist(<jaopca:item_dustapatite>);
blacklist(<jaopca:item_dustaquamarine>);
blacklist(<jaopca:item_dustchargedcertusquartz>);
blacklist(<jaopca:item_dustmalachite>);
blacklist(<jaopca:item_dustperidot>);
blacklist(<jaopca:item_dustruby>);
blacklist(<jaopca:item_dustsapphire>);
blacklist(<jaopca:item_dusttanzanite>);
blacklist(<jaopca:item_dusttopaz>);
blacklist(<jaopca:item_dusttrinitite>);
blacklist(<jaopca:item_hunkastralstarmetal>);
blacklist(<jaopca:item_hunkdraconium>);
blacklist(<jaopca:item_hunkiridium>);
blacklist(<jaopca:item_hunkmithril>);
blacklist(<jaopca:item_hunkosmium>);
blacklist(<jaopca:item_hunkplatinum>);
blacklist(<jaopca:item_hunktitanium>);
blacklist(<jaopca:item_hunktungsten>);
infinFurnace(<jaopca:item_rockychunkaluminium>, <jaopca:item_dirtygemaluminium> * 4);
infinFurnace(<jaopca:item_rockychunkamber>, <jaopca:item_dirtygemamber> * 4);
infinFurnace(<jaopca:item_rockychunkamethyst>, <jaopca:item_dirtygemamethyst> * 4);
infinFurnace(<jaopca:item_rockychunkanglesite>, <jaopca:item_dirtygemanglesite> * 4);
infinFurnace(<jaopca:item_rockychunkapatite>, <jaopca:item_dirtygemapatite> * 4);
infinFurnace(<jaopca:item_rockychunkaquamarine>, <jaopca:item_dirtygemaquamarine> * 4);
infinFurnace(<jaopca:item_rockychunkardite>, <jaopca:item_dirtygemardite> * 4);
infinFurnace(<jaopca:item_rockychunkastralstarmetal>, <jaopca:item_dirtygemastralstarmetal> * 4);
infinFurnace(<jaopca:item_rockychunkbenitoite>, <jaopca:item_dirtygembenitoite> * 4);
infinFurnace(<jaopca:item_rockychunkboron>, <jaopca:item_dirtygemboron> * 4);
infinFurnace(<jaopca:item_rockychunkcertusquartz>, <jaopca:item_dirtygemcertusquartz> * 4);
infinFurnace(<jaopca:item_rockychunkchargedcertusquartz>, <jaopca:item_dirtygemchargedcertusquartz> * 4);
infinFurnace(<jaopca:item_rockychunkcoal>, <jaopca:item_dirtygemcoal> * 4);
infinFurnace(<jaopca:item_rockychunkcobalt>, <jaopca:item_dirtygemcobalt> * 4);
infinFurnace(<jaopca:item_rockychunkcopper>, <jaopca:item_dirtygemcopper> * 4);
infinFurnace(<jaopca:item_rockychunkdiamond>, <jaopca:item_dirtygemdiamond> * 4);
infinFurnace(<jaopca:item_rockychunkdilithium>, <jaopca:item_dirtygemdilithium> * 4);
infinFurnace(<jaopca:item_rockychunkdimensionalshard>, <jaopca:item_dirtygemdimensionalshard> * 4);
infinFurnace(<jaopca:item_rockychunkdraconium>, <jaopca:item_dirtygemdraconium> * 4);
infinFurnace(<jaopca:item_rockychunkemerald>, <jaopca:item_dirtygememerald> * 4);
infinFurnace(<jaopca:item_rockychunkgold>, <jaopca:item_dirtygemgold> * 4);
infinFurnace(<jaopca:item_rockychunkiridium>, <jaopca:item_dirtygemiridium> * 4);
infinFurnace(<jaopca:item_rockychunkiron>, <jaopca:item_dirtygemiron> * 4);
infinFurnace(<jaopca:item_rockychunklapis>, <jaopca:item_dirtygemlapis> * 4);
infinFurnace(<jaopca:item_rockychunklead>, <jaopca:item_dirtygemlead> * 4);
infinFurnace(<jaopca:item_rockychunklithium>, <jaopca:item_dirtygemlithium> * 4);
infinFurnace(<jaopca:item_rockychunkmagnesium>, <jaopca:item_dirtygemmagnesium> * 4);
infinFurnace(<jaopca:item_rockychunkmalachite>, <jaopca:item_dirtygemmalachite> * 4);
infinFurnace(<jaopca:item_rockychunkmithril>, <jaopca:item_dirtygemmithril> * 4);
infinFurnace(<jaopca:item_rockychunknickel>, <jaopca:item_dirtygemnickel> * 4);
infinFurnace(<jaopca:item_rockychunkosmium>, <jaopca:item_dirtygemosmium> * 4);
infinFurnace(<jaopca:item_rockychunkperidot>, <jaopca:item_dirtygemperidot> * 4);
infinFurnace(<jaopca:item_rockychunkplatinum>, <jaopca:item_dirtygemplatinum> * 4);
infinFurnace(<jaopca:item_rockychunkquartz>, <jaopca:item_dirtygemquartz> * 4);
infinFurnace(<jaopca:item_rockychunkquartzblack>, <jaopca:item_dirtygemquartzblack> * 4);
infinFurnace(<jaopca:item_rockychunkredstone>, <jaopca:item_dirtygemredstone> * 4);
infinFurnace(<jaopca:item_rockychunkruby>, <jaopca:item_dirtygemruby> * 4);
infinFurnace(<jaopca:item_rockychunksapphire>, <jaopca:item_dirtygemsapphire> * 4);
infinFurnace(<jaopca:item_rockychunksilver>, <jaopca:item_dirtygemsilver> * 4);
infinFurnace(<jaopca:item_rockychunktanzanite>, <jaopca:item_dirtygemtanzanite> * 4);
infinFurnace(<jaopca:item_rockychunkthorium>, <jaopca:item_dirtygemthorium> * 4);
infinFurnace(<jaopca:item_rockychunktin>, <jaopca:item_dirtygemtin> * 4);
infinFurnace(<jaopca:item_rockychunktitanium>, <jaopca:item_dirtygemtitanium> * 4);
infinFurnace(<jaopca:item_rockychunktopaz>, <jaopca:item_dirtygemtopaz> * 4);
infinFurnace(<jaopca:item_rockychunktrinitite>, <jaopca:item_dirtygemtrinitite> * 4);
infinFurnace(<jaopca:item_rockychunktungsten>, <jaopca:item_dirtygemtungsten> * 4);
infinFurnace(<jaopca:item_rockychunkuranium>, <jaopca:item_dirtygemuranium> * 4);
infinFurnace(<libvulpes:ore0>, <libvulpes:productdust>);
blacklist(<libvulpes:productdust:3>);
blacklist(<libvulpes:productdust:7>);
infinFurnace(<mechanics:heavy_mesh:*>, <mechanics:heavy_ingot> * 2);
blacklist(<mekanism:dust:1>);
blacklist(<mekanism:dust:2>);
blacklist(<mekanism:dust:3>);
blacklist(<mekanism:dust:4>);
blacklist(<mekanism:dust>);
infinFurnace(<mekanism:oreblock>, <mekanism:ingot:1>);
blacklist(<mekanism:otherdust:1>);
blacklist(<mekanism:otherdust:4>);
infinFurnace(<mekanism:polyethene:1>, <rats:rat_tube_white>);
infinFurnace(<minecraft:beef:*>, <minecraft:cooked_beef>);
infinFurnace(<minecraft:book:*>, <cookingforblockheads:recipe_book:1>);
infinFurnace(<minecraft:cactus:*>, <minecraft:dye:2>);
infinFurnace(<minecraft:chainmail_boots:*>, <minecraft:iron_nugget>);
infinFurnace(<minecraft:chainmail_chestplate:*>, <minecraft:iron_nugget>);
infinFurnace(<minecraft:chainmail_helmet:*>, <minecraft:iron_nugget>);
infinFurnace(<minecraft:chainmail_leggings:*>, <minecraft:iron_nugget>);
infinFurnace(<minecraft:chicken:*>, <minecraft:cooked_chicken>);
infinFurnace(<minecraft:chorus_fruit:*>, <minecraft:chorus_fruit_popped>);
infinFurnace(<minecraft:clay_ball:*>, <minecraft:brick>);
infinFurnace(<minecraft:clay:*>, <minecraft:hardened_clay>);
infinFurnace(<minecraft:coal_ore:*>, <minecraft:coal>);
infinFurnace(<minecraft:coal:*>, <nuclearcraft:ingot:8>);
infinFurnace(<minecraft:cobblestone:*>, <minecraft:stone>);
infinFurnace(<minecraft:diamond_ore:*>, <minecraft:diamond>);
infinFurnace(<minecraft:dye:3>, <nuclearcraft:roasted_cocoa_beans>);
infinFurnace(<minecraft:egg>, <betteranimalsplus:fried_egg>);
infinFurnace(<minecraft:emerald_ore:*>, <minecraft:emerald>);
infinFurnace(<minecraft:fish:1>, <minecraft:cooked_fish:1>);
infinFurnace(<minecraft:fish>, <minecraft:cooked_fish>);
infinFurnace(<minecraft:gold_ore:*>, <minecraft:gold_ingot>);
infinFurnace(<minecraft:golden_axe:*>, <minecraft:gold_nugget>);
infinFurnace(<minecraft:golden_boots:*>, <minecraft:gold_nugget>);
infinFurnace(<minecraft:golden_chestplate:*>, <minecraft:gold_nugget>);
infinFurnace(<minecraft:golden_helmet:*>, <minecraft:gold_nugget>);
infinFurnace(<minecraft:golden_hoe:*>, <minecraft:gold_nugget>);
infinFurnace(<minecraft:golden_horse_armor:*>, <minecraft:gold_nugget>);
infinFurnace(<minecraft:golden_leggings:*>, <minecraft:gold_nugget>);
infinFurnace(<minecraft:golden_pickaxe:*>, <minecraft:gold_nugget>);
infinFurnace(<minecraft:golden_shovel:*>, <minecraft:gold_nugget>);
infinFurnace(<minecraft:golden_sword:*>, <minecraft:gold_nugget>);
infinFurnace(<minecraft:iron_axe:*>, <minecraft:iron_nugget>);
infinFurnace(<minecraft:iron_boots:*>, <minecraft:iron_nugget>);
infinFurnace(<minecraft:iron_chestplate:*>, <minecraft:iron_nugget>);
infinFurnace(<minecraft:iron_helmet:*>, <minecraft:iron_nugget>);
infinFurnace(<minecraft:iron_hoe:*>, <minecraft:iron_nugget>);
infinFurnace(<minecraft:iron_horse_armor:*>, <minecraft:iron_nugget>);
infinFurnace(<minecraft:iron_leggings:*>, <minecraft:iron_nugget>);
infinFurnace(<minecraft:iron_ore:*>, <minecraft:iron_ingot>);
infinFurnace(<minecraft:iron_pickaxe:*>, <minecraft:iron_nugget>);
infinFurnace(<minecraft:iron_shovel:*>, <minecraft:iron_nugget>);
infinFurnace(<minecraft:iron_sword:*>, <minecraft:iron_nugget>);
infinFurnace(<minecraft:lapis_ore:*>, <minecraft:dye:4>);
// SKIP: <minecraft:log:*>
// SKIP: <minecraft:log2:*>
infinFurnace(<minecraft:mutton:*>, <minecraft:cooked_mutton>);
infinFurnace(<minecraft:netherrack:*>, <minecraft:netherbrick>);
infinFurnace(<minecraft:porkchop:*>, <minecraft:cooked_porkchop>);
infinFurnace(<minecraft:potato:*>, <minecraft:baked_potato>);
infinFurnace(<minecraft:quartz_ore:*>, <minecraft:quartz>);
infinFurnace(<minecraft:rabbit:*>, <minecraft:cooked_rabbit>);
infinFurnace(<minecraft:redstone_ore:*>, <minecraft:redstone>);
infinFurnace(<minecraft:rotten_flesh>, <rustic:tallow>);
infinFurnace(<minecraft:sand:*>, <minecraft:glass>);
blacklist(<minecraft:sponge:1>);
infinFurnace(<minecraft:stained_hardened_clay:1>, <minecraft:orange_glazed_terracotta>);
infinFurnace(<minecraft:stained_hardened_clay:2>, <minecraft:magenta_glazed_terracotta>);
infinFurnace(<minecraft:stained_hardened_clay:3>, <minecraft:light_blue_glazed_terracotta>);
infinFurnace(<minecraft:stained_hardened_clay:4>, <minecraft:yellow_glazed_terracotta>);
infinFurnace(<minecraft:stained_hardened_clay:5>, <minecraft:lime_glazed_terracotta>);
infinFurnace(<minecraft:stained_hardened_clay:6>, <minecraft:pink_glazed_terracotta>);
infinFurnace(<minecraft:stained_hardened_clay:7>, <minecraft:gray_glazed_terracotta>);
infinFurnace(<minecraft:stained_hardened_clay:8>, <minecraft:silver_glazed_terracotta>);
infinFurnace(<minecraft:stained_hardened_clay:9>, <minecraft:cyan_glazed_terracotta>);
infinFurnace(<minecraft:stained_hardened_clay:10>, <minecraft:purple_glazed_terracotta>);
infinFurnace(<minecraft:stained_hardened_clay:11>, <minecraft:blue_glazed_terracotta>);
infinFurnace(<minecraft:stained_hardened_clay:12>, <minecraft:brown_glazed_terracotta>);
infinFurnace(<minecraft:stained_hardened_clay:13>, <minecraft:green_glazed_terracotta>);
infinFurnace(<minecraft:stained_hardened_clay:14>, <minecraft:red_glazed_terracotta>);
infinFurnace(<minecraft:stained_hardened_clay:15>, <minecraft:black_glazed_terracotta>);
infinFurnace(<minecraft:stained_hardened_clay>, <minecraft:white_glazed_terracotta>);
blacklist(<minecraft:stonebrick>);
infinFurnace(<mysticalagriculture:crafting:29>, <mysticalagriculture:crafting:38>);
blacklist(<mysticalagriculture:soulstone:1>);
infinFurnace(<mysticalagriculture:soulstone:3>, <mysticalagriculture:soulstone:4>);
infinFurnace(<mysticalagriculture:soulstone>, <mysticalagriculture:crafting:28>);
infinFurnace(<netherendingores:ore_end_modded_1:1>, <thermalfoundation:ore> * 2);
blacklist(<netherendingores:ore_end_modded_1:2>);
infinFurnace(<netherendingores:ore_end_modded_1:3>, <thermalfoundation:ore:3> * 2);
infinFurnace(<netherendingores:ore_end_modded_1:4>, <thermalfoundation:ore:8> * 2);
infinFurnace(<netherendingores:ore_end_modded_1:5>, <thermalfoundation:ore:5> * 2);
infinFurnace(<netherendingores:ore_end_modded_1:6>, <thermalfoundation:ore:6> * 2);
infinFurnace(<netherendingores:ore_end_modded_1:7>, <thermalfoundation:ore:2> * 2);
infinFurnace(<netherendingores:ore_end_modded_1:8>, <thermalfoundation:ore:1> * 2);
infinFurnace(<netherendingores:ore_end_modded_1:9>, <appliedenergistics2:quartz_ore> * 2);
blacklist(<netherendingores:ore_end_modded_1:10>);
infinFurnace(<netherendingores:ore_end_modded_1:11>, <mekanism:oreblock> * 2);
infinFurnace(<netherendingores:ore_end_modded_1:12>, <immersiveengineering:ore:5> * 2);
infinFurnace(<netherendingores:ore_end_modded_1:14>, <libvulpes:ore0> * 2);
infinFurnace(<netherendingores:ore_end_modded_1>, <thermalfoundation:ore:4> * 2);
infinFurnace(<netherendingores:ore_end_modded_2:1>, <biomesoplenty:gem_ore:1> * 2);
infinFurnace(<netherendingores:ore_end_modded_2:2>, <biomesoplenty:gem_ore:6> * 2);
blacklist(<netherendingores:ore_end_modded_2:3>);
blacklist(<netherendingores:ore_end_modded_2:5>);
blacklist(<netherendingores:ore_end_modded_2:6>);
blacklist(<netherendingores:ore_end_modded_2:7>);
blacklist(<netherendingores:ore_end_modded_2:8>);
blacklist(<netherendingores:ore_end_modded_2:9>);
infinFurnace(<netherendingores:ore_end_vanilla:1>, <minecraft:diamond_ore> * 2);
infinFurnace(<netherendingores:ore_end_vanilla:2>, <minecraft:emerald_ore> * 2);
infinFurnace(<netherendingores:ore_end_vanilla:3>, <minecraft:gold_ore> * 2);
infinFurnace(<netherendingores:ore_end_vanilla:4>, <minecraft:iron_ore> * 2);
infinFurnace(<netherendingores:ore_end_vanilla:5>, <minecraft:lapis_ore> * 2);
infinFurnace(<netherendingores:ore_end_vanilla:6>, <minecraft:redstone_ore> * 2);
infinFurnace(<netherendingores:ore_end_vanilla>, <minecraft:coal_ore> * 2);
infinFurnace(<netherendingores:ore_nether_modded_1:1>, <thermalfoundation:ore> * 2);
blacklist(<netherendingores:ore_nether_modded_1:2>);
infinFurnace(<netherendingores:ore_nether_modded_1:3>, <thermalfoundation:ore:3> * 2);
blacklist(<netherendingores:ore_nether_modded_1:4>);
infinFurnace(<netherendingores:ore_nether_modded_1:5>, <thermalfoundation:ore:5> * 2);
infinFurnace(<netherendingores:ore_nether_modded_1:6>, <thermalfoundation:ore:6> * 2);
infinFurnace(<netherendingores:ore_nether_modded_1:7>, <thermalfoundation:ore:2> * 2);
infinFurnace(<netherendingores:ore_nether_modded_1:8>, <thermalfoundation:ore:1> * 2);
infinFurnace(<netherendingores:ore_nether_modded_1:9>, <appliedenergistics2:quartz_ore> * 2);
infinFurnace(<netherendingores:ore_nether_modded_1:10>, <appliedenergistics2:charged_quartz_ore> * 2);
infinFurnace(<netherendingores:ore_nether_modded_1:11>, <mekanism:oreblock> * 2);
infinFurnace(<netherendingores:ore_nether_modded_1:12>, <immersiveengineering:ore:5> * 2);
blacklist(<netherendingores:ore_nether_modded_1:14>);
infinFurnace(<netherendingores:ore_nether_modded_1>, <thermalfoundation:ore:4> * 2);
infinFurnace(<netherendingores:ore_nether_modded_2:1>, <biomesoplenty:gem_ore:1> * 2);
blacklist(<netherendingores:ore_nether_modded_2:2>);
infinFurnace(<netherendingores:ore_nether_modded_2:3>, <biomesoplenty:gem_ore:2> * 2);
blacklist(<netherendingores:ore_nether_modded_2:5>);
blacklist(<netherendingores:ore_nether_modded_2:6>);
blacklist(<netherendingores:ore_nether_modded_2:7>);
blacklist(<netherendingores:ore_nether_modded_2:8>);
blacklist(<netherendingores:ore_nether_modded_2:9>);
infinFurnace(<netherendingores:ore_nether_vanilla:1>, <minecraft:diamond_ore> * 2);
infinFurnace(<netherendingores:ore_nether_vanilla:2>, <minecraft:emerald_ore> * 2);
infinFurnace(<netherendingores:ore_nether_vanilla:3>, <minecraft:gold_ore> * 2);
infinFurnace(<netherendingores:ore_nether_vanilla:4>, <minecraft:iron_ore> * 2);
infinFurnace(<netherendingores:ore_nether_vanilla:5>, <minecraft:lapis_ore> * 2);
infinFurnace(<netherendingores:ore_nether_vanilla:6>, <minecraft:redstone_ore> * 2);
infinFurnace(<netherendingores:ore_nether_vanilla>, <minecraft:coal_ore> * 2);
infinFurnace(<netherendingores:ore_other_1:1>, <minecraft:quartz_ore> * 2);
infinFurnace(<netherendingores:ore_other_1:3>, <tconstruct:ore:1> * 2);
infinFurnace(<netherendingores:ore_other_1:4>, <tconstruct:ingots>);
infinFurnace(<netherendingores:ore_other_1:5>, <tconstruct:ore> * 2);
blacklist(<netherendingores:ore_other_1>);
blacklist(<nuclearcraft:americium:2>);
blacklist(<nuclearcraft:americium:3>);
blacklist(<nuclearcraft:americium:4>);
blacklist(<nuclearcraft:americium:7>);
blacklist(<nuclearcraft:americium:8>);
blacklist(<nuclearcraft:americium:9>);
blacklist(<nuclearcraft:americium:12>);
blacklist(<nuclearcraft:americium:13>);
blacklist(<nuclearcraft:americium:14>);
blacklist(<nuclearcraft:berkelium:2>);
blacklist(<nuclearcraft:berkelium:3>);
blacklist(<nuclearcraft:berkelium:4>);
blacklist(<nuclearcraft:berkelium:7>);
blacklist(<nuclearcraft:berkelium:8>);
blacklist(<nuclearcraft:berkelium:9>);
blacklist(<nuclearcraft:californium:2>);
blacklist(<nuclearcraft:californium:3>);
blacklist(<nuclearcraft:californium:4>);
blacklist(<nuclearcraft:californium:7>);
blacklist(<nuclearcraft:californium:8>);
blacklist(<nuclearcraft:californium:9>);
blacklist(<nuclearcraft:californium:12>);
blacklist(<nuclearcraft:californium:13>);
blacklist(<nuclearcraft:californium:14>);
blacklist(<nuclearcraft:californium:17>);
blacklist(<nuclearcraft:californium:18>);
blacklist(<nuclearcraft:californium:19>);
infinFurnace(<nuclearcraft:compound:12>, <nuclearcraft:compound:13>);
blacklist(<nuclearcraft:curium:2>);
blacklist(<nuclearcraft:curium:3>);
blacklist(<nuclearcraft:curium:4>);
blacklist(<nuclearcraft:curium:7>);
blacklist(<nuclearcraft:curium:8>);
blacklist(<nuclearcraft:curium:9>);
blacklist(<nuclearcraft:curium:12>);
blacklist(<nuclearcraft:curium:13>);
blacklist(<nuclearcraft:curium:14>);
blacklist(<nuclearcraft:curium:17>);
blacklist(<nuclearcraft:curium:18>);
blacklist(<nuclearcraft:curium:19>);
blacklist(<nuclearcraft:dust:3>);
blacklist(<nuclearcraft:dust:5>);
blacklist(<nuclearcraft:dust:6>);
blacklist(<nuclearcraft:dust:7>);
blacklist(<nuclearcraft:dust:8>);
blacklist(<nuclearcraft:dust:9>);
blacklist(<nuclearcraft:dust:10>);
blacklist(<nuclearcraft:dust:11>);
blacklist(<nuclearcraft:dust:12>);
blacklist(<nuclearcraft:dust:13>);
blacklist(<nuclearcraft:dust:14>);
blacklist(<nuclearcraft:dust2:1>);
blacklist(<nuclearcraft:dust2>);
infinFurnace(<nuclearcraft:flour>, <minecraft:bread>);
infinFurnace(<nuclearcraft:gem_dust:1>, <nuclearcraft:dust:14>);
blacklist(<nuclearcraft:ingot:14>);
blacklist(<nuclearcraft:ingot:15>);
blacklist(<nuclearcraft:ingot2:2>);
blacklist(<nuclearcraft:ingot2:3>);
blacklist(<nuclearcraft:ingot2:4>);
blacklist(<nuclearcraft:ingot2:6>);
infinFurnace(<nuclearcraft:ingot2>, <nuclearcraft:ingot:10>);
blacklist(<nuclearcraft:neptunium:2>);
blacklist(<nuclearcraft:neptunium:3>);
blacklist(<nuclearcraft:neptunium:4>);
blacklist(<nuclearcraft:neptunium:7>);
blacklist(<nuclearcraft:neptunium:8>);
blacklist(<nuclearcraft:neptunium:9>);
infinFurnace(<nuclearcraft:ore:3>, <nuclearcraft:ingot:3>);
infinFurnace(<nuclearcraft:ore:5>, <nuclearcraft:ingot:5>);
infinFurnace(<nuclearcraft:ore:6>, <nuclearcraft:ingot:6>);
infinFurnace(<nuclearcraft:ore:7>, <nuclearcraft:ingot:7>);
infinFurnace(<nuclearcraft:part:21>, <nuclearcraft:part:22>);
blacklist(<nuclearcraft:plutonium:2>);
blacklist(<nuclearcraft:plutonium:3>);
blacklist(<nuclearcraft:plutonium:4>);
blacklist(<nuclearcraft:plutonium:7>);
blacklist(<nuclearcraft:plutonium:8>);
blacklist(<nuclearcraft:plutonium:9>);
blacklist(<nuclearcraft:plutonium:12>);
blacklist(<nuclearcraft:plutonium:13>);
blacklist(<nuclearcraft:plutonium:14>);
blacklist(<nuclearcraft:plutonium:17>);
blacklist(<nuclearcraft:plutonium:18>);
blacklist(<nuclearcraft:plutonium:19>);
blacklist(<nuclearcraft:uranium:2>);
blacklist(<nuclearcraft:uranium:3>);
blacklist(<nuclearcraft:uranium:4>);
blacklist(<nuclearcraft:uranium:7>);
blacklist(<nuclearcraft:uranium:8>);
blacklist(<nuclearcraft:uranium:9>);
blacklist(<nuclearcraft:uranium:12>);
blacklist(<nuclearcraft:uranium:13>);
blacklist(<nuclearcraft:uranium:14>);
infinFurnace(<opencomputers:material:2>, <opencomputers:material:4>);
blacklist(<qmd:copernicium:2>);
blacklist(<qmd:copernicium:3>);
blacklist(<qmd:copernicium:4>);
blacklist(<qmd:dust:1>);
blacklist(<qmd:dust:2>);
blacklist(<qmd:dust:5>);
blacklist(<qmd:dust:6>);
blacklist(<qmd:dust:7>);
blacklist(<qmd:dust:8>);
blacklist(<qmd:dust:9>);
blacklist(<qmd:dust:10>);
blacklist(<qmd:dust:11>);
blacklist(<qmd:dust:12>);
blacklist(<qmd:dust:13>);
blacklist(<qmd:dust:14>);
blacklist(<qmd:dust:15>);
blacklist(<qmd:dust>);
blacklist(<qmd:dust2:1>);
blacklist(<qmd:dust2>);
infinFurnace(<quark:biome_cobblestone:2>, <minecraft:stone>);
blacklist(<quark:crab_leg:*>);
infinFurnace(<quark:frog_leg:*>, <quark:cooked_frog_leg>);
infinFurnace(<quark:trowel>, <minecraft:iron_nugget>);
infinFurnace(<randomthings:beanpod>, <thaumicaugmentation:urn:2>);
infinFurnace(<randomthings:biomestone>, <randomthings:biomestone:1>);
blacklist(<rats:marbled_cheese_brick:*>);
infinFurnace(<rats:marbled_cheese_raw:*>, <rats:marbled_cheese>);
infinFurnace(<rats:rat_nugget_ore:1>.withTag({ OreItem: { id: 'thaumcraft:ore_amber', Count: 1, Damage: 0 as short }, IngotItem: { id: 'thaumcraft:amber', Count: 1, Damage: 0 as short } }), <thaumcraft:amber>);
infinFurnace(<rats:rat_nugget_ore:2>.withTag({ OreItem: { id: 'forestry:resources', Count: 1, Damage: 0 as short }, IngotItem: { id: 'forestry:apatite', Count: 1, Damage: 0 as short } }), <forestry:apatite>);
infinFurnace(<rats:rat_nugget_ore:3>.withTag({ OreItem: { id: 'astralsorcery:blockcustomsandore', Count: 1, Damage: 0 as short }, IngotItem: { id: 'astralsorcery:itemcraftingcomponent', Count: 3, Damage: 0 as short } }), <astralsorcery:itemcraftingcomponent> * 3);
infinFurnace(<rats:rat_nugget_ore:4>.withTag({ OreItem: { id: 'tconstruct:ore', Count: 1, Damage: 1 as short }, IngotItem: { id: 'tconstruct:ingots', Count: 1, Damage: 1 as short } }), <tconstruct:ingots:1>);
infinFurnace(<rats:rat_nugget_ore:5>.withTag({ OreItem: { id: 'twilightforest:armor_shard_cluster', Count: 1, Damage: 0 as short }, IngotItem: { id: 'twilightforest:knightmetal_ingot', Count: 1, Damage: 0 as short } }), <twilightforest:knightmetal_ingot>);
infinFurnace(<rats:rat_nugget_ore:6>.withTag({ OreItem: { id: 'actuallyadditions:block_misc', Count: 1, Damage: 3 as short }, IngotItem: { id: 'actuallyadditions:item_misc', Count: 1, Damage: 5 as short } }), <actuallyadditions:item_misc:5>);
infinFurnace(<rats:rat_nugget_ore:7>.withTag({ OreItem: { id: 'nuclearcraft:ore', Count: 1, Damage: 5 as short }, IngotItem: { id: 'nuclearcraft:ingot', Count: 1, Damage: 5 as short } }), <nuclearcraft:ingot:5>);
infinFurnace(<rats:rat_nugget_ore:8>.withTag({ OreItem: { id: 'thaumcraft:ore_cinnabar', Count: 1, Damage: 0 as short }, IngotItem: { id: 'thaumcraft:quicksilver', Count: 1, Damage: 0 as short } }), <thaumcraft:quicksilver>);
infinFurnace(<rats:rat_nugget_ore:9>.withTag({ OreItem: { id: 'minecraft:coal_ore', Count: 1, Damage: 0 as short }, IngotItem: { id: 'minecraft:coal', Count: 1, Damage: 0 as short } }), <minecraft:coal>);
infinFurnace(<rats:rat_nugget_ore:10>.withTag({ OreItem: { id: 'tconstruct:ore', Count: 1, Damage: 0 as short }, IngotItem: { id: 'tconstruct:ingots', Count: 1, Damage: 0 as short } }), <tconstruct:ingots>);
infinFurnace(<rats:rat_nugget_ore:11>.withTag({ OreItem: { id: 'thermalfoundation:ore', Count: 1, Damage: 0 as short }, IngotItem: { id: 'thermalfoundation:material', Count: 1, Damage: 128 as short } }), <thermalfoundation:material:128>);
infinFurnace(<rats:rat_nugget_ore:12>.withTag({ OreItem: { id: 'minecraft:diamond_ore', Count: 1, Damage: 0 as short }, IngotItem: { id: 'minecraft:diamond', Count: 1, Damage: 0 as short } }), <minecraft:diamond>);
infinFurnace(<rats:rat_nugget_ore:13>.withTag({ OreItem: { id: 'libvulpes:ore0', Count: 1, Damage: 0 as short }, IngotItem: { id: 'libvulpes:productdust', Count: 1, Damage: 0 as short } }), <libvulpes:productdust>);
infinFurnace(<rats:rat_nugget_ore:14>.withTag({ OreItem: { id: 'minecraft:emerald_ore', Count: 1, Damage: 0 as short }, IngotItem: { id: 'minecraft:emerald', Count: 1, Damage: 0 as short } }), <minecraft:emerald>);
infinFurnace(<rats:rat_nugget_ore:15>.withTag({ OreItem: { id: 'netherendingores:ore_end_modded_1', Count: 1, Damage: 0 as short }, IngotItem: { id: 'thermalfoundation:ore', Count: 2, Damage: 4 as short } }), <thermalfoundation:ore:4> * 2);
blacklist(<rats:rat_nugget_ore:16>.withTag({ OreItem: { id: 'netherendingores:ore_end_modded_2', Count: 1, Damage: 5 as short }, IngotItem: { id: 'netherendingores:ore_other_1', Count: 2, Damage: 6 as short } }));
infinFurnace(<rats:rat_nugget_ore:17>.withTag({ OreItem: { id: 'netherendingores:ore_other_1', Count: 1, Damage: 3 as short }, IngotItem: { id: 'tconstruct:ore', Count: 2, Damage: 1 as short } }), <tconstruct:ore:1> * 2);
blacklist(<rats:rat_nugget_ore:18>.withTag({ OreItem: { id: 'netherendingores:ore_end_modded_2', Count: 1, Damage: 8 as short }, IngotItem: { id: 'netherendingores:ore_other_1', Count: 2, Damage: 9 as short } }));
infinFurnace(<rats:rat_nugget_ore:19>.withTag({ OreItem: { id: 'netherendingores:ore_end_modded_1', Count: 1, Damage: 9 as short }, IngotItem: { id: 'appliedenergistics2:quartz_ore', Count: 2, Damage: 0 as short } }), <appliedenergistics2:quartz_ore> * 2);
infinFurnace(<rats:rat_nugget_ore:20>.withTag({ OreItem: { id: 'netherendingores:ore_end_modded_1', Count: 1, Damage: 10 as short }, IngotItem: { id: 'appliedenergistics2:charged_quartz_ore', Count: 2, Damage: 0 as short } }), <appliedenergistics2:charged_quartz_ore> * 2);
infinFurnace(<rats:rat_nugget_ore:21>.withTag({ OreItem: { id: 'netherendingores:ore_end_vanilla', Count: 1, Damage: 0 as short }, IngotItem: { id: 'minecraft:coal_ore', Count: 2, Damage: 0 as short } }), <minecraft:coal_ore> * 2);
infinFurnace(<rats:rat_nugget_ore:22>.withTag({ OreItem: { id: 'netherendingores:ore_other_1', Count: 1, Damage: 5 as short }, IngotItem: { id: 'tconstruct:ore', Count: 2, Damage: 0 as short } }), <tconstruct:ore> * 2);
infinFurnace(<rats:rat_nugget_ore:23>.withTag({ OreItem: { id: 'netherendingores:ore_end_modded_1', Count: 1, Damage: 1 as short }, IngotItem: { id: 'thermalfoundation:ore', Count: 2, Damage: 0 as short } }), <thermalfoundation:ore> * 2);
infinFurnace(<rats:rat_nugget_ore:24>.withTag({ OreItem: { id: 'netherendingores:ore_end_vanilla', Count: 1, Damage: 1 as short }, IngotItem: { id: 'minecraft:diamond_ore', Count: 2, Damage: 0 as short } }), <minecraft:diamond_ore> * 2);
infinFurnace(<rats:rat_nugget_ore:25>.withTag({ OreItem: { id: 'netherendingores:ore_end_modded_1', Count: 1, Damage: 14 as short }, IngotItem: { id: 'libvulpes:ore0', Count: 2, Damage: 0 as short } }), <libvulpes:ore0> * 2);
infinFurnace(<rats:rat_nugget_ore:26>.withTag({ OreItem: { id: 'netherendingores:ore_end_vanilla', Count: 1, Damage: 2 as short }, IngotItem: { id: 'minecraft:emerald_ore', Count: 2, Damage: 0 as short } }), <minecraft:emerald_ore> * 2);
infinFurnace(<rats:rat_nugget_ore:27>.withTag({ OreItem: { id: 'netherendingores:ore_end_vanilla', Count: 1, Damage: 3 as short }, IngotItem: { id: 'minecraft:gold_ore', Count: 2, Damage: 0 as short } }), <minecraft:gold_ore> * 2);
blacklist(<rats:rat_nugget_ore:28>.withTag({ OreItem: { id: 'netherendingores:ore_end_modded_2', Count: 1, Damage: 6 as short }, IngotItem: { id: 'netherendingores:ore_other_1', Count: 2, Damage: 7 as short } }));
blacklist(<rats:rat_nugget_ore:29>.withTag({ OreItem: { id: 'netherendingores:ore_end_modded_2', Count: 1, Damage: 9 as short }, IngotItem: { id: 'netherendingores:ore_other_1', Count: 2, Damage: 10 as short } }));
infinFurnace(<rats:rat_nugget_ore:30>.withTag({ OreItem: { id: 'netherendingores:ore_end_modded_1', Count: 1, Damage: 2 as short }, IngotItem: { id: 'thermalfoundation:ore', Count: 2, Damage: 7 as short } }), <thermalfoundation:ore:7> * 2);
infinFurnace(<rats:rat_nugget_ore:31>.withTag({ OreItem: { id: 'netherendingores:ore_end_vanilla', Count: 1, Damage: 4 as short }, IngotItem: { id: 'minecraft:iron_ore', Count: 2, Damage: 0 as short } }), <minecraft:iron_ore> * 2);
infinFurnace(<rats:rat_nugget_ore:32>.withTag({ OreItem: { id: 'netherendingores:ore_end_vanilla', Count: 1, Damage: 5 as short }, IngotItem: { id: 'minecraft:lapis_ore', Count: 2, Damage: 0 as short } }), <minecraft:lapis_ore> * 2);
infinFurnace(<rats:rat_nugget_ore:33>.withTag({ OreItem: { id: 'netherendingores:ore_end_modded_1', Count: 1, Damage: 3 as short }, IngotItem: { id: 'thermalfoundation:ore', Count: 2, Damage: 3 as short } }), <thermalfoundation:ore:3> * 2);
infinFurnace(<rats:rat_nugget_ore:34>.withTag({ OreItem: { id: 'netherendingores:ore_end_modded_1', Count: 1, Damage: 4 as short }, IngotItem: { id: 'thermalfoundation:ore', Count: 2, Damage: 8 as short } }), <thermalfoundation:ore:8> * 2);
infinFurnace(<rats:rat_nugget_ore:35>.withTag({ OreItem: { id: 'netherendingores:ore_end_modded_1', Count: 1, Damage: 5 as short }, IngotItem: { id: 'thermalfoundation:ore', Count: 2, Damage: 5 as short } }), <thermalfoundation:ore:5> * 2);
infinFurnace(<rats:rat_nugget_ore:36>.withTag({ OreItem: { id: 'netherendingores:ore_end_modded_1', Count: 1, Damage: 11 as short }, IngotItem: { id: 'mekanism:oreblock', Count: 2, Damage: 0 as short } }), <mekanism:oreblock> * 2);
infinFurnace(<rats:rat_nugget_ore:37>.withTag({ OreItem: { id: 'netherendingores:ore_end_modded_2', Count: 1, Damage: 3 as short }, IngotItem: { id: 'biomesoplenty:gem_ore', Count: 2, Damage: 2 as short } }), <biomesoplenty:gem_ore:2> * 2);
infinFurnace(<rats:rat_nugget_ore:38>.withTag({ OreItem: { id: 'netherendingores:ore_end_modded_1', Count: 1, Damage: 6 as short }, IngotItem: { id: 'thermalfoundation:ore', Count: 2, Damage: 6 as short } }), <thermalfoundation:ore:6> * 2);
infinFurnace(<rats:rat_nugget_ore:39>.withTag({ OreItem: { id: 'netherendingores:ore_other_1', Count: 1, Damage: 1 as short }, IngotItem: { id: 'minecraft:quartz_ore', Count: 2, Damage: 0 as short } }), <minecraft:quartz_ore> * 2);
infinFurnace(<rats:rat_nugget_ore:40>.withTag({ OreItem: { id: 'netherendingores:ore_end_vanilla', Count: 1, Damage: 6 as short }, IngotItem: { id: 'minecraft:redstone_ore', Count: 2, Damage: 0 as short } }), <minecraft:redstone_ore> * 2);
infinFurnace(<rats:rat_nugget_ore:41>.withTag({ OreItem: { id: 'netherendingores:ore_end_modded_2', Count: 1, Damage: 1 as short }, IngotItem: { id: 'biomesoplenty:gem_ore', Count: 2, Damage: 1 as short } }), <biomesoplenty:gem_ore:1> * 2);
infinFurnace(<rats:rat_nugget_ore:42>.withTag({ OreItem: { id: 'netherendingores:ore_end_modded_2', Count: 1, Damage: 2 as short }, IngotItem: { id: 'biomesoplenty:gem_ore', Count: 2, Damage: 6 as short } }), <biomesoplenty:gem_ore:6> * 2);
infinFurnace(<rats:rat_nugget_ore:43>.withTag({ OreItem: { id: 'netherendingores:ore_end_modded_1', Count: 1, Damage: 7 as short }, IngotItem: { id: 'thermalfoundation:ore', Count: 2, Damage: 2 as short } }), <thermalfoundation:ore:2> * 2);
infinFurnace(<rats:rat_nugget_ore:44>.withTag({ OreItem: { id: 'netherendingores:ore_end_modded_1', Count: 1, Damage: 8 as short }, IngotItem: { id: 'thermalfoundation:ore', Count: 2, Damage: 1 as short } }), <thermalfoundation:ore:1> * 2);
infinFurnace(<rats:rat_nugget_ore:45>.withTag({ OreItem: { id: 'netherendingores:ore_end_modded_1', Count: 1, Damage: 12 as short }, IngotItem: { id: 'immersiveengineering:ore', Count: 2, Damage: 5 as short } }), <immersiveengineering:ore:5> * 2);
blacklist(<rats:rat_nugget_ore:46>.withTag({ OreItem: { id: 'netherendingores:ore_end_modded_2', Count: 1, Damage: 7 as short }, IngotItem: { id: 'netherendingores:ore_other_1', Count: 2, Damage: 8 as short } }));
infinFurnace(<rats:rat_nugget_ore:47>.withTag({ OreItem: { id: 'biomesoplenty:gem_ore', Count: 1, Damage: 0 as short }, IngotItem: { id: 'biomesoplenty:gem', Count: 1, Damage: 0 as short } }), <biomesoplenty:gem>);
infinFurnace(<rats:rat_nugget_ore:48>.withTag({ OreItem: { id: 'draconicevolution:draconium_ore', Count: 1, Damage: 2 as short }, IngotItem: { id: 'draconicevolution:draconium_ore', Count: 2, Damage: 0 as short } }), <draconicevolution:draconium_ore> * 2);
infinFurnace(<rats:rat_nugget_ore:49>.withTag({ OreItem: { id: 'minecraft:gold_ore', Count: 1, Damage: 0 as short }, IngotItem: { id: 'minecraft:gold_ingot', Count: 1, Damage: 0 as short } }), <minecraft:gold_ingot>);
infinFurnace(<rats:rat_nugget_ore:50>.withTag({ OreItem: { id: 'thermalfoundation:ore', Count: 1, Damage: 7 as short }, IngotItem: { id: 'thermalfoundation:material', Count: 1, Damage: 135 as short } }), <thermalfoundation:material:135>);
infinFurnace(<rats:rat_nugget_ore:51>.withTag({ OreItem: { id: 'minecraft:iron_ore', Count: 1, Damage: 0 as short }, IngotItem: { id: 'minecraft:iron_ingot', Count: 1, Damage: 0 as short } }), <minecraft:iron_ingot>);
infinFurnace(<rats:rat_nugget_ore:52>.withTag({ OreItem: { id: 'minecraft:lapis_ore', Count: 1, Damage: 0 as short }, IngotItem: { id: 'minecraft:dye', Count: 1, Damage: 4 as short } }), <minecraft:dye:4>);
infinFurnace(<rats:rat_nugget_ore:53>.withTag({ OreItem: { id: 'thermalfoundation:ore', Count: 1, Damage: 3 as short }, IngotItem: { id: 'thermalfoundation:material', Count: 1, Damage: 131 as short } }), <thermalfoundation:material:131>);
infinFurnace(<rats:rat_nugget_ore:54>.withTag({ OreItem: { id: 'nuclearcraft:ore', Count: 1, Damage: 6 as short }, IngotItem: { id: 'nuclearcraft:ingot', Count: 1, Damage: 6 as short } }), <nuclearcraft:ingot:6>);
infinFurnace(<rats:rat_nugget_ore:55>.withTag({ OreItem: { id: 'nuclearcraft:ore', Count: 1, Damage: 7 as short }, IngotItem: { id: 'nuclearcraft:ingot', Count: 1, Damage: 7 as short } }), <nuclearcraft:ingot:7>);
infinFurnace(<rats:rat_nugget_ore:56>.withTag({ OreItem: { id: 'biomesoplenty:gem_ore', Count: 1, Damage: 5 as short }, IngotItem: { id: 'biomesoplenty:gem', Count: 1, Damage: 5 as short } }), <biomesoplenty:gem:5>);
infinFurnace(<rats:rat_nugget_ore:57>.withTag({ OreItem: { id: 'thermalfoundation:ore', Count: 1, Damage: 8 as short }, IngotItem: { id: 'thermalfoundation:material', Count: 1, Damage: 136 as short } }), <thermalfoundation:material:136>);
infinFurnace(<rats:rat_nugget_ore:81>.withTag({ OreItem: { id: 'minecraft:quartz_ore', Count: 1, Damage: 0 as short }, IngotItem: { id: 'minecraft:quartz', Count: 1, Damage: 0 as short } }), <minecraft:quartz>);
infinFurnace(<rats:rat_nugget_ore:89>.withTag({ OreItem: { id: 'thermalfoundation:ore', Count: 1, Damage: 5 as short }, IngotItem: { id: 'thermalfoundation:material', Count: 1, Damage: 133 as short } }), <thermalfoundation:material:133>);
infinFurnace(<rats:rat_nugget_ore:90>.withTag({ OreItem: { id: 'mekanism:oreblock', Count: 1, Damage: 0 as short }, IngotItem: { id: 'mekanism:ingot', Count: 1, Damage: 1 as short } }), <mekanism:ingot:1>);
infinFurnace(<rats:rat_nugget_ore:91>.withTag({ OreItem: { id: 'biomesoplenty:gem_ore', Count: 1, Damage: 2 as short }, IngotItem: { id: 'biomesoplenty:gem', Count: 1, Damage: 2 as short } }), <biomesoplenty:gem:2>);
infinFurnace(<rats:rat_nugget_ore:92>.withTag({ OreItem: { id: 'contenttweaker:ore_phosphor', Count: 1, Damage: 0 as short }, IngotItem: { id: 'contenttweaker:nugget_phosphor', Count: 1, Damage: 0 as short } }), <contenttweaker:nugget_phosphor>);
infinFurnace(<rats:rat_nugget_ore:93>.withTag({ OreItem: { id: 'thermalfoundation:ore', Count: 1, Damage: 6 as short }, IngotItem: { id: 'thermalfoundation:material', Count: 1, Damage: 134 as short } }), <thermalfoundation:material:134>);
infinFurnace(<rats:rat_nugget_ore:94>.withTag({ OreItem: { id: 'twilightforest:ironwood_raw', Count: 1, Damage: 0 as short }, IngotItem: { id: 'twilightforest:ironwood_ingot', Count: 2, Damage: 0 as short } }), <twilightforest:ironwood_ingot> * 2);
infinFurnace(<rats:rat_nugget_ore:95>.withTag({ OreItem: { id: 'minecraft:redstone_ore', Count: 1, Damage: 0 as short }, IngotItem: { id: 'minecraft:redstone', Count: 1, Damage: 0 as short } }), <minecraft:redstone>);
infinFurnace(<rats:rat_nugget_ore:96>.withTag({ OreItem: { id: 'astralsorcery:blockcustomore', Count: 1, Damage: 0 as short }, IngotItem: { id: 'mysticalagriculture:prosperity_ore', Count: 1, Damage: 0 as short } }), <mysticalagriculture:prosperity_ore>);
infinFurnace(<rats:rat_nugget_ore:97>.withTag({ OreItem: { id: 'biomesoplenty:gem_ore', Count: 1, Damage: 1 as short }, IngotItem: { id: 'biomesoplenty:gem', Count: 1, Damage: 1 as short } }), <biomesoplenty:gem:1>);
infinFurnace(<rats:rat_nugget_ore:98>.withTag({ OreItem: { id: 'biomesoplenty:gem_ore', Count: 1, Damage: 6 as short }, IngotItem: { id: 'biomesoplenty:gem', Count: 1, Damage: 6 as short } }), <biomesoplenty:gem:6>);
infinFurnace(<rats:rat_nugget_ore:99>.withTag({ OreItem: { id: 'thermalfoundation:ore', Count: 1, Damage: 2 as short }, IngotItem: { id: 'thermalfoundation:material', Count: 1, Damage: 130 as short } }), <thermalfoundation:material:130>);
infinFurnace(<rats:rat_nugget_ore:100>.withTag({ OreItem: { id: 'astralsorcery:blockcustomore', Count: 1, Damage: 1 as short }, IngotItem: { id: 'astralsorcery:itemcraftingcomponent', Count: 1, Damage: 1 as short } }), <astralsorcery:itemcraftingcomponent:1>);
infinFurnace(<rats:rat_nugget_ore:101>.withTag({ OreItem: { id: 'biomesoplenty:gem_ore', Count: 1, Damage: 4 as short }, IngotItem: { id: 'biomesoplenty:gem', Count: 1, Damage: 4 as short } }), <biomesoplenty:gem:4>);
infinFurnace(<rats:rat_nugget_ore:102>.withTag({ OreItem: { id: 'nuclearcraft:ore', Count: 1, Damage: 3 as short }, IngotItem: { id: 'nuclearcraft:ingot', Count: 1, Damage: 3 as short } }), <nuclearcraft:ingot:3>);
infinFurnace(<rats:rat_nugget_ore:103>.withTag({ OreItem: { id: 'thermalfoundation:ore', Count: 1, Damage: 1 as short }, IngotItem: { id: 'thermalfoundation:material', Count: 1, Damage: 129 as short } }), <thermalfoundation:material:129>);
infinFurnace(<rats:rat_nugget_ore:104>.withTag({ OreItem: { id: 'biomesoplenty:gem_ore', Count: 1, Damage: 3 as short }, IngotItem: { id: 'biomesoplenty:gem', Count: 1, Damage: 3 as short } }), <biomesoplenty:gem:3>);
infinFurnace(<rats:rat_nugget_ore:105>.withTag({ OreItem: { id: 'endreborn:block_wolframium_ore', Count: 1, Damage: 0 as short }, IngotItem: { id: 'endreborn:item_ingot_wolframium', Count: 1, Damage: 0 as short } }), <endreborn:item_ingot_wolframium>);
infinFurnace(<rats:rat_nugget_ore:106>.withTag({ OreItem: { id: 'immersiveengineering:ore', Count: 1, Damage: 5 as short }, IngotItem: { id: 'immersiveengineering:metal', Count: 1, Damage: 5 as short } }), <immersiveengineering:metal:5>);
infinFurnace(<rats:rat_nugget_ore>.withTag({ OreItem: { id: 'thermalfoundation:ore', Count: 1, Damage: 4 as short }, IngotItem: { id: 'thermalfoundation:material', Count: 1, Damage: 132 as short } }), <thermalfoundation:material:132>);
infinFurnace(<rats:raw_rat:*>, <rats:cooked_rat>);
blacklist(<rustic:dust_gold>);
blacklist(<rustic:dust_tiny_iron>);
infinFurnace(<rustic:honeycomb>, <rustic:beeswax>);
// SKIP: <rustic:log:1>
// SKIP: <rustic:log>
infinFurnace(<tcomplement:scorched_block:1>, <tcomplement:scorched_block>);
blacklist(<tcomplement:scorched_block:3>);
blacklist(<tcomplement:scorched_slab:3>);
blacklist(<tcomplement:scorched_stairs_brick:*>);
infinFurnace(<tconevo:earth_material_block>, <tconevo:material:1>);
infinFurnace(<tconevo:edible>, <tconevo:edible:1>);
blacklist(<tconevo:metal:1>);
blacklist(<tconevo:metal:6>);
blacklist(<tconevo:metal:11>);
blacklist(<tconevo:metal:16>);
blacklist(<tconevo:metal:21>);
blacklist(<tconevo:metal:26>);
blacklist(<tconevo:metal:31>);
blacklist(<tconevo:metal:36>);
blacklist(<tconevo:metal:41>);
infinFurnace(<tconstruct:brownstone:1>, <tconstruct:brownstone>);
blacklist(<tconstruct:brownstone:3>);
infinFurnace(<tconstruct:ore:1>, <tconstruct:ingots:1>);
infinFurnace(<tconstruct:ore>, <tconstruct:ingots>);
blacklist(<tconstruct:seared:3>);
infinFurnace(<tconstruct:slime_congealed:1>, <tconstruct:slime_channel:1> * 3);
infinFurnace(<tconstruct:slime_congealed:2>, <tconstruct:slime_channel:2> * 3);
infinFurnace(<tconstruct:slime_congealed:3>, <tconstruct:slime_channel:3> * 3);
infinFurnace(<tconstruct:slime_congealed:4>, <tconstruct:slime_channel:4> * 3);
blacklist(<tconstruct:slime_congealed:5>);
infinFurnace(<tconstruct:slime_congealed>, <tconstruct:slime_channel> * 3);
infinFurnace(<tconstruct:soil:1>, <tconstruct:materials:9>);
infinFurnace(<tconstruct:soil:2>, <tconstruct:materials:10>);
infinFurnace(<tconstruct:soil:3>, <tconstruct:soil:4>);
infinFurnace(<tconstruct:soil:5>, <tconstruct:materials:11>);
infinFurnace(<tconstruct:soil>, <tconstruct:materials>);
infinFurnace(<tconstruct:spaghetti:2>, <tconstruct:moms_spaghetti>);
infinFurnace(<thaumcraft:cluster:1>, <minecraft:gold_ingot> * 2);
infinFurnace(<thaumcraft:cluster:2>, <thermalfoundation:material:128> * 2);
infinFurnace(<thaumcraft:cluster:3>, <thermalfoundation:material:129> * 2);
infinFurnace(<thaumcraft:cluster:4>, <thermalfoundation:material:130> * 2);
infinFurnace(<thaumcraft:cluster:5>, <thermalfoundation:material:131> * 2);
infinFurnace(<thaumcraft:cluster:6>, <thaumcraft:quicksilver> * 2);
infinFurnace(<thaumcraft:cluster:7>, <minecraft:quartz> * 5);
infinFurnace(<thaumcraft:cluster>, <minecraft:iron_ingot> * 2);
// SKIP: <thaumcraft:log_greatwood:*>
// SKIP: <thaumcraft:log_silverwood:*>
infinFurnace(<thaumcraft:ore_amber:*>, <thaumcraft:amber>);
infinFurnace(<thaumcraft:ore_cinnabar:*>, <thaumcraft:quicksilver>);
blacklist(<thaumcraft:ore_quartz:*>);
infinFurnace(<thaumicaugmentation:stone:10>, <thaumcraft:stone_ancient_rock>);
blacklist(<thermalfoundation:material:1>);
blacklist(<thermalfoundation:material:64>);
blacklist(<thermalfoundation:material:65>);
blacklist(<thermalfoundation:material:66>);
blacklist(<thermalfoundation:material:67>);
blacklist(<thermalfoundation:material:68>);
blacklist(<thermalfoundation:material:69>);
blacklist(<thermalfoundation:material:70>);
blacklist(<thermalfoundation:material:71>);
blacklist(<thermalfoundation:material:72>);
blacklist(<thermalfoundation:material:96>);
blacklist(<thermalfoundation:material:97>);
blacklist(<thermalfoundation:material:98>);
blacklist(<thermalfoundation:material:99>);
blacklist(<thermalfoundation:material:100>);
infinFurnace(<thermalfoundation:material:801>, <minecraft:coal:1>);
blacklist(<thermalfoundation:material:864>);
blacklist(<thermalfoundation:material>);
infinFurnace(<thermalfoundation:ore:1>, <thermalfoundation:material:129>);
infinFurnace(<thermalfoundation:ore:2>, <thermalfoundation:material:130>);
infinFurnace(<thermalfoundation:ore:3>, <thermalfoundation:material:131>);
infinFurnace(<thermalfoundation:ore:4>, <thermalfoundation:material:132>);
infinFurnace(<thermalfoundation:ore:5>, <thermalfoundation:material:133>);
infinFurnace(<thermalfoundation:ore:6>, <thermalfoundation:material:134>);
infinFurnace(<thermalfoundation:ore:7>, <thermalfoundation:material:135>);
infinFurnace(<thermalfoundation:ore:8>, <thermalfoundation:material:136>);
infinFurnace(<thermalfoundation:ore>, <thermalfoundation:material:128>);
infinFurnace(<threng:material:2>, <threng:material>);
blacklist(<trinity:barium>);
blacklist(<trinity:dust_au_198:*>);
infinFurnace(<twilightforest:armor_shard_cluster:*>, <twilightforest:knightmetal_ingot>);
infinFurnace(<twilightforest:ironwood_raw:*>, <twilightforest:ironwood_ingot> * 2);
// SKIP: <twilightforest:magic_log:*>
infinFurnace(<twilightforest:raw_meef:*>, <twilightforest:cooked_meef>);
infinFurnace(<twilightforest:raw_venison:*>, <twilightforest:cooked_venison>);
// SKIP: <twilightforest:twilight_log:*>
/**/
