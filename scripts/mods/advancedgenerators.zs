#modloaded advgenerators

import crafttweaker.item.IIngredient;

// Power IO Module
recipes.addShapedMirrored('AdvancedGenerators Power IO Module',
  <advgenerators:power_io>,
  [[<ore:ingotSilver>, <ore:ingotTin>, <ore:ingotSilver>],
    [<ore:ingotTin>, <gendustry:power_module>, <ore:ingotTin>],
    [<ore:ingotSilver>, <ore:ingotTin>, <ore:ingotSilver>]]);

// Iron Tubing
mods.actuallyadditions.AtomicReconstructor.addRecipe(<advgenerators:iron_tubing>, <actuallyadditions:item_misc:7>, 10000);

// Redstone-Iron Tubing
mods.extrautils2.Resonator.add(<advgenerators:iron_wiring>, <advgenerators:iron_tubing>, 20 * 100);

// [Iron Frame*2] from [Iron Mechanical Component][+1]
craft.remake(<advgenerators:iron_frame> * 2, ['pretty',
  '╱   ╱',
  '  I  ',
  '╱   ╱'], {
  '╱': <ore:stickIron>, // Iron Rod
  'I': <immersiveengineering:material:8>, // Iron Mechanical Component
});

// [Control Circuit] from [Red Coal][+2]
craft.remake(<advgenerators:controller>, ['pretty',
  'A Q A',
  'E E E'], {
  'A': <ore:circuitAdvanced>, // Advanced Circuit
  'Q': <extrautils2:ingredients:4>, // Red Coal
  'E': <forestry:thermionic_tubes:12>, // Ender Electron Tube
});

// [Pressure Valve] from [Hardened Fluiduct][+2]
craft.remake(<advgenerators:pressure_valve>, ['pretty',
  'D I D',
  'I H I',
  'D I D'], {
  'D': <mekanism:basicblock:11>, // Dynamic Valve
  'H': <extrautils2:flattransfernode:1>,
  'I': <advgenerators:iron_tubing>, // Iron Tubing
});

// [Advanced Pressure Valve] from [Pressure Valve][+1]
recipes.remove(<advgenerators:advanced_pressure_valve>);
scripts.process.fill(<advgenerators:pressure_valve>, <fluid:syngas> * 1000, <advgenerators:advanced_pressure_valve>, 'only: MechanicalDryingBasin NCInfuser Transposer');

val turbineTypes = {
  iron     : { '▬': <ore:plateIron>         , '/': <tconstruct:large_plate>.withTag({ Material: 'construction_alloy' }) | <tconstruct:large_plate>.withTag({ Material: 'iron' }), 'o': <advgenerators:iron_tubing> },
  bronze   : { '▬': <ore:plateBronze>       , '/': <tconstruct:large_plate>.withTag({ Material: 'bronze' })        , 'o': <forestry:sturdy_machine> },
  gold     : { '▬': <ore:plateGold>         , '/': <tconstruct:large_plate>.withTag({ Material: 'electrum' })      , 'o': <actuallyadditions:item_crystal_empowered:4> },
  steel    : { '▬': <ore:plateSteel>        , '/': <tconstruct:large_plate>.withTag({ Material: 'steel' })         , 'o': <enderio:item_basic_capacitor> },
  adv_alloy: { '▬': <ore:plateAdvancedAlloy>, '/': <tconstruct:large_plate>.withTag({ Material: 'advanced_alloy' }), 'o': <ore:stickTitaniumIridium> },
  manyullyn: { '▬': <ore:ingotManyullyn>    , '/': <tconstruct:large_plate>.withTag({ Material: 'manyullyn' })     , 'o': <mysticalagriculture:crafting:32> },
  enderium : { '▬': <ore:plateEnderium>     , '/': <tconstruct:large_plate>.withTag({ Material: 'enderium' })      , 'o': <thermalfoundation:material:895> },
} as IIngredient[string][string];

for name, ingrs in turbineTypes {
  val blade   = itemUtils.getItem('advgenerators:turbine_blade_' ~ name);
  val rotor   = itemUtils.getItem('advgenerators:turbine_rotor_' ~ name);
  val kit     = itemUtils.getItem('advgenerators:turbine_kit_' ~ name);
  val turbine = itemUtils.getItem('advgenerators:turbine_' ~ name);

  ingrs['B'] = blade;
  ingrs['R'] = rotor;

  // Blade
  craft.make(blade * 4, ['pretty',
    '▬ ▬',
    '▬ ▬',
    '  ▬'], ingrs);

  // Rotor
  craft.make(name == 'iron' ? rotor * 4 : rotor, ['pretty',
    'B B B',
    'B / B',
    'B B B'], ingrs);

  if (name == 'iron') {
    // Turbine
    craft.make(turbine * 4, ['pretty',
      'r ◙ r',
      '◙ o ◙',
      'r ◙ r'], {
      'r': rotor,
      '◙': <advgenerators:iron_frame>, // Iron Frame
      'o': ingrs['o'],
    });
  }
  else {
    // Turbine
    craft.make(turbine, ['pretty',
      '◙ ◙ ◙',
      'R r R',
      '◙ o ◙'], {
      'r': rotor,
      'R': <advgenerators:iron_wiring>, // Redstone-Iron Wiring
      '◙': <advgenerators:iron_frame>, // Iron Frame
      'o': ingrs['o'],
    });
  }

  // Kit
  if (isNull(kit)) continue;
  craft.shapeless(kit, 'MUo', {
    'M': rotor,
    'U': <advgenerators:upgrade_kit>,
    'o': ingrs['o'],
  });

  // Fluid recycle
  val fluidName = D(ingrs['/'].items[0].tag).getString('Material');
  val fluid = !isNull(fluidName) ? game.getLiquid(fluidName) : null;
  if (!isNull(fluid)) {
    mods.tconstruct.Melting.addRecipe(name == 'iron' ? fluid * (648) : fluid * (2592), rotor);
  }
  else {
    val item = ingrs['▬'].items[0];
    recipes.addShapeless(name == 'iron' ? item * 4 : item * 18, [rotor]);
  }
}
