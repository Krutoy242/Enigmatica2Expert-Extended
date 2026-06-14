#modloaded smelteryio

import crafttweaker.item.IIngredient;

// Remove unused upgrades
Purge(<smelteryio:upgrade:1>);
Purge(<smelteryio:upgrade:2>);
Purge(<smelteryio:upgrade:3>);

<smelteryio:upgrade:4>.maxStackSize = 16;
<smelteryio:upgrade:6>.maxStackSize = 64;

// Ice balls
scripts.process.mash(<biomesoplenty:hard_ice>, (<smelteryio:iceball> ?? <iceandfire:dragon_ice>) * 8, 'No Exceptions');

for input, amount in {
  <minecraft:glass_bottle>: 1,
  <minecraft:potion>.withTag({ Potion: 'minecraft:water' }): 2,
  <minecraft:potion:*>: 3,
  <rustic:elixir>.withTag({ display: { Name: 'ANY Elixir' } }, false): 10, // Elixir
} as int[IIngredient]$orderly {
  // [Base Upgrade]
  craft.remake(<smelteryio:upgrade> * amount, ['pretty',
    '□ □ □',
    'п E п',
    '□ □ □'], {
    '□': <ore:plateLapis>,    // Lapis Lazuli Plate
    'п': <ore:plateAluminum>, // Aluminum Plate
    'E': input,
  });
}

// [Speed Upgrade] from [Base Upgrade][+1]
craft.reshapeless(<smelteryio:upgrade:6>, 'BAA', {
  'B': <smelteryio:upgrade>, // Base Upgrade
  'A': <ore:listAllsugar>,      // Sugar
});

// [Slot Size Upgrade 4] from [Base Upgrade][+2]
craft.remake(<smelteryio:upgrade:4>, ['pretty',
  '  c  ',
  '‚ B ‚',
  '  ‚  '], {
  'c': <ore:chest>, // Oak Chest
  '‚': <ore:nuggetKnightslime>, // Knightslime Nugget
  'B': <smelteryio:upgrade>, // Base Upgrade
});

// [Casting_Machine] from [Casting_Table][+3]
craft.remake(<smelteryio:machine:1>, ['pretty',
  '□ S □',
  'i C i',
  '□ i □'], {
  '□': <ore:blockSeared>,        // Seared Stone
  'C': <tconstruct:casting>,     // Casting Table
  'S': <tconstruct:smeltery_io>,
  'i': <ore:ice>,                 // Ice
});
