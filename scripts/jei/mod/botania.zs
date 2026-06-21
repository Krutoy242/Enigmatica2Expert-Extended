#modloaded botania requious
#priority 950

import mods.requious.AssemblyRecipe;
import mods.requious.SlotVisual;

scripts.jei.crafting_hints.addInsOutCatl([], <botania:bifrost>, <botania:rainbowrod>);

// -----------------------------------------------------------------------
// -----------------------------------------------------------------------
val x = <assembly:petro_petunia>;
x.addJEICatalyst(<botania:specialflower>.withTag({ type: 'petro_petunia' }));
x.addJEICatalyst(<botania:floatingspecialflower>.withTag({ type: 'petro_petunia' }));
x.setJEIFluidSlot(0, 0, 'liquid_input');
x.setJEIDurationSlot(2, 0, 'duration', SlotVisual.arrowRight());
x.setJEIItemSlot(4, 0, 'output0');

for fluid, arr in {
/* Inject_js(
Object.entries(
  config('config/acronym/floralchemy.cfg').fuelvalues
).map(([fluid, {burnTime, powerPreTick}]) =>
  [fluid, ((20*60) / burnTime * 1000) | 0, powerPreTick * burnTime]
).sort((a, b) => b[2] - a[2])
.map(([fluid, consumption, manaTotal]) =>
  `  ${("'"+fluid+"'").padEnd(14)+':'} [${consumption}, ${manaTotal}],`
)) */
  'perfect_fuel': [25, 384000000],
  'rocketfuel'  : [1000, 240000],
  'diesel'      : [6857, 8750],
  'biodiesel'   : [9600, 6250],
  'biomass'     : [9600, 6250],
  'oil'         : [24000, 2500],
/**/
} as int[][string]$orderly {
  val consumption = arr[0];
  val manaTotal = arr[1];
  x.addJEIRecipe(AssemblyRecipe.create(function (container) {
    container.addItemOutput('output0',
      <botania:manatablet>.withTag({ mana: min(500000, manaTotal), display: { Name: '§b' ~ manaTotal ~ ' Mana' } })
      * (manaTotal / 500000 + 1)
    );
  })
    .requireFluid('liquid_input', game.getLiquid(fluid) * consumption)
  );
}
