/*
Nuclianthus (Helianthus + nuclear) - botanical reactor
Generates power using nuclear fuel (produces nuclear waste)
Catch: if buffer is overflowing (for some mana amount wasted - but heals overtime) it explodes KABOOM!!!

Stats:
Mana per 1 sec: H/t*eff
Time working: as on fuel
*/
#loader contenttweaker

import crafttweaker.data.IData;
import crafttweaker.entity.IEntityItem;
import crafttweaker.item.IItemStack;
import crafttweaker.util.Math;
import crafttweaker.world.IBlockPos;
import crafttweaker.world.IWorld;
import mods.contenttweaker.Color;
import mods.contenttweaker.VanillaFactory;
import mods.randomtweaker.cote.BlockAdded;
import mods.randomtweaker.cote.ISubTileEntity;
import mods.randomtweaker.cote.ISubTileEntityGenerating;
import mods.randomtweaker.cote.SubTileEntityInGame;
import mods.zenutils.DataUpdateOperation.OVERWRITE;
import native.net.minecraft.util.EnumParticleTypes;
import native.net.minecraft.world.World;

static fuelsList as int[][string] = {
/*
Fromat:
fuel:name [duration, heat/t, effciency]
*/

// Thorium fuels
'item.nuclearcraft.fuel_thorium.tbu_ox': [14400, 40, 125], // TBU-OX
'item.nuclearcraft.fuel_thorium.tbu_ni': [18000, 32, 125], // TBU-NI
'item.nuclearcraft.fuel_thorium.tbu_za': [11520, 50, 125],  // TBU-ZA

// Uranium fuels
'item.nuclearcraft.fuel_uranium.leu_233_ox': [2666, 216, 110], // LEU-233-OX
'item.nuclearcraft.fuel_uranium.leu_233_ni': [3348, 172, 110], // LEU-233-NI
'item.nuclearcraft.fuel_uranium.leu_233_za': [2134, 270, 110], // LEU-233-ZA
'item.nuclearcraft.fuel_uranium.heu_233_ox': [2666, 648, 115], // HEU-233-OX
'item.nuclearcraft.fuel_uranium.heu_233_ni': [3348, 516, 115], // HEU-233-NI
'item.nuclearcraft.fuel_uranium.heu_233_za': [2134, 810, 115], // HEU-233-ZA
'item.nuclearcraft.fuel_uranium.leu_235_ox': [4800, 120, 100], // LEU-235-OX
'item.nuclearcraft.fuel_uranium.leu_235_ni': [6000, 96, 100], // LEU-235-NI
'item.nuclearcraft.fuel_uranium.leu_235_za': [3840, 150, 100], // LEU-235-ZA
'item.nuclearcraft.fuel_uranium.heu_235_ox': [4800, 360, 105], // HEU-235-OX
'item.nuclearcraft.fuel_uranium.heu_235_ni': [6000, 288, 105], // HEU-235-NI
'item.nuclearcraft.fuel_uranium.heu_235_za': [3840, 450, 105],  // HEU-235-ZA

// Neptunium fuels
'item.nuclearcraft.fuel_neptunium.len_236_ox': [1972, 292, 110], // LEN-236-OX
'item.nuclearcraft.fuel_neptunium.len_236_ni': [2462, 234, 110], // LEN-236-NI
'item.nuclearcraft.fuel_neptunium.len_236_za': [1574, 366, 110], // LEN-236-ZA
'item.nuclearcraft.fuel_neptunium.hen_236_ox': [1972, 876, 115], // HEN-236-OX
'item.nuclearcraft.fuel_neptunium.hen_236_ni': [2462, 702, 115], // HEN-236-NI
'item.nuclearcraft.fuel_neptunium.hen_236_za': [1574, 1098, 115],  // HEN-236-ZA

// Plutonium fuels
'item.nuclearcraft.fuel_plutonium.lep_239_ox': [4572, 126, 120], // LEP-239-OX
'item.nuclearcraft.fuel_plutonium.lep_239_ni': [5760, 100, 120], // LEP-239-NI
'item.nuclearcraft.fuel_plutonium.lep_239_za': [3646, 158, 120], // LEP-239-ZA
'item.nuclearcraft.fuel_plutonium.hep_239_ox': [4572, 378, 125], // HEP-239-OX
'item.nuclearcraft.fuel_plutonium.hep_239_ni': [5760, 300, 125], // HEP-239-NI
'item.nuclearcraft.fuel_plutonium.hep_239_za': [3646, 474, 125], // HEP-239-ZA
'item.nuclearcraft.fuel_plutonium.lep_241_ox': [3164, 182, 130], // LEP-241-OX
'item.nuclearcraft.fuel_plutonium.lep_241_ni': [3946, 146, 130], // LEP-241-NI
'item.nuclearcraft.fuel_plutonium.lep_241_za': [2526, 228, 130], // LEP-241-ZA
'item.nuclearcraft.fuel_plutonium.hep_241_ox': [3164, 546, 130], // HEP-241-OX
'item.nuclearcraft.fuel_plutonium.hep_241_ni': [3946, 438, 130], // HEP-241-NI
'item.nuclearcraft.fuel_plutonium.hep_241_za': [2526, 684, 130], // HEP-241-ZA

// Mixed fuels
'item.nuclearcraft.fuel_mixed.mix_239_ox': [4354, 132, 105], // MOX-239
'item.nuclearcraft.fuel_mixed.mix_239_ni': [5486, 106, 105], // MNI-239
'item.nuclearcraft.fuel_mixed.mix_239_za': [3472, 166, 105], // MZA-239
'item.nuclearcraft.fuel_mixed.mix_241_ox': [3014, 192, 115], // MOX-241
'item.nuclearcraft.fuel_mixed.mix_241_ni': [3758, 154, 115], // MNI-241
'item.nuclearcraft.fuel_mixed.mix_241_za': [2406, 240, 115], // MZA-241

// Americium fuels
'item.nuclearcraft.fuel_americium.lea_242_ox': [1476, 390, 135], // LEA-242-OX
'item.nuclearcraft.fuel_americium.lea_242_ni': [1846, 312, 135], // LEA-242-NI
'item.nuclearcraft.fuel_americium.lea_242_za': [1180, 488, 135], // LEA-242-ZA
'item.nuclearcraft.fuel_americium.hea_242_ox': [1476, 1170, 140], // HEA-242-OX
'item.nuclearcraft.fuel_americium.hea_242_ni': [1846, 936, 140], // HEA-242-NI
'item.nuclearcraft.fuel_americium.hea_242_za': [1180, 1464, 140],  // HEA-242-ZA

// Curium fuels
'item.nuclearcraft.fuel_curium.lecm_243_ox': [1500, 384, 145], // LECm-243-OX
'item.nuclearcraft.fuel_curium.lecm_243_ni': [1870, 308, 145], // LECm-243-NI
'item.nuclearcraft.fuel_curium.lecm_243_za': [1200, 480, 145], // LECm-243-ZA
'item.nuclearcraft.fuel_curium.hecm_243_ox': [1500, 1152, 150], // HECm-243-OX
'item.nuclearcraft.fuel_curium.hecm_243_ni': [1870, 924, 150], // HECm-243-NI
'item.nuclearcraft.fuel_curium.hecm_243_za': [1200, 1440, 150], // HECm-243-ZA
'item.nuclearcraft.fuel_curium.lecm_245_ox': [2420, 238, 150], // LECm-245-OX
'item.nuclearcraft.fuel_curium.lecm_245_ni': [3032, 190, 150], // LECm-245-NI
'item.nuclearcraft.fuel_curium.lecm_245_za': [1932, 298, 150], // LECm-245-ZA
'item.nuclearcraft.fuel_curium.hecm_245_ox': [2420, 714, 155], // HECm-245-OX
'item.nuclearcraft.fuel_curium.hecm_245_ni': [3032, 570, 155], // HECm-245-NI
'item.nuclearcraft.fuel_curium.hecm_245_za': [1932, 894, 155], // HECm-245-ZA
'item.nuclearcraft.fuel_curium.lecm_247_ox': [2150, 268, 155], // LECm-247-OX
'item.nuclearcraft.fuel_curium.lecm_247_ni': [2692, 214, 155], // LECm-247-NI
'item.nuclearcraft.fuel_curium.lecm_247_za': [1714, 336, 155], // LECm-247-ZA
'item.nuclearcraft.fuel_curium.hecm_247_ox': [2150, 804, 160], // HECm-247-OX
'item.nuclearcraft.fuel_curium.hecm_247_ni': [2692, 642, 160], // HECm-247-NI
'item.nuclearcraft.fuel_curium.hecm_247_za': [1714, 1008, 160],  // HECm-247-ZA

// Berkelium fuels
'item.nuclearcraft.fuel_berkelium.leb_248_ox': [2166, 266, 165], //LEB-248-OX
'item.nuclearcraft.fuel_berkelium.leb_248_ni': [2716, 212, 165], //LEB-248-NI
'item.nuclearcraft.fuel_berkelium.leb_248_za': [1734, 332, 165], //LEB-248-ZA
'item.nuclearcraft.fuel_berkelium.heb_248_ox': [2166, 798, 170], //HEB-248-OX
'item.nuclearcraft.fuel_berkelium.heb_248_ni': [2716, 636, 170], //HEB-248-NI
'item.nuclearcraft.fuel_berkelium.heb_248_za': [1734, 996, 170], //HEB-248-ZA

// Californium fuels
'item.nuclearcraft.fuel_californium.lecf_249_ox': [1348, 442, 165], // LECf-249-OX
'item.nuclearcraft.fuel_californium.lecf_249_ni': [1684, 354, 165], // LECf-249-NI
'item.nuclearcraft.fuel_californium.lecf_249_za': [1078, 558, 165], // LECf-249-ZA
'item.nuclearcraft.fuel_californium.hecf_249_ox': [1348, 1326, 170], // HECf-249-OX
'item.nuclearcraft.fuel_californium.hecf_249_ni': [1684, 1062, 170], // HECf-249-NI
'item.nuclearcraft.fuel_californium.hecf_249_za': [1078, 1674, 170], // HECf-249-ZA
'item.nuclearcraft.fuel_californium.lecf_251_ox': [1468, 396, 170], // LECf-251-OX
'item.nuclearcraft.fuel_californium.lecf_251_ni': [1840, 318, 170], // LECf-251-NI
'item.nuclearcraft.fuel_californium.lecf_251_za': [1180, 502, 170], // LECf-251-ZA
'item.nuclearcraft.fuel_californium.hecf_251_ox': [1468, 1188, 175], // HECf-251-OX
'item.nuclearcraft.fuel_californium.hecf_251_ni': [1840, 950, 175], // HECf-251-NI
'item.nuclearcraft.fuel_californium.hecf_251_za': [1180, 1502, 175],  // HECf-251-ZA

// IC2 fuels
'ic2.nuclear.uranium'   : [7600,  100, 120],    // Enriched uranium
'ic2.nuclear.mox'       : [45600, 140, 135],    // MOX

} as int[][string]; 

static fuelDurationMultiplier as double = 1.0;
static fuelManaGenerationMultiplier as double = 1.0;
static overHeatLimit as int = 10000;

var nuclianthus = VanillaFactory.createSubTileGenerating("nuclianthus", 0xffff00);
nuclianthus.maxMana = 10000;
nuclianthus.passiveFlower = false;
nuclianthus.range = 1;
nuclianthus.onUpdate = function(subtile, world, pos) { 
    if(world.isRemote()) {
        
        return;
    }
    isWorking(subtile) ? generate(world, pos, subtile) : pickUpFuel(world, pos, subtile);
};
nuclianthus.register();

function isWorking(subtile as SubTileEntityInGame) as bool{
    return !(isNull(subtile.data)
    || isNull(subtile.data.Status)
    || subtile.data.Status!="work");
}

function generate(world as IWorld, pos as IBlockPos, subtile as SubTileEntityInGame) as void{
    if(subtile.data.FuelData.duration>0){
        if(world.isRemote()){
            world.native.spawnParticle(EnumParticleTypes.CRIT_MAGIC, pos.x, 1.2f + pos.y, pos.z, 0, 0, 0, 5);
            return;
        }
        val manaGenerated = (subtile.data.FuelData.production / 20) as int;
        val heatGenerated = Math.max(manaGenerated + subtile.getMana() - subtile.getMaxMana(), 0);
        subtile.setCustomData(subtile.data.deepUpdate({Overheat: (Math.max((subtile.data.Overheat + heatGenerated - 10) as int , 0)), FuelData: {duration: subtile.data.FuelData.duration - 2}},{FuelData: {duration: OVERWRITE}, Overheat: OVERWRITE}));
        subtile.addMana(manaGenerated);
        if(world.random.nextInt(5) > 2) scripts.lib.sound.play("minecraft:block.lava.pop", pos, world); //I would like to use this: "nuclearcraft:player.geiger_tick"
        server.commandManager.executeCommandSilent(server, "/particle reddust "~pos.x~" "~(1.2f + pos.y)~" "~pos.z~" "~(((subtile.data.Overheat as float) / 10000) - 1)~" "~(((10000 - subtile.data.Overheat) as float) / 10000)~" 0 1");
        if(subtile.data.Overheat > overHeatLimit) world.performExplosion(null, pos.x, pos.y, pos.z, 20.0f, true, true); //TODO make falling blocks
    } else {
        dropFuelWaste(world, pos, subtile);
    }
}

function pickUpFuel(world as IWorld, pos as IBlockPos, subtile as SubTileEntityInGame)as void{
    if(world.isRemote()) return;
    val fuel = findFuel(world, pos);
    if(isNull(fuel)) return;
    val fuelData = fuelsList[fuel.item.name]; 
    if(isNull(fuelData)) return;
    val newData = {
        Status : 'work',
        FuelData : {duration: (fuelDurationMultiplier * fuelData[0]) as int , production: (fuelManaGenerationMultiplier * fuelData[1] * fuelData[2] / 100) as int},
        Overheat : getSubtileHeat(subtile),
        WasteName : getFuelWasteOreDictName(fuel.item)
    } as IData;    
    subtile.setCustomData(newData);
    scripts.lib.sound.play("minecraft:entity.item.pickup", pos, world);

    fuel.item.amount==1 ? fuel.setDead() : fuel.item.mutable().shrink(1);
    return;
}

function getSubtileHeat(subtile as SubTileEntityInGame) as int{
    if(isNull(subtile.data)
    || isNull(subtile.data.Overheat)) return 0;
    return subtile.data.Overheat as int;
}

function getFuelWasteOreDictName(item as IItemStack) as string{
    for ore in item.ores{
        if(ore.name.startsWith('ingot')) return ore.name.replaceFirst('ingot', 'ingotDepleted');
    }
}

function findFuel(world as IWorld, pos as IBlockPos) as IEntityItem{
    val items = world.getEntityItems();
    for item in items{
        if(isNull(item)
        || isNull(item.item)
        || Math.abs(item.x - pos.x - 0.5 ) > 2
        || Math.abs(item.y - pos.y ) > 1
        || Math.abs(item.z - pos.z - 0.5) > 2
        || !item.alive) continue;
        for ore in item.item.ores{
            if(ore.name=='fuelReactor') return item;
        }
    }
    return null;
}

function dropFuelWaste(world as IWorld, pos as IBlockPos, subtile as SubTileEntityInGame) as void{
    world.spawnEntity(oreDict.get(subtile.data.WasteName).firstItem.createEntityItem(world, pos.x, pos.y + 0.3f, pos.z));
    subtile.setCustomData({Status: "pickUp"} as IData);
}
