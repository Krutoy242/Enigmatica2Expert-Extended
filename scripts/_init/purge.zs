/**
 * @file Remove all items and their OreDicts BEFORE other scripts loads
 * to prevent iterating over purged items
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

#ignoreBracketErrors
#modloaded zenutils
#priority 3000
#reloadable

import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;

function furnaceRemove(output as IItemStack, input as IIngredient) as void {
  if (isNull(output)) return;
  if (isNull(input)) furnace.remove(output);
  else furnace.remove(output, input);
}

function recipesRemove(output as IItemStack) as void {
  if (isNull(output)) return;
  recipes.remove(output);
}

// Industrial Diamond (Replaced with regular diamond)
Purge(<ic2:crafting:19>).ores([<ore:gemDiamond>]);

// Unused dusts
Purge(<ic2:dust:4>).ores([<ore:dustCopper>]);
Purge(<ic2:dust:7>).ores([<ore:dustGold>]);
Purge(<ic2:dust:8>).ores([<ore:dustIron>]);
Purge(<ic2:dust:10>).ores([<ore:dustLead>]);
Purge(<ic2:dust:12>).ores([<ore:dustObsidian>]);
Purge(<ic2:dust:14>).ores([<ore:dustSilver>]);
Purge(<ic2:dust:17>).ores([<ore:dustTin>]);
Purge(<ic2:dust:25>).ores([<ore:dustTinyObsidian>]);
Purge(<ic2:nuclear:6>);
Purge(<ic2:nuclear:8>);
Purge(<ic2:nuclear:9>);
Purge(<ic2:resource:8>).ores([<ore:blockSteel>]); // Steel blocks
Purge(<ic2:resource:6>).ores([<ore:blockCopper>]); // Copper blocks
Purge(<ic2:resource:9>).ores([<ore:blockTin>]); // Tin blocks
Purge(<ic2:resource:10>).ores([<ore:blockUranium>]);
Purge(<ic2:resource:15>).ores([<ore:blockSilver>]); // Silver blocks
Purge(<ic2:resource:7>).ores([<ore:blockLead>]); // Lead blocks
Purge(<ic2:misc_resource>).ores([<ore:dustAshes>]); // Ashes
Purge(<ic2:misc_resource:5>).ores([<ore:itemSlag>]); // Slag
Purge(<ic2:plate>).ores([<ore:plateBronze>]);
Purge(<ic2:plate:1>).ores([<ore:plateCopper>]);
Purge(<ic2:plate:2>).ores([<ore:plateGold>]);
Purge(<ic2:plate:3>).ores([<ore:plateIron>]);
Purge(<ic2:plate:5>).ores([<ore:plateLead>]);
Purge(<ic2:plate:7>).ores([<ore:plateSteel>]);
Purge(<ic2:plate:8>).ores([<ore:plateTin>]);
Purge(<thaumcraft:plate:1>).ores([<ore:plateIron>]);
Purge(<openblocks:generic:1>); // Crane ingredient
Purge(<openblocks:generic:2>);
Purge(<openblocks:generic:3>);
Purge(<openblocks:generic:4>);
Purge(<openblocks:generic:5>);
Purge(<openblocks:cursor>);
Purge(<actuallyadditions:item_misc:17>).ores([<ore:dye>, <ore:dyeBlack>]);
Purge(<actuallyadditions:item_food:9>);
Purge(<avaritia:compressed_crafting_table>);
Purge(<avaritia:double_compressed_crafting_table>);
Purge(<avaritia:resource>); // Diamond Lattice
Purge(<nuclearcraft:alloy>).ores([<ore:ingotBronze>]);
Purge(<nuclearcraft:alloy:5>).ores([<ore:ingotSteel>]);
Purge(<nuclearcraft:dust>).ores([<ore:dustCopper>]);
Purge(<nuclearcraft:dust:1>).ores([<ore:dustTin>]);
Purge(<nuclearcraft:dust:2>).ores([<ore:dustLead>]);
Purge(<nuclearcraft:dust:4>).ores([<ore:dustUranium>]);
Purge(<nuclearcraft:gem_dust>).ores([<ore:dustDiamond>]);
Purge(<nuclearcraft:gem_dust:2>);
Purge(<nuclearcraft:gem_dust:3>).ores([<ore:dustObsidian>]);
Purge(<nuclearcraft:gem_dust:6>).ores([<ore:dustSulfur>, <ore:dustSulphur>]);
Purge(<nuclearcraft:gem:6>);
Purge(<nuclearcraft:ingot>).ores([<ore:ingotCopper>]);
Purge(<nuclearcraft:ingot:1>).ores([<ore:ingotTin>]);
Purge(<nuclearcraft:ingot:2>).ores([<ore:ingotLead>]);
Purge(<nuclearcraft:ingot:4>).ores([<ore:ingotUranium>]);
Purge(<nuclearcraft:ingot_block:4>).ores([<ore:blockUranium>]);
Purge(<nuclearcraft:ore>);
Purge(<nuclearcraft:ore:1>);
Purge(<nuclearcraft:ore:2>);
Purge(<nuclearcraft:ore:4>);
Purge(<qmd:dust:4>).ores([<ore:dustCobalt>]); // Cobalt
Purge(<qmd:dust:3>).ores([<ore:dustTitanium>]); // Cobalt
Purge(<qmd:ingot_alloy:4>).ores([<ore:ingotOsmiridium>]); // Osmiridium
Purge(<qmd:ingot:3>).ores([<ore:ingotTitanium>]); // Titanium Ingot
Purge(<qmd:ingot:4>).ores([<ore:ingotCobalt>]); // Cobalt
Purge(<qmd:ingot:9>).ores([<ore:ingotIridium>]); // Iridium
Purge(<qmd:ingot:10>).ores([<ore:ingotPlatinum>]); // Platinum
Purge(<qmd:ingot>).furn().ores([<ore:ingotTungsten>]); // Tungsten
Purge(<theoneprobe:diamond_helmet_probe>);
Purge(<theoneprobe:gold_helmet_probe>);
Purge(<theoneprobe:iron_helmet_probe>);
Purge(<theoneprobe:probe_goggles>);
Purge(<libvulpes:productdust:1>).ores([<ore:dustIron>]).furn();
Purge(<libvulpes:productdust:2>).ores([<ore:dustGold>]).furn();
Purge(<libvulpes:productdust:3>).ores([<ore:dustSilicon>]).furn();
Purge(<libvulpes:productdust:4>).ores([<ore:dustCopper>]).furn();
Purge(<libvulpes:productdust:5>).ores([<ore:dustTin>]).furn();
Purge(<libvulpes:productdust:6>).ores([<ore:dustSteel>]).furn();
Purge(<libvulpes:productdust:9>).ores([<ore:dustAluminum>, <ore:dustAluminium>]).furn();
Purge(<libvulpes:productdust:10>).ores([<ore:dustIridium>]).furn();
Purge(<libvulpes:productingot:4>).ores([<ore:ingotCopper>]).furn();
Purge(<libvulpes:productingot:5>).ores([<ore:ingotTin>]).furn();
Purge(<libvulpes:productingot:6>).ores([<ore:ingotSteel>]).furn();
Purge(<libvulpes:productingot:9>).ores([<ore:ingotAluminum>, <ore:ingotAluminium>]).furn();
Purge(<libvulpes:productingot:10>).ores([<ore:ingotIridium>]).furn();
Purge(<libvulpes:productnugget:4>).ores([<ore:nuggetCopper>]).furn();
Purge(<libvulpes:productnugget:5>).ores([<ore:nuggetTin>]).furn();
Purge(<libvulpes:productnugget:6>).ores([<ore:nuggetSteel>]).furn();
Purge(<libvulpes:productnugget:9>).ores([<ore:nuggetAluminum>, <ore:nuggetAluminium>]).furn();
Purge(<libvulpes:productnugget:10>).ores([<ore:nuggetIridium>]).furn();
Purge(<libvulpes:ore0:4>).furn();
Purge(<libvulpes:ore0:5>).furn();
Purge(<libvulpes:ore0:9>).ores([<ore:oreAluminium>]).furn();
Purge(<libvulpes:ore0:10>).ores([<ore:oreIridium>]).furn();
Purge(<libvulpes:productrod:1>).ores([<ore:stickIron>]).furn();
Purge(<libvulpes:productrod:6>).ores([<ore:stickSteel>]).furn();
Purge(<advancedrocketry:concrete>).ores([<ore:concrete>]);
Purge(<actuallyadditions:block_grinder>);
Purge(<actuallyadditions:block_grinder_double>);
Purge(<actuallyadditions:item_dust>).ores([<ore:dustIron>]).furn();
Purge(<actuallyadditions:item_dust:1>).ores([<ore:dustGold>]).furn();
Purge(<actuallyadditions:item_dust:2>).ores([<ore:dustDiamond>]).furn();
Purge(<actuallyadditions:item_dust:4>).ores([<ore:dustLapis>]).furn();
Purge(<actuallyadditions:item_dust:6>).ores([<ore:dustCoal>]).furn();
Purge(<actuallyadditions:block_misc:5>).ores([<ore:blockCharcoal>]).furn();
Purge(<exnihilocreatio:block_end_cake>);
Purge(<plustic:alumitenugget>).ores([<ore:nuggetAlumite>]);
Purge(<plustic:alumiteingot>).ores([<ore:ingotAlumite>]);
Purge(<plustic:alumiteblock>).ores([<ore:blockAlumite>]);

// Purge saltpeter and sulfur
Purge(<bloodmagic:component:24>);
Purge(<bloodmagic:component:23>);

// TC nuggets
Purge(<thaumcraft:nugget:0>).ores([<ore:nuggetIron>]);
Purge(<thaumcraft:nugget:1>).ores([<ore:nuggetCopper>]);
Purge(<thaumcraft:nugget:2>).ores([<ore:nuggetTin>]);
Purge(<thaumcraft:nugget:3>).ores([<ore:nuggetSilver>]);
Purge(<thaumcraft:nugget:4>).ores([<ore:nuggetLead>]);

// *======= Metal Nuggets =======*

Purge(<immersiveengineering:metal:29>).ores([<ore:nuggetIron>]);
Purge(<immersiveengineering:metal:20>).ores([<ore:nuggetCopper>]);
Purge(<immersiveengineering:metal:21>).ores([<ore:nuggetAluminum>, <ore:nuggetAluminium>]);
Purge(<immersiveengineering:metal:22>).ores([<ore:nuggetLead>]);
Purge(<immersiveengineering:metal:23>).ores([<ore:nuggetSilver>]);
Purge(<immersiveengineering:metal:24>).ores([<ore:nuggetNickel>]);
Purge(<immersiveengineering:metal:26>).ores([<ore:nuggetConstantan>]);
Purge(<immersiveengineering:metal:27>).ores([<ore:nuggetElectrum>]);
Purge(<immersiveengineering:metal:28>).ores([<ore:nuggetSteel>]);
Purge(<extendedcrafting:material:128>).ores([<ore:nuggetDiamond>]);
Purge(<extendedcrafting:material:129>).ores([<ore:nuggetEmerald>]);
Purge(<opencomputers:material:29>).ores([<ore:chipDiamond>]); // Diamond nugget
Purge(<opencomputers:material>);

// Remove Refined storage cables
if (isNull(loadedMods['refinedstorage'])) {
  Purge(<immersivecables:coil_block:3>);
  Purge(<immersivecables:wire_coil:3>);
}

/* Inject_js(
(getUnchangedFurnaceRecipes()??[])
.filter((r) => isJEIBlacklisted(r.in_id, r.in_meta) && !isPurged(r.output))
.map(({output,input})=>[`furnaceRemove(${output}`,`, ${input});`])
) */
furnaceRemove(<minecraft:gold_ingot>                , <actuallyadditions:item_dust:1>);
furnaceRemove(<minecraft:diamond>                   , <actuallyadditions:item_dust:2>);
furnaceRemove(<minecraft:dye:4>                     , <actuallyadditions:item_dust:4>);
furnaceRemove(<appliedenergistics2:material:5>      , <actuallyadditions:item_dust:5>);
furnaceRemove(<minecraft:coal>                      , <actuallyadditions:item_dust:6>);
furnaceRemove(<minecraft:iron_ingot>                , <actuallyadditions:item_dust>);
furnaceRemove(<biomesoplenty:gem:7>                 , <biomesoplenty:gem_ore:7>);
furnaceRemove(<appliedenergistics2:material:5>      , <enderio:item_material:33>);
furnaceRemove(<exnihilocreatio:crook_clay>          , <exnihilocreatio:crook_clay_uncooked>);
furnaceRemove(<exnihilocreatio:item_ore_aluminium:3>, <exnihilocreatio:item_ore_aluminium:1>);
furnaceRemove(<exnihilocreatio:item_ore_aluminium:3>, <exnihilocreatio:item_ore_aluminium:2>);
furnaceRemove(<tconstruct:ingots:1>                 , <exnihilocreatio:item_ore_ardite:1>);
furnaceRemove(<tconstruct:ingots>                   , <exnihilocreatio:item_ore_cobalt:1>);
furnaceRemove(<exnihilocreatio:item_ore_copper:3>   , <exnihilocreatio:item_ore_copper:1>);
furnaceRemove(<exnihilocreatio:item_ore_copper:3>   , <exnihilocreatio:item_ore_copper:2>);
furnaceRemove(<minecraft:gold_ingot>                , <exnihilocreatio:item_ore_gold:1>);
furnaceRemove(<minecraft:gold_ingot>                , <exnihilocreatio:item_ore_gold:2>);
furnaceRemove(<minecraft:iron_ingot>                , <exnihilocreatio:item_ore_iron:1>);
furnaceRemove(<minecraft:iron_ingot>                , <exnihilocreatio:item_ore_iron:2>);
furnaceRemove(<exnihilocreatio:item_ore_lead:3>     , <exnihilocreatio:item_ore_lead:1>);
furnaceRemove(<exnihilocreatio:item_ore_lead:3>     , <exnihilocreatio:item_ore_lead:2>);
furnaceRemove(<exnihilocreatio:item_ore_nickel:3>   , <exnihilocreatio:item_ore_nickel:1>);
furnaceRemove(<exnihilocreatio:item_ore_nickel:3>   , <exnihilocreatio:item_ore_nickel:2>);
furnaceRemove(<exnihilocreatio:item_ore_silver:3>   , <exnihilocreatio:item_ore_silver:1>);
furnaceRemove(<exnihilocreatio:item_ore_silver:3>   , <exnihilocreatio:item_ore_silver:2>);
furnaceRemove(<exnihilocreatio:item_ore_tin:3>      , <exnihilocreatio:item_ore_tin:1>);
furnaceRemove(<exnihilocreatio:item_ore_tin:3>      , <exnihilocreatio:item_ore_tin:2>);
furnaceRemove(<thermalfoundation:material:128>      , <forestry:resources:1>);
furnaceRemove(<thermalfoundation:material:129>      , <forestry:resources:2>);
furnaceRemove(<minecraft:gold_ingot>                , <ic2:dust:7>);
furnaceRemove(<minecraft:iron_ingot>                , <ic2:dust:8>);
furnaceRemove(<immersiveengineering:metal:5>        , <ic2:resource:4>);
furnaceRemove(<iceandfire:silver_ingot>             , <iceandfire:silver_ore:*>);
furnaceRemove(<immersiveengineering:metal>          , <immersiveengineering:metal:9>);
furnaceRemove(<immersiveengineering:metal:1>        , <immersiveengineering:metal:10>);
furnaceRemove(<immersiveengineering:metal:2>        , <immersiveengineering:metal:11>);
furnaceRemove(<immersiveengineering:metal:3>        , <immersiveengineering:metal:12>);
furnaceRemove(<immersiveengineering:metal:4>        , <immersiveengineering:metal:13>);
furnaceRemove(<immersiveengineering:metal:6>        , <immersiveengineering:metal:15>);
furnaceRemove(<immersiveengineering:metal:7>        , <immersiveengineering:metal:16>);
furnaceRemove(<immersiveengineering:metal:8>        , <immersiveengineering:metal:17>);
furnaceRemove(<minecraft:iron_ingot>                , <immersiveengineering:metal:18>);
furnaceRemove(<minecraft:gold_ingot>                , <immersiveengineering:metal:19>);
furnaceRemove(<immersiveengineering:metal:1>        , <immersiveengineering:ore:1>);
furnaceRemove(<immersiveengineering:metal:2>        , <immersiveengineering:ore:2>);
furnaceRemove(<immersiveengineering:metal:3>        , <immersiveengineering:ore:3>);
furnaceRemove(<immersiveengineering:metal:4>        , <immersiveengineering:ore:4>);
furnaceRemove(<immersiveengineering:metal>          , <immersiveengineering:ore>);
furnaceRemove(<nuclearcraft:ingot:5>                , <jaopca:item_hunkboron>);
furnaceRemove(<nuclearcraft:ingot:6>                , <jaopca:item_hunklithium>);
furnaceRemove(<nuclearcraft:ingot:7>                , <jaopca:item_hunkmagnesium>);
furnaceRemove(<nuclearcraft:ingot:3>                , <jaopca:item_hunkthorium>);
furnaceRemove(<immersiveengineering:metal:5>        , <jaopca:item_hunkuranium>);
furnaceRemove(<thermalfoundation:material:128>      , <libvulpes:ore0:4>);
furnaceRemove(<thermalfoundation:material:129>      , <libvulpes:ore0:5>);
furnaceRemove(<minecraft:iron_ingot>                , <libvulpes:productdust:1>);
furnaceRemove(<minecraft:gold_ingot>                , <libvulpes:productdust:2>);
furnaceRemove(<thermalfoundation:material:128>      , <libvulpes:productdust:4>);
furnaceRemove(<thermalfoundation:material:129>      , <libvulpes:productdust:5>);
furnaceRemove(<thermalfoundation:material:132>      , <libvulpes:productdust:9>);
furnaceRemove(<thermalfoundation:material:135>      , <libvulpes:productdust:10>);
furnaceRemove(<mekanism:ingot:5>                    , <mekanism:oreblock:1>);
furnaceRemove(<mekanism:ingot:6>                    , <mekanism:oreblock:2>);
furnaceRemove(<thermalfoundation:material:129>      , <nuclearcraft:dust:1>);
furnaceRemove(<thermalfoundation:material:131>      , <nuclearcraft:dust:2>);
furnaceRemove(<immersiveengineering:metal:5>        , <nuclearcraft:dust:4>);
furnaceRemove(<thermalfoundation:material:128>      , <nuclearcraft:dust>);
furnaceRemove(<appliedenergistics2:material:5>      , <nuclearcraft:gem_dust:2>);
furnaceRemove(<thermalfoundation:material:129>      , <nuclearcraft:ore:1>);
furnaceRemove(<thermalfoundation:material:131>      , <nuclearcraft:ore:2>);
furnaceRemove(<immersiveengineering:metal:5>        , <nuclearcraft:ore:4>);
furnaceRemove(<thermalfoundation:material:128>      , <nuclearcraft:ore>);
furnaceRemove(<libvulpes:productingot:7>            , <qmd:dust:3>);
furnaceRemove(<tconstruct:ingots>                   , <qmd:dust:4>);
furnaceRemove(<minecraft:gold_ingot> * 3            , <thaumicwonders:eldritch_cluster:1>);
furnaceRemove(<thaumcraft:quicksilver> * 3          , <thaumicwonders:eldritch_cluster:6>);
furnaceRemove(<minecraft:quartz> * 4                , <thaumicwonders:eldritch_cluster:7>);
furnaceRemove(<thaumcraft:ingot:1> * 2              , <thaumicwonders:eldritch_cluster:8>);
furnaceRemove(<minecraft:iron_ingot> * 3            , <thaumicwonders:eldritch_cluster>);
/**/

// *======= Metal Blocks =======*
recipesRemove(<mekanism:basicblock:12>);
recipesRemove(<mekanism:basicblock:1>);
recipesRemove(<mekanism:basicblock:3>);
recipesRemove(<mekanism:basicblock:5>);
recipesRemove(<mekanism:basicblock:13>);
recipesRemove(<forestry:resource_storage:3>);
recipesRemove(<forestry:resource_storage:1>);
recipesRemove(<forestry:resource_storage:2>);
recipesRemove(<tcomplement:storage>);
recipesRemove(<immersiveengineering:stone_decoration:3>);
recipesRemove(<immersiveengineering:storage>);
recipesRemove(<immersiveengineering:storage:1>);
recipesRemove(<immersiveengineering:storage:2>);
recipesRemove(<immersiveengineering:storage:3>);
recipesRemove(<immersiveengineering:storage:4>);
recipesRemove(<immersiveengineering:storage:7>);
recipesRemove(<immersiveengineering:storage:8>);
Purge(<ic2:ingot:1>).furn().ores([<ore:ingotBronze>]);
Purge(<ic2:ingot:2>).furn().ores([<ore:ingotCopper>]);
Purge(<ic2:ingot:3>).furn().ores([<ore:ingotLead>]);
Purge(<ic2:ingot:4>).furn().ores([<ore:ingotSilver>]);
Purge(<ic2:ingot:6>).furn().ores([<ore:ingotTin>]);
Purge(<ic2:ingot:8>).ores([<ore:ingotUranium>]);
Purge(<ic2:resource:5>).ores([<ore:blockBronze>]); // Bronze
recipesRemove(<ic2:ingot:5>);
// *============================*

Purge(<jaopca:item_dusttinyanglesite>).ores([<ore:dustTinyAnglesite>]);
Purge(<jaopca:item_dusttinybenitoite>).ores([<ore:dustTinyBenitoite>]);
Purge(<contenttweaker:item_ore_anglesite:1>).ores([<ore:oreAnglesite>]);
Purge(<contenttweaker:item_ore_anglesite:2>).ores([<ore:dustAnglesite>]);
Purge(<contenttweaker:item_ore_anglesite:3>).furn().ores([<ore:ingotAnglesite>]);
Purge(<contenttweaker:item_ore_benitoite:1>).ores([<ore:oreBenitoite>]);
Purge(<contenttweaker:item_ore_benitoite:2>).ores([<ore:dustBenitoite>]);
Purge(<contenttweaker:item_ore_benitoite:3>).furn().ores([<ore:ingotBenitoite>]);
Purge(<contenttweaker:item_ore_tungsten:1>).ores([<ore:oreTungsten>]);
Purge(<contenttweaker:item_ore_tungsten:2>).ores([<ore:dustTungsten>]);
Purge(<contenttweaker:item_ore_tungsten:3>).furn().ores([<ore:ingotTungsten>]);
Purge(<jaopca:block_blocktungsten>).ores([<ore:blockTungsten>]);
Purge(<jaopca:item_nuggettungsten>).ores([<ore:nuggetTungsten>]);
Purge(<enderio:item_owl_egg>);
Purge(<enderio:item_material:9>);
Purge(<thermalfoundation:material:22>).ores([<ore:gearWood>]);
Purge(<thermalfoundation:material:656>);
Purge(<ae2stuff:visualiser>);
Purge(<itemfilters:filter>);
Purge(<excompressum:ore_smasher>);
Purge(<forestry:gear_bronze>).ores([<ore:gearBronze>]);
Purge(<forestry:gear_copper>).ores([<ore:gearCopper>]);
Purge(<forestry:gear_tin>).ores([<ore:gearTin>]);
Purge(<forestry:capsule>);
Purge(<forestry:can>);
Purge(<forestry:refractory>);
Purge(<appliedenergistics2:material:40>).ores([<ore:gearWood>]);
Purge(<mysticalagriculture:chunk>);
Purge(<mysticalagriculture:chunk:1>);
Purge(<mysticalagriculture:chunk:2>);
Purge(<mysticalagriculture:chunk:3>);
Purge(<mysticalagriculture:chunk:4>);
Purge(<mysticalagriculture:crafting:48>);
Purge(<mysticalagradditions:insanium:4>);
Purge(<mysticalagradditions:stuff:69>);
Purge(<immersiveengineering:ore:1>).ores([<ore:oreAluminum>, <ore:oreAluminium>]);
Purge(<betteranimalsplus:cheese>);

// Pams replacements
Purge(<harvestcraft:chilipepperitem>).ores([<ore:cropChilipepper>, <ore:listAllpepper>]);
Purge(<harvestcraft:chilipepperseeditem>).ores([<ore:listAllseed>, <ore:seedChilipepper>]);
Purge(<harvestcraft:coffeebeanitem>).ores([<ore:cropCoffee>]);
Purge(<harvestcraft:coffeeseeditem>).ores([<ore:seedCoffee>, <ore:listAllseed>]);
Purge(<harvestcraft:grapeitem>).ores([<ore:listAllfruit>, <ore:cropGrape>]);
Purge(<harvestcraft:grapeseeditem>).ores([<ore:listAllseed>, <ore:seedGrape>]);
Purge(<harvestcraft:olive_sapling>).ores([<ore:treeSapling>]);
Purge(<harvestcraft:oliveitem>).ores([<ore:cropOlive>]);
Purge(<harvestcraft:pamolive>);
Purge(<harvestcraft:tomatoitem>).ores([<ore:listAllveggie>, <ore:cropTomato>]);
Purge(<harvestcraft:tomatoseeditem>).ores([<ore:listAllseed>, <ore:seedTomato>]);
Purge(<harvestcraft:beanseeditem>).ores([<ore:listAllseed>, <ore:seedBean>]);
Purge(<harvestcraft:beanitem>).ores([<ore:cropBean>, <ore:listAllveggie>]);
Purge(<harvestcraft:riceseeditem>).ores([<ore:seedRice>, <ore:listAllseed>]);
Purge(<harvestcraft:riceitem>).ores([<ore:cropRice>]);
Purge(<harvestcraft:cocoapowderitem>).ores([<ore:foodCocoapowder>]);
Purge(<harvestcraft:chocolatebaritem>).ores([<ore:foodChocolatebar>]);

Purge(<thaumicwonders:eldritch_cluster:0>);
Purge(<thaumicwonders:eldritch_cluster:1>);
Purge(<thaumicwonders:eldritch_cluster:2>);
Purge(<thaumicwonders:eldritch_cluster:3>);
Purge(<thaumicwonders:eldritch_cluster:4>);
Purge(<thaumicwonders:eldritch_cluster:5>);
Purge(<thaumicwonders:eldritch_cluster:6>);
Purge(<thaumicwonders:eldritch_cluster:7>);
Purge(<thaumicwonders:eldritch_cluster:8>);

// Gears
val gearsToRemove = [
  <thermalfoundation:material:23>,
  <thermalfoundation:material:24>,
  <thermalfoundation:material:25>,
  <thermalfoundation:material:26>,
  <thermalfoundation:material:27>,
  <thermalfoundation:material:256>,
  <thermalfoundation:material:257>,
  <thermalfoundation:material:258>,
  <thermalfoundation:material:259>,
  <thermalfoundation:material:260>,
  <thermalfoundation:material:261>,
  <thermalfoundation:material:262>,
  <thermalfoundation:material:263>,
  <thermalfoundation:material:264>,
  <thermalfoundation:material:288>,
  <thermalfoundation:material:289>,
  <thermalfoundation:material:290>,
  <thermalfoundation:material:291>,
  <thermalfoundation:material:292>,
  <thermalfoundation:material:293>,
  <thermalfoundation:material:294>,
  <thermalfoundation:material:295>,
  <redstonearsenal:material:96>,
  <jaopca:item_geardraconium>,
] as IItemStack[];

for item in gearsToRemove {
  recipesRemove(item);
}

// Connector Upgrade Kit causing dupes and dissapearing of main hand when used from offhand
Purge(<xnet:connector_upgrade>);
