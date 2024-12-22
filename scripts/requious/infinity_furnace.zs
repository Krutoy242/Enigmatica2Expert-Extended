#modloaded requious
#priority -150

import crafttweaker.data.IData;
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
  if (isNull(inp) || isNull(out)) return;

  val assRecipe = AssemblyRecipe.create(function (c) {
    c.addItemOutput('output', out * min(64, out.amount * 4));
  })
    .requireItem('input', inp)
    .requireDuration('duration', 1);

  <assembly:infinity_furnace>.addJEIRecipe(assRecipe);
}

// Wildcard
static W as int = <minecraft:dirt:*>.damage;

static blacklistedInput as bool[IItemStack] = {} as bool[IItemStack];
static blacklistedWildcard as bool[string] = {} as bool[string];

function blacklist(id as string, damage as int = 0, amount as int = 1, tag as IData = null) as void {
  // Wildcarded input
  if (damage == W) {
    blacklistedWildcard[id] = true;
  }
  else {
    val item = utils.get(id, damage/* , amount, tag */);
    if (isNull(item)) {
      utils.log('Cant find item for blacklisting in Infinity Furnace: ' ~ id ~ ':' ~ damage);
      return;
    }
    blacklistedInput[item] = true;
  }
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
  ) return false;

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
      || !isNull(blacklistedInput[input]))
      return;

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
    ) return; // Item is unsmeltable

    if (pushToOutput(smelted * min(64, smelted.amount * 4), c))
      c.machine.setItem(inpX, inpY, inputStack.amount > 1 ? inputStack.withAmount(inputStack.amount - 1) : null);
  })
    .requireWorldCondition('has_input', function (m) {
    val inputStack = m.getItem(inpX, inpY);
      if (isNull(inputStack)) return false;
      val input = inputStack.anyAmount();

      // Skip if blacklisted
      if (!isNull(blacklistedWildcard[input.definition.id])
        || !isNull(blacklistedInput[input]))
        return false;
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
rats:marbled_cheese_brick
rustic:dust_tiny_iron
tcomplement:scorched_block:3
tcomplement:scorched_slab:3
tcomplement:scorched_stairs_brick
tconstruct:brownstone:3
tconstruct:seared:3
thermalfoundation:material:864
`.trim().split('\n'))

const commandString = (id, meta, nbt, amount) => {
  let s = `'${id}'`
  ;(meta || amount || nbt) && (s += `, ${meta === '*' ? 'W' : (meta || 0)}`)
  ;((amount && parseInt(amount) > 1) || nbt) && (s += `, ${amount || 1}`)
  ;(nbt) && (s += `, ${nbt}`)
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

  return `infinFurnace(utils.get(${
    inpCommandStr}), utils.get(${
    commandString(out_id, out_meta, out_tag, out_amount)}));`
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

// Total Furnace recipes registered: 918
// Blacklisted by JEI or manually: 77
// Filtered by oredict: 150
infinFurnace(utils.get('actuallyadditions:block_misc', 3), utils.get('actuallyadditions:item_misc', 5));
blacklist('actuallyadditions:item_dust', 3);
blacklist('actuallyadditions:item_dust', 7);
infinFurnace(utils.get('actuallyadditions:item_misc', 4), utils.get('actuallyadditions:item_food', 15));
infinFurnace(utils.get('actuallyadditions:item_misc', 9), utils.get('actuallyadditions:item_food', 17));
infinFurnace(utils.get('actuallyadditions:item_misc', 20), utils.get('minecraft:iron_ingot', 0, 2));
infinFurnace(utils.get('actuallyadditions:item_misc', 21), utils.get('actuallyadditions:item_misc', 22));
blacklist('advancedrocketry:productdust', 1);
blacklist('advancedrocketry:productdust');
infinFurnace(utils.get('appliedenergistics2:material', 2), utils.get('appliedenergistics2:material', 5));
infinFurnace(utils.get('appliedenergistics2:material', 3), utils.get('appliedenergistics2:material', 5));
infinFurnace(utils.get('appliedenergistics2:material', 4), utils.get('minecraft:bread'));
blacklist('appliedenergistics2:material', 49);
blacklist('appliedenergistics2:material', 51);
infinFurnace(utils.get('appliedenergistics2:sky_stone_block'), utils.get('appliedenergistics2:smooth_sky_stone_block'));
infinFurnace(utils.get('astralsorcery:blockcustomore', 1), utils.get('astralsorcery:itemcraftingcomponent', 1));
infinFurnace(utils.get('astralsorcery:blockcustomsandore'), utils.get('astralsorcery:itemcraftingcomponent', 0, 3));
blacklist('betteranimalsplus:crab_meat_raw');
infinFurnace(utils.get('betteranimalsplus:eel_meat_raw'), utils.get('betteranimalsplus:eel_meat_cooked'));
infinFurnace(utils.get('betteranimalsplus:golden_goose_egg'), utils.get('minecraft:gold_ingot'));
infinFurnace(utils.get('betteranimalsplus:goose_egg'), utils.get('betteranimalsplus:fried_egg'));
infinFurnace(utils.get('betteranimalsplus:pheasant_egg'), utils.get('betteranimalsplus:fried_egg'));
infinFurnace(utils.get('betteranimalsplus:pheasantraw'), utils.get('betteranimalsplus:pheasantcooked'));
infinFurnace(utils.get('betteranimalsplus:turkey_egg'), utils.get('betteranimalsplus:fried_egg'));
infinFurnace(utils.get('betteranimalsplus:turkey_raw'), utils.get('betteranimalsplus:turkey_cooked'));
infinFurnace(utils.get('betteranimalsplus:venisonraw'), utils.get('betteranimalsplus:venisoncooked'));
infinFurnace(utils.get('biomesoplenty:gem_ore', 1), utils.get('biomesoplenty:gem', 1));
infinFurnace(utils.get('biomesoplenty:gem_ore', 2), utils.get('biomesoplenty:gem', 2));
infinFurnace(utils.get('biomesoplenty:gem_ore', 3), utils.get('biomesoplenty:gem', 3));
infinFurnace(utils.get('biomesoplenty:gem_ore', 4), utils.get('biomesoplenty:gem', 4));
infinFurnace(utils.get('biomesoplenty:gem_ore', 5), utils.get('biomesoplenty:gem', 5));
infinFurnace(utils.get('biomesoplenty:gem_ore', 6), utils.get('biomesoplenty:gem', 6));
infinFurnace(utils.get('biomesoplenty:gem_ore'), utils.get('biomesoplenty:gem'));
// SKIP: 'biomesoplenty:log_0', 4
// SKIP: 'biomesoplenty:log_0', 5
// SKIP: 'biomesoplenty:log_0', 6
// SKIP: 'biomesoplenty:log_0', 7
// SKIP: 'biomesoplenty:log_1', 4
// SKIP: 'biomesoplenty:log_1', 5
// SKIP: 'biomesoplenty:log_1', 6
// SKIP: 'biomesoplenty:log_1', 7
// SKIP: 'biomesoplenty:log_2', 4
// SKIP: 'biomesoplenty:log_2', 5
// SKIP: 'biomesoplenty:log_2', 6
// SKIP: 'biomesoplenty:log_2', 7
// SKIP: 'biomesoplenty:log_3', 4
// SKIP: 'biomesoplenty:log_3', 5
// SKIP: 'biomesoplenty:log_3', 6
// SKIP: 'biomesoplenty:log_3', 7
// SKIP: 'biomesoplenty:log_4', 5
blacklist('biomesoplenty:mud');
blacklist('biomesoplenty:mudball');
infinFurnace(utils.get('biomesoplenty:plant_1', 6), utils.get('minecraft:dye', 2));
infinFurnace(utils.get('biomesoplenty:white_sand'), utils.get('minecraft:glass'));
blacklist('bloodmagic:component', 19);
blacklist('bloodmagic:component', 20);
blacklist('botania:biomestonea', 8);
blacklist('botania:biomestonea', 9);
blacklist('botania:biomestonea', 10);
blacklist('botania:biomestonea', 11);
blacklist('botania:biomestonea', 12);
blacklist('botania:biomestonea', 13);
blacklist('botania:biomestonea', 14);
blacklist('botania:biomestonea', 15);
infinFurnace(utils.get('cathedral:claytile'), utils.get('cathedral:firedtile'));
infinFurnace(utils.get('claybucket:unfiredclaybucket', W), utils.get('claybucket:claybucket'));
infinFurnace(utils.get('contenttweaker:ore_phosphor'), utils.get('contenttweaker:nugget_phosphor'));
infinFurnace(utils.get('cookingforblockheads:recipe_book'), utils.get('cookingforblockheads:recipe_book', 1));
blacklist('draconicevolution:draconium_dust', W);
infinFurnace(utils.get('draconicevolution:draconium_ore', W), utils.get('draconicevolution:draconium_ingot'));
blacklist('enderio:item_material', 21);
blacklist('enderio:item_material', 24);
blacklist('enderio:item_material', 25);
blacklist('enderio:item_material', 26);
blacklist('enderio:item_material', 27);
blacklist('enderio:item_material', 30);
blacklist('enderio:item_material', 31);
blacklist('enderio:item_material', 74);
blacklist('enderio:item_owl_egg');
infinFurnace(utils.get('endreborn:block_wolframium_ore', W), utils.get('endreborn:item_ingot_wolframium'));
infinFurnace(utils.get('exnihilocreatio:item_material', 2), utils.get('exnihilocreatio:item_cooked_silkworm'));
blacklist('exnihilocreatio:item_ore_ardite', 2);
blacklist('exnihilocreatio:item_ore_cobalt', 2);
infinFurnace(utils.get('extrautils2:decorativesolid', 4), utils.get('extrautils2:decorativeglass'));
// SKIP: 'extrautils2:ironwood_log', W
infinFurnace(utils.get('forestry:ash'), utils.get('tconstruct:materials'));
// SKIP: 'forestry:logs.0', W
// SKIP: 'forestry:logs.1', W
// SKIP: 'forestry:logs.2', W
// SKIP: 'forestry:logs.3', W
// SKIP: 'forestry:logs.4', W
// SKIP: 'forestry:logs.5', W
// SKIP: 'forestry:logs.6', W
// SKIP: 'forestry:logs.7', W
infinFurnace(utils.get('forestry:peat'), utils.get('forestry:ash'));
infinFurnace(utils.get('forestry:resources'), utils.get('forestry:apatite'));
blacklist('gendustry:gene_sample', W);
blacklist('gendustry:gene_template', W);
infinFurnace(utils.get('gendustry:honey_drop', 5), utils.get('appliedenergistics2:material', 5, 2));
infinFurnace(utils.get('harvestcraft:anchovyrawitem', W), utils.get('minecraft:cooked_fish'));
infinFurnace(utils.get('harvestcraft:bassrawitem', W), utils.get('minecraft:cooked_fish'));
infinFurnace(utils.get('harvestcraft:calamarirawitem', W), utils.get('harvestcraft:calamaricookeditem'));
infinFurnace(utils.get('harvestcraft:carprawitem', W), utils.get('minecraft:cooked_fish'));
infinFurnace(utils.get('harvestcraft:catfishrawitem', W), utils.get('minecraft:cooked_fish'));
infinFurnace(utils.get('harvestcraft:charrrawitem', W), utils.get('minecraft:cooked_fish'));
infinFurnace(utils.get('harvestcraft:clamrawitem', W), utils.get('harvestcraft:clamcookeditem'));
infinFurnace(utils.get('harvestcraft:crabrawitem', W), utils.get('harvestcraft:crabcookeditem'));
infinFurnace(utils.get('harvestcraft:crayfishrawitem', W), utils.get('harvestcraft:crayfishcookeditem'));
infinFurnace(utils.get('harvestcraft:duckrawitem', W), utils.get('harvestcraft:duckcookeditem'));
infinFurnace(utils.get('harvestcraft:eelrawitem', W), utils.get('minecraft:cooked_fish'));
infinFurnace(utils.get('harvestcraft:frograwitem', W), utils.get('harvestcraft:frogcookeditem'));
infinFurnace(utils.get('harvestcraft:greenheartfishitem', W), utils.get('minecraft:cooked_fish'));
infinFurnace(utils.get('harvestcraft:grouperrawitem', W), utils.get('minecraft:cooked_fish'));
infinFurnace(utils.get('harvestcraft:grubitem', W), utils.get('harvestcraft:cookedgrubitem'));
infinFurnace(utils.get('harvestcraft:herringrawitem', W), utils.get('minecraft:cooked_fish'));
infinFurnace(utils.get('harvestcraft:mudfishrawitem', W), utils.get('minecraft:cooked_fish'));
infinFurnace(utils.get('harvestcraft:musselrawitem', W), utils.get('harvestcraft:musselcookeditem'));
infinFurnace(utils.get('harvestcraft:octopusrawitem', W), utils.get('harvestcraft:octopuscookeditem'));
infinFurnace(utils.get('harvestcraft:oysterrawitem', W), utils.get('harvestcraft:oystercookeditem'));
infinFurnace(utils.get('harvestcraft:perchrawitem', W), utils.get('minecraft:cooked_fish'));
infinFurnace(utils.get('harvestcraft:rawtofabbititem', W), utils.get('harvestcraft:cookedtofabbititem'));
infinFurnace(utils.get('harvestcraft:rawtofaconitem', W), utils.get('harvestcraft:cookedtofaconitem'));
infinFurnace(utils.get('harvestcraft:rawtofeakitem', W), utils.get('harvestcraft:cookedtofeakitem'));
infinFurnace(utils.get('harvestcraft:rawtofeegitem', W), utils.get('harvestcraft:cookedtofeegitem'));
infinFurnace(utils.get('harvestcraft:rawtofenisonitem', W), utils.get('harvestcraft:cookedtofenisonitem'));
infinFurnace(utils.get('harvestcraft:rawtofickenitem', W), utils.get('harvestcraft:cookedtofickenitem'));
infinFurnace(utils.get('harvestcraft:rawtofishitem', W), utils.get('harvestcraft:cookedtofishitem'));
infinFurnace(utils.get('harvestcraft:rawtofuduckitem', W), utils.get('harvestcraft:cookedtofuduckitem'));
infinFurnace(utils.get('harvestcraft:rawtofurkeyitem', W), utils.get('harvestcraft:cookedtofurkeyitem'));
infinFurnace(utils.get('harvestcraft:rawtofuttonitem', W), utils.get('harvestcraft:cookedtofuttonitem'));
infinFurnace(utils.get('harvestcraft:sardinerawitem', W), utils.get('minecraft:cooked_fish'));
infinFurnace(utils.get('harvestcraft:scalloprawitem', W), utils.get('harvestcraft:scallopcookeditem'));
infinFurnace(utils.get('harvestcraft:shrimprawitem', W), utils.get('harvestcraft:shrimpcookeditem'));
infinFurnace(utils.get('harvestcraft:snailrawitem', W), utils.get('harvestcraft:snailcookeditem'));
infinFurnace(utils.get('harvestcraft:snapperrawitem', W), utils.get('minecraft:cooked_fish'));
infinFurnace(utils.get('harvestcraft:tilapiarawitem', W), utils.get('minecraft:cooked_fish'));
infinFurnace(utils.get('harvestcraft:troutrawitem', W), utils.get('minecraft:cooked_fish'));
infinFurnace(utils.get('harvestcraft:tunarawitem', W), utils.get('minecraft:cooked_fish'));
infinFurnace(utils.get('harvestcraft:turkeyrawitem', W), utils.get('harvestcraft:turkeycookeditem'));
infinFurnace(utils.get('harvestcraft:turtlerawitem', W), utils.get('harvestcraft:turtlecookeditem'));
infinFurnace(utils.get('harvestcraft:venisonrawitem', W), utils.get('harvestcraft:venisoncookeditem'));
infinFurnace(utils.get('harvestcraft:walleyerawitem', W), utils.get('minecraft:cooked_fish'));
infinFurnace(utils.get('ic2:crafting', 27), utils.get('ic2:crystal_memory'));
infinFurnace(utils.get('ic2:crushed', 1), utils.get('minecraft:gold_ingot'));
infinFurnace(utils.get('ic2:crushed', 2), utils.get('minecraft:iron_ingot'));
infinFurnace(utils.get('ic2:crushed', 3), utils.get('thermalfoundation:material', 131));
infinFurnace(utils.get('ic2:crushed', 4), utils.get('thermalfoundation:material', 130));
infinFurnace(utils.get('ic2:crushed', 5), utils.get('thermalfoundation:material', 129));
infinFurnace(utils.get('ic2:crushed', 6), utils.get('immersiveengineering:metal', 5));
infinFurnace(utils.get('ic2:crushed'), utils.get('thermalfoundation:material', 128));
blacklist('ic2:dust', 3);
blacklist('ic2:dust', 11);
infinFurnace(utils.get('ic2:dust', 15), utils.get('tconstruct:materials'));
infinFurnace(utils.get('ic2:misc_resource', 4), utils.get('ic2:crafting'));
infinFurnace(utils.get('ic2:mug', 1), utils.get('ic2:mug', 2));
infinFurnace(utils.get('ic2:purified', 1), utils.get('minecraft:gold_ingot'));
infinFurnace(utils.get('ic2:purified', 2), utils.get('minecraft:iron_ingot'));
infinFurnace(utils.get('ic2:purified', 3), utils.get('thermalfoundation:material', 131));
infinFurnace(utils.get('ic2:purified', 4), utils.get('thermalfoundation:material', 130));
infinFurnace(utils.get('ic2:purified', 5), utils.get('thermalfoundation:material', 129));
infinFurnace(utils.get('ic2:purified', 6), utils.get('immersiveengineering:metal', 5));
infinFurnace(utils.get('ic2:purified'), utils.get('thermalfoundation:material', 128));
// SKIP: 'ic2:rubber_wood', W
blacklist('iceandfire:dread_stone_bricks', W);
infinFurnace(utils.get('iceandfire:frozen_cobblestone', W), utils.get('minecraft:cobblestone'));
infinFurnace(utils.get('iceandfire:frozen_dirt', W), utils.get('minecraft:dirt'));
infinFurnace(utils.get('iceandfire:frozen_grass_path', W), utils.get('minecraft:grass_path'));
infinFurnace(utils.get('iceandfire:frozen_grass', W), utils.get('minecraft:grass'));
infinFurnace(utils.get('iceandfire:frozen_gravel', W), utils.get('minecraft:gravel'));
infinFurnace(utils.get('iceandfire:frozen_splinters', W), utils.get('minecraft:stick', 0, 3));
infinFurnace(utils.get('iceandfire:frozen_stone', W), utils.get('minecraft:stone'));
infinFurnace(utils.get('iceandfire:stymphalian_bird_feather', W), utils.get('thermalfoundation:material', 227));
infinFurnace(utils.get('immersiveengineering:material', 7), utils.get('thermalfoundation:rockwool', 7));
blacklist('immersiveengineering:material', 18);
blacklist('immersiveengineering:metal', 14);
infinFurnace(utils.get('immersiveengineering:ore', 5), utils.get('immersiveengineering:metal', 5));
infinFurnace(utils.get('industrialforegoing:dryrubber', W), utils.get('industrialforegoing:plastic'));
// SKIP: 'integrateddynamics:menril_log_filled'
// SKIP: 'integrateddynamics:menril_log'
infinFurnace(utils.get('jaopca:item_chunkaluminium'), utils.get('jaopca:item_dirtygemaluminium', 0, 10));
infinFurnace(utils.get('jaopca:item_chunkamber'), utils.get('jaopca:item_dirtygemamber', 0, 10));
infinFurnace(utils.get('jaopca:item_chunkamethyst'), utils.get('jaopca:item_dirtygemamethyst', 0, 10));
infinFurnace(utils.get('jaopca:item_chunkapatite'), utils.get('jaopca:item_dirtygemapatite', 0, 10));
infinFurnace(utils.get('jaopca:item_chunkaquamarine'), utils.get('jaopca:item_dirtygemaquamarine', 0, 10));
infinFurnace(utils.get('jaopca:item_chunkardite'), utils.get('jaopca:item_dirtygemardite', 0, 10));
infinFurnace(utils.get('jaopca:item_chunkastralstarmetal'), utils.get('jaopca:item_dirtygemastralstarmetal', 0, 10));
infinFurnace(utils.get('jaopca:item_chunkboron'), utils.get('jaopca:item_dirtygemboron', 0, 10));
infinFurnace(utils.get('jaopca:item_chunkcertusquartz'), utils.get('jaopca:item_dirtygemcertusquartz', 0, 10));
infinFurnace(utils.get('jaopca:item_chunkchargedcertusquartz'), utils.get('jaopca:item_dirtygemchargedcertusquartz', 0, 10));
infinFurnace(utils.get('jaopca:item_chunkcoal'), utils.get('jaopca:item_dirtygemcoal', 0, 10));
infinFurnace(utils.get('jaopca:item_chunkcobalt'), utils.get('jaopca:item_dirtygemcobalt', 0, 10));
infinFurnace(utils.get('jaopca:item_chunkcopper'), utils.get('jaopca:item_dirtygemcopper', 0, 10));
infinFurnace(utils.get('jaopca:item_chunkdiamond'), utils.get('jaopca:item_dirtygemdiamond', 0, 10));
infinFurnace(utils.get('jaopca:item_chunkdilithium'), utils.get('jaopca:item_dirtygemdilithium', 0, 10));
infinFurnace(utils.get('jaopca:item_chunkdimensionalshard'), utils.get('jaopca:item_dirtygemdimensionalshard', 0, 10));
infinFurnace(utils.get('jaopca:item_chunkdraconium'), utils.get('jaopca:item_dirtygemdraconium', 0, 10));
infinFurnace(utils.get('jaopca:item_chunkemerald'), utils.get('jaopca:item_dirtygememerald', 0, 10));
infinFurnace(utils.get('jaopca:item_chunkgold'), utils.get('jaopca:item_dirtygemgold', 0, 10));
infinFurnace(utils.get('jaopca:item_chunkiridium'), utils.get('jaopca:item_dirtygemiridium', 0, 10));
infinFurnace(utils.get('jaopca:item_chunkiron'), utils.get('jaopca:item_dirtygemiron', 0, 10));
infinFurnace(utils.get('jaopca:item_chunklapis'), utils.get('jaopca:item_dirtygemlapis', 0, 10));
infinFurnace(utils.get('jaopca:item_chunklead'), utils.get('jaopca:item_dirtygemlead', 0, 10));
infinFurnace(utils.get('jaopca:item_chunklithium'), utils.get('jaopca:item_dirtygemlithium', 0, 10));
infinFurnace(utils.get('jaopca:item_chunkmagnesium'), utils.get('jaopca:item_dirtygemmagnesium', 0, 10));
infinFurnace(utils.get('jaopca:item_chunkmalachite'), utils.get('jaopca:item_dirtygemmalachite', 0, 10));
infinFurnace(utils.get('jaopca:item_chunkmithril'), utils.get('jaopca:item_dirtygemmithril', 0, 10));
infinFurnace(utils.get('jaopca:item_chunknickel'), utils.get('jaopca:item_dirtygemnickel', 0, 10));
infinFurnace(utils.get('jaopca:item_chunkosmium'), utils.get('jaopca:item_dirtygemosmium', 0, 10));
infinFurnace(utils.get('jaopca:item_chunkperidot'), utils.get('jaopca:item_dirtygemperidot', 0, 10));
infinFurnace(utils.get('jaopca:item_chunkplatinum'), utils.get('jaopca:item_dirtygemplatinum', 0, 10));
infinFurnace(utils.get('jaopca:item_chunkquartz'), utils.get('jaopca:item_dirtygemquartz', 0, 10));
infinFurnace(utils.get('jaopca:item_chunkquartzblack'), utils.get('jaopca:item_dirtygemquartzblack', 0, 10));
infinFurnace(utils.get('jaopca:item_chunkredstone'), utils.get('jaopca:item_dirtygemredstone', 0, 10));
infinFurnace(utils.get('jaopca:item_chunkruby'), utils.get('jaopca:item_dirtygemruby', 0, 10));
infinFurnace(utils.get('jaopca:item_chunksapphire'), utils.get('jaopca:item_dirtygemsapphire', 0, 10));
infinFurnace(utils.get('jaopca:item_chunksilver'), utils.get('jaopca:item_dirtygemsilver', 0, 10));
infinFurnace(utils.get('jaopca:item_chunktanzanite'), utils.get('jaopca:item_dirtygemtanzanite', 0, 10));
infinFurnace(utils.get('jaopca:item_chunkthorium'), utils.get('jaopca:item_dirtygemthorium', 0, 10));
infinFurnace(utils.get('jaopca:item_chunktin'), utils.get('jaopca:item_dirtygemtin', 0, 10));
infinFurnace(utils.get('jaopca:item_chunktitanium'), utils.get('jaopca:item_dirtygemtitanium', 0, 10));
infinFurnace(utils.get('jaopca:item_chunktopaz'), utils.get('jaopca:item_dirtygemtopaz', 0, 10));
infinFurnace(utils.get('jaopca:item_chunktrinitite'), utils.get('jaopca:item_dirtygemtrinitite', 0, 10));
infinFurnace(utils.get('jaopca:item_chunktungsten'), utils.get('jaopca:item_dirtygemtungsten', 0, 10));
infinFurnace(utils.get('jaopca:item_chunkuranium'), utils.get('jaopca:item_dirtygemuranium', 0, 10));
infinFurnace(utils.get('jaopca:item_clusteraluminium'), utils.get('thermalfoundation:material', 132, 2));
infinFurnace(utils.get('jaopca:item_clusteramber'), utils.get('thaumcraft:amber', 0, 3));
infinFurnace(utils.get('jaopca:item_clusteramethyst'), utils.get('biomesoplenty:gem', 0, 3));
infinFurnace(utils.get('jaopca:item_clusterapatite'), utils.get('forestry:apatite', 0, 17));
infinFurnace(utils.get('jaopca:item_clusteraquamarine'), utils.get('astralsorcery:itemcraftingcomponent', 0, 7));
infinFurnace(utils.get('jaopca:item_clusterardite'), utils.get('tconstruct:ingots', 1, 2));
infinFurnace(utils.get('jaopca:item_clusterastralstarmetal'), utils.get('astralsorcery:itemcraftingcomponent', 1, 2));
infinFurnace(utils.get('jaopca:item_clusterboron'), utils.get('nuclearcraft:ingot', 5, 2));
infinFurnace(utils.get('jaopca:item_clustercertusquartz'), utils.get('appliedenergistics2:material', 0, 5));
infinFurnace(utils.get('jaopca:item_clusterchargedcertusquartz'), utils.get('appliedenergistics2:material', 1, 3));
infinFurnace(utils.get('jaopca:item_clustercoal'), utils.get('minecraft:coal', 0, 8));
infinFurnace(utils.get('jaopca:item_clustercobalt'), utils.get('tconstruct:ingots', 0, 2));
infinFurnace(utils.get('jaopca:item_clusterdiamond'), utils.get('minecraft:diamond', 0, 3));
infinFurnace(utils.get('jaopca:item_clusterdilithium'), utils.get('libvulpes:productgem', 0, 2));
infinFurnace(utils.get('jaopca:item_clusterdimensionalshard'), utils.get('rftools:dimensional_shard', 0, 5));
infinFurnace(utils.get('jaopca:item_clusterdraconium'), utils.get('draconicevolution:draconium_ingot', 0, 2));
infinFurnace(utils.get('jaopca:item_clusteremerald'), utils.get('minecraft:emerald', 0, 3));
infinFurnace(utils.get('jaopca:item_clusteriridium'), utils.get('thermalfoundation:material', 135, 2));
infinFurnace(utils.get('jaopca:item_clusterlapis'), utils.get('minecraft:dye', 4, 17));
infinFurnace(utils.get('jaopca:item_clusterlithium'), utils.get('nuclearcraft:ingot', 6, 2));
infinFurnace(utils.get('jaopca:item_clustermagnesium'), utils.get('nuclearcraft:ingot', 7, 2));
infinFurnace(utils.get('jaopca:item_clustermalachite'), utils.get('biomesoplenty:gem', 5, 3));
infinFurnace(utils.get('jaopca:item_clustermithril'), utils.get('thermalfoundation:material', 136, 2));
infinFurnace(utils.get('jaopca:item_clusternickel'), utils.get('thermalfoundation:material', 133, 2));
infinFurnace(utils.get('jaopca:item_clusterosmium'), utils.get('mekanism:ingot', 1, 2));
infinFurnace(utils.get('jaopca:item_clusterperidot'), utils.get('biomesoplenty:gem', 2, 3));
infinFurnace(utils.get('jaopca:item_clusterplatinum'), utils.get('thermalfoundation:material', 134, 2));
infinFurnace(utils.get('jaopca:item_clusterquartzblack'), utils.get('actuallyadditions:item_misc', 5, 3));
infinFurnace(utils.get('jaopca:item_clusterredstone'), utils.get('extrautils2:ingredients', 0, 17));
infinFurnace(utils.get('jaopca:item_clusterruby'), utils.get('biomesoplenty:gem', 1, 3));
infinFurnace(utils.get('jaopca:item_clustersapphire'), utils.get('biomesoplenty:gem', 6, 3));
infinFurnace(utils.get('jaopca:item_clustertanzanite'), utils.get('biomesoplenty:gem', 4, 3));
infinFurnace(utils.get('jaopca:item_clusterthorium'), utils.get('nuclearcraft:ingot', 3, 2));
infinFurnace(utils.get('jaopca:item_clustertitanium'), utils.get('libvulpes:productingot', 7, 2));
infinFurnace(utils.get('jaopca:item_clustertopaz'), utils.get('biomesoplenty:gem', 3, 3));
infinFurnace(utils.get('jaopca:item_clustertrinitite'), utils.get('trinity:trinitite_shard', 0, 2));
infinFurnace(utils.get('jaopca:item_clustertungsten'), utils.get('qmd:dust', 0, 2));
infinFurnace(utils.get('jaopca:item_clusteruranium'), utils.get('immersiveengineering:metal', 5, 2));
infinFurnace(utils.get('jaopca:item_crushedaluminium'), utils.get('thermalfoundation:material', 132));
infinFurnace(utils.get('jaopca:item_crushedardite'), utils.get('tconstruct:ingots', 1));
infinFurnace(utils.get('jaopca:item_crushedastralstarmetal'), utils.get('astralsorcery:itemcraftingcomponent', 1));
infinFurnace(utils.get('jaopca:item_crushedboron'), utils.get('nuclearcraft:ingot', 5));
infinFurnace(utils.get('jaopca:item_crushedcobalt'), utils.get('tconstruct:ingots'));
infinFurnace(utils.get('jaopca:item_crusheddraconium'), utils.get('draconicevolution:draconium_ingot'));
infinFurnace(utils.get('jaopca:item_crushediridium'), utils.get('thermalfoundation:material', 135));
infinFurnace(utils.get('jaopca:item_crushedlithium'), utils.get('nuclearcraft:ingot', 6));
infinFurnace(utils.get('jaopca:item_crushedmagnesium'), utils.get('nuclearcraft:ingot', 7));
infinFurnace(utils.get('jaopca:item_crushedmithril'), utils.get('thermalfoundation:material', 136));
infinFurnace(utils.get('jaopca:item_crushednickel'), utils.get('thermalfoundation:material', 133));
infinFurnace(utils.get('jaopca:item_crushedosmium'), utils.get('mekanism:ingot', 1));
infinFurnace(utils.get('jaopca:item_crushedplatinum'), utils.get('thermalfoundation:material', 134));
infinFurnace(utils.get('jaopca:item_crushedpurifiedaluminium'), utils.get('thermalfoundation:material', 132));
infinFurnace(utils.get('jaopca:item_crushedpurifiedardite'), utils.get('tconstruct:ingots', 1));
infinFurnace(utils.get('jaopca:item_crushedpurifiedastralstarmetal'), utils.get('astralsorcery:itemcraftingcomponent', 1));
infinFurnace(utils.get('jaopca:item_crushedpurifiedboron'), utils.get('nuclearcraft:ingot', 5));
infinFurnace(utils.get('jaopca:item_crushedpurifiedcobalt'), utils.get('tconstruct:ingots'));
infinFurnace(utils.get('jaopca:item_crushedpurifieddraconium'), utils.get('draconicevolution:draconium_ingot'));
infinFurnace(utils.get('jaopca:item_crushedpurifiediridium'), utils.get('thermalfoundation:material', 135));
infinFurnace(utils.get('jaopca:item_crushedpurifiedlithium'), utils.get('nuclearcraft:ingot', 6));
infinFurnace(utils.get('jaopca:item_crushedpurifiedmagnesium'), utils.get('nuclearcraft:ingot', 7));
infinFurnace(utils.get('jaopca:item_crushedpurifiedmithril'), utils.get('thermalfoundation:material', 136));
infinFurnace(utils.get('jaopca:item_crushedpurifiednickel'), utils.get('thermalfoundation:material', 133));
infinFurnace(utils.get('jaopca:item_crushedpurifiedosmium'), utils.get('mekanism:ingot', 1));
infinFurnace(utils.get('jaopca:item_crushedpurifiedplatinum'), utils.get('thermalfoundation:material', 134));
infinFurnace(utils.get('jaopca:item_crushedpurifiedthorium'), utils.get('nuclearcraft:ingot', 3));
infinFurnace(utils.get('jaopca:item_crushedpurifiedtungsten'), utils.get('endreborn:item_ingot_wolframium'));
infinFurnace(utils.get('jaopca:item_crushedthorium'), utils.get('nuclearcraft:ingot', 3));
infinFurnace(utils.get('jaopca:item_crushedtungsten'), utils.get('endreborn:item_ingot_wolframium'));
infinFurnace(utils.get('jaopca:item_crystalabyssaluminium'), utils.get('jaopca:item_dirtygemaluminium'));
infinFurnace(utils.get('jaopca:item_crystalabyssamber'), utils.get('jaopca:item_dirtygemamber'));
infinFurnace(utils.get('jaopca:item_crystalabyssamethyst'), utils.get('jaopca:item_dirtygemamethyst'));
infinFurnace(utils.get('jaopca:item_crystalabyssapatite'), utils.get('jaopca:item_dirtygemapatite'));
infinFurnace(utils.get('jaopca:item_crystalabyssaquamarine'), utils.get('jaopca:item_dirtygemaquamarine'));
infinFurnace(utils.get('jaopca:item_crystalabyssardite'), utils.get('jaopca:item_dirtygemardite'));
infinFurnace(utils.get('jaopca:item_crystalabyssastralstarmetal'), utils.get('jaopca:item_dirtygemastralstarmetal'));
infinFurnace(utils.get('jaopca:item_crystalabyssboron'), utils.get('jaopca:item_dirtygemboron'));
infinFurnace(utils.get('jaopca:item_crystalabysscertusquartz'), utils.get('jaopca:item_dirtygemcertusquartz'));
infinFurnace(utils.get('jaopca:item_crystalabysschargedcertusquartz'), utils.get('jaopca:item_dirtygemchargedcertusquartz'));
infinFurnace(utils.get('jaopca:item_crystalabysscoal'), utils.get('jaopca:item_dirtygemcoal'));
infinFurnace(utils.get('jaopca:item_crystalabysscobalt'), utils.get('jaopca:item_dirtygemcobalt'));
infinFurnace(utils.get('jaopca:item_crystalabysscopper'), utils.get('jaopca:item_dirtygemcopper'));
infinFurnace(utils.get('jaopca:item_crystalabyssdiamond'), utils.get('jaopca:item_dirtygemdiamond'));
infinFurnace(utils.get('jaopca:item_crystalabyssdilithium'), utils.get('jaopca:item_dirtygemdilithium'));
infinFurnace(utils.get('jaopca:item_crystalabyssdimensionalshard'), utils.get('jaopca:item_dirtygemdimensionalshard'));
infinFurnace(utils.get('jaopca:item_crystalabyssdraconium'), utils.get('jaopca:item_dirtygemdraconium'));
infinFurnace(utils.get('jaopca:item_crystalabyssemerald'), utils.get('jaopca:item_dirtygememerald'));
infinFurnace(utils.get('jaopca:item_crystalabyssgold'), utils.get('jaopca:item_dirtygemgold'));
infinFurnace(utils.get('jaopca:item_crystalabyssiridium'), utils.get('jaopca:item_dirtygemiridium'));
infinFurnace(utils.get('jaopca:item_crystalabyssiron'), utils.get('jaopca:item_dirtygemiron'));
infinFurnace(utils.get('jaopca:item_crystalabysslapis'), utils.get('jaopca:item_dirtygemlapis'));
infinFurnace(utils.get('jaopca:item_crystalabysslead'), utils.get('jaopca:item_dirtygemlead'));
infinFurnace(utils.get('jaopca:item_crystalabysslithium'), utils.get('jaopca:item_dirtygemlithium'));
infinFurnace(utils.get('jaopca:item_crystalabyssmagnesium'), utils.get('jaopca:item_dirtygemmagnesium'));
infinFurnace(utils.get('jaopca:item_crystalabyssmalachite'), utils.get('jaopca:item_dirtygemmalachite'));
infinFurnace(utils.get('jaopca:item_crystalabyssmithril'), utils.get('jaopca:item_dirtygemmithril'));
infinFurnace(utils.get('jaopca:item_crystalabyssnickel'), utils.get('jaopca:item_dirtygemnickel'));
infinFurnace(utils.get('jaopca:item_crystalabyssosmium'), utils.get('jaopca:item_dirtygemosmium'));
infinFurnace(utils.get('jaopca:item_crystalabyssperidot'), utils.get('jaopca:item_dirtygemperidot'));
infinFurnace(utils.get('jaopca:item_crystalabyssplatinum'), utils.get('jaopca:item_dirtygemplatinum'));
infinFurnace(utils.get('jaopca:item_crystalabyssquartz'), utils.get('jaopca:item_dirtygemquartz'));
infinFurnace(utils.get('jaopca:item_crystalabyssquartzblack'), utils.get('jaopca:item_dirtygemquartzblack'));
infinFurnace(utils.get('jaopca:item_crystalabyssredstone'), utils.get('jaopca:item_dirtygemredstone'));
infinFurnace(utils.get('jaopca:item_crystalabyssruby'), utils.get('jaopca:item_dirtygemruby'));
infinFurnace(utils.get('jaopca:item_crystalabysssapphire'), utils.get('jaopca:item_dirtygemsapphire'));
infinFurnace(utils.get('jaopca:item_crystalabysssilver'), utils.get('jaopca:item_dirtygemsilver'));
infinFurnace(utils.get('jaopca:item_crystalabysstanzanite'), utils.get('jaopca:item_dirtygemtanzanite'));
infinFurnace(utils.get('jaopca:item_crystalabyssthorium'), utils.get('jaopca:item_dirtygemthorium'));
infinFurnace(utils.get('jaopca:item_crystalabysstin'), utils.get('jaopca:item_dirtygemtin'));
infinFurnace(utils.get('jaopca:item_crystalabysstitanium'), utils.get('jaopca:item_dirtygemtitanium'));
infinFurnace(utils.get('jaopca:item_crystalabysstopaz'), utils.get('jaopca:item_dirtygemtopaz'));
infinFurnace(utils.get('jaopca:item_crystalabysstrinitite'), utils.get('jaopca:item_dirtygemtrinitite'));
infinFurnace(utils.get('jaopca:item_crystalabysstungsten'), utils.get('jaopca:item_dirtygemtungsten'));
infinFurnace(utils.get('jaopca:item_crystalabyssuranium'), utils.get('jaopca:item_dirtygemuranium'));
infinFurnace(utils.get('jaopca:item_dirtygemaluminium'), utils.get('thermalfoundation:material', 132, 12));
infinFurnace(utils.get('jaopca:item_dirtygemamber'), utils.get('thaumcraft:amber', 0, 18));
infinFurnace(utils.get('jaopca:item_dirtygemamethyst'), utils.get('biomesoplenty:gem', 0, 18));
infinFurnace(utils.get('jaopca:item_dirtygemapatite'), utils.get('forestry:apatite', 0, 64));
infinFurnace(utils.get('jaopca:item_dirtygemaquamarine'), utils.get('astralsorcery:itemcraftingcomponent', 0, 37));
infinFurnace(utils.get('jaopca:item_dirtygemardite'), utils.get('tconstruct:ingots', 1, 12));
infinFurnace(utils.get('jaopca:item_dirtygemastralstarmetal'), utils.get('astralsorcery:itemcraftingcomponent', 1, 12));
infinFurnace(utils.get('jaopca:item_dirtygemboron'), utils.get('nuclearcraft:ingot', 5, 12));
infinFurnace(utils.get('jaopca:item_dirtygemcertusquartz'), utils.get('appliedenergistics2:material', 0, 27));
infinFurnace(utils.get('jaopca:item_dirtygemchargedcertusquartz'), utils.get('appliedenergistics2:material', 1, 18));
infinFurnace(utils.get('jaopca:item_dirtygemcoal'), utils.get('minecraft:coal', 0, 46));
infinFurnace(utils.get('jaopca:item_dirtygemcobalt'), utils.get('tconstruct:ingots', 0, 12));
infinFurnace(utils.get('jaopca:item_dirtygemcopper'), utils.get('thermalfoundation:material', 128, 12));
infinFurnace(utils.get('jaopca:item_dirtygemdiamond'), utils.get('minecraft:diamond', 0, 18));
infinFurnace(utils.get('jaopca:item_dirtygemdilithium'), utils.get('libvulpes:productgem', 0, 12));
infinFurnace(utils.get('jaopca:item_dirtygemdimensionalshard'), utils.get('rftools:dimensional_shard', 0, 27));
infinFurnace(utils.get('jaopca:item_dirtygemdraconium'), utils.get('draconicevolution:draconium_ingot', 0, 12));
infinFurnace(utils.get('jaopca:item_dirtygememerald'), utils.get('minecraft:emerald', 0, 18));
infinFurnace(utils.get('jaopca:item_dirtygemgold'), utils.get('minecraft:gold_ingot', 0, 12));
infinFurnace(utils.get('jaopca:item_dirtygemiridium'), utils.get('thermalfoundation:material', 135, 12));
infinFurnace(utils.get('jaopca:item_dirtygemiron'), utils.get('minecraft:iron_ingot', 0, 12));
infinFurnace(utils.get('jaopca:item_dirtygemlapis'), utils.get('minecraft:dye', 4, 64));
infinFurnace(utils.get('jaopca:item_dirtygemlead'), utils.get('thermalfoundation:material', 131, 12));
infinFurnace(utils.get('jaopca:item_dirtygemlithium'), utils.get('nuclearcraft:ingot', 6, 12));
infinFurnace(utils.get('jaopca:item_dirtygemmagnesium'), utils.get('nuclearcraft:ingot', 7, 12));
infinFurnace(utils.get('jaopca:item_dirtygemmalachite'), utils.get('biomesoplenty:gem', 5, 18));
infinFurnace(utils.get('jaopca:item_dirtygemmithril'), utils.get('thermalfoundation:material', 136, 12));
infinFurnace(utils.get('jaopca:item_dirtygemnickel'), utils.get('thermalfoundation:material', 133, 12));
infinFurnace(utils.get('jaopca:item_dirtygemosmium'), utils.get('mekanism:ingot', 1, 12));
infinFurnace(utils.get('jaopca:item_dirtygemperidot'), utils.get('biomesoplenty:gem', 2, 18));
infinFurnace(utils.get('jaopca:item_dirtygemplatinum'), utils.get('thermalfoundation:material', 134, 12));
infinFurnace(utils.get('jaopca:item_dirtygemquartz'), utils.get('minecraft:quartz', 0, 27));
infinFurnace(utils.get('jaopca:item_dirtygemquartzblack'), utils.get('actuallyadditions:item_misc', 5, 18));
infinFurnace(utils.get('jaopca:item_dirtygemredstone'), utils.get('extrautils2:ingredients', 0, 64));
infinFurnace(utils.get('jaopca:item_dirtygemruby'), utils.get('biomesoplenty:gem', 1, 18));
infinFurnace(utils.get('jaopca:item_dirtygemsapphire'), utils.get('biomesoplenty:gem', 6, 18));
infinFurnace(utils.get('jaopca:item_dirtygemsilver'), utils.get('thermalfoundation:material', 130, 12));
infinFurnace(utils.get('jaopca:item_dirtygemtanzanite'), utils.get('biomesoplenty:gem', 4, 18));
infinFurnace(utils.get('jaopca:item_dirtygemthorium'), utils.get('nuclearcraft:ingot', 3, 12));
infinFurnace(utils.get('jaopca:item_dirtygemtin'), utils.get('thermalfoundation:material', 129, 12));
infinFurnace(utils.get('jaopca:item_dirtygemtitanium'), utils.get('libvulpes:productingot', 7, 12));
infinFurnace(utils.get('jaopca:item_dirtygemtopaz'), utils.get('biomesoplenty:gem', 3, 18));
infinFurnace(utils.get('jaopca:item_dirtygemtrinitite'), utils.get('trinity:trinitite_shard', 0, 12));
infinFurnace(utils.get('jaopca:item_dirtygemtungsten'), utils.get('qmd:dust', 0, 12));
infinFurnace(utils.get('jaopca:item_dirtygemuranium'), utils.get('immersiveengineering:metal', 5, 12));
infinFurnace(utils.get('jaopca:item_dustalchaluminium'), utils.get('jaopca:item_dirtygemaluminium', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchamber'), utils.get('jaopca:item_dirtygemamber', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchamethyst'), utils.get('jaopca:item_dirtygemamethyst', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchapatite'), utils.get('jaopca:item_dirtygemapatite', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchaquamarine'), utils.get('jaopca:item_dirtygemaquamarine', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchardite'), utils.get('jaopca:item_dirtygemardite', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchastralstarmetal'), utils.get('jaopca:item_dirtygemastralstarmetal', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchboron'), utils.get('jaopca:item_dirtygemboron', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchcertusquartz'), utils.get('jaopca:item_dirtygemcertusquartz', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchchargedcertusquartz'), utils.get('jaopca:item_dirtygemchargedcertusquartz', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchcoal'), utils.get('jaopca:item_dirtygemcoal', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchcobalt'), utils.get('jaopca:item_dirtygemcobalt', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchcopper'), utils.get('jaopca:item_dirtygemcopper', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchdiamond'), utils.get('jaopca:item_dirtygemdiamond', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchdilithium'), utils.get('jaopca:item_dirtygemdilithium', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchdimensionalshard'), utils.get('jaopca:item_dirtygemdimensionalshard', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchdraconium'), utils.get('jaopca:item_dirtygemdraconium', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchemerald'), utils.get('jaopca:item_dirtygememerald', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchgold'), utils.get('jaopca:item_dirtygemgold', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchiridium'), utils.get('jaopca:item_dirtygemiridium', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchiron'), utils.get('jaopca:item_dirtygemiron', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchlapis'), utils.get('jaopca:item_dirtygemlapis', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchlead'), utils.get('jaopca:item_dirtygemlead', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchlithium'), utils.get('jaopca:item_dirtygemlithium', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchmagnesium'), utils.get('jaopca:item_dirtygemmagnesium', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchmalachite'), utils.get('jaopca:item_dirtygemmalachite', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchmithril'), utils.get('jaopca:item_dirtygemmithril', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchnickel'), utils.get('jaopca:item_dirtygemnickel', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchosmium'), utils.get('jaopca:item_dirtygemosmium', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchperidot'), utils.get('jaopca:item_dirtygemperidot', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchplatinum'), utils.get('jaopca:item_dirtygemplatinum', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchquartz'), utils.get('jaopca:item_dirtygemquartz', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchquartzblack'), utils.get('jaopca:item_dirtygemquartzblack', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchredstone'), utils.get('jaopca:item_dirtygemredstone', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchruby'), utils.get('jaopca:item_dirtygemruby', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchsapphire'), utils.get('jaopca:item_dirtygemsapphire', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchsilver'), utils.get('jaopca:item_dirtygemsilver', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchtanzanite'), utils.get('jaopca:item_dirtygemtanzanite', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchthorium'), utils.get('jaopca:item_dirtygemthorium', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchtin'), utils.get('jaopca:item_dirtygemtin', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchtitanium'), utils.get('jaopca:item_dirtygemtitanium', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchtopaz'), utils.get('jaopca:item_dirtygemtopaz', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchtrinitite'), utils.get('jaopca:item_dirtygemtrinitite', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchtungsten'), utils.get('jaopca:item_dirtygemtungsten', 0, 48));
infinFurnace(utils.get('jaopca:item_dustalchuranium'), utils.get('jaopca:item_dirtygemuranium', 0, 48));
blacklist('jaopca:item_dustamber');
blacklist('jaopca:item_dustamethyst');
blacklist('jaopca:item_dustapatite');
blacklist('jaopca:item_dustaquamarine');
blacklist('jaopca:item_dustchargedcertusquartz');
blacklist('jaopca:item_dustmalachite');
blacklist('jaopca:item_dustperidot');
blacklist('jaopca:item_dustruby');
blacklist('jaopca:item_dustsapphire');
blacklist('jaopca:item_dusttanzanite');
blacklist('jaopca:item_dusttopaz');
blacklist('jaopca:item_dusttrinitite');
blacklist('jaopca:item_hunkastralstarmetal');
blacklist('jaopca:item_hunkdraconium');
blacklist('jaopca:item_hunkiridium');
blacklist('jaopca:item_hunkmithril');
blacklist('jaopca:item_hunkosmium');
blacklist('jaopca:item_hunkplatinum');
blacklist('jaopca:item_hunktitanium');
blacklist('jaopca:item_hunktungsten');
infinFurnace(utils.get('jaopca:item_rockychunkaluminium'), utils.get('jaopca:item_dirtygemaluminium', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunkamber'), utils.get('jaopca:item_dirtygemamber', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunkamethyst'), utils.get('jaopca:item_dirtygemamethyst', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunkapatite'), utils.get('jaopca:item_dirtygemapatite', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunkaquamarine'), utils.get('jaopca:item_dirtygemaquamarine', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunkardite'), utils.get('jaopca:item_dirtygemardite', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunkastralstarmetal'), utils.get('jaopca:item_dirtygemastralstarmetal', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunkboron'), utils.get('jaopca:item_dirtygemboron', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunkcertusquartz'), utils.get('jaopca:item_dirtygemcertusquartz', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunkchargedcertusquartz'), utils.get('jaopca:item_dirtygemchargedcertusquartz', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunkcoal'), utils.get('jaopca:item_dirtygemcoal', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunkcobalt'), utils.get('jaopca:item_dirtygemcobalt', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunkcopper'), utils.get('jaopca:item_dirtygemcopper', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunkdiamond'), utils.get('jaopca:item_dirtygemdiamond', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunkdilithium'), utils.get('jaopca:item_dirtygemdilithium', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunkdimensionalshard'), utils.get('jaopca:item_dirtygemdimensionalshard', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunkdraconium'), utils.get('jaopca:item_dirtygemdraconium', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunkemerald'), utils.get('jaopca:item_dirtygememerald', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunkgold'), utils.get('jaopca:item_dirtygemgold', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunkiridium'), utils.get('jaopca:item_dirtygemiridium', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunkiron'), utils.get('jaopca:item_dirtygemiron', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunklapis'), utils.get('jaopca:item_dirtygemlapis', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunklead'), utils.get('jaopca:item_dirtygemlead', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunklithium'), utils.get('jaopca:item_dirtygemlithium', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunkmagnesium'), utils.get('jaopca:item_dirtygemmagnesium', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunkmalachite'), utils.get('jaopca:item_dirtygemmalachite', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunkmithril'), utils.get('jaopca:item_dirtygemmithril', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunknickel'), utils.get('jaopca:item_dirtygemnickel', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunkosmium'), utils.get('jaopca:item_dirtygemosmium', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunkperidot'), utils.get('jaopca:item_dirtygemperidot', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunkplatinum'), utils.get('jaopca:item_dirtygemplatinum', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunkquartz'), utils.get('jaopca:item_dirtygemquartz', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunkquartzblack'), utils.get('jaopca:item_dirtygemquartzblack', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunkredstone'), utils.get('jaopca:item_dirtygemredstone', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunkruby'), utils.get('jaopca:item_dirtygemruby', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunksapphire'), utils.get('jaopca:item_dirtygemsapphire', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunksilver'), utils.get('jaopca:item_dirtygemsilver', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunktanzanite'), utils.get('jaopca:item_dirtygemtanzanite', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunkthorium'), utils.get('jaopca:item_dirtygemthorium', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunktin'), utils.get('jaopca:item_dirtygemtin', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunktitanium'), utils.get('jaopca:item_dirtygemtitanium', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunktopaz'), utils.get('jaopca:item_dirtygemtopaz', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunktrinitite'), utils.get('jaopca:item_dirtygemtrinitite', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunktungsten'), utils.get('jaopca:item_dirtygemtungsten', 0, 4));
infinFurnace(utils.get('jaopca:item_rockychunkuranium'), utils.get('jaopca:item_dirtygemuranium', 0, 4));
infinFurnace(utils.get('libvulpes:ore0'), utils.get('libvulpes:productdust'));
blacklist('libvulpes:productdust', 3);
blacklist('libvulpes:productdust', 7);
infinFurnace(utils.get('mechanics:heavy_mesh', W), utils.get('mechanics:heavy_ingot', 0, 2));
blacklist('mekanism:dust', 1);
blacklist('mekanism:dust', 2);
blacklist('mekanism:dust', 3);
blacklist('mekanism:dust', 4);
blacklist('mekanism:dust');
infinFurnace(utils.get('mekanism:oreblock'), utils.get('mekanism:ingot', 1));
blacklist('mekanism:otherdust', 1);
blacklist('mekanism:otherdust', 4);
infinFurnace(utils.get('mekanism:polyethene', 1), utils.get('rats:rat_tube_white'));
infinFurnace(utils.get('minecraft:beef', W), utils.get('minecraft:cooked_beef'));
infinFurnace(utils.get('minecraft:book', W), utils.get('cookingforblockheads:recipe_book', 1));
infinFurnace(utils.get('minecraft:cactus', W), utils.get('minecraft:dye', 2));
infinFurnace(utils.get('minecraft:chainmail_boots', W), utils.get('minecraft:iron_nugget'));
infinFurnace(utils.get('minecraft:chainmail_chestplate', W), utils.get('minecraft:iron_nugget'));
infinFurnace(utils.get('minecraft:chainmail_helmet', W), utils.get('minecraft:iron_nugget'));
infinFurnace(utils.get('minecraft:chainmail_leggings', W), utils.get('minecraft:iron_nugget'));
infinFurnace(utils.get('minecraft:chicken', W), utils.get('minecraft:cooked_chicken'));
infinFurnace(utils.get('minecraft:chorus_fruit', W), utils.get('minecraft:chorus_fruit_popped'));
infinFurnace(utils.get('minecraft:clay_ball', W), utils.get('minecraft:brick'));
infinFurnace(utils.get('minecraft:clay', W), utils.get('minecraft:hardened_clay'));
infinFurnace(utils.get('minecraft:coal_ore', W), utils.get('minecraft:coal'));
infinFurnace(utils.get('minecraft:coal', W), utils.get('nuclearcraft:ingot', 8));
infinFurnace(utils.get('minecraft:cobblestone', W), utils.get('minecraft:stone'));
infinFurnace(utils.get('minecraft:diamond_ore', W), utils.get('minecraft:diamond'));
infinFurnace(utils.get('minecraft:dye', 3), utils.get('nuclearcraft:roasted_cocoa_beans'));
infinFurnace(utils.get('minecraft:egg'), utils.get('betteranimalsplus:fried_egg'));
infinFurnace(utils.get('minecraft:emerald_ore', W), utils.get('minecraft:emerald'));
infinFurnace(utils.get('minecraft:fish', 1), utils.get('minecraft:cooked_fish', 1));
infinFurnace(utils.get('minecraft:fish'), utils.get('minecraft:cooked_fish'));
infinFurnace(utils.get('minecraft:gold_ore', W), utils.get('minecraft:gold_ingot'));
infinFurnace(utils.get('minecraft:golden_axe', W), utils.get('minecraft:gold_nugget'));
infinFurnace(utils.get('minecraft:golden_boots', W), utils.get('minecraft:gold_nugget'));
infinFurnace(utils.get('minecraft:golden_chestplate', W), utils.get('minecraft:gold_nugget'));
infinFurnace(utils.get('minecraft:golden_helmet', W), utils.get('minecraft:gold_nugget'));
infinFurnace(utils.get('minecraft:golden_hoe', W), utils.get('minecraft:gold_nugget'));
infinFurnace(utils.get('minecraft:golden_horse_armor', W), utils.get('minecraft:gold_nugget'));
infinFurnace(utils.get('minecraft:golden_leggings', W), utils.get('minecraft:gold_nugget'));
infinFurnace(utils.get('minecraft:golden_pickaxe', W), utils.get('minecraft:gold_nugget'));
infinFurnace(utils.get('minecraft:golden_shovel', W), utils.get('minecraft:gold_nugget'));
infinFurnace(utils.get('minecraft:golden_sword', W), utils.get('minecraft:gold_nugget'));
infinFurnace(utils.get('minecraft:iron_axe', W), utils.get('minecraft:iron_nugget'));
infinFurnace(utils.get('minecraft:iron_boots', W), utils.get('minecraft:iron_nugget'));
infinFurnace(utils.get('minecraft:iron_chestplate', W), utils.get('minecraft:iron_nugget'));
infinFurnace(utils.get('minecraft:iron_helmet', W), utils.get('minecraft:iron_nugget'));
infinFurnace(utils.get('minecraft:iron_hoe', W), utils.get('minecraft:iron_nugget'));
infinFurnace(utils.get('minecraft:iron_horse_armor', W), utils.get('minecraft:iron_nugget'));
infinFurnace(utils.get('minecraft:iron_leggings', W), utils.get('minecraft:iron_nugget'));
infinFurnace(utils.get('minecraft:iron_ore', W), utils.get('minecraft:iron_ingot'));
infinFurnace(utils.get('minecraft:iron_pickaxe', W), utils.get('minecraft:iron_nugget'));
infinFurnace(utils.get('minecraft:iron_shovel', W), utils.get('minecraft:iron_nugget'));
infinFurnace(utils.get('minecraft:iron_sword', W), utils.get('minecraft:iron_nugget'));
infinFurnace(utils.get('minecraft:lapis_ore', W), utils.get('minecraft:dye', 4));
// SKIP: 'minecraft:log', W
// SKIP: 'minecraft:log2', W
infinFurnace(utils.get('minecraft:mutton', W), utils.get('minecraft:cooked_mutton'));
infinFurnace(utils.get('minecraft:netherrack', W), utils.get('minecraft:netherbrick'));
infinFurnace(utils.get('minecraft:porkchop', W), utils.get('minecraft:cooked_porkchop'));
infinFurnace(utils.get('minecraft:potato', W), utils.get('minecraft:baked_potato'));
infinFurnace(utils.get('minecraft:quartz_ore', W), utils.get('minecraft:quartz'));
infinFurnace(utils.get('minecraft:rabbit', W), utils.get('minecraft:cooked_rabbit'));
infinFurnace(utils.get('minecraft:redstone_ore', W), utils.get('minecraft:redstone'));
infinFurnace(utils.get('minecraft:rotten_flesh'), utils.get('rustic:tallow'));
infinFurnace(utils.get('minecraft:sand', W), utils.get('minecraft:glass'));
blacklist('minecraft:sponge', 1);
infinFurnace(utils.get('minecraft:stained_hardened_clay', 1), utils.get('minecraft:orange_glazed_terracotta'));
infinFurnace(utils.get('minecraft:stained_hardened_clay', 2), utils.get('minecraft:magenta_glazed_terracotta'));
infinFurnace(utils.get('minecraft:stained_hardened_clay', 3), utils.get('minecraft:light_blue_glazed_terracotta'));
infinFurnace(utils.get('minecraft:stained_hardened_clay', 4), utils.get('minecraft:yellow_glazed_terracotta'));
infinFurnace(utils.get('minecraft:stained_hardened_clay', 5), utils.get('minecraft:lime_glazed_terracotta'));
infinFurnace(utils.get('minecraft:stained_hardened_clay', 6), utils.get('minecraft:pink_glazed_terracotta'));
infinFurnace(utils.get('minecraft:stained_hardened_clay', 7), utils.get('minecraft:gray_glazed_terracotta'));
infinFurnace(utils.get('minecraft:stained_hardened_clay', 8), utils.get('minecraft:silver_glazed_terracotta'));
infinFurnace(utils.get('minecraft:stained_hardened_clay', 9), utils.get('minecraft:cyan_glazed_terracotta'));
infinFurnace(utils.get('minecraft:stained_hardened_clay', 10), utils.get('minecraft:purple_glazed_terracotta'));
infinFurnace(utils.get('minecraft:stained_hardened_clay', 11), utils.get('minecraft:blue_glazed_terracotta'));
infinFurnace(utils.get('minecraft:stained_hardened_clay', 12), utils.get('minecraft:brown_glazed_terracotta'));
infinFurnace(utils.get('minecraft:stained_hardened_clay', 13), utils.get('minecraft:green_glazed_terracotta'));
infinFurnace(utils.get('minecraft:stained_hardened_clay', 14), utils.get('minecraft:red_glazed_terracotta'));
infinFurnace(utils.get('minecraft:stained_hardened_clay', 15), utils.get('minecraft:black_glazed_terracotta'));
infinFurnace(utils.get('minecraft:stained_hardened_clay'), utils.get('minecraft:white_glazed_terracotta'));
blacklist('minecraft:stonebrick');
infinFurnace(utils.get('mysticalagriculture:crafting', 29), utils.get('mysticalagriculture:crafting', 38));
blacklist('mysticalagriculture:soulstone', 1);
infinFurnace(utils.get('mysticalagriculture:soulstone', 3), utils.get('mysticalagriculture:soulstone', 4));
infinFurnace(utils.get('mysticalagriculture:soulstone'), utils.get('mysticalagriculture:crafting', 28));
infinFurnace(utils.get('netherendingores:ore_end_modded_1', 1), utils.get('thermalfoundation:ore', 0, 2));
blacklist('netherendingores:ore_end_modded_1', 2);
infinFurnace(utils.get('netherendingores:ore_end_modded_1', 3), utils.get('thermalfoundation:ore', 3, 2));
infinFurnace(utils.get('netherendingores:ore_end_modded_1', 4), utils.get('thermalfoundation:ore', 8, 2));
infinFurnace(utils.get('netherendingores:ore_end_modded_1', 5), utils.get('thermalfoundation:ore', 5, 2));
infinFurnace(utils.get('netherendingores:ore_end_modded_1', 6), utils.get('thermalfoundation:ore', 6, 2));
infinFurnace(utils.get('netherendingores:ore_end_modded_1', 7), utils.get('thermalfoundation:ore', 2, 2));
infinFurnace(utils.get('netherendingores:ore_end_modded_1', 8), utils.get('thermalfoundation:ore', 1, 2));
infinFurnace(utils.get('netherendingores:ore_end_modded_1', 9), utils.get('appliedenergistics2:quartz_ore', 0, 2));
blacklist('netherendingores:ore_end_modded_1', 10);
infinFurnace(utils.get('netherendingores:ore_end_modded_1', 11), utils.get('mekanism:oreblock', 0, 2));
infinFurnace(utils.get('netherendingores:ore_end_modded_1', 12), utils.get('immersiveengineering:ore', 5, 2));
infinFurnace(utils.get('netherendingores:ore_end_modded_1', 14), utils.get('libvulpes:ore0', 0, 2));
infinFurnace(utils.get('netherendingores:ore_end_modded_1'), utils.get('thermalfoundation:ore', 4, 2));
infinFurnace(utils.get('netherendingores:ore_end_modded_2', 1), utils.get('biomesoplenty:gem_ore', 1, 2));
infinFurnace(utils.get('netherendingores:ore_end_modded_2', 2), utils.get('biomesoplenty:gem_ore', 6, 2));
blacklist('netherendingores:ore_end_modded_2', 3);
blacklist('netherendingores:ore_end_modded_2', 5);
blacklist('netherendingores:ore_end_modded_2', 6);
blacklist('netherendingores:ore_end_modded_2', 7);
blacklist('netherendingores:ore_end_modded_2', 8);
blacklist('netherendingores:ore_end_modded_2', 9);
infinFurnace(utils.get('netherendingores:ore_end_vanilla', 1), utils.get('minecraft:diamond_ore', 0, 2));
infinFurnace(utils.get('netherendingores:ore_end_vanilla', 2), utils.get('minecraft:emerald_ore', 0, 2));
infinFurnace(utils.get('netherendingores:ore_end_vanilla', 3), utils.get('minecraft:gold_ore', 0, 2));
infinFurnace(utils.get('netherendingores:ore_end_vanilla', 4), utils.get('minecraft:iron_ore', 0, 2));
infinFurnace(utils.get('netherendingores:ore_end_vanilla', 5), utils.get('minecraft:lapis_ore', 0, 2));
infinFurnace(utils.get('netherendingores:ore_end_vanilla', 6), utils.get('minecraft:redstone_ore', 0, 2));
infinFurnace(utils.get('netherendingores:ore_end_vanilla'), utils.get('minecraft:coal_ore', 0, 2));
infinFurnace(utils.get('netherendingores:ore_nether_modded_1', 1), utils.get('thermalfoundation:ore', 0, 2));
blacklist('netherendingores:ore_nether_modded_1', 2);
infinFurnace(utils.get('netherendingores:ore_nether_modded_1', 3), utils.get('thermalfoundation:ore', 3, 2));
blacklist('netherendingores:ore_nether_modded_1', 4);
infinFurnace(utils.get('netherendingores:ore_nether_modded_1', 5), utils.get('thermalfoundation:ore', 5, 2));
infinFurnace(utils.get('netherendingores:ore_nether_modded_1', 6), utils.get('thermalfoundation:ore', 6, 2));
infinFurnace(utils.get('netherendingores:ore_nether_modded_1', 7), utils.get('thermalfoundation:ore', 2, 2));
infinFurnace(utils.get('netherendingores:ore_nether_modded_1', 8), utils.get('thermalfoundation:ore', 1, 2));
infinFurnace(utils.get('netherendingores:ore_nether_modded_1', 9), utils.get('appliedenergistics2:quartz_ore', 0, 2));
infinFurnace(utils.get('netherendingores:ore_nether_modded_1', 10), utils.get('appliedenergistics2:charged_quartz_ore', 0, 2));
infinFurnace(utils.get('netherendingores:ore_nether_modded_1', 11), utils.get('mekanism:oreblock', 0, 2));
infinFurnace(utils.get('netherendingores:ore_nether_modded_1', 12), utils.get('immersiveengineering:ore', 5, 2));
blacklist('netherendingores:ore_nether_modded_1', 14);
infinFurnace(utils.get('netherendingores:ore_nether_modded_1'), utils.get('thermalfoundation:ore', 4, 2));
infinFurnace(utils.get('netherendingores:ore_nether_modded_2', 1), utils.get('biomesoplenty:gem_ore', 1, 2));
blacklist('netherendingores:ore_nether_modded_2', 2);
infinFurnace(utils.get('netherendingores:ore_nether_modded_2', 3), utils.get('biomesoplenty:gem_ore', 2, 2));
blacklist('netherendingores:ore_nether_modded_2', 5);
blacklist('netherendingores:ore_nether_modded_2', 6);
blacklist('netherendingores:ore_nether_modded_2', 7);
blacklist('netherendingores:ore_nether_modded_2', 8);
blacklist('netherendingores:ore_nether_modded_2', 9);
infinFurnace(utils.get('netherendingores:ore_nether_vanilla', 1), utils.get('minecraft:diamond_ore', 0, 2));
infinFurnace(utils.get('netherendingores:ore_nether_vanilla', 2), utils.get('minecraft:emerald_ore', 0, 2));
infinFurnace(utils.get('netherendingores:ore_nether_vanilla', 3), utils.get('minecraft:gold_ore', 0, 2));
infinFurnace(utils.get('netherendingores:ore_nether_vanilla', 4), utils.get('minecraft:iron_ore', 0, 2));
infinFurnace(utils.get('netherendingores:ore_nether_vanilla', 5), utils.get('minecraft:lapis_ore', 0, 2));
infinFurnace(utils.get('netherendingores:ore_nether_vanilla', 6), utils.get('minecraft:redstone_ore', 0, 2));
infinFurnace(utils.get('netherendingores:ore_nether_vanilla'), utils.get('minecraft:coal_ore', 0, 2));
infinFurnace(utils.get('netherendingores:ore_other_1', 1), utils.get('minecraft:quartz_ore', 0, 2));
infinFurnace(utils.get('netherendingores:ore_other_1', 3), utils.get('tconstruct:ore', 1, 2));
infinFurnace(utils.get('netherendingores:ore_other_1', 4), utils.get('tconstruct:ingots'));
infinFurnace(utils.get('netherendingores:ore_other_1', 5), utils.get('tconstruct:ore', 0, 2));
blacklist('netherendingores:ore_other_1');
blacklist('nuclearcraft:americium', 2);
blacklist('nuclearcraft:americium', 3);
blacklist('nuclearcraft:americium', 4);
blacklist('nuclearcraft:americium', 7);
blacklist('nuclearcraft:americium', 8);
blacklist('nuclearcraft:americium', 9);
blacklist('nuclearcraft:americium', 12);
blacklist('nuclearcraft:americium', 13);
blacklist('nuclearcraft:americium', 14);
blacklist('nuclearcraft:berkelium', 2);
blacklist('nuclearcraft:berkelium', 3);
blacklist('nuclearcraft:berkelium', 4);
blacklist('nuclearcraft:berkelium', 7);
blacklist('nuclearcraft:berkelium', 8);
blacklist('nuclearcraft:berkelium', 9);
blacklist('nuclearcraft:californium', 2);
blacklist('nuclearcraft:californium', 3);
blacklist('nuclearcraft:californium', 4);
blacklist('nuclearcraft:californium', 7);
blacklist('nuclearcraft:californium', 8);
blacklist('nuclearcraft:californium', 9);
blacklist('nuclearcraft:californium', 12);
blacklist('nuclearcraft:californium', 13);
blacklist('nuclearcraft:californium', 14);
blacklist('nuclearcraft:californium', 17);
blacklist('nuclearcraft:californium', 18);
blacklist('nuclearcraft:californium', 19);
blacklist('nuclearcraft:curium', 2);
blacklist('nuclearcraft:curium', 3);
blacklist('nuclearcraft:curium', 4);
blacklist('nuclearcraft:curium', 7);
blacklist('nuclearcraft:curium', 8);
blacklist('nuclearcraft:curium', 9);
blacklist('nuclearcraft:curium', 12);
blacklist('nuclearcraft:curium', 13);
blacklist('nuclearcraft:curium', 14);
blacklist('nuclearcraft:curium', 17);
blacklist('nuclearcraft:curium', 18);
blacklist('nuclearcraft:curium', 19);
blacklist('nuclearcraft:dust', 3);
blacklist('nuclearcraft:dust', 5);
blacklist('nuclearcraft:dust', 6);
blacklist('nuclearcraft:dust', 7);
blacklist('nuclearcraft:dust', 8);
blacklist('nuclearcraft:dust', 9);
blacklist('nuclearcraft:dust', 10);
blacklist('nuclearcraft:dust', 11);
blacklist('nuclearcraft:dust', 12);
blacklist('nuclearcraft:dust', 13);
blacklist('nuclearcraft:dust', 14);
infinFurnace(utils.get('nuclearcraft:flour'), utils.get('minecraft:bread'));
infinFurnace(utils.get('nuclearcraft:gem_dust', 1), utils.get('nuclearcraft:dust', 14));
blacklist('nuclearcraft:ingot', 14);
blacklist('nuclearcraft:ingot', 15);
blacklist('nuclearcraft:neptunium', 2);
blacklist('nuclearcraft:neptunium', 3);
blacklist('nuclearcraft:neptunium', 4);
blacklist('nuclearcraft:neptunium', 7);
blacklist('nuclearcraft:neptunium', 8);
blacklist('nuclearcraft:neptunium', 9);
infinFurnace(utils.get('nuclearcraft:ore', 3), utils.get('nuclearcraft:ingot', 3));
infinFurnace(utils.get('nuclearcraft:ore', 5), utils.get('nuclearcraft:ingot', 5));
infinFurnace(utils.get('nuclearcraft:ore', 6), utils.get('nuclearcraft:ingot', 6));
infinFurnace(utils.get('nuclearcraft:ore', 7), utils.get('nuclearcraft:ingot', 7));
blacklist('nuclearcraft:plutonium', 2);
blacklist('nuclearcraft:plutonium', 3);
blacklist('nuclearcraft:plutonium', 4);
blacklist('nuclearcraft:plutonium', 7);
blacklist('nuclearcraft:plutonium', 8);
blacklist('nuclearcraft:plutonium', 9);
blacklist('nuclearcraft:plutonium', 12);
blacklist('nuclearcraft:plutonium', 13);
blacklist('nuclearcraft:plutonium', 14);
blacklist('nuclearcraft:plutonium', 17);
blacklist('nuclearcraft:plutonium', 18);
blacklist('nuclearcraft:plutonium', 19);
blacklist('nuclearcraft:uranium', 2);
blacklist('nuclearcraft:uranium', 3);
blacklist('nuclearcraft:uranium', 4);
blacklist('nuclearcraft:uranium', 7);
blacklist('nuclearcraft:uranium', 8);
blacklist('nuclearcraft:uranium', 9);
blacklist('nuclearcraft:uranium', 12);
blacklist('nuclearcraft:uranium', 13);
blacklist('nuclearcraft:uranium', 14);
infinFurnace(utils.get('opencomputers:material', 2), utils.get('opencomputers:material', 4));
blacklist('qmd:copernicium', 2);
blacklist('qmd:copernicium', 3);
blacklist('qmd:copernicium', 4);
blacklist('qmd:dust', 1);
blacklist('qmd:dust', 2);
blacklist('qmd:dust', 5);
blacklist('qmd:dust', 6);
blacklist('qmd:dust', 7);
blacklist('qmd:dust', 8);
blacklist('qmd:dust', 9);
blacklist('qmd:dust', 10);
blacklist('qmd:dust', 11);
blacklist('qmd:dust', 12);
blacklist('qmd:dust', 13);
blacklist('qmd:dust', 14);
blacklist('qmd:dust');
blacklist('qmd:dust2', 1);
blacklist('qmd:dust2');
infinFurnace(utils.get('quark:biome_cobblestone', 2), utils.get('minecraft:stone'));
blacklist('quark:crab_leg', W);
infinFurnace(utils.get('quark:frog_leg', W), utils.get('quark:cooked_frog_leg'));
infinFurnace(utils.get('quark:trowel'), utils.get('minecraft:iron_nugget'));
infinFurnace(utils.get('randomthings:biomestone'), utils.get('randomthings:biomestone', 1));
blacklist('rats:marbled_cheese_brick', W);
infinFurnace(utils.get('rats:marbled_cheese_raw', W), utils.get('rats:marbled_cheese'));
infinFurnace(utils.get('rats:rat_nugget_ore', 1, 1, {OreItem: {Count: 1, id: "thaumcraft:ore_amber", Damage: 0 as short}, IngotItem: {Count: 1, id: "thaumcraft:amber", Damage: 0 as short}}), utils.get('thaumcraft:amber'));
infinFurnace(utils.get('rats:rat_nugget_ore', 2, 1, {OreItem: {Count: 1, id: "forestry:resources", Damage: 0 as short}, IngotItem: {Count: 1, id: "forestry:apatite", Damage: 0 as short}}), utils.get('forestry:apatite'));
infinFurnace(utils.get('rats:rat_nugget_ore', 3, 1, {OreItem: {Count: 1, id: "astralsorcery:blockcustomsandore", Damage: 0 as short}, IngotItem: {Count: 3, id: "astralsorcery:itemcraftingcomponent", Damage: 0 as short}}), utils.get('astralsorcery:itemcraftingcomponent', 0, 3));
infinFurnace(utils.get('rats:rat_nugget_ore', 4, 1, {OreItem: {Count: 1, id: "tconstruct:ore", Damage: 1 as short}, IngotItem: {Count: 1, id: "tconstruct:ingots", Damage: 1 as short}}), utils.get('tconstruct:ingots', 1));
infinFurnace(utils.get('rats:rat_nugget_ore', 5, 1, {OreItem: {Count: 1, id: "twilightforest:armor_shard_cluster", Damage: 0 as short}, IngotItem: {Count: 1, id: "twilightforest:knightmetal_ingot", Damage: 0 as short}}), utils.get('twilightforest:knightmetal_ingot'));
infinFurnace(utils.get('rats:rat_nugget_ore', 6, 1, {OreItem: {Count: 1, id: "actuallyadditions:block_misc", Damage: 3 as short}, IngotItem: {Count: 1, id: "actuallyadditions:item_misc", Damage: 5 as short}}), utils.get('actuallyadditions:item_misc', 5));
infinFurnace(utils.get('rats:rat_nugget_ore', 7, 1, {OreItem: {Count: 1, id: "nuclearcraft:ore", Damage: 5 as short}, IngotItem: {Count: 1, id: "nuclearcraft:ingot", Damage: 5 as short}}), utils.get('nuclearcraft:ingot', 5));
infinFurnace(utils.get('rats:rat_nugget_ore', 8, 1, {OreItem: {Count: 1, id: "thaumcraft:ore_cinnabar", Damage: 0 as short}, IngotItem: {Count: 1, id: "thaumcraft:quicksilver", Damage: 0 as short}}), utils.get('thaumcraft:quicksilver'));
infinFurnace(utils.get('rats:rat_nugget_ore', 9, 1, {OreItem: {Count: 1, id: "minecraft:coal_ore", Damage: 0 as short}, IngotItem: {Count: 1, id: "minecraft:coal", Damage: 0 as short}}), utils.get('minecraft:coal'));
infinFurnace(utils.get('rats:rat_nugget_ore', 10, 1, {OreItem: {Count: 1, id: "tconstruct:ore", Damage: 0 as short}, IngotItem: {Count: 1, id: "tconstruct:ingots", Damage: 0 as short}}), utils.get('tconstruct:ingots'));
infinFurnace(utils.get('rats:rat_nugget_ore', 11, 1, {OreItem: {Count: 1, id: "thermalfoundation:ore", Damage: 0 as short}, IngotItem: {Count: 1, id: "thermalfoundation:material", Damage: 128 as short}}), utils.get('thermalfoundation:material', 128));
infinFurnace(utils.get('rats:rat_nugget_ore', 12, 1, {OreItem: {Count: 1, id: "minecraft:diamond_ore", Damage: 0 as short}, IngotItem: {Count: 1, id: "minecraft:diamond", Damage: 0 as short}}), utils.get('minecraft:diamond'));
infinFurnace(utils.get('rats:rat_nugget_ore', 13, 1, {OreItem: {Count: 1, id: "libvulpes:ore0", Damage: 0 as short}, IngotItem: {Count: 1, id: "libvulpes:productdust", Damage: 0 as short}}), utils.get('libvulpes:productdust'));
infinFurnace(utils.get('rats:rat_nugget_ore', 14, 1, {OreItem: {Count: 1, id: "draconicevolution:draconium_ore", Damage: 0 as short}, IngotItem: {Count: 1, id: "draconicevolution:draconium_ingot", Damage: 0 as short}}), utils.get('draconicevolution:draconium_ingot'));
infinFurnace(utils.get('rats:rat_nugget_ore', 15, 1, {OreItem: {Count: 1, id: "minecraft:emerald_ore", Damage: 0 as short}, IngotItem: {Count: 1, id: "minecraft:emerald", Damage: 0 as short}}), utils.get('minecraft:emerald'));
infinFurnace(utils.get('rats:rat_nugget_ore', 16, 1, {OreItem: {Count: 1, id: "netherendingores:ore_end_modded_1", Damage: 0 as short}, IngotItem: {Count: 2, id: "thermalfoundation:ore", Damage: 4 as short}}), utils.get('thermalfoundation:ore', 4, 2));
blacklist('rats:rat_nugget_ore', 17, 1, {OreItem: {Count: 1, id: "netherendingores:ore_end_modded_2", Damage: 5 as short}, IngotItem: {Count: 2, id: "netherendingores:ore_other_1", Damage: 6 as short}});
infinFurnace(utils.get('rats:rat_nugget_ore', 18, 1, {OreItem: {Count: 1, id: "netherendingores:ore_other_1", Damage: 3 as short}, IngotItem: {Count: 2, id: "tconstruct:ore", Damage: 1 as short}}), utils.get('tconstruct:ore', 1, 2));
blacklist('rats:rat_nugget_ore', 19, 1, {OreItem: {Count: 1, id: "netherendingores:ore_end_modded_2", Damage: 8 as short}, IngotItem: {Count: 2, id: "netherendingores:ore_other_1", Damage: 9 as short}});
infinFurnace(utils.get('rats:rat_nugget_ore', 20, 1, {OreItem: {Count: 1, id: "netherendingores:ore_end_modded_1", Damage: 9 as short}, IngotItem: {Count: 2, id: "appliedenergistics2:quartz_ore", Damage: 0 as short}}), utils.get('appliedenergistics2:quartz_ore', 0, 2));
infinFurnace(utils.get('rats:rat_nugget_ore', 21, 1, {OreItem: {Count: 1, id: "netherendingores:ore_end_modded_1", Damage: 10 as short}, IngotItem: {Count: 2, id: "appliedenergistics2:charged_quartz_ore", Damage: 0 as short}}), utils.get('appliedenergistics2:charged_quartz_ore', 0, 2));
infinFurnace(utils.get('rats:rat_nugget_ore', 22, 1, {OreItem: {Count: 1, id: "netherendingores:ore_end_vanilla", Damage: 0 as short}, IngotItem: {Count: 2, id: "minecraft:coal_ore", Damage: 0 as short}}), utils.get('minecraft:coal_ore', 0, 2));
infinFurnace(utils.get('rats:rat_nugget_ore', 23, 1, {OreItem: {Count: 1, id: "netherendingores:ore_other_1", Damage: 5 as short}, IngotItem: {Count: 2, id: "tconstruct:ore", Damage: 0 as short}}), utils.get('tconstruct:ore', 0, 2));
infinFurnace(utils.get('rats:rat_nugget_ore', 24, 1, {OreItem: {Count: 1, id: "netherendingores:ore_end_modded_1", Damage: 1 as short}, IngotItem: {Count: 2, id: "thermalfoundation:ore", Damage: 0 as short}}), utils.get('thermalfoundation:ore', 0, 2));
infinFurnace(utils.get('rats:rat_nugget_ore', 25, 1, {OreItem: {Count: 1, id: "netherendingores:ore_end_vanilla", Damage: 1 as short}, IngotItem: {Count: 2, id: "minecraft:diamond_ore", Damage: 0 as short}}), utils.get('minecraft:diamond_ore', 0, 2));
infinFurnace(utils.get('rats:rat_nugget_ore', 26, 1, {OreItem: {Count: 1, id: "netherendingores:ore_end_modded_1", Damage: 14 as short}, IngotItem: {Count: 2, id: "libvulpes:ore0", Damage: 0 as short}}), utils.get('libvulpes:ore0', 0, 2));
infinFurnace(utils.get('rats:rat_nugget_ore', 27, 1, {OreItem: {Count: 1, id: "netherendingores:ore_end_vanilla", Damage: 2 as short}, IngotItem: {Count: 2, id: "minecraft:emerald_ore", Damage: 0 as short}}), utils.get('minecraft:emerald_ore', 0, 2));
infinFurnace(utils.get('rats:rat_nugget_ore', 28, 1, {OreItem: {Count: 1, id: "netherendingores:ore_end_vanilla", Damage: 3 as short}, IngotItem: {Count: 2, id: "minecraft:gold_ore", Damage: 0 as short}}), utils.get('minecraft:gold_ore', 0, 2));
blacklist('rats:rat_nugget_ore', 29, 1, {OreItem: {Count: 1, id: "netherendingores:ore_end_modded_2", Damage: 6 as short}, IngotItem: {Count: 2, id: "netherendingores:ore_other_1", Damage: 7 as short}});
blacklist('rats:rat_nugget_ore', 30, 1, {OreItem: {Count: 1, id: "netherendingores:ore_end_modded_2", Damage: 9 as short}, IngotItem: {Count: 2, id: "netherendingores:ore_other_1", Damage: 10 as short}});
infinFurnace(utils.get('rats:rat_nugget_ore', 31, 1, {OreItem: {Count: 1, id: "netherendingores:ore_end_modded_1", Damage: 2 as short}, IngotItem: {Count: 2, id: "thermalfoundation:ore", Damage: 7 as short}}), utils.get('thermalfoundation:ore', 7, 2));
infinFurnace(utils.get('rats:rat_nugget_ore', 32, 1, {OreItem: {Count: 1, id: "netherendingores:ore_end_vanilla", Damage: 4 as short}, IngotItem: {Count: 2, id: "minecraft:iron_ore", Damage: 0 as short}}), utils.get('minecraft:iron_ore', 0, 2));
infinFurnace(utils.get('rats:rat_nugget_ore', 33, 1, {OreItem: {Count: 1, id: "netherendingores:ore_end_vanilla", Damage: 5 as short}, IngotItem: {Count: 2, id: "minecraft:lapis_ore", Damage: 0 as short}}), utils.get('minecraft:lapis_ore', 0, 2));
infinFurnace(utils.get('rats:rat_nugget_ore', 34, 1, {OreItem: {Count: 1, id: "netherendingores:ore_end_modded_1", Damage: 3 as short}, IngotItem: {Count: 2, id: "thermalfoundation:ore", Damage: 3 as short}}), utils.get('thermalfoundation:ore', 3, 2));
infinFurnace(utils.get('rats:rat_nugget_ore', 35, 1, {OreItem: {Count: 1, id: "netherendingores:ore_end_modded_1", Damage: 4 as short}, IngotItem: {Count: 2, id: "thermalfoundation:ore", Damage: 8 as short}}), utils.get('thermalfoundation:ore', 8, 2));
infinFurnace(utils.get('rats:rat_nugget_ore', 36, 1, {OreItem: {Count: 1, id: "netherendingores:ore_end_modded_1", Damage: 5 as short}, IngotItem: {Count: 2, id: "thermalfoundation:ore", Damage: 5 as short}}), utils.get('thermalfoundation:ore', 5, 2));
infinFurnace(utils.get('rats:rat_nugget_ore', 37, 1, {OreItem: {Count: 1, id: "netherendingores:ore_end_modded_1", Damage: 11 as short}, IngotItem: {Count: 2, id: "mekanism:oreblock", Damage: 0 as short}}), utils.get('mekanism:oreblock', 0, 2));
infinFurnace(utils.get('rats:rat_nugget_ore', 38, 1, {OreItem: {Count: 1, id: "netherendingores:ore_end_modded_2", Damage: 3 as short}, IngotItem: {Count: 2, id: "biomesoplenty:gem_ore", Damage: 2 as short}}), utils.get('biomesoplenty:gem_ore', 2, 2));
infinFurnace(utils.get('rats:rat_nugget_ore', 39, 1, {OreItem: {Count: 1, id: "netherendingores:ore_end_modded_1", Damage: 6 as short}, IngotItem: {Count: 2, id: "thermalfoundation:ore", Damage: 6 as short}}), utils.get('thermalfoundation:ore', 6, 2));
infinFurnace(utils.get('rats:rat_nugget_ore', 40, 1, {OreItem: {Count: 1, id: "netherendingores:ore_other_1", Damage: 1 as short}, IngotItem: {Count: 2, id: "minecraft:quartz_ore", Damage: 0 as short}}), utils.get('minecraft:quartz_ore', 0, 2));
infinFurnace(utils.get('rats:rat_nugget_ore', 41, 1, {OreItem: {Count: 1, id: "netherendingores:ore_end_vanilla", Damage: 6 as short}, IngotItem: {Count: 2, id: "minecraft:redstone_ore", Damage: 0 as short}}), utils.get('minecraft:redstone_ore', 0, 2));
infinFurnace(utils.get('rats:rat_nugget_ore', 42, 1, {OreItem: {Count: 1, id: "netherendingores:ore_end_modded_2", Damage: 1 as short}, IngotItem: {Count: 2, id: "biomesoplenty:gem_ore", Damage: 1 as short}}), utils.get('biomesoplenty:gem_ore', 1, 2));
infinFurnace(utils.get('rats:rat_nugget_ore', 43, 1, {OreItem: {Count: 1, id: "netherendingores:ore_end_modded_2", Damage: 2 as short}, IngotItem: {Count: 2, id: "biomesoplenty:gem_ore", Damage: 6 as short}}), utils.get('biomesoplenty:gem_ore', 6, 2));
infinFurnace(utils.get('rats:rat_nugget_ore', 44, 1, {OreItem: {Count: 1, id: "netherendingores:ore_end_modded_1", Damage: 7 as short}, IngotItem: {Count: 2, id: "thermalfoundation:ore", Damage: 2 as short}}), utils.get('thermalfoundation:ore', 2, 2));
infinFurnace(utils.get('rats:rat_nugget_ore', 45, 1, {OreItem: {Count: 1, id: "netherendingores:ore_end_modded_1", Damage: 8 as short}, IngotItem: {Count: 2, id: "thermalfoundation:ore", Damage: 1 as short}}), utils.get('thermalfoundation:ore', 1, 2));
infinFurnace(utils.get('rats:rat_nugget_ore', 46, 1, {OreItem: {Count: 1, id: "netherendingores:ore_end_modded_1", Damage: 12 as short}, IngotItem: {Count: 2, id: "immersiveengineering:ore", Damage: 5 as short}}), utils.get('immersiveengineering:ore', 5, 2));
blacklist('rats:rat_nugget_ore', 47, 1, {OreItem: {Count: 1, id: "netherendingores:ore_end_modded_2", Damage: 7 as short}, IngotItem: {Count: 2, id: "netherendingores:ore_other_1", Damage: 8 as short}});
infinFurnace(utils.get('rats:rat_nugget_ore', 48, 1, {OreItem: {Count: 1, id: "biomesoplenty:gem_ore", Damage: 0 as short}, IngotItem: {Count: 1, id: "biomesoplenty:gem", Damage: 0 as short}}), utils.get('biomesoplenty:gem'));
infinFurnace(utils.get('rats:rat_nugget_ore', 49, 1, {OreItem: {Count: 1, id: "minecraft:gold_ore", Damage: 0 as short}, IngotItem: {Count: 1, id: "minecraft:gold_ingot", Damage: 0 as short}}), utils.get('minecraft:gold_ingot'));
infinFurnace(utils.get('rats:rat_nugget_ore', 50, 1, {OreItem: {Count: 1, id: "thermalfoundation:ore", Damage: 7 as short}, IngotItem: {Count: 1, id: "thermalfoundation:material", Damage: 135 as short}}), utils.get('thermalfoundation:material', 135));
infinFurnace(utils.get('rats:rat_nugget_ore', 51, 1, {OreItem: {Count: 1, id: "minecraft:iron_ore", Damage: 0 as short}, IngotItem: {Count: 1, id: "minecraft:iron_ingot", Damage: 0 as short}}), utils.get('minecraft:iron_ingot'));
infinFurnace(utils.get('rats:rat_nugget_ore', 52, 1, {OreItem: {Count: 1, id: "minecraft:lapis_ore", Damage: 0 as short}, IngotItem: {Count: 1, id: "minecraft:dye", Damage: 4 as short}}), utils.get('minecraft:dye', 4));
infinFurnace(utils.get('rats:rat_nugget_ore', 53, 1, {OreItem: {Count: 1, id: "thermalfoundation:ore", Damage: 3 as short}, IngotItem: {Count: 1, id: "thermalfoundation:material", Damage: 131 as short}}), utils.get('thermalfoundation:material', 131));
infinFurnace(utils.get('rats:rat_nugget_ore', 54, 1, {OreItem: {Count: 1, id: "nuclearcraft:ore", Damage: 6 as short}, IngotItem: {Count: 1, id: "nuclearcraft:ingot", Damage: 6 as short}}), utils.get('nuclearcraft:ingot', 6));
infinFurnace(utils.get('rats:rat_nugget_ore', 55, 1, {OreItem: {Count: 1, id: "nuclearcraft:ore", Damage: 7 as short}, IngotItem: {Count: 1, id: "nuclearcraft:ingot", Damage: 7 as short}}), utils.get('nuclearcraft:ingot', 7));
infinFurnace(utils.get('rats:rat_nugget_ore', 56, 1, {OreItem: {Count: 1, id: "biomesoplenty:gem_ore", Damage: 5 as short}, IngotItem: {Count: 1, id: "biomesoplenty:gem", Damage: 5 as short}}), utils.get('biomesoplenty:gem', 5));
infinFurnace(utils.get('rats:rat_nugget_ore', 57, 1, {OreItem: {Count: 1, id: "thermalfoundation:ore", Damage: 8 as short}, IngotItem: {Count: 1, id: "thermalfoundation:material", Damage: 136 as short}}), utils.get('thermalfoundation:material', 136));
infinFurnace(utils.get('rats:rat_nugget_ore', 80, 1, {OreItem: {Count: 1, id: "minecraft:quartz_ore", Damage: 0 as short}, IngotItem: {Count: 1, id: "minecraft:quartz", Damage: 0 as short}}), utils.get('minecraft:quartz'));
infinFurnace(utils.get('rats:rat_nugget_ore', 88, 1, {OreItem: {Count: 1, id: "thermalfoundation:ore", Damage: 5 as short}, IngotItem: {Count: 1, id: "thermalfoundation:material", Damage: 133 as short}}), utils.get('thermalfoundation:material', 133));
infinFurnace(utils.get('rats:rat_nugget_ore', 89, 1, {OreItem: {Count: 1, id: "mekanism:oreblock", Damage: 0 as short}, IngotItem: {Count: 1, id: "mekanism:ingot", Damage: 1 as short}}), utils.get('mekanism:ingot', 1));
infinFurnace(utils.get('rats:rat_nugget_ore', 90, 1, {OreItem: {Count: 1, id: "biomesoplenty:gem_ore", Damage: 2 as short}, IngotItem: {Count: 1, id: "biomesoplenty:gem", Damage: 2 as short}}), utils.get('biomesoplenty:gem', 2));
infinFurnace(utils.get('rats:rat_nugget_ore', 91, 1, {OreItem: {Count: 1, id: "contenttweaker:ore_phosphor", Damage: 0 as short}, IngotItem: {Count: 1, id: "contenttweaker:nugget_phosphor", Damage: 0 as short}}), utils.get('contenttweaker:nugget_phosphor'));
infinFurnace(utils.get('rats:rat_nugget_ore', 92, 1, {OreItem: {Count: 1, id: "thermalfoundation:ore", Damage: 6 as short}, IngotItem: {Count: 1, id: "thermalfoundation:material", Damage: 134 as short}}), utils.get('thermalfoundation:material', 134));
infinFurnace(utils.get('rats:rat_nugget_ore', 93, 1, {OreItem: {Count: 1, id: "twilightforest:ironwood_raw", Damage: 0 as short}, IngotItem: {Count: 2, id: "twilightforest:ironwood_ingot", Damage: 0 as short}}), utils.get('twilightforest:ironwood_ingot', 0, 2));
infinFurnace(utils.get('rats:rat_nugget_ore', 94, 1, {OreItem: {Count: 1, id: "minecraft:redstone_ore", Damage: 0 as short}, IngotItem: {Count: 1, id: "minecraft:redstone", Damage: 0 as short}}), utils.get('minecraft:redstone'));
infinFurnace(utils.get('rats:rat_nugget_ore', 95, 1, {OreItem: {Count: 1, id: "biomesoplenty:gem_ore", Damage: 1 as short}, IngotItem: {Count: 1, id: "biomesoplenty:gem", Damage: 1 as short}}), utils.get('biomesoplenty:gem', 1));
infinFurnace(utils.get('rats:rat_nugget_ore', 96, 1, {OreItem: {Count: 1, id: "biomesoplenty:gem_ore", Damage: 6 as short}, IngotItem: {Count: 1, id: "biomesoplenty:gem", Damage: 6 as short}}), utils.get('biomesoplenty:gem', 6));
infinFurnace(utils.get('rats:rat_nugget_ore', 97, 1, {OreItem: {Count: 1, id: "thermalfoundation:ore", Damage: 2 as short}, IngotItem: {Count: 1, id: "thermalfoundation:material", Damage: 130 as short}}), utils.get('thermalfoundation:material', 130));
infinFurnace(utils.get('rats:rat_nugget_ore', 98, 1, {OreItem: {Count: 1, id: "astralsorcery:blockcustomore", Damage: 1 as short}, IngotItem: {Count: 1, id: "astralsorcery:itemcraftingcomponent", Damage: 1 as short}}), utils.get('astralsorcery:itemcraftingcomponent', 1));
infinFurnace(utils.get('rats:rat_nugget_ore', 99, 1, {OreItem: {Count: 1, id: "biomesoplenty:gem_ore", Damage: 4 as short}, IngotItem: {Count: 1, id: "biomesoplenty:gem", Damage: 4 as short}}), utils.get('biomesoplenty:gem', 4));
infinFurnace(utils.get('rats:rat_nugget_ore', 100, 1, {OreItem: {Count: 1, id: "nuclearcraft:ore", Damage: 3 as short}, IngotItem: {Count: 1, id: "nuclearcraft:ingot", Damage: 3 as short}}), utils.get('nuclearcraft:ingot', 3));
infinFurnace(utils.get('rats:rat_nugget_ore', 101, 1, {OreItem: {Count: 1, id: "thermalfoundation:ore", Damage: 1 as short}, IngotItem: {Count: 1, id: "thermalfoundation:material", Damage: 129 as short}}), utils.get('thermalfoundation:material', 129));
infinFurnace(utils.get('rats:rat_nugget_ore', 102, 1, {OreItem: {Count: 1, id: "biomesoplenty:gem_ore", Damage: 3 as short}, IngotItem: {Count: 1, id: "biomesoplenty:gem", Damage: 3 as short}}), utils.get('biomesoplenty:gem', 3));
infinFurnace(utils.get('rats:rat_nugget_ore', 103, 1, {OreItem: {Count: 1, id: "endreborn:block_wolframium_ore", Damage: 0 as short}, IngotItem: {Count: 1, id: "endreborn:item_ingot_wolframium", Damage: 0 as short}}), utils.get('endreborn:item_ingot_wolframium'));
infinFurnace(utils.get('rats:rat_nugget_ore', 104, 1, {OreItem: {Count: 1, id: "immersiveengineering:ore", Damage: 5 as short}, IngotItem: {Count: 1, id: "immersiveengineering:metal", Damage: 5 as short}}), utils.get('immersiveengineering:metal', 5));
infinFurnace(utils.get('rats:rat_nugget_ore', 0, 1, {OreItem: {Count: 1, id: "thermalfoundation:ore", Damage: 4 as short}, IngotItem: {Count: 1, id: "thermalfoundation:material", Damage: 132 as short}}), utils.get('thermalfoundation:material', 132));
infinFurnace(utils.get('rats:raw_rat', W), utils.get('rats:cooked_rat'));
blacklist('rustic:dust_tiny_iron');
infinFurnace(utils.get('rustic:honeycomb'), utils.get('rustic:beeswax'));
// SKIP: 'rustic:log', 1
// SKIP: 'rustic:log'
infinFurnace(utils.get('tcomplement:scorched_block', 1), utils.get('tcomplement:scorched_block'));
blacklist('tcomplement:scorched_block', 3);
blacklist('tcomplement:scorched_slab', 3);
blacklist('tcomplement:scorched_stairs_brick', W);
infinFurnace(utils.get('tconevo:earth_material_block'), utils.get('tconevo:material', 1));
infinFurnace(utils.get('tconevo:edible'), utils.get('tconevo:edible', 1));
blacklist('tconevo:metal', 1);
blacklist('tconevo:metal', 6);
blacklist('tconevo:metal', 11);
blacklist('tconevo:metal', 16);
blacklist('tconevo:metal', 21);
blacklist('tconevo:metal', 26);
blacklist('tconevo:metal', 31);
blacklist('tconevo:metal', 36);
blacklist('tconevo:metal', 41);
infinFurnace(utils.get('tconstruct:brownstone', 1), utils.get('tconstruct:brownstone'));
blacklist('tconstruct:brownstone', 3);
infinFurnace(utils.get('tconstruct:ore', 1), utils.get('tconstruct:ingots', 1));
infinFurnace(utils.get('tconstruct:ore'), utils.get('tconstruct:ingots'));
blacklist('tconstruct:seared', 3);
infinFurnace(utils.get('tconstruct:slime_congealed', 1), utils.get('tconstruct:slime_channel', 1, 3));
infinFurnace(utils.get('tconstruct:slime_congealed', 2), utils.get('tconstruct:slime_channel', 2, 3));
infinFurnace(utils.get('tconstruct:slime_congealed', 3), utils.get('tconstruct:slime_channel', 3, 3));
infinFurnace(utils.get('tconstruct:slime_congealed', 4), utils.get('tconstruct:slime_channel', 4, 3));
blacklist('tconstruct:slime_congealed', 5);
infinFurnace(utils.get('tconstruct:slime_congealed'), utils.get('tconstruct:slime_channel', 0, 3));
infinFurnace(utils.get('tconstruct:soil', 1), utils.get('tconstruct:materials', 9));
infinFurnace(utils.get('tconstruct:soil', 2), utils.get('tconstruct:materials', 10));
infinFurnace(utils.get('tconstruct:soil', 3), utils.get('tconstruct:soil', 4));
infinFurnace(utils.get('tconstruct:soil', 5), utils.get('tconstruct:materials', 11));
infinFurnace(utils.get('tconstruct:soil'), utils.get('tconstruct:materials'));
infinFurnace(utils.get('tconstruct:spaghetti', 2), utils.get('tconstruct:moms_spaghetti'));
infinFurnace(utils.get('thaumcraft:cluster', 1), utils.get('minecraft:gold_ingot', 0, 2));
infinFurnace(utils.get('thaumcraft:cluster', 2), utils.get('thermalfoundation:material', 128, 2));
infinFurnace(utils.get('thaumcraft:cluster', 3), utils.get('thermalfoundation:material', 129, 2));
infinFurnace(utils.get('thaumcraft:cluster', 4), utils.get('thermalfoundation:material', 130, 2));
infinFurnace(utils.get('thaumcraft:cluster', 5), utils.get('thermalfoundation:material', 131, 2));
infinFurnace(utils.get('thaumcraft:cluster', 6), utils.get('thaumcraft:quicksilver', 0, 2));
infinFurnace(utils.get('thaumcraft:cluster', 7), utils.get('minecraft:quartz', 0, 5));
infinFurnace(utils.get('thaumcraft:cluster'), utils.get('minecraft:iron_ingot', 0, 2));
// SKIP: 'thaumcraft:log_greatwood', W
// SKIP: 'thaumcraft:log_silverwood', W
infinFurnace(utils.get('thaumcraft:ore_amber', W), utils.get('thaumcraft:amber'));
infinFurnace(utils.get('thaumcraft:ore_cinnabar', W), utils.get('thaumcraft:quicksilver'));
blacklist('thaumcraft:ore_quartz', W);
infinFurnace(utils.get('thaumicaugmentation:stone', 10), utils.get('thaumcraft:stone_ancient_rock'));
blacklist('thermalfoundation:material', 1);
blacklist('thermalfoundation:material', 64);
blacklist('thermalfoundation:material', 65);
blacklist('thermalfoundation:material', 66);
blacklist('thermalfoundation:material', 67);
blacklist('thermalfoundation:material', 68);
blacklist('thermalfoundation:material', 69);
blacklist('thermalfoundation:material', 70);
blacklist('thermalfoundation:material', 71);
blacklist('thermalfoundation:material', 72);
blacklist('thermalfoundation:material', 96);
blacklist('thermalfoundation:material', 97);
blacklist('thermalfoundation:material', 98);
blacklist('thermalfoundation:material', 99);
blacklist('thermalfoundation:material', 100);
infinFurnace(utils.get('thermalfoundation:material', 801), utils.get('minecraft:coal', 1));
blacklist('thermalfoundation:material', 864);
blacklist('thermalfoundation:material');
infinFurnace(utils.get('thermalfoundation:ore', 1), utils.get('thermalfoundation:material', 129));
infinFurnace(utils.get('thermalfoundation:ore', 2), utils.get('thermalfoundation:material', 130));
infinFurnace(utils.get('thermalfoundation:ore', 3), utils.get('thermalfoundation:material', 131));
infinFurnace(utils.get('thermalfoundation:ore', 4), utils.get('thermalfoundation:material', 132));
infinFurnace(utils.get('thermalfoundation:ore', 5), utils.get('thermalfoundation:material', 133));
infinFurnace(utils.get('thermalfoundation:ore', 6), utils.get('thermalfoundation:material', 134));
infinFurnace(utils.get('thermalfoundation:ore', 7), utils.get('thermalfoundation:material', 135));
infinFurnace(utils.get('thermalfoundation:ore', 8), utils.get('thermalfoundation:material', 136));
infinFurnace(utils.get('thermalfoundation:ore'), utils.get('thermalfoundation:material', 128));
infinFurnace(utils.get('threng:material', 2), utils.get('threng:material'));
blacklist('trinity:dust_au_198', W);
infinFurnace(utils.get('twilightforest:armor_shard_cluster', W), utils.get('twilightforest:knightmetal_ingot'));
infinFurnace(utils.get('twilightforest:ironwood_raw', W), utils.get('twilightforest:ironwood_ingot', 0, 2));
infinFurnace(utils.get('twilightforest:magic_beans'), utils.get('randomthings:beans', 2));
// SKIP: 'twilightforest:magic_log', W
infinFurnace(utils.get('twilightforest:raw_meef', W), utils.get('twilightforest:cooked_meef'));
infinFurnace(utils.get('twilightforest:raw_venison', W), utils.get('twilightforest:cooked_venison'));
// SKIP: 'twilightforest:twilight_log', W
/**/
