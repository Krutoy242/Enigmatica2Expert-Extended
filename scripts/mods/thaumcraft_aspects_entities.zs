import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;
import crafttweaker.data.IData;
import thaumcraft.aspect.CTAspectStack;
import crafttweaker.entity.IEntityDefinition;

#modloaded thaumcraft

/* 
___  ____ ___ ___ ____ ____    ____ _  _ _ _  _ ____ _    ____ 
|__] |___  |   |  |___ |__/    |__| |\ | | |\/| |__| |    [__  
|__] |___  |   |  |___ |  \    |  | | \| | |  | |  | |___ ___] 
                                                               
*/ 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "betteranimalsplus:badger"}})
                                                .setAspects(<aspect:bestia>*10        ,<aspect:terra>*10       ,<aspect:perditio>*5); 
<entity:betteranimalsplus:badger>               .setAspects(<aspect:bestia>*10        ,<aspect:terra>*10       ,<aspect:perditio>*5);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "betteranimalsplus:blackbear"}})
                                                .setAspects(<aspect:bestia>*20        ,<aspect:terra>*20       ,<aspect:tenebrae>*10); 
<entity:betteranimalsplus:blackbear>            .setAspects(<aspect:bestia>*20        ,<aspect:terra>*20       ,<aspect:tenebrae>*10);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "betteranimalsplus:boar"}})
                                                .setAspects(<aspect:bestia>*15        ,<aspect:terra>*10      ,<aspect:aversio>*10); 
<entity:betteranimalsplus:boar>                 .setAspects(<aspect:bestia>*15        ,<aspect:terra>*10      ,<aspect:aversio>*10);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "betteranimalsplus:bobbit_worm"}})
                                                .setAspects(<aspect:bestia>*15        ,<aspect:terra>*10      ,<aspect:vinculum>*10); 
<entity:betteranimalsplus:bobbit_worm>          .setAspects(<aspect:bestia>*15        ,<aspect:terra>*10      ,<aspect:vinculum>*10);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "betteranimalsplus:brownbear"}})
                                                .setAspects(<aspect:bestia>*20        ,<aspect:terra>*20      ,<aspect:aversio>*10); 
<entity:betteranimalsplus:brownbear>            .setAspects(<aspect:bestia>*20        ,<aspect:terra>*20      ,<aspect:aversio>*10);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "betteranimalsplus:crab"}})
                                                .setAspects(<aspect:bestia>*10        ,<aspect:aqua>*10       ,<aspect:praemunio>*5); 
<entity:betteranimalsplus:crab>                 .setAspects(<aspect:bestia>*10        ,<aspect:aqua>*10       ,<aspect:praemunio>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "betteranimalsplus:coyote"}})
                                                .setAspects(<aspect:bestia>*15        ,<aspect:victus>*15     ,<aspect:ignis>*5); 
<entity:betteranimalsplus:coyote>               .setAspects(<aspect:bestia>*15        ,<aspect:victus>*15     ,<aspect:ignis>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "betteranimalsplus:deer"}})
                                                .setAspects(<aspect:bestia>*15        ,<aspect:victus>*15     ,<aspect:terra>*5); 
<entity:betteranimalsplus:deer>                 .setAspects(<aspect:bestia>*15        ,<aspect:victus>*15     ,<aspect:terra>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "betteranimalsplus:eel_freshwater"}})
                                                .setAspects(<aspect:bestia>*10        ,<aspect:aqua>*10       ,<aspect:potentia>*5); 
<entity:betteranimalsplus:eel_freshwater>       .setAspects(<aspect:bestia>*10        ,<aspect:aqua>*10       ,<aspect:potentia>*5);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "betteranimalsplus:eel_saltwater"}})
                                                .setAspects(<aspect:bestia>*10        ,<aspect:aqua>*10       ,<aspect:fluctus>*5); 
<entity:betteranimalsplus:eel_saltwater>        .setAspects(<aspect:bestia>*10        ,<aspect:aqua>*10       ,<aspect:fluctus>*5);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "betteranimalsplus:feralwolf"}})
                                                .setAspects(<aspect:bestia>*15        ,<aspect:victus>*15     ,<aspect:sonus>*5); 
<entity:betteranimalsplus:feralwolf>            .setAspects(<aspect:bestia>*15        ,<aspect:victus>*15     ,<aspect:sonus>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "betteranimalsplus:fox"}})
                                                .setAspects(<aspect:bestia>*15        ,<aspect:victus>*15     ,<aspect:desiderium>*5); 
<entity:betteranimalsplus:fox>                  .setAspects(<aspect:bestia>*15        ,<aspect:victus>*15     ,<aspect:desiderium>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "betteranimalsplus:goat"}})
                                                .setAspects(<aspect:bestia>*15        ,<aspect:terra>*15      ,<aspect:fabrico>*10); 
<entity:betteranimalsplus:goat>                 .setAspects(<aspect:bestia>*15        ,<aspect:terra>*15      ,<aspect:fabrico>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "betteranimalsplus:goose"}})
                                                .setAspects(<aspect:bestia>*10        ,<aspect:aer>*10        ,<aspect:permutatio>*5); 
<entity:betteranimalsplus:goose>                .setAspects(<aspect:bestia>*10        ,<aspect:aer>*10        ,<aspect:permutatio>*5);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "betteranimalsplus:horseshoecrab"}})
                                                .setAspects(<aspect:bestia>*10        ,<aspect:aqua>*10       ,<aspect:vinculum>*5); 
<entity:betteranimalsplus:horseshoecrab>        .setAspects(<aspect:bestia>*10        ,<aspect:aqua>*10       ,<aspect:vinculum>*5);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "betteranimalsplus:jellyfish"}})
                                                .setAspects(<aspect:bestia>*10        ,<aspect:aqua>*10       ,<aspect:potentia>*5); 
<entity:betteranimalsplus:jellyfish>            .setAspects(<aspect:bestia>*10        ,<aspect:aqua>*10       ,<aspect:potentia>*5);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "betteranimalsplus:lammergeier"}})
                                                .setAspects(<aspect:bestia>*10        ,<aspect:volatus>*10    ,<aspect:visum>*5); 
<entity:betteranimalsplus:lammergeier>          .setAspects(<aspect:bestia>*10        ,<aspect:volatus>*10    ,<aspect:visum>*5);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "betteranimalsplus:lamprey"}})
                                                .setAspects(<aspect:bestia>*10        ,<aspect:aqua>*10       ,<aspect:motus>*5); 
<entity:betteranimalsplus:lamprey>              .setAspects(<aspect:bestia>*10        ,<aspect:aqua>*10       ,<aspect:motus>*5);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "betteranimalsplus:moose"}})
                                                .setAspects(<aspect:bestia>*50        ,<aspect:victus>*30     ,<aspect:terra>*20); 
<entity:betteranimalsplus:moose>                .setAspects(<aspect:bestia>*50        ,<aspect:victus>*30     ,<aspect:terra>*20);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "betteranimalsplus:nautilus"}})
                                                .setAspects(<aspect:aqua>*10          ,<aspect:praemunio>*10  ,<aspect:bestia>*10); 
<entity:betteranimalsplus:nautilus>             .setAspects(<aspect:aqua>*10          ,<aspect:praemunio>*10  ,<aspect:bestia>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "betteranimalsplus:pheasant"}})
                                                .setAspects(<aspect:bestia>*15        ,<aspect:volatus>*10    ,<aspect:ventus>*10); 
<entity:betteranimalsplus:pheasant>             .setAspects(<aspect:bestia>*15        ,<aspect:volatus>*10    ,<aspect:ventus>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "betteranimalsplus:reindeer"}})
                                                .setAspects(<aspect:bestia>*40        ,<aspect:victus>*20     ,<aspect:gelum>*20); 
<entity:betteranimalsplus:reindeer>             .setAspects(<aspect:bestia>*40        ,<aspect:victus>*20     ,<aspect:gelum>*20);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "betteranimalsplus:shark"}}) 
                                                .setAspects(<aspect:aqua>*30          ,<aspect:aversio>*20    ,<aspect:bestia>*20); 
<entity:betteranimalsplus:shark>                .setAspects(<aspect:aqua>*30          ,<aspect:aversio>*20    ,<aspect:bestia>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "betteranimalsplus:squirrel"}})
                                                .setAspects(<aspect:bestia>*10        ,<aspect:herba>*10      ,<aspect:vacuos>*10); 
<entity:betteranimalsplus:squirrel>             .setAspects(<aspect:bestia>*10        ,<aspect:herba>*10      ,<aspect:vacuos>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "betteranimalsplus:songbird"}})
                                                .setAspects(<aspect:bestia>*15        ,<aspect:volatus>*10    ,<aspect:sonus>*20); 
<entity:betteranimalsplus:songbird>             .setAspects(<aspect:bestia>*15        ,<aspect:volatus>*10    ,<aspect:sonus>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "betteranimalsplus:tarantula"}})
                                                .setAspects(<aspect:bestia>*50        ,<aspect:vinculum>*30   ,<aspect:sensus>*20       ,<aspect:infernum>*20); 
<entity:betteranimalsplus:tarantula>            .setAspects(<aspect:bestia>*50        ,<aspect:vinculum>*30   ,<aspect:sensus>*20       ,<aspect:infernum>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "betteranimalsplus:turkey"}})
                                                .setAspects(<aspect:bestia>*15        ,<aspect:volatus>*10    ,<aspect:ventus>*10); 
<entity:betteranimalsplus:turkey>               .setAspects(<aspect:bestia>*15        ,<aspect:volatus>*10    ,<aspect:ventus>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "betteranimalsplus:walrus"}})
                                                .setAspects(<aspect:bestia>*20        ,<aspect:victus>*20     ,<aspect:gelum>*10); 
<entity:betteranimalsplus:walrus>               .setAspects(<aspect:bestia>*20        ,<aspect:victus>*20     ,<aspect:gelum>*10);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "emberroot:witherwitch"}})
                                                .setAspects(<aspect:humanus>*20       ,<aspect:vitium>*20     ,<aspect:alkimia>*30); 
<entity:emberroot:witherwitch>                  .setAspects(<aspect:humanus>*20       ,<aspect:vitium>*20     ,<aspect:alkimia>*30); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "betteranimalsplus:whale"}})
                                                .setAspects(<aspect:bestia>*20        ,<aspect:aqua>*20       ,<aspect:vacuos>*10); 
<entity:betteranimalsplus:whale>                .setAspects(<aspect:bestia>*20        ,<aspect:aqua>*20       ,<aspect:vacuos>*10);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "betteranimalsplus:zotzpyre"}})
                                                .setAspects(<aspect:bestia>*15        ,<aspect:volatus>*10    ,<aspect:ignis>*10); 
<entity:betteranimalsplus:zotzpyre>             .setAspects(<aspect:bestia>*15        ,<aspect:volatus>*10    ,<aspect:ignis>*10); 

/* 
____ _  _ ____ ____ _  _ 
|  | |  | |__| |__/ |_/  
|_\| |__| |  | |  \ | \_ 
                         
*/ 

<minecraft:spawn_egg>.withTag({EntityTag: {id: "quark:ashen"}})
                                                .setAspects(<aspect:mortuus>*10       ,<aspect:perditio>*10   ,<aspect:aversio>*20); 
<entity:quark:ashen>                            .setAspects(<aspect:mortuus>*10       ,<aspect:perditio>*10   ,<aspect:aversio>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "quark:archaeologist"}})
                                                .setAspects(<aspect:humanus>*20       ,<aspect:permutatio>*10 ,<aspect:terra>*10); 
<entity:quark:archaeologist>                    .setAspects(<aspect:humanus>*20       ,<aspect:permutatio>*10 ,<aspect:terra>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "quark:crab"}})
                                                .setAspects(<aspect:bestia>*10        ,<aspect:aqua>*10       ,<aspect:praemunio>*5); 
<entity:quark:crab>                             .setAspects(<aspect:bestia>*10        ,<aspect:aqua>*10       ,<aspect:praemunio>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "quark:dweller"}})
                                                .setAspects(<aspect:exanimis>*10      ,<aspect:mortuus>*10    ,<aspect:humanus>*20     ,<aspect:visum>*10); 
<entity:quark:dweller>                          .setAspects(<aspect:exanimis>*10      ,<aspect:mortuus>*10    ,<aspect:humanus>*20     ,<aspect:visum>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "quark:foxhound"}})
                                                .setAspects(<aspect:bestia>*20        ,<aspect:ignis>*10      ,<aspect:infernum>*10         ,<aspect:potentia>*10); 
<entity:quark:foxhound>                         .setAspects(<aspect:bestia>*20        ,<aspect:ignis>*10      ,<aspect:infernum>*10         ,<aspect:potentia>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "quark:frog"}})
                                                .setAspects(<aspect:bestia>*10        ,<aspect:aqua>*10       ,<aspect:vinculum>*5); 
<entity:quark:frog>                             .setAspects(<aspect:bestia>*10        ,<aspect:aqua>*10       ,<aspect:vinculum>*5);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "quark:pirate"}})
                                                .setAspects(<aspect:mortuus>*10       ,<aspect:aqua>*10       ,<aspect:aversio>*20); 
<entity:quark:pirate>                           .setAspects(<aspect:mortuus>*10       ,<aspect:aqua>*10       ,<aspect:aversio>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "quark:stoneling"}})
                                                .setAspects(<aspect:terra>*10         ,<aspect:vinculum>*10   ,<aspect:desiderium>*20); 
<entity:quark:stoneling>                        .setAspects(<aspect:terra>*10         ,<aspect:vinculum>*10   ,<aspect:desiderium>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "quark:wraith"}})
                                                .setAspects(<aspect:mortuus>*10       ,<aspect:spiritus>*20   ,<aspect:imperium>*20); 
<entity:quark:wraith>                           .setAspects(<aspect:mortuus>*10       ,<aspect:spiritus>*20   ,<aspect:imperium>*20); 

/* 
___  ____ ____ ___  _  _ ____ ___  _    ____ ____ ____ _  _ _ _  _ ____ 
|  \ |___ |___ |__] |\/| |  | |__] |    |___ |__| |__/ |\ | | |\ | | __ 
|__/ |___ |___ |    |  | |__| |__] |___ |___ |  | |  \ | \| | | \| |__] 
                                                                        
*/ 

<minecraft:spawn_egg>.withTag({EntityTag: {id: "deepmoblearning:glitch"}})
                                                .setAspects(<aspect:victus>*50        ,<aspect:machina>*50    ,<aspect:imperium>*25     ,<aspect:caeles>*30); 
<entity:deepmoblearning:glitch>                 .setAspects(<aspect:victus>*50        ,<aspect:machina>*50    ,<aspect:imperium>*25     ,<aspect:caeles>*30);

/*
___  _ ____ _  _ ____ ____ ____ ___  _    ____ _  _ ___ _   _ 
|__] | |  | |\/| |___ [__  |  | |__] |    |___ |\ |  |   \_/  
|__] | |__| |  | |___ ___] |__| |    |___ |___ | \|  |    |   
                                                              
*/

<minecraft:spawn_egg>.withTag({EntityTag: {id: "biomesoplenty:wasp"}})
                                                .setAspects(<aspect:bestia>*10        ,<aspect:desiderium>*10 ,<aspect:infernum>*5); 
<entity:biomesoplenty:wasp>                     .setAspects(<aspect:bestia>*10        ,<aspect:desiderium>*10 ,<aspect:infernum>*5); 

/*
____ _  _ ___  ____ ____ ____ ____ ____ ___ ___  ____ ____ 
|___ |\/| |__] |___ |__/ |__/ |  | |  |  |    /  |  | |  | 
|___ |  | |__] |___ |  \ |  \ |__| |__|  |   /__ |__| |__| 
                                                           
*/

<minecraft:spawn_egg>.withTag({EntityTag: {id: "emberroot:creeper"}})
                                                .setAspects(<aspect:exitium>*20       ,<aspect:ignis>*10      ,<aspect:alkimia>*5        ,<aspect:perditio>*10); 
<entity:emberroot:creeper>                      .setAspects(<aspect:exitium>*20       ,<aspect:ignis>*10      ,<aspect:alkimia>*5        ,<aspect:perditio>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "emberroot:deers"}})
                                                .setAspects(<aspect:bestia>*15        ,<aspect:victus>*15     ,<aspect:terra>*5); 
<entity:emberroot:deers>                        .setAspects(<aspect:bestia>*15        ,<aspect:victus>*15     ,<aspect:terra>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "emberroot:dire_wolf"}})
                                                .setAspects(<aspect:bestia>*20        ,<aspect:terra>*10      ,<aspect:aversio>*5); 
<entity:emberroot:dire_wolf>                    .setAspects(<aspect:bestia>*20        ,<aspect:terra>*10      ,<aspect:aversio>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "emberroot:fairies"}})
                                                .setAspects(<aspect:auram>*20         ,<aspect:victus>*10     ,<aspect:volatus>*10); 
<entity:emberroot:fairies>                      .setAspects(<aspect:auram>*20         ,<aspect:victus>*10     ,<aspect:volatus>*10);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "emberroot:knight_fallen"}})
                                                .setAspects(<aspect:exanimis>*10      ,<aspect:perditio>*10   ,<aspect:humanus>*20); 
<entity:emberroot:knight_fallen>                .setAspects(<aspect:exanimis>*10      ,<aspect:perditio>*10   ,<aspect:humanus>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "emberroot:enderminy"}})
                                                .setAspects(<aspect:alienis>*20       ,<aspect:tenebrae>*10); 
<entity:emberroot:enderminy>                    .setAspects(<aspect:alienis>*20       ,<aspect:tenebrae>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "emberroot:fallenmount"}})
                                                .setAspects(<aspect:bestia>*40        ,<aspect:exanimis>*10   ,<aspect:motus>*10); 
<entity:emberroot:fallenmount>                  .setAspects(<aspect:bestia>*40        ,<aspect:exanimis>*10   ,<aspect:motus>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "emberroot:hero"}})
                                                .setAspects(<aspect:humanus>*40       ,<aspect:exanimis>*10   ,<aspect:instrumentum>*10); 
<entity:emberroot:hero>                         .setAspects(<aspect:humanus>*40       ,<aspect:exanimis>*10   ,<aspect:instrumentum>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "emberroot:owl"}})
                                                .setAspects(<aspect:bestia>*10        ,<aspect:sensus>*10     ,<aspect:volatus>*5); 
<entity:emberroot:owl>                          .setAspects(<aspect:bestia>*10        ,<aspect:sensus>*10     ,<aspect:volatus>*5);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "emberroot:rainbow_golem"}})
                                                .setAspects(<aspect:vitreus>*20       ,<aspect:machina>*10    ,<aspect:motus>*10); 
<entity:emberroot:rainbow_golem>                .setAspects(<aspect:vitreus>*20       ,<aspect:machina>*10    ,<aspect:motus>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "emberroot:rainbowslime"}})
                                                .setAspects(<aspect:aqua>*10          ,<aspect:alkimia>*10    ,<aspect:caeles>*5); 
<entity:emberroot:rainbowslime>                 .setAspects(<aspect:aqua>*10          ,<aspect:alkimia>*10    ,<aspect:caeles>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "emberroot:rootsonesprite"}})
                                                .setAspects(<aspect:spiritus>*10      ,<aspect:mana>*10       ,<aspect:lux>*5); 
<entity:emberroot:rootsonesprite>               .setAspects(<aspect:spiritus>*10      ,<aspect:mana>*10       ,<aspect:lux>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "emberroot:rootsonespritegreater"}})
                                                .setAspects(<aspect:spiritus>*50      ,<aspect:praecantatio>*20,<aspect:lux>*15); 
<entity:emberroot:rootsonespritegreater>        .setAspects(<aspect:spiritus>*50      ,<aspect:praecantatio>*20,<aspect:lux>*15); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "emberroot:rootsonespriteling"}})
                                                .setAspects(<aspect:spiritus>*10      ,<aspect:visum>*10      ,<aspect:lux>*5); 
<entity:emberroot:rootsonespriteling>           .setAspects(<aspect:spiritus>*10      ,<aspect:visum>*10      ,<aspect:lux>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "emberroot:skeleton_frozen"}})
                                                .setAspects(<aspect:mortuus>*10       ,<aspect:gelum>*10      ,<aspect:aversio>*20); 
<entity:emberroot:skeleton_frozen>              .setAspects(<aspect:mortuus>*10       ,<aspect:gelum>*10      ,<aspect:aversio>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "emberroot:slime"}})
                                                .setAspects(<aspect:aqua>*10          ,<aspect:victus>*10     ,<aspect:terra>*5); 
<entity:emberroot:slime>                        .setAspects(<aspect:aqua>*10          ,<aspect:victus>*10     ,<aspect:terra>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "emberroot:sprouts"}})
                                                .setAspects(<aspect:herba>*10         ,<aspect:victus>*10); 
<entity:emberroot:sprouts>                      .setAspects(<aspect:herba>*10         ,<aspect:victus>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "emberroot:timberwolf"}})
                                                .setAspects(<aspect:bestia>*15        ,<aspect:victus>*15     ,<aspect:herba>*5); 
<entity:emberroot:timberwolf>                   .setAspects(<aspect:bestia>*15        ,<aspect:victus>*15     ,<aspect:herba>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "emberroot:withercat"}})
                                                .setAspects(<aspect:bestia>*20        ,<aspect:tenebrae>*10   ,<aspect:infernum>*10); 
<entity:emberroot:withercat>                    .setAspects(<aspect:bestia>*20        ,<aspect:tenebrae>*10   ,<aspect:infernum>*10);

/*
____ _  _ ___  ____ ____ ___  ____ ____ _  _ 
|___ |\ | |  \ |__/ |___ |__] |  | |__/ |\ | 
|___ | \| |__/ |  \ |___ |__] |__| |  \ | \| 
                                             
*/

<minecraft:spawn_egg>.withTag({EntityTag: {id: "endreborn:chronologist"}})
                                                .setAspects(<aspect:alienis>*30       ,<aspect:desiderium>*20 ,<aspect:visum>*10); 
<entity:endreborn:chronologist>                 .setAspects(<aspect:alienis>*30       ,<aspect:desiderium>*20 ,<aspect:visum>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "endreborn:endguard"}})
                                                .setAspects(<aspect:alienis>*30       ,<aspect:volatus>*10    ,<aspect:ventus>*10); 
<entity:endreborn:endguard>                     .setAspects(<aspect:alienis>*30       ,<aspect:volatus>*10    ,<aspect:ventus>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "endreborn:watcher"}})
                                                .setAspects(<aspect:alienis>*30       ,<aspect:tenebrae>*20   ,<aspect:sensus>*10); 
<entity:endreborn:watcher>                      .setAspects(<aspect:alienis>*30       ,<aspect:tenebrae>*20   ,<aspect:sensus>*10); 

/* 
_ ____ ____    ____ _  _ ___     ____ _ ____ ____ 
| |    |___    |__| |\ | |  \    |___ | |__/ |___ 
| |___ |___    |  | | \| |__/    |    | |  \ |___ 
                                                  
*/

<minecraft:spawn_egg>.withTag({EntityTag: {id: "iceandfire:myrmex_worker"}})
                                                .setAspects(<aspect:mythus>*10        ,<aspect:bestia>*10     ,<aspect:fabrico>*5);
<entity:iceandfire:myrmex_worker>               .setAspects(<aspect:mythus>*10        ,<aspect:bestia>*10     ,<aspect:fabrico>*5);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "iceandfire:myrmex_soldier"}})
                                                .setAspects(<aspect:mythus>*15        ,<aspect:bestia>*15     ,<aspect:aversio>*20);
<entity:iceandfire:myrmex_soldier>              .setAspects(<aspect:mythus>*15        ,<aspect:bestia>*15     ,<aspect:aversio>*20);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "iceandfire:myrmex_sentinel"}})
                                                .setAspects(<aspect:mythus>*20        ,<aspect:bestia>*20     ,<aspect:sensus>*50);
<entity:iceandfire:myrmex_sentinel>             .setAspects(<aspect:mythus>*20        ,<aspect:bestia>*20     ,<aspect:sensus>*50);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "iceandfire:myrmex_royal"}})
                                                .setAspects(<aspect:mythus>*30        ,<aspect:bestia>*30     ,<aspect:volatus>*50);
<entity:iceandfire:myrmex_royal>                .setAspects(<aspect:mythus>*30        ,<aspect:bestia>*30     ,<aspect:volatus>*50);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "iceandfire:myrmex_queen"}})
                                                .setAspects(<aspect:mythus>*300       ,<aspect:bestia>*300    ,<aspect:desiderium>*200);
<entity:iceandfire:myrmex_queen>                .setAspects(<aspect:mythus>*300       ,<aspect:bestia>*300    ,<aspect:desiderium>*200);

<minecraft:spawn_egg>.withTag({EntityTag: {id: "iceandfire:firedragon"}})
                                                .setAspects(<aspect:draco>*500        ,<aspect:praecantatio>*500  ,<aspect:desiderium>*500  ,<aspect:victus>*500    ,<aspect:ignis>*500);
<entity:iceandfire:firedragon>                  .setAspects(<aspect:draco>*500        ,<aspect:praecantatio>*500  ,<aspect:desiderium>*500  ,<aspect:victus>*500    ,<aspect:ignis>*500);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "iceandfire:icedragon"}})
                                                .setAspects(<aspect:draco>*500        ,<aspect:praecantatio>*500  ,<aspect:desiderium>*500  ,<aspect:victus>*500    ,<aspect:gelum>*500);
<entity:iceandfire:icedragon>                   .setAspects(<aspect:draco>*500        ,<aspect:praecantatio>*500  ,<aspect:desiderium>*500  ,<aspect:victus>*500    ,<aspect:gelum>*500);

<minecraft:spawn_egg>.withTag({EntityTag: {id: "iceandfire:seaserpent"}})
                                                .setAspects(<aspect:draco>*100        ,<aspect:aqua>*300      ,<aspect:mythus>*300);
<entity:iceandfire:seaserpent>                  .setAspects(<aspect:draco>*100        ,<aspect:aqua>*300      ,<aspect:mythus>*300);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "iceandfire:siren"}})
                                                .setAspects(<aspect:sonus>*50         ,<aspect:imperium>*30   ,<aspect:aqua>*50         ,<aspect:mythus>*30);
<entity:iceandfire:siren>                       .setAspects(<aspect:sonus>*50         ,<aspect:imperium>*30   ,<aspect:aqua>*50         ,<aspect:mythus>*30);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "iceandfire:hippocampus"}})
                                                .setAspects(<aspect:motus>*20         ,<aspect:mythus>*20     ,<aspect:aqua>*50);
<entity:iceandfire:hippocampus>                 .setAspects(<aspect:motus>*20         ,<aspect:mythus>*20     ,<aspect:aqua>*50);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "iceandfire:gorgon"}})
                                                .setAspects(<aspect:mythus>*200       ,<aspect:praecantatio>*100  ,<aspect:exanimis>*200    ,<aspect:humanus>*400);
<entity:iceandfire:gorgon>                      .setAspects(<aspect:mythus>*200       ,<aspect:praecantatio>*100  ,<aspect:exanimis>*200    ,<aspect:humanus>*400);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "iceandfire:cyclops"}})
                                                .setAspects(<aspect:mythus>*100       ,<aspect:visum>*100     ,<aspect:potentia>*200);
<entity:iceandfire:cyclops>                     .setAspects(<aspect:mythus>*400       ,<aspect:visum>*100     ,<aspect:potentia>*200);

<minecraft:spawn_egg>.withTag({EntityTag: {id: "iceandfire:if_troll"}})
                                                .setAspects(<aspect:mythus>*50        ,<aspect:tenebrae>*50   ,<aspect:terra>*100);
<entity:iceandfire:if_troll>                    .setAspects(<aspect:mythus>*50        ,<aspect:tenebrae>*50   ,<aspect:terra>*100);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "iceandfire:if_hydra"}})
                                                .setAspects(<aspect:mythus>*100       ,<aspect:praecantatio>*100  ,<aspect:alkimia>*100    ,<aspect:victus>*200); 
<entity:iceandfire:if_hydra>                    .setAspects(<aspect:mythus>*100       ,<aspect:praecantatio>*100  ,<aspect:alkimia>*100    ,<aspect:victus>*200); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "iceandfire:stymphalianbird"}})
                                                .setAspects(<aspect:mythus>*20        ,<aspect:aer>*10        ,<aspect:volatus>*20     ,<aspect:ventus>*20); 
<entity:iceandfire:stymphalianbird>             .setAspects(<aspect:mythus>*20        ,<aspect:aer>*10        ,<aspect:volatus>*20     ,<aspect:ventus>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "iceandfire:amphithere"}})
                                                .setAspects(<aspect:mythus>*25        ,<aspect:aer>*15        ,<aspect:volatus>*15     ,<aspect:desiderium>*20); 
<entity:iceandfire:amphithere>                  .setAspects(<aspect:mythus>*25        ,<aspect:aer>*15        ,<aspect:volatus>*15     ,<aspect:desiderium>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "iceandfire:deathworm"}})
                                                .setAspects(<aspect:mythus>*30        ,<aspect:vinculum>*20   ,<aspect:bestia>*50);
<entity:iceandfire:deathworm>                   .setAspects(<aspect:mythus>*30        ,<aspect:vinculum>*20   ,<aspect:bestia>*50);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "iceandfire:if_cockatrice"}})
                                                .setAspects(<aspect:mythus>*10        ,<aspect:mortuus>*20    ,<aspect:motus>*20        ,<aspect:perditio>*30); 
<entity:iceandfire:if_cockatrice>               .setAspects(<aspect:mythus>*10        ,<aspect:mortuus>*20    ,<aspect:motus>*20        ,<aspect:perditio>*30); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "iceandfire:hippogryph"}})
                                                .setAspects(<aspect:mythus>*50        ,<aspect:ventus>*50     ,<aspect:victus>*50);
<entity:iceandfire:hippogryph>                  .setAspects(<aspect:mythus>*50        ,<aspect:ventus>*50     ,<aspect:victus>*50);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "iceandfire:if_pixie"}})
                                                .setAspects(<aspect:mythus>*20        ,<aspect:praecantatio>*50,<aspect:humanus>*20      ,<aspect:desiderium>*50); 
<entity:iceandfire:if_pixie>                    .setAspects(<aspect:mythus>*20        ,<aspect:praecantatio>*50,<aspect:humanus>*20      ,<aspect:desiderium>*50); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "iceandfire:snowvillager"}})
                                                .setAspects(<aspect:humanus>*20       ,<aspect:permutatio>*20 ,<aspect:desiderium>*20); 
<entity:iceandfire:snowvillager>                .setAspects(<aspect:humanus>*20       ,<aspect:permutatio>*20 ,<aspect:desiderium>*20); 

<minecraft:spawn_egg>.withTag({EntityTag: {id: "iceandfire:dread_thrall"}})
                                                .setAspects(<aspect:exanimis>*20      ,<aspect:perditio>*20   ,<aspect:spiritus>*20); 
<entity:iceandfire:dread_thrall>                .setAspects(<aspect:exanimis>*20      ,<aspect:perditio>*20   ,<aspect:spiritus>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "iceandfire:dread_beast"}})
                                                .setAspects(<aspect:exanimis>*20      ,<aspect:bestia>*20     ,<aspect:spiritus>*20); 
<entity:iceandfire:dread_beast>                 .setAspects(<aspect:exanimis>*20      ,<aspect:bestia>*20     ,<aspect:spiritus>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "iceandfire:dread_scuttler"}})
                                                .setAspects(<aspect:exanimis>*20      ,<aspect:alkimia>*20    ,<aspect:spiritus>*20); 
<entity:iceandfire:dread_scuttler>              .setAspects(<aspect:exanimis>*20      ,<aspect:alkimia>*20    ,<aspect:spiritus>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "iceandfire:dread_ghoul"}})
                                                .setAspects(<aspect:exanimis>*20      ,<aspect:perditio>*20   ,<aspect:spiritus>*20); 
<entity:iceandfire:dread_ghoul>                 .setAspects(<aspect:exanimis>*20      ,<aspect:perditio>*20   ,<aspect:spiritus>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "iceandfire:dread_knight"}})
                                                .setAspects(<aspect:exanimis>*20      ,<aspect:metallum>*20   ,<aspect:spiritus>*20); 
<entity:iceandfire:dread_knight>                .setAspects(<aspect:exanimis>*20      ,<aspect:metallum>*20   ,<aspect:spiritus>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "iceandfire:dread_horse"}})
                                                .setAspects(<aspect:exanimis>*20      ,<aspect:motus>*20      ,<aspect:spiritus>*20); 
<entity:iceandfire:dread_horse>                 .setAspects(<aspect:exanimis>*20      ,<aspect:motus>*20      ,<aspect:spiritus>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "iceandfire:dread_lich"}})
                                                .setAspects(<aspect:exanimis>*20      ,<aspect:praecantatio>*20,<aspect:spiritus>*20); 
<entity:iceandfire:dread_lich>                  .setAspects(<aspect:exanimis>*20      ,<aspect:praecantatio>*20,<aspect:spiritus>*20); 


/*
_ _  _ ___  _  _ ____ ___ ____ _ ____ _    ____ ____ ____ ____ ____ ____ _ _  _ ____ 
| |\ | |  \ |  | [__   |  |__/ | |__| |    |___ |  | |__/ |___ | __ |  | | |\ | | __ 
| | \| |__/ |__| ___]  |  |  \ | |  | |___ |    |__| |  \ |___ |__] |__| | | \| |__] 
                                                                                     
*/

<minecraft:spawn_egg>.withTag({EntityTag: {id: "industrialforegoing:pink_slime"}})
                                                .setAspects(<aspect:aqua>*10          ,<aspect:victus>*10     ,<aspect:desiderium>*5); 
<entity:industrialforegoing:pink_slime>         .setAspects(<aspect:aqua>*10          ,<aspect:victus>*10     ,<aspect:desiderium>*5); 

/*
_  _ ____ ___ _  _ ____ ____ ____ _  _ ___  _ _  _ ____ ____ ____ ____ ____ 
|\ | |___  |  |__| |___ |__/ |___ |\ | |  \ | |\ | | __ |  | |__/ |___ [__  
| \| |___  |  |  | |___ |  \ |___ | \| |__/ | | \| |__] |__| |  \ |___ ___] 
                                                                            
*/

<minecraft:spawn_egg>.withTag({EntityTag: {id: "netherendingores:netherfish"}})
                                                .setAspects(<aspect:bestia>*10        ,<aspect:ignis>*10      ,<aspect:infernum>*5); 
<entity:netherendingores:netherfish>            .setAspects(<aspect:bestia>*10        ,<aspect:ignis>*10      ,<aspect:infernum>*5); 

/*
_  _ _  _ ____ _    ____ ____ ____ ____ ____ ____ ____ ___ 
|\ | |  | |    |    |___ |__| |__/ |    |__/ |__| |___  |  
| \| |__| |___ |___ |___ |  | |  \ |___ |  \ |  | |     |  
                                                           
*/

<minecraft:spawn_egg>.withTag({EntityTag: {id: "nuclearcraft:feral_ghoul"}})
                                                .setAspects(<aspect:exanimis>*10      ,<aspect:mortuus>*10    ,<aspect:humanus>*20,     <aspect:potentia>*50); 
<entity:nuclearcraft:feral_ghoul>               .setAspects(<aspect:exanimis>*10      ,<aspect:mortuus>*10    ,<aspect:humanus>*20,     <aspect:potentia>*50); 

/*
____ ____ _  _ ___  ____ _  _ ___ _  _ _ _  _ ____ ____ 
|__/ |__| |\ | |  \ |  | |\/|  |  |__| | |\ | | __ [__  
|  \ |  | | \| |__/ |__| |  |  |  |  | | | \| |__] ___] 
                                                        
*/

<minecraft:spawn_egg>.withTag({EntityTag: {id: "randomthings:spirit"}})
                                                .setAspects(<aspect:spiritus>*20); 
<entity:randomthings:spirit>                    .setAspects(<aspect:spiritus>*20); 

/*
___ _  _ ____ _  _ _  _ ____ ____ ____ ____ ___ 
 |  |__| |__| |  | |\/| |    |__/ |__| |___  |  
 |  |  | |  | |__| |  | |___ |  \ |  | |     |  
                                                
*/

<minecraft:spawn_egg>.withTag({EntityTag: {id: "thaumcraft:brainyzombie"}})
                                                .setAspects(<aspect:exanimis>*10      ,<aspect:mortuus>*10    ,<aspect:humanus>*20,     <aspect:cognitio>*10); 
<entity:thaumcraft:brainyzombie>                .setAspects(<aspect:exanimis>*10      ,<aspect:mortuus>*10    ,<aspect:humanus>*20,     <aspect:cognitio>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "thaumcraft:cultistcleric"}})
                                                .setAspects(<aspect:humanus>*20       ,<aspect:alienis>*20    ,<aspect:praecantatio>*10); 
<entity:thaumcraft:cultistcleric>               .setAspects(<aspect:humanus>*20       ,<aspect:alienis>*20    ,<aspect:praecantatio>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "thaumcraft:cultistknight"}})
                                                .setAspects(<aspect:humanus>*20       ,<aspect:alienis>*20    ,<aspect:aversio>*10); 
<entity:thaumcraft:cultistknight>               .setAspects(<aspect:humanus>*20       ,<aspect:alienis>*20    ,<aspect:aversio>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "thaumcraft:cultistportallesser"}})
                                                .setAspects(<aspect:praecantatio>*20  ,<aspect:alienis>*50    ,<aspect:motus>*30); 
<entity:thaumcraft:cultistportallesser>         .setAspects(<aspect:praecantatio>*20  ,<aspect:alienis>*50    ,<aspect:motus>*30); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "thaumcraft:eldritchcrab"}})
                                                .setAspects(<aspect:vitium>*20        ,<aspect:alienis>*20    ,<aspect:praemunio>*10); 
<entity:thaumcraft:eldritchcrab>                .setAspects(<aspect:vitium>*20        ,<aspect:alienis>*20    ,<aspect:praemunio>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "thaumcraft:eldritchguardian"}})
                                                .setAspects(<aspect:alienis>*30       ,<aspect:mortuus>*20    ,<aspect:vacuos>*10); 
<entity:thaumcraft:eldritchguardian>            .setAspects(<aspect:alienis>*30       ,<aspect:mortuus>*20    ,<aspect:vacuos>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "thaumcraft:firebat"}})
                                                .setAspects(<aspect:bestia>*20        ,<aspect:ignis>*20      ,<aspect:infernum>*10     ,<aspect:volatus>*10); 
<entity:thaumcraft:firebat>                     .setAspects(<aspect:bestia>*20        ,<aspect:ignis>*20      ,<aspect:infernum>*10     ,<aspect:volatus>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "thaumcraft:inhabitedzombie"}})
                                                .setAspects(<aspect:exanimis>*10      ,<aspect:mortuus>*10    ,<aspect:humanus>*20,     <aspect:imperium>*30); 
<entity:thaumcraft:inhabitedzombie>             .setAspects(<aspect:exanimis>*10      ,<aspect:mortuus>*10    ,<aspect:humanus>*20,     <aspect:imperium>*30); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "thaumcraft:mindspider"}})
                                                .setAspects(<aspect:cognitio>*10      ,<aspect:bestia>*5      ,<aspect:alienis>*5); 
<entity:thaumcraft:mindspider>                  .setAspects(<aspect:cognitio>*10      ,<aspect:bestia>*5      ,<aspect:alienis>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "thaumcraft:pech"}})
                                                .setAspects(<aspect:humanus>*20       ,<aspect:desiderium>*20 ,<aspect:permutatio>*10); 
<entity:thaumcraft:pech>                        .setAspects(<aspect:humanus>*20       ,<aspect:desiderium>*20 ,<aspect:permutatio>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "thaumcraft:taintacle"}})
                                                .setAspects(<aspect:vitium>*20        ,<aspect:alienis>*5     ,<aspect:victus>*20); 
<entity:thaumcraft:taintacle>                   .setAspects(<aspect:vitium>*20        ,<aspect:alienis>*5     ,<aspect:victus>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "thaumcraft:taintcrawler"}})
                                                .setAspects(<aspect:vitium>*20        ,<aspect:vacuos>*10     ,<aspect:vinculum>*10); 
<entity:thaumcraft:taintcrawler>                .setAspects(<aspect:vitium>*20        ,<aspect:vacuos>*10     ,<aspect:vinculum>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "thaumcraft:taintseed"}})
                                                .setAspects(<aspect:vitium>*50        ,<aspect:victus>*20); 
<entity:thaumcraft:taintseed>                   .setAspects(<aspect:vitium>*50        ,<aspect:victus>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "thaumcraft:taintseedprime"}})
                                                .setAspects(<aspect:vitium>*150       ,<aspect:victus>*60); 
<entity:thaumcraft:taintseedprime>              .setAspects(<aspect:vitium>*150       ,<aspect:victus>*60); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "thaumcraft:thaumslime"}})
                                                .setAspects(<aspect:vitium>*10        ,<aspect:alkimia>*20    ,<aspect:aqua>*20); 
<entity:thaumcraft:thaumslime>                  .setAspects(<aspect:vitium>*10        ,<aspect:alkimia>*20    ,<aspect:aqua>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "thaumcraft:taintswarm"}})
                                                .setAspects(<aspect:vitium>*20        ,<aspect:sanguis>*20); 
<entity:thaumcraft:taintswarm>                  .setAspects(<aspect:vitium>*20        ,<aspect:sanguis>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "thaumcraft:wisp"}})
                                                .setAspects(<aspect:auram>*20); 
<entity:thaumcraft:wisp>                        .setAspects(<aspect:auram>*20); 

/*
___ _  _ ____ _  _ _  _ ____ ___  ___  _ ___ _ ____ _  _ ____ 
 |  |__| |__| |  | |\/| |__| |  \ |  \ |  |  | |  | |\ | [__  
 |  |  | |  | |__| |  | |  | |__/ |__/ |  |  | |__| | \| ___] 
                                                              
*/

<minecraft:spawn_egg>.withTag({EntityTag: {id: "thaumadditions:blue_wolf"}})
                                                .setAspects(<aspect:bestia>*20        ,<aspect:auram>*20      ,<aspect:mana>*10); 
<entity:thaumadditions:blue_wolf>               .setAspects(<aspect:bestia>*20        ,<aspect:auram>*20      ,<aspect:mana>*10); 

/*
___ _  _ ____ _  _ _  _ _ ____ ____ _  _ ____ _  _ ____ _  _ ___ ____ ___ _ ____ _  _ 
 |  |__| |__| |  | |\/| | |    |__| |  | | __ |\/| |___ |\ |  |  |__|  |  | |  | |\ | 
 |  |  | |  | |__| |  | | |___ |  | |__| |__] |  | |___ | \|  |  |  |  |  | |__| | \| 
                                                                                      
*/

<minecraft:spawn_egg>.withTag({EntityTag: {id: "thaumicaugmentation:eldritch_guardian"}})
                                                .setAspects(<aspect:alienis>*50       ,<aspect:mortuus>*30    ,<aspect:vacuos>*20); 
<entity:thaumicaugmentation:eldritch_guardian>  .setAspects(<aspect:alienis>*50       ,<aspect:mortuus>*30    ,<aspect:vacuos>*20); 

/*
___ _  _ ____ ____ _  _ ____ _       ____ ____ _  _ _  _ ___  ____ ___ _ ____ _  _ 
 |  |__| |___ |__/ |\/| |__| |       |___ |  | |  | |\ | |  \ |__|  |  | |  | |\ | 
 |  |  | |___ |  \ |  | |  | |___    |    |__| |__| | \| |__/ |  |  |  | |__| | \| 
                                                                                   
*/

<minecraft:spawn_egg>.withTag({EntityTag: {id: "thermalfoundation:basalz"}})
                                                .setAspects(<aspect:terra>*20         ,<aspect:metallum>*20); 
<entity:thermalfoundation:basalz>               .setAspects(<aspect:terra>*20         ,<aspect:metallum>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "thermalfoundation:blitz"}})
                                                .setAspects(<aspect:aer>*20           ,<aspect:ventus>*20); 
<entity:thermalfoundation:blitz>                .setAspects(<aspect:aer>*20           ,<aspect:ventus>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "thermalfoundation:blizz"}})
                                                .setAspects(<aspect:aqua>*20          ,<aspect:gelum>*20); 
<entity:thermalfoundation:blizz>                .setAspects(<aspect:aqua>*20          ,<aspect:gelum>*20); 

/*
___ _ _  _ _  _ ____ ____ . ____    ____ ____ _  _ ____ ___ ____ _  _ ____ ___ 
 |  | |\ | |_/  |___ |__/ ' [__     |    |  | |\ | [__   |  |__/ |  | |     |  
 |  | | \| | \_ |___ |  \   ___]    |___ |__| | \| ___]  |  |  \ |__| |___  |  
                                                                               
*/

<minecraft:spawn_egg>.withTag({EntityTag: {id: "tconstruct:blueslime"}})
                                                .setAspects(<aspect:aqua>*10          ,<aspect:victus>*10         ,<aspect:fabrico>*5); 
<entity:tconstruct:blueslime>                   .setAspects(<aspect:aqua>*10          ,<aspect:victus>*10         ,<aspect:fabrico>*5); 

/*
___ _ _ _ _ _    _ ____ _  _ ___ ____ ____ ____ ____ ____ ___ 
 |  | | | | |    | | __ |__|  |  |___ |  | |__/ |___ [__   |  
 |  |_|_| | |___ | |__] |  |  |  |    |__| |  \ |___ ___]  |  
                                                              
*/

<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:bighorn_sheep"}})
                                                .setAspects(<aspect:bestia>*15        ,<aspect:terra>*15      ,<aspect:fabrico>*10); 
<entity:twilightforest:bighorn_sheep>           .setAspects(<aspect:bestia>*15        ,<aspect:terra>*15      ,<aspect:fabrico>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:bunny"}})
                                                .setAspects(<aspect:bestia>*10        ,<aspect:terra>*10      ,<aspect:visum>*5); 
<entity:twilightforest:bunny>                   .setAspects(<aspect:bestia>*10        ,<aspect:terra>*10      ,<aspect:visum>*5);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:deer"}})
                                                .setAspects(<aspect:bestia>*15        ,<aspect:terra>*15      ,<aspect:victus>*10); 
<entity:twilightforest:deer>                    .setAspects(<aspect:bestia>*15        ,<aspect:terra>*15      ,<aspect:victus>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:firefly"}})
                                                .setAspects(<aspect:lux>*5); 
<entity:twilightforest:firefly>                 .setAspects(<aspect:lux>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:hedge_spider"}})
                                                .setAspects(<aspect:bestia>*20        ,<aspect:vinculum>*10   ,<aspect:herba>*10); 
<entity:twilightforest:hedge_spider>            .setAspects(<aspect:bestia>*20        ,<aspect:vinculum>*10   ,<aspect:herba>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:hostile_wolf"}})
                                                .setAspects(<aspect:bestia>*20        ,<aspect:terra>*10      ,<aspect:aversio>*5); 
<entity:twilightforest:hostile_wolf>            .setAspects(<aspect:bestia>*20        ,<aspect:terra>*10      ,<aspect:aversio>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:kobold"}})
                                                .setAspects(<aspect:humanus>*10       ,<aspect:herba>*10      ,<aspect:instrumentum>*5); 
<entity:twilightforest:kobold>                  .setAspects(<aspect:humanus>*10       ,<aspect:herba>*10      ,<aspect:instrumentum>*5);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:mist_wolf"}})
                                                .setAspects(<aspect:bestia>*20        ,<aspect:terra>*20      ,<aspect:aversio>*5); 
<entity:twilightforest:mist_wolf>               .setAspects(<aspect:bestia>*20        ,<aspect:terra>*20      ,<aspect:aversio>*5);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:raven"}})
                                                .setAspects(<aspect:bestia>*10        ,<aspect:aer>*10        ,<aspect:auram>*5); 
<entity:twilightforest:raven>                   .setAspects(<aspect:bestia>*10        ,<aspect:aer>*10        ,<aspect:auram>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:redcap"}})
                                                .setAspects(<aspect:humanus>*10       ,<aspect:instrumentum>*10,<aspect:exitium>*5); 
<entity:twilightforest:redcap>                  .setAspects(<aspect:humanus>*10       ,<aspect:instrumentum>*10,<aspect:exitium>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:redcap_sapper"}})
                                                .setAspects(<aspect:humanus>*10       ,<aspect:instrumentum>*10,<aspect:exitium>*5); 
<entity:twilightforest:redcap_sapper>           .setAspects(<aspect:humanus>*10       ,<aspect:instrumentum>*10,<aspect:exitium>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:skeleton_druid"}})
                                                .setAspects(<aspect:mortuus>*10       ,<aspect:herba>*10       ,<aspect:praecantatio>*20); 
<entity:twilightforest:skeleton_druid>          .setAspects(<aspect:mortuus>*10       ,<aspect:herba>*10       ,<aspect:praecantatio>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:squirrel"}})
                                                .setAspects(<aspect:bestia>*10        ,<aspect:terra>*10       ,<aspect:victus>*20); 
<entity:twilightforest:squirrel>                .setAspects(<aspect:bestia>*10        ,<aspect:terra>*10       ,<aspect:victus>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:wild_boar"}})
                                                .setAspects(<aspect:bestia>*15        ,<aspect:terra>*15       ,<aspect:victus>*10); 
<entity:twilightforest:wild_boar>               .setAspects(<aspect:bestia>*15        ,<aspect:terra>*15       ,<aspect:victus>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:tiny_bird"}})
                                                .setAspects(<aspect:bestia>*10        ,<aspect:volatus>*10     ,<aspect:sonus>*10); 
<entity:twilightforest:tiny_bird>               .setAspects(<aspect:bestia>*10        ,<aspect:volatus>*10     ,<aspect:sonus>*10); 

<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:death_tome"}})
                                                .setAspects(<aspect:cognitio>*20      ,<aspect:praemunio>*10   ,<aspect:mortuus>*10); 
<entity:twilightforest:death_tome>              .setAspects(<aspect:cognitio>*20      ,<aspect:praemunio>*10   ,<aspect:mortuus>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:wraith"}})
                                                .setAspects(<aspect:spiritus>*20      ,<aspect:desiderium>*10  ,<aspect:mortuus>*10); 
<entity:twilightforest:wraith>                  .setAspects(<aspect:spiritus>*20      ,<aspect:desiderium>*10  ,<aspect:mortuus>*10); 

<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:king_spider"}})
                                                .setAspects(<aspect:bestia>*100       ,<aspect:vinculum>*50    ,<aspect:mortuus>*50); 
<entity:twilightforest:king_spider>             .setAspects(<aspect:bestia>*100       ,<aspect:vinculum>*50    ,<aspect:mortuus>*50); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:maze_slime"}})
                                                .setAspects(<aspect:aqua>*20          ,<aspect:victus>*10      ,<aspect:vinculum>*5); 
<entity:twilightforest:maze_slime>              .setAspects(<aspect:aqua>*20          ,<aspect:victus>*10      ,<aspect:vinculum>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:minotaur"}})
                                                .setAspects(<aspect:bestia>*10        ,<aspect:victus>*5       ,<aspect:vinculum>*5); 
<entity:twilightforest:minotaur>                .setAspects(<aspect:bestia>*10        ,<aspect:victus>*5       ,<aspect:vinculum>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:mosquito_swarm"}})
                                                .setAspects(<aspect:vitium>*20        ,<aspect:victus>*10      ,<aspect:sanguis>*5); 
<entity:twilightforest:mosquito_swarm>          .setAspects(<aspect:vitium>*20        ,<aspect:victus>*10      ,<aspect:sanguis>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:pinch_beetle"}})
                                                .setAspects(<aspect:bestia>*20        ,<aspect:aer>*10         ,<aspect:sonus>*5); 
<entity:twilightforest:pinch_beetle>            .setAspects(<aspect:bestia>*20        ,<aspect:aer>*10         ,<aspect:sonus>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:slime_beetle"}})
                                                .setAspects(<aspect:bestia>*20        ,<aspect:alkimia>*10     ,<aspect:victus>*5); 
<entity:twilightforest:slime_beetle>            .setAspects(<aspect:bestia>*20        ,<aspect:alkimia>*10     ,<aspect:victus>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:swarm_spider"}})
                                                .setAspects(<aspect:bestia>*10        ,<aspect:vinculum>*5     ,<aspect:mortuus>*5); 
<entity:twilightforest:swarm_spider>            .setAspects(<aspect:bestia>*10        ,<aspect:vinculum>*5     ,<aspect:mortuus>*5); 

<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:yeti"}})
                                                .setAspects(<aspect:bestia>*15        ,<aspect:gelum>*30       ,<aspect:praemunio>*10); 
<entity:twilightforest:yeti>                    .setAspects(<aspect:bestia>*15        ,<aspect:gelum>*30       ,<aspect:praemunio>*10);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:winter_wolf"}})
                                                .setAspects(<aspect:bestia>*20        ,<aspect:gelum>*20       ,<aspect:aversio>*5); 
<entity:twilightforest:winter_wolf>             .setAspects(<aspect:bestia>*20        ,<aspect:gelum>*20       ,<aspect:aversio>*5);

<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:ice_crystal"}})
                                                .setAspects(<aspect:gelum>*20         ,<aspect:motus>*5); 
<entity:twilightforest:ice_crystal>             .setAspects(<aspect:gelum>*20         ,<aspect:motus>*5);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:penguin"}})
                                                .setAspects(<aspect:bestia>*20        ,<aspect:gelum>*5         ,<aspect:ventus>*5); 
<entity:twilightforest:penguin>                 .setAspects(<aspect:bestia>*20        ,<aspect:gelum>*5         ,<aspect:ventus>*5);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:snow_guardian"}})
                                                .setAspects(<aspect:spiritus>*20      ,<aspect:gelum>*5         ,<aspect:praemunio>*10); 
<entity:twilightforest:snow_guardian>           .setAspects(<aspect:spiritus>*20      ,<aspect:gelum>*5         ,<aspect:praemunio>*10);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:stable_ice_core"}})
                                                .setAspects(<aspect:gelum>*40         ,<aspect:ordo>*10); 
<entity:twilightforest:stable_ice_core>         .setAspects(<aspect:gelum>*40         ,<aspect:ordo>*10);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:unstable_ice_core"}})
                                                .setAspects(<aspect:gelum>*40         ,<aspect:ordo>*10); 
<entity:twilightforest:unstable_ice_core>       .setAspects(<aspect:gelum>*40         ,<aspect:ordo>*10);

<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:blockchain_goblin"}})
                                                .setAspects(<aspect:humanus>*10       ,<aspect:aversio>*10); 
<entity:twilightforest:blockchain_goblin>       .setAspects(<aspect:humanus>*10       ,<aspect:aversio>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:goblin_knight_lower"}})
                                                .setAspects(<aspect:humanus>*10       ,<aspect:praemunio>*10); 
<entity:twilightforest:goblin_knight_lower>     .setAspects(<aspect:humanus>*10       ,<aspect:praemunio>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:helmet_crab"}})
                                                .setAspects(<aspect:bestia>*10        ,<aspect:praemunio>*10); 
<entity:twilightforest:helmet_crab>             .setAspects(<aspect:bestia>*10        ,<aspect:praemunio>*10); 

<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:fire_beetle"}})
                                                .setAspects(<aspect:bestia>*20        ,<aspect:ignis>*10        ,<aspect:exitium>*5); 
<entity:twilightforest:fire_beetle>             .setAspects(<aspect:bestia>*20        ,<aspect:ignis>*10        ,<aspect:exitium>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:mini_ghast"}})
                                                .setAspects(<aspect:spiritus>*25      ,<aspect:fluctus>*10      ,<aspect:sanguis>*5); 
<entity:twilightforest:mini_ghast>              .setAspects(<aspect:spiritus>*25      ,<aspect:fluctus>*10      ,<aspect:sanguis>*5);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:tower_broodling"}})
                                                .setAspects(<aspect:bestia>*10        ,<aspect:herba>*10        ,<aspect:victus>*5); 
<entity:twilightforest:tower_broodling>         .setAspects(<aspect:bestia>*10        ,<aspect:herba>*10        ,<aspect:victus>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:tower_ghast"}})
                                                .setAspects(<aspect:spiritus>*50      ,<aspect:fluctus>*20      ,<aspect:sanguis>*10); 
<entity:twilightforest:tower_ghast>             .setAspects(<aspect:spiritus>*50      ,<aspect:fluctus>*20      ,<aspect:sanguis>*10);
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:tower_golem"}})
                                                .setAspects(<aspect:metallum>*50      ,<aspect:victus>*20); 
<entity:twilightforest:tower_golem>             .setAspects(<aspect:metallum>*50      ,<aspect:victus>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:tower_termite"}})
                                                .setAspects(<aspect:herba>*20         ,<aspect:bestia>*10       ,<aspect:vinculum>*10); 
<entity:twilightforest:tower_termite>           .setAspects(<aspect:herba>*20         ,<aspect:bestia>*10       ,<aspect:vinculum>*10); 

<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:armored_giant"}})
                                                .setAspects(<aspect:humanus>*50       ,<aspect:praemunio>*30    ,<aspect:mythus>*20); 
<entity:twilightforest:armored_giant>           .setAspects(<aspect:humanus>*50       ,<aspect:praemunio>*30    ,<aspect:mythus>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:giant_miner"}})
                                                .setAspects(<aspect:humanus>*50       ,<aspect:instrumentum>*30 ,<aspect:mythus>*20); 
<entity:twilightforest:giant_miner>             .setAspects(<aspect:humanus>*50       ,<aspect:instrumentum>*30 ,<aspect:mythus>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:troll"}})
                                                .setAspects(<aspect:bestia>*30        ,<aspect:tenebrae>*20     ,<aspect:mythus>*5); 
<entity:twilightforest:troll>                   .setAspects(<aspect:bestia>*30        ,<aspect:tenebrae>*20     ,<aspect:mythus>*5); 

<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:adherent"}})
                                                .setAspects(<aspect:instrumentum>*25  ,<aspect:machina>*20      ,<aspect:fabrico>*20); 
<entity:twilightforest:adherent>                .setAspects(<aspect:instrumentum>*25  ,<aspect:machina>*20      ,<aspect:fabrico>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:harbinger_cube"}})
                                                .setAspects(<aspect:sensus>*25        ,<aspect:machina>*20      ,<aspect:visum>*20); 
<entity:twilightforest:harbinger_cube>          .setAspects(<aspect:sensus>*25        ,<aspect:machina>*20      ,<aspect:visum>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:roving_cube"}})
                                                .setAspects(<aspect:tenebrae>*25      ,<aspect:machina>*20      ,<aspect:motus>*20); 
<entity:twilightforest:roving_cube>             .setAspects(<aspect:tenebrae>*25      ,<aspect:machina>*20      ,<aspect:motus>*20); 

/*
____ ____ ___ ____ 
|__/ |__|  |  [__  
|  \ |  |  |  ___] 
                   
*/

<minecraft:spawn_egg>.withTag({EntityTag: {id: "rats:feral_ratlantean"}})
                                                .setAspects(<aspect:perditio>*20      ,<aspect:rattus>*50       ,<aspect:aversio>*30); 
<entity:rats:feral_ratlantean>                  .setAspects(<aspect:perditio>*20      ,<aspect:rattus>*50       ,<aspect:aversio>*30); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "rats:illager_piper"}})
                                                .setAspects(<aspect:humanus>*20       ,<aspect:rattus>*10       ,<aspect:imperium>*10); 
<entity:rats:illager_piper>                     .setAspects(<aspect:humanus>*20       ,<aspect:rattus>*10       ,<aspect:imperium>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "rats:pirat"}})
                                                .setAspects(<aspect:bestia>*10        ,<aspect:rattus>*10       ,<aspect:aversio>*10); 
<entity:rats:pirat>                             .setAspects(<aspect:bestia>*10        ,<aspect:rattus>*10       ,<aspect:aversio>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "rats:plague_beast"}})
                                                .setAspects(<aspect:perditio>*20      ,<aspect:rattus>*50       ,<aspect:vitium>*30); 
<entity:rats:plague_beast>                      .setAspects(<aspect:perditio>*20      ,<aspect:rattus>*50       ,<aspect:vitium>*30); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "rats:plague_cloud"}})
                                                .setAspects(<aspect:vacuos>*20        ,<aspect:rattus>*10       ,<aspect:tenebrae>*10); 
<entity:rats:plague_cloud>                      .setAspects(<aspect:vacuos>*20        ,<aspect:rattus>*10       ,<aspect:tenebrae>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "rats:plague_doctor"}})
                                                .setAspects(<aspect:humanus>*20       ,<aspect:rattus>*10       ,<aspect:ordo>*10); 
<entity:rats:plague_doctor>                     .setAspects(<aspect:humanus>*20       ,<aspect:rattus>*10       ,<aspect:ordo>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "rats:rat"}})
                                                .setAspects(<aspect:rattus>*10); 
<entity:rats:rat>                               .setAspects(<aspect:rattus>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "rats:ratlantean_spirit"}})
                                                .setAspects(<aspect:spiritus>*20      ,<aspect:rattus>*10       ,<aspect:lux>*10); 
<entity:rats:ratlantean_spirit>                 .setAspects(<aspect:spiritus>*20      ,<aspect:rattus>*10       ,<aspect:lux>*10); 

/*
_  _ ____ _  _ _ _    _    ____ 
|  | |__| |\ | | |    |    |__| 
 \/  |  | | \| | |___ |___ |  | 
                                
*/

<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:zombie"}})
                                                .setAspects(<aspect:exanimis>*10      ,<aspect:mortuus>*10      ,<aspect:humanus>*20); 
<entity:minecraft:zombie>                       .setAspects(<aspect:exanimis>*10      ,<aspect:mortuus>*10      ,<aspect:humanus>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:husk"}})
                                                .setAspects(<aspect:exanimis>*10      ,<aspect:mortuus>*10      ,<aspect:humanus>*20        ,<aspect:perditio>*10); 
<entity:minecraft:husk>                         .setAspects(<aspect:exanimis>*10      ,<aspect:mortuus>*10      ,<aspect:humanus>*20        ,<aspect:perditio>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:skeleton"}})
                                                .setAspects(<aspect:mortuus>*10       ,<aspect:perditio>*10     ,<aspect:aversio>*20); 
<entity:minecraft:skeleton>                     .setAspects(<aspect:mortuus>*10       ,<aspect:perditio>*10     ,<aspect:aversio>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:stray"}})
                                                .setAspects(<aspect:mortuus>*10       ,<aspect:perditio>*10     ,<aspect:aversio>*20        ,<aspect:gelum>*10); 
<entity:minecraft:stray>                        .setAspects(<aspect:mortuus>*10       ,<aspect:perditio>*10     ,<aspect:aversio>*20        ,<aspect:gelum>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:creeper"}})
                                                .setAspects(<aspect:exitium>*20       ,<aspect:ignis>*10        ,<aspect:alkimia>*5        ,<aspect:perditio>*10); 
<entity:minecraft:creeper>                      .setAspects(<aspect:exitium>*20       ,<aspect:ignis>*10        ,<aspect:alkimia>*5        ,<aspect:perditio>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:spider"}})
                                                .setAspects(<aspect:bestia>*20        ,<aspect:vinculum>*10     ,<aspect:sensus>*10); 
<entity:minecraft:spider>                       .setAspects(<aspect:bestia>*20        ,<aspect:vinculum>*10     ,<aspect:sensus>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:cave_spider"}})
                                                .setAspects(<aspect:bestia>*15        ,<aspect:vinculum>*10     ,<aspect:sensus>*10        ,<aspect:alkimia>*5); 
<entity:minecraft:cave_spider>                  .setAspects(<aspect:bestia>*15        ,<aspect:vinculum>*10     ,<aspect:sensus>*10        ,<aspect:alkimia>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:witch"}})
                                                .setAspects(<aspect:humanus>*20       ,<aspect:praecantatio>*10 ,<aspect:alkimia>*10); 
<entity:minecraft:witch>                        .setAspects(<aspect:humanus>*20       ,<aspect:praecantatio>*10 ,<aspect:alkimia>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:slime"}})
                                                .setAspects(<aspect:aqua>*10          ,<aspect:victus>*10); 
<entity:minecraft:slime>                        .setAspects(<aspect:aqua>*10          ,<aspect:victus>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:guardian"}})
                                                .setAspects(<aspect:aqua>*20          ,<aspect:praemunio>*10    ,<aspect:sensus>*10); 
<entity:minecraft:guardian>                     .setAspects(<aspect:aqua>*20          ,<aspect:praemunio>*10    ,<aspect:sensus>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:elder_guardian"}})
                                                .setAspects(<aspect:aqua>*200         ,<aspect:praemunio>*100   ,<aspect:mythus>*50); 
<entity:minecraft:elder_guardian>               .setAspects(<aspect:aqua>*200         ,<aspect:praemunio>*100   ,<aspect:mythus>*50); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:silverfish"}})
                                                .setAspects(<aspect:perditio>*20      ,<aspect:vacuos>*10       ,<aspect:vinculum>*10); 
<entity:minecraft:silverfish>                   .setAspects(<aspect:perditio>*20      ,<aspect:vacuos>*10       ,<aspect:vinculum>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:zombie_horse"}})
                                                .setAspects(<aspect:bestia>*40        ,<aspect:exanimis>*10     ,<aspect:motus>*10); 
<entity:minecraft:zombie_horse>                 .setAspects(<aspect:bestia>*40        ,<aspect:exanimis>*10     ,<aspect:motus>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:skeleton_horse"}})
                                                .setAspects(<aspect:bestia>*40        ,<aspect:mortuus>*10      ,<aspect:motus>*10); 
<entity:minecraft:skeleton_horse>               .setAspects(<aspect:bestia>*40        ,<aspect:mortuus>*10      ,<aspect:motus>*10); 

<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:zombie_pigman"}})
                                                .setAspects(<aspect:exanimis>*10      ,<aspect:mortuus>*10      ,<aspect:bestia>*20); 
<entity:minecraft:zombie_pigman>                .setAspects(<aspect:exanimis>*10      ,<aspect:mortuus>*10      ,<aspect:bestia>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:magma_cube"}})
                                                .setAspects(<aspect:aqua>*10          ,<aspect:victus>*10       ,<aspect:infernum>*5); 
<entity:minecraft:magma_cube>                   .setAspects(<aspect:aqua>*10          ,<aspect:victus>*10       ,<aspect:infernum>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:wither_skeleton"}})
                                                .setAspects(<aspect:mortuus>*10       ,<aspect:perditio>*20     ,<aspect:aversio>*20        ,<aspect:spiritus>*20); 
<entity:minecraft:wither_skeleton>              .setAspects(<aspect:mortuus>*10       ,<aspect:perditio>*20     ,<aspect:aversio>*20        ,<aspect:spiritus>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:blaze"}})
                                                .setAspects(<aspect:ignis>*20         ,<aspect:infernum>*20); 
<entity:minecraft:blaze>                        .setAspects(<aspect:ignis>*20         ,<aspect:infernum>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:ghast"}})
                                                .setAspects(<aspect:spiritus>*50      ,<aspect:volatus>*10      ,<aspect:fluctus>*20); 
<entity:minecraft:ghast>                        .setAspects(<aspect:spiritus>*50      ,<aspect:volatus>*10      ,<aspect:fluctus>*20); 

<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:enderman"}})
                                                .setAspects(<aspect:alienis>*40       ,<aspect:tenebrae>*20); 
<entity:minecraft:enderman>                     .setAspects(<aspect:alienis>*40       ,<aspect:tenebrae>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:endermite"}})
                                                .setAspects(<aspect:alienis>*20       ,<aspect:vacuos>*10       ,<aspect:vinculum>*10); 
<entity:minecraft:endermite>                    .setAspects(<aspect:alienis>*20       ,<aspect:vacuos>*10       ,<aspect:vinculum>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:shulker"}})
                                                .setAspects(<aspect:alienis>*40       ,<aspect:volatus>*20      ,<aspect:sonus>*10); 
<entity:minecraft:shulker>                      .setAspects(<aspect:alienis>*40       ,<aspect:volatus>*10      ,<aspect:sonus>*10); 

<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:cow"}})
                                                .setAspects(<aspect:bestia>*10        ,<aspect:terra>*10        ,<aspect:praemunio>*5); 
<entity:minecraft:cow>                          .setAspects(<aspect:bestia>*10        ,<aspect:terra>*10        ,<aspect:praemunio>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:sheep"}})
                                                .setAspects(<aspect:bestia>*10        ,<aspect:terra>*10        ,<aspect:fabrico>*5); 
<entity:minecraft:sheep>                        .setAspects(<aspect:bestia>*10        ,<aspect:terra>*10        ,<aspect:fabrico>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:pig"}})
                                                .setAspects(<aspect:bestia>*10        ,<aspect:terra>*10        ,<aspect:victus>*5); 
<entity:minecraft:pig>                          .setAspects(<aspect:bestia>*10        ,<aspect:terra>*10        ,<aspect:victus>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:chicken"}})
                                                .setAspects(<aspect:bestia>*10        ,<aspect:volatus>*10      ,<aspect:ventus>*5); 
<entity:minecraft:chicken>                      .setAspects(<aspect:bestia>*10        ,<aspect:volatus>*10      ,<aspect:ventus>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:rabbit"}})
                                                .setAspects(<aspect:bestia>*10        ,<aspect:terra>*10        ,<aspect:visum>*5); 
<entity:minecraft:rabbit>                       .setAspects(<aspect:bestia>*10        ,<aspect:terra>*10        ,<aspect:visum>*5); 

<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:wolf"}})
                                                .setAspects(<aspect:bestia>*20        ,<aspect:terra>*10        ,<aspect:aversio>*5); 
<entity:minecraft:wolf>                         .setAspects(<aspect:bestia>*20        ,<aspect:terra>*10        ,<aspect:aversio>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:ocelot"}})
                                                .setAspects(<aspect:bestia>*20        ,<aspect:terra>*10        ,<aspect:desiderium>*5); 
<entity:minecraft:ocelot>                       .setAspects(<aspect:bestia>*20        ,<aspect:terra>*10        ,<aspect:desiderium>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:parrot"}})
                                                .setAspects(<aspect:bestia>*20        ,<aspect:volatus>*10      ,<aspect:sonus>*5); 
<entity:minecraft:parrot>                       .setAspects(<aspect:bestia>*20        ,<aspect:volatus>*10      ,<aspect:sonus>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:horse"}})
                                                .setAspects(<aspect:bestia>*40        ,<aspect:terra>*10        ,<aspect:motus>*5); 
<entity:minecraft:horse>                        .setAspects(<aspect:bestia>*40        ,<aspect:terra>*10        ,<aspect:motus>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:donkey"}})
                                                .setAspects(<aspect:bestia>*30        ,<aspect:terra>*10        ,<aspect:vinculum>*5); 
<entity:minecraft:donkey>                       .setAspects(<aspect:bestia>*30        ,<aspect:terra>*10        ,<aspect:vinculum>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:mule"}})
                                                .setAspects(<aspect:bestia>*30        ,<aspect:terra>*10        ,<aspect:imperium>*5); 
<entity:minecraft:mule>                         .setAspects(<aspect:bestia>*30        ,<aspect:terra>*10        ,<aspect:imperium>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:llama"}})
                                                .setAspects(<aspect:bestia>*30        ,<aspect:terra>*10        ,<aspect:permutatio>*5); 
<entity:minecraft:llama>                        .setAspects(<aspect:bestia>*30        ,<aspect:terra>*10        ,<aspect:permutatio>*5); 

<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:squid"}})
                                                .setAspects(<aspect:bestia>*10        ,<aspect:aqua>*10         ,<aspect:tenebrae>*5); 
<entity:minecraft:squid>                        .setAspects(<aspect:bestia>*10        ,<aspect:aqua>*10         ,<aspect:tenebrae>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:bat"}})
                                                .setAspects(<aspect:bestia>*10        ,<aspect:volatus>*10      ,<aspect:tenebrae>*5); 
<entity:minecraft:bat>                          .setAspects(<aspect:bestia>*10        ,<aspect:volatus>*10      ,<aspect:tenebrae>*5); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:polar_bear"}})
                                                .setAspects(<aspect:bestia>*50        ,<aspect:terra>*10        ,<aspect:gelum>*20); 
<entity:minecraft:polar_bear>                   .setAspects(<aspect:bestia>*50        ,<aspect:terra>*10        ,<aspect:gelum>*20); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:mooshroom"}})
                                                .setAspects(<aspect:bestia>*10        ,<aspect:terra>*10        ,<aspect:victus>*5); 
<entity:minecraft:mooshroom>                    .setAspects(<aspect:bestia>*10        ,<aspect:terra>*10        ,<aspect:victus>*5); 

<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:evocation_illager"}})
                                                .setAspects(<aspect:humanus>*20       ,<aspect:praecantatio>*10 ,<aspect:aversio>*10); 
<entity:minecraft:evocation_illager>            .setAspects(<aspect:humanus>*20       ,<aspect:praecantatio>*10 ,<aspect:aversio>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:villager"}})
                                                .setAspects(<aspect:humanus>*20       ,<aspect:permutatio>*10   ,<aspect:ordo>*10); 
<entity:minecraft:villager>                     .setAspects(<aspect:humanus>*20       ,<aspect:permutatio>*10   ,<aspect:ordo>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:vindication_illager"}})
                                                .setAspects(<aspect:humanus>*20       ,<aspect:desiderium>*10   ,<aspect:aversio>*10); 
<entity:minecraft:vindication_illager>          .setAspects(<aspect:humanus>*20       ,<aspect:desiderium>*10   ,<aspect:aversio>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:vex"}})
                                                .setAspects(<aspect:volatus>*20       ,<aspect:aversio>*10      ,<aspect:praecantatio>*10); 
<entity:minecraft:vex>                          .setAspects(<aspect:volatus>*20       ,<aspect:aversio>*10      ,<aspect:praecantatio>*10); 
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:zombie_villager"}})
                                                .setAspects(<aspect:humanus>*20       ,<aspect:permutatio>*10   ,<aspect:ordo>*10       ,<aspect:exanimis>*20); 
<entity:minecraft:zombie_villager>              .setAspects(<aspect:humanus>*20       ,<aspect:permutatio>*10   ,<aspect:ordo>*10       ,<aspect:exanimis>*20); 

/*
██████╗  ██████╗ ███████╗███████╗███████╗███████╗
██╔══██╗██╔═══██╗██╔════╝██╔════╝██╔════╝██╔════╝
██████╔╝██║   ██║███████╗███████╗█████╗  ███████╗
██╔══██╗██║   ██║╚════██║╚════██║██╔══╝  ╚════██║
██████╔╝╚██████╔╝███████║███████║███████╗███████║
╚═════╝  ╚═════╝ ╚══════╝╚══════╝╚══════╝╚══════╝
*/

val bossesEggs = [
<minecraft:spawn_egg>.withTag({EntityTag: {id: "thaumcraft:eldritchwarden"}}),
<minecraft:spawn_egg>.withTag({EntityTag: {id: "thaumicwonders:corruption_avatar"}}),
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:lich"}}),
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:ur_ghast"}}),
<minecraft:spawn_egg>.withTag({EntityTag: {id: "rats:neo_ratlantean"}}),
<minecraft:spawn_egg>.withTag({EntityTag: {id: "thaumcraft:cultistleader"}}),
<minecraft:spawn_egg>.withTag({EntityTag: {id: "thaumicaugmentation:primal_wisp"}}),
<minecraft:spawn_egg>.withTag({EntityTag: {id: "emberroot:rootsonespriteboss"}}),
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:yeti_alpha"}}),
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:king_spider"}}),
<minecraft:spawn_egg>.withTag({EntityTag: {id: "thaumcraft:eldritchgolem"}}),
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:hydra"}}),
<minecraft:spawn_egg>.withTag({EntityTag: {id: "betteranimalsplus:hirschgeist"}}),
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:naga"}}),
<minecraft:spawn_egg>.withTag({EntityTag: {id: "thaumicaugmentation:eldritch_warden"}}),
<minecraft:spawn_egg>.withTag({EntityTag: {id: "endreborn:endlord"}}),
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:snow_queen"}}),
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:quest_ram"}}),
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:knight_phantom"}}),
<minecraft:spawn_egg>.withTag({EntityTag: {id: "thaumicaugmentation:eldritch_golem"}}),
<minecraft:spawn_egg>.withTag({EntityTag: {id: "thaumcraft:taintaclegiant"}}),
<minecraft:spawn_egg>.withTag({EntityTag: {id: "rats:marbled_cheese_golem"}}),
<minecraft:spawn_egg>.withTag({EntityTag: {id: "thaumcraft:cultistportalgreater"}}),
<minecraft:spawn_egg>.withTag({EntityTag: {id: "rats:black_death"}}),
<minecraft:spawn_egg>.withTag({EntityTag: {id: "twilightforest:minoshroom"}}),
 ] as IItemStack[];
for egg in bossesEggs{
  egg.setAspects(<aspect:caeles>*314);
}

val susEggs = [
//<minecraft:spawn_egg>.withTag({EntityTag: {id: "nuclearcraft:feral_ghoul"}}),
<minecraft:spawn_egg>.withTag({EntityTag: {id: "cyclicmagic:robot"}}),
<minecraft:spawn_egg>.withTag({EntityTag: {id: "mekanism:babyskeleton"}}),
<minecraft:spawn_egg>.withTag({EntityTag: {id: "thaumcraft:giantbrainyzombie"}}),
<minecraft:spawn_egg>.withTag({EntityTag: {id: "plustic:supremeleader"}}),
 ] as IItemStack[];
for egg in susEggs{
  egg.setAspects(<aspect:amogus>);
}
