#modloaded exnihilocreatio requious
#priority 950

import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.liquid.ILiquidStack;
import mods.requious.AssemblyRecipe;
import mods.requious.SlotVisual;

import scripts.jei.requious.add as addRecipe;

var x = <assembly:scented_hive>;
x.addJEICatalyst(<exnihilocreatio:hive:1>);
x.setJEIDurationSlot(3, 0, 'duration', scripts.jei.requious.getVisSlots(5, 1));
scripts.jei.requious.addInsOuts(x, [[1, 0], [2, 0], [0, 0]], [[4, 0]]);

/* Inject_js(
JSON.parse(loadText('config/exnihilocreatio/ScentedHiveRegistry.json'))
.map(l=>`addRecipe(x, { [<exnihilocreatio:hive:1>, ${
  Object.keys(l.adjacentBlocks).map(i=>`<${i}>`).join(', ')
}]: [<${l.hive}>] });`)
.join('\n')
) */
addRecipe(x, { [<exnihilocreatio:hive:1>, <ore:treeLeaves>, <ore:logWood>]: [<forestry:beehives:0>] });
addRecipe(x, { [<exnihilocreatio:hive:1>, <ore:flower>]: [<forestry:beehives:1>] });
addRecipe(x, { [<exnihilocreatio:hive:1>, <ore:sand>]: [<forestry:beehives:2>] });
addRecipe(x, { [<exnihilocreatio:hive:1>, <minecraft:log:3>, <ore:treeLeaves>]: [<forestry:beehives:3>] });
addRecipe(x, { [<exnihilocreatio:hive:1>, <minecraft:end_stone:0>]: [<forestry:beehives:4>] });
addRecipe(x, { [<exnihilocreatio:hive:1>, <minecraft:ice:0>, <minecraft:snow:0>]: [<forestry:beehives:5>] });
addRecipe(x, { [<exnihilocreatio:hive:1>, <ore:dirt>]: [<forestry:beehives:6>] });
/**/

// -----------------------------------------------------------------------
// -----------------------------------------------------------------------
x = <assembly:witch_water>;
x.addJEICatalyst(Bucket('witchwater'));
x.addJEICatalyst(<exnihilocreatio:witchwater>);
x.setJEIDurationSlot(1, 0, 'duration', scripts.jei.requious.getVisGauge(1, 8));
scripts.jei.requious.addInsOuts(x, [[0, 0]], [[2, 0]]);
addRecipe(x, { [<entity:minecraft:skeleton>.asIngr()]: [<entity:minecraft:wither_skeleton>.asStack()] });
addRecipe(x, { [<entity:minecraft:creeper>.asIngr()]: [<entity:minecraft:creeper>.asStack()] });
addRecipe(x, { [<entity:minecraft:slime>.asIngr()]: [<entity:minecraft:magma_cube>.asStack()] });
addRecipe(x, { [<entity:minecraft:spider>.asIngr()]: [<entity:minecraft:cave_spider>.asStack()] });
addRecipe(x, { [<entity:minecraft:squid>.asIngr()]: [<entity:minecraft:ghast>.asStack()] });
addRecipe(x, { [<entity:minecraft:villager>.asIngr()]: [<entity:minecraft:zombie_villager>.asStack()] });
addRecipe(x, { [<entity:minecraft:villager>.asIngr()]: [<entity:minecraft:witch>.asStack()] });
addRecipe(x, { [<entity:minecraft:villager>.asIngr()]: [<entity:minecraft:evocation_illager>.asStack()] });
addRecipe(x, { [<entity:minecraft:villager>.asIngr()]: [<entity:minecraft:vindication_illager>.asStack()] });
addRecipe(x, { [<entity:minecraft:pig>.asIngr()]: [<entity:minecraft:zombie_pigman>.asStack()] });
addRecipe(x, { [<entity:minecraft:cow>.asIngr()]: [<entity:minecraft:mooshroom>.asStack()] });
addRecipe(x, { [<openblocks:luggage>]: [<openblocks:luggage>.withTag({ size: 54 })] });

// -----------------------------------------------------------------------
// -----------------------------------------------------------------------
x = <assembly:barrel_milking>;
x.addJEICatalyst(<exnihilocreatio:block_barrel0>);
x.addJEICatalyst(<exnihilocreatio:block_barrel1>);
x.setJEIItemSlot(0, 0, 'input0');
x.setJEIDurationSlot(1, 0, 'duration', SlotVisual.arrowRight());
x.setJEIItemSlot(2, 0, 'input1');
x.setJEIDurationSlot(3, 0, 'duration', SlotVisual.arrowRight());
x.setJEIFluidSlot(4, 0, 'fluid_out');

function add_barrel_milking(input as IIngredient, barrel as IItemStack, output as ILiquidStack, duration as int) as void {
  <assembly:barrel_milking>.addJEIRecipe(AssemblyRecipe.create(function (c) {
    c.addFluidOutput('fluid_out', output);
  })
    .requireItem('input0', input)
    .requireItem('input1', barrel)
    .requireDuration('duration', max(1, duration))
  );
}

val WB = <exnihilocreatio:block_barrel0>;
val SB = <exnihilocreatio:block_barrel1>;
/* Inject_js{
const blacklist = loadJson("config/exnihilocreatio/BarrelLiquidBlacklistRegistry.json")[0]
return loadJson("config/exnihilocreatio/MilkEntityRegistry.json")
.map(o=>[
  `add_barrel_milking(<entity:${o.entityOnTop}>.asIngr()`,
  blacklist.includes(o.result) ? ', SB' : ', WB',
  `, <liquid:${o.result}>`, ` * ${o.amount}`,
  `, ${o.coolDown});`
])
} */
add_barrel_milking(<entity:minecraft:cow>.asIngr()                , WB, <liquid:milk>               * 10 , 20);
add_barrel_milking(<entity:emberroot:timberwolf>.asIngr()         , WB, <liquid:tree_oil>           * 10 , 20);
add_barrel_milking(<entity:emberroot:rainbow_golem>.asIngr()      , SB, <liquid:construction_alloy> * 10 , 20);
add_barrel_milking(<entity:excompressum:angry_chicken>.asIngr()   , SB, <liquid:fiery_essence>      * 10 , 20);
add_barrel_milking(<entity:emberroot:skeleton_frozen>.asIngr()    , WB, <liquid:ice>                * 10 , 20);
add_barrel_milking(<entity:mekanism:robit>.asIngr()               , SB, <liquid:electronics>        * 10 , 20);
add_barrel_milking(<entity:endreborn:watcher>.asIngr()            , SB, <liquid:obsidian>           * 40 , 20);
add_barrel_milking(<entity:betteranimalsplus:hirschgeist>.asIngr(), SB, <liquid:platinum>           * 10 , 20);
add_barrel_milking(<entity:rats:neo_ratlantean>.asIngr()          , SB, <liquid:crystal_matrix>     * 1  , 20);
add_barrel_milking(<entity:iceandfire:if_cockatrice>.asIngr()     , SB, <liquid:gelatin>            * 10 , 20);
add_barrel_milking(<entity:openblocks:mini_me>.asIngr()           , WB, <liquid:blockfluiddirt>     * 100, 20);
/**/
