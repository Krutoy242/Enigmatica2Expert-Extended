#modloaded omniwand
#reloadable

import crafttweaker.item.IItemStack;

// Oredict remake
recipes.remove(<omniwand:wand>);
recipes.addShaped('Morphing Tool', <omniwand:wand>, [
  [null, <ore:dyeLime>, <extrautils2:endershard>],
  [null, <ore:ingotFakeIron>, <ore:dyeOrange>],
  [<ore:ingotFakeIron>, null, null]]);

static superwand as IItemStack = <omniwand:wand>.withTag({
  "omniwand:data": {
    actuallyadditions   : {id: "actuallyadditions:item_laser_wrench"            , Count: 1, tag: { "omniwand:definedMod": "actuallyadditions"    }},
    actuallyadditions0  : {id: "actuallyadditions:item_crafter_on_a_stick"      , Count: 1, tag: { "omniwand:definedMod": "actuallyadditions0"   }},
    appliedenergistics2 : {id: "appliedenergistics2:nether_quartz_wrench"       , Count: 1, tag: { "omniwand:definedMod": "appliedenergistics2"  }},
    appliedenergistics20: {id: "appliedenergistics2:nether_quartz_cutting_knife", Count: 1, tag: { "omniwand:definedMod": "appliedenergistics20" }},
    appliedenergistics21: {id: "appliedenergistics2:network_tool"               , Count: 1, tag: { "omniwand:definedMod": "appliedenergistics21" }},
    architecturecraft   : {id: "architecturecraft:chisel"                       , Count: 1, tag: { "omniwand:definedMod": "architecturecraft"    }},
    architecturecraft1  : {id: "architecturecraft:hammer"                       , Count: 1, tag: { "omniwand:definedMod": "architecturecraft1"   }},
    bloodmagic          : {id: "bloodmagic:ritual_reader"                       , Count: 1, tag: { "omniwand:definedMod": "bloodmagic"           }},
    bloodmagic0         : {id: "bloodmagic:node_router"                         , Count: 1, tag: { "omniwand:definedMod": "bloodmagic0"          }},
    botania             : {id: "botania:twigwand"                               , Count: 1, tag: { "omniwand:definedMod": "botania"              }},
    chisel              : {id: "chisel:offsettool"                              , Count: 1, tag: { "omniwand:definedMod": "chisel"               }},
    compactmachines3    : {id: "compactmachines3:psd"                           , Count: 1, tag: { "omniwand:definedMod": "compactmachines3"     }},
    deepmoblearningbm   : {id: "deepmoblearningbm:altar_linker"                 , Count: 1, tag: { "omniwand:definedMod": "deepmoblearningbm"    }},
    draconicevolution   : {id: "draconicevolution:crystal_binder"               , Count: 1, tag: { "omniwand:definedMod": "draconicevolution"    }},
    enderio             : {id: "enderio:item_yeta_wrench"                       , Count: 1, tag: { "omniwand:definedMod": "enderio"              }},
    environmentaltech   : {id: "environmentaltech:tool_multiblock_assembler"    , Count: 1, tag: { "omniwand:definedMod": "environmentaltech"    }},
    extrautils2         : {id: "extrautils2:wrench"                             , Count: 1, tag: { "omniwand:definedMod": "extrautils2"          }},
    forestry            : {id: "forestry:smoker"                                , Count: 1, tag: { "omniwand:definedMod": "forestry"             }},
    forestry1           : {id: "forestry:soldering_iron"                        , Count: 1, tag: { "omniwand:definedMod": "forestry1"            }},
    forestry2           : {id: "forestry:wrench"                                , Count: 1, tag: { "omniwand:definedMod": "forestry2"            }},
    ic2                 : {id: "ic2:wrench"                                     , Count: 1, tag: { "omniwand:definedMod": "ic2"                  }},
    ic20                : {id: "ic2:crowbar"                                    , Count: 1, tag: { "omniwand:definedMod": "ic20"                 }},
    ic21                : {id: "ic2:foam_sprayer"                               , Count: 1, tag: { "omniwand:definedMod": "ic21"                 }},
    ic22                : {id: "ic2:painter"                                    , Count: 1, tag: { "omniwand:definedMod": "ic22"                 }},
    ic23                : {id: "ic2:weeding_trowel"                             , Count: 1, tag: { "omniwand:definedMod": "ic23"                 }},
    ic24                : {id: "ic2:wrench_new"                                 , Count: 1, tag: { "omniwand:definedMod": "ic24"                 }},
    iceandfire          : {id: "iceandfire:dragon_stick"                        , Count: 1, tag: { "omniwand:definedMod": "iceandfire"           }},
    iceandfire0         : {id: "iceandfire:dragon_flute"                        , Count: 1, tag: { "omniwand:definedMod": "iceandfire0"          }},
    iceandfire1         : {id: "iceandfire:myrmex_desert_staff"                 , Count: 1, tag: { "omniwand:definedMod": "iceandfire1"          }},
    iceandfire2         : {id: "iceandfire:myrmex_jungle_staff"                 , Count: 1, tag: { "omniwand:definedMod": "iceandfire2"          }},
    immersiveengineering: {id: "immersiveengineering:tool"                      , Count: 1, tag: { "omniwand:definedMod": "immersiveengineering" }},
    immersivepetroleum  : {id: "immersivepetroleum:oil_can"                     , Count: 1, tag: { "omniwand:definedMod": "immersivepetroleum"   }},
    integratedtunnels   : {id: "integrateddynamics:wrench"                      , Count: 1, tag: { "omniwand:definedMod": "integratedtunnels"    }},
    integratedtunnels0  : {id: "integrateddynamics:labeller"                    , Count: 1, tag: { "omniwand:definedMod": "integratedtunnels0"   }},
    integratedtunnels1  : {id: "integrateddynamics:portable_logic_programmer"   , Count: 1, tag: { "omniwand:definedMod": "integratedtunnels1"   }},
    libvulpes           : {id: "libvulpes:linker"                               , Count: 1, tag: { "omniwand:definedMod": "libvulpes"            }},
    mekanism            : {id: "mekanism:configurator"                          , Count: 1, tag: { "omniwand:definedMod": "mekanism"             }},
    mekanism0           : {id: "mekanism:gaugedropper"                          , Count: 1, tag: { "omniwand:definedMod": "mekanism0"            }},
    nuclearcraft        : {id: "nuclearcraft:multitool"                         , Count: 1, tag: { "omniwand:definedMod": "nuclearcraft"         }, tag: { multitoolUsed: 0 as byte }},
    opencomputers       : {id: "opencomputers:tool"                             , Count: 1, tag: { "omniwand:definedMod": "opencomputers"        }},
    opencomputers1      : {id: "opencomputers:wrench"                           , Count: 1, tag: { "omniwand:definedMod": "opencomputers1"       }},
    rats                : {id: "rats:cheese_stick"                              , Count: 1, tag: { "omniwand:definedMod": "rats"                 }},
    rats1               : {id: "rats:radius_stick"                              , Count: 1, tag: { "omniwand:definedMod": "rats1"                }},
    rftools             : {id: "rftools:smartwrench"                            , Count: 1, tag: { "omniwand:definedMod": "rftools"              }},
    storagedrawers      : {id: "storagedrawers:drawer_key"                      , Count: 1, tag: { "omniwand:definedMod": "storagedrawers"       }},
    storagedrawers1     : {id: "storagedrawers:personal_key"                    , Count: 1, tag: { "omniwand:definedMod": "storagedrawers1"      }},
    storagedrawers2     : {id: "storagedrawers:quantify_key"                    , Count: 1, tag: { "omniwand:definedMod": "storagedrawers2"      }},
    storagedrawers3     : {id: "storagedrawers:shroud_key"                      , Count: 1, tag: { "omniwand:definedMod": "storagedrawers3"      }},
    teslacorelib        : {id: "teslacorelib:wrench"                            , Count: 1, tag: { "omniwand:definedMod": "teslacorelib"         }},
    thermalfoundation   : {id: "thermalfoundation:wrench"                       , Count: 1, tag: { "omniwand:definedMod": "thermalfoundation"    }},
    thaumcraft          : {id: "thaumcraft:resonator"                           , Count: 1, tag: { "omniwand:definedMod": "thaumcraft"           }},
  },
  "omniwand:is_transforming": 1 as byte,
});

recipes.addShaped('Superwrench', superwand, [
  [null, <ore:gearCopper>, null],
  [<ore:gearAluminium>, <omniwand:wand>, <ore:gearTin>],
  [null, <ore:gearLead>, null],
]);

// Prevent NuclerCraft: Overhauled destroy omniwand on right-click with Multitool
// Since I cant actually cancel event, i will just give player another Omniwant
events.onPlayerInteractBlock(function(e as crafttweaker.event.PlayerInteractBlockEvent) {
  if(
    e.world.remote
    || !e.player.isSneaking
    || isNull(e.item)
    || e.item.definition.id != 'nuclearcraft:multitool'
    || isNull(e.item.tag)
    || isNull(e.item.tag.memberGet('omniwand:data'))
  ) return;

  e.player.give(e.item);
  e.item.mutable().shrink(e.item.amount);
  e.cancel();
});
