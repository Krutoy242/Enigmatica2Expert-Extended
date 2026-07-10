// Used for $orderly
#modloaded zenutils
#priority 10
#reloadable

import crafttweaker.data.IData;
import crafttweaker.item.IItemStack;

// ######################################################################
//
// Data
//
// ######################################################################
static defaultArmorMats as int[string]$orderly = {
/* Inject_js(
  getCSV('dev/tools/tcon/stats/Armory Stats.csv')
  .map(l=>Object.keys(l).slice(0,2).map(k=>l[k].trim()))
  .map(([a, b])=>[`  '${a}'`, ': ' + Math.round(b) + ','])
) */
  'void_crystal'           : 18,
  'flint'                  : 25,
  'tin'                    : 26,
  'enchanted_fabric'       : 28,
  'restonia_crystal'       : 28,
  'apatite'                : 28,
  'xu_demonic_metal'       : 28,
  'stone'                  : 30,
  'construction_alloy'     : 41,
  'iron'                   : 45,
  'paper'                  : 48,
  'xu_evil_metal'          : 49,
  'chocolate'              : 49,
  'nickel'                 : 50,
  'tanzanite'              : 52,
  'cactus'                 : 53,
  'heavy'                  : 58,
  'topaz'                  : 59,
  'blueslime'              : 60,
  'invar'                  : 60,
  'sapphire'               : 60,
  'lonsdaleite'            : 60,
  'slime'                  : 60,
  'wood'                   : 61,
  'bronze'                 : 62,
  'netherrack'             : 62,
  'electrum'               : 62,
  'mica'                   : 62,
  'prismarine'             : 64,
  'peridot'                : 65,
  'energetic_metal'        : 67,
  'aluminium'              : 67,
  'pigiron'                : 67,
  'aquamarine'             : 69,
  'obsidian'               : 69,
  'ghostwood'              : 69,
  'magnesium'              : 70,
  'certus_quartz'          : 70,
  'bone'                   : 70,
  'diamantine_crystal'     : 71,
  'palis_crystal'          : 72,
  'nagascale'              : 71,
  'constantan'             : 71,
  'alumite'                : 72,
  'silver'                 : 73,
  'alubrass'               : 72,
  'livingrock'             : 72,
  'sponge'                 : 72,
  'kyronite'               : 73,
  'sentient_metal'         : 74,
  'polyethylene'           : 74,
  'copper'                 : 74,
  'cobalt'                 : 74,
  'treatedwood'            : 74,
  'electrical_steel'       : 76,
  'xu_magical_wood'        : 76,
  'leatherforesttroll'     : 77,
  'leatherfrosttroll'      : 77,
  'leathermountaintroll'   : 77,
  'magmaslime'             : 76,
  'fierymetal'             : 77,
  'amber'                  : 77,
  'conductive_iron'        : 78,
  'endstone'               : 78,
  'sky_stone'              : 78,
  'dragonbone'             : 79,
  'malachite_gem'          : 79,
  'firewood'               : 80,
  'lumium'                 : 80,
  'knightslime'            : 82,
  'redstone_alloy'         : 81,
  'alpha_fur'              : 82,
  'ionite'                 : 82,
  'fluxed_electrum'        : 83,
  'ma.prosperity'          : 83,
  'boron'                  : 84,
  'pink_slime'             : 85,
  'ruby'                   : 85,
  'manyullyn'              : 85,
  'ardite'                 : 86,
  'pladium'                : 87,
  'bloodbone'              : 87,
  'emerald_plustic'        : 88,
  'emeraldic_crystal'      : 89,
  'steel'                  : 90,
  'ma.base_essence'        : 91,
  'rubber'                 : 91,
  'tough'                  : 91,
  'desert_myrmex'          : 93,
  'jungle_myrmex'          : 93,
  'flux_crystal'           : 92,
  'fluix_steel'            : 93,
  'livingwood'             : 94,
  'enderium'               : 94,
  'cheese'                 : 95,
  'dark_steel'             : 95,
  'pulsating_iron'         : 95,
  'xu_enchanted_metal'     : 96,
  'hard_carbon'            : 96,
  'ma.soulium'             : 97,
  'draconium'              : 97,
  'litherite'              : 100,
  'vibrant_alloy'          : 102,
  'mithminite'             : 102,
  'refined_glowstone'      : 102,
  'ma.inferium'            : 103,
  'bound_metal'            : 103,
  'amethyst'               : 104,
  'scalesapphiredragon'    : 105,
  'psimetal'               : 105,
  'thaumium'               : 110,
  'scalesilverdragon'      : 110,
  'advanced_alloy'         : 110,
  'end_steel'              : 110,
  'meat_metal'             : 110,
  'mithrillium'            : 110,
  'uranium'                : 111,
  'iridium'                : 111,
  'refined_obsidian'       : 111,
  'titanium'               : 112,
  'universal_metal'        : 112,
  'thorium'                : 113,
  'darkwood'               : 113,
  'scalebluedragon'        : 113,
  'plague_metal'           : 113,
  'bloodwood'              : 113,
  'endorium'               : 114,
  'dreamwood'              : 115,
  'psigem'                 : 115,
  'osgloglas'              : 116,
  'boron_nitride'          : 116,
  'scalewhitedragon'       : 116,
  'erodium'                : 116,
  'manasteel'              : 116,
  'scaleblueseaserpent'    : 116,
  'scalebronzeseaserpent'  : 116,
  'scaledeepblueseaserpent': 116,
  'scalegreenseaserpent'   : 116,
  'scalepurpleseaserpent'  : 116,
  'scaleredseaserpent'     : 116,
  'scaletealseaserpent'    : 116,
  'black_quartz'           : 117,
  'void_metal'             : 118,
  'ma.prudentium'          : 119,
  'energetic_alloy'        : 119,
  'steeleaf'               : 119,
  'fusewood'               : 121,
  'chitinbrowndeathworm'   : 123,
  'chitintandeathworm'     : 123,
  'chitinwhitedeathworm'   : 123,
  'carbon_fiber'           : 124,
  'signalum'               : 125,
  'knightmetal'            : 128,
  'dragonsteel_ice'        : 130,
  'scalegraydragon'        : 131,
  'dragonsteel_fire'       : 134,
  'fluix'                  : 136,
  'ma.intermedium'         : 137,
  'primal_metal'           : 138,
  'pink_metal'             : 139,
  'osmium'                 : 140,
  'lead'                   : 142,
  'sunnarium'              : 142,
  'dark_matter'            : 144,
  'elementium'             : 144,
  'blood_infused_glitch'   : 148,
  'ma.superium'            : 157,
  'adaminite'              : 160,
  'enori_crystal'          : 168,
  'platinum'               : 170,
  'starmetal'              : 171,
  'wyvern_metal'           : 174,
  'scalegreendragon'       : 178,
  'osmiridium'             : 178,
  'scalebronzedragon'      : 181,
  'scalereddragon'         : 181,
  'crystal_matrix'         : 187,
  'essence_metal'          : 189,
  'soularium'              : 194,
  'ichorium'               : 207,
  'spectre'                : 214,
  'red_matter'             : 214,
  'mirion'                 : 218,
  'gelid_enderium'         : 245,
  'terrasteel'             : 257,
  'aethium'                : 292,
  'ma.supremium'           : 341,
  'gelid_gem'              : 344,
  'fireproof'              : 438,
  'draconic_metal'         : 451,
  'neutronium'             : 487,
  'chaotic_metal'          : 814,
  'infinity_metal'         : 2220,
/**/
} as int[string]$orderly;

static defaultWeaponMats as int[string]$orderly = {
/* Inject_js(
  getCSV('dev/tools/tcon/stats/Stats.csv')
  .map(l=>Object.keys(l).slice(0,2).map(k=>l[k].trim()))
  .map(([a, b])=>[`  '${a}'`, ': ' + Math.round(b) + ','])
) */
  'stone'               : 41,
  'paper'               : 47,
  'construction_alloy'  : 51,
  'rubber'              : 54,
  'flint'               : 63,
  'chocolate'           : 73,
  'tin'                 : 77,
  'blueslime'           : 80,
  'wood'                : 82,
  'slime'               : 86,
  'cactus'              : 87,
  'netherrack'          : 94,
  'apatite'             : 95,
  'livingrock'          : 101,
  'xu_magical_wood'     : 102,
  'magmaslime'          : 102,
  'soularium'           : 109,
  'polyethylene'        : 109,
  'prismarine'          : 110,
  'sponge'              : 111,
  'ma.prosperity'       : 111,
  'silver'              : 112,
  'pink_slime'          : 113,
  'bone'                : 117,
  'endstone'            : 117,
  'void_crystal'        : 118,
  'iron'                : 119,
  'firewood'            : 119,
  'bloodbone'           : 121,
  'treatedwood'         : 122,
  'lonsdaleite'         : 123,
  'cheese'              : 123,
  'amber'               : 123,
  'ma.soulium'          : 124,
  'obsidian'            : 125,
  'tanzanite'           : 125,
  'livingwood'          : 128,
  'dragonbone'          : 128,
  'xu_demonic_metal'    : 129,
  'ruby'                : 132,
  'mica'                : 134,
  'constantan'          : 135,
  'emerald_plustic'     : 135,
  'malachite_gem'       : 136,
  'desert_myrmex'       : 137,
  'jungle_myrmex'       : 137,
  'ardite'              : 137,
  'lead'                : 138,
  'alpha_fur'           : 138,
  'meat_metal'          : 139,
  'certus_quartz'       : 139,
  'nickel'              : 142,
  'aquamarine'          : 142,
  'bronze'              : 144,
  'flux_crystal'        : 145,
  'sapphire'            : 146,
  'sky_stone'           : 146,
  'alubrass'            : 147,
  'plague_metal'        : 147,
  'peridot'             : 151,
  'invar'               : 152,
  'lumium'              : 153,
  'pigiron'             : 154,
  'heavy'               : 155,
  'copper'              : 158,
  'black_quartz'        : 158,
  'palis_crystal'       : 159,
  'steel'               : 163,
  'energetic_alloy'     : 166,
  'aluminium'           : 166,
  'ma.base_essence'     : 166,
  'vibrant_alloy'       : 168,
  'topaz'               : 170,
  'knightslime'         : 173,
  'uranium'             : 174,
  'ma.inferium'         : 175,
  'carbon_fiber'        : 175,
  'dreamwood'           : 178,
  'diamantine_crystal'  : 181,
  'manyullyn'           : 183,
  'nagascale'           : 183,
  'advanced_alloy'      : 184,
  'osmium'              : 185,
  'electrical_steel'    : 188,
  'osmiridium'          : 194,
  'spectre'             : 194,
  'bloodwood'           : 195,
  'endorium'            : 196,
  'dark_steel'          : 198,
  'electrum'            : 198,
  'boron'               : 200,
  'alumite'             : 200,
  'amethyst'            : 202,
  'knightmetal'         : 204,
  'thorium'             : 204,
  'fluxed_electrum'     : 207,
  'fluix'               : 207,
  'redstone_alloy'      : 211,
  'restonia_crystal'    : 212,
  'ma.prudentium'       : 213,
  'sentient_metal'      : 214,
  'fluix_steel'         : 214,
  'energetic_metal'     : 217,
  'bound_metal'         : 222,
  'refined_glowstone'   : 225,
  'emeraldic_crystal'   : 228,
  'magnesium'           : 229,
  'fierymetal'          : 229,
  'pulsating_iron'      : 231,
  'fusewood'            : 232,
  'refined_obsidian'    : 233,
  'ghostwood'           : 234,
  'enori_crystal'       : 236,
  'enderium'            : 238,
  'xu_evil_metal'       : 241,
  'steeleaf'            : 242,
  'xu_enchanted_metal'  : 243,
  'cobalt'              : 246,
  'platinum'            : 251,
  'osgloglas'           : 253,
  'thaumium'            : 253,
  'tough'               : 254,
  'manasteel'           : 255,
  'psigem'              : 255,
  'hard_carbon'         : 256,
  'mithrillium'         : 259,
  'psimetal'            : 261,
  'starmetal'           : 262,
  'titanium'            : 271,
  'conductive_iron'     : 275,
  'signalum'            : 286,
  'boron_nitride'       : 291,
  'draconium'           : 292,
  'ma.intermedium'      : 293,
  'iridium'             : 298,
  'elementium'          : 302,
  'void_metal'          : 310,
  'pink_metal'          : 313,
  'wyvern_metal'        : 320,
  'mirion'              : 334,
  'sunnarium'           : 340,
  'universal_metal'     : 344,
  'crystal_matrix'      : 344,
  'end_steel'           : 348,
  'terrasteel'          : 353,
  'dragonsteel_ice'     : 355,
  'adaminite'           : 359,
  'dragonsteel_fire'    : 360,
  'darkwood'            : 370,
  'primal_metal'        : 372,
  'ichorium'            : 376,
  'mithminite'          : 395,
  'blood_infused_glitch': 424,
  'ma.superium'         : 436,
  'neutronium'          : 439,
  'litherite'           : 452,
  'dark_matter'         : 483,
  'fireproof'           : 490,
  'erodium'             : 523,
  'kyronite'            : 538,
  'essence_metal'       : 555,
  'draconic_metal'      : 573,
  'gelid_gem'           : 582,
  'pladium'             : 587,
  'ma.supremium'        : 664,
  'gelid_enderium'      : 686,
  'red_matter'          : 691,
  'ionite'              : 706,
  'aethium'             : 783,
  'chaotic_metal'       : 1042,
  'infinity_metal'      : 20107,
/**/
} as int[string]$orderly;

static armorEntitys as IData = [
  {
    entityID: [
      'minecraft:zombie',
      'minecraft:zombie_villager',
      'minecraft:husk',
      'emberroot:knight_fallen',
    ],
    groups: [
      {
        name      : 'Everyman',
        weight    : 20,
        ticWeapons: ['broadsword', 'longsword', 'rapier', 'frypan', 'battlesign', 'cleaver'],
      },
      {
        name      : 'Rare',
        weight    : 6,
        ticMats   : ['iron', 'pigiron', 'knightslime', 'slime', 'blueslime', 'magmaslime', 'netherrack', 'cobalt', 'ardite', 'manyullyn', 'steel'],
        ticWeapons: ['hammer', 'tcomplement:sledge_hammer', 'lumberaxe', 'scythe'],
      },
      {
        name      : 'Worker',
        weight    : 10,
        ticMats   : ['stone', 'flint', 'treatedwood', 'xu_magical_wood', 'firewood', 'chocolate', 'livingwood_plustic', 'ma.soulium', 'integrationforegoing.plastic', 'soularium', 'leathermountaintroll', 'leatherforesttroll', 'certusquartz_plustic', 'obsidian', 'lead', 'dragonbone', 'pigiron'],
        ticWeapons: ['pickaxe', 'shovel', 'hatchet', 'mattock', 'kama', 'exnihilocreatio:crook_tconstruct', 'excavator'],
      },
    ],
  },
  {
    entityID: [
      'minecraft:zombie_pigman',
    ],
    groups: [
      {
        ticMats   : ['copper', 'bronze', 'nickel', 'scalebronzedragon', 'cheese', 'scalebronzeseaserpent', 'magmaslime', 'energetic_alloy', 'electrum', 'fierymetal', 'amber', 'topaz', 'lumium_plustic', 'xu_evil_metal', 'refined_glowstone', 'awakened_plustic'],
        ticWeapons: ['frypan', 'battlesign'],
      },
    ],
  },
  {
    entityID: [
      'minecraft:wither_skeleton',
    ],
    groups: [
      {
        ticMats: ['construction_alloy', 'tough', 'thorium', 'blackquartz_plustic', 'void_actadd_plustic', 'plague_metal'],
      },
    ],
  },
  {
    entityID: [
      'minecraft:skeleton',
      'minecraft:stray',
      'quarq:ashen',
    ],
    groups: [
      {
        ticMats: ['paper', 'bone', 'chitinwhitedeathworm', 'chitintandeathworm', 'iron', 'enori_actadd_plustic', 'knightmetal', 'ma.base_essence', 'silver', 'scalewhitedragon', 'dragonbone', 'scalebluedragon', 'scalesilverdragon', 'invar', 'titanium', 'iridium', 'platinum_plustic', 'end_steel', 'endstone', 'xu_evil_metal'],
      },
    ],
  },
  {
    entityID: [
      'emberroot:hero',
    ],
    groups: [
      {
        ticMats: ['blueslime', 'cobalt', 'scaletealseaserpent', 'scaledeepblueseaserpent', 'scalesapphiredragon', 'ma.base_essence', 'starmetal', 'psimetal', 'sapphire', 'psigem', 'platinum_plustic', 'manasteel', 'palis_actadd_plustic', 'diamatine_actadd_plustic', 'hard_carbon', 'tanzanite', 'osmiridium', 'pladium', 'refined_obsidian', 'ionite'],
      },
    ],
  },
] as IData;

static normalizedWeights as double[][IData] = {};
for entry in armorEntitys.asList() {
  if (isNull(entry.groups.asList()) || entry.groups.length == 1) {
    normalizedWeights[entry] = [1.0];
    continue;
  }

  val list = entry.groups.asList();
  var summ = 0.0;
  for group in list {
    summ += group.weight?.asFloat() ?? 1.0;
  }

  var result = [] as double[];
  var a = 0.0;
  for group in list {
    a += (group.weight?.asFloat() ?? 1.0) / summ;
    result += a;
    utils.log('Normalized equip group [' ~ (group.name?.asString() ?? 'Default') ~ '] with prob. threshold: ' ~ a);
  }
  normalizedWeights[entry] = result;
}

// -------------------------------
// EQUIPMENT IDs
// -------------------------------
static armDefinitions as string[][] = [
  ['conarm:helmet'],
  ['conarm:chestplate'],
  ['conarm:leggings'],
  ['conarm:boots'],
  [
    'tconstruct:broadsword',
    'tconstruct:rapier',
    'tconstruct:frypan',
    'tconstruct:longsword',
    'tconstruct:cleaver',
    'tconstruct:pickaxe',
    'tconstruct:shovel',
    'tconstruct:hatchet',
    'tconstruct:mattock',
    'tconstruct:kama',
    'tconstruct:hammer',
    'tconstruct:excavator',
    'tconstruct:lumberaxe',
    'tconstruct:scythe',
  ],
  ['tconstruct:battlesign'],
] as string[][];

// How much materials required for each tool or armour
static matsRequired as int[string] = {} as int[string];
function addMatRequirment(item as IItemStack) as void {
  if (!item.hasTag) return;
  val len = (item.tag?.TinkerData?.Materials ?? [] as IData).length;
  if (len <= 0) return;
  matsRequired[item.definition.id] = len;
}
function getMatsRequired(matName as string) as int {
  if (isNull(matsRequired.__initialized)) {
    for modName in ['tconstruct', 'conarm', 'tconevo'] as string[] {
      val mod = loadedMods[modName];
      if (isNull(mod)) continue;
      for item in mod.items { addMatRequirment(item); }
    }
    matsRequired['__initialized'] = 1;
  }
  val len = matsRequired[matName];
  return isNull(len) ? 0 : len as int;
}

// ######################################################################
//
// Modifier power "points" (Warhammer-style army budget, see modifierGen.zs)
//
// ######################################################################
// Cost of a single modifier in abstract power points. The random generator
// spends a difficulty-scaled budget on these, so expensive modifiers are
// reachable only at high difficulty and the single most expensive one only at
// difficulty 1.0. Any modifier NOT listed here defaults to DEFAULT_MOD_POINTS
// (100) — that includes brand-new modifiers from freshly added mods.
//
// Keys are the *registered* identifiers (armor traits keep their `_armor`
// suffix). Run `/grant_random_armor dump` to log every live modifier together
// with its effective point value, then curate the values here.
static DEFAULT_MOD_POINTS as int = 100;

static modifierPoints as int[string] = {
  'sticky_armor'                          : 40,
  'shulkerweight_armor'                   : 45,
  'amphibious_armor'                      : 60,
  'apprentice_armor'                      : 60,
  'haste'                                 : 60,
  'blast_resistant_armor'                 : 70,
  'emerald'                               : 70,
  'global_traveler'                       : 70,
  'projectile_resistant_armor'            : 70,
  'diamond'                               : 75,
  'antimagic_armor'                       : 80,
  'night_vision_armor'                    : 90,
  'glowing_armor'                         : 100,
  'reinforced_armor'                      : 120,
  'reinforced'                            : 120,
  'diamond_armor'                         : 150,
  'frostwalker_armor'                     : 150,
  'tconevo.chain_lightning'               : 150,
  'emerald_armor'                         : 160,
  'highstride_armor'                      : 160,
  'soulbound_armor'                       : 180,
  'soulbound'                             : 180,
  'dexterous_armor'                       : 200,
  'incognito'                             : 200,
  'sturdy'                                : 200,
  'sharp'                                 : 220,
  'sharpness'                             : 220,
  'lacerating'                            : 240,
  'self_fix_armor'                        : 240,
  'darkside_armor'                        : 260,
  'mending_armor'                         : 260,
  'travel_goggles_armor'                  : 260,
  'parasitic_armor'                       : 280,
  'telekinetic_armor'                     : 280,
  'potion_belt_armor'                     : 300,
  'powerful'                              : 300,
  'powerful_armor'                        : 320,
  'travel_belt_armor'                     : 320,
  'travel_sack_armor'                     : 350,
  'concealed_armor'                       : 400,
  'tconevo.photovoltaic_armor'            : 520,
  'tconevo.photovoltaic'                  : 520,
  'tconevo.fluxed_armor'                  : 600,
  'tconevo.fluxed'                        : 600,
  'tconevo.draconic_jump_boost_armor'     : 700,
  'tconevo.energized'                     : 700,
  'tconevo.megaflip_armor'                : 700,
  'tconevo.stifling_armor'                : 850,
  'tconevo.chilling_touch_armor'          : 900,
  'tconevo.draconic_move_speed_armor'     : 900,
  'tconevo.reactive_armor'                : 900,
  'tconevo.gale_force_armor'              : 950,
  'tconevo.hearth_embrace_armor'          : 1000,
  'tconevo.radiant_armor'                 : 1100,
  'tconevo.bulwark_armor'                 : 1200,
  'tconevo.will_strength_armor'           : 1200,
  'tconevo.shadowstep_armor'              : 1300,
  'tconevo.second_wind_armor'             : 1400,
  'tconevo.spectral_armor'                : 1500,
  'tconevo.true_strike'                   : 1500,
  'tconevo.vampiric'                      : 1600,
  'tconevo.bloodbound'                    : 1800,
  'tconevo.draconic_energy_armor'         : 1800,
  'tconevo.phoenix_aspect_armor'          : 1800,
  'tconevo.mortal_wounds'                 : 2000,
  'tconevo.sentient'                      : 2000,
  'tconevo.celestial_armor'               : 2200,
  'tconevo.crystalys'                     : 2200,
  'tconevo.draconic_shield_capacity_armor': 2200,
  'tconevo.relentless'                    : 2200,
  'tconevo.overwhelm'                     : 2400,
  'tconevo.thundergod_favour_armor'       : 2400,
  'tconevo.divine_grace_armor'            : 2600,
  'tconevo.executor'                      : 2600,
  'tconevo.chaos_resistance_armor'        : 3000,
  'tconevo.ruination'                     : 3200,
  'tconevo.culling'                       : 3600,
  'tconevo.weightless_armor'              : 4000,
  'tconevo.final_guard_armor'             : 4200,
  'tconevo.condensing'                    : 8000,
  'tconevo.eternity_armor'                : 16000,
  'tconevo.eternity'                      : 16000,
  'tconevo.omnipotence'                   : 20000,
  'tconevo.infinitum_armor'               : 50000,
  'tconevo.infinitum'                     : 50000,
  'tconevo.null_almighty_armor'           : 50000,
  'tconevo.null_almighty'                 : 50000,
} as int[string];

function getModifierPoints(id as string) as int {
  val p = modifierPoints[id];
  return isNull(p) ? DEFAULT_MOD_POINTS : p as int;
}

// ######################################################################
//
// Inventory loot — items rolled into backpack/belt accessories (modifierGen.zs)
//
// ######################################################################
// Ordered common -> rare. A difficulty-weighted index picks from the front of
// the list at low difficulty and reaches the rare tail near difficulty 1.0.
static inventoryLoot as IItemStack[] = [
  <minecraft:rotten_flesh>,
  <minecraft:bone>,
  <minecraft:arrow>,
  <minecraft:string>,
  <minecraft:coal>,
  <minecraft:bread>,
  <minecraft:iron_ingot>,
  <minecraft:cooked_beef>,
  <minecraft:redstone>,
  <minecraft:gunpowder>,
  <minecraft:ender_pearl>,
  <minecraft:gold_ingot>,
  <minecraft:glowstone_dust>,
  <minecraft:blaze_powder>,
  <minecraft:emerald>,
  <minecraft:diamond>,
  <minecraft:golden_carrot>,
  <minecraft:experience_bottle>,
  <minecraft:golden_apple>,
  <minecraft:ghast_tear>,
  <minecraft:golden_apple:1>,
  <minecraft:nether_star>,
] as IItemStack[];

// Potions rolled into the "potion belt" accessory (key "potions"). Ordered
// common -> strong, picked by the same difficulty-weighted index.
static potionLoot as IItemStack[] = [
  <minecraft:potion>.withTag({ Potion: 'minecraft:swiftness' }),
  <minecraft:potion>.withTag({ Potion: 'minecraft:healing' }),
  <minecraft:potion>.withTag({ Potion: 'minecraft:fire_resistance' }),
  <minecraft:potion>.withTag({ Potion: 'minecraft:strength' }),
  <minecraft:potion>.withTag({ Potion: 'minecraft:leaping' }),
  <minecraft:potion>.withTag({ Potion: 'minecraft:regeneration' }),
  <minecraft:potion>.withTag({ Potion: 'minecraft:strong_healing' }),
  <minecraft:potion>.withTag({ Potion: 'minecraft:strong_strength' }),
  <minecraft:potion>.withTag({ Potion: 'minecraft:strong_regeneration' }),
] as IItemStack[];
