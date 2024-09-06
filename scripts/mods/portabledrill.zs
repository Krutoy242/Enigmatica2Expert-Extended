#modloaded portabledrill

import scripts.jei.crafting_hints;

// [Portable_Drill] from [Bedrock_Miner][+2]
craft.remake(<portabledrill:portable_drill>, ['pretty',
  '╱ B ╱',
  '  |  ',
  '  |  '], {
  '╱': <ore:stickSteel>,                 // Steel Rod
  'B': <bedrockores:bedrock_miner>,      // Bedrock Miner
  '|': <immersiveengineering:coresample>, // Core Sample
});

// Recipe hint for mineral sampling via Portable Drill
crafting_hints.add1to1(<portabledrill:portable_drill>, <immersiveengineering:coresample>);