import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;
import thaumcraft.aspect.CTAspectStack;

#ignoreBracketErrors

#modloaded thaumcraft

/*
 █████╗ ███████╗██████╗ ███████╗ ██████╗████████╗███████╗
██╔══██╗██╔════╝██╔══██╗██╔════╝██╔════╝╚══██╔══╝██╔════╝
███████║███████╗██████╔╝█████╗  ██║        ██║   ███████╗
██╔══██║╚════██║██╔═══╝ ██╔══╝  ██║        ██║   ╚════██║
██║  ██║███████║██║     ███████╗╚██████╗   ██║   ███████║
╚═╝  ╚═╝╚══════╝╚═╝     ╚══════╝ ╚═════╝   ╚═╝   ╚══════╝
*/

/*
#######################################################
____ ____ ___ _  _ ____ _    _    _   _    ____ ___  ___  _ ___ _ ____ _  _ ____ 
|__| |     |  |  | |__| |    |     \_/     |__| |  \ |  \ |  |  | |  | |\ | [__  
|  | |___  |  |__| |  | |___ |___   |      |  | |__/ |__/ |  |  | |__| | \| ___] 
                                                                                 
#######################################################
*/


/*
#######################################################
____ _  _ _ _  _ _  _ ____ 
|__| |\ | | |\/| |  | [__  
|  | | \| | |  | |__| ___] 
                           
#######################################################
*/

<animus:component>                              .setAspects(<aspect:praecantatio>*5  ,<aspect:fabrico>*10); #reagent builder T1
<animus:component:1>                            .setAspects(<aspect:praecantatio>*15 ,Aspect.imperium*20); #reagent chains T3
<animus:component:2>                            .setAspects(<aspect:praecantatio>*15 ,<aspect:rattus>*40); #reagent consumption T3
<animus:component:3>                            .setAspects(<aspect:praecantatio>*10 ,<aspect:desiderium>*30); #reagent leech T2
<animus:component:4>                            .setAspects(<aspect:praecantatio>*10 ,<aspect:potentia>*50); #reagent storm T2
<animus:component:5>                            .setAspects(<aspect:praecantatio>*20 ,<aspect:motus>*20); #reagent acquisition T4

<animus:sigil_builder>                          .setAspects(<aspect:praecantatio>*5  ,<aspect:sanguis>*5         ,<aspect:fabrico>*10); #sigil builder T1
<animus:sigil_chains>                           .setAspects(<aspect:praecantatio>*15 ,<aspect:sanguis>*30        ,Aspect.imperium*30); #sigil chains T3
<animus:sigil_consumption>                      .setAspects(<aspect:praecantatio>*15 ,<aspect:sanguis>*30        ,<aspect:rattus>*30); #sigil consumption T3
<animus:sigil_leech>                            .setAspects(<aspect:praecantatio>*10 ,<aspect:sanguis>*15        ,<aspect:desiderium>*20); #sigil leech T2
<animus:sigil_storm>                            .setAspects(<aspect:praecantatio>*10 ,<aspect:sanguis>*15        ,<aspect:potentia>*50); #sigil storm T2
<animus:sigil_transposition>                    .setAspects(<aspect:praecantatio>*20 ,<aspect:sanguis>*60        ,<aspect:motus>*40); #sigil acquisition T4

/*
#######################################################
____ ___  ___  _    _ ____ ___     ____ _  _ ____ ____ ____ ____ ___ _ ____ ____ 
|__| |__] |__] |    | |___ |  \    |___ |\ | |___ |__/ | __ |___  |  | |    [__  
|  | |    |    |___ | |___ |__/    |___ | \| |___ |  \ |__] |___  |  | |___ ___] 
                                                                                 
#######################################################
*/

<appliedenergistics2:quartz_block>              .setAspects(<aspect:vitreus>*30     ,<aspect:potentia>*15); #Certus quartz block
<appliedenergistics2:material:10>               .setAspects(<aspect:vitreus>*10     ,<aspect:potentia>*10       ,<aspect:ordo>*10); #Pure certus quartz

/*
#######################################################
____ ____ ___ ____ ____ _       ____ ____ ____ ____ ____ ____ _   _ 
|__| [__   |  |__/ |__| |       [__  |  | |__/ |    |___ |__/  \_/  
|  | ___]  |  |  \ |  | |___    ___] |__| |  \ |___ |___ |  \   |   
                                                                    
#######################################################
*/

<astralsorcery:blockmarble>                     .setAspects(<aspect:terra>*4      ,<aspect:ordo>*2); #marble
<astralsorcery:blockblackmarble>                .setAspects(<aspect:terra>*4        ,<aspect:potentia>*1); #sooty marble

<astralsorcery:itemusabledust>                  .setAspects(<aspect:lux>*2          ,<aspect:sensus>*1); #illumination powder
<astralsorcery:itemusabledust:1>                .setAspects(<aspect:tenebrae>*10    ,<aspect:potentia>*20); #nocturnal powder
<astralsorcery:itemcraftingcomponent:4>         .setAspects(<aspect:praecantatio>*5 ,<aspect:ordo>*10); #resonating gem
<astralsorcery:blockinfusedwood>                .setAspects(<aspect:herba>*20        ,<aspect:praecantatio>*1); #infused wood
<astralsorcery:blockinfusedwood:6>              .setAspects(<aspect:herba>*20        ,<aspect:praecantatio>*1); #vibrant infused wood

<astralsorcery:itemcraftingcomponent:3>         .setAspects(<aspect:praecantatio>*10,<aspect:auram>*5           ,<aspect:vitreus>*10); #glass lens and bellow collores lenses
<astralsorcery:itemcoloredlens>                 .setAspects(<aspect:praecantatio>*10,<aspect:auram>*5           ,<aspect:vitreus>*10    ,<aspect:ignis>*20); #ignition
<astralsorcery:itemcoloredlens:1>               .setAspects(<aspect:praecantatio>*10,<aspect:auram>*5           ,<aspect:vitreus>*10    ,<aspect:exanimis>*20); #break
<astralsorcery:itemcoloredlens:2>               .setAspects(<aspect:praecantatio>*10,<aspect:auram>*5           ,<aspect:vitreus>*10    ,<aspect:herba>*20); #growth
<astralsorcery:itemcoloredlens:3>               .setAspects(<aspect:praecantatio>*10,<aspect:auram>*5           ,<aspect:vitreus>*10    ,<aspect:aversio>*20); #damage (emotional)
<astralsorcery:itemcoloredlens:4>               .setAspects(<aspect:praecantatio>*10,<aspect:auram>*5           ,<aspect:vitreus>*10    ,<aspect:victus>*20); #regeneration
<astralsorcery:itemcoloredlens:5>               .setAspects(<aspect:praecantatio>*10,<aspect:auram>*5           ,<aspect:vitreus>*10    ,<aspect:motus>*20); #push
<astralsorcery:itemcoloredlens:6>               .setAspects(<aspect:praecantatio>*10,<aspect:auram>*5           ,<aspect:vitreus>*10    ,<aspect:spiritus>*20); #spectral

<astralsorcery:itemshiftingstar:*>              .setAspects(<aspect:praecantatio>*20); #shifting star

<astralsorcery:itemrockcrystalsimple>           .setAspects(<aspect:praecantatio>*5 ,<aspect:ordo>*10           ,<aspect:vitreus>*20);                      #rock crystal
<astralsorcery:blockcustomore>                  .setAspects(<aspect:praecantatio>*5 ,<aspect:ordo>*50           ,<aspect:vitreus>*50    ,<aspect:terra>*5); #rock crystal ore
<astralsorcery:itemcelestialcrystal>            .setAspects(<aspect:praecantatio>*20,<aspect:ordo>*10           ,<aspect:vitreus>*20    ,<aspect:tenebrae>*10); #celestial crystal
<astralsorcery:blockcelestialcrystals:4>        .setAspects(<aspect:praecantatio>*50,<aspect:ordo>*50           ,<aspect:vitreus>*100   ,<aspect:tenebrae>*50); #celestial crystal cluster
<astralsorcery:itemperkgem>                     .setAspects(<aspect:praecantatio>*20,<aspect:ordo>*10           ,<aspect:vitreus>*20    ,<aspect:sensus>*10); #orium gem (blue)
<astralsorcery:blockgemcrystals:2>              .setAspects(<aspect:praecantatio>*50,<aspect:ordo>*50           ,<aspect:vitreus>*100   ,<aspect:sensus>*50); #^that ore
<astralsorcery:itemperkgem:1>                   .setAspects(<aspect:praecantatio>*20,<aspect:ordo>*10           ,<aspect:vitreus>*20    ,<aspect:lux>*10); #ilium gem (orange)
<astralsorcery:blockgemcrystals:3>              .setAspects(<aspect:praecantatio>*50,<aspect:ordo>*50           ,<aspect:vitreus>*100   ,<aspect:lux>*50); #^that ore
<astralsorcery:itemperkgem:2>                   .setAspects(<aspect:praecantatio>*20,<aspect:ordo>*10           ,<aspect:vitreus>*20    ,<aspect:potentia>*10); #fengarum gem (white)
<astralsorcery:blockgemcrystals:4>              .setAspects(<aspect:praecantatio>*50,<aspect:ordo>*50           ,<aspect:vitreus>*100   ,<aspect:potentia>*50); #^that ore
<astralsorcery:blockcollectorcrystal>           .setAspects(<aspect:praecantatio>*30,<aspect:ordo>*50           ,<aspect:vitreus>*40);                          #collector crystal
<astralsorcery:blockcelestialcollectorcrystal>  .setAspects(<aspect:praecantatio>*100,<aspect:ordo>*100           ,<aspect:vitreus>*200 ,<aspect:tenebrae>*100); #celestial collector crystal

<astralsorcery:blockaltar>                      .setAspects(<aspect:praecantatio>*5 ,<aspect:fabrico>*10        ,<aspect:ordo>*5); #Altar T1
<astralsorcery:blockaltar:1>                    .setAspects(<aspect:praecantatio>*10,<aspect:fabrico>*20        ,<aspect:ordo>*20); #T2
<astralsorcery:blockaltar:2>                    .setAspects(<aspect:praecantatio>*50,<aspect:fabrico>*30        ,<aspect:ordo>*50); #T3
<astralsorcery:blockaltar:3>                    .setAspects(<aspect:praecantatio>*100,<aspect:fabrico>*40       ,<aspect:ordo>*100      ,<aspect:sanguis>*50); #T4

<astralsorcery:blockworldilluminator>           .setAspects(<aspect:lux>*5          ,<aspect:ordo>*5            ,<aspect:vitreus>*10); #Cave illuminator
<astralsorcery:blockattunementrelay>            .setAspects(<aspect:praecantatio>*10,<aspect:auram>*5           ,<aspect:permutatio>*5); #spectral realy
<astralsorcery:blocklens>                       .setAspects(<aspect:praecantatio>*10,<aspect:auram>*10          ,<aspect:ordo>*5        ,<aspect:vitreus>*20); #Lens
<astralsorcery:blockmachine:1>                  .setAspects(<aspect:terra>*5        ,<aspect:fabrico>*5         ,<aspect:machina>*5); #grindstone
<astralsorcery:itemconstellationpaper>          .setAspects(<aspect:praecantatio>*5 ,<aspect:cognitio>*20       ,<aspect:ordo>*10); #constelation paper
<astralsorcery:itemknowledgeshare>              .setAspects(<aspect:praecantatio>*5 ,<aspect:cognitio>*20       ,<aspect:ordo>*10); #scroll of written knowledge
<astralsorcery:blockprism>                      .setAspects(<aspect:praecantatio>*20,<aspect:vitreus>*30        ,<aspect:ordo>*30); #primslens
<astralsorcery:blockwell>                       .setAspects(<aspect:praecantatio>*5 ,<aspect:aqua>*10           ,<aspect:ordo>*5); #lightwell
<astralsorcery:blockbore>                       .setAspects(<aspect:praecantatio>*20,<aspect:desiderium>*20     ,<aspect:ordo>*20); #evershifting fountain
<astralsorcery:blockborehead>                   .setAspects(<aspect:praecantatio>*10,<aspect:desiderium>*20     ,<aspect:ordo>*15); #neromantic prime
<astralsorcery:blockborehead:1>                 .setAspects(<aspect:praecantatio>*10,<aspect:desiderium>*20     ,<aspect:tenebrae>*15); #fysallidic prime
<astralsorcery:blockrituallink>                 .setAspects(<aspect:praecantatio>*5 ,<aspect:vitreus>*10        ,<aspect:ordo>*5); #ritual anchor

<astralsorcery:itemsextant>                     .setAspects(<aspect:praecantatio>*5 ,<aspect:sensus>*10         ,<aspect:desiderium>*5); #sextant
<astralsorcery:itemhandtelescope>               .setAspects(<aspect:praecantatio>*10,<aspect:sensus>*20         ,<aspect:desiderium>*10); #looking glass
<astralsorcery:blockmachine>                    .setAspects(<aspect:praecantatio>*5 ,<aspect:sensus>*10         ,<aspect:desiderium>*20); #telescope
<astralsorcery:blockobservatory>                .setAspects(<aspect:praecantatio>*50,<aspect:sensus>*50         ,Aspect.visum*30      ,<aspect:tenebrae>*20); #observatory

<astralsorcery:blockcelestialgateway>           .setAspects(<aspect:praecantatio>*10,<aspect:alienis>*20        ,<aspect:motus>*50); #celestial gateway
<astralsorcery:blockstarlightinfuser>           .setAspects(<aspect:praecantatio>*10,<aspect:permutatio>*20     ,<aspect:ordo>*20); #starlight infuser
<astralsorcery:blockattunementaltar>            .setAspects(<aspect:praecantatio>*10,<aspect:ordo>*10           ,<aspect:desiderium>*20); #attument altar
<astralsorcery:blockmapdrawingtable>            .setAspects(<aspect:praecantatio>*20,<aspect:sensus>*10         ,<aspect:desiderium>*20 ,Aspect.imperium*10); #stellar refraction table
<astralsorcery:blockchalice>                    .setAspects(<aspect:praecantatio>*10,<aspect:tenebrae>*10       ,<aspect:desiderium>*20); #containment chalice
<astralsorcery:blockritualpedestal>             .setAspects(<aspect:praecantatio>*10,<aspect:ordo>*10           ,<aspect:desiderium>*20); #ritual pedestal

<astralsorcery:itemlinkingtool>                 .setAspects(<aspect:praecantatio>*5 ,<aspect:instrumentum>*10   ,<aspect:vitreus>*10); #linking tool
<astralsorcery:itemwand>                        .setAspects(<aspect:praecantatio>*5 ,<aspect:instrumentum>*10   ,<aspect:vitreus>*10); #resonating wand
<astralsorcery:itemilluminationwand>            .setAspects(<aspect:praecantatio>*10,<aspect:lux>*20            ,<aspect:vitreus>*20); #illumination wand
<astralsorcery:iteminfusedglass>                .setAspects(<aspect:praecantatio>*20,<aspect:auram>*10          ,<aspect:vitreus>*20    ,<aspect:ordo>*20); #infused glass
<astralsorcery:itemskyresonator>                .setAspects(<aspect:sensus>*10      ,<aspect:ordo>*5            ,<aspect:desiderium>*10); #fosic resonator
<astralsorcery:itemperkseal>                    .setAspects(<aspect:praecantatio>*10,<aspect:tenebrae>*10       ,<aspect:potentia>*20); #sealing sigil

<astralsorcery:itemenchantmentamulet>           .setAspects(<aspect:praecantatio>*30,<aspect:tenebrae>*10       ,<aspect:vitreus>*10); #resplendent prism


/*
#######################################################
___  _    ____ ____ ___  _  _ ____ ____ _ ____ 
|__] |    |  | |  | |  \ |\/| |__| | __ | |    
|__] |___ |__| |__| |__/ |  | |  | |__] | |___ 
                                               
#######################################################
*/

<bloodmagic:slate>                              .setAspects(<aspect:terra>*5        ,<aspect:sanguis>*5); #slate blank
<bloodmagic:slate:1>                            .setAspects(<aspect:terra>*5        ,<aspect:sanguis>*15); #slate reinforced
<bloodmagic:slate:2>                            .setAspects(<aspect:terra>*5        ,<aspect:sanguis>*30); #slate imbued
<bloodmagic:slate:3>                            .setAspects(<aspect:terra>*5        ,<aspect:sanguis>*66); #slate demonic
<bloodmagic:slate:4>                            .setAspects(<aspect:terra>*5        ,<aspect:sanguis>*100); #slate ethernal

<bloodmagic:blood_shard>                        .setAspects(<aspect:mortuus>*10     ,<aspect:exanimis>*10    ,<aspect:sanguis>*10); #weak blood shard
<bloodmagic:blood_shard:1>                      .setAspects(Aspect.caeles*30      ,Aspect.infernum*50    ,<aspect:sanguis>*20); #demon blood shard

<bloodmagic:activation_crystal>                 .setAspects(<aspect:praecantatio>*10,<aspect:desiderium>*20  ,<aspect:sanguis>*20); #weak activation crystal
<bloodmagic:activation_crystal:1>               .setAspects(<aspect:praecantatio>*40,<aspect:desiderium>*30  ,<aspect:sanguis>*50); #awekaned activation crystal

<bloodmagic:blood_orb:*>                                        .setAspects(<aspect:spiritus>*40); #soulbinded orbs
<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:weak"})        .setAspects(<aspect:praecantatio>*10  ,<aspect:desiderium>*10   ,<aspect:sanguis>*10); #orb tier 1
<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:apprentice"})  .setAspects(<aspect:praecantatio>*20  ,<aspect:victus>*10       ,<aspect:sanguis>*25); #orb tier 2
<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:magician"})    .setAspects(<aspect:praecantatio>*30  ,<aspect:metallum>*50     ,<aspect:sanguis>*50); #orb tier 3
<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:master"})      .setAspects(<aspect:praecantatio>*40  ,<aspect:mortuus>*20      ,<aspect:sanguis>*80); #orb tier 4
<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:archmage"})    .setAspects(<aspect:praecantatio>*50  ,<aspect:ordo>*100        ,<aspect:sanguis>*100); #orb tier 5
<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:transcendent"}).setAspects(<aspect:praecantatio>*100 ,Aspect.caeles*100      ,<aspect:sanguis>*300); #orb tier 6

<bloodmagic:soul_snare>                         .setAspects(<aspect:vinculum>*3     ,Aspect.imperium*3     ,Aspect.ventus*1); #rudimentary snare
<bloodmagic:arcane_ashes:*>                     .setAspects(<aspect:potentia>*10    ,<aspect:ignis>*10       ,Aspect.exitium*5); #arcane ashes

<bloodmagic:soul_forge>                         .setAspects(<aspect:instrumentum>*20,<aspect:spiritus>*30    ,<aspect:praecantatio>*15); #rudimentary snare
<bloodmagic:demon_pylon>                        .setAspects(Aspect.infernum*30    ,<aspect:spiritus>*20    ,<aspect:desiderium>*20); #rudimentary snare
<bloodmagic:demon_crucible>                     .setAspects(Aspect.infernum*30    ,<aspect:spiritus>*20    ,Aspect.fluctus*15); #rudimentary snare
<bloodmagic:demon_crystallizer>                 .setAspects(Aspect.infernum*30    ,<aspect:spiritus>*20    ,Aspect.fluctus*15); #rudimentary snare
<bloodmagic:alchemy_table>                      .setAspects(<aspect:alkimia>*25     ,<aspect:ordo>*20        ,<aspect:praecantatio>*20); #rudimentary snare
<bloodmagic:altar>                              .setAspects(<aspect:terra>*15       ,<aspect:praecantatio>*10,<aspect:aversio>*30); #rudimentary snare

<bloodmagic:monster_soul>                       .setAspects(<aspect:spiritus>*2     ,Aspect.infernum*2);                       #demonic will
<bloodmagic:monster_soul:1>                     .setAspects(<aspect:spiritus>*2     ,Aspect.infernum*2     ,<aspect:alkimia>*1); #corrosive
<bloodmagic:monster_soul:2>                     .setAspects(<aspect:spiritus>*2     ,Aspect.infernum*2     ,Aspect.exitium*1); #destructive
<bloodmagic:monster_soul:3>                     .setAspects(<aspect:spiritus>*2     ,Aspect.infernum*2     ,<aspect:mortuus>*1); #vengeful
<bloodmagic:monster_soul:4>                     .setAspects(<aspect:spiritus>*2     ,Aspect.infernum*2     ,<aspect:alienis>*1); #steadfast

<bloodmagic:item_demon_crystal>                 .setAspects(<aspect:spiritus>*30    ,Aspect.infernum*25);                       #demonic will crystal
<bloodmagic:item_demon_crystal:1>               .setAspects(<aspect:spiritus>*30    ,Aspect.infernum*25    ,<aspect:alkimia>*20); #corrosive
<bloodmagic:item_demon_crystal:2>               .setAspects(<aspect:spiritus>*30    ,Aspect.infernum*25    ,Aspect.exitium*20); #destructive
<bloodmagic:item_demon_crystal:3>               .setAspects(<aspect:spiritus>*30    ,Aspect.infernum*25    ,<aspect:mortuus>*20); #vengeful
<bloodmagic:item_demon_crystal:4>               .setAspects(<aspect:spiritus>*30    ,Aspect.infernum*25    ,<aspect:alienis>*20); #steadfast

<bloodmagic:sentient_sword>                     .setAspects(<aspect:spiritus>*20    ,<aspect:aversio>*30);
<bloodmagic:sentient_bow>                       .setAspects(<aspect:spiritus>*20    ,<aspect:aversio>*15     ,Aspect.ventus*15);
<bloodmagic:sentient_axe>                       .setAspects(<aspect:spiritus>*20    ,<aspect:instrumentum>*20);
<bloodmagic:sentient_pickaxe>                   .setAspects(<aspect:spiritus>*20    ,<aspect:instrumentum>*20);
<bloodmagic:sentient_shovel>                    .setAspects(<aspect:spiritus>*20    ,<aspect:instrumentum>*20);

<bloodmagic:sacrificial_dagger>                 .setAspects(<aspect:alienis>*5      ,<aspect:aversio>*5      ,<aspect:mortuus>*10);
<bloodmagic:dagger_of_sacrifice>                .setAspects(<aspect:sanguis>*15     ,<aspect:instrumentum>*10,<aspect:aversio>*10);

<bloodmagic:component:8>                        .setAspects(<aspect:praecantatio>*5  ,<aspect:aqua>*10); #reagent binding
<bloodmagic:sigil_whirlwind>                    .setAspects(<aspect:praecantatio>*5  ,<aspect:sanguis>*5   ,<aspect:aer>*20); #sigil wirldwind
<bloodmagic:component:29>                       .setAspects(<aspect:praecantatio>*5  ,<aspect:alkimia>*5  ,<aspect:potentia>*10); #simple power catalyst
<bloodmagic:component:28>                       .setAspects(<aspect:praecantatio>*5  ,<aspect:alkimia>*5  ,<aspect:sensus>*10); #simple lengthening catalyst

# TIERED REAGENTS AND SIGILS
# Tier 1

<bloodmagic:component>                          .setAspects(<aspect:praecantatio>*5  ,<aspect:aqua>*10); #reagent water
<bloodmagic:component:1>                        .setAspects(<aspect:praecantatio>*5  ,<aspect:ignis>*10); #reagent lava

<bloodmagic:sigil_water>                        .setAspects(<aspect:praecantatio>*5  ,<aspect:sanguis>*5     ,<aspect:aqua>*10); #sigil water
<bloodmagic:sigil_lava>                         .setAspects(<aspect:praecantatio>*5  ,<aspect:sanguis>*5     ,<aspect:ignis>*10); #sigil lava
<bloodmagic:sigil_divination>                   .setAspects(<aspect:praecantatio>*5  ,<aspect:sanguis>*5     ,<aspect:cognitio>*10); #sigil divination

#Tier 2

<bloodmagic:component:5>                        .setAspects(<aspect:praecantatio>*10  ,<aspect:herba>*20); #reagent growth
<bloodmagic:component:31>                       .setAspects(<aspect:praecantatio>*10  ,<aspect:praecantatio>*20); #reagent elasticy
<bloodmagic:component:2>                        .setAspects(<aspect:praecantatio>*10  ,<aspect:volatus>*20); #reagent air
<bloodmagic:component:7>                        .setAspects(<aspect:praecantatio>*10  ,<aspect:sensus>*20); #reagent sight
<bloodmagic:component:3>                        .setAspects(<aspect:praecantatio>*10  ,Aspect.exitium*20); #reagent mining
<bloodmagic:component:32>                       .setAspects(<aspect:praecantatio>*10  ,<aspect:gelum>*20); #reagent frost
<bloodmagic:component:4>                        .setAspects(<aspect:praecantatio>*10  ,<aspect:vacuos>*20); #reagent void

<bloodmagic:sigil_green_grove>                  .setAspects(<aspect:praecantatio>*10  ,<aspect:sanguis>*15   ,<aspect:herba>*20); #sigil growth
<bloodmagic:sigil_bounce>                       .setAspects(<aspect:praecantatio>*10  ,<aspect:sanguis>*15   ,<aspect:praemunio>*20); #sigil elasticy
<bloodmagic:sigil_air>                          .setAspects(<aspect:praecantatio>*10  ,<aspect:sanguis>*15   ,<aspect:volatus>*20); #sigil air
<bloodmagic:sigil_seer>                         .setAspects(<aspect:praecantatio>*10  ,<aspect:sanguis>*15   ,<aspect:sensus>*20); #sigil sight
<bloodmagic:sigil_fast_miner>                   .setAspects(<aspect:praecantatio>*10  ,<aspect:sanguis>*15   ,Aspect.exitium*20); #sigil mining
<bloodmagic:sigil_frost>                        .setAspects(<aspect:praecantatio>*10  ,<aspect:sanguis>*15   ,<aspect:gelum>*20); #sigil frost
<bloodmagic:sigil_void>                         .setAspects(<aspect:praecantatio>*10  ,<aspect:sanguis>*15   ,<aspect:vacuos>*20); #sigil void

#Tier 3

<bloodmagic:component:12>                       .setAspects(<aspect:praecantatio>*15  ,<aspect:metallum>*30); #reagent magnetism
<bloodmagic:component:27>                       .setAspects(<aspect:praecantatio>*15  ,<aspect:vinculum>*30); #reagent holding
<bloodmagic:component:11>                       .setAspects(<aspect:praecantatio>*15  ,<aspect:lux>*30); #reagent blood lamp
<bloodmagic:component:30>                       .setAspects(<aspect:praecantatio>*15  ,<aspect:bestia>*30); #reagent claw
<bloodmagic:component:6>                        .setAspects(<aspect:praecantatio>*15  ,<aspect:aer>*10,<aspect:ignis>*10,<aspect:terra>*10,<aspect:aqua>*10); #reagent elemental affinity

<bloodmagic:sigil_magnetism>                    .setAspects(<aspect:praecantatio>*15  ,<aspect:sanguis>*30   ,<aspect:metallum>*30); #sigil magnetism
<bloodmagic:sigil_holding>                      .setAspects(<aspect:praecantatio>*15  ,<aspect:sanguis>*30   ,<aspect:vinculum>*30); #sigil holding
<bloodmagic:sigil_blood_light>                  .setAspects(<aspect:praecantatio>*15  ,<aspect:sanguis>*30   ,<aspect:vacuos>*30); #sigil blood lamp
<bloodmagic:sigil_claw>                         .setAspects(<aspect:praecantatio>*15  ,<aspect:sanguis>*30   ,<aspect:bestia>*30); #sigil claw
<bloodmagic:sigil_elemental_affinity>           .setAspects(<aspect:praecantatio>*15  ,<aspect:sanguis>*30   ,<aspect:aer>*10,<aspect:ignis>*10,<aspect:terra>*10,<aspect:aqua>*10); #sigil elemental affinity

#Tier 4

<bloodmagic:component:18>                       .setAspects(<aspect:praecantatio>*20  ,<aspect:permutatio>*40); #reagent transposition
<bloodmagic:component:17>                       .setAspects(<aspect:praecantatio>*20  ,<aspect:alienis>*40); #reagent teleposition
<bloodmagic:component:9>                        .setAspects(<aspect:praecantatio>*20  ,<aspect:perditio>*40); #reagent supression
<bloodmagic:component:15>                       .setAspects(<aspect:praecantatio>*20  ,<aspect:spiritus>*40); #reagent phantom bridge
<bloodmagic:component:13>                       .setAspects(<aspect:praecantatio>*20  ,Aspect.ventus*40); #reagent haste
<bloodmagic:component:16>                       .setAspects(<aspect:praecantatio>*20  ,<aspect:tenebrae>*40); #reagent severance
<bloodmagic:component:14>                       .setAspects(<aspect:praecantatio>*20  ,<aspect:ordo>*40); #reagent compression

<bloodmagic:sigil_transposition>                .setAspects(<aspect:praecantatio>*20  ,<aspect:sanguis>*60   ,<aspect:permutatio>*40); #sigil transposition
<bloodmagic:sigil_teleposition>                 .setAspects(<aspect:praecantatio>*20  ,<aspect:sanguis>*60   ,<aspect:alienis>*40); #sigil teleposiotion
<bloodmagic:sigil_suppression>                  .setAspects(<aspect:praecantatio>*20  ,<aspect:sanguis>*60   ,<aspect:perditio>*40); #sigil supression
<bloodmagic:sigil_phantom_bridge>               .setAspects(<aspect:praecantatio>*20  ,<aspect:sanguis>*60   ,<aspect:spiritus>*40); #sigil phantom bridge
<bloodmagic:sigil_haste>                        .setAspects(<aspect:praecantatio>*20  ,<aspect:sanguis>*60   ,Aspect.ventus*40); #sigil haste
<bloodmagic:sigil_ender_severance>              .setAspects(<aspect:praecantatio>*20  ,<aspect:sanguis>*60   ,<aspect:tenebrae>*40); #sigil severance
<bloodmagic:sigil_compression>                  .setAspects(<aspect:praecantatio>*20  ,<aspect:sanguis>*60   ,<aspect:ordo>*40); #sigil compression

/*
#######################################################
___  ____ ___ ____ _  _ _ ____ 
|__] |  |  |  |__| |\ | | |__| 
|__] |__|  |  |  | | \| | |  | 
                               
#######################################################
*/

#Random
<botania:manaresource>                          .setAspects(<aspect:metallum>*10  ,<aspect:mana>*5); #manasteel
<botania:manaresource:1>                        .setAspects(<aspect:alienis>*10   ,<aspect:motus>*5           ,<aspect:mana>*10); #manapearl
<botania:manaresource:2>                        .setAspects(<aspect:vitreus>*15   ,<aspect:desiderium>*15     ,<aspect:mana>*10); #manadiamond
<botania:manaresource:4>                        .setAspects(<aspect:terra>*20     ,<aspect:praecantatio>*20   ,<aspect:mana>*10         ,<aspect:metallum>*10); #terrasteel
<botania:manaresource:7>                        .setAspects(<aspect:alienis>*5    ,<aspect:metallum>*10       ,<aspect:mana>*5); #elementium
<botania:manaresource:8>                        .setAspects(<aspect:alienis>*20   ,<aspect:mythus>*5          ,<aspect:mana>*10); #pixie dust
<botania:manaresource:9>                        .setAspects(<aspect:alienis>*10   ,<aspect:vitreus>*15        ,<aspect:mana>*10         ,<aspect:desiderium>*15); #dragon gem
<botania:manaresource:16>                       .setAspects(<aspect:bestia>*5     ,<aspect:fabrico>*2         ,<aspect:mana>*2); #mana string
<botania:manaresource:23>                       .setAspects(<aspect:potentia>*5   ,<aspect:mana>*5); #mana powder
<botania:manaresource:22>                       .setAspects(<aspect:praemunio>*10 ,<aspect:mana>*5); #manaweave cloth
<botania:manabottle:*>                          .setAspects(<aspect:mana>*10); #mana bottle
<botania:managlass>                             .setAspects(<aspect:vitreus>*5    ,<aspect:mana>*2); #mana glass
<botania:monocle>                               .setAspects(<aspect:sensus>*10    ,Aspect.visum*20          ,<aspect:mana>*6); #monocle
<botania:blacklotus>                            .setAspects(<aspect:alienis>*10   ,<aspect:ordo>*10           ,<aspect:mana>*15); #monocle
<botania:blacklotus:1>                          .setAspects(<aspect:alienis>*20   ,<aspect:ordo>*20           ,<aspect:mana>*50); #monocle
<botania:manaresource:5>                        .setAspects(Aspect.caeles*25    ,<aspect:ordo>*50           ,<aspect:alienis>*50); #gaia spirit
<botania:manaresource:14>                       .setAspects(Aspect.caeles*75    ,<aspect:ordo>*150          ,<aspect:mana>*20         ,<aspect:metallum>*10); #gaia ingot
<botania:manaresource:12>                       .setAspects(<aspect:potentia>*20  ,<aspect:permutatio>*20     ,<aspect:alienis>*15      ,<aspect:machina>*15, <aspect:mana>*10); #red string
<botania:storage>                               .setAspects(<aspect:metallum>*67  ,<aspect:mana>*33); #manasteel block
<botania:manacookie>                            .setAspects(<aspect:victus>*20    ,<aspect:mana>*25); #mana cookie
<botania:openbucket>                            .setAspects(<aspect:metallum>*20  ,<aspect:mana>*10           ,<aspect:alienis>*10      ,<aspect:vacuos>*15);
<botania:runealtar>                             .setAspects(<aspect:mana>*10      ,<aspect:fabrico>*20);                                                                              #runic altar
<botania:manatablet>                          .setAspects(<aspect:mana>*10      ,<aspect:instrumentum>*20   ,Aspect.imperium*20);                                                 #mana tablet
<botania:distributor>                           .setAspects(<aspect:mana>*10      ,<aspect:machina>*5         ,<aspect:terra>*30);
<botania:foresteye>                             .setAspects(<aspect:mana>*15      ,<aspect:sensus>*15         ,<aspect:terra>*30);
<botania:platform:0>                            .setAspects(<aspect:mana>*2       ,<aspect:herba>*20          ,<aspect:alienis>*2);
<botania:platform:1>                            .setAspects(<aspect:mana>*3       ,<aspect:herba>*20          ,<aspect:alienis>*5);
<botania:spawnerclaw>                           .setAspects(<aspect:aqua>*90      ,<aspect:mana>*30           ,<aspect:victus>*30       ,<aspect:metallum>*50); # life infuser
<botania:starfield>                             .setAspects(<aspect:mana>*7       ,<aspect:metallum>*30       ,<aspect:alienis>*22      ,<aspect:tenebrae>*23   ,<aspect:lux>*20);
<botania:rfgenerator>                           .setAspects(<aspect:mana>*3       ,<aspect:potentia>*201      ,<aspect:machina>*20      ,<aspect:terra>*15      ,<aspect:victus>*9);
<botania:terraplate>                            .setAspects(<aspect:mana>*50      ,<aspect:metallum>*50       ,<aspect:fabrico>*20      ,<aspect:permutatio>*20 ,<aspect:auram>*20);
<botania:pump>                                  .setAspects(<aspect:mana>*7       ,<aspect:terra>*20          ,<aspect:metallum>*50     ,<aspect:machina>*10    ,<aspect:permutatio>*10);
<botania:sparkchanger>                          .setAspects(<aspect:mana>*7       ,<aspect:alienis>*7         ,<aspect:metallum>*15     ,<aspect:machina>*10    ,<aspect:terra>*11);
<botania:teruterubozu>                          .setAspects(<aspect:mana>*9       ,<aspect:permutatio>*9      ,<aspect:aqua>*20         ,<aspect:potentia>*20   ,<aspect:aer>*20);
<botania:sextant>                               .setAspects(<aspect:mana>*15      ,<aspect:metallum>*30       ,<aspect:herba>*18        ,<aspect:instrumentum>*8,<aspect:victus>*9);
<botania:enchantedsoil>                         .setAspects(<aspect:mana>*15      ,<aspect:victus>*20         ,<aspect:terra>*10);
<botania:manamirror:*>                          .setAspects(<aspect:mana>*20      ,<aspect:permutatio>*10     ,<aspect:terra>*20);

# Mana Lenses
<botania:lens>                                  .setAspects(<aspect:metallum>*30  ,<aspect:mana>*15); #default
<botania:lens:1>                                .setAspects(<aspect:metallum>*30  ,<aspect:mana>*15           ,<aspect:alienis>*5       ,<aspect:motus>*10);        #velocity
<botania:lens:2>                                .setAspects(<aspect:metallum>*30  ,<aspect:mana>*15           ,<aspect:alienis>*5       ,<aspect:potentia>*10);     #potency
<botania:lens:3>                                .setAspects(<aspect:metallum>*30  ,<aspect:mana>*15           ,<aspect:alienis>*5       ,<aspect:vitreus>*10);      #resistance
<botania:lens:4>                                .setAspects(<aspect:metallum>*30  ,<aspect:mana>*15           ,<aspect:alienis>*5       ,<aspect:instrumentum>*10); #efficiency
<botania:lens:5>                                .setAspects(<aspect:metallum>*30  ,<aspect:mana>*15           ,<aspect:alienis>*5       ,<aspect:praemunio>*10);    #bounce
<botania:lens:6>                                .setAspects(<aspect:metallum>*30  ,<aspect:mana>*15           ,<aspect:alienis>*5       ,<aspect:terra>*10);        #gravity
<botania:lens:7>                                .setAspects(<aspect:metallum>*30  ,<aspect:mana>*15           ,<aspect:alienis>*5       ,Aspect.exitium*10);      #bore
<botania:lens:8>                                .setAspects(<aspect:metallum>*30  ,<aspect:mana>*15           ,<aspect:alienis>*5       ,<aspect:aversio>*10);      #damaging
<botania:lens:9>                                .setAspects(<aspect:metallum>*30  ,<aspect:mana>*15           ,<aspect:alienis>*5       ,<aspect:spiritus>*10);       #phantom
<botania:lens:10>                               .setAspects(<aspect:metallum>*30  ,<aspect:mana>*15           ,<aspect:alienis>*5       ,<aspect:desiderium>*10);   #magnetizing
<botania:lens:11>                               .setAspects(<aspect:metallum>*30  ,<aspect:mana>*15           ,<aspect:alienis>*5       ,<aspect:perditio>*10);     #entropic
<botania:lens:12>                               .setAspects(<aspect:metallum>*30  ,<aspect:mana>*15           ,<aspect:alienis>*5       ,Aspect.ventus*10);       #influence
<botania:lens:13>                               .setAspects(<aspect:metallum>*30  ,<aspect:mana>*15           ,<aspect:alienis>*5       ,<aspect:praecantatio>*10); #weight
<botania:lens:14>                               .setAspects(<aspect:metallum>*30  ,<aspect:mana>*15           ,<aspect:alienis>*5       ,<aspect:fabrico>*10);      #paintslinger
<botania:lens:15>                               .setAspects(<aspect:metallum>*30  ,<aspect:mana>*15           ,<aspect:alienis>*5       ,<aspect:ignis>*10);        #kindle
<botania:lens:16>                               .setAspects(<aspect:metallum>*30  ,<aspect:mana>*15           ,<aspect:alienis>*5       ,<aspect:machina>*10);      #force
<botania:lens:17>                               .setAspects(<aspect:metallum>*30  ,<aspect:mana>*15           ,<aspect:alienis>*5       ,<aspect:lux>*10);          #flash
<botania:lens:18>                               .setAspects(<aspect:metallum>*30  ,<aspect:mana>*15           ,<aspect:alienis>*15);                                #warp
<botania:lens:19>                               .setAspects(<aspect:metallum>*30  ,<aspect:mana>*15           ,<aspect:alienis>*5       ,Aspect.imperium*10);     #redirective
<botania:lens:20>                               .setAspects(<aspect:metallum>*30  ,<aspect:mana>*15           ,<aspect:alienis>*5       ,<aspect:alkimia>*10);      #celebratory
<botania:lens:21>                               .setAspects(<aspect:metallum>*30  ,<aspect:mana>*15           ,<aspect:alienis>*5       ,<aspect:permutatio>*10);   #flare
<botania:lens:22>                               .setAspects(<aspect:metallum>*30  ,<aspect:mana>*15           ,<aspect:alienis>*5       ,<aspect:cognitio>*10);     #messenger
<botania:lens:23>                               .setAspects(<aspect:metallum>*30  ,<aspect:mana>*15           ,<aspect:alienis>*5       ,<aspect:sensus>*10);       #tripwire

#Runes
<botania:rune:3>                                .setAspects(<aspect:terra>*5      ,<aspect:aer>*25            ,<aspect:mana>*5); #rune air
<botania:rune:2>                                .setAspects(<aspect:terra>*30     ,<aspect:mana>*5); #rune earth
<botania:rune:1>                                .setAspects(<aspect:terra>*5      ,<aspect:ignis>*25          ,<aspect:mana>*5); #rune fire
<botania:rune>                                  .setAspects(<aspect:terra>*5      ,<aspect:aqua>*25           ,<aspect:mana>*5); #rune water
<botania:rune:7>                                .setAspects(<aspect:terra>*5      ,<aspect:gelum>*25          ,<aspect:mana>*10); #rune winter
<botania:rune:6>                                .setAspects(<aspect:terra>*5      ,<aspect:mortuus>*25        ,<aspect:mana>*10); #rune autumn
<botania:rune:5>                                .setAspects(<aspect:terra>*5      ,<aspect:victus>*25         ,<aspect:mana>*10); #rune summer
<botania:rune:4>                                .setAspects(<aspect:terra>*5      ,<aspect:herba>*25          ,<aspect:mana>*10); #rune spring
<botania:rune:8>                                .setAspects(<aspect:terra>*5      ,<aspect:auram>*25          ,<aspect:mana>*15); #rune of mana
<botania:rune:15>                               .setAspects(<aspect:terra>*5      ,<aspect:desiderium>*20     ,<aspect:mythus>*30       ,<aspect:mana>*15); #rune pride
<botania:rune:14>                               .setAspects(<aspect:terra>*5      ,<aspect:desiderium>*20     ,<aspect:spiritus>*30     ,<aspect:mana>*15); #rune envy
<botania:rune:13>                               .setAspects(<aspect:terra>*5      ,<aspect:desiderium>*20     ,<aspect:aversio>*30      ,<aspect:mana>*15); #rune wrath
<botania:rune:12>                               .setAspects(<aspect:terra>*5      ,<aspect:desiderium>*20     ,Aspect.imperium*30     ,<aspect:mana>*15); #rune sloth
<botania:rune:11>                               .setAspects(<aspect:terra>*5      ,<aspect:desiderium>*20     ,<aspect:humanus>*30      ,<aspect:mana>*15); #rune greed
<botania:rune:10>                               .setAspects(<aspect:terra>*5      ,<aspect:desiderium>*20     ,<aspect:vacuos>*30       ,<aspect:mana>*15); #rune gluttony
<botania:rune:9>                                .setAspects(<aspect:terra>*5      ,<aspect:desiderium>*20     ,Aspect.fluctus*30      ,<aspect:mana>*15); #rune lust

#Items/baubles
<botania:terrasword>                            .setAspects(<aspect:mana>*30      ,<aspect:praecantatio>*30   ,<aspect:aversio>*16      ,<aspect:metallum>*12);                       #terra sword
<botania:tinyplanet>                            .setAspects(<aspect:mana>*5       ,<aspect:praecantatio>*3    ,<aspect:motus>*3         ,<aspect:terra>*30      ,<aspect:victus>*9);  #tiny planet
<botania:laputashard:*>                         .setAspects(<aspect:mana>*15      ,<aspect:instrumentum>*40   ,<aspect:alienis>*100     ,Aspect.caeles*50);                         #shard of laputa
<botania:knockbackbelt>                         .setAspects(<aspect:terra>*30     ,<aspect:potentia>*30       ,<aspect:praemunio>*10);                          #tectonic gridle  
<botania:travelbelt>                            .setAspects(<aspect:terra>*30     ,<aspect:motus>*30          ,<aspect:praemunio>*10);                          #soujourner's sash
<botania:supertravelbelt>                       .setAspects(Aspect.caeles*75    ,<aspect:motus>*100         ,<aspect:praemunio>*50);  
<botania:miningring>                            .setAspects(Aspect.exitium*10   ,<aspect:desiderium>*50     ,<aspect:instrumentum>*10 ,<aspect:metallum>*50); #ring of the mantle
<botania:waterring>                             .setAspects(<aspect:aqua>*30      ,<aspect:desiderium>*50     ,<aspect:instrumentum>*10 ,<aspect:metallum>*50); #ring of chordata
<botania:magnetring>                            .setAspects(<aspect:mana>*30      ,<aspect:desiderium>*150    ,<aspect:instrumentum>*10 ,<aspect:metallum>*50); #ring of magnetization
<botania:pixiering>                             .setAspects(<aspect:mana>*10      ,<aspect:desiderium>*50     ,<aspect:instrumentum>*10 ,<aspect:metallum>*50);  #fairy ring
<botania:holycloak>                             .setAspects(Aspect.caeles*30    ,<aspect:praemunio>*30      ,<aspect:vacuos>*20       ,<aspect:lux>*20);      #cloak of virtue
<botania:balancecloak>                          .setAspects(Aspect.caeles*30    ,<aspect:praemunio>*30      ,<aspect:permutatio>*20   ,Aspect.visum*20);    #cloak of balance
<botania:unholycloak>                           .setAspects(Aspect.caeles*30    ,<aspect:praemunio>*30      ,<aspect:aversio>*20      ,Aspect.infernum*20); #cloak of sin
<botania:manainkwell:*>                         .setAspects(<aspect:mana>*15      ,<aspect:sensus>*5);                                                          #botania inkwell
<botania:temperancestone>                       .setAspects(<aspect:mana>*5       ,<aspect:terra>*30          ,<aspect:vinculum>*5);
<botania:blackholetalisman>                     .setAspects(<aspect:mana>*10      ,<aspect:vacuos>*30         ,<aspect:alienis>*50      ,<aspect:tenebrae>*25);

<botania:flighttiara>                           .setAspects(Aspect.caeles*75    ,<aspect:volatus>*100       ,<aspect:alienis>*150     ,Aspect.ventus*50);   #Flugel Tiara
<botania:flighttiara:1>                         .setAspects(Aspect.caeles*75    ,<aspect:volatus>*100       ,<aspect:alienis>*150     ,<aspect:ordo>*50);     #Flugel Tiara (flugel)
<botania:flighttiara:2>                         .setAspects(Aspect.caeles*75    ,<aspect:volatus>*100       ,<aspect:alienis>*150     ,<aspect:perditio>*50); #Flugel Tiara (one winged angel)
<botania:flighttiara:3>                         .setAspects(Aspect.caeles*75    ,<aspect:volatus>*100       ,<aspect:alienis>*150     ,<aspect:gelum>*50);    #Flugel Tiara (ice fairy)
<botania:flighttiara:4>                         .setAspects(Aspect.caeles*75    ,<aspect:volatus>*100       ,<aspect:alienis>*150     ,<aspect:ignis>*50);    #Flugel Tiara (phoenix)
<botania:flighttiara:5>                         .setAspects(Aspect.caeles*75    ,<aspect:volatus>*100       ,<aspect:alienis>*150     ,Aspect.fluctus*50);  #Flugel Tiara (black snow princess)
<botania:flighttiara:6>                         .setAspects(Aspect.caeles*75    ,<aspect:volatus>*100       ,<aspect:alienis>*150     ,<aspect:tenebrae>*50); #Flugel Tiara (lord of the pit)
<botania:flighttiara:7>                         .setAspects(Aspect.caeles*75    ,<aspect:volatus>*100       ,<aspect:alienis>*150     ,<aspect:lux>*50);      #Flugel Tiara (sylph)
<botania:flighttiara:8>                         .setAspects(Aspect.caeles*75    ,<aspect:volatus>*100       ,<aspect:alienis>*150     ,<aspect:bestia>*50);   #Flugel Tiara (chicken)

<botania:dice:*>                                .setAspects(<aspect:mana>*30      ,<aspect:alienis>*30        ,<aspect:desiderium>*25);
<botania:infinitefruit:*>                       .setAspects(<aspect:victus>*50    ,<aspect:herba>*30          ,<aspect:alienis>*15      ,<aspect:mana>*30   ,<aspect:desiderium>*25);
<botania:kingkey:*>                             .setAspects(<aspect:aversio>*50   ,<aspect:vinculum>*30       ,<aspect:alienis>*15      ,<aspect:mana>*30   ,<aspect:desiderium>*25);
<botania:flugeleye:*>                           .setAspects(<aspect:motus>*50     ,<aspect:volatus>*30        ,<aspect:alienis>*15      ,<aspect:mana>*30   ,<aspect:desiderium>*25);
<botania:odinring:*>                            .setAspects(<aspect:praemunio>*50 ,<aspect:victus>*30         ,<aspect:alienis>*15      ,<aspect:mana>*30   ,<aspect:desiderium>*25);
<botania:thorring:*>                            .setAspects(<aspect:instrumentum>*50,<aspect:perditio>*30     ,<aspect:alienis>*15      ,<aspect:mana>*30   ,<aspect:desiderium>*25);
<botania:lokiring:*>                            .setAspects(<aspect:auram>*50     ,<aspect:humanus>*30        ,<aspect:alienis>*15      ,<aspect:mana>*30   ,<aspect:desiderium>*25);

<botania:rainbowrod>                            .setAspects(<aspect:mana>*30      ,<aspect:instrumentum>*20   ,<aspect:alienis>*50      ,<aspect:permutatio>*30);   #rod of bifrost
<botania:diviningrod>                           .setAspects(<aspect:mana>*10      ,<aspect:desiderium>*20     ,<aspect:sensus>*20       ,<aspect:instrumentum>*10); 
<botania:tornadorod>                            .setAspects(<aspect:mana>*5       ,<aspect:aer>*20            ,Aspect.fluctus*10);                                
<botania:terraformrod>                          .setAspects(<aspect:mana>*40      ,<aspect:instrumentum>*40   ,<aspect:terra>*120       ,<aspect:permutatio>*40);   
<botania:dirtrod>                               .setAspects(<aspect:mana>*5       ,<aspect:instrumentum>*10   ,<aspect:terra>*20);   
<botania:gravityrod>                            .setAspects(<aspect:mana>*10      ,<aspect:instrumentum>*20   ,<aspect:alienis>*20      ,<aspect:vinculum>*20);   
<botania:missilerod>                            .setAspects(<aspect:mana>*25      ,<aspect:aversio>*30        ,Aspect.caeles*30       ,<aspect:alienis>*100);   
<botania:cobblerod>                             .setAspects(<aspect:mana>*10      ,<aspect:instrumentum>*10   ,<aspect:terra>*30        ,<aspect:perditio>*5);   
<botania:exchangerod>                           .setAspects(<aspect:mana>*10      ,<aspect:instrumentum>*20   ,<aspect:permutatio>*30   ,Aspect.imperium*30);   

#Generating flora
<botania:specialflower>.withTag({type: "endoflame"})    .setAspects(<aspect:herba>*20       ,<aspect:ignis>*10      ,<aspect:aer>*10);   
<botania:specialflower>.withTag({type: "kekimurus"})    .setAspects(<aspect:herba>*20       ,<aspect:vacuos>*10     ,<aspect:fabrico>*10);   
<botania:specialflower>.withTag({type: "narslimmus"})   .setAspects(<aspect:herba>*20       ,<aspect:victus>*10     ,<aspect:aqua>*10);   
<botania:specialflower>.withTag({type: "entropinnyum"}) .setAspects(<aspect:herba>*20       ,<aspect:alkimia>*10    ,Aspect.exitium*10);   
<botania:specialflower>.withTag({type: "spectrolus"})   .setAspects(<aspect:herba>*20       ,<aspect:fabrico>*10    ,<aspect:ordo>*10);   
<botania:specialflower>.withTag({type: "dandelifeon"})  .setAspects(<aspect:herba>*100      ,<aspect:cognitio>*100  ,Aspect.caeles*25);   
<botania:specialflower>.withTag({type: "rafflowsia"})   .setAspects(<aspect:herba>*20       ,<aspect:exanimis>*10   ,<aspect:perditio>*10);   
<botania:specialflower>.withTag({type: "arcanerose"})   .setAspects(<aspect:herba>*20       ,<aspect:cognitio>*10   ,<aspect:humanus>*10);   
<botania:specialflower>.withTag({type: "munchdew"})     .setAspects(<aspect:herba>*20       ,<aspect:vacuos>*10     ,<aspect:terra>*10);   
<botania:specialflower>.withTag({type: "hydroangeas"})  .setAspects(<aspect:herba>*20       ,<aspect:aqua>*10       ,<aspect:sensus>*10);   
<botania:specialflower>.withTag({type: "gourmaryllis"}) .setAspects(<aspect:herba>*20       ,<aspect:vacuos>*10     ,<aspect:bestia>*10);   
<botania:specialflower>.withTag({type: "shulk_me_not"}) .setAspects(<aspect:herba>*20       ,<aspect:alienis>*10    ,<aspect:mortuus>*10);   
<botania:specialflower>.withTag({type: "thermalily"})   .setAspects(<aspect:herba>*20       ,<aspect:ignis>*10      ,<aspect:terra>*10);   

#Functional flora
<botania:specialflower>.withTag({type: "orechid"})                      .setAspects(<aspect:herba>*50       ,<aspect:desiderium>*50 ,<aspect:terra>*30);   
<botania:specialflower>.withTag({type: "orechidIgnem"})                 .setAspects(<aspect:herba>*50       ,<aspect:desiderium>*50 ,Aspect.infernum*30);   
<botania:specialflower>.withTag({type: "orechidVacuam"})                .setAspects(<aspect:herba>*50       ,<aspect:desiderium>*50 ,<aspect:alienis>*30);   
<botania:specialflower>.withTag({type: "excompressum.orechidEvolved"})  .setAspects(<aspect:herba>*50       ,<aspect:desiderium>*50 ,<aspect:terra>*30);   
<botania:specialflower>.withTag({type: "puredaisy"})                    .setAspects(<aspect:herba>*20       ,<aspect:ordo>*10       ,<aspect:permutatio>*10);   
<botania:specialflower>.withTag({type: "manastar"})                     .setAspects(<aspect:herba>*20       ,<aspect:sensus>*10     ,<aspect:praecantatio>*10);  
<botania:specialflower>.withTag({type: "petro_petunia"})                .setAspects(<aspect:herba>*20       ,<aspect:alkimia>*10    ,<aspect:aqua>*10);  

<botania:specialflower>.withTag({type: "exoflame"})       .setAspects(<aspect:herba>*20       ,<aspect:ignis>*10      ,<aspect:fabrico>*10);  
<botania:specialflower>.withTag({type: "dreadthorn"})     .setAspects(<aspect:herba>*20       ,<aspect:mortuus>*10    ,Aspect.visum*10);  
<botania:specialflower>.withTag({type: "hopperhock"})     .setAspects(<aspect:herba>*20       ,<aspect:vacuos>*10     ,<aspect:desiderium>*10);  
<botania:specialflower>.withTag({type: "jadedAmaranthus"}).setAspects(<aspect:herba>*20       ,<aspect:victus>*10     ,<aspect:praecantatio>*10);  
<botania:specialflower>.withTag({type: "jiyuulia"})       .setAspects(<aspect:herba>*20       ,<aspect:praemunio>*10  ,<aspect:potentia>*10);  
<botania:specialflower>.withTag({type: "bellethorn"})     .setAspects(<aspect:herba>*20       ,<aspect:aversio>*10    ,<aspect:mortuus>*10);  
<botania:specialflower>.withTag({type: "agricarnation"})  .setAspects(<aspect:herba>*20       ,<aspect:ordo>*10       ,<aspect:victus>*10);  
<botania:specialflower>.withTag({type: "clayconia"})      .setAspects(<aspect:herba>*20       ,<aspect:permutatio>*10 ,<aspect:aqua>*10);  
<botania:specialflower>.withTag({type: "daffomill"})      .setAspects(<aspect:herba>*20       ,<aspect:motus>*10      ,Aspect.ventus*10);  
<botania:specialflower>.withTag({type: "hyacidus"})       .setAspects(<aspect:herba>*20       ,<aspect:mortuus>*10    ,<aspect:aqua>*10);  
<botania:specialflower>.withTag({type: "medumone"})       .setAspects(<aspect:herba>*20       ,<aspect:gelum>*10      ,Aspect.fluctus*10);  
<botania:specialflower>.withTag({type: "pollidisiac"})    .setAspects(<aspect:herba>*20       ,<aspect:bestia>*10     ,<aspect:victus>*10);  
<botania:specialflower>.withTag({type: "vinculotus"})     .setAspects(<aspect:herba>*20       ,<aspect:alienis>*10    ,<aspect:vinculum>*10);  
<botania:specialflower>.withTag({type: "fallenKanade"})   .setAspects(<aspect:herba>*20       ,<aspect:auram>*10      ,<aspect:victus>*10);  
<botania:specialflower>.withTag({type: "bergamute"})      .setAspects(<aspect:herba>*20       ,<aspect:vacuos>*10     ,Aspect.sonus*10);  
<botania:specialflower>.withTag({type: "bubbell"})        .setAspects(<aspect:herba>*20       ,<aspect:auram>*10      ,<aspect:aqua>*10);  
<botania:specialflower>.withTag({type: "heiseiDream"})    .setAspects(<aspect:herba>*20       ,<aspect:aversio>*10    ,Aspect.imperium*10);  
<botania:specialflower>.withTag({type: "marimorphosis"})  .setAspects(<aspect:herba>*20       ,<aspect:permutatio>*10 ,<aspect:vitreus>*10);  
<botania:specialflower>.withTag({type: "rannuncarpus"})   .setAspects(<aspect:herba>*20       ,<aspect:desiderium>*10 ,<aspect:ordo>*10);  
<botania:specialflower>.withTag({type: "spectranthemum"}) .setAspects(<aspect:herba>*20       ,<aspect:alienis>*10    ,<aspect:motus>*10);  
<botania:specialflower>.withTag({type: "tangleberrie"})   .setAspects(<aspect:herba>*20       ,<aspect:desiderium>*10 ,<aspect:vinculum>*10);  
<botania:specialflower>.withTag({type: "tigerseye"})      .setAspects(<aspect:herba>*20       ,Aspect.exitium*10    ,<aspect:bestia>*10);  
<botania:specialflower>.withTag({type: "solegnolia"})     .setAspects(<aspect:herba>*20       ,<aspect:desiderium>*10 ,<aspect:perditio>*10);  
<botania:specialflower>.withTag({type: "loonium"})        .setAspects(<aspect:herba>*20       ,<aspect:desiderium>*10 ,<aspect:mythus>*10);  

/*
#######################################################
____ _  _ _ ____ ____ _    _      / ____ _  _ ____ ____ _  _          ____ ____ _  _ ____ ____ ____ _       ____ ___ ____ _  _ ____ ____ 
|    |__| | [__  |___ |    |     /  |  | |  | |__| |__/ |_/     __    | __ |___ |\ | |___ |__/ |__| |       [__   |  |  | |\ | |___ [__  
|___ |  | | ___] |___ |___ |___ /   |_\| |__| |  | |  \ | \_          |__] |___ | \| |___ |  \ |  | |___    ___]  |  |__| | \| |___ ___] 
                                                                                                                                         
#######################################################
*/

<chisel:basalt2:7>                              .setAspects(<aspect:terra>*4      ,<aspect:tenebrae>*2); #basalt
<chisel:marble2:7>                              .setAspects(<aspect:terra>*4      ,<aspect:ordo>*2); #marble
<quark:jasper>                                  .setAspects(<aspect:terra>*4      ,<aspect:ignis>*2); #jasper

<quark:black_ash>                               .setAspects(<aspect:perditio>*4      ,<aspect:tenebrae>*2); #wither ash

<quark:root>                                    .setAspects(<aspect:herba>*5); 
<quark:root_flower>                             .setAspects(<aspect:herba>*3      ,<aspect:instrumentum>*2); 
<quark:root_flower:1>                           .setAspects(<aspect:herba>*3      ,<aspect:tenebrae>*2); 
<quark:root_flower:2>                           .setAspects(<aspect:herba>*3      ,<aspect:potentia>*2); 

/*
#######################################################
___  ____ ____ ___     _  _ ____ ___     _    ____ ____ ____ _  _ _ _  _ ____ 
|  \ |___ |___ |__]    |\/| |  | |__]    |    |___ |__| |__/ |\ | | |\ | | __ 
|__/ |___ |___ |       |  | |__| |__]    |___ |___ |  | |  \ | \| | | \| |__] 
                                                                              
#######################################################
*/

<deepmoblearning:glitch_fragment>                   .setAspects(Aspect.exitium*10   ,<aspect:machina>*20      ,Aspect.caeles*10       ,Aspect.imperium*20); 
<deepmoblearning:glitch_infused_ingot>              .setAspects(<aspect:metallum>*10  ,<aspect:machina>*20      ,Aspect.caeles*10       ,Aspect.imperium*20); 
<deepmoblearning:glitch_heart>                      .setAspects(<aspect:victus>*30    ,<aspect:machina>*20      ,Aspect.caeles*10       ,Aspect.imperium*20); 

<deepmoblearningbm:blood_infused_glitch_ingot>      .setAspects(<aspect:metallum>*10  ,<aspect:machina>*20      ,Aspect.caeles*10       ,Aspect.imperium*20       ,<aspect:sanguis>*15); 

<deepmoblearning:living_matter_overworldian>        .setAspects(<aspect:machina>*20   ,<aspect:terra>*30        ,<aspect:victus>*30       ,<aspect:bestia>*30);
<deepmoblearning:living_matter_hellish>             .setAspects(<aspect:machina>*20   ,Aspect.infernum*30     ,<aspect:mortuus>*30      ,<aspect:ignis>*30);
<deepmoblearning:living_matter_extraterrestrial>    .setAspects(<aspect:machina>*20   ,<aspect:alienis>*30      ,<aspect:vacuos>*30       ,<aspect:tenebrae>*30);
<deepmoblearning:living_matter_twilight>            .setAspects(<aspect:machina>*20   ,<aspect:mythus>*30       ,<aspect:herba>*30        ,<aspect:auram>*10);

<deepmoblearning:pristine_matter_zombie>            .setAspects(<aspect:machina>*10   ,<aspect:vinculum>*10     ,<aspect:exanimis>*30     ,<aspect:mortuus>*30        ,<aspect:humanus>*60);
<deepmoblearning:pristine_matter_spider>            .setAspects(<aspect:machina>*10   ,<aspect:vinculum>*10     ,<aspect:bestia>*30       ,<aspect:vinculum>*30       ,<aspect:sensus>*30);
<deepmoblearning:pristine_matter_skeleton>          .setAspects(<aspect:machina>*10   ,<aspect:vinculum>*10     ,<aspect:mortuus>*30      ,<aspect:perditio>*30       ,<aspect:aversio>*60);
<deepmoblearning:pristine_matter_creeper>           .setAspects(<aspect:machina>*10   ,<aspect:vinculum>*10     ,Aspect.exitium*30      ,<aspect:ignis>*30          ,<aspect:alkimia>*15        ,<aspect:perditio>*30);
<deepmoblearning:pristine_matter_slime>             .setAspects(<aspect:machina>*10   ,<aspect:vinculum>*10     ,<aspect:aqua>*30         ,<aspect:victus>*30);
<deepmoblearning:pristine_matter_witch>             .setAspects(<aspect:machina>*10   ,<aspect:vinculum>*10     ,<aspect:humanus>*60      ,<aspect:praecantatio>*30   ,<aspect:alkimia>*30);
<deepmoblearning:pristine_matter_guardian>          .setAspects(<aspect:machina>*10   ,<aspect:vinculum>*10     ,<aspect:aqua>*60         ,<aspect:praemunio>*30      ,<aspect:sensus>*30);
<deepmoblearning:pristine_matter_tinker_slime>      .setAspects(<aspect:machina>*10   ,<aspect:vinculum>*10     ,<aspect:aqua>*60         ,<aspect:victus>*30         ,<aspect:fabrico>*15);

<deepmoblearning:pristine_matter_blaze>             .setAspects(<aspect:machina>*10   ,<aspect:vinculum>*10     ,<aspect:ignis>*60        ,Aspect.infernum*60);
<deepmoblearning:pristine_matter_wither_skeleton>   .setAspects(<aspect:machina>*10   ,<aspect:vinculum>*10     ,<aspect:mortuus>*60      ,<aspect:perditio>*60       ,<aspect:aversio>*60        ,<aspect:spiritus>*60);
<deepmoblearning:pristine_matter_ghast>             .setAspects(<aspect:machina>*10   ,<aspect:vinculum>*10     ,<aspect:spiritus>*60     ,<aspect:volatus>*30        ,Aspect.fluctus*60);
<deepmoblearning:pristine_matter_wither>            .setAspects(<aspect:machina>*10   ,<aspect:vinculum>*10     ,Aspect.caeles*50       ,<aspect:alienis>*50        ,<aspect:ordo>*50);

<deepmoblearning:pristine_matter_enderman>          .setAspects(<aspect:machina>*10   ,<aspect:vinculum>*10     ,<aspect:alienis>*80      ,<aspect:tenebrae>*60);
<deepmoblearning:pristine_matter_shulker>           .setAspects(<aspect:machina>*10   ,<aspect:vinculum>*10     ,<aspect:alienis>*50      ,<aspect:volatus>*30        ,Aspect.sonus*30);
<deepmoblearning:pristine_matter_dragon>            .setAspects(<aspect:machina>*10   ,<aspect:vinculum>*10     ,<aspect:draco>*50        ,<aspect:alienis>*50        ,<aspect:alkimia>*20);

<deepmoblearning:pristine_matter_twilight_forest>   .setAspects(<aspect:machina>*10   ,<aspect:vinculum>*10     ,<aspect:mythus>*10       ,<aspect:terra>*50          ,<aspect:spiritus>*30);
<deepmoblearning:pristine_matter_twilight_swamp>    .setAspects(<aspect:machina>*10   ,<aspect:vinculum>*10     ,<aspect:mythus>*10       ,<aspect:herba>*50          ,<aspect:vitium>*30);
<deepmoblearning:pristine_matter_twilight_glacier>  .setAspects(<aspect:machina>*10   ,<aspect:vinculum>*10     ,<aspect:mythus>*10       ,<aspect:gelum>*50          ,<aspect:vitreus>*30);

<deepmoblearning:pristine_matter_thermal_elemental> .setAspects(<aspect:machina>*10   ,<aspect:vinculum>*10     ,<aspect:aqua>*20         ,<aspect:ignis>*20          ,<aspect:terra>*20          ,<aspect:aer>*20);

/*
#######################################################
___  ____ ____ ____ ____ _  _ _ ____    ____ _  _ ____ _    _  _ ___ _ ____ _  _ 
|  \ |__/ |__| |    |  | |\ | | |       |___ |  | |  | |    |  |  |  | |  | |\ | 
|__/ |  \ |  | |___ |__| | \| | |___    |___  \/  |__| |___ |__|  |  | |__| | \| 
                                                                                 
#######################################################
*/

<draconicevolution:dragon_heart>                .setAspects(<aspect:draco>*100    ,<aspect:praecantatio>*50   ,<aspect:spiritus>*30     ,<aspect:victus>*100); #dragon heart

/*
#######################################################
____ _  _ ___     ____ ____ ___  ____ ____ _  _ 
|___ |\ | |  \    |__/ |___ |__] |  | |__/ |\ | 
|___ | \| |__/    |  \ |___ |__] |__| |  \ | \| 
                                                
#######################################################
*/

/*
#######################################################
____ _  _ ___  ____ ____    _ ____ 
|___ |\ | |  \ |___ |__/    | |  | 
|___ | \| |__/ |___ |  \    | |__| 
                            
#######################################################
*/

/*
#######################################################
____ _  _ ___ ____ ____    _  _ ___ _ _    _ ___ _ ____ ____    
|___  \/   |  |__/ |__|    |  |  |  | |    |  |  | |___ [__     
|___ _/\_  |  |  \ |  |    |__|  |  | |___ |  |  | |___ ___]    
                                                                
#######################################################
*/

<extrautils2:ingredients:11>                    .setAspects(<aspect:metallum>*10  ,Aspect.infernum*5); #Demonic ingot
<extrautils2:ingredients:12>                    .setAspects(<aspect:metallum>*10  ,<aspect:cognitio>*5); #Enchanted ingot
<extrautils2:fakecopy:*>                        .setAspects(<aspect:amogus>*25); #Fake Item

/*
#######################################################
____ ____ ____ ____ ____ ___ ____ _   _ 
|___ |  | |__/ |___ [__   |  |__/  \_/  
|    |__| |  \ |___ ___]  |  |  \   |   
                                        
#######################################################
*/

<forestry:candle>                               .setAspects(<aspect:lux>*20      ,<aspect:herba>*5            ,<aspect:aer>*5);
<forestry:stump>                                .setAspects(<aspect:lux>*20      ,<aspect:herba>*5            ,<aspect:aer>*5);
<forestry:beeswax>                              .setAspects(<aspect:lux>*5       ,<aspect:aer>*2);

/*
#######################################################
____ ____ _  _ ___  _  _ ____ ___ ____ _   _ 
| __ |___ |\ | |  \ |  | [__   |  |__/  \_/  
|__] |___ | \| |__/ |__| ___]  |  |  \   |   
                                             
#######################################################
*/

/*
#######################################################
_ ____ ____    ____ _  _ ___     ____ _ ____ ____ 
| |    |___    |__| |\ | |  \    |___ | |__/ |___ 
| |___ |___    |  | | \| |__/    |    | |  \ |___ 
                                                  
#######################################################
*/

#General

<iceandfire:manuscript>                        .setAspects(<aspect:cognitio>*20); #manuscript
<iceandfire:witherbone>                        .setAspects(<aspect:mortuus>*10      ,Aspect.infernum*10     ,<aspect:tenebrae>*5       ,<aspect:perditio>*5); #wither bone
<iceandfire:myrmex_stinger>                    .setAspects(<aspect:mythus>*5        ,<aspect:aversio>*6       ,<aspect:alkimia>*5);

#Dragons general

<iceandfire:dragonbone>                         .setAspects(<aspect:draco>*5      ,<aspect:praecantatio>*2    ,<aspect:mortuus>*5); #dragon bone
<iceandfire:dragon_meal>                        .setAspects(<aspect:victus>*20    ,<aspect:bestia>*10         ,<aspect:mortuus>*20); #dragon meal

#Fire
<iceandfire:fire_dragon_heart>                  .setAspects(<aspect:draco>*100    ,<aspect:praecantatio>*50   ,<aspect:spiritus>*30     ,<aspect:victus>*100    ,<aspect:ignis>*50); #heart
<iceandfire:fire_dragon_flesh>                  .setAspects(<aspect:draco>*10     ,<aspect:victus>*10         ,<aspect:mortuus>*20      ,<aspect:ignis>*20); #flesh
<iceandfire:fire_dragon_blood>                  .setAspects(<aspect:draco>*5      ,<aspect:praecantatio>*10   ,<aspect:alkimia>*10      ,<aspect:ignis>*10); #blood
<iceandfire:dragon_skull>                       .setAspects(<aspect:draco>*25     ,<aspect:spiritus>*10       ,<aspect:mortuus>*10      ,<aspect:ignis>*30); #skull
<iceandfire:dragonscales_red>                   .setAspects(<aspect:draco>*5      ,<aspect:praemunio>*7       ,Aspect.infernum*10     ,<aspect:ignis>*10); #scales red
<iceandfire:dragonscales_bronze>                .setAspects(<aspect:draco>*5      ,<aspect:praemunio>*7       ,<aspect:desiderium>*10   ,<aspect:ignis>*10); #scales bronze
<iceandfire:dragonscales_green>                 .setAspects(<aspect:draco>*5      ,<aspect:praemunio>*7       ,Aspect.visum*10        ,<aspect:ignis>*10); #scales green
<iceandfire:dragonscales_gray>                  .setAspects(<aspect:draco>*5      ,<aspect:praemunio>*7       ,Aspect.exitium*10      ,<aspect:ignis>*10); #scales gray
<iceandfire:dragonegg_red>                      .setAspects(<aspect:draco>*100    ,<aspect:praecantatio>*10   ,Aspect.infernum*10     ,<aspect:ignis>*10); #egg red
<iceandfire:dragonegg_bronze>                   .setAspects(<aspect:draco>*100    ,<aspect:praecantatio>*10   ,<aspect:desiderium>*10   ,<aspect:ignis>*10); #egg bronze
<iceandfire:dragonegg_green>                    .setAspects(<aspect:draco>*100    ,<aspect:praecantatio>*10   ,Aspect.visum*10        ,<aspect:ignis>*10); #egg green
<iceandfire:dragonegg_gray>                     .setAspects(<aspect:draco>*100    ,<aspect:praecantatio>*10   ,Aspect.exitium*10      ,<aspect:ignis>*10); #egg gray
<iceandfire:dragonsteel_fire_ingot>             .setAspects(<aspect:draco>*25     ,<aspect:metallum>*20       ,<aspect:desiderium>*40   ,<aspect:ignis>*50); #dragonsteel ingot
<iceandfire:fire_lily>                          .setAspects(<aspect:draco>*5      ,<aspect:praecantatio>*2    ,<aspect:herba>*5         ,<aspect:ignis>*5); #lily
<iceandfire:fire_stew>                          .setAspects(<aspect:draco>*5      ,<aspect:praecantatio>*5    ,<aspect:ignis>*20); #lily mixture

#Ice
<iceandfire:ice_dragon_heart>                   .setAspects(<aspect:draco>*100    ,<aspect:praecantatio>*50   ,<aspect:spiritus>*30     ,<aspect:victus>*100    ,<aspect:gelum>*50); #heart
<iceandfire:ice_dragon_flesh>                   .setAspects(<aspect:draco>*10     ,<aspect:victus>*10         ,<aspect:mortuus>*20      ,<aspect:gelum>*20); #flesh
<iceandfire:ice_dragon_blood>                   .setAspects(<aspect:draco>*5      ,<aspect:praecantatio>*10   ,<aspect:alkimia>*10      ,<aspect:gelum>*10); #blood
<iceandfire:dragon_skull:1>                     .setAspects(<aspect:draco>*25     ,<aspect:spiritus>*10       ,<aspect:mortuus>*10      ,<aspect:gelum>*30); #skull
<iceandfire:dragonscales_sapphire>              .setAspects(<aspect:draco>*5      ,<aspect:praemunio>*15      ,<aspect:instrumentum>*10 ,<aspect:gelum>*10); #scales sapphire
<iceandfire:dragonscales_blue>                  .setAspects(<aspect:draco>*5      ,<aspect:praemunio>*15      ,<aspect:vitreus>*10      ,<aspect:gelum>*10); #scales blue
<iceandfire:dragonscales_white>                 .setAspects(<aspect:draco>*5      ,<aspect:praemunio>*15      ,<aspect:volatus>*10      ,<aspect:gelum>*10); #scales white
<iceandfire:dragonscales_silver>                .setAspects(<aspect:draco>*5      ,<aspect:praemunio>*15      ,Aspect.fluctus*10      ,<aspect:gelum>*10); #scales silver
<iceandfire:dragonegg_sapphire>                 .setAspects(<aspect:draco>*100    ,<aspect:praecantatio>*10   ,<aspect:instrumentum>*10 ,<aspect:gelum>*10); #egg sapphire
<iceandfire:dragonegg_blue>                     .setAspects(<aspect:draco>*100    ,<aspect:praecantatio>*10   ,<aspect:vitreus>*10      ,<aspect:gelum>*10); #egg blue
<iceandfire:dragonegg_white>                    .setAspects(<aspect:draco>*100    ,<aspect:praecantatio>*10   ,<aspect:volatus>*10      ,<aspect:gelum>*10); #egg white
<iceandfire:dragonegg_silver>                   .setAspects(<aspect:draco>*100    ,<aspect:praecantatio>*10   ,Aspect.fluctus*10      ,<aspect:gelum>*10); #egg silver
<iceandfire:dragonsteel_ice_ingot>              .setAspects(<aspect:draco>*25     ,<aspect:metallum>*20       ,<aspect:desiderium>*40   ,<aspect:gelum>*50); #dragonsteel ingot
<iceandfire:frost_lily>                         .setAspects(<aspect:draco>*5      ,<aspect:praecantatio>*2    ,<aspect:herba>*5         ,<aspect:gelum>*5); #lily
<iceandfire:frost_stew>                         .setAspects(<aspect:draco>*5      ,<aspect:praecantatio>*5    ,<aspect:gelum>*20); #lily mixture

#Ocean creatures
<iceandfire:sea_serpent_fang>                   .setAspects(<aspect:draco>*5      ,<aspect:aversio>*10        ,<aspect:aqua>*10         ,<aspect:mythus>*5); #fang
<iceandfire:sea_serpent_scales_teal>            .setAspects(<aspect:draco>*5      ,<aspect:praemunio>*10      ,<aspect:aqua>*10         ,<aspect:alkimia>*5       ,<aspect:mythus>*10); #scale teal
<iceandfire:sea_serpent_scales_deepblue>        .setAspects(<aspect:draco>*5      ,<aspect:praemunio>*10      ,<aspect:aqua>*10         ,<aspect:instrumentum>*5  ,<aspect:mythus>*10); #scale deepblue
<iceandfire:sea_serpent_scales_bronze>          .setAspects(<aspect:draco>*5      ,<aspect:praemunio>*10      ,<aspect:aqua>*10         ,Aspect.sonus*5         ,<aspect:mythus>*10); #scale bronze
<iceandfire:sea_serpent_scales_blue>            .setAspects(<aspect:draco>*5      ,<aspect:praemunio>*10      ,<aspect:aqua>*10         ,<aspect:vitreus>*5       ,<aspect:mythus>*10); #scale blue
<iceandfire:sea_serpent_scales_green>           .setAspects(<aspect:draco>*5      ,<aspect:praemunio>*10      ,<aspect:aqua>*10         ,Aspect.visum*5         ,<aspect:mythus>*10); #scale green
<iceandfire:sea_serpent_scales_purple>          .setAspects(<aspect:draco>*5      ,<aspect:praemunio>*10      ,<aspect:aqua>*10         ,<aspect:praecantatio>*5  ,<aspect:mythus>*10); #scale purple
<iceandfire:sea_serpent_scales_red>             .setAspects(<aspect:draco>*5      ,<aspect:praemunio>*10      ,<aspect:aqua>*10         ,<aspect:victus>*5        ,<aspect:mythus>*10); #scale red
<iceandfire:seaserpent_skull>                   .setAspects(<aspect:draco>*10     ,<aspect:spiritus>*20       ,<aspect:aqua>*20         ,<aspect:mythus>*50); #skull

<iceandfire:shiny_scales>                       .setAspects(<aspect:desiderium>*20,<aspect:praemunio>*5       ,<aspect:aqua>*10         ,<aspect:mythus>*2); #shiny scales
<iceandfire:siren_tear>                         .setAspects(Aspect.sonus*100    ,Aspect.imperium*50       ,<aspect:aqua>*50         ,<aspect:mythus>*50); #siren 
<iceandfire:hippocampus_fin>                    .setAspects(<aspect:motus>*100    ,<aspect:mythus>*50         ,<aspect:aqua>*50); #hippocampus 

#Beach creatures

<iceandfire:gorgon_head>                        .setAspects(<aspect:mythus>*50    ,<aspect:mortuus>*50        ,<aspect:exanimis>*40     ,<aspect:humanus>*50); #gorgon

<iceandfire:cyclops_eye>                        .setAspects(<aspect:mythus>*20    ,Aspect.visum*30          ,<aspect:mortuus>*20      ,<aspect:bestia>*50); #cyclop
<iceandfire:cyclops_skull>                      .setAspects(<aspect:mythus>*30    ,<aspect:spiritus>*20       ,<aspect:potentia>*20     ,<aspect:terra>*50); 

#Underground

<iceandfire:troll_skull>                        .setAspects(<aspect:mythus>*20    ,<aspect:spiritus>*20       ,<aspect:tenebrae>*20     ,<aspect:terra>*30); #troll skull
<iceandfire:troll_leather_frost>                .setAspects(<aspect:mythus>*10    ,<aspect:praemunio>*10      ,<aspect:tenebrae>*10     ,<aspect:gelum>*15); #leather frost
<iceandfire:troll_leather_mountain>             .setAspects(<aspect:mythus>*10    ,<aspect:praemunio>*10      ,<aspect:tenebrae>*10     ,<aspect:terra>*15); #leather mountain
<iceandfire:troll_leather_forest>               .setAspects(<aspect:mythus>*10    ,<aspect:praemunio>*10      ,<aspect:tenebrae>*10     ,<aspect:herba>*15); #leather forest
<iceandfire:troll_weapon.trunk_frost>           .setAspects(<aspect:mythus>*10    ,<aspect:aversio>*20        ,<aspect:tenebrae>*10     ,<aspect:praecantatio>*10); #troll weapons
<iceandfire:troll_weapon.hammer>                .setAspects(<aspect:mythus>*10    ,<aspect:aversio>*20        ,<aspect:tenebrae>*10     ,<aspect:praecantatio>*10); 
<iceandfire:troll_weapon.column_forest>         .setAspects(<aspect:mythus>*10    ,<aspect:aversio>*20        ,<aspect:tenebrae>*10     ,<aspect:praecantatio>*10); 
<iceandfire:troll_weapon.column_frost>          .setAspects(<aspect:mythus>*10    ,<aspect:aversio>*20        ,<aspect:tenebrae>*10     ,<aspect:praecantatio>*10); 
<iceandfire:troll_weapon.trunk>                 .setAspects(<aspect:mythus>*10    ,<aspect:aversio>*20        ,<aspect:tenebrae>*10     ,<aspect:praecantatio>*10); 
<iceandfire:troll_weapon.axe>                   .setAspects(<aspect:mythus>*10    ,<aspect:aversio>*20        ,<aspect:tenebrae>*10     ,<aspect:praecantatio>*10); 
<iceandfire:troll_weapon.column>                .setAspects(<aspect:mythus>*10    ,<aspect:aversio>*20        ,<aspect:tenebrae>*10     ,<aspect:praecantatio>*10); 

#Swamp

<iceandfire:hydra_skull>                        .setAspects(<aspect:mythus>*50    ,<aspect:spiritus>*20       ,<aspect:alkimia>*50     ,<aspect:victus>*50);  #hydra
<iceandfire:hydra_fang>                         .setAspects(<aspect:mythus>*10    ,<aspect:aversio>*10        ,<aspect:alkimia>*10);                          
<iceandfire:hydra_heart>                        .setAspects(<aspect:mythus>*50    ,<aspect:praecantatio>*30   ,<aspect:alkimia>*50     ,<aspect:victus>*200); 

<iceandfire:stymphalian_skull>                  .setAspects(<aspect:mythus>*15    ,<aspect:spiritus>*20       ,<aspect:volatus>*40     ,Aspect.ventus*40);  #ironbird
<iceandfire:stymphalian_bird_feather>           .setAspects(<aspect:mythus>*5     ,<aspect:aer>*5             ,<aspect:volatus>*5      ,Aspect.ventus*5); 

#Jungle

<iceandfire:amphithere_feather>                 .setAspects(<aspect:mythus>*5     ,<aspect:aer>*5             ,<aspect:volatus>*5      ,<aspect:desiderium>*20);  #amphithere
<iceandfire:amphithere_skull>                   .setAspects(<aspect:mythus>*30    ,<aspect:spiritus>*20       ,<aspect:aer>*20         ,<aspect:volatus>*20);  

<iceandfire:myrmex_jungle_chitin>               .setAspects(<aspect:mythus>*5     ,<aspect:praemunio>*5       ,<aspect:herba>*5); #jungle myrmex
<iceandfire:myrmex_jungle_resin>                .setAspects(<aspect:mythus>*5     ,<aspect:permutatio>*5      ,<aspect:herba>*5); 
<iceandfire:myrmex_jungle_egg:*>                .setAspects(<aspect:mythus>*20    ,<aspect:victus>*10         ,<aspect:herba>*5); 

#Desert
<iceandfire:deathworm_chitin:*>                 .setAspects(<aspect:mythus>*5     ,<aspect:praemunio>*5       ,<aspect:bestia>*5); #deathworm
<iceandfire:iceandfire.deathworm_egg:*>         .setAspects(<aspect:mythus>*10    ,<aspect:victus>*20         ,<aspect:bestia>*20); 
<iceandfire:deathworm_tounge>                   .setAspects(<aspect:mythus>*20    ,<aspect:vinculum>*50       ,<aspect:bestia>*50);

<iceandfire:myrmex_desert_chitin>               .setAspects(<aspect:mythus>*5     ,<aspect:praemunio>*5       ,<aspect:ignis>*5); #desert myrmex
<iceandfire:myrmex_desert_resin>                .setAspects(<aspect:mythus>*5     ,<aspect:permutatio>*5      ,<aspect:ignis>*5); 
<iceandfire:myrmex_desert_egg:*>                .setAspects(<aspect:mythus>*20    ,<aspect:victus>*10         ,<aspect:ignis>*5); 

<iceandfire:cockatrice_skull>                   .setAspects(<aspect:mythus>*10    ,<aspect:spiritus>*20       ,<aspect:motus>*10        ,<aspect:perditio>*20);  #cockatrice
<iceandfire:cockatrice_eye>                     .setAspects(<aspect:mythus>*20    ,<aspect:mortuus>*20        ,<aspect:motus>*10        ,<aspect:perditio>*50); 

#Forest/plains

<iceandfire:hippogryph_skull>                   .setAspects(<aspect:mythus>*20    ,<aspect:spiritus>*20       ,Aspect.ventus*20       ,<aspect:victus>*40);  
<iceandfire:hippogryph_egg:*>                   .setAspects(<aspect:mythus>*20    ,<aspect:victus>*40         ,Aspect.ventus*40); 

<iceandfire:pixie_dust>                         .setAspects(<aspect:mythus>*2     ,<aspect:praecantatio>*30   ,<aspect:humanus>*20      ,<aspect:desiderium>*5); 
<iceandfire:ambrosia>                           .setAspects(<aspect:mythus>*2     ,<aspect:praecantatio>*40   ,<aspect:victus>*20       ,<aspect:desiderium>*20); 
<iceandfire:jar_pixie:*>                        .setAspects(<aspect:mythus>*20    ,<aspect:praecantatio>*50   ,<aspect:humanus>*20      ,<aspect:desiderium>*50); 
<iceandfire:pixie_wings>                        .setAspects(<aspect:mythus>*20    ,<aspect:praecantatio>*50   ,Aspect.imperium*20     ,<aspect:desiderium>*50); 
<iceandfire:pixie_house:*>                      .setAspects(<aspect:herba>*20     ,<aspect:auram>*5); 

#Ice

<iceandfire:dread_shard>                        .setAspects(<aspect:exanimis>*10  ,<aspect:perditio>*10       ,<aspect:spiritus>*20); 

/*
#######################################################
_ _  _ _  _ ____ ____ ____ _ _  _ ____ 
| |\/| |\/| |___ |__/ [__  | |  | |___ 
| |  | |  | |___ |  \ ___] |  \/  |___ 
                                                                                                                                          
#######################################################
*/

/*
#######################################################
_ _  _ ___  _  _ ____ ___ ____ _ ____ _    ____ ____ ____ ____ ___ 
| |\ | |  \ |  | [__   |  |__/ | |__| |    |    |__/ |__| |___  |  
| | \| |__/ |__| ___]  |  |  \ | |  | |___ |___ |  \ |  | |     |  
                                                                                                             
#######################################################
*/

/*
#######################################################
_  _ ____ ____ _  _ ____ _  _ _ ____ ____ 
|\/| |___ |    |__| |__| |\ | | |    [__  
|  | |___ |___ |  | |  | | \| | |___ ___] 
                                          
#######################################################
*/

<mechanics:heavy_ingot>                         .setAspects(<aspect:metallum>*10  ,<aspect:perditio>*5); #heavy ingot

/*
#######################################################
_  _ ____ _  _ ____ _  _ _ ____ _  _ 
|\/| |___ |_/  |__| |\ | | [__  |\/| 
|  | |___ | \_ |  | | \| | ___] |  | 
                                     
#######################################################
*/

<mekanism:ingot>                                .setAspects(<aspect:metallum>*10  ,<aspect:tenebrae>*5        ,<aspect:terra>*10);  #Refined obsidian ingot
<mekanism:nugget>                               .setAspects(<aspect:metallum>*1   ,<aspect:terra>*1);                               #Refined obsidian nugget
<mekanism:basicblock:2>                         .setAspects(<aspect:metallum>*67  ,<aspect:tenebrae>*33       ,<aspect:terra>*67);  #Refined obsidian block
<mekanism:otherdust:5>                          .setAspects(<aspect:metallum>*10  ,<aspect:tenebrae>*5        ,<aspect:terra>*10,    <aspect:perditio>*5); #Refined obsidian dust

<mekanism:ingot:3>                              .setAspects(<aspect:metallum>*10  ,<aspect:lux>*10            ,<aspect:sensus>*5);  #Refined glowstone ingot
<mekanism:nugget:3>                             .setAspects(<aspect:metallum>*1  ,<aspect:sensus>*1);                               #Refined glowstone nugget
<mekanism:basicblock:4>                         .setAspects(<aspect:metallum>*67  ,<aspect:lux>*67            ,<aspect:sensus>*33); #Refined glowstone block

/*
#######################################################
___  _    _  _ ____ ___ _ ____ 
|__] |    |  | [__   |  | |    
|    |___ |__| ___]  |  | |___ 
                               
#######################################################
*/

<plustic:mirioningot>                           .setAspects(<aspect:metallum>*10  ,<aspect:mana>*10           ,<aspect:auram>*10); 
<plustic:mirionnugget>                          .setAspects(<aspect:metallum>*1   ,<aspect:mana>*1            ,<aspect:auram>*1); 
<plustic:mirionblock>                           .setAspects(<aspect:metallum>*67  ,<aspect:mana>*67           ,<aspect:auram>*67); 
<plustic:osgloglasingot>                        .setAspects(<aspect:metallum>*10  ,Aspect.visum*10); 
<plustic:osgloglasnugget>                       .setAspects(<aspect:metallum>*1   ,Aspect.visum*1); 
<plustic:osgloglasblock>                        .setAspects(<aspect:metallum>*67  ,Aspect.visum*67); 
<plustic:alumiteingot>                          .setAspects(<aspect:metallum>*10  ,Aspect.sonus*5); 
<plustic:alumitenugget>                         .setAspects(<aspect:metallum>*1   ,Aspect.sonus*1); 
<plustic:alumiteblock>                          .setAspects(<aspect:metallum>*67  ,Aspect.sonus*67); 
<plustic:osmiridiumingot>                       .setAspects(<aspect:metallum>*10  ,<aspect:volatus>*5); 
<plustic:osmiridiumnugget>                      .setAspects(<aspect:metallum>*1   ,<aspect:volatus>*1); 
<plustic:osmiridiumblock>                       .setAspects(<aspect:metallum>*67  ,<aspect:volatus>*67); 

/*
#######################################################
___  ____ _ 
|__] [__  | 
|    ___] | 
            
#######################################################
*/

<psi:material>                                  .setAspects(<aspect:potentia>*10  ,<aspect:alienis>*5         ,<aspect:potentia>*5); #Psi dust
<psi:material:1>                                .setAspects(<aspect:metallum>*10  ,<aspect:alienis>*5         ,<aspect:potentia>*5); #Psi ingot
<psi:material:2>                                .setAspects(<aspect:vitreus>*10   ,<aspect:alienis>*5         ,<aspect:potentia>*5); #Psi gem

/*
#######################################################
____ ____ _  _ ___  ____ _  _    ___ _  _ _ _  _ ____ ____ 
|__/ |__| |\ | |  \ |  | |\/|     |  |__| | |\ | | __ [__  
|  \ |  | | \| |__/ |__| |  |     |  |  | | | \| |__] ___] 
                                                           
#######################################################
*/

<randomthings:ingredient:2>                     .setAspects(<aspect:spiritus>*10); #Ectoplasm

/*
#######################################################
____ ____ ___ ____ 
|__/ |__|  |  [__  
|  \ |  |  |  ___] 
                   
#######################################################
*/

<rats:rat_sack>                                 .setAspects(<aspect:rattus>*10    ,<aspect:ordo>*5); 
<rats:piper_hat>                                .setAspects(<aspect:rattus>*10    ,<aspect:praemunio>*4       ,<aspect:praecantatio>*2); 
<rats:rat_flute>                                .setAspects(<aspect:rattus>*10    ,<aspect:praecantatio>*10   ,<aspect:fabrico>*10); 
<rats:plague_essence>                           .setAspects(<aspect:rattus>*10    ,<aspect:mortuus>*5); 
<rats:rat_pelt>                                 .setAspects(<aspect:rattus>*5     ,<aspect:praemunio>*5); 
<rats:raw_rat>                                  .setAspects(<aspect:rattus>*5     ,<aspect:victus>*5); 
<rats:cheese_stick>                             .setAspects(<aspect:rattus>*10    ,<aspect:fabrico>*10); 
<rats:radius_stick>                             .setAspects(<aspect:rattus>*10    ,<aspect:perditio>*10       ,<aspect:mortuus>*10); 
<rats:string_cheese>                            .setAspects(<aspect:rattus>*5     ,<aspect:fabrico>*5         ,<aspect:victus>*5); 
<rats:jack_o_ratern>                            .setAspects(<aspect:rattus>*5     ,<aspect:herba>*5           ,<aspect:lux>*5); 
<rats:rat_lantern>                              .setAspects(<aspect:herba>*1); 
<rats:marbled_cheese_raw>                       .setAspects(<aspect:rattus>*5     ,<aspect:terra>*5); 
//<rats:feral_bagh_nakhs>                         .setAspects(<aspect:rattus>*10); 
<rats:feral_rat_claw>                           .setAspects(<aspect:rattus>*25    ,<aspect:mortuus>*5); 
<rats:gem_of_ratlantis>                         .setAspects(<aspect:rattus>*10    ,<aspect:vitreus>*15        ,<aspect:desiderium>*10); 
<rats:arcane_technology>                        .setAspects(<aspect:rattus>*50    ,<aspect:machina>*15        ,<aspect:alienis>*10); 
//<rats:ancient_sawblade>                         .setAspects(<aspect:rattus>*10   ,<aspect:>*5         ,<aspect:>*5); 
<rats:ratlantean_flame>                         .setAspects(<aspect:rattus>*5     ,<aspect:spiritus>*10       ,<aspect:alienis>*5); 
<rats:psionic_rat_brain>                        .setAspects(<aspect:rattus>*100   ,<aspect:cognitio>*100      ,<aspect:desiderium>*100 ,<aspect:alienis>*25, <aspect:alkimia>*50); 
//<rats:idol_of_ratlantis>                        .setAspects(<aspect:rattus>*10   ,<aspect:>*5         ,<aspect:>*5); 
<rats:rattrap>                                  .setAspects(<aspect:rattus>*5     ,<aspect:vinculum>*40       ,<aspect:metallum>*5,   <aspect:fabrico>*5); 
<rats:rat_cage>                                 .setAspects(<aspect:rattus>*5     ,<aspect:vinculum>*50       ,<aspect:metallum>*20,   <aspect:fabrico>*15); 
<rats:charged_creeper_chunk>                    .setAspects(Aspect.exitium*10   ,<aspect:alkimia>*5         ,<aspect:ignis>*10,   <aspect:perditio>*10); 
<rats:plague_scythe>                            .setAspects(<aspect:aversio>*52   ,<aspect:rattus>*15); 
//<rats:rat_capture_net>                          .setAspects(<aspect:rattus>*10   ,<aspect:>*5         ,<aspect:>*5); 

val tubes = [
<rats:rat_tube_white>,
<rats:rat_tube_orange>,
<rats:rat_tube_magenta>,
<rats:rat_tube_light_blue>,
<rats:rat_tube_yellow>,
<rats:rat_tube_lime>,
<rats:rat_tube_pink>,
<rats:rat_tube_gray>,
<rats:rat_tube_cyan>,
<rats:rat_tube_silver>,
<rats:rat_tube_purple>,
<rats:rat_tube_blue>,
<rats:rat_tube_brown>,
<rats:rat_tube_green>,
<rats:rat_tube_red>,
 ] as IItemStack[];
for tube in tubes{
  tube.setAspects(<aspect:rattus>*1,<aspect:motus>*5);
}

val igloos = [
<rats:rat_igloo_cyan>,
<rats:rat_igloo_purple>,
<rats:rat_igloo_blue>,
<rats:rat_igloo_brown>,
<rats:rat_igloo_green>,
<rats:rat_igloo_red>,
<rats:rat_igloo_black>,
<rats:rat_igloo_white>,
<rats:rat_igloo_orange>,
<rats:rat_igloo_magenta>,
<rats:rat_igloo_light_blue>,
<rats:rat_igloo_yellow>,
<rats:rat_igloo_lime>,
<rats:rat_igloo_pink>,
<rats:rat_igloo_gray>,
<rats:rat_igloo_silver>,
 ] as IItemStack[];
for igloo in igloos{
  igloo.setAspects(<aspect:fabrico>*30,<aspect:humanus>*30,<aspect:ordo>*15);
}

/*
#######################################################
____ ____    ___ ____ ____ _    ____ 
|__/ |___     |  |  | |  | |    [__  
|  \ |        |  |__| |__| |___ ___] 
                                     
#######################################################
*/

/*
#######################################################
___ _  _ ____ ____ _  _ ____ _       ____ ____ _  _ _  _ ___  ____ ___ _ ____ _  _ 
 |  |__| |___ |__/ |\/| |__| |       |___ |  | |  | |\ | |  \ |__|  |  | |  | |\ | 
 |  |  | |___ |  \ |  | |  | |___    |    |__| |__| | \| |__/ |  |  |  | |__| | \| 
                                                                                   
#######################################################
*/

<thermalfoundation:material:2048>               .setAspects(<aspect:gelum>*15     ,<aspect:vitreus>*5); #Blizz rod 
<thermalfoundation:material:2052>               .setAspects(<aspect:terra>*15     ,Aspect.exitium*5); #Basalz rod
<thermalfoundation:material:2050>               .setAspects(<aspect:aer>*15       ,Aspect.sonus*5); #Blitz rod

/*
#######################################################
___ _ _  _ _  _ ____ ____ . ____    ____ ____ _  _ ____ ___ ____ _  _ ____ ___ 
 |  | |\ | |_/  |___ |__/ ' [__     |    |  | |\ | [__   |  |__/ |  | |     |  
 |  | | \| | \_ |___ |  \   ___]    |___ |__| | \| ___]  |  |  \ |__| |___  |  
                                                                               
#######################################################
*/

<tconstruct:materials:17>                       .setAspects(<aspect:mortuus>*10      ,Aspect.infernum*10    ,<aspect:tenebrae>*5       ,<aspect:perditio>*5); #wither bone

<tconstruct:ingots:2>                           .setAspects(<aspect:metallum>*10  ,<aspect:aversio>*5); #Manyullyn ingot
<tconstruct:nuggets:2>                          .setAspects(<aspect:metallum>*1);                       #Manyullyn nugget
<tconstruct:metal:2>                            .setAspects(<aspect:metallum>*67  ,<aspect:aversio>*33);#Manyullyn block
<tconstruct:ingots:5>                           .setAspects(<aspect:metallum>*10  ,<aspect:alkimia>*5); #Alchemical brass ingot
<tconstruct:nuggets:5>                          .setAspects(<aspect:metallum>*1);                       #Alchemical brass nugget
<tconstruct:metal:5>                            .setAspects(<aspect:metallum>*67  ,<aspect:alkimia>*33);#Alchemical brass block
<tconstruct:ingots:4>                           .setAspects(<aspect:metallum>*10  ,<aspect:bestia>*5); #Pigiron ingot
<tconstruct:nuggets:4>                          .setAspects(<aspect:metallum>*1);                      #Pigiron ingot
<tconstruct:metal:4>                            .setAspects(<aspect:metallum>*67  ,<aspect:bestia>*33);#Pigiron block

/*
#######################################################
___ _ _  _ _  _ ____ ____ . ____    ____ _  _ ____ _    _  _ ___ _ ____ _  _ 
 |  | |\ | |_/  |___ |__/ ' [__     |___ |  | |  | |    |  |  |  | |  | |\ | 
 |  | | \| | \_ |___ |  \   ___]    |___  \/  |__| |___ |__|  |  | |__| | \| 
                                                                             
#######################################################
*/

<tconevo:metal:25>                              .setAspects(<aspect:metallum>*20  ,<aspect:sanguis>*10); #Bound ingot
<tconevo:metal:27>                              .setAspects(<aspect:metallum>*2   ,<aspect:sanguis>*1);  #Bound nugget
<tconevo:metal_block:5>                         .setAspects(<aspect:metallum>*133 ,<aspect:sanguis>*67); #Bound block
<tconevo:metal:30>                              .setAspects(<aspect:metallum>*20  ,<aspect:spiritus>*10); #Sentient ingot
<tconevo:metal:32>                              .setAspects(<aspect:metallum>*2   ,<aspect:spiritus>*1);  #Sentient nugget
<tconevo:metal_block:6>                         .setAspects(<aspect:metallum>*133 ,<aspect:spiritus>*67); #Sentient block
<tconevo:metal:35>                              .setAspects(<aspect:metallum>*20  ,<aspect:potentia>*10); #Energium ingot
<tconevo:metal:37>                              .setAspects(<aspect:metallum>*2   ,<aspect:potentia>*1);  #Energium nugget
<tconevo:metal_block:7>                         .setAspects(<aspect:metallum>*133 ,<aspect:potentia>*67); #Energium block
<tconevo:metal:40>                              .setAspects(<aspect:metallum>*20  ,<aspect:humanus>*10); #UU-metal ingot
<tconevo:metal:42>                              .setAspects(<aspect:metallum>*2   ,<aspect:humanus>*1);  #UU-metal nugget
<tconevo:metal_block:8>                         .setAspects(<aspect:metallum>*133 ,<aspect:humanus>*67); #UU-metal block
<tconevo:edible>                                .setAspects(<aspect:metallum>*10  ,<aspect:victus>*5); #Raw meat ingot
<tconevo:edible:1>                              .setAspects(<aspect:metallum>*10  ,<aspect:bestia>*5); #Cooked meat ingot
<tconevo:metal:15>                              .setAspects(<aspect:metallum>*20  ,<aspect:exanimis>*25); #Essence-Infused ingot
<tconevo:metal:17>                              .setAspects(<aspect:metallum>*2   ,<aspect:exanimis>*2);  #Essence-Infused nugget
<tconevo:metal_block:3>                         .setAspects(<aspect:metallum>*133 ,<aspect:exanimis>*167);#Essence-Infused block
<tconevo:metal>                                 .setAspects(<aspect:metallum>*100 ,Aspect.caeles*50); #Wyvern ingot
<tconevo:metal:2>                               .setAspects(<aspect:metallum>*10  ,Aspect.caeles*5);  #Wyvern nugget
<tconevo:metal_block>                           .setAspects(<aspect:metallum>*500 ,Aspect.caeles*333);#Wyvern block
<tconevo:metal:5>                               .setAspects(<aspect:metallum>*100 ,<aspect:draco>*50); #Draconic ingot
<tconevo:metal:7>                               .setAspects(<aspect:metallum>*10  ,<aspect:draco>*5);  #Draconic nugget
<tconevo:metal_block:1>                         .setAspects(<aspect:metallum>*500 ,<aspect:draco>*333);#Draconic block
<tconevo:metal:10>                              .setAspects(<aspect:metallum>*100 ,<aspect:rattus>*50); #Chaotic ingot
<tconevo:metal:12>                              .setAspects(<aspect:metallum>*10  ,<aspect:rattus>*5);  #Chaotic nugget
<tconevo:metal_block:2>                         .setAspects(<aspect:metallum>*500 ,<aspect:rattus>*333);#Chaotic block
<tconevo:metal:20>                              .setAspects(<aspect:metallum>*20  ,<aspect:aqua>*10,<aspect:ignis>*10,<aspect:terra>*10,<aspect:perditio>*10,<aspect:ordo>*10,<aspect:aer>*10); #Primordial ingot
<tconevo:metal:22>                              .setAspects(<aspect:metallum>*2   ,<aspect:aqua>*1, <aspect:ignis>*1, <aspect:terra>*1, <aspect:perditio>*1, <aspect:ordo>*1, <aspect:aer>*1); #Primordial nugget
<tconevo:metal_block:4>                         .setAspects(<aspect:metallum>*133 ,<aspect:aqua>*67,<aspect:ignis>*67,<aspect:terra>*67,<aspect:perditio>*67,<aspect:ordo>*67,<aspect:aer>*167); #Primordial block

/*
#######################################################
___ _  _ ____ _  _ _  _ ____ ____ ____ ____ ___ 
 |  |__| |__| |  | |\/| |    |__/ |__| |___  |  
 |  |  | |  | |__| |  | |___ |  \ |  | |     |  
                                                
#######################################################
*/

<thaumcraft:alumentum>                         .setAspects(<aspect:ignis>*2       , <aspect:potentia>*2);
<thaumcraft:condenser_lattice_dirty>           .setAspects(<aspect:vitium>*10); 
<thaumcraft:ingot:2>                           .setAspects(<aspect:metallum>*5    , <aspect:instrumentum>*2);

<thaumcraft:bath_salts>                        .setAspects(<aspect:ordo>*1        , <aspect:victus>*1);
<thaumcraft:sanity_soap>                       .setAspects(<aspect:ordo>*2        , <aspect:victus>*2         ,<aspect:mana>*2);
<thaumicaugmentation:bars>                     .setAspects(<aspect:metallum>);

<thaumcraft:ingot>                              .setAspects(<aspect:metallum>*10        , <aspect:praecantatio>*5);
<thaumcraft:nugget:6>                           .setAspects(<aspect:metallum>*1);
<thaumcraft:metal_thaumium>                     .setAspects(<aspect:metallum>*67        , <aspect:praecantatio>*33);
<thaumcraft:plate:2>                            .setAspects(<aspect:metallum>*10        , <aspect:praecantatio>*5,  <aspect:instrumentum>*2);
<mysticalagriculture:thaumium_seeds>            .setAspects(<aspect:metallum>*10        , <aspect:praecantatio>*5,  <aspect:herba>*20);
<mysticalagriculture:thaumium_essence>          .setAspects(<aspect:metallum>*10        , <aspect:praecantatio>*25);

<thaumcraft:ingot:1>                            .setAspects(<aspect:metallum>*10        , <aspect:vitium>*5);
<thaumcraft:nugget:7>                           .setAspects(<aspect:metallum>*1);
<thaumcraft:metal_void>                         .setAspects(<aspect:metallum>*67        , <aspect:vitium>*33);
<thaumcraft:plate:3>                            .setAspects(<aspect:metallum>*10        , <aspect:vitium>*5,  <aspect:instrumentum>*2);
<mysticalagriculture:void_metal_seeds>          .setAspects(<aspect:metallum>*10        , <aspect:vitium>*5,  <aspect:herba>*20);
<mysticalagriculture:void_metal_essence>        .setAspects(<aspect:metallum>*10        , <aspect:vitium>*5,  <aspect:praecantatio>*20);

<thaumicwonders:alienist_stone>                 .setAspects(<aspect:tenebrae>*10        , <aspect:praecantatio>*15,   <aspect:alkimia>*15);
<thaumicwonders:transmuter_stone>               .setAspects(<aspect:motus>*10           , <aspect:permutatio>*15,     <aspect:alkimia>*15);
<thaumicwonders:alchemist_stone>                .setAspects(<aspect:metallum>*10        , <aspect:ordo>*15,           <aspect:alkimia>*15);

val nitor = [
<thaumcraft:nitor_white>,
<thaumcraft:nitor_orange>,
<thaumcraft:nitor_magenta>,
<thaumcraft:nitor_lightblue>,
<thaumcraft:nitor_yellow>,
<thaumcraft:nitor_lime>,
<thaumcraft:nitor_pink>,
<thaumcraft:nitor_gray>,
<thaumcraft:nitor_silver>,
<thaumcraft:nitor_cyan>,
<thaumcraft:nitor_purple>,
<thaumcraft:nitor_blue>,
<thaumcraft:nitor_brown>,
<thaumcraft:nitor_green>,
<thaumcraft:nitor_red>,
<thaumcraft:nitor_black>
 ] as IItemStack[];
for nitor in nitor{
  nitor.setAspects(<aspect:lux>*2,<aspect:sensus>);
}


/*
#######################################################
___ _ _ _ _ _    _ ____ _  _ ___    ____ ____ ____ ____ ____ ___ 
 |  | | | | |    | | __ |__|  |     |___ |  | |__/ |___ [__   |  
 |  |_|_| | |___ | |__] |  |  |     |    |__| |  \ |___ ___]  |  
                                                                 
#######################################################
*/

<mysticalagriculture:fiery_ingot_seeds>         .setAspects(<aspect:metallum>*15  ,<aspect:ignis>*40    ,<aspect:auram>*12    ,<aspect:herba>*20); 
<mysticalagriculture:fiery_ingot_essence>       .setAspects(<aspect:metallum>*15  ,<aspect:ignis>*40    ,<aspect:auram>*12    ,<aspect:praecantatio>*20); 

<twilightforest:ironwood_ingot>                 .setAspects(<aspect:metallum>*10  ,<aspect:herba>*5); 
<mysticalagriculture:ironwood_seeds>            .setAspects(<aspect:metallum>*10  ,<aspect:herba>*20); 
<mysticalagriculture:ironwood_essence>          .setAspects(<aspect:metallum>*10  ,<aspect:herba>*5     ,<aspect:praecantatio>*15); 
<twilightforest:knightmetal_ingot>              .setAspects(<aspect:metallum>*10  ,<aspect:praemunio>*5); 
<twilightforest:armor_shard_cluster>            .setAspects(<aspect:metallum>*5  ,<aspect:praemunio>*10); 
<mysticalagriculture:knightmetal_seeds>         .setAspects(<aspect:metallum>*10  ,<aspect:praemunio>*5 ,<aspect:herba>*20); 
<mysticalagriculture:knightmetal_essence>       .setAspects(<aspect:metallum>*10  ,<aspect:praemunio>*5 ,<aspect:praecantatio>*20); 
<twilightforest:auroralized_glass>              .setAspects(<aspect:vitreus>*5    ,<aspect:alienis>*10); 

/*
#######################################################
_  _ ____ _  _ _ _    _    ____   / _  _ _ _  _ ____ ____ ____ ____ ____ ___ 
|  | |__| |\ | | |    |    |__|  /  |\/| | |\ | |___ |    |__/ |__| |___  |  
 \/  |  | | \| | |___ |___ |  | /   |  | | | \| |___ |___ |  \ |  | |     |  
                                                                             
#######################################################
*/

<minecraft:stone:3>                             .setAspects(<aspect:terra>*5      ,<aspect:ordo>); #diorite
<minecraft:stone:5>                             .setAspects(<aspect:terra>*5      ,<aspect:perditio>); #andesite
<minecraft:stone:1>                             .setAspects(<aspect:terra>*5      ,<aspect:ignis>); #granite
<minecraft:web>                                 .setAspects(<aspect:bestia>*5     ,<aspect:vinculum>*2);
<minecraft:iron_block>                          .setAspects(<aspect:metallum>*101);
<minecraft:gold_block>                          .setAspects(<aspect:metallum>*67   ,<aspect:desiderium>*33);

<minecraft:skull:1>                             .setAspects(<aspect:spiritus>*10  ,Aspect.infernum*10       ,<aspect:tenebrae>*5       ,<aspect:perditio>*5); #wither skull

/*
#######################################################
_  _ _  _ _    ___  ____ ____    _    _ ___  ____ ____ ____ _   _ 
|  | |  | |    |__] |___ [__     |    | |__] |__/ |__| |__/  \_/  
 \/  |__| |___ |    |___ ___]    |___ | |__] |  \ |  | |  \   |   
                                                                  
#######################################################
*/

<libvulpes:productsheet:1>                    .setAspects(<aspect:metallum>*21); 
<libvulpes:productsheet:4>                    .setAspects(<aspect:metallum>*14    ,<aspect:permutatio>*7); 
<libvulpes:productsheet:6>                    .setAspects(<aspect:metallum>*21    ,<aspect:ordo>*7); 
<libvulpes:productsheet:7>                    .setAspects(<aspect:metallum>*14    ,<aspect:gelum>*7); 
<libvulpes:productsheet:9>                    .setAspects(<aspect:metallum>*14    ,<aspect:aer>*7); 

# Removing wrong aspects from stuff
<conarm:armor_trim:*>.setAspects(<aspect:terra>);
<harvestcraft:freshwateritem>.removeAspects(<aspect:metallum>);

# Override aspects
<rats:rat_diamond>                             .setAspects(<aspect:desiderium>*4  ,<aspect:vitreus>*4      , <aspect:rattus>*4);
<enderio:block_enderman_skull>                 .setAspects(<aspect:mortuus>*40    ,<aspect:alienis>*50     ,<aspect:tenebrae>*60);
<ic2:dust:5>                                   .setAspects(<aspect:desiderium>*20 ,<aspect:vitreus>*15);
<additionalcompression:gemdiamond_compressed:1>.setAspects(<aspect:desiderium>*500,<aspect:vitreus>*500);
<additionalcompression:gemdiamond_compressed:2>.setAspects(<aspect:desiderium>*500,<aspect:vitreus>*500    ,Aspect.caeles*100);
<mekanism:compresseddiamond>                   .setAspects(<aspect:desiderium>*20 ,<aspect:vitreus>*20);
<thermalfoundation:material:26>                .setAspects(<aspect:desiderium>*50 ,<aspect:machina>*40);
<actuallyadditions:item_crystal:2>             .setAspects(<aspect:desiderium>*20 ,<aspect:vitreus>*20     , <aspect:potentia>*80);
<actuallyadditions:block_crystal:2>            .setAspects(<aspect:desiderium>*140,<aspect:vitreus>*140    , <aspect:potentia>*80);
<actuallyadditions:item_crystal_empowered:2>   .setAspects(<aspect:desiderium>*60 ,<aspect:vitreus>*60     , <aspect:potentia>*150);
<actuallyadditions:block_crystal_empowered:2>  .setAspects(<aspect:desiderium>*400,<aspect:vitreus>*400    , <aspect:potentia>*400);
<extrautils2:compressedcobblestone:0>          .setAspects(<aspect:terra>*45      , <aspect:perditio>*9);
<extrautils2:compressedcobblestone:1>          .setAspects(<aspect:terra>*405     , <aspect:perditio>*81);
<extrautils2:compressedcobblestone:2>          .setAspects(<aspect:terra>*500     , <aspect:perditio>*500);
<biomesoplenty:hard_ice>                       .setAspects(<aspect:gelum>*21);
<appliedenergistics2:sky_stone_block>          .setAspects(<aspect:alienis>*2     , <aspect:tenebrae>*7);
<minecraft:sugar>                              .setAspects(<aspect:desiderium>    , <aspect:aqua>);

/*
███╗░░░███╗███████╗████████╗░█████╗░██╗░░░░░██╗░░░░░██╗░░░██╗██████╗░░██████╗░██╗░░░██╗
████╗░████║██╔════╝╚══██╔══╝██╔══██╗██║░░░░░██║░░░░░██║░░░██║██╔══██╗██╔════╝░╚██╗░██╔╝
██╔████╔██║█████╗░░░░░██║░░░███████║██║░░░░░██║░░░░░██║░░░██║██████╔╝██║░░██╗░░╚████╔╝░
██║╚██╔╝██║██╔══╝░░░░░██║░░░██╔══██║██║░░░░░██║░░░░░██║░░░██║██╔══██╗██║░░╚██╗░░╚██╔╝░░
██║░╚═╝░██║███████╗░░░██║░░░██║░░██║███████╗███████╗╚██████╔╝██║░░██║╚██████╔╝░░░██║░░░
╚═╝░░░░░╚═╝╚══════╝░░░╚═╝░░░╚═╝░░╚═╝╚══════╝╚══════╝░╚═════╝░╚═╝░░╚═╝░╚═════╝░░░░╚═╝░░░
*/

/*
Just a list of aspect - metal
<aspect:amogus>,        - null
<aspect:ignis>,         - fiery ingot
<aspect:herba>,         - ironwood
Aspect.ventus,        - lithium
<aspect:exanimis>,      - essence infused
<aspect:praemunio>,     - knight metal
<aspect:tenebrae>,      - thorium
<aspect:instrumentum>,  - alchemical brass?
<aspect:aer>,           - aluminium
<aspect:terra>,         - osmium
<aspect:rattus>,        - chaotic
<aspect:spiritus>,      - sentient
<aspect:aqua>,          - knightslime
<aspect:perditio>,      - heavy metal
<aspect:ordo>,          - lead
<aspect:metallum>,      - iron
<aspect:sanguis>,       - bounded
Aspect.imperium,      - nickiel
<aspect:sensus>,        - platinum
<aspect:alienis>,       - enderium
<aspect:victus>,        - raw meat
<aspect:mythus>,        - silver
<aspect:praecantatio>,  - thaumium?
Aspect.fluctus,       - iridium
Aspect.visum,         - osgloglas
<aspect:vinculum>,      - bronze
<aspect:fabrico>,       - invar
<aspect:alkimia>,       - alchemical brass
<aspect:volatus>,       - cobalt
<aspect:draco>,         - draconic metal
Aspect.sonus,         - constantant
<aspect:vitium>,        - void metal
<aspect:vacuos>,        - tungsten
Aspect.caeles,        - wyvern metal
<aspect:lux>,           - lumium
<aspect:permutatio>,    - copper
<aspect:humanus>,       - UU metal, boron
<aspect:machina>,       - signalium
<aspect:desiderium>,    - gold
<aspect:vitreus>,       - tin
<aspect:motus>,         - electrum
Aspect.exitium,       - ardite
<aspect:cognitio>,      - enchanted metal
<aspect:mana>,          - manasteel
Aspect.infernum,      - demon metal
<aspect:mortuus>,       - uranium
<aspect:aversio>,       - manyullyn
<aspect:potentia>,      - energium
<aspect:auram>,         - mana infused, magnesium
<aspect:bestia>,        - cooked meat, pigiron
<aspect:gelum>,         - titanium
*/

function calculateAspects(main as float, secondary as float, a1 as CTAspectStack, a2 as CTAspectStack, a3 as CTAspectStack) as CTAspectStack[] {
  var list = [] as CTAspectStack[];
  list+=a1.setAmount(main as int);
  if (secondary>=1) list+=a2.setAmount(secondary as int);
  if (!isNull(a3)) list+=a3.setAmount(main as int); 
  return list;
}

function addMetallurgicAspects(mul as float, mulAs as float, tier as int,
  ingot as IItemStack,          nugget as IItemStack,   block as IItemStack,    dust as IItemStack,
  plate as IItemStack,      densePlate as IItemStack,    sheetBlock as IItemStack,    case as IItemStack, gear as IItemStack,     
  cluster as IItemStack, crystal as IItemStack, crystalCompacted as IItemStack, rockyChunk as IItemStack,
  chunk as IItemStack, alchemicalDust as IItemStack, dirty as IItemStack,
  ore as IItemStack, oreNether as IItemStack, oreEnd as IItemStack,
  crushed as IItemStack, crushedPurfired as IItemStack,
  seed as IItemStack, essence as IItemStack,
  aspectMain as CTAspectStack, aspectSec as CTAspectStack, aspectThird as CTAspectStack = null) as void
{
  if(!isNull(ingot))  ingot     .setAspects(calculateAspects(10.0*mul, 5.0*mulAs, aspectMain, aspectSec, aspectThird));
  if(!isNull(nugget)) nugget    .setAspects(calculateAspects(1.0*mul, 0.5*mulAs, aspectMain, aspectSec, aspectThird));
  if(!isNull(block))  block     .setAspects(calculateAspects(67.0*mul, 33.5*mulAs, aspectMain, aspectSec, aspectThird));
  if(!isNull(dust))   dust      .setAspects(calculateAspects(10.0*mul, 5.0*mulAs, aspectMain, aspectSec, aspectThird) + <aspect:perditio>*5);

  if(!isNull(plate))      plate     .setAspects(calculateAspects(10.0*mul, 5.0*mulAs, aspectMain, aspectSec, aspectThird) + <aspect:instrumentum>*2);
  if(!isNull(densePlate)) densePlate.setAspects(calculateAspects(67.0*mul, 33.5*mulAs, aspectMain, aspectSec, aspectThird)+ <aspect:instrumentum>*13);
  if(!isNull(sheetBlock)) sheetBlock.setAspects(calculateAspects(10.0*mul, 5.0*mulAs, aspectMain, aspectSec, aspectThird));
  if(!isNull(case))       case      .setAspects(calculateAspects(2.0*mul, 2.0*mulAs, aspectMain, aspectSec, aspectThird)+ <aspect:instrumentum>*2);
  if(!isNull(gear))       gear      .setAspects(calculateAspects(30.0*mul, 15.0*mulAs, aspectMain, aspectSec, aspectThird)+ <aspect:machina>*5);
  
  if(!isNull(cluster))          cluster         .setAspects(calculateAspects(15.0*mul, 10.0*mulAs, aspectMain, aspectSec, aspectThird)+ <aspect:ordo>*5+ <aspect:terra>*5);
  if(!isNull(crystal))          crystal         .setAspects(calculateAspects(15.0*mul, 10.0*mulAs, aspectMain, aspectSec, aspectThird)+ <aspect:ordo>*10 );
  if(!isNull(crystalCompacted)) crystalCompacted.setAspects(calculateAspects(60.0*mul, 40.0*mulAs, aspectMain, aspectSec, aspectThird)+ <aspect:vitreus>*20 );
  if(!isNull(rockyChunk))       rockyChunk      .setAspects(calculateAspects(150.0*mul, 100.0*mulAs, aspectMain, aspectSec, aspectThird)+ <aspect:vitreus>*50+ <aspect:desiderium>*100 );
  if(!isNull(chunk))            chunk           .setAspects(calculateAspects(250.0*mul, 200.0*mulAs, aspectMain, aspectSec, aspectThird)+ <aspect:vitreus>*75+ <aspect:permutatio>*100 );
  if(!isNull(alchemicalDust))   alchemicalDust  .setAspects(calculateAspects(500.0*mul, 500.0*mulAs, aspectMain, aspectSec, aspectThird)+ <aspect:ordo>*250+ <aspect:praecantatio>*250+ Aspect.caeles*50 );
  if(!isNull(dirty))            dirty           .setAspects(calculateAspects(60.0*mul, 40.0*mulAs, aspectMain, aspectSec, aspectThird)+ <aspect:permutatio>*30 );
  
  if(!isNull(ore))        ore       .setAspects(calculateAspects(10.0*mul, 5.0*mulAs, aspectMain, aspectSec, aspectThird)+  <aspect:terra>*5 );
  if(!isNull(oreNether))  oreNether .setAspects(calculateAspects(20.0*mul, 10.0*mulAs, aspectMain, aspectSec, aspectThird)+ <aspect:ignis>*10 );
  if(!isNull(oreEnd))     oreEnd    .setAspects(calculateAspects(40.0*mul, 20.0*mulAs, aspectMain, aspectSec, aspectThird)+ <aspect:alienis>*10 );

  if(!isNull(crushed))          crushed         .setAspects(calculateAspects(10.0*mul, 5.0*mulAs, aspectMain, aspectSec, aspectThird)+ <aspect:perditio>*1 );
  if(!isNull(crushedPurfired))  crushedPurfired .setAspects(calculateAspects(10.0*mul, 5.0*mulAs, aspectMain, aspectSec, aspectThird)+ <aspect:ordo>*1 );

  if(!isNull(seed))     seed      .setAspects(calculateAspects(10.0*mul, 5.0*mulAs, aspectMain, aspectSec, aspectThird)+ <aspect:herba>*(((5.0*tier)as int)) );
  if(!isNull(essence))  essence   .setAspects(calculateAspects(10.0*mul, 5.0*mulAs, aspectMain, aspectSec, aspectThird)+ <aspect:praecantatio>*(((5.0*tier)as int)) );
}

#Iron
addMetallurgicAspects
(1,1,3,
<minecraft:iron_ingot>,<minecraft:iron_nugget>,<minecraft:iron_block>,<thermalfoundation:material>,
<thermalfoundation:material:32>,<ic2:plate:12>,<immersiveengineering:sheetmetal:9>,<ic2:casing:3>,<thermalfoundation:material:24>,
<thaumcraft:cluster>, <jaopca:item_crystalshardiron>, <jaopca:item_crystalabyssiron>, 
<jaopca:item_rockychunkiron>, <jaopca:item_chunkiron>, <jaopca:item_dustalchiron>,<jaopca:item_dirtygemiron>,
<minecraft:iron_ore>, <netherendingores:ore_nether_vanilla:4>, <netherendingores:ore_end_vanilla:4>, <ic2:crushed:2>, <ic2:purified:2>,
<mysticalagriculture:iron_seeds>,<mysticalagriculture:iron_essence>,
<aspect:metallum>,<aspect:metallum>);

#Gold
addMetallurgicAspects
(1,2,4,
<minecraft:gold_ingot>,<minecraft:gold_nugget>,<minecraft:gold_block>,<thermalfoundation:material:1>,
<thermalfoundation:material:33>,<ic2:plate:11>,<immersiveengineering:sheetmetal:10>,<ic2:casing:2>,<thermalfoundation:material:25>,
<thaumcraft:cluster:1>, <jaopca:item_crystalshardgold>, <jaopca:item_crystalabyssgold>, 
<jaopca:item_rockychunkgold>, <jaopca:item_chunkgold>, <jaopca:item_dustalchgold>,<jaopca:item_dirtygemgold>,
<minecraft:gold_ore>, <netherendingores:ore_nether_vanilla:3>, <netherendingores:ore_end_vanilla:3>, <ic2:crushed:1>, <ic2:purified:1>,
<mysticalagriculture:gold_seeds>,<mysticalagriculture:gold_essence>,
<aspect:metallum>,<aspect:desiderium>);

#Diamond
addMetallurgicAspects
(2,2,4,
<minecraft:diamond>,<thermalfoundation:material:16>,<minecraft:diamond_block>,<ic2:dust:5>,
null,null,null,null,<thermalfoundation:material:26>,
<jaopca:item_clusterdiamond>,<jaopca:item_crystalsharddiamond>,<jaopca:item_crystalabyssdiamond>,
<jaopca:item_rockychunkdiamond>,<jaopca:item_chunkdiamond>,<jaopca:item_dustalchdiamond>,<jaopca:item_dirtygemdiamond>,
<minecraft:diamond_ore>,<netherendingores:ore_nether_vanilla:1>,<netherendingores:ore_end_vanilla:1>,
null,null,
<mysticalagriculture:diamond_seeds>,<mysticalagriculture:diamond_essence>,
<aspect:vitreus>, <aspect:desiderium>);

#Emerald
addMetallurgicAspects
(1.5,2,4,
<minecraft:emerald>,<thermalfoundation:material:17>,<minecraft:emerald_block>,<actuallyadditions:item_dust:3>,
null,null,null,null,<thermalfoundation:material:27>,
<jaopca:item_clusteremerald>,<jaopca:item_crystalshardemerald>,<jaopca:item_crystalabyssemerald>,
<jaopca:item_rockychunkemerald>,<jaopca:item_chunkemerald>,<jaopca:item_dustalchemerald>,<jaopca:item_dirtygememerald>,
<minecraft:emerald_ore>,<netherendingores:ore_nether_vanilla:2>,<netherendingores:ore_end_vanilla:2>,null,null,
null,null,
<aspect:vitreus>, <aspect:desiderium>);

#Copper
addMetallurgicAspects
(1,1,2,
<thermalfoundation:material:128>,<thermalfoundation:material:192>,<thermalfoundation:storage>,
<thermalfoundation:material:64>,<thermalfoundation:material:320>,<ic2:plate:10>,<immersiveengineering:sheetmetal>,<ic2:casing:1>,<thermalfoundation:material:256>,
<thaumcraft:cluster:2>,<jaopca:item_crystalshardcopper>,<jaopca:item_crystalabysscopper>,<jaopca:item_rockychunkcopper>,
<jaopca:item_chunkcopper>,<jaopca:item_dustalchcopper>,<jaopca:item_dirtygemcopper>,
<thermalfoundation:ore>,<netherendingores:ore_nether_modded_1:1>,<netherendingores:ore_end_modded_1:1>,
<ic2:crushed>,<ic2:purified>,
<mysticalagriculture:copper_seeds>,<mysticalagriculture:copper_essence>,
<aspect:metallum>, <aspect:permutatio>);

#Tin
addMetallurgicAspects
(1,1,2,
<thermalfoundation:material:129>,<thermalfoundation:material:193>,<thermalfoundation:storage:1>,<thermalfoundation:material:65>,
<thermalfoundation:material:321>,<ic2:plate:17>,null,<ic2:casing:6>,<thermalfoundation:material:257>,
<thaumcraft:cluster:3>,<jaopca:item_crystalshardtin>,<jaopca:item_crystalabysstin>,<jaopca:item_rockychunktin>,
<jaopca:item_chunktin>,<jaopca:item_dustalchtin>,<jaopca:item_dirtygemtin>,
<thermalfoundation:ore:1>,<netherendingores:ore_nether_modded_1:8>,<netherendingores:ore_end_modded_1:8>,
<ic2:crushed:5>,<ic2:purified:5>,
<mysticalagriculture:tin_seeds>,<mysticalagriculture:tin_essence>,
<aspect:metallum>, <aspect:vitreus>);

#Silver
addMetallurgicAspects
(1,1,3,
<thermalfoundation:material:130>,<thermalfoundation:material:194>,<thermalfoundation:storage:2>,<thermalfoundation:material:66>,
<thermalfoundation:material:322>,null,<immersiveengineering:sheetmetal:3>,null,<thermalfoundation:material:258>,
<thaumcraft:cluster:4>,<jaopca:item_crystalshardsilver>,<jaopca:item_crystalabysssilver>,<jaopca:item_rockychunksilver>,
<jaopca:item_chunksilver>,<jaopca:item_dustalchsilver>,<jaopca:item_dirtygemsilver>,
<thermalfoundation:ore:2>,<netherendingores:ore_nether_modded_1:7>,<netherendingores:ore_end_modded_1:7>,
<ic2:crushed:4>,<ic2:purified:4>,
<mysticalagriculture:silver_seeds>,<mysticalagriculture:silver_essence>,
<aspect:metallum>, <aspect:mythus>);

#Lead
addMetallurgicAspects
(1,1,3,
<thermalfoundation:material:131>,<thermalfoundation:material:195>,<thermalfoundation:storage:3>,<thermalfoundation:material:67>,
<thermalfoundation:material:323>,<ic2:plate:14>,<immersiveengineering:sheetmetal:2>,<ic2:casing:4>,<thermalfoundation:material:259>,
<thaumcraft:cluster:5>,<jaopca:item_crystalshardlead>,<jaopca:item_crystalabysslead>,<jaopca:item_rockychunklead>,
<jaopca:item_chunklead>,<jaopca:item_dustalchlead>,<jaopca:item_dirtygemlead>,
<thermalfoundation:ore:3>,<netherendingores:ore_nether_modded_1:3>,<netherendingores:ore_end_modded_1:3>,
<ic2:crushed:3>,<ic2:purified:3>,
<mysticalagriculture:lead_seeds>,<mysticalagriculture:lead_essence>,
<aspect:metallum>, <aspect:ordo>);

#Aluminium
addMetallurgicAspects
(1,1,3,
<thermalfoundation:material:132>,<thermalfoundation:material:196>,<thermalfoundation:storage:4>,<thermalfoundation:material:68>,
<thermalfoundation:material:324>,null,<immersiveengineering:sheetmetal:1>,null,<thermalfoundation:material:260>,
<jaopca:item_clusteraluminium>,<jaopca:item_crystalshardaluminium>,<jaopca:item_crystalabyssaluminium>,<jaopca:item_rockychunkaluminium>,
<jaopca:item_chunkaluminium>,<jaopca:item_dustalchaluminium>,<jaopca:item_dirtygemaluminium>,
<thermalfoundation:ore:4>,<netherendingores:ore_nether_modded_1>,<netherendingores:ore_end_modded_1>,
<jaopca:item_crushedaluminium>,<jaopca:item_crushedpurifiedaluminium>,
<mysticalagriculture:aluminum_seeds>,<mysticalagriculture:aluminum_essence>,
<aspect:metallum>, <aspect:aer>);

#Nickiel
addMetallurgicAspects
(1,1,4,
<thermalfoundation:material:133>,<thermalfoundation:material:197>,<thermalfoundation:storage:5>,<thermalfoundation:material:69>,
<thermalfoundation:material:325>,null,<immersiveengineering:sheetmetal:4>,null,<thermalfoundation:material:261>,
<jaopca:item_clusternickel>,<jaopca:item_crystalshardnickel>,<jaopca:item_crystalabyssnickel>,<jaopca:item_rockychunknickel>,
<jaopca:item_chunknickel>,<jaopca:item_dustalchnickel>,<jaopca:item_dirtygemnickel>,
<thermalfoundation:ore:5>,<netherendingores:ore_nether_modded_1:5>,<netherendingores:ore_end_modded_1:5>,
<jaopca:item_crushednickel>,<jaopca:item_crushedpurifiednickel>,
<mysticalagriculture:nickel_seeds>,<mysticalagriculture:nickel_essence>,
<aspect:metallum>, Aspect.imperium);

#Platinum
addMetallurgicAspects
(2,1,5,
<thermalfoundation:material:134>,<thermalfoundation:material:198>,<thermalfoundation:storage:6>,<thermalfoundation:material:70>,
<thermalfoundation:material:326>,null,null,null,<thermalfoundation:material:262>,
<jaopca:item_clusterplatinum>,<jaopca:item_crystalshardplatinum>,<jaopca:item_crystalabyssplatinum>,<jaopca:item_rockychunkplatinum>,
<jaopca:item_chunkplatinum>,<jaopca:item_dustalchplatinum>,<jaopca:item_dirtygemplatinum>,
<thermalfoundation:ore:6>,<netherendingores:ore_nether_modded_1:6>,<netherendingores:ore_end_modded_1:6>,
<jaopca:item_crushedplatinum>,<jaopca:item_crushedpurifiedplatinum>,
<mysticalagriculture:platinum_seeds>,<mysticalagriculture:platinum_essence>,
<aspect:metallum>, <aspect:sensus>);

#Iridium
addMetallurgicAspects
(2,2,6,
<thermalfoundation:material:135>,<thermalfoundation:material:199>,<thermalfoundation:storage:7>,<thermalfoundation:material:71>,
<thermalfoundation:material:327>,null,null,null,<thermalfoundation:material:263>,
<jaopca:item_clusteriridium>,<jaopca:item_crystalshardiridium>,<jaopca:item_crystalabyssiridium>,<jaopca:item_rockychunkiridium>,
<jaopca:item_chunkiridium>,<jaopca:item_dustalchiridium>,<jaopca:item_dirtygemiridium>,
<thermalfoundation:ore:7>,null,null,
<jaopca:item_crushediridium>,<jaopca:item_crushedpurifiediridium>,
<mysticalagriculture:iridium_seeds>,<mysticalagriculture:iridium_essence>,
<aspect:metallum>, Aspect.fluctus);

#ManaInfused
addMetallurgicAspects
(2,1,0,
<thermalfoundation:material:136>,<thermalfoundation:material:200>,<thermalfoundation:storage:8>,<thermalfoundation:material:72>,
<thermalfoundation:material:328>,null,null,null,<thermalfoundation:material:264>,
<jaopca:item_clustermithril>,<jaopca:item_crystalshardmithril>,<jaopca:item_crystalabyssmithril>,<jaopca:item_rockychunkmithril>,
<jaopca:item_chunkmithril>,<jaopca:item_dustalchmithril>,<jaopca:item_dirtygemmithril>,
<thermalfoundation:ore:8>,null,<netherendingores:ore_end_modded_1:4>,
<jaopca:item_crushedmithril>,<jaopca:item_crushedpurifiedmithril>,
null,null,
<aspect:metallum>, <aspect:auram>);

#Steel
addMetallurgicAspects
(1.5,1,0,
<thermalfoundation:material:160>,<thermalfoundation:material:224>,<thermalfoundation:storage_alloy>,<thermalfoundation:material:96>,
<thermalfoundation:material:352>,<ic2:plate:16>,<immersiveengineering:sheetmetal:8>,<ic2:casing:5>,<thermalfoundation:material:288>,
null,null,null,null,
null,null,null,
null,null,null,
null,null,
null,null,
<aspect:metallum>, <aspect:ordo>);

#Electrum
addMetallurgicAspects
(1,1,0,
<thermalfoundation:material:161>,<thermalfoundation:material:225>,<thermalfoundation:storage_alloy:1>,<thermalfoundation:material:97>,
<thermalfoundation:material:353>,null,<immersiveengineering:sheetmetal:7>,null,<thermalfoundation:material:289>,
null,null,null,null,
null,null,null,
null,null,null,
null,null,
null,null,
<aspect:metallum>, <aspect:motus>);

#Invar
addMetallurgicAspects
(1,1,0,
<thermalfoundation:material:162>,<thermalfoundation:material:226>,<thermalfoundation:storage_alloy:2>,<thermalfoundation:material:98>,
<thermalfoundation:material:354>,null,null,null,<thermalfoundation:material:290>,
null,null,null,null,
null,null,null,
null,null,null,
null,null,
null,null,
<aspect:metallum>, <aspect:fabrico>);

#Bronze
addMetallurgicAspects
(1,1,0,
<thermalfoundation:material:163>,<thermalfoundation:material:227>,<thermalfoundation:storage_alloy:3>,<thermalfoundation:material:99>,
<thermalfoundation:material:355>,<ic2:plate:9>,null,<ic2:casing>,<thermalfoundation:material:291>,
null,null,null,null,
null,null,null,
null,null,null,
null,null,
null,null,
<aspect:metallum>, <aspect:vinculum>);

#Constantant
addMetallurgicAspects
(1,1,0,
<thermalfoundation:material:164>,<thermalfoundation:material:228>,<thermalfoundation:storage_alloy:4>,<thermalfoundation:material:100>,
<thermalfoundation:material:356>,null,null,null,<thermalfoundation:material:292>,
null,null,null,null,
null,null,null,
null,null,null,
null,null,
null,null,
<aspect:metallum>, Aspect.sonus);

#Signalum
addMetallurgicAspects
(1,1,0,
<thermalfoundation:material:165>,<thermalfoundation:material:229>,<thermalfoundation:storage_alloy:5>,<thermalfoundation:material:101>,
<thermalfoundation:material:357>,null,null,null,<thermalfoundation:material:293>,
null,null,null,null,
null,null,null,
null,null,null,
null,null,
null,null,
<aspect:metallum>, <aspect:machina>);

#Lumium
addMetallurgicAspects
(1,1,0,
<thermalfoundation:material:166>,<thermalfoundation:material:230>,<thermalfoundation:storage_alloy:6>,<thermalfoundation:material:102>,
<thermalfoundation:material:358>,null,null,null,<thermalfoundation:material:294>,
null,null,null,null,
null,null,null,
null,null,null,
null,null,
null,null,
<aspect:metallum>, <aspect:lux>);

#Ednerium
addMetallurgicAspects
(2,2,6,
<thermalfoundation:material:167>,<thermalfoundation:material:231>,<thermalfoundation:storage_alloy:7>,<thermalfoundation:material:103>,
<thermalfoundation:material:359>,null,null,null,<thermalfoundation:material:295>,
null,null,null,null,
null,null,null,
null,null,null,
null,null,
<mysticalagriculture:enderium_seeds>,
<mysticalagriculture:enderium_essence>,
<aspect:metallum>, <aspect:alienis>);

#Coal
addMetallurgicAspects
(1,2,2,
<minecraft:coal>,<actuallyadditions:item_misc:10>,<minecraft:coal_block>,<thermalfoundation:material:768>,
null,null,null,null,null,
<jaopca:item_clustercoal>,<jaopca:item_crystalshardcoal>,<jaopca:item_crystalabysscoal>,<jaopca:item_rockychunkcoal>,
<jaopca:item_chunkcoal>,<jaopca:item_dustalchcoal>,<jaopca:item_dirtygemcoal>,
<minecraft:coal_ore>,<netherendingores:ore_nether_vanilla>,<netherendingores:ore_end_vanilla>,
null,null,
<mysticalagriculture:coal_seeds>,<mysticalagriculture:coal_essence>,
<aspect:ignis>, <aspect:potentia>);

#Lapis
addMetallurgicAspects
(0.5,0.4,4,
<minecraft:dye:4>,<jaopca:item_nuggetlapis>,<minecraft:lapis_block>,<ic2:dust:9>,
<ic2:plate:4>,<ic2:plate:13>,null,null,null,
<jaopca:item_clusterlapis>,<jaopca:item_crystalshardlapis>,<jaopca:item_crystalabysslapis>,<jaopca:item_rockychunklapis>,
<jaopca:item_chunklapis>,<jaopca:item_dustalchlapis>,<jaopca:item_dirtygemlapis>,
<minecraft:lapis_ore>,<netherendingores:ore_nether_vanilla:5>,<netherendingores:ore_end_vanilla:5>,
null,null,
<mysticalagriculture:lapis_lazuli_seeds>,<mysticalagriculture:lapis_lazuli_essence>,
<aspect:sensus>, <aspect:desiderium>);

#Redstone
addMetallurgicAspects
(1.0,0.0,4,
<minecraft:redstone>,<jaopca:item_dusttinyredstone>,<minecraft:redstone_block>,null,
null,null,null,null,null,
<jaopca:item_clusterredstone>,<jaopca:item_crystalshardredstone>,<jaopca:item_crystalabyssredstone>,<jaopca:item_rockychunkredstone>,
<jaopca:item_chunkredstone>,<jaopca:item_dustalchredstone>,<jaopca:item_dirtygemredstone>,
<minecraft:redstone_ore>,<netherendingores:ore_nether_vanilla:6>,<netherendingores:ore_end_vanilla:6>,
null,null,
<mysticalagriculture:redstone_seeds>,<mysticalagriculture:redstone_essence>,
<aspect:potentia>, <aspect:terra>);

#Titanium
addMetallurgicAspects
(1.0,1.0,0,
<libvulpes:productingot:7>,<libvulpes:productnugget:7>,<libvulpes:metal0:7>,<libvulpes:productdust:7>,
<libvulpes:productplate:7>,null,null,null,<libvulpes:productgear:7>,
<jaopca:item_clustertitanium>,<jaopca:item_crystalshardtitanium>,<jaopca:item_crystalabysstitanium>,<jaopca:item_rockychunktitanium>,
<jaopca:item_chunktitanium>,<jaopca:item_dustalchtitanium>,<jaopca:item_dirtygemtitanium>,
<libvulpes:ore0:8>,null,null,
null,null,
null,null,
<aspect:metallum>, <aspect:gelum>);

#Knightslime
addMetallurgicAspects
(1.0,1.0,3,
<tconstruct:ingots:3>,<tconstruct:nuggets:3>,<tconstruct:metal:3>,null,
null,null,null,null,null,
null,null,null,null,
null,null,null,
null,null,null,
null,null,
<mysticalagriculture:knightslime_seeds>,<mysticalagriculture:knightslime_essence>,
<aspect:metallum>, <aspect:aqua>);

#Cobalt
addMetallurgicAspects
(1.0,1.0,4,
<tconstruct:ingots>,<tconstruct:nuggets>,<tconstruct:metal>,<exnihilocreatio:item_ore_cobalt:2>,
null,null,null,null,null,
<jaopca:item_clustercobalt>,<jaopca:item_crystalshardcobalt>,<jaopca:item_crystalabysscobalt>,<jaopca:item_rockychunkcobalt>,
<jaopca:item_chunkcobalt>,<jaopca:item_dustalchcobalt>,<jaopca:item_dirtygemcobalt>,
<netherendingores:ore_other_1:4>,<tconstruct:ore>,<netherendingores:ore_other_1:5>,
<jaopca:item_crushedcobalt>,<jaopca:item_crushedpurifiedcobalt>,
<mysticalagriculture:cobalt_seeds>,<mysticalagriculture:cobalt_essence>,
<aspect:metallum>, <aspect:volatus>);

#Ardite
addMetallurgicAspects
(1.0,1.0,4,
<tconstruct:ingots:1>,<tconstruct:nuggets:1>,<tconstruct:metal:1>,<exnihilocreatio:item_ore_ardite:2>,
null,null,null,null,null,
<jaopca:item_clusterardite>,<jaopca:item_crystalshardardite>,<jaopca:item_crystalabyssardite>,<jaopca:item_rockychunkardite>,
<jaopca:item_chunkardite>,<jaopca:item_dustalchardite>,<jaopca:item_dirtygemardite>,
<netherendingores:ore_other_1:2>,<tconstruct:ore:1>,<netherendingores:ore_other_1:3>,
<jaopca:item_crushedardite>,<jaopca:item_crushedpurifiedardite>,
<mysticalagriculture:ardite_seeds>,<mysticalagriculture:ardite_essence>,
<aspect:metallum>, Aspect.exitium);

#Uranium
addMetallurgicAspects
(1.0,1.0,4,
<immersiveengineering:metal:5>,<immersiveengineering:metal:25>,<immersiveengineering:storage:5>,<immersiveengineering:metal:14>,
<immersiveengineering:metal:35>,null,<immersiveengineering:sheetmetal:5>,null,null,
<jaopca:item_clusteruranium>,<jaopca:item_crystalsharduranium>,<jaopca:item_crystalabyssuranium>,<jaopca:item_rockychunkuranium>,
<jaopca:item_chunkuranium>,<jaopca:item_dustalchuranium>,<jaopca:item_dirtygemuranium>,
<immersiveengineering:ore:5>,<netherendingores:ore_nether_modded_1:12>,<netherendingores:ore_end_modded_1:12>,
<ic2:crushed:6>,<ic2:purified:6>,
<mysticalagriculture:uranium_seeds>,<mysticalagriculture:uranium_essence>,
<aspect:metallum>, <aspect:mortuus>);

#Starmetal
addMetallurgicAspects
(1.0,1.0,3,
<astralsorcery:itemcraftingcomponent:1>,<jaopca:item_nuggetastralstarmetal>,<jaopca:block_blockastralstarmetal>,<astralsorcery:itemcraftingcomponent:2>,
null,null,null,null,null,
<jaopca:item_clusterastralstarmetal>,<jaopca:item_crystalshardastralstarmetal>,<jaopca:item_crystalabyssastralstarmetal>,<jaopca:item_rockychunkastralstarmetal>,
<jaopca:item_chunkastralstarmetal>,<jaopca:item_dustalchastralstarmetal>,<jaopca:item_dirtygemastralstarmetal>,
<astralsorcery:blockcustomore:1>,null,null,
<jaopca:item_crushedastralstarmetal>,<jaopca:item_crushedpurifiedastralstarmetal>,
<mysticalagriculture:starmetal_seeds>,<mysticalagriculture:starmetal_essence>,
<aspect:metallum>, <aspect:praecantatio>, <aspect:tenebrae>);

#Black quartz
addMetallurgicAspects
(1.0,1.0,3,
<actuallyadditions:item_misc:5>,<jaopca:item_nuggetquartzblack>,<actuallyadditions:block_misc:2>,<actuallyadditions:item_dust:7>,
null,null,null,null,null,
<jaopca:item_clusterquartzblack>,<jaopca:item_crystalshardquartzblack>,<jaopca:item_crystalabyssquartzblack>,<jaopca:item_rockychunkquartzblack>,
<jaopca:item_chunkquartzblack>,<jaopca:item_dustalchquartzblack>,<jaopca:item_dirtygemquartzblack>,
<actuallyadditions:block_misc:3>,null,null,
null,null,
<mysticalagriculture:black_quartz_seeds>,<mysticalagriculture:black_quartz_essence>,
<aspect:vitreus>, <aspect:tenebrae>);

#Certus quartz
addMetallurgicAspects
(1.0,1.0,2,
<appliedenergistics2:material>,<jaopca:item_nuggetcertusquartz>,null,<appliedenergistics2:material:2>,
null,null,null,null,null,
<jaopca:item_clustercertusquartz>,<jaopca:item_crystalshardcertusquartz>,<jaopca:item_crystalabysscertusquartz>,<jaopca:item_rockychunkcertusquartz>,
<jaopca:item_chunkcertusquartz>,<jaopca:item_dustalchcertusquartz>,<jaopca:item_dirtygemcertusquartz>,
<appliedenergistics2:quartz_ore>,<netherendingores:ore_nether_modded_1:9>,<netherendingores:ore_end_modded_1:9>,
null,null,
<mysticalagriculture:certus_quartz_seeds>,<mysticalagriculture:certus_quartz_essence>,
<aspect:vitreus>, <aspect:potentia>);

#Charged certus quartz
addMetallurgicAspects
(1.0,4.0,0,
<appliedenergistics2:material:1>,<jaopca:item_nuggetchargedcertusquartz>,null,null,
null,null,null,null,null,
<jaopca:item_clusterchargedcertusquartz>,<jaopca:item_crystalshardchargedcertusquartz>,<jaopca:item_crystalabysschargedcertusquartz>,<jaopca:item_rockychunkchargedcertusquartz>,
<jaopca:item_chunkchargedcertusquartz>,<jaopca:item_dustalchchargedcertusquartz>,<jaopca:item_dirtygemchargedcertusquartz>,
<appliedenergistics2:charged_quartz_ore>,<netherendingores:ore_nether_modded_1:10>,null,
null,null,
null,null,
<aspect:vitreus>, <aspect:potentia>);

#Aquamarine
addMetallurgicAspects
(1.0,1.0,3,
<astralsorcery:itemcraftingcomponent>,<jaopca:block_blockaquamarine>,<jaopca:item_nuggetaquamarine>,<jaopca:item_dustaquamarine>,
null,null,null,null,null,
<jaopca:item_clusteraquamarine>,<jaopca:item_crystalshardaquamarine>,<jaopca:item_crystalabyssaquamarine>,<jaopca:item_rockychunkaquamarine>,
<jaopca:item_chunkaquamarine>,<jaopca:item_dustalchaquamarine>,<jaopca:item_dirtygemaquamarine>,
<astralsorcery:blockcustomsandore>,null,null,
null,null,
<mysticalagriculture:aquamarine_seeds>,<mysticalagriculture:aquamarine_essence>,
<aspect:vitreus>, <aspect:aqua>);

#Tungsten
addMetallurgicAspects
(1.0,1.0,0,
<endreborn:item_ingot_wolframium>,<endreborn:wolframium_nugget>,<endreborn:block_wolframium>,<jaopca:item_dustdirtytungsten>,
null,null,null,null,null,
<jaopca:item_clustertungsten>,<jaopca:item_crystalshardtungsten>,<jaopca:item_crystalabysstungsten>,<jaopca:item_rockychunktungsten>,
<jaopca:item_chunktungsten>,<jaopca:item_dustalchtungsten>,<jaopca:item_dirtygemtungsten>,
<endreborn:block_wolframium_ore>,null,null,
<jaopca:item_crushedtungsten>,<jaopca:item_crushedpurifiedtungsten>,
null,null,
<aspect:metallum>, <aspect:vacuos>);

#Apatite
addMetallurgicAspects
(1.0,1.0,2,
<forestry:apatite>,<jaopca:item_nuggetapatite>,<forestry:resource_storage>,<jaopca:item_dustapatite>,
null,null,null,null,null,
<jaopca:item_clusterapatite>,<jaopca:item_crystalshardapatite>,<jaopca:item_crystalabyssapatite>,<jaopca:item_rockychunkapatite>,
<jaopca:item_chunkapatite>,<jaopca:item_dustalchapatite>,<jaopca:item_dirtygemapatite>,
<forestry:resources>,null,null,
null,null,
<mysticalagriculture:apatite_seeds>,<mysticalagriculture:apatite_essence>,
<aspect:vitreus>, <aspect:herba>);

#Osmium
addMetallurgicAspects
(1.0,1.0,4,
<mekanism:ingot:1>,<mekanism:nugget:1>,<mekanism:basicblock>,<mekanism:dust:2>,
null,null,null,null,null,
<jaopca:item_clusterosmium>,<jaopca:item_crystalshardosmium>,<jaopca:item_crystalabyssosmium>,<jaopca:item_rockychunkosmium>,
<jaopca:item_chunkosmium>,<jaopca:item_dustalchosmium>,<jaopca:item_dirtygemosmium>,
<mekanism:oreblock>,<netherendingores:ore_nether_modded_1:11>,<netherendingores:ore_end_modded_1:11>,
<jaopca:item_crushedosmium>,<jaopca:item_crushedpurifiedosmium>,
<mysticalagriculture:osmium_seeds>,<mysticalagriculture:osmium_essence>,
<aspect:metallum>, <aspect:terra>);

#Boron
addMetallurgicAspects
(1.0,1.0,4,
<nuclearcraft:ingot:5>,<jaopca:item_nuggetboron>,<nuclearcraft:ingot_block:5>,<nuclearcraft:dust:5>,
null,null,null,null,null,
<jaopca:item_clusterboron>,<jaopca:item_crystalshardboron>,<jaopca:item_crystalabyssboron>,<jaopca:item_rockychunkboron>,
<jaopca:item_chunkboron>,<jaopca:item_dustalchboron>,<jaopca:item_dirtygemboron>,
<nuclearcraft:ore:5>,null,null,
<jaopca:item_crushedboron>,<jaopca:item_crushedpurifiedboron>,
<mysticalagriculture:boron_seeds>,<mysticalagriculture:boron_essence>,
<aspect:metallum>, <aspect:humanus>);

#Lithium
addMetallurgicAspects
(1.0,1.0,4,
<nuclearcraft:ingot:6>,<jaopca:item_nuggetlithium>,<nuclearcraft:ingot_block:6>,<ic2:dust:11>,
null,null,null,null,null,
<jaopca:item_clusterlithium>,<jaopca:item_crystalshardlithium>,<jaopca:item_crystalabysslithium>,<jaopca:item_rockychunklithium>,
<jaopca:item_chunklithium>,<jaopca:item_dustalchlithium>,<jaopca:item_dirtygemlithium>,
<nuclearcraft:ore:6>,null,<netherendingores:ore_end_modded_1:14>,
<jaopca:item_crushedlithium>,<jaopca:item_crushedpurifiedlithium>,
<mysticalagriculture:lithium_seeds>,<mysticalagriculture:lithium_essence>,
<aspect:metallum>, Aspect.ventus);

#Magnesium
addMetallurgicAspects
(1.0,1.0,4,
<nuclearcraft:ingot:7>,<jaopca:item_nuggetmagnesium>,<nuclearcraft:ingot_block:7>,<nuclearcraft:dust:7>,
null,null,null,null,null,
<jaopca:item_clustermagnesium>,<jaopca:item_crystalshardmagnesium>,<jaopca:item_crystalabyssmagnesium>,<jaopca:item_rockychunkmagnesium>,
<jaopca:item_chunkmagnesium>,<jaopca:item_dustalchmagnesium>,<jaopca:item_dirtygemmagnesium>,
<nuclearcraft:ore:7>,null,null,
<jaopca:item_crushedmagnesium>,<jaopca:item_crushedpurifiedmagnesium>,
<mysticalagriculture:magnesium_seeds>,<mysticalagriculture:magnesium_essence>,
<aspect:metallum>, <aspect:auram>);

#Thorium
addMetallurgicAspects
(1.0,1.0,4,
<nuclearcraft:ingot:3>,<jaopca:item_nuggetthorium>,<nuclearcraft:ingot_block:3>,<nuclearcraft:dust:3>,
null,null,null,null,null,
<jaopca:item_clusterthorium>,<jaopca:item_crystalshardthorium>,<jaopca:item_crystalabyssthorium>,<jaopca:item_rockychunkthorium>,
<jaopca:item_chunkthorium>,<jaopca:item_dustalchthorium>,<jaopca:item_dirtygemthorium>,
<nuclearcraft:ore:3>,null,null,
<jaopca:item_crushedthorium>,<jaopca:item_crushedpurifiedthorium>,
<mysticalagriculture:thorium_seeds>,<mysticalagriculture:thorium_essence>,
<aspect:metallum>, <aspect:tenebrae>);

#Draconium
addMetallurgicAspects
(2.0,2.0,5,
<draconicevolution:draconium_ingot>,<draconicevolution:nugget>,<draconicevolution:draconium_block>,<draconicevolution:draconium_dust>,
null,null,null,null,null,
<jaopca:item_clusterdraconium>,<jaopca:item_crystalsharddraconium>,<jaopca:item_crystalabyssdraconium>,<jaopca:item_rockychunkdraconium>,
<jaopca:item_chunkdraconium>,<jaopca:item_dustalchdraconium>,<jaopca:item_dirtygemdraconium>,
<draconicevolution:draconium_ore>,<draconicevolution:draconium_ore:1>,<draconicevolution:draconium_ore:2>,
<jaopca:item_crusheddraconium>,<jaopca:item_crushedpurifieddraconium>,
<mysticalagriculture:draconium_seeds>,<mysticalagriculture:draconium_essence>,
<aspect:metallum>, <aspect:draco>);

#Amber
addMetallurgicAspects
(1.0,2.0,4,
<thaumcraft:amber>,<jaopca:item_nuggetamber>,<thaumcraft:amber_brick>,<jaopca:item_dustamber>,
null,null,null,null,null,
<jaopca:item_clusteramber>,<jaopca:item_crystalshardamber>,<jaopca:item_crystalabyssamber>,<jaopca:item_rockychunkamber>,
<jaopca:item_chunkamber>,<jaopca:item_dustalchamber>,<jaopca:item_dirtygemamber>,
<thaumcraft:ore_amber>,null,null,
null,null,
<mysticalagriculture:amber_seeds>,<mysticalagriculture:amber_essence>,
<aspect:vitreus>, <aspect:vinculum>);

#Amethyst
addMetallurgicAspects
(2.0,4.0,4,
<biomesoplenty:gem>,<jaopca:item_nuggetamethyst>,<biomesoplenty:gem_block>,<jaopca:item_dustamethyst>,
null,null,null,null,null,
<jaopca:item_clusteramethyst>,<jaopca:item_crystalshardamethyst>,<jaopca:item_crystalabyssamethyst>,<jaopca:item_rockychunkamethyst>,
<jaopca:item_chunkamethyst>,<jaopca:item_dustalchamethyst>,<jaopca:item_dirtygemamethyst>,
null,null,<biomesoplenty:gem_ore>,
null,null,
<mysticalagriculture:ender_amethyst_seeds>,<mysticalagriculture:ender_amethyst_essence>,
<aspect:vitreus>, <aspect:alienis>, <aspect:desiderium>);

#Dilithium
addMetallurgicAspects
(2.0,4.0,0,
<libvulpes:productgem>,<jaopca:item_nuggetdilithium>,<jaopca:block_blockdilithium>,<libvulpes:productdust>,
null,null,null,null,null,
<jaopca:item_clusterdilithium>,<jaopca:item_crystalsharddilithium>,<jaopca:item_crystalabyssdilithium>,<jaopca:item_rockychunkdilithium>,
<jaopca:item_chunkdilithium>,<jaopca:item_dustalchdilithium>,<jaopca:item_dirtygemdilithium>,
<libvulpes:ore0>,null,<netherendingores:ore_end_modded_1:14>,
null,null,
null,null,
<aspect:vitreus>, Aspect.fluctus);

#Dimensional shard
addMetallurgicAspects
(2.0,4.0,0,
<rftools:dimensional_shard>,<jaopca:item_nuggetdimensionalshard>,<jaopca:block_blockdimensionalshard>,<jaopca:item_dustdimensionalshard>,
null,null,null,null,null,
<jaopca:item_clusterdimensionalshard>,<jaopca:item_crystalsharddimensionalshard>,<jaopca:item_crystalabyssdimensionalshard>,<jaopca:item_rockychunkdimensionalshard>,
<jaopca:item_chunkdimensionalshard>,<jaopca:item_dustalchdimensionalshard>,<jaopca:item_dirtygemdimensionalshard>,
<rftools:dimensional_shard_ore>,null,null,
null,null,
null,null,
<aspect:vitreus>, <aspect:motus>);

#Malachite
addMetallurgicAspects
(1.0,2.0,4,
<biomesoplenty:gem:5>,<jaopca:item_nuggetmalachite>,<biomesoplenty:gem_block:5>,<jaopca:item_dustmalachite>,
null,null,null,null,null,
<jaopca:item_clustermalachite>,<jaopca:item_crystalshardmalachite>,<jaopca:item_crystalabyssmalachite>,<jaopca:item_rockychunkmalachite>,
<jaopca:item_chunkmalachite>,<jaopca:item_dustalchmalachite>,<jaopca:item_dirtygemmalachite>,
<biomesoplenty:gem_ore:5>,null,null,
null,null,
<mysticalagriculture:malachite_seeds>,<mysticalagriculture:malachite_essence>,
<aspect:vitreus>, <aspect:fabrico>, <aspect:desiderium>);

#Peridot
addMetallurgicAspects
(1.0,2.0,4,
<biomesoplenty:gem:2>,<jaopca:item_nuggetperidot>,<biomesoplenty:gem_block:2>,<jaopca:item_dustperidot>,
null,null,null,null,null,
<jaopca:item_clusterperidot>,<jaopca:item_crystalshardperidot>,<jaopca:item_crystalabyssperidot>,<jaopca:item_rockychunkperidot>,
<jaopca:item_chunkperidot>,<jaopca:item_dustalchperidot>,<jaopca:item_dirtygemperidot>,
<biomesoplenty:gem_ore:2>,null,null,
null,null,
<mysticalagriculture:peridot_seeds>,<mysticalagriculture:peridot_essence>,
<aspect:vitreus>, <aspect:terra>, <aspect:desiderium>);

#Quartz
addMetallurgicAspects
(0.5,0.0,3,
<minecraft:quartz>,null,null,<appliedenergistics2:material:3>,
null,null,null,null,null,
<thaumcraft:cluster:7>,<jaopca:item_crystalshardquartz>,<jaopca:item_crystalabyssquartz>,<jaopca:item_rockychunkquartz>,
<jaopca:item_chunkquartz>,<jaopca:item_dustalchquartz>,<jaopca:item_dirtygemquartz>,
<netherendingores:ore_other_1>,<minecraft:quartz_ore>,<netherendingores:ore_other_1:1>,
null,null,
<mysticalagriculture:nether_quartz_seeds>,<mysticalagriculture:nether_quartz_essence>,
<aspect:vitreus>, <aspect:terra>);

#Ruby
addMetallurgicAspects
(1.0,2.0,4,
<biomesoplenty:gem:1>,<jaopca:item_nuggetruby>,<biomesoplenty:gem_block:1>,<jaopca:item_dustruby>,
null,null,null,null,null,
<jaopca:item_clusterruby>,<jaopca:item_crystalshardruby>,<jaopca:item_crystalabyssruby>,<jaopca:item_rockychunkruby>,
<jaopca:item_chunkruby>,<jaopca:item_dustalchruby>,<jaopca:item_dirtygemruby>,
<biomesoplenty:gem_ore:1>,null,null,
null,null,
<mysticalagriculture:ruby_seeds>,<mysticalagriculture:ruby_essence>,
<aspect:vitreus>, <aspect:victus>, <aspect:desiderium>);

#Sapphire
addMetallurgicAspects
(1.0,2.0,4,
<biomesoplenty:gem:6>,<jaopca:item_nuggetsapphire>,<biomesoplenty:gem_block:6>,<jaopca:item_dustsapphire>,
null,null,null,null,null,
<jaopca:item_clustersapphire>,<jaopca:item_crystalshardsapphire>,<jaopca:item_crystalabysssapphire>,<jaopca:item_rockychunksapphire>,
<jaopca:item_chunksapphire>,<jaopca:item_dustalchsapphire>,<jaopca:item_dirtygemsapphire>,
<biomesoplenty:gem_ore:6>,null,<netherendingores:ore_end_modded_2:2>,
null,null,
<mysticalagriculture:sapphire_seeds>,<mysticalagriculture:sapphire_essence>,
<aspect:vitreus>, <aspect:gelum>, <aspect:desiderium>);

#Tanzanite
addMetallurgicAspects
(1.0,2.0,4,
<biomesoplenty:gem:4>,<jaopca:item_nuggettanzanite>,<biomesoplenty:gem_block:4>,<jaopca:item_dusttanzanite>,
null,null,null,null,null,
<jaopca:item_clustertanzanite>,<jaopca:item_crystalshardtanzanite>,<jaopca:item_crystalabysstanzanite>,<jaopca:item_rockychunktanzanite>,
<jaopca:item_chunktanzanite>,<jaopca:item_dustalchtanzanite>,<jaopca:item_dirtygemtanzanite>,
<biomesoplenty:gem_ore:4>,null,null,
null,null,
<mysticalagriculture:tanzanite_seeds>,<mysticalagriculture:tanzanite_essence>,
<aspect:vitreus>, <aspect:vitium>, <aspect:desiderium>);

#Topaz
addMetallurgicAspects
(1.0,2.0,4,
<biomesoplenty:gem:3>,<jaopca:item_nuggettopaz>,<biomesoplenty:gem_block:3>,<jaopca:item_dusttopaz>,
null,null,null,null,null,
<jaopca:item_clustertopaz>,<jaopca:item_crystalshardtopaz>,<jaopca:item_crystalabysstopaz>,<jaopca:item_rockychunktopaz>,
<jaopca:item_chunktopaz>,<jaopca:item_dustalchtopaz>,<jaopca:item_dirtygemtopaz>,
<biomesoplenty:gem_ore:3>,null,null,
null,null,
<mysticalagriculture:topaz_seeds>,<mysticalagriculture:topaz_essence>,
<aspect:vitreus>, Aspect.imperium, <aspect:desiderium>);

#Trinitite
addMetallurgicAspects
(1.0,2.0,0,
<trinity:trinitite_shard>,<jaopca:item_nuggettrinitite>,<trinity:solid_trinitite>,<jaopca:item_dusttrinitite>,
null,null,null,null,null,
<jaopca:item_clustertrinitite>,<jaopca:item_crystalshardtrinitite>,<jaopca:item_crystalabysstrinitite>,<jaopca:item_rockychunktrinitite>,
<jaopca:item_chunktrinitite>,<jaopca:item_dustalchtrinitite>,<jaopca:item_dirtygemtrinitite>,
<trinity:trinitite>,null,null,
null,null,
null,null,
<aspect:vitreus>, Aspect.exitium, <aspect:desiderium>);

/*
 ██████╗ ████████╗██╗  ██╗███████╗██████╗ 
██╔═══██╗╚══██╔══╝██║  ██║██╔════╝██╔══██╗
██║   ██║   ██║   ███████║█████╗  ██████╔╝
██║   ██║   ██║   ██╔══██║██╔══╝  ██╔══██╗
╚██████╔╝   ██║   ██║  ██║███████╗██║  ██║
 ╚═════╝    ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
*/

#[Sanguis aspect] source
mods.bloodmagic.BloodAltar.addRecipe(
<thaumcraft:phial:1>.withTag({Aspects: [{amount: 10, key: "sanguis"}]}), #output
<thaumcraft:phial>, #input
1, #tier
1000, #blood_essence_drain (how much essence crafting recipe require)
20, #consume_rate (how fast it will take essence from altar)
0); #drain_rate (how fast crafting process will decay if there is no blood in altar, 0 means no loss)

#[Mana aspect] source
mods.botania.ManaInfusion.addAlchemy(<thaumcraft:phial:1>.withTag({Aspects: [{amount: 10, key: "mana"}]}),<thaumcraft:phial>,5000);
