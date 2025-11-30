#priority 1
#modloaded loottweaker
#ignoreBracketErrors

import crafttweaker.item.IItemStack;

///////////////////////////
// Item related loottables//
///////////////////////////

static baubles as int[][IItemStack] = { // Total weight = 365
  <cyclicmagic:charm_antidote>                               : [5, 0, 1, 1],
  <cyclicmagic:charm_water>                                  : [5, 0, 1, 1],
  <cyclicmagic:charm_air>                                    : [5, 0, 1, 1],
  <cyclicmagic:charm_void>                                   : [5, 0, 1, 1],
  <cyclicmagic:charm_boat>                                   : [5, 0, 1, 1],
  <cyclicmagic:charm_fire>                                   : [5, 0, 1, 1],
  <cyclicmagic:charm_speed>                                  : [5, 0, 1, 1],
  <cyclicmagic:charm_wing>                                   : [5, 0, 1, 1],
  <thaumictinkerer:cat_amulet>                               : [10, 0, 1, 1],
  <twilightforest:charm_of_keeping_1>                        : [40, 0, 1, 1],
  <twilightforest:charm_of_keeping_2>                        : [20, 0, 1, 1],
  <twilightforest:charm_of_keeping_3>                        : [10, 0, 1, 1],
  <twilightforest:charm_of_life_1>                           : [20, 0, 1, 1],
  <twilightforest:charm_of_life_2>                           : [10, 0, 1, 1],
  <thaumadditions:traveller_belt>                            : [10, 0, 1, 1],
  <randomthings:lavacharm>.withTag({charge: 200})            : [10, 0, 1, 1],
  <psicosts:psi_cell:1>.withTag({PsioCharge: 240000})        : [10, 0, 1, 1],
  <darkutils:charm_agression>                                : [10, 0, 1, 1],
  <botania:lavapendant>                                      : [10, 0, 1, 1],
  <botania:itemfinder>                                       : [10, 0, 1, 1],
  <botania:travelbelt>                                       : [10, 0, 1, 1],
  <thaumcraft:baubles:3>                                     : [10, 0, 1, 1],
  <thaumcraft:cloud_ring>                                    : [10, 0, 1, 1],
  <mia:kobold_ring>                                          : [10, 0, 1, 1],
  <randomthings:obsidianskullring>                           : [10, 0, 1, 1],
  <darkutils:charm_gluttony>                                 : [10, 0, 1, 1],
  <darkutils:charm_portal>                                   : [10, 0, 1, 1],
  <botania:bloodpendant>.withTag({brewKey: 'fireResistance'}): [10, 0, 1, 1],
  <botania:cloudpendant>                                     : [10, 0, 1, 1],
  <botania:icependant>                                       : [10, 0, 1, 1],
  <thaumictinkerer:experience_charm>.withTag({})             : [10, 0, 1, 1],
  <thaumcraft:verdant_charm>                                 : [5, 0, 1, 1],
  <thaumcraft:verdant_charm>.withTag({type: 1 as byte})      : [5, 0, 1, 1],
  <thaumcraft:verdant_charm>.withTag({type: 2 as byte})      : [5, 0, 1, 1],
  <darkutils:charm_sleep>                                    : [10, 0, 1, 1],
  <darkutils:focus_sash>                                     : [10, 0, 1, 1],
};

static thaumcraftSpells as int[][IItemStack] = { // Total weight = 90

  <thaumcraft:focus_1>.withTag({package: {complexity: 12, nodes: [{type: 'MEDIUM', key: 'ROOT'}, {type: 'MEDIUM', key: 'thaumcraft.SPELLBAT', 'setting.target': 1}, {'setting.power': 1, type: 'EFFECT', key: 'thaumcraft.HEAL'}], index: 0, power: 1.0 as float}, display: {Name: 'Ottabugnirih'}}) : [3, 0, 1, 1],
  <thaumcraft:focus_1>.withTag({package: {complexity: 14, nodes: [{type: 'MEDIUM', key: 'ROOT'}, {type: 'MEDIUM', key: 'thaumcraft.BOLT'}, {'setting.power': 3, type: 'EFFECT', key: 'focus.thaumicaugmentation.water'}], index: 0, power: 1.0 as float}, display: {Name: 'Uhssaru\'Pusakua'}}) : [3, 0, 1, 1],
  <thaumcraft:focus_1>.withTag({package: {complexity: 14, nodes: [{type: 'MEDIUM', key: 'ROOT'}, {type: 'MEDIUM', key: 'thaumcraft.BOLT'}, {'setting.power': 3, type: 'EFFECT', key: 'thaumcraft.EARTH'}], index: 0, power: 1.0 as float}, display: {Name: 'Nesok U\'ykihc'}}) : [3, 0, 1, 1],
  <thaumcraft:focus_1>.withTag({package: {complexity: 14, nodes: [{type: 'MEDIUM', key: 'ROOT'}, {type: 'MEDIUM', key: 'thaumcraft.PROJECTILE', 'setting.speed': 5, 'setting.option': 0}, {'setting.type': 1, 'setting.duration': 2, 'setting.power': 4, type: 'EFFECT', key: 'mia.focus.size_change'}], index: 0, power: 1.0 as float}, display: {Name: 'Urob Anasi\'h'}}): [3, 0, 1, 1],
  <thaumcraft:focus_1>.withTag({package: {complexity: 15, nodes: [{type: 'MEDIUM', key: 'ROOT'}, {type: 'MEDIUM', key: 'thaumcraft.BOLT'}, {'setting.duration': 2, 'setting.power': 4, type: 'EFFECT', key: 'thaumcraft.FIRE'}], index: 0, power: 1.0 as float}, display: {Name: 'Nesok On\'ih'}}) : [3, 0, 1, 1],
  <thaumcraft:focus_1>.withTag({package: {complexity: 15, nodes: [{type: 'MEDIUM', key: 'ROOT'}, {type: 'MEDIUM', key: 'thaumcraft.BOLT'}, {'setting.power': 5, type: 'EFFECT', key: 'thaumcraft.AIR'}], index: 0, power: 1.0 as float}, display: {Name: 'Ukabuk'}}) : [3, 0, 1, 1],
  <thaumcraft:focus_1>.withTag({package: {complexity: 15, nodes: [{type: 'MEDIUM', key: 'ROOT'}, {type: 'MEDIUM', key: 'thaumcraft.PROJECTILE', 'setting.speed': 2, 'setting.option': 2}, {'setting.power': 3, type: 'EFFECT', key: 'thaumcraft.AIR'}], index: 0, power: 1.0 as float}, display: {Name: 'Akihsae'}}) : [3, 0, 1, 1],
  <thaumcraft:focus_1>.withTag({package: {complexity: 15, nodes: [{type: 'MEDIUM', key: 'ROOT'}, {type: 'MEDIUM', key: 'thaumcraft.SPELLBAT', 'setting.target': 0}, {'setting.duration': 1, 'setting.power': 3, type: 'EFFECT', key: 'thaumcraft.FIRE'}], index: 0, power: 1.0 as float}, display: {Name: 'Ottabureh'}}) : [3, 0, 1, 1],
  <thaumcraft:focus_1>.withTag({package: {complexity: 7, nodes: [{type: 'MEDIUM', key: 'ROOT'}, {type: 'MEDIUM', key: 'thaumcraft.TOUCH'}, {type: 'EFFECT', key: 'thaumictinkerer.efreetflame'}], index: 0, power: 1.0 as float}, srt: 1360312191, color: -7989202, display: {Name: 'Ugak\' O\' Awuuk'}}) : [3, 0, 1, 1],
  <thaumcraft:focus_1>.withTag({package: {complexity: 9, nodes: [{type: 'MEDIUM', key: 'ROOT'}, {'setting.method': 0, type: 'MEDIUM', key: 'thaumcraft.PLAN'}, {type: 'EFFECT', key: 'thaumictinkerer.efreetflame'}], index: 0, power: 1.0 as float}, display: {Name: 'Iake\'s O\' Uugak'}}) : [3, 0, 1, 1],

  <thaumcraft:focus_2>.withTag({package: {complexity: 20, nodes: [{type: 'MEDIUM', key: 'ROOT'}, {type: 'EFFECT', key: 'thaumictinkerer.enderrift'}], index: 0, power: 1.0 as float}, srt: 1307043816, color: -13943489, display: {Name: 'Otuseh\'Adne'}}) : [3, 0, 1, 1],
  <thaumcraft:focus_2>.withTag({package: {complexity: 20, nodes: [{type: 'MEDIUM', key: 'ROOT'}, {type: 'MEDIUM', key: 'thaumcraft.BOLT'}, {'setting.intensity': 15, type: 'EFFECT', key: 'focus.thaumicaugmentation.light'}], index: 0, power: 1.0 as float}, display: {Name: 'Ra\'ito boru\'t'}}) : [3, 0, 1, 1],
  <thaumcraft:focus_2>.withTag({package: {complexity: 22, nodes: [{type: 'MEDIUM', key: 'ROOT'}, {type: 'MEDIUM', key: 'thaumcraft.TOUCH'}, {type: 'EFFECT', key: 'thaumictinkerer.dislocation'}], index: 0, power: 1.0 as float}, display: {Name: 'Yo\'ink'}}) : [3, 0, 1, 1],
  <thaumcraft:focus_2>.withTag({package: {complexity: 23, nodes: [{type: 'MEDIUM', key: 'ROOT'}, {'setting.type': 0, 'setting.duration': 7, 'setting.power': 4, type: 'EFFECT', key: 'mia.focus.size_change'}], index: 0, power: 1.0 as float}, display: {Name: 'Ioron Nijoyk'}}) : [3, 0, 1, 1],
  <thaumcraft:focus_2>.withTag({package: {complexity: 24, nodes: [{type: 'MEDIUM', key: 'ROOT'}, {'setting.cone': 10, type: 'MOD', 'setting.forks': 2, key: 'thaumcraft.SCATTER'}, {type: 'MEDIUM', key: 'thaumcraft.PROJECTILE', 'setting.speed': 5, 'setting.option': 0}, {'setting.power': 5, type: 'EFFECT', key: 'thaumcraft.EARTH'}], index: 0, power: 1.0 as float}, display: {Name: 'Nad\'Ujin'}}) : [3, 0, 1, 1],
  <thaumcraft:focus_2>.withTag({package: {complexity: 24, nodes: [{type: 'MEDIUM', key: 'ROOT'}, {'setting.cone': 10, type: 'MOD', 'setting.forks': 3, key: 'thaumcraft.SCATTER'}, {type: 'MEDIUM', key: 'thaumcraft.PROJECTILE', 'setting.speed': 3, 'setting.option': 1}, {'setting.power': 4, type: 'EFFECT', key: 'focus.thaumicaugmentation.water'}], index: 0, power: 1.0 as float}, display: {Name: 'Urob\'ato-U'}}) : [3, 0, 1, 1],
  <thaumcraft:focus_2>.withTag({package: {complexity: 24, nodes: [{type: 'MEDIUM', key: 'ROOT'}, {type: 'MEDIUM', key: 'thaumcraft.MINE', 'setting.target': 1}, {type: 'EFFECT', key: 'thaumictinkerer.enderrift'}], index: 0, power: 1.0 as float}, srt: 522772029, display: {Name: 'Upparoto Tuseh\'Adne'}}) : [3, 0, 1, 1],
  <thaumcraft:focus_2>.withTag({package: {complexity: 25, nodes: [{type: 'MEDIUM', key: 'ROOT'}, {'setting.cone': 10, type: 'MOD', 'setting.forks': 2, key: 'thaumcraft.SCATTER'}, {type: 'MOD', packages: {packages: [{complexity: 0, nodes: [{type: 'MEDIUM', key: 'thaumcraft.BOLT'}, {'setting.power': 1, type: 'EFFECT', key: 'thaumcraft.FLUX'}], index: 0, power: 1.0 as float}, {complexity: 0, nodes: [{type: 'MEDIUM', key: 'thaumcraft.PROJECTILE', 'setting.speed': 5, 'setting.option': 0}, {'setting.duration': 1, 'setting.power': 1, type: 'EFFECT', key: 'thaumcraft.FIRE'}], index: 0, power: 1.0 as float}]}, key: 'thaumcraft.SPLITTRAJECTORY'}], index: 0, power: 1.0 as float}, srt: -420892238, display: {Name: 'Otusaykurauy\'De'}}): [3, 0, 1, 1],
  <thaumcraft:focus_2>.withTag({package: {complexity: 25, nodes: [{type: 'MEDIUM', key: 'ROOT'}, {'setting.cone': 10, type: 'MOD', 'setting.forks': 3, key: 'thaumcraft.SCATTER'}, {type: 'MEDIUM', key: 'thaumcraft.BOLT'}, {'setting.power': 5, type: 'EFFECT', key: 'thaumcraft.FLUX'}], index: 0, power: 1.0 as float}, display: {Name: 'Az\'Er\'rurpuirot'}}) : [3, 0, 1, 1],
  <thaumcraft:focus_2>.withTag({package: {complexity: 25, nodes: [{type: 'MEDIUM', key: 'ROOT'}, {type: 'MEDIUM', key: 'thaumcraft.MINE', 'setting.target': 0}, {'setting.cone': 360, type: 'MOD', 'setting.forks': 10, key: 'thaumcraft.SCATTER'}, {type: 'MEDIUM', key: 'thaumcraft.PROJECTILE', 'setting.speed': 4, 'setting.option': 0}, {'setting.duration': 10, 'setting.power': 1, type: 'EFFECT', key: 'thaumcraft.FROST'}], index: 0, power: 1.0 as float}, srt: -1291221152, color: -1966081, display: {Name: 'Naz\'k Irok'}}) : [3, 0, 1, 1],
  <thaumcraft:focus_2>.withTag({package: {complexity: 25, nodes: [{type: 'MEDIUM', key: 'ROOT'}, {type: 'MEDIUM', key: 'thaumcraft.MINE', 'setting.target': 0}, {'setting.radius': 3, 'setting.duration': 9, type: 'MEDIUM', key: 'thaumcraft.CLOUD'}, {'setting.duration': 0, 'setting.power': 5, type: 'EFFECT', key: 'thaumcraft.FIRE'}], index: 0, power: 1.0 as float}, display: {Name: 'Uppa\'Rotnogarod'}}) : [3, 0, 1, 1],

  <thaumicaugmentation:focus_ancient>.withTag({package: {complexity: 27, nodes: [{type: 'MEDIUM', key: 'ROOT'}, {'setting.method': 0, type: 'MEDIUM', key: 'thaumcraft.PLAN'}, {type: 'EFFECT', key: 'focus.thaumicaugmentation.ward'}], index: 0, power: 1.0 as float}, display: {Name: 'Anustijnek'}}) : [3, 0, 1, 1],
  <thaumicaugmentation:focus_ancient>.withTag({package: {complexity: 34, nodes: [{type: 'MEDIUM', key: 'ROOT'}, {type: 'MEDIUM', key: 'thaumcraft.BOLT'}, {'setting.type': 1, 'setting.duration': 9, 'setting.power': 4, type: 'EFFECT', key: 'mia.focus.size_change'}], index: 0, power: 1.0 as float}, srt: 859716589, display: {Name: 'Urus Ohsukuhs \'O Iket'}}) : [3, 0, 1, 1],
  <thaumicaugmentation:focus_ancient>.withTag({package: {complexity: 35, nodes: [{type: 'MEDIUM', key: 'ROOT'}, {'setting.cone': 360, type: 'MOD', 'setting.forks': 10, key: 'thaumcraft.SCATTER'}, {type: 'MEDIUM', key: 'thaumcraft.MINE', 'setting.target': 1}, {'setting.radius': 1, 'setting.duration': 9, type: 'MEDIUM', key: 'thaumcraft.CLOUD'}, {'setting.power': 5, type: 'EFFECT', key: 'thaumcraft.HEAL'}], index: 0, power: 1.0 as float}, srt: -2092331808, display: {Name: 'Uratusirukugnir\'h'}}) : [3, 0, 1, 1],
  <thaumicaugmentation:focus_ancient>.withTag({package: {complexity: 35, nodes: [{type: 'MEDIUM', key: 'ROOT'}, {'setting.cone': 360, type: 'MOD', 'setting.forks': 10, key: 'thaumcraft.SCATTER'}, {type: 'MOD', packages: {packages: [{complexity: 0, nodes: [{type: 'MEDIUM', key: 'thaumcraft.PROJECTILE', 'setting.speed': 1, 'setting.option': 1}, {'setting.duration': 2, 'setting.power': 2, type: 'EFFECT', key: 'thaumcraft.FROST'}], index: 0, power: 1.0 as float}, {complexity: 0, nodes: [{type: 'MEDIUM', key: 'thaumcraft.PROJECTILE', 'setting.speed': 1, 'setting.option': 1}, {'setting.duration': 1, 'setting.power': 1, type: 'EFFECT', key: 'thaumcraft.FIRE'}], index: 0, power: 1.0 as float}]}, key: 'thaumcraft.SPLITTRAJECTORY'}], index: 0, power: 1.0 as float}, display: {Name: 'I\'banah'}}): [3, 0, 1, 1],
  <thaumicaugmentation:focus_ancient>.withTag({package: {complexity: 35, nodes: [{type: 'MEDIUM', key: 'ROOT'}, {'setting.cone': 360, type: 'MOD', 'setting.forks': 6, key: 'thaumcraft.SCATTER'}, {type: 'MEDIUM', key: 'thaumcraft.SPELLBAT', 'setting.target': 0}, {type: 'MOD', packages: {packages: [{complexity: 0, nodes: [{'setting.duration': 2, 'setting.power': 5, type: 'EFFECT', key: 'thaumcraft.FROST'}], index: 0, power: 1.0 as float}, {complexity: 0, nodes: [{'setting.duration': 3, 'setting.power': 2, type: 'EFFECT', key: 'thaumcraft.CURSE'}], index: 0, power: 1.0 as float}]}, key: 'thaumcraft.SPLITTARGET'}], index: 0, power: 1.0 as float}, color: -5931134, display: {Name: 'Erum Onirom\'k'}}) : [3, 0, 1, 1],
  <thaumicaugmentation:focus_ancient>.withTag({package: {complexity: 35, nodes: [{type: 'MEDIUM', key: 'ROOT'}, {'setting.cone': 90, type: 'MOD', 'setting.forks': 10, key: 'thaumcraft.SCATTER'}, {type: 'MEDIUM', key: 'thaumcraft.PROJECTILE', 'setting.speed': 1, 'setting.option': 0}, {'setting.silk': 0, 'setting.power': 5, type: 'EFFECT', key: 'thaumcraft.BREAK', 'setting.fortune': 0}], index: 0, power: 1.0 as float}, srt: -1861774959, display: {Name: 'Ake\'rubusehc'}}) : [3, 0, 1, 1],

  <thaumcraft:focus_3>.withTag({package: {complexity: 43, nodes: [{type: 'MEDIUM', key: 'ROOT'}, {'setting.cone': 10, type: 'MOD', 'setting.forks': 10, key: 'thaumcraft.SCATTER'}, {type: 'MEDIUM', key: 'thaumcraft.PROJECTILE', 'setting.speed': 5, 'setting.option': 1}, {'setting.power': 5, type: 'EFFECT', key: 'thaumcraft.EARTH'}], index: 0, power: 1.0 as float}, srt: 882108625, color: -11091968, display: {Name: 'Blank Greater Focus'}}) : [3, 0, 1, 1],
  <thaumcraft:focus_3>.withTag({package: {complexity: 49, nodes: [{type: 'MEDIUM', key: 'ROOT'}, {'setting.cone': 60, type: 'MOD', 'setting.forks': 5, key: 'thaumcraft.SCATTER'}, {type: 'MOD', packages: {packages: [{complexity: 0, nodes: [{type: 'MEDIUM', key: 'thaumcraft.PROJECTILE', 'setting.speed': 4, 'setting.option': 0}, {'setting.power': 5, type: 'EFFECT', key: 'thaumcraft.AIR'}], index: 0, power: 1.0 as float}, {complexity: 0, nodes: [{type: 'MEDIUM', key: 'thaumcraft.PROJECTILE', 'setting.speed': 4, 'setting.option': 0}, {'setting.power': 5, type: 'EFFECT', key: 'thaumcraft.EARTH'}], index: 0, power: 1.0 as float}]}, key: 'thaumcraft.SPLITTRAJECTORY'}], index: 0, power: 1.0 as float}, srt: 384730128, display: {Name: 'Osoy Ujin'}}): [3, 0, 1, 1],
  <thaumcraft:focus_3>.withTag({package: {complexity: 50, nodes: [{type: 'MEDIUM', key: 'ROOT'}, {type: 'MEDIUM', key: 'thaumcraft.BOLT'}, {'setting.radius': 3, 'setting.duration': 19, type: 'MEDIUM', key: 'thaumcraft.CLOUD'}, {type: 'MOD', packages: {packages: [{complexity: 0, nodes: [{'setting.duration': 3, 'setting.power': 5, type: 'EFFECT', key: 'thaumcraft.FROST'}], index: 0, power: 1.0 as float}, {complexity: 0, nodes: [{'setting.power': 5, type: 'EFFECT', key: 'thaumcraft.FLUX'}], index: 0, power: 1.0 as float}]}, key: 'thaumcraft.SPLITTARGET'}], index: 0, power: 1.0 as float}, srt: -759788293, color: -5210177, display: {Name: 'Iki Aniket\'Iemihc '}}) : [3, 0, 1, 1],
};

static psiSpells as int[][IItemStack] = { // Total weight = 80
  <psi:spell_bullet:1>.withTag({spell: {spellName: 'Silk Touch', uuidMost: 7040784541673081416 as long, validSpell: 1 as byte, spellList: [{data: {params: {_target: 2}, key: 'operatorEntityPosition'}, x: 2, y: 2}, {data: {key: 'selectorFocalPoint'}, x: 2, y: 3}, {data: {params: {_target: 1}, key: 'operatorEntityPosition'}, x: 2, y: 4}, {data: {key: 'constantNumber', constantValue: '3'}, x: 2, y: 5}, {data: {key: 'constantNumber', constantValue: '20'}, x: 2, y: 6}, {data: {params: {_ray: 2, _max: 0, _position: 3}, key: 'operatorVectorRaycast'}, x: 3, y: 2}, {data: {params: {_target: 3}, key: 'operatorEntityLook'}, x: 3, y: 3}, {data: {params: {_ray: 1, _max: 0, _position: 3}, key: 'operatorVectorRaycastAxis'}, x: 3, y: 4}, {data: {params: {_time: 3}, key: 'trickDelay'}, x: 3, y: 5}, {data: {params: {_time: 3, _position: 4}, key: 'trickConjureLight'}, x: 3, y: 6}, {data: {params: {_target: 3}, key: 'connector'}, x: 4, y: 2}, {data: {params: {_target: 2, _position: 1}, key: 'trickMoveBlock'}, x: 4, y: 3}, {data: {params: {_target: 3}, key: 'connector'}, x: 4, y: 4}, {data: {params: {_target: 4}, key: 'connector'}, x: 4, y: 5}, {data: {params: {_vector3: 0, _vector2: 4, _vector1: 1}, key: 'operatorVectorSubtract'}, x: 4, y: 6}, {data: {params: {_target: 3}, key: 'connector'}, x: 5, y: 2}, {data: {params: {_target: 1}, key: 'connector'}, x: 5, y: 3}, {data: {params: {_vector3: 0, _vector2: 3, _vector1: 1}, key: 'operatorVectorSum'}, x: 5, y: 4}, {data: {params: {_ray: 4, _max: 0, _position: 1}, key: 'operatorVectorRaycast'}, x: 5, y: 5}, {data: {params: {_x: 0, _y: 4, _z: 0}, key: 'operatorVectorConstruct'}, x: 5, y: 6}, {data: {key: 'errorSuppressor'}, x: 6, y: 2}, {data: {params: {_position: 2}, key: 'trickCollapseBlock'}, x: 6, y: 3}, {data: {params: {_target: 3}, key: 'connector'}, x: 6, y: 4}, {data: {params: {_x: 0, _y: 2, _z: 0}, key: 'operatorVectorConstruct'}, x: 6, y: 5}, {data: {key: 'constantNumber', constantValue: '-1'}, x: 6, y: 6}], uuidLeast: -6686968270980647932 as long}}) : [10, 0, 1, 1],
  <psi:spell_bullet:3>.withTag({spell: {spellName: 'Forced jump', uuidMost: 7986986100593740141 as long, validSpell: 1 as byte, spellList: [{data: {params: {_target: 4}, key: 'operatorEntityPosition'}, x: 3, y: 3}, {data: {params: {_position: 1, _radius: 2}, key: 'selectorNearbyLiving'}, x: 3, y: 4}, {data: {key: 'constantNumber', constantValue: '20'}, x: 3, y: 5}, {data: {params: {_target: 4}, key: 'connector'}, x: 4, y: 3}, {data: {params: {_direction: 4, _speed: 2, _target: 3}, key: 'trickMassAddMotion'}, x: 4, y: 4}, {data: {key: 'constantNumber', constantValue: '3'}, x: 4, y: 5}, {data: {key: 'selectorAttackTarget'}, x: 5, y: 3}, {data: {params: {_target: 2}, key: 'connector'}, x: 5, y: 4}, {data: {params: {_x: 0, _y: 3, _z: 0}, key: 'operatorVectorConstruct'}, x: 5, y: 5}], uuidLeast: -7893745099119970887 as long}}) : [10, 0, 1, 1],
  <psi:spell_bullet:1>.withTag({spell: {spellName: 'Reflect', uuidMost: -2096726258991349084 as long, validSpell: 1 as byte, spellList: [{data: {params: {_x: 0, _y: 2, _z: 0}, key: 'operatorVectorConstruct'}, x: 2, y: 3}, {data: {key: 'constantNumber', constantValue: '1'}, x: 2, y: 4}, {data: {params: {_direction: 3, _speed: 4, _target: 2}, key: 'trickMassAddMotion'}, x: 3, y: 3}, {data: {params: {_position: 4, _radius: 2}, key: 'selectorNearbyProjectiles'}, x: 3, y: 4}, {data: {key: 'constantNumber', constantValue: '50'}, x: 3, y: 5}, {data: {key: 'constantNumber', constantValue: '0.2'}, x: 4, y: 3}, {data: {params: {_target: 2}, key: 'operatorEntityPosition'}, x: 4, y: 4}, {data: {key: 'selectorCaster'}, x: 4, y: 5}], uuidLeast: -6990323508199400942 as long}, display: {Lore: ['This is a psimetal leggins spell']}}) : [10, 0, 1, 1],
  <psi:spell_bullet:3>.withTag({spell: {spellName: 'Explosion!', uuidMost: -7279129427525680489 as long, validSpell: 1 as byte, spellList: [{data: {key: 'constantNumber', constantValue: '2'}, x: 2, y: 2}, {data: {key: 'constantNumber', constantValue: '1'}, x: 2, y: 3}, {data: {params: {_position: 4}, key: 'trickTorrent'}, x: 2, y: 4}, {data: {params: {_time: 2, _position: 4}, key: 'trickConjureBlock'}, x: 2, y: 5}, {data: {key: 'constantNumber', constantValue: '1'}, x: 2, y: 6}, {data: {params: {_direction: 2, _speed: 3, _target: 4}, key: 'trickAddMotion'}, x: 3, y: 2}, {data: {params: {_x: 0, _y: 3, _z: 0}, key: 'operatorVectorConstruct'}, x: 3, y: 3}, {data: {params: {_vector3: 0, _vector2: 1, _vector1: 4}, key: 'operatorVectorSum'}, x: 3, y: 4}, {data: {params: {_vector3: 0, _vector2: 2, _vector1: 1}, key: 'operatorVectorSum'}, x: 3, y: 5}, {data: {params: {_x: 0, _y: 4, _z: 0}, key: 'operatorVectorConstruct'}, x: 3, y: 6}, {data: {params: {_target: 4}, key: 'operatorFocusedEntity'}, x: 4, y: 2}, {data: {params: {_target: 1}, key: 'operatorEntityPosition'}, x: 4, y: 3}, {data: {params: {_target: 1}, key: 'connector'}, x: 4, y: 4}, {data: {params: {_target: 1}, key: 'connector'}, x: 4, y: 5}, {data: {key: 'constantNumber', constantValue: '3'}, x: 4, y: 6}, {data: {key: 'selectorCaster'}, x: 5, y: 2}, {data: {key: 'constantNumber', constantValue: '1.43'}, x: 5, y: 3}, {data: {params: {_power: 1, _position: 3}, key: 'trickExplode'}, x: 5, y: 4}, {data: {params: {_time: 2, _position: 3}, key: 'trickConjureBlock'}, x: 5, y: 5}, {data: {key: 'constantNumber', constantValue: '1'}, x: 5, y: 6}, {data: {key: 'errorSuppressor'}, x: 6, y: 0}, {data: {params: {_time: 2}, key: 'trickDelay'}, x: 6, y: 2}, {data: {key: 'constantNumber', constantValue: '3'}, x: 6, y: 3}], uuidLeast: -4813307202214668862 as long}}) : [10, 0, 1, 1],
  <psi:spell_bullet:1>.withTag({spell: {spellName: 'Psi Bridge', uuidMost: 2417157461429604239 as long, validSpell: 1 as byte, spellList: [{data: {params: {_target: 4}, key: 'connector'}, x: 0, y: 0}, {data: {params: {_target: 1}, key: 'connector'}, x: 0, y: 1}, {data: {params: {_target: 1}, key: 'operatorEntityLook'}, x: 0, y: 2}, {data: {key: 'selectorCaster'}, x: 1, y: 0}, {data: {params: {_target: 1}, key: 'operatorEntityPosition'}, x: 1, y: 1}, {data: {params: {_number2: 2, _vector1: 3}, key: 'operatorVectorMultiply'}, x: 1, y: 2}, {data: {key: 'constantNumber', constantValue: '99999'}, x: 1, y: 3}, {data: {params: {_x: 0, _y: 4, _z: 0}, key: 'operatorVectorConstruct'}, x: 2, y: 0}, {data: {params: {_vector3: 0, _vector2: 1, _vector1: 3}, key: 'operatorVectorSubtract'}, x: 2, y: 1}, {data: {params: {_max: 2, _time: 4, _target: 3, _position: 1}, key: 'trickConjureBlockSequence'}, x: 2, y: 2}, {data: {key: 'constantNumber', constantValue: '16'}, x: 2, y: 3}, {data: {key: 'constantNumber', constantValue: '2'}, x: 3, y: 0}, {data: {key: 'constantNumber', constantValue: '300'}, x: 3, y: 2}], uuidLeast: -6549739740077054252 as long}}) : [10, 0, 1, 1],
  <psi:spell_bullet:3>.withTag({spell: {spellName: 'Conjure Light', uuidMost: -2582049172205056036 as long, validSpell: 1 as byte, spellList: [{data: {params: {_target: 2}, key: 'operatorEntityLook'}, x: 2, y: 2}, {data: {key: 'selectorCaster'}, x: 2, y: 3}, {data: {params: {_target: 1}, key: 'operatorEntityLook'}, x: 2, y: 4}, {data: {params: {_ray: 3, _max: 0, _position: 2}, key: 'operatorVectorRaycast'}, x: 3, y: 2}, {data: {params: {_target: 3}, key: 'operatorEntityPosition'}, x: 3, y: 3}, {data: {params: {_ray: 3, _max: 0, _position: 1}, key: 'operatorVectorRaycastAxis'}, x: 3, y: 4}, {data: {params: {_target: 3}, key: 'connector'}, x: 4, y: 2}, {data: {params: {_vector3: 0, _vector2: 1, _vector1: 2}, key: 'operatorVectorSum'}, x: 4, y: 3}, {data: {params: {_target: 3}, key: 'connector'}, x: 4, y: 4}, {data: {params: {_time: 0, _position: 3}, key: 'trickConjureLight'}, x: 5, y: 3}], uuidLeast: -9205327261615088199 as long}}) : [10, 0, 1, 1],
  <psi:spell_bullet:3>.withTag({spell: {spellName: 'Sanctuary Cage', uuidMost: 3981460506013683229 as long, validSpell: 1 as byte, spellList: [{data: {key: 'constantNumber', constantValue: '4'}, x: 0, y: 0}, {data: {params: {_target: 1}, key: 'connector'}, x: 0, y: 1}, {data: {key: 'constantNumber', constantValue: '1'}, x: 0, y: 3}, {data: {params: {_x: 1, _y: 0, _z: 0}, key: 'operatorVectorConstruct'}, x: 0, y: 4}, {data: {key: 'constantNumber', constantValue: '6000'}, x: 0, y: 5}, {data: {params: {_x: 0, _y: 3, _z: 0}, key: 'operatorVectorConstruct'}, x: 1, y: 0}, {data: {params: {_max: 3, _time: 0, _target: 1, _position: 4}, key: 'trickConjureBlockSequence'}, x: 1, y: 1}, {data: {params: {_target: 4}, key: 'connector'}, x: 1, y: 2}, {data: {params: {_target: 1}, key: 'connector'}, x: 1, y: 3}, {data: {params: {_vector3: 0, _vector2: 3, _vector1: 1}, key: 'operatorVectorSum'}, x: 1, y: 4}, {data: {params: {_max: 4, _time: 3, _target: 2, _position: 1}, key: 'trickConjureBlockSequence'}, x: 1, y: 5}, {data: {params: {_target: 4}, key: 'connector'}, x: 1, y: 6}, {data: {key: 'constantNumber', constantValue: '-2'}, x: 2, y: 0}, {data: {params: {_target: 4}, key: 'connector'}, x: 2, y: 1}, {data: {params: {_target: 4}, key: 'connector'}, x: 2, y: 2}, {data: {key: 'constantNumber', constantValue: '-1'}, x: 2, y: 3}, {data: {params: {_x: 1, _y: 0, _z: 0}, key: 'operatorVectorConstruct'}, x: 2, y: 4}, {data: {key: 'constantNumber', constantValue: '4'}, x: 2, y: 5}, {data: {params: {_target: 4}, key: 'connector'}, x: 2, y: 6}, {data: {params: {_x: 0, _y: 3, _z: 0}, key: 'operatorVectorConstruct'}, x: 3, y: 0}, {data: {params: {_vector3: 0, _vector2: 4, _vector1: 1}, key: 'operatorVectorSum'}, x: 3, y: 1}, {data: {params: {_target: 1}, key: 'connector'}, x: 3, y: 2}, {data: {params: {_target: 1}, key: 'connector'}, x: 3, y: 3}, {data: {params: {_vector3: 0, _vector2: 3, _vector1: 1}, key: 'operatorVectorSum'}, x: 3, y: 4}, {data: {params: {_max: 3, _time: 4, _target: 2, _position: 1}, key: 'trickConjureBlockSequence'}, x: 3, y: 5}, {data: {params: {_target: 4}, key: 'connector'}, x: 3, y: 6}, {data: {key: 'selectorAttackTarget'}, x: 4, y: 0}, {data: {params: {_target: 1}, key: 'operatorEntityPosition'}, x: 4, y: 1}, {data: {params: {_target: 3}, key: 'connector'}, x: 4, y: 2}, {data: {key: 'constantNumber', constantValue: '1'}, x: 4, y: 3}, {data: {params: {_x: 0, _y: 0, _z: 1}, key: 'operatorVectorConstruct'}, x: 4, y: 4}, {data: {key: 'constantNumber', constantValue: '6000'}, x: 4, y: 5}, {data: {params: {_x: 0, _y: 2, _z: 0}, key: 'operatorVectorConstruct'}, x: 4, y: 6}, {data: {key: 'constantNumber', constantValue: '4'}, x: 4, y: 7}, {data: {params: {_target: 3}, key: 'connector'}, x: 5, y: 2}, {data: {params: {_target: 1}, key: 'connector'}, x: 5, y: 3}, {data: {params: {_vector3: 0, _vector2: 3, _vector1: 1}, key: 'operatorVectorSum'}, x: 5, y: 4}, {data: {params: {_max: 4, _time: 3, _target: 2, _position: 1}, key: 'trickConjureBlockSequence'}, x: 5, y: 5}, {data: {params: {_target: 3}, key: 'connector'}, x: 5, y: 6}, {data: {params: {_target: 3}, key: 'connector'}, x: 6, y: 2}, {data: {key: 'constantNumber', constantValue: '-1'}, x: 6, y: 3}, {data: {params: {_x: 0, _y: 0, _z: 1}, key: 'operatorVectorConstruct'}, x: 6, y: 4}, {data: {key: 'constantNumber', constantValue: '4'}, x: 6, y: 5}, {data: {params: {_max: 1, _time: 2, _target: 3, _position: 4}, key: 'trickConjureBlockSequence'}, x: 6, y: 6}, {data: {key: 'constantNumber', constantValue: '6000'}, x: 6, y: 7}, {data: {params: {_target: 3}, key: 'connector'}, x: 7, y: 2}, {data: {params: {_target: 1}, key: 'connector'}, x: 7, y: 3}, {data: {params: {_vector3: 0, _vector2: 3, _vector1: 1}, key: 'operatorVectorSum'}, x: 7, y: 4}, {data: {params: {_target: 1}, key: 'connector'}, x: 7, y: 5}, {data: {params: {_target: 1}, key: 'connector'}, x: 7, y: 6}], uuidLeast: -8443639308603780978 as long}}): [10, 0, 1, 1],
  <psi:spell_bullet:1>.withTag({spell: {spellName: 'Blink', uuidMost: -5160180429860157288 as long, validSpell: 1 as byte, spellList: [{data: {key: 'selectorCaster'}, x: 3, y: 2}, {data: {params: {_distance: 4, _target: 1}, key: 'trickBlink'}, x: 3, y: 3}, {data: {key: 'constantNumber', constantValue: '4'}, x: 4, y: 3}], uuidLeast: -5769275948216450916 as long}}) : [10, 0, 1, 1],
};

static sigils as int[][IItemStack] = { // Total weight = 90
  <animus:sigil_builder>            : [10, 0, 1, 1],
  <animus:sigil_storm>              : [10, 0, 1, 1],
  <bloodmagic:sigil_air>            : [10, 0, 1, 1],
  <bloodmagic:sigil_compression>    : [10, 0, 1, 1],
  <bloodmagic:sigil_ender_severance>: [10, 0, 1, 1],
  <bloodmagic:sigil_fast_miner>     : [10, 0, 1, 1],
  <bloodmagic:sigil_green_grove>    : [10, 0, 1, 1],
  <bloodmagic:sigil_haste>          : [10, 0, 1, 1],
  <bloodmagic:sigil_phantom_bridge> : [10, 0, 1, 1],
};

static ancientTomes as int[][IItemStack] = { // Total weight = 52
  <quark:ancient_tome>.withTag({StoredEnchantments: [{lvl: 1 as short, id: 23}]}): [2, 0, 1, 1],
  <quark:ancient_tome>.withTag({StoredEnchantments: [{lvl: 2 as short, id: 19}]}): [2, 0, 1, 1],
  <quark:ancient_tome>.withTag({StoredEnchantments: [{lvl: 2 as short, id: 20}]}): [2, 0, 1, 1],
  <quark:ancient_tome>.withTag({StoredEnchantments: [{lvl: 2 as short, id: 49}]}): [2, 0, 1, 1],
  <quark:ancient_tome>.withTag({StoredEnchantments: [{lvl: 3 as short, id: 12}]}): [2, 0, 1, 1],
  <quark:ancient_tome>.withTag({StoredEnchantments: [{lvl: 3 as short, id: 13}]}): [2, 0, 1, 1],
  <quark:ancient_tome>.withTag({StoredEnchantments: [{lvl: 3 as short, id: 21}]}): [2, 0, 1, 1],
  <quark:ancient_tome>.withTag({StoredEnchantments: [{lvl: 3 as short, id: 22}]}): [2, 0, 1, 1],
  <quark:ancient_tome>.withTag({StoredEnchantments: [{lvl: 3 as short, id: 34}]}): [2, 0, 1, 1],
  <quark:ancient_tome>.withTag({StoredEnchantments: [{lvl: 3 as short, id: 35}]}): [2, 0, 1, 1],
  <quark:ancient_tome>.withTag({StoredEnchantments: [{lvl: 3 as short, id: 61}]}): [2, 0, 1, 1],
  <quark:ancient_tome>.withTag({StoredEnchantments: [{lvl: 3 as short, id: 62}]}): [2, 0, 1, 1],
  <quark:ancient_tome>.withTag({StoredEnchantments: [{lvl: 3 as short, id: 73}]}): [2, 0, 1, 1],
  <quark:ancient_tome>.withTag({StoredEnchantments: [{lvl: 3 as short, id: 78}]}): [2, 0, 1, 1],
  <quark:ancient_tome>.withTag({StoredEnchantments: [{lvl: 3 as short, id: 79}]}): [2, 0, 1, 1],
  <quark:ancient_tome>.withTag({StoredEnchantments: [{lvl: 3 as short, id: 7}]}) : [2, 0, 1, 1],
  <quark:ancient_tome>.withTag({StoredEnchantments: [{lvl: 4 as short, id: 2}]}) : [2, 0, 1, 1],
  <quark:ancient_tome>.withTag({StoredEnchantments: [{lvl: 4 as short, id: 72}]}): [2, 0, 1, 1],
  <quark:ancient_tome>.withTag({StoredEnchantments: [{lvl: 4 as short, id: 74}]}): [2, 0, 1, 1],
  <quark:ancient_tome>.withTag({StoredEnchantments: [{lvl: 4 as short, id: 75}]}): [2, 0, 1, 1],
  <quark:ancient_tome>.withTag({StoredEnchantments: [{lvl: 5 as short, id: 15}]}): [2, 0, 1, 1],
  <quark:ancient_tome>.withTag({StoredEnchantments: [{lvl: 5 as short, id: 16}]}): [2, 0, 1, 1],
  <quark:ancient_tome>.withTag({StoredEnchantments: [{lvl: 5 as short, id: 17}]}): [2, 0, 1, 1],
  <quark:ancient_tome>.withTag({StoredEnchantments: [{lvl: 5 as short, id: 18}]}): [2, 0, 1, 1],
  <quark:ancient_tome>.withTag({StoredEnchantments: [{lvl: 5 as short, id: 32}]}): [2, 0, 1, 1],
  <quark:ancient_tome>.withTag({StoredEnchantments: [{lvl: 5 as short, id: 48}]}): [2, 0, 1, 1],
};

/////////////////////////////////
// Consumable related loottables//
/////////////////////////////////

static magicConsumables as int[][IItemStack] = { // Total weight = 90
  <botania:blacklotus:1>  : [2, 0, 1, 1],
  <botania:blacklotus>    : [8, 0, 1, 2],
  <botania:overgrowthseed>: [10, 0, 1, 2],
  <thaumcraft:curio:1>    : [10,  0, 1, 2],
  <thaumcraft:curio:2>    : [10,  0, 1, 2],
  <thaumcraft:curio:4>    : [10,  0, 1, 2],
  <thaumcraft:curio:5>    : [10,  0, 1, 2],
  <thaumcraft:curio>      : [10,  0, 1, 2],
  <thaumcraft:sanity_soap>: [20,  0, 1, 4],
};

static magicComponents as int[][IItemStack] = { // Total weight = 110
  <botania:manaresource:1>         : [5, 0, 1, 2],
  <botania:manaresource:2>         : [5, 0, 1, 2],
  <endreborn:item_dragonite_seeds> : [2, 0, 1, 1],
  <endreborn:item_end_essence>     : [10, 0, 1, 4],
  <thaumadditions:void_fruit>      : [5, 0, 1, 2],
  <thaumcraft:bottle_taint>        : [10, 0, 1, 2],
  <thaumcraft:condenser_lattice>   : [20, 0, 3, 5],
  <thaumcraft:mechanism_complex>   : [3, 0, 1, 1],
  <thaumcraft:mechanism_simple>    : [10, 0, 1, 3],
  <thaumcraft:mind:1>              : [5, 0, 1, 1],
  <thaumcraft:mind>                : [4, 0, 1, 1],
  <thaumcraft:module:1>            : [4, 0, 1, 1],
  <thaumcraft:module>              : [5, 0, 1, 1],
  <thaumcraft:morphic_resonator>   : [10, 0, 1, 2],
  <thaumcraft:vis_resonator>       : [10, 0, 1, 2],
  <thaumicwonders:primordial_grain>: [2, 0, 1, 5],
};

static badFood as int[][IItemStack] = { // Total weight = 160
  <harvestcraft:zombiejerkyitem>  : [20,0,1,2],
  <rats:contaminated_food>        : [100,0,1,10],
  <tconstruct:edible:10>          : [15,0,1,2],
  <thaumcraft:brain>              : [10,0,1,2],
  <warptheory:item_something>     : [5,0,1,2],
};

static goodFood as int[][IItemStack] = { // Total weight = 51
  <contenttweaker:dairy_pill>            : [3, 0, 1, 2],
  <contenttweaker:fruit_pill>            : [3, 0, 1, 2],
  <contenttweaker:grain_pill>            : [3, 0, 1, 2],
  <contenttweaker:protein_pill>          : [3, 0, 1, 2],
  <contenttweaker:vegetable_pill>        : [3, 0, 1, 2],
  <harvestcraft:chickencurryitem>        : [3, 0, 1, 2],
  <harvestcraft:chimichangaitem>         : [3, 0, 1, 2],
  <harvestcraft:delightedmealitem>       : [3, 0, 1, 2],
  <harvestcraft:deluxechickencurryitem>  : [3, 0, 1, 2],
  <harvestcraft:deluxenachoesitem>       : [3, 0, 1, 2],
  <harvestcraft:gourmetporkburgeritem>   : [3, 0, 1, 2],
  <harvestcraft:gourmetvenisonburgeritem>: [3, 0, 1, 2],
  <harvestcraft:hamandpineapplepizzaitem>: [3, 0, 1, 2],
  <harvestcraft:netherstartoastitem>     : [3, 0, 1, 2],
  <harvestcraft:ploughmanslunchitem>     : [3, 0, 1, 2],
  <harvestcraft:randomtacoitem>          : [3, 0, 1, 2],
  <harvestcraft:thankfuldinneritem>      : [3, 0, 1, 2],
};

static techComponents as int[][IItemStack] = { // Total weight = 308
  <ic2:crafting:1>                 : [50, 0, 1, 2],
  <ic2:crafting:2>                 : [20, 0, 1, 2],
  <ic2:crafting:6>                 : [20, 0, 1, 1],
  <ic2:crafting:7>                 : [20, 0, 1, 2],
  <immersiveengineering:material:1>: [30, 0, 1, 2],
  <immersiveengineering:material:2>: [30, 0, 1, 2],
  <immersiveengineering:material:8>: [30, 0, 1, 2],
  <immersiveengineering:material:9>: [30, 0, 1, 2],
  <mechanics:empty_rod>            : [10, 0, 1, 1],
  <mekanismgenerators:solarpanel>  : [50, 0, 1, 3],
  <nuclearcraft:part:7>            : [5, 0, 1, 2],
  <nuclearcraft:part:8>            : [5, 0, 1, 2],
  <nuclearcraft:part:9>            : [5, 0, 1, 2],
};

static tinkersModifiers as int[][IItemStack] = { // Total weight = 57
  <actuallyadditions:item_crystal_empowered:2>: [1, 0, 1, 1],
  <conarm:gauntlet_mat>                       : [1, 0, 1, 1],
  <conarm:resist_mat>                         : [5, 0, 1, 1],
  <conarm:resist_mat_blast>                   : [5, 0, 1, 1],
  <conarm:resist_mat_fire>                    : [5, 0, 1, 1],
  <conarm:resist_mat_proj>                    : [5, 0, 1, 1],
  <conarm:travel_belt_base>                   : [1, 0, 1, 1],
  <conarm:travel_sack>                        : [1, 0, 1, 1],
  <conarm:travel_slowfall>                    : [1, 0, 1, 1],
  <oeintegration:excavatemodifier>            : [2, 0, 1, 1],
  <scalinghealth:heartdust>                   : [5, 0, 1, 4],
  <tconstruct:materials:12>                   : [3, 0, 1, 1],
  <tconstruct:materials:13>                   : [3, 0, 1, 1],
  <tconstruct:materials:14>                   : [3, 0, 1, 1],
  <tconstruct:materials:16>                   : [3, 0, 1, 1],
  <tconstruct:materials:19>                   : [3, 0, 1, 1],
  <tinkersaddons:modifier_item:1>             : [4, 0, 1, 1],
  <tinkersaddons:modifier_item:2>             : [3, 0, 1, 1],
  <tinkersaddons:modifier_item:3>             : [2, 0, 1, 1],
  <tinkersaddons:modifier_item:4>             : [1, 0, 1, 1],
};

static upgrades as int[][IItemStack] = { // Total weight = 98
  <advgenerators:capacitor_kit_advanced>    : [1, 0, 1, 1],
  <extrautils2:ingredients:15>              : [5, 0, 1, 1],
  <ic2:upgrade:1>                           : [10, 0, 1, 1],
  <ic2:upgrade>                             : [10, 0, 1, 1],
  <mekanism:energyupgrade>                  : [5, 0, 1, 1],
  <mekanism:speedupgrade>                   : [5, 0, 1, 1],
  <mekanism:tierinstaller:1>                : [1, 0, 1, 1],
  <mekanism:tierinstaller>                  : [3, 0, 1, 1],
  <nuclearcraft:upgrade:1>                  : [3, 0, 1, 1],
  <nuclearcraft:upgrade>                    : [3, 0, 1, 1],
  <rats:rat_upgrade_basic>                  : [5, 0, 1, 1],
  <rats:rat_upgrade_jury_rigged>.withTag({}): [5, 0, 1, 1],
  <rats:rat_upgrade_speed>                  : [5, 0, 1, 1],
  <storagedrawers:upgrade_storage:1>        : [4, 0, 1, 1],
  <storagedrawers:upgrade_storage:2>        : [2, 0, 1, 1],
  <storagedrawers:upgrade_storage>          : [6, 0, 1, 1],
  <teslacorelib:energy_tier1>               : [4, 0, 1, 1],
  <teslacorelib:energy_tier2>               : [2, 0, 1, 1],
  <teslacorelib:speed_tier1>                : [4, 0, 1, 1],
  <teslacorelib:speed_tier2>                : [2, 0, 1, 1],
  <thermalexpansion:augment:128>            : [3, 0, 1, 1],
  <thermalfoundation:upgrade:1>             : [2, 0, 1, 1],
  <thermalfoundation:upgrade>               : [5, 0, 1, 1],
};

static celestialNotes as int[][IItemStack] = { // Total weight = 130
  <thaumcraft:celestial_notes:10>: [10, 0, 1, 2],
  <thaumcraft:celestial_notes:11>: [10, 0, 1, 2],
  <thaumcraft:celestial_notes:12>: [10, 0, 1, 2],
  <thaumcraft:celestial_notes:1> : [10, 0, 1, 2],
  <thaumcraft:celestial_notes:2> : [10, 0, 1, 2],
  <thaumcraft:celestial_notes:3> : [10, 0, 1, 2],
  <thaumcraft:celestial_notes:4> : [10, 0, 1, 2],
  <thaumcraft:celestial_notes:5> : [10, 0, 1, 2],
  <thaumcraft:celestial_notes:6> : [10, 0, 1, 2],
  <thaumcraft:celestial_notes:7> : [10, 0, 1, 2],
  <thaumcraft:celestial_notes:8> : [10, 0, 1, 2],
  <thaumcraft:celestial_notes:9> : [10, 0, 1, 2],
  <thaumcraft:celestial_notes>   : [10, 0, 1, 2],
};
