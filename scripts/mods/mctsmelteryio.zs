#modloaded mctsmelteryio

import crafttweaker.item.IIngredient;

// Remove unused upgrades
Purge(<mctsmelteryio:upgrade:1>);
Purge(<mctsmelteryio:upgrade:2>);
Purge(<mctsmelteryio:upgrade:3>);

<mctsmelteryio:upgrade:4>.maxStackSize = 16;
<mctsmelteryio:upgrade:6>.maxStackSize = 64;

// Ice balls
scripts.process.mash(<biomesoplenty:hard_ice>, (<mctsmelteryio:iceball> ?? <iceandfire:dragon_ice>) * 8, 'No Exceptions');

for input, amount in {
  <minecraft:glass_bottle>: 1,
  <minecraft:potion>.withTag({ Potion: 'minecraft:water' }): 2,
  <minecraft:potion:*>: 3,
  <rustic:elixir>.withTag({ display: { Name: 'ANY Elixir' } }, false): 10, // Elixir
} as int[IIngredient]$orderly {
  // [Base Upgrade]
  craft.remake(<mctsmelteryio:upgrade> * amount, ['pretty',
    '□ □ □',
    'п E п',
    '□ □ □'], {
    '□': <ore:plateLapis>,    // Lapis Lazuli Plate
    'п': <ore:plateAluminum>, // Aluminum Plate
    'E': input,
  });
}

// [Speed Upgrade] from [Base Upgrade][+1]
craft.reshapeless(<mctsmelteryio:upgrade:6>, 'BAA', {
  'B': <mctsmelteryio:upgrade>, // Base Upgrade
  'A': <ore:listAllsugar>,      // Sugar
});

// [Slot Size Upgrade 4] from [Base Upgrade][+2]
craft.remake(<mctsmelteryio:upgrade:4>, ['pretty',
  '  c  ',
  '‚ B ‚',
  '  ‚  '], {
  'c': <ore:chest>, // Oak Chest
  '‚': <ore:nuggetKnightslime>, // Knightslime Nugget
  'B': <mctsmelteryio:upgrade>, // Base Upgrade
});

// [Casting_Machine] from [Casting_Table][+3]
craft.remake(<mctsmelteryio:machine:1>, ['pretty',
  '□ S □',
  'i C i',
  '□ i □'], {
  '□': <ore:blockSeared>,        // Seared Stone
  'C': <tconstruct:casting>,     // Casting Table
  'S': <tconstruct:smeltery_io>,
  'i': <ore:ice>,                 // Ice
});
