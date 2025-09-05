#modloaded thaumcraft randomtweaker
#ignoreBracketErrors
#reloadable

import crafttweaker.item.IItemStack;
import thaumcraft.aspect.CTAspectStack;

import scripts.mods.thaumcraft.aspect.set;
import scripts.mods.thaumcraft.aspect.toAspects;

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

set('5🔮 10🔨', <animus:component>); // reagent builder T1
set('15🔮 20🙌', <animus:component:1>); // reagent chains T3
set('15🔮 40🐀', <animus:component:2>); // reagent consumption T3
set('10🔮 30✊', <animus:component:3>); // reagent leech T2
set('10🔮 50💪', <animus:component:4>); // reagent storm T2
set('20🔮 20🏃', <animus:component:5>); // reagent acquisition T4

set('5🔮 5🩸 10🔨', <animus:sigil_builder>); // sigil builder T1
set('15🔮 30🩸 30🙌', <animus:sigil_chains>); // sigil chains T3
set('15🔮 30🩸 30🐀', <animus:sigil_consumption>); // sigil consumption T3
set('10🔮 15🩸 20✊', <animus:sigil_leech>); // sigil leech T2
set('10🔮 15🩸 50💪', <animus:sigil_storm>); // sigil storm T2
set('20🔮 60🩸 40🏃', <animus:sigil_transposition>); // sigil acquisition T4

/*
#######################################################
____ ___  ___  _    _ ____ ___     ____ _  _ ____ ____ ____ ____ ___ _ ____ ____
|__| |__] |__] |    | |___ |  \    |___ |\ | |___ |__/ | __ |___  |  | |    [__
|  | |    |    |___ | |___ |__/    |___ | \| |___ |  \ |__] |___  |  | |___ ___]

#######################################################
*/

set('30💎 15💪', <appliedenergistics2:quartz_block>); // Certus quartz block
set('10💎 10💪 10⟁', <appliedenergistics2:material:10>); // Pure certus quartz

/*
#######################################################
____ ____ ___ ____ ____ _       ____ ____ ____ ____ ____ ____ _   _
|__| [__   |  |__/ |__| |       [__  |  | |__/ |    |___ |__/  \_/
|  | ___]  |  |  \ |  | |___    ___] |__| |  \ |___ |___ |  \   |

#######################################################
*/

set('4⛰️ 2⟁', <astralsorcery:blockmarble>); // marble
set('4⛰️ 💪', <astralsorcery:blockblackmarble>); // sooty marble

set('2🕯️ 🦉', <astralsorcery:itemusabledust>); // illumination powder
set('10🌑 20💪', <astralsorcery:itemusabledust:1>); // nocturnal powder
set('5🔮 10⟁', <astralsorcery:itemcraftingcomponent:4>); // resonating gem
set('20🌱 🔮', <astralsorcery:blockinfusedwood>); // infused wood
set('20🌱 🔮', <astralsorcery:blockinfusedwood:6>); // vibrant infused wood

set('10🔮 5✨ 10💎', <astralsorcery:itemcraftingcomponent:3>); // glass lens and bellow collores lenses
set('10🔮 5✨ 10💎 20🔥', <astralsorcery:itemcoloredlens>); // ignition
set('10🔮 5✨ 10💎 20💀', <astralsorcery:itemcoloredlens:1>); // break
set('10🔮 5✨ 10💎 20🌱', <astralsorcery:itemcoloredlens:2>); // growth
set('10🔮 5✨ 10💎 20🗡️', <astralsorcery:itemcoloredlens:3>); // damage (emotional)
set('10🔮 5✨ 10💎 20❤️', <astralsorcery:itemcoloredlens:4>); // regeneration
set('10🔮 5✨ 10💎 20🏃', <astralsorcery:itemcoloredlens:5>); // push
set('10🔮 5✨ 10💎 20👻', <astralsorcery:itemcoloredlens:6>); // spectral

set('20🔮', <astralsorcery:itemshiftingstar:*>); // shifting star

set('5🔮 10⟁ 20💎', <astralsorcery:itemrockcrystalsimple>); // rock crystal
set('5🔮 50⟁ 50💎 5⛰️', <astralsorcery:blockcustomore>); // rock crystal ore
set('20🔮 10⟁ 20💎 10🌑', <astralsorcery:itemcelestialcrystal>); // celestial crystal
set('50🔮 50⟁ 100💎 50🌑', <astralsorcery:blockcelestialcrystals:4>); // celestial crystal cluster
set('20🔮 10⟁ 20💎 10🦉', <astralsorcery:itemperkgem>); // orium gem (blue)
set('50🔮 50⟁ 100💎 50🦉', <astralsorcery:blockgemcrystals:2>); // ^that ore
set('20🔮 10⟁ 20💎 10🕯️', <astralsorcery:itemperkgem:1>); // ilium gem (orange)
set('50🔮 50⟁ 100💎 50🕯️', <astralsorcery:blockgemcrystals:3>); // ^that ore
set('20🔮 10⟁ 20💎 10💪', <astralsorcery:itemperkgem:2>); // fengarum gem (white)
set('50🔮 50⟁ 100💎 50💪', <astralsorcery:blockgemcrystals:4>); // ^that ore
set('30🔮 50⟁ 40💎', <astralsorcery:blockcollectorcrystal>); // collector crystal
set('100🔮 100⟁ 200💎 100🌑', <astralsorcery:blockcelestialcollectorcrystal>); // celestial collector crystal

set('5🔮 10🔨 5⟁', <astralsorcery:blockaltar>); // Altar T1
set('10🔮 20🔨 20⟁', <astralsorcery:blockaltar:1>); // T2
set('50🔮 30🔨 50⟁', <astralsorcery:blockaltar:2>); // T3
set('100🔮 40🔨 100⟁ 50🩸', <astralsorcery:blockaltar:3>); // T4

set('5🕯️ 5⟁ 10💎', <astralsorcery:blockworldilluminator>); // Cave illuminator
set('10🔮 5✨ 5🔄', <astralsorcery:blockattunementrelay>); // spectral realy
set('10🔮 10✨ 5⟁ 20💎', <astralsorcery:blocklens>); // Lens
set('5⛰️ 5🔨 5⚙️', <astralsorcery:blockmachine:1>); // grindstone
set('5🔮 20🧠 10⟁', <astralsorcery:itemconstellationpaper>); // constelation paper
set('5🔮 20🧠 10⟁', <astralsorcery:itemknowledgeshare>); // scroll of written knowledge
set('20🔮 30💎 30⟁', <astralsorcery:blockprism>); // primslens
set('5🔮 10💧 5⟁', <astralsorcery:blockwell>); // lightwell
set('20🔮 20✊ 20⟁', <astralsorcery:blockbore>); // evershifting fountain
set('10🔮 20✊ 15⟁', <astralsorcery:blockborehead>); // neromantic prime
set('10🔮 20✊ 15🌑', <astralsorcery:blockborehead:1>); // fysallidic prime
set('5🔮 10💎 5⟁', <astralsorcery:blockrituallink>); // ritual anchor

set('5🔮 10🦉 5✊', <astralsorcery:itemsextant>); // sextant
set('10🔮 20🦉 10✊', <astralsorcery:itemhandtelescope>); // looking glass
set('5🔮 10🦉 20✊', <astralsorcery:blockmachine>); // telescope
set('50🔮 50🦉 30👁️ 20🌑', <astralsorcery:blockobservatory>); // observatory

set('10🔮 20👽 50🏃', <astralsorcery:blockcelestialgateway>); // celestial gateway
set('10🔮 20🔄 20⟁', <astralsorcery:blockstarlightinfuser>); // starlight infuser
set('10🔮 10⟁ 20✊', <astralsorcery:blockattunementaltar>); // attument altar
set('20🔮 10🦉 20✊ 10🙌', <astralsorcery:blockmapdrawingtable>); // stellar refraction table
set('10🔮 10🌑 20✊', <astralsorcery:blockchalice>); // containment chalice
set('10🔮 10⟁ 20✊', <astralsorcery:blockritualpedestal>); // ritual pedestal

set('5🔮 10🛠️ 10💎', <astralsorcery:itemlinkingtool>); // linking tool
set('5🔮 10🛠️ 10💎', <astralsorcery:itemwand>); // resonating wand
set('10🔮 20🕯️ 20💎', <astralsorcery:itemilluminationwand>); // illumination wand
set('20🔮 10✨ 20💎 20⟁', <astralsorcery:iteminfusedglass>); // infused glass
set('10🦉 5⟁ 10✊', <astralsorcery:itemskyresonator>); // fosic resonator
set('10🔮 10🌑 20💪', <astralsorcery:itemperkseal>); // sealing sigil

set('30🔮 10🌑 10💎', <astralsorcery:itemenchantmentamulet>); // resplendent prism

/*
#######################################################
___  _    ____ ____ ___  _  _ ____ ____ _ ____
|__] |    |  | |  | |  \ |\/| |__| | __ | |
|__] |___ |__| |__| |__/ |  | |  | |__] | |___

#######################################################
*/

set('5⛰️ 5🩸', <bloodmagic:slate>); // slate blank
set('5⛰️ 15🩸', <bloodmagic:slate:1>); // slate reinforced
set('5⛰️ 30🩸', <bloodmagic:slate:2>); // slate imbued
set('5⛰️ 66🩸', <bloodmagic:slate:3>); // slate demonic
set('5⛰️ 100🩸', <bloodmagic:slate:4>); // slate ethernal

set('10⚰️ 10💀 10🩸', <bloodmagic:blood_shard>); // weak blood shard
set('30☀️ 50🧨 20🩸', <bloodmagic:blood_shard:1>); // demon blood shard

set('10🔮 20✊ 20🩸', <bloodmagic:activation_crystal>); // weak activation crystal
set('40🔮 30✊ 50🩸', <bloodmagic:activation_crystal:1>); // awekaned activation crystal

set('40👻', <bloodmagic:blood_orb:*>); // soulbinded orbs
set('10🔮 10✊ 10🩸', <bloodmagic:blood_orb>.withTag({orb: 'bloodmagic:weak'})); // orb tier 1
set('20🔮 10❤️ 25🩸', <bloodmagic:blood_orb>.withTag({orb: 'bloodmagic:apprentice'})); // orb tier 2
set('30🔮 50🔩 50🩸', <bloodmagic:blood_orb>.withTag({orb: 'bloodmagic:magician'})); // orb tier 3
set('40🔮 20⚰️ 80🩸', <bloodmagic:blood_orb>.withTag({orb: 'bloodmagic:master'})); // orb tier 4
set('50🔮 100⟁ 100🩸', <bloodmagic:blood_orb>.withTag({orb: 'bloodmagic:archmage'})); // orb tier 5
set('100🔮 100☀️ 300🩸', <bloodmagic:blood_orb>.withTag({orb: 'bloodmagic:transcendent'})); // orb tier 6

set('3🔗 3🙌 🍃', <bloodmagic:soul_snare>); // rudimentary snare
set('10💪 10🔥 5💣', <bloodmagic:arcane_ashes:*>); // arcane ashes

set('20🛠️ 30👻 15🔮', <bloodmagic:soul_forge>); // rudimentary snare
set('30🧨 20👻 20✊', <bloodmagic:demon_pylon>); // rudimentary snare
set('30🧨 20👻 15♒', <bloodmagic:demon_crucible>); // rudimentary snare
set('30🧨 20👻 15♒', <bloodmagic:demon_crystallizer>); // rudimentary snare
set('25⚗️ 20⟁ 20🔮', <bloodmagic:alchemy_table>); // rudimentary snare
set('15⛰️ 10🔮 30🗡️', <bloodmagic:altar>); // rudimentary snare

set('2👻 2🧨', <bloodmagic:monster_soul>); // demonic will
set('2👻 2🧨 ⚗️', <bloodmagic:monster_soul:1>); // corrosive
set('2👻 2🧨 💣', <bloodmagic:monster_soul:2>); // destructive
set('2👻 2🧨 ⚰️', <bloodmagic:monster_soul:3>); // vengeful
set('2👻 2🧨 👽', <bloodmagic:monster_soul:4>); // steadfast

set('30👻 25🧨', <bloodmagic:item_demon_crystal>); // demonic will crystal
set('30👻 25🧨 20⚗️', <bloodmagic:item_demon_crystal:1>); // corrosive
set('30👻 25🧨 20💣', <bloodmagic:item_demon_crystal:2>); // destructive
set('30👻 25🧨 20⚰️', <bloodmagic:item_demon_crystal:3>); // vengeful
set('30👻 25🧨 20👽', <bloodmagic:item_demon_crystal:4>); // steadfast

set('20👻 30🗡️', <bloodmagic:sentient_sword>);
set('20👻 15🗡️ 15🍃', <bloodmagic:sentient_bow>);
set('20👻 20🛠️', <bloodmagic:sentient_axe>);
set('20👻 20🛠️', <bloodmagic:sentient_pickaxe>);
set('20👻 20🛠️', <bloodmagic:sentient_shovel>);

set('5👽 5🗡️ 10⚰️', <bloodmagic:sacrificial_dagger>);
set('15🩸 10🛠️ 10🗡️', <bloodmagic:dagger_of_sacrifice>);

set('5🔮 10💧', <bloodmagic:component:8>); // reagent binding
set('5🔮 5🩸 20💨', <bloodmagic:sigil_whirlwind>); // sigil wirldwind
set('5🔮 5⚗️ 10💪', <bloodmagic:component:29>); // simple power catalyst
set('5🔮 5⚗️ 10🦉', <bloodmagic:component:28>); // simple lengthening catalyst

// TIERED REAGENTS AND SIGILS
// Tier 1

set('5🔮 10💧', <bloodmagic:component>); // reagent water
set('5🔮 10🔥', <bloodmagic:component:1>); // reagent lava

set('5🔮 5🩸 10💧', <bloodmagic:sigil_water>); // sigil water
set('5🔮 5🩸 10🔥', <bloodmagic:sigil_lava>); // sigil lava
set('5🔮 5🩸 10🧠', <bloodmagic:sigil_divination>); // sigil divination

// Tier 2

set('10🔮 20🌱', <bloodmagic:component:5>); // reagent growth
set('10🔮 20🔮', <bloodmagic:component:31>); // reagent elasticy
set('10🔮 20🕊️', <bloodmagic:component:2>); // reagent air
set('10🔮 20🦉', <bloodmagic:component:7>); // reagent sight
set('10🔮 20💣', <bloodmagic:component:3>); // reagent mining
set('10🔮 20🧊', <bloodmagic:component:32>); // reagent frost
set('10🔮 20〇', <bloodmagic:component:4>); // reagent void

set('10🔮 15🩸 20🌱', <bloodmagic:sigil_green_grove>); // sigil growth
set('10🔮 15🩸 20🛡️', <bloodmagic:sigil_bounce>); // sigil elasticy
set('10🔮 15🩸 20🕊️', <bloodmagic:sigil_air>); // sigil air
set('10🔮 15🩸 20🦉', <bloodmagic:sigil_seer>); // sigil sight
set('10🔮 15🩸 20💣', <bloodmagic:sigil_fast_miner>); // sigil mining
set('10🔮 15🩸 20🧊', <bloodmagic:sigil_frost>); // sigil frost
set('10🔮 15🩸 20〇', <bloodmagic:sigil_void>); // sigil void

// Tier 3

set('15🔮 30🔩', <bloodmagic:component:12>); // reagent magnetism
set('15🔮 30🔗', <bloodmagic:component:27>); // reagent holding
set('15🔮 30🕯️', <bloodmagic:component:11>); // reagent blood lamp
set('15🔮 30🐺', <bloodmagic:component:30>); // reagent claw
set('15🔮 10💨 10🔥 10⛰️ 10💧', <bloodmagic:component:6>); // reagent elemental affinity

set('15🔮 30🩸 30🔩', <bloodmagic:sigil_magnetism>); // sigil magnetism
set('15🔮 30🩸 30🔗', <bloodmagic:sigil_holding>); // sigil holding
set('15🔮 30🩸 30〇', <bloodmagic:sigil_blood_light>); // sigil blood lamp
set('15🔮 30🩸 30🐺', <bloodmagic:sigil_claw>); // sigil claw
set('15🔮 30🩸 10💨 10🔥 10⛰️ 10💧', <bloodmagic:sigil_elemental_affinity>); // sigil elemental affinity

// Tier 4

set('20🔮 40🔄', <bloodmagic:component:18>); // reagent transposition
set('20🔮 40👽', <bloodmagic:component:17>); // reagent teleposition
set('20🔮 40⚡', <bloodmagic:component:9>); // reagent supression
set('20🔮 40👻', <bloodmagic:component:15>); // reagent phantom bridge
set('20🔮 40🍃', <bloodmagic:component:13>); // reagent haste
set('20🔮 40🌑', <bloodmagic:component:16>); // reagent severance
set('20🔮 40⟁', <bloodmagic:component:14>); // reagent compression

set('20🔮 60🩸 40🔄', <bloodmagic:sigil_transposition>); // sigil transposition
set('20🔮 60🩸 40👽', <bloodmagic:sigil_teleposition>); // sigil teleposiotion
set('20🔮 60🩸 40⚡', <bloodmagic:sigil_suppression>); // sigil supression
set('20🔮 60🩸 40👻', <bloodmagic:sigil_phantom_bridge>); // sigil phantom bridge
set('20🔮 60🩸 40🍃', <bloodmagic:sigil_haste>); // sigil haste
set('20🔮 60🩸 40🌑', <bloodmagic:sigil_ender_severance>); // sigil severance
set('20🔮 60🩸 40⟁', <bloodmagic:sigil_compression>); // sigil compression

/*
#######################################################
___  ____ ___ ____ _  _ _ ____
|__] |  |  |  |__| |\ | | |__|
|__] |__|  |  |  | | \| | |  |

#######################################################
*/

// Random
set('10🔩 5🔷', <botania:manaresource>); // manasteel
set('10👽 5🏃 10🔷', <botania:manaresource:1>); // manapearl
set('15💎 15✊ 10🔷', <botania:manaresource:2>); // manadiamond
set('20⛰️ 20🔮 10🔷 10🔩', <botania:manaresource:4>); // terrasteel
set('5👽 10🔩 5🔷', <botania:manaresource:7>); // elementium
set('20👽 5🦄 10🔷', <botania:manaresource:8>); // pixie dust
set('10👽 15💎 10🔷 15✊', <botania:manaresource:9>); // dragon gem
set('5🐺 2🔨 2🔷', <botania:manaresource:16>); // mana string
set('5💪 5🔷', <botania:manaresource:23>); // mana powder
set('10🛡️ 5🔷', <botania:manaresource:22>); // manaweave cloth
set('10🔷', <botania:manabottle:*>); // mana bottle
set('5💎 2🔷', <botania:managlass>); // mana glass
set('10🦉 20👁️ 6🔷', <botania:monocle>); // monocle
set('10👽 10⟁ 15🔷', <botania:blacklotus>); // monocle
set('20👽 20⟁ 50🔷', <botania:blacklotus:1>); // monocle
set('25☀️ 50⟁ 50👽', <botania:manaresource:5>); // gaia spirit
set('75☀️ 150⟁ 20🔷 10🔩', <botania:manaresource:14>); // gaia ingot
set('20💪 20🔄 15👽 15⚙️ 10🔷', <botania:manaresource:12>); // red string
set('67🔩 33🔷', <botania:storage>); // manasteel block
set('20❤️ 25🔷', <botania:manacookie>); // mana cookie
set('20🔩 10🔷 10👽 15〇', <botania:openbucket>);
set('10🔷 20🔨', <botania:runealtar>); // runic altar
set('10🔷 20🛠️ 20🙌', <botania:manatablet>); // mana tablet
set('10🔷 5⚙️ 30⛰️', <botania:distributor>);
set('15🔷 15🦉 30⛰️', <botania:foresteye>);
set('2🔷 20🌱 2👽', <botania:platform:0>);
set('3🔷 20🌱 5👽', <botania:platform:1>);
set('90💧 30🔷 30❤️ 50🔩', <botania:spawnerclaw>); // life infuser
set('7🔷 30🔩 22👽 23🌑 20🕯️', <botania:starfield>);
set('3🔷 201💪 20⚙️ 15⛰️ 9❤️', <botania:rfgenerator>);
set('50🔷 50🔩 20🔨 20🔄 20✨', <botania:terraplate>);
set('7🔷 20⛰️ 50🔩 10⚙️ 10🔄', <botania:pump>);
set('7🔷 7👽 15🔩 10⚙️ 11⛰️', <botania:sparkchanger>);
set('9🔷 9🔄 20💧 20💪 20💨', <botania:teruterubozu>);
set('15🔷 30🔩 18🌱 8🛠️ 9❤️', <botania:sextant>);
set('15🔷 20❤️ 10⛰️', <botania:enchantedsoil>);
set('20🔷 10🔄 20⛰️', <botania:manamirror:*>);

// Mana Lenses
set('30🔩 15🔷', <botania:lens>); // default
set('30🔩 15🔷 5👽 10🏃', <botania:lens:1>); // velocity
set('30🔩 15🔷 5👽 10💪', <botania:lens:2>); // potency
set('30🔩 15🔷 5👽 10💎', <botania:lens:3>); // resistance
set('30🔩 15🔷 5👽 10🛠️', <botania:lens:4>); // efficiency
set('30🔩 15🔷 5👽 10🛡️', <botania:lens:5>); // bounce
set('30🔩 15🔷 5👽 10⛰️', <botania:lens:6>); // gravity
set('30🔩 15🔷 5👽 10💣', <botania:lens:7>); // bore
set('30🔩 15🔷 5👽 10🗡️', <botania:lens:8>); // damaging
set('30🔩 15🔷 5👽 10👻', <botania:lens:9>); // phantom
set('30🔩 15🔷 5👽 10✊', <botania:lens:10>); // magnetizing
set('30🔩 15🔷 5👽 10⚡', <botania:lens:11>); // entropic
set('30🔩 15🔷 5👽 10🍃', <botania:lens:12>); // influence
set('30🔩 15🔷 5👽 10🔮', <botania:lens:13>); // weight
set('30🔩 15🔷 5👽 10🔨', <botania:lens:14>); // paintslinger
set('30🔩 15🔷 5👽 10🔥', <botania:lens:15>); // kindle
set('30🔩 15🔷 5👽 10⚙️', <botania:lens:16>); // force
set('30🔩 15🔷 5👽 10🕯️', <botania:lens:17>); // flash
set('30🔩 15🔷 15👽', <botania:lens:18>); // warp
set('30🔩 15🔷 5👽 10🙌', <botania:lens:19>); // redirective
set('30🔩 15🔷 5👽 10⚗️', <botania:lens:20>); // celebratory
set('30🔩 15🔷 5👽 10🔄', <botania:lens:21>); // flare
set('30🔩 15🔷 5👽 10🧠', <botania:lens:22>); // messenger
set('30🔩 15🔷 5👽 10🦉', <botania:lens:23>); // tripwire

// Runes
set('5⛰️ 25💨 5🔷', <botania:rune:3>); // rune air
set('30⛰️ 5🔷', <botania:rune:2>); // rune earth
set('5⛰️ 25🔥 5🔷', <botania:rune:1>); // rune fire
set('5⛰️ 25💧 5🔷', <botania:rune>); // rune water
set('5⛰️ 25🧊 10🔷', <botania:rune:7>); // rune winter
set('5⛰️ 25⚰️ 10🔷', <botania:rune:6>); // rune autumn
set('5⛰️ 25❤️ 10🔷', <botania:rune:5>); // rune summer
set('5⛰️ 25🌱 10🔷', <botania:rune:4>); // rune spring
set('5⛰️ 25✨ 15🔷', <botania:rune:8>); // rune of mana
set('5⛰️ 20✊ 30🦄 15🔷', <botania:rune:15>); // rune pride
set('5⛰️ 20✊ 30👻 15🔷', <botania:rune:14>); // rune envy
set('5⛰️ 20✊ 30🗡️ 15🔷', <botania:rune:13>); // rune wrath
set('5⛰️ 20✊ 30🙌 15🔷', <botania:rune:12>); // rune sloth
set('5⛰️ 20✊ 30👨 15🔷', <botania:rune:11>); // rune greed
set('5⛰️ 20✊ 30〇 15🔷', <botania:rune:10>); // rune gluttony
set('5⛰️ 20✊ 30♒ 15🔷', <botania:rune:9>); // rune lust

// Items/baubles
set('30🔷 30🔮 16🗡️ 12🔩', <botania:terrasword>); // terra sword
set('5🔷 3🔮 3🏃 30⛰️ 9❤️', <botania:tinyplanet>); // tiny planet
set('15🔷 40🛠️ 100👽 50☀️', <botania:laputashard:*>); // shard of laputa
set('30⛰️ 30💪 10🛡️', <botania:knockbackbelt>); // tectonic gridle
set('30⛰️ 30🏃 10🛡️', <botania:travelbelt>); // soujourner's sash
set('75☀️ 100🏃 50🛡️', <botania:supertravelbelt>);
set('10💣 50✊ 10🛠️ 50🔩', <botania:miningring>); // ring of the mantle
set('30💧 50✊ 10🛠️ 50🔩', <botania:waterring>); // ring of chordata
set('30🔷 150✊ 10🛠️ 50🔩', <botania:magnetring>); // ring of magnetization
set('10🔷 50✊ 10🛠️ 50🔩', <botania:pixiering>); // fairy ring
set('30☀️ 30🛡️ 20〇 20🕯️', <botania:holycloak>); // cloak of virtue
set('30☀️ 30🛡️ 20🔄 20👁️', <botania:balancecloak>); // cloak of balance
set('30☀️ 30🛡️ 20🗡️ 20🧨', <botania:unholycloak>); // cloak of sin
set('15🔷 5🦉', <botania:manainkwell:*>); // botania inkwell
set('5🔷 30⛰️ 5🔗', <botania:temperancestone>);
set('10🔷 30〇 50👽 25🌑', <botania:blackholetalisman>);

set('75☀️ 100🕊️ 150👽 50🍃', <botania:flighttiara>); // Flugel Tiara
set('75☀️ 100🕊️ 150👽 50⟁', <botania:flighttiara:1>); // Flugel Tiara (flugel)
set('75☀️ 100🕊️ 150👽 50⚡', <botania:flighttiara:2>); // Flugel Tiara (one winged angel)
set('75☀️ 100🕊️ 150👽 50🧊', <botania:flighttiara:3>); // Flugel Tiara (ice fairy)
set('75☀️ 100🕊️ 150👽 50🔥', <botania:flighttiara:4>); // Flugel Tiara (phoenix)
set('75☀️ 100🕊️ 150👽 50♒', <botania:flighttiara:5>); // Flugel Tiara (black snow princess)
set('75☀️ 100🕊️ 150👽 50🌑', <botania:flighttiara:6>); // Flugel Tiara (lord of the pit)
set('75☀️ 100🕊️ 150👽 50🕯️', <botania:flighttiara:7>); // Flugel Tiara (sylph)
set('75☀️ 100🕊️ 150👽 50🐺', <botania:flighttiara:8>); // Flugel Tiara (chicken)

set('30🔷 30👽 25✊', <botania:dice:*>);
set('50❤️ 30🌱 15👽 30🔷 25✊', <botania:infinitefruit:*>);
set('50🗡️ 30🔗 15👽 30🔷 25✊', <botania:kingkey:*>);
set('50🏃 30🕊️ 15👽 30🔷 25✊', <botania:flugeleye:*>);
set('50🛡️ 30❤️ 15👽 30🔷 25✊', <botania:odinring:*>);
set('50🛠️ 30⚡ 15👽 30🔷 25✊', <botania:thorring:*>);
set('50✨ 30👨 15👽 30🔷 25✊', <botania:lokiring:*>);

set('30🔷 20🛠️ 50👽 30🔄', <botania:rainbowrod>); // rod of bifrost
set('10🔷 20✊ 20🦉 10🛠️', <botania:diviningrod>);
set('5🔷 20💨 10♒', <botania:tornadorod>);
set('40🔷 40🛠️ 120⛰️ 40🔄', <botania:terraformrod>);
set('5🔷 10🛠️ 20⛰️', <botania:dirtrod>);
set('10🔷 20🛠️ 20👽 20🔗', <botania:gravityrod>);
set('25🔷 30🗡️ 40👽', <botania:missilerod>);
set('10🔷 10🛠️ 30⛰️ 5⚡', <botania:cobblerod>);
set('10🔷 20🛠️ 30🔄 30🙌', <botania:exchangerod>);

// Generating flora
set('20🌱 10🔥 10💨', <botania:specialflower>.withTag({type: 'endoflame'}));
set('20🌱 10〇 10🔨', <botania:specialflower>.withTag({type: 'kekimurus'}));
set('20🌱 10❤️ 10💧', <botania:specialflower>.withTag({type: 'narslimmus'}));
set('20🌱 10⚗️ 10💣', <botania:specialflower>.withTag({type: 'entropinnyum'}));
set('20🌱 10🔨 10⟁', <botania:specialflower>.withTag({type: 'spectrolus'}));
set('100🌱 100🧠 25☀️', <botania:specialflower>.withTag({type: 'dandelifeon'}));
set('20🌱 10💀 10⚡', <botania:specialflower>.withTag({type: 'rafflowsia'}));
set('20🌱 10🧠 10👨', <botania:specialflower>.withTag({type: 'arcanerose'}));
set('20🌱 10〇 10⛰️', <botania:specialflower>.withTag({type: 'munchdew'}));
set('20🌱 10💧 10🦉', <botania:specialflower>.withTag({type: 'hydroangeas'}));
set('20🌱 10〇 10🐺', <botania:specialflower>.withTag({type: 'gourmaryllis'}));
set('20🌱 10👽 10⚰️', <botania:specialflower>.withTag({type: 'shulk_me_not'}));
set('20🌱 10🔥 10⛰️', <botania:specialflower>.withTag({type: 'thermalily'}));

// Functional flora
set('50🌱 50✊ 30⛰️', <botania:specialflower>.withTag({type: 'orechid'}));
set('50🌱 50✊ 30🧨', <botania:specialflower>.withTag({type: 'orechidIgnem'}));
set('50🌱 50✊ 30👽', <botania:specialflower>.withTag({type: 'orechidVacuam'}));
set('50🌱 50✊ 30⛰️', <botania:specialflower>.withTag({type: 'excompressum.orechidEvolved'}));
set('20🌱 10⟁ 10🔄', <botania:specialflower>.withTag({type: 'puredaisy'}));
set('20🌱 10🦉 10🔮', <botania:specialflower>.withTag({type: 'manastar'}));
set('20🌱 10⚗️ 10💧', <botania:specialflower>.withTag({type: 'petro_petunia'}));

set('20🌱 10🔥 10🔨', <botania:specialflower>.withTag({type: 'exoflame'}));
set('20🌱 10⚰️ 10👁️', <botania:specialflower>.withTag({type: 'dreadthorn'}));
set('20🌱 10〇 10✊', <botania:specialflower>.withTag({type: 'hopperhock'}));
set('20🌱 10❤️ 10🔮', <botania:specialflower>.withTag({type: 'jadedAmaranthus'}));
set('20🌱 10🛡️ 10💪', <botania:specialflower>.withTag({type: 'jiyuulia'}));
set('20🌱 10🗡️ 10⚰️', <botania:specialflower>.withTag({type: 'bellethorn'}));
set('20🌱 10⟁ 10❤️', <botania:specialflower>.withTag({type: 'agricarnation'}));
set('20🌱 10🔄 10💧', <botania:specialflower>.withTag({type: 'clayconia'}));
set('20🌱 10🏃 10🍃', <botania:specialflower>.withTag({type: 'daffomill'}));
set('20🌱 10⚰️ 10💧', <botania:specialflower>.withTag({type: 'hyacidus'}));
set('20🌱 10🧊 10♒', <botania:specialflower>.withTag({type: 'medumone'}));
set('20🌱 10🐺 10❤️', <botania:specialflower>.withTag({type: 'pollidisiac'}));
set('20🌱 10👽 10🔗', <botania:specialflower>.withTag({type: 'vinculotus'}));
set('20🌱 10✨ 10❤️', <botania:specialflower>.withTag({type: 'fallenKanade'}));
set('20🌱 10〇 10🛎️', <botania:specialflower>.withTag({type: 'bergamute'}));
set('20🌱 10✨ 10💧', <botania:specialflower>.withTag({type: 'bubbell'}));
set('20🌱 10🗡️ 10🙌', <botania:specialflower>.withTag({type: 'heiseiDream'}));
set('20🌱 10🔄 10💎', <botania:specialflower>.withTag({type: 'marimorphosis'}));
set('20🌱 10✊ 10⟁', <botania:specialflower>.withTag({type: 'rannuncarpus'}));
set('20🌱 10👽 10🏃', <botania:specialflower>.withTag({type: 'spectranthemum'}));
set('20🌱 10✊ 10🔗', <botania:specialflower>.withTag({type: 'tangleberrie'}));
set('20🌱 10💣 10🐺', <botania:specialflower>.withTag({type: 'tigerseye'}));
set('20🌱 10✊ 10⚡', <botania:specialflower>.withTag({type: 'solegnolia'}));
set('20🌱 10✊ 10🦄', <botania:specialflower>.withTag({type: 'loonium'}));

/*
#######################################################
____ _  _ _ ____ ____ _    _      / ____ _  _ ____ ____ _  _          ____ ____ _  _ ____ ____ ____ _       ____ ___ ____ _  _ ____ ____
|    |__| | [__  |___ |    |     /  |  | |  | |__| |__/ |_/     __    | __ |___ |\ | |___ |__/ |__| |       [__   |  |  | |\ | |___ [__
|___ |  | | ___] |___ |___ |___ /   |_\| |__| |  | |  \ | \_          |__] |___ | \| |___ |  \ |  | |___    ___]  |  |__| | \| |___ ___]

#######################################################
*/

set('4⛰️ 2🌑', <chisel:basalt2:7>); // basalt
set('4⛰️ 2⟁', <chisel:marble2:7>); // marble
set('4⛰️ 2🔥', <quark:jasper>); // jasper

set('4⚡ 2🌑', <quark:black_ash>); // wither ash

set('5🌱', <quark:root>);
set('3🌱 2🛠️', <quark:root_flower>);
set('3🌱 2🌑', <quark:root_flower:1>);
set('3🌱 2💪', <quark:root_flower:2>);

/*
#######################################################
___  ____ ____ ___     _  _ ____ ___     _    ____ ____ ____ _  _ _ _  _ ____
|  \ |___ |___ |__]    |\/| |  | |__]    |    |___ |__| |__/ |\ | | |\ | | __
|__/ |___ |___ |       |  | |__| |__]    |___ |___ |  | |  \ | \| | | \| |__]

#######################################################
*/

set('10💣 20⚙️ 10☀️ 20🙌', <deepmoblearning:glitch_fragment>);
set('10🔩 20⚙️ 10☀️ 20🙌', <deepmoblearning:glitch_infused_ingot>);
set('30❤️ 20⚙️ 10☀️ 20🙌', <deepmoblearning:glitch_heart>);

set('10🔩 20⚙️ 10☀️ 20🙌 15🩸', <deepmoblearningbm:blood_infused_glitch_ingot>);

set('20⚙️ 30⛰️ 30❤️ 30🐺', <deepmoblearning:living_matter_overworldian>);
set('20⚙️ 30🧨 30⚰️ 30🔥', <deepmoblearning:living_matter_hellish>);
set('20⚙️ 30👽 30〇 30🌑', <deepmoblearning:living_matter_extraterrestrial>);
set('20⚙️ 30🦄 30🌱 10✨', <deepmoblearning:living_matter_twilight>);

set('10⚙️ 10🔗 30💀 30⚰️ 60👨', <deepmoblearning:pristine_matter_zombie>);
set('10⚙️ 10🔗 30🐺 30🔗 30🦉', <deepmoblearning:pristine_matter_spider>);
set('10⚙️ 10🔗 30⚰️ 30⚡ 60🗡️', <deepmoblearning:pristine_matter_skeleton>);
set('10⚙️ 10🔗 30💣 30🔥 15⚗️ 30⚡', <deepmoblearning:pristine_matter_creeper>);
set('10⚙️ 10🔗 30💧 30❤️', <deepmoblearning:pristine_matter_slime>);
set('10⚙️ 10🔗 60👨 30🔮 30⚗️', <deepmoblearning:pristine_matter_witch>);
set('10⚙️ 10🔗 60💧 30🛡️ 30🦉', <deepmoblearning:pristine_matter_guardian>);
set('10⚙️ 10🔗 60💧 30❤️ 15🔨', <deepmoblearning:pristine_matter_tinker_slime>);

set('10⚙️ 10🔗 60🔥 60🧨', <deepmoblearning:pristine_matter_blaze>);
set('10⚙️ 10🔗 60⚰️ 60⚡ 60🗡️ 60👻', <deepmoblearning:pristine_matter_wither_skeleton>);
set('10⚙️ 10🔗 60👻 30🕊️ 60♒', <deepmoblearning:pristine_matter_ghast>);
set('10⚙️ 10🔗 50☀️ 50👽 50⟁', <deepmoblearning:pristine_matter_wither>);

set('10⚙️ 10🔗 80👽 60🌑', <deepmoblearning:pristine_matter_enderman>);
set('10⚙️ 10🔗 50👽 30🕊️ 30🛎️', <deepmoblearning:pristine_matter_shulker>);
set('10⚙️ 10🔗 50🐲 50👽 20⚗️', <deepmoblearning:pristine_matter_dragon>);

set('10⚙️ 10🔗 10🦄 50⛰️ 30👻', <deepmoblearning:pristine_matter_twilight_forest>);
set('10⚙️ 10🔗 10🦄 50🌱 30🍇', <deepmoblearning:pristine_matter_twilight_swamp>);
set('10⚙️ 10🔗 10🦄 50🧊 30💎', <deepmoblearning:pristine_matter_twilight_glacier>);

set('10⚙️ 10🔗 20💧 20🔥 20⛰️ 20💨', <deepmoblearning:pristine_matter_thermal_elemental>);

/*
#######################################################
___  ____ ____ ____ ____ _  _ _ ____    ____ _  _ ____ _    _  _ ___ _ ____ _  _
|  \ |__/ |__| |    |  | |\ | | |       |___ |  | |  | |    |  |  |  | |  | |\ |
|__/ |  \ |  | |___ |__| | \| | |___    |___  \/  |__| |___ |__|  |  | |__| | \|

#######################################################
*/

set('100🐲 50🔮 30👻 100❤️', <draconicevolution:dragon_heart>); // dragon heart

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

set('10🔩 5🧨', <extrautils2:ingredients:11>); // Demonic ingot
set('10🔩 5🧠', <extrautils2:ingredients:12>); // Enchanted ingot
set('25ඞ', <extrautils2:fakecopy:*>); // Fake Item

/*
#######################################################
____ ____ ____ ____ ____ ___ ____ _   _
|___ |  | |__/ |___ [__   |  |__/  \_/
|    |__| |  \ |___ ___]  |  |  \   |

#######################################################
*/

set('20🕯️ 5🌱 5💨', <forestry:candle>);
set('20🕯️ 5🌱 5💨', <forestry:stump>);
set('5🕯️ 2💨', <forestry:beeswax>);

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

// General

set('20🧠', <iceandfire:manuscript>); // manuscript
set('10⚰️ 10🧨 5🌑 5⚡', <iceandfire:witherbone>); // wither bone
set('5🦄 6🗡️ 5⚗️', <iceandfire:myrmex_stinger>);

// Dragons general

set('5🐲 2🔮 5⚰️', <iceandfire:dragonbone>); // dragon bone
set('20❤️ 10🐺 20⚰️', <iceandfire:dragon_meal>); // dragon meal

// Fire
set('100🐲 50🔮 30👻 100❤️ 50🔥', <iceandfire:fire_dragon_heart>); // heart
set('10🐲 10❤️ 20⚰️ 20🔥', <iceandfire:fire_dragon_flesh>); // flesh
set('5🐲 10🔮 10⚗️ 10🔥', <iceandfire:fire_dragon_blood>); // blood
set('25🐲 10👻 10⚰️ 30🔥', <iceandfire:dragon_skull>); // skull
set('5🐲 7🛡️ 10🧨 10🔥', <iceandfire:dragonscales_red>); // scales red
set('5🐲 7🛡️ 10✊ 10🔥', <iceandfire:dragonscales_bronze>); // scales bronze
set('5🐲 7🛡️ 10👁️ 10🔥', <iceandfire:dragonscales_green>); // scales green
set('5🐲 7🛡️ 10💣 10🔥', <iceandfire:dragonscales_gray>); // scales gray
set('100🐲 10🔮 10🧨 10🔥', <iceandfire:dragonegg_red>); // egg red
set('100🐲 10🔮 10✊ 10🔥', <iceandfire:dragonegg_bronze>); // egg bronze
set('100🐲 10🔮 10👁️ 10🔥', <iceandfire:dragonegg_green>); // egg green
set('100🐲 10🔮 10💣 10🔥', <iceandfire:dragonegg_gray>); // egg gray
set('25🐲 20🔩 40✊ 50🔥', <iceandfire:dragonsteel_fire_ingot>); // dragonsteel ingot
set('5🐲 2🔮 5🌱 5🔥', <iceandfire:fire_lily>); // lily
set('5🐲 5🔮 20🔥', <iceandfire:fire_stew>); // lily mixture

// Ice
set('100🐲 50🔮 30👻 100❤️ 50🧊', <iceandfire:ice_dragon_heart>); // heart
set('10🐲 10❤️ 20⚰️ 20🧊', <iceandfire:ice_dragon_flesh>); // flesh
set('5🐲 10🔮 10⚗️ 10🧊', <iceandfire:ice_dragon_blood>); // blood
set('25🐲 10👻 10⚰️ 30🧊', <iceandfire:dragon_skull:1>); // skull
set('5🐲 15🛡️ 10🛠️ 10🧊', <iceandfire:dragonscales_sapphire>); // scales sapphire
set('5🐲 15🛡️ 10💎 10🧊', <iceandfire:dragonscales_blue>); // scales blue
set('5🐲 15🛡️ 10🕊️ 10🧊', <iceandfire:dragonscales_white>); // scales white
set('5🐲 15🛡️ 10♒ 10🧊', <iceandfire:dragonscales_silver>); // scales silver
set('100🐲 10🔮 10🛠️ 10🧊', <iceandfire:dragonegg_sapphire>); // egg sapphire
set('100🐲 10🔮 10💎 10🧊', <iceandfire:dragonegg_blue>); // egg blue
set('100🐲 10🔮 10🕊️ 10🧊', <iceandfire:dragonegg_white>); // egg white
set('100🐲 10🔮 10♒ 10🧊', <iceandfire:dragonegg_silver>); // egg silver
set('25🐲 20🔩 40✊ 50🧊', <iceandfire:dragonsteel_ice_ingot>); // dragonsteel ingot
set('5🐲 2🔮 5🌱 5🧊', <iceandfire:frost_lily>); // lily
set('5🐲 5🔮 20🧊', <iceandfire:frost_stew>); // lily mixture

// Ocean creatures
set('5🐲 10🗡️ 10💧 5🦄', <iceandfire:sea_serpent_fang>); // fang
set('5🐲 10🛡️ 10💧 5⚗️ 10🦄', <iceandfire:sea_serpent_scales_teal>); // scale teal
set('5🐲 10🛡️ 10💧 5🛠️ 10🦄', <iceandfire:sea_serpent_scales_deepblue>); // scale deepblue
set('5🐲 10🛡️ 10💧 5🛎️ 10🦄', <iceandfire:sea_serpent_scales_bronze>); // scale bronze
set('5🐲 10🛡️ 10💧 5💎 10🦄', <iceandfire:sea_serpent_scales_blue>); // scale blue
set('5🐲 10🛡️ 10💧 5👁️ 10🦄', <iceandfire:sea_serpent_scales_green>); // scale green
set('5🐲 10🛡️ 10💧 5🔮 10🦄', <iceandfire:sea_serpent_scales_purple>); // scale purple
set('5🐲 10🛡️ 10💧 5❤️ 10🦄', <iceandfire:sea_serpent_scales_red>); // scale red
set('10🐲 20👻 20💧 50🦄', <iceandfire:seaserpent_skull>); // skull

set('20✊ 5🛡️ 10💧 2🦄', <iceandfire:shiny_scales>); // shiny scales
set('100🛎️ 50🙌 50💧 50🦄', <iceandfire:siren_tear>); // siren
set('100🏃 50🦄 50💧', <iceandfire:hippocampus_fin>); // hippocampus

// Beach creatures

set('50🦄 50⚰️ 40💀 50👨', <iceandfire:gorgon_head>); // gorgon

set('20🦄 30👁️ 20⚰️ 50🐺', <iceandfire:cyclops_eye>); // cyclop
set('30🦄 20👻 20💪 50⛰️', <iceandfire:cyclops_skull>);

// Underground

set('20🦄 20👻 20🌑 30⛰️', <iceandfire:troll_skull>); // troll skull
set('10🦄 10🛡️ 10🌑 15🧊', <iceandfire:troll_leather_frost>); // leather frost
set('10🦄 10🛡️ 10🌑 15⛰️', <iceandfire:troll_leather_mountain>); // leather mountain
set('10🦄 10🛡️ 10🌑 15🌱', <iceandfire:troll_leather_forest>); // leather forest
set('10🦄 20🗡️ 10🌑 10🔮', <iceandfire:troll_weapon.trunk_frost>); // troll weapons
set('10🦄 20🗡️ 10🌑 10🔮', <iceandfire:troll_weapon.hammer>);
set('10🦄 20🗡️ 10🌑 10🔮', <iceandfire:troll_weapon.column_forest>);
set('10🦄 20🗡️ 10🌑 10🔮', <iceandfire:troll_weapon.column_frost>);
set('10🦄 20🗡️ 10🌑 10🔮', <iceandfire:troll_weapon.trunk>);
set('10🦄 20🗡️ 10🌑 10🔮', <iceandfire:troll_weapon.axe>);
set('10🦄 20🗡️ 10🌑 10🔮', <iceandfire:troll_weapon.column>);

// Swamp

set('50🦄 20👻 50⚗️ 50❤️', <iceandfire:hydra_skull>); // hydra
set('10🦄 10🗡️ 10⚗️', <iceandfire:hydra_fang>);
set('50🦄 30🔮 50⚗️ 200❤️', <iceandfire:hydra_heart>);

set('15🦄 20👻 40🕊️ 40🍃', <iceandfire:stymphalian_skull>); // ironbird
set('5🦄 5💨 5🕊️ 5🍃', <iceandfire:stymphalian_bird_feather>);

// Jungle

set('5🦄 5💨 5🕊️ 20✊', <iceandfire:amphithere_feather>); // amphithere
set('30🦄 20👻 20💨 20🕊️', <iceandfire:amphithere_skull>);

set('5🦄 5🛡️ 5🌱', <iceandfire:myrmex_jungle_chitin>); // jungle myrmex
set('5🦄 5🔄 5🌱', <iceandfire:myrmex_jungle_resin>);
set('20🦄 10❤️ 5🌱', <iceandfire:myrmex_jungle_egg:*>);

// Desert
set('5🦄 5🛡️ 5🐺', <iceandfire:deathworm_chitin:*>); // deathworm
set('10🦄 20❤️ 20🐺', <iceandfire:iceandfire.deathworm_egg:*>);
set('20🦄 50🔗 50🐺', <iceandfire:deathworm_tounge>);

set('5🦄 5🛡️ 5🔥', <iceandfire:myrmex_desert_chitin>); // desert myrmex
set('5🦄 5🔄 5🔥', <iceandfire:myrmex_desert_resin>);
set('20🦄 10❤️ 5🔥', <iceandfire:myrmex_desert_egg:*>);

set('10🦄 20👻 10🏃 20⚡', <iceandfire:cockatrice_skull>); // cockatrice
set('20🦄 20⚰️ 10🏃 50⚡', <iceandfire:cockatrice_eye>);

// Forest/plains

set('20🦄 20👻 20🍃 40❤️', <iceandfire:hippogryph_skull>);
set('20🦄 40❤️ 40🍃', <iceandfire:hippogryph_egg:*>);

set('2🦄 30🔮 20👨 5✊', <iceandfire:pixie_dust>);
set('2🦄 40🔮 20❤️ 20✊', <iceandfire:ambrosia>);
set('20🦄 50🔮 20👨 50✊', <iceandfire:jar_pixie:*>);
set('20🦄 50🔮 20🙌 50✊', <iceandfire:pixie_wings>);
set('20🌱 5✨', <iceandfire:pixie_house:*>);

// Ice

set('10💀 10⚡ 20👻', <iceandfire:dread_shard>);

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

set('10🔩 5⚡', <mechanics:heavy_ingot>); // heavy ingot

/*
#######################################################
_  _ ____ _  _ ____ _  _ _ ____ _  _
|\/| |___ |_/  |__| |\ | | [__  |\/|
|  | |___ | \_ |  | | \| | ___] |  |

#######################################################
*/

set('10🔩 5🌑 10⛰️', <mekanism:ingot>); // Refined obsidian ingot
set('🔩 ⛰️', <mekanism:nugget>); // Refined obsidian nugget
set('67🔩 33🌑 67⛰️', <mekanism:basicblock:2>); // Refined obsidian block
set('10🔩 5🌑 10⛰️ 5⚡', <mekanism:otherdust:5>); // Refined obsidian dust

set('10🔩 10🕯️ 5🦉', <mekanism:ingot:3>); // Refined glowstone ingot
set('🔩 🦉', <mekanism:nugget:3>); // Refined glowstone nugget
set('67🔩 67🕯️ 33🦉', <mekanism:basicblock:4>); // Refined glowstone block

/*
#######################################################
___  _    _  _ ____ ___ _ ____
|__] |    |  | [__   |  | |
|    |___ |__| ___]  |  | |___

#######################################################
*/

set('10🔩 10🔷 10✨', <plustic:mirioningot>);
set('🔩 🔷 ✨', <plustic:mirionnugget>);
set('67🔩 67🔷 67✨', <plustic:mirionblock>);
set('10🔩 10👁️', <plustic:osgloglasingot>);
set('🔩 👁️', <plustic:osgloglasnugget>);
set('67🔩 67👁️', <plustic:osgloglasblock>);
set('10🔩 5🛎️', <plustic:alumiteingot>);
set('🔩 🛎️', <plustic:alumitenugget>);
set('67🔩 67🛎️', <plustic:alumiteblock>);
set('10🔩 5🕊️', <plustic:osmiridiumingot>);
set('🔩 🕊️', <plustic:osmiridiumnugget>);
set('67🔩 67🕊️', <plustic:osmiridiumblock>);

/*
#######################################################
___  ____ _
|__] [__  |
|    ___] |

#######################################################
*/

set('10💪 5👽 5💪', <psi:material>); // Psi dust
set('10🔩 5👽 5💪', <psi:material:1>); // Psi ingot
set('10💎 5👽 5💪', <psi:material:2>); // Psi gem

/*
#######################################################
____ ____ _  _ ___  ____ _  _    ___ _  _ _ _  _ ____ ____
|__/ |__| |\ | |  \ |  | |\/|     |  |__| | |\ | | __ [__
|  \ |  | | \| |__/ |__| |  |     |  |  | | | \| |__] ___]

#######################################################
*/

set('10👻', <randomthings:ingredient:2>); // Ectoplasm

/*
#######################################################
____ ____ ___ ____
|__/ |__|  |  [__
|  \ |  |  |  ___]

#######################################################
*/

set('10🐀 5⟁', <rats:rat_sack>);
set('10🐀 4🛡️ 2🔮', <rats:piper_hat>);
set('10🐀 10🔮 10🔨', <rats:rat_flute>);
set('10🐀 5⚰️', <rats:plague_essence>);
set('5🐀 5🛡️', <rats:rat_pelt>);
set('5🐀 5❤️', <rats:raw_rat>);
set('10🐀 10🔨', <rats:cheese_stick>);
set('10🐀 10⚡ 10⚰️', <rats:radius_stick>);
set('5🐀 5🔨 5❤️', <rats:string_cheese>);
set('5🐀 5🌱 5🕯️', <rats:jack_o_ratern>);
set('🌱', <rats:rat_lantern>);
set('5🐀 5⛰️', <rats:marbled_cheese_raw>);
// set('10🐀', <rats:feral_bagh_nakhs>);
set('25🐀 5⚰️', <rats:feral_rat_claw>);
set('10🐀 15💎 10✊', <rats:gem_of_ratlantis>);
set('50🐀 15⚙️ 10👽', <rats:arcane_technology>);
// set('10🐀', <rats:ancient_sawblade>);
set('5🐀 10👻 5👽', <rats:ratlantean_flame>);
set('100🐀 100🧠 100✊ 25👽 50⚗️', <rats:psionic_rat_brain>);
// set('10🐀', <rats:idol_of_ratlantis>);
set('5🐀 40🔗 5🔩 5🔨', <rats:rattrap>);
set('5🐀 50🔗 20🔩 15🔨', <rats:rat_cage>);
set('10💣 5⚗️ 10🔥 10⚡', <rats:charged_creeper_chunk>);
set('52🗡️ 15🐀', <rats:plague_scythe>);
// set('10🐀', <rats:rat_capture_net>);

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
for tube in tubes {
  set('🐀 5🏃', tube);
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
for igloo in igloos {
  set('30🔨 30👨 15⟁', igloo);
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

set('15🧊 5💎', <thermalfoundation:material:2048>); // Blizz rod
set('15⛰️ 5💣', <thermalfoundation:material:2052>); // Basalz rod
set('15💨 5🛎️', <thermalfoundation:material:2050>); // Blitz rod

/*
#######################################################
___ _ _  _ _  _ ____ ____ . ____    ____ ____ _  _ ____ ___ ____ _  _ ____ ___
 |  | |\ | |_/  |___ |__/ ' [__     |    |  | |\ | [__   |  |__/ |  | |     |
 |  | | \| | \_ |___ |  \   ___]    |___ |__| | \| ___]  |  |  \ |__| |___  |

#######################################################
*/

set('10⚰️ 10🧨 5🌑 5⚡', <tconstruct:materials:17>); // wither bone

set('10🔩 5🗡️', <tconstruct:ingots:2>); // Manyullyn ingot
set('🔩', <tconstruct:nuggets:2>); // Manyullyn nugget
set('67🔩 33🗡️', <tconstruct:metal:2>);// Manyullyn block
set('10🔩 5⚗️', <tconstruct:ingots:5>); // Alchemical brass ingot
set('🔩', <tconstruct:nuggets:5>); // Alchemical brass nugget
set('67🔩 33⚗️', <tconstruct:metal:5>);// Alchemical brass block
set('10🔩 5🐺', <tconstruct:ingots:4>); // Pigiron ingot
set('🔩', <tconstruct:nuggets:4>); // Pigiron ingot
set('67🔩 33🐺', <tconstruct:metal:4>);// Pigiron block

/*
#######################################################
___ _ _  _ _  _ ____ ____ . ____    ____ _  _ ____ _    _  _ ___ _ ____ _  _
 |  | |\ | |_/  |___ |__/ ' [__     |___ |  | |  | |    |  |  |  | |  | |\ |
 |  | | \| | \_ |___ |  \   ___]    |___  \/  |__| |___ |__|  |  | |__| | \|

#######################################################
*/

set('20🔩 10🩸', <tconevo:metal:25>); // Bound ingot
set('2🔩 🩸', <tconevo:metal:27>); // Bound nugget
set('133🔩 67🩸', <tconevo:metal_block:5>); // Bound block
set('20🔩 10👻', <tconevo:metal:30>); // Sentient ingot
set('2🔩 👻', <tconevo:metal:32>); // Sentient nugget
set('133🔩 67👻', <tconevo:metal_block:6>); // Sentient block
set('20🔩 10💪', <tconevo:metal:35>); // Energium ingot
set('2🔩 💪', <tconevo:metal:37>); // Energium nugget
set('133🔩 67💪', <tconevo:metal_block:7>); // Energium block
set('20🔩 10👨', <tconevo:metal:40>); // UU-metal ingot
set('2🔩 👨', <tconevo:metal:42>); // UU-metal nugget
set('133🔩 67👨', <tconevo:metal_block:8>); // UU-metal block
set('10🔩 5❤️', <tconevo:edible>); // Raw meat ingot
set('10🔩 5🐺', <tconevo:edible:1>); // Cooked meat ingot
set('20🔩 25💀', <tconevo:metal:15>); // Essence-Infused ingot
set('2🔩 2💀', <tconevo:metal:17>); // Essence-Infused nugget
set('133🔩 167💀', <tconevo:metal_block:3>);// Essence-Infused block
set('100🔩 50☀️', <tconevo:metal>); // Wyvern ingot
set('10🔩 5☀️', <tconevo:metal:2>); // Wyvern nugget
set('500🔩 333☀️', <tconevo:metal_block>);// Wyvern block
set('100🔩 50🐲', <tconevo:metal:5>); // Draconic ingot
set('10🔩 5🐲', <tconevo:metal:7>); // Draconic nugget
set('500🔩 333🐲', <tconevo:metal_block:1>);// Draconic block
set('100🔩 50🐀', <tconevo:metal:10>); // Chaotic ingot
set('10🔩 5🐀', <tconevo:metal:12>); // Chaotic nugget
set('500🔩 333🐀', <tconevo:metal_block:2>);// Chaotic block
set('20🔩 10💧 10🔥 10⛰️ 10⚡ 10⟁ 10💨', <tconevo:metal:20>); // Primordial ingot
set('2🔩 💧 🔥 ⛰️ ⚡ ⟁ 💨', <tconevo:metal:22>); // Primordial nugget
set('133🔩 67💧 67🔥 67⛰️ 67⚡ 67⟁ 167💨', <tconevo:metal_block:4>); // Primordial block

/*
#######################################################
___ _  _ ____ _  _ _  _ ____ ____ ____ ____ ___
 |  |__| |__| |  | |\/| |    |__/ |__| |___  |
 |  |  | |  | |__| |  | |___ |  \ |  | |     |

#######################################################
*/

set('2🔥 2💪', <thaumcraft:alumentum>);
set('10🍇', <thaumcraft:condenser_lattice_dirty>);
set('5🔩 2🛠️', <thaumcraft:ingot:2>);

set('⟁ ❤️', <thaumcraft:bath_salts>);
set('2⟁ 2❤️ 2🔷', <thaumcraft:sanity_soap>);
set('🔩', <thaumicaugmentation:bars>);

set('10🔩 5🔮', <thaumcraft:ingot>);
set('🔩', <thaumcraft:nugget:6>);
set('67🔩 33🔮', <thaumcraft:metal_thaumium>);
set('10🔩 5🔮 2🛠️', <thaumcraft:plate:2>);
set('10🔩 5🔮 20🌱', <mysticalagriculture:thaumium_seeds>);
set('10🔩 25🔮', <mysticalagriculture:thaumium_essence>);

set('10🔩 5🍇', <thaumcraft:ingot:1>);
set('🔩', <thaumcraft:nugget:7>);
set('67🔩 33🍇', <thaumcraft:metal_void>);
set('10🔩 5🍇 2🛠️', <thaumcraft:plate:3>);
set('10🔩 5🍇 20🌱', <mysticalagriculture:void_metal_seeds>);
set('10🔩 5🍇 20🔮', <mysticalagriculture:void_metal_essence>);

set('10🌑 15🔮 15⚗️', <thaumicwonders:alienist_stone>);
set('10🏃 15🔄 15⚗️', <thaumicwonders:transmuter_stone>);
set('10🔩 15⟁ 15⚗️', <thaumicwonders:alchemist_stone>);

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
  <thaumcraft:nitor_black>,
] as IItemStack[];
for nitor in nitor {
  set('2🕯️ 🦉', nitor);
}

/*
#######################################################
___ _ _ _ _ _    _ ____ _  _ ___    ____ ____ ____ ____ ____ ___
 |  | | | | |    | | __ |__|  |     |___ |  | |__/ |___ [__   |
 |  |_|_| | |___ | |__] |  |  |     |    |__| |  \ |___ ___]  |

#######################################################
*/

set('15🔩 40🔥 12✨ 20🌱', <mysticalagriculture:fiery_ingot_seeds>);
set('15🔩 40🔥 12✨ 20🔮', <mysticalagriculture:fiery_ingot_essence>);

set('10🔩 5🌱', <twilightforest:ironwood_ingot>);
set('10🔩 20🌱', <mysticalagriculture:ironwood_seeds>);
set('10🔩 5🌱 15🔮', <mysticalagriculture:ironwood_essence>);
set('10🔩 5🛡️', <twilightforest:knightmetal_ingot>);
set('5🔩 10🛡️', <twilightforest:armor_shard_cluster>);
set('10🔩 5🛡️ 20🌱', <mysticalagriculture:knightmetal_seeds>);
set('10🔩 5🛡️ 20🔮', <mysticalagriculture:knightmetal_essence>);
set('5💎 10👽', <twilightforest:auroralized_glass>);

/*
#######################################################
_  _ ____ _  _ _ _    _    ____   / _  _ _ _  _ ____ ____ ____ ____ ____ ___
|  | |__| |\ | | |    |    |__|  /  |\/| | |\ | |___ |    |__/ |__| |___  |
 \/  |  | | \| | |___ |___ |  | /   |  | | | \| |___ |___ |  \ |  | |     |

#######################################################
*/

set('5⛰️ ⟁', <minecraft:stone:3>); // diorite
set('5⛰️ ⚡', <minecraft:stone:5>); // andesite
set('5⛰️ 🔥', <minecraft:stone:1>); // granite
set('5🐺 2🔗', <minecraft:web>);
set('101🔩', <minecraft:iron_block>);
set('67🔩 33✊', <minecraft:gold_block>);

set('10👻 10🧨 5🌑 5⚡', <minecraft:skull:1>); // wither skull

/*
#######################################################
_  _ _  _ _    ___  ____ ____    _    _ ___  ____ ____ ____ _   _
|  | |  | |    |__] |___ [__     |    | |__] |__/ |__| |__/  \_/
 \/  |__| |___ |    |___ ___]    |___ | |__] |  \ |  | |  \   |

#######################################################
*/

set('21🔩', <libvulpes:productsheet:1>);
set('14🔩 7🔄', <libvulpes:productsheet:4>);
set('21🔩 7⟁', <libvulpes:productsheet:6>);
set('14🔩 7🧊', <libvulpes:productsheet:7>);
set('14🔩 7💨', <libvulpes:productsheet:9>);

// Removing wrong aspects from stuff
set('⛰️', <conarm:armor_trim:*>);
<harvestcraft:freshwateritem>.removeAspects(<aspect:metallum>);

// Override aspects
set('4✊ 4💎 4🐀', <rats:rat_diamond>);
set('40⚰️ 50👽 60🌑', <enderio:block_enderman_skull>);
set('20✊ 15💎', <ic2:dust:5>);
set('500✊ 500💎', <additionalcompression:gemdiamond_compressed:1>);
set('500✊ 500💎 100☀️', <additionalcompression:gemdiamond_compressed:2>);
set('20✊ 20💎', <mekanism:compresseddiamond>);
set('50✊ 40⚙️', <thermalfoundation:material:26>);
set('20✊ 20💎 80💪', <actuallyadditions:item_crystal:2>);
set('140✊ 140💎 80💪', <actuallyadditions:block_crystal:2>);
set('60✊ 60💎 150💪', <actuallyadditions:item_crystal_empowered:2>);
set('400✊ 400💎 400💪', <actuallyadditions:block_crystal_empowered:2>);
set('45⛰️ 9⚡', <extrautils2:compressedcobblestone:0>);
set('405⛰️ 81⚡', <extrautils2:compressedcobblestone:1>);
set('500⛰️ 500⚡', <extrautils2:compressedcobblestone:2>);
set('21🧊', <biomesoplenty:hard_ice>);
set('2👽 7🌑', <appliedenergistics2:sky_stone_block>);
set('✊ 💧', <minecraft:sugar>);

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
Aspect.ventus  ,        - lithium
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
Aspect.imperium,        - nickel
<aspect:sensus>,        - platinum
<aspect:alienis>,       - enderium
<aspect:victus>,        - raw meat
<aspect:mythus>,        - silver
<aspect:praecantatio>,  - thaumium?
Aspect.fluctus,         - iridium
Aspect.visum,           - osgloglas
<aspect:vinculum>,      - bronze
<aspect:fabrico>,       - invar
<aspect:alkimia>,       - alchemical brass
<aspect:volatus>,       - cobalt
<aspect:draco>,         - draconic metal
Aspect.sonus,           - constantant
<aspect:vitium>,        - void metal
<aspect:vacuos>,        - tungsten
Aspect.caeles,          - wyvern metal
<aspect:lux>,           - lumium
<aspect:permutatio>,    - copper
<aspect:humanus>,       - UU metal, boron
<aspect:machina>,       - signalium
<aspect:desiderium>,    - gold
<aspect:vitreus>,       - tin
<aspect:motus>,         - electrum
Aspect.exitium,         - ardite
<aspect:cognitio>,      - enchanted metal
<aspect:mana>,          - manasteel
Aspect.infernum,        - demon metal
<aspect:mortuus>,       - uranium
<aspect:aversio>,       - manyullyn
<aspect:potentia>,      - energium
<aspect:auram>,         - mana infused, magnesium
<aspect:bestia>,        - cooked meat, pigiron
<aspect:gelum>,         - titanium
*/

function calculateAspects(main as float, secondary as float, a1 as CTAspectStack, a2 as CTAspectStack, a3 as CTAspectStack) as CTAspectStack[] {
  var list = [] as CTAspectStack[];
  list += a1.setAmount(main);
  if (secondary >= 1) list += a2.setAmount(secondary);
  if (!isNull(a3)) list += a3.setAmount(main);
  return list;
}

function addMetallurgicAspects(mul as float, mulAs as float, tier as int,
  ingot as IItemStack, nugget as IItemStack, block as IItemStack, dust as IItemStack,
  plate as IItemStack, densePlate as IItemStack, sheetBlock as IItemStack, case as IItemStack, gear as IItemStack,
  cluster as IItemStack, crystal as IItemStack, crystalCompacted as IItemStack, rockyChunk as IItemStack,
  chunk as IItemStack, alchemicalDust as IItemStack, dirty as IItemStack,
  ore as IItemStack, oreNether as IItemStack, oreEnd as IItemStack,
  crushed as IItemStack, crushedPurfired as IItemStack,
  seed as IItemStack, essence as IItemStack,
  aspectMain as CTAspectStack, aspectSec as CTAspectStack, aspectThird as CTAspectStack = null) as void {
  if (!isNull(ingot)) ingot.setAspects(calculateAspects(10.0 * mul, 5.0 * mulAs, aspectMain, aspectSec, aspectThird));
  if (!isNull(nugget)) nugget.setAspects(calculateAspects(1.0 * mul, 0.5 * mulAs, aspectMain, aspectSec, aspectThird));
  if (!isNull(block)) block.setAspects(calculateAspects(67.0 * mul, 33.5 * mulAs, aspectMain, aspectSec, aspectThird));
  if (!isNull(dust)) dust.setAspects(calculateAspects(10.0 * mul, 5.0 * mulAs, aspectMain, aspectSec, aspectThird) + <aspect:perditio> * 5);

  if (!isNull(plate)) plate.setAspects(calculateAspects(10.0 * mul, 5.0 * mulAs, aspectMain, aspectSec, aspectThird) + <aspect:instrumentum> * 2);
  if (!isNull(densePlate)) densePlate.setAspects(calculateAspects(67.0 * mul, 33.5 * mulAs, aspectMain, aspectSec, aspectThird) + <aspect:instrumentum> * 13);
  if (!isNull(sheetBlock)) sheetBlock.setAspects(calculateAspects(10.0 * mul, 5.0 * mulAs, aspectMain, aspectSec, aspectThird));
  if (!isNull(case)) case.setAspects(calculateAspects(2.0 * mul, 2.0 * mulAs, aspectMain, aspectSec, aspectThird) + <aspect:instrumentum> * 2);
  if (!isNull(gear)) gear.setAspects(calculateAspects(30.0 * mul, 15.0 * mulAs, aspectMain, aspectSec, aspectThird) + <aspect:machina> * 5);

  if (!isNull(cluster)) cluster.setAspects(calculateAspects(15.0 * mul, 10.0 * mulAs, aspectMain, aspectSec, aspectThird) + <aspect:ordo> * 5 + <aspect:terra> * 5);
  if (!isNull(crystal)) crystal.setAspects(calculateAspects(15.0 * mul, 10.0 * mulAs, aspectMain, aspectSec, aspectThird) + <aspect:ordo> * 10);
  if (!isNull(crystalCompacted)) crystalCompacted.setAspects(calculateAspects(60.0 * mul, 40.0 * mulAs, aspectMain, aspectSec, aspectThird) + <aspect:vitreus> * 20);
  if (!isNull(rockyChunk)) rockyChunk.setAspects(calculateAspects(150.0 * mul, 100.0 * mulAs, aspectMain, aspectSec, aspectThird) + <aspect:vitreus> * 50 + <aspect:desiderium> * 100);
  if (!isNull(chunk)) chunk.setAspects(calculateAspects(250.0 * mul, 200.0 * mulAs, aspectMain, aspectSec, aspectThird) + <aspect:vitreus> * 75 + <aspect:permutatio> * 100);
  if (!isNull(alchemicalDust)) alchemicalDust.setAspects(calculateAspects(500.0 * mul, 500.0 * mulAs, aspectMain, aspectSec, aspectThird) + <aspect:ordo> * 250 + <aspect:praecantatio> * 250 + Aspect.caeles * 50);
  if (!isNull(dirty)) dirty.setAspects(calculateAspects(60.0 * mul, 40.0 * mulAs, aspectMain, aspectSec, aspectThird) + <aspect:permutatio> * 30);

  if (!isNull(ore)) ore.setAspects(calculateAspects(10.0 * mul, 5.0 * mulAs, aspectMain, aspectSec, aspectThird) + <aspect:terra> * 5);
  if (!isNull(oreNether)) oreNether.setAspects(calculateAspects(20.0 * mul, 10.0 * mulAs, aspectMain, aspectSec, aspectThird) + <aspect:ignis> * 10);
  if (!isNull(oreEnd)) oreEnd.setAspects(calculateAspects(40.0 * mul, 20.0 * mulAs, aspectMain, aspectSec, aspectThird) + <aspect:alienis> * 10);

  if (!isNull(crushed)) crushed.setAspects(calculateAspects(10.0 * mul, 5.0 * mulAs, aspectMain, aspectSec, aspectThird) + <aspect:perditio> * 1);
  if (!isNull(crushedPurfired)) crushedPurfired.setAspects(calculateAspects(10.0 * mul, 5.0 * mulAs, aspectMain, aspectSec, aspectThird) + <aspect:ordo> * 1);

  if (!isNull(seed)) seed.setAspects(calculateAspects(10.0 * mul, 5.0 * mulAs, aspectMain, aspectSec, aspectThird) + <aspect:herba> * ((5.0 * tier)));
  if (!isNull(essence)) essence.setAspects(calculateAspects(10.0 * mul, 5.0 * mulAs, aspectMain, aspectSec, aspectThird) + <aspect:praecantatio> * ((5.0 * tier)));
}

// Iron
addMetallurgicAspects
(1, 1, 3,
  <minecraft:iron_ingot>, <minecraft:iron_nugget>, <minecraft:iron_block>, <thermalfoundation:material>,
  <thermalfoundation:material:32>, <ic2:plate:12>, <immersiveengineering:sheetmetal:9>, <ic2:casing:3>, <thermalfoundation:material:24>,
  <thaumcraft:cluster>, <jaopca:item_crystalshardiron>, <jaopca:item_crystalabyssiron>,
  <jaopca:item_rockychunkiron>, <jaopca:item_chunkiron>, <jaopca:item_dustalchiron>, <jaopca:item_dirtygemiron>,
  <minecraft:iron_ore>, <netherendingores:ore_nether_vanilla:4>, <netherendingores:ore_end_vanilla:4>, <ic2:crushed:2>, <ic2:purified:2>,
  <mysticalagriculture:iron_seeds>, <mysticalagriculture:iron_essence>,
  <aspect:metallum>, <aspect:metallum>);

// Gold
addMetallurgicAspects
(1, 2, 4,
  <minecraft:gold_ingot>, <minecraft:gold_nugget>, <minecraft:gold_block>, <thermalfoundation:material:1>,
  <thermalfoundation:material:33>, <ic2:plate:11>, <immersiveengineering:sheetmetal:10>, <ic2:casing:2>, <thermalfoundation:material:25>,
  <thaumcraft:cluster:1>, <jaopca:item_crystalshardgold>, <jaopca:item_crystalabyssgold>,
  <jaopca:item_rockychunkgold>, <jaopca:item_chunkgold>, <jaopca:item_dustalchgold>, <jaopca:item_dirtygemgold>,
  <minecraft:gold_ore>, <netherendingores:ore_nether_vanilla:3>, <netherendingores:ore_end_vanilla:3>, <ic2:crushed:1>, <ic2:purified:1>,
  <mysticalagriculture:gold_seeds>, <mysticalagriculture:gold_essence>,
  <aspect:metallum>, <aspect:desiderium>);

// Diamond
addMetallurgicAspects
(2, 2, 4,
  <minecraft:diamond>, <thermalfoundation:material:16>, <minecraft:diamond_block>, <ic2:dust:5>,
  null, null, null, null, <thermalfoundation:material:26>,
  <jaopca:item_clusterdiamond>, <jaopca:item_crystalsharddiamond>, <jaopca:item_crystalabyssdiamond>,
  <jaopca:item_rockychunkdiamond>, <jaopca:item_chunkdiamond>, <jaopca:item_dustalchdiamond>, <jaopca:item_dirtygemdiamond>,
  <minecraft:diamond_ore>, <netherendingores:ore_nether_vanilla:1>, <netherendingores:ore_end_vanilla:1>,
  null, null,
  <mysticalagriculture:diamond_seeds>, <mysticalagriculture:diamond_essence>,
  <aspect:vitreus>, <aspect:desiderium>);

// Emerald
addMetallurgicAspects
(1.5, 2, 4,
  <minecraft:emerald>, <thermalfoundation:material:17>, <minecraft:emerald_block>, <actuallyadditions:item_dust:3>,
  null, null, null, null, <thermalfoundation:material:27>,
  <jaopca:item_clusteremerald>, <jaopca:item_crystalshardemerald>, <jaopca:item_crystalabyssemerald>,
  <jaopca:item_rockychunkemerald>, <jaopca:item_chunkemerald>, <jaopca:item_dustalchemerald>, <jaopca:item_dirtygememerald>,
  <minecraft:emerald_ore>, <netherendingores:ore_nether_vanilla:2>, <netherendingores:ore_end_vanilla:2>, null, null,
  null, null,
  <aspect:vitreus>, <aspect:desiderium>);

// Copper
addMetallurgicAspects
(1, 1, 2,
  <thermalfoundation:material:128>, <thermalfoundation:material:192>, <thermalfoundation:storage>,
  <thermalfoundation:material:64>, <thermalfoundation:material:320>, <ic2:plate:10>, <immersiveengineering:sheetmetal>, <ic2:casing:1>, <thermalfoundation:material:256>,
  <thaumcraft:cluster:2>, <jaopca:item_crystalshardcopper>, <jaopca:item_crystalabysscopper>, <jaopca:item_rockychunkcopper>,
  <jaopca:item_chunkcopper>, <jaopca:item_dustalchcopper>, <jaopca:item_dirtygemcopper>,
  <thermalfoundation:ore>, <netherendingores:ore_nether_modded_1:1>, <netherendingores:ore_end_modded_1:1>,
  <ic2:crushed>, <ic2:purified>,
  <mysticalagriculture:copper_seeds>, <mysticalagriculture:copper_essence>,
  <aspect:metallum>, <aspect:permutatio>);

// Tin
addMetallurgicAspects
(1, 1, 2,
  <thermalfoundation:material:129>, <thermalfoundation:material:193>, <thermalfoundation:storage:1>, <thermalfoundation:material:65>,
  <thermalfoundation:material:321>, <ic2:plate:17>, null, <ic2:casing:6>, <thermalfoundation:material:257>,
  <thaumcraft:cluster:3>, <jaopca:item_crystalshardtin>, <jaopca:item_crystalabysstin>, <jaopca:item_rockychunktin>,
  <jaopca:item_chunktin>, <jaopca:item_dustalchtin>, <jaopca:item_dirtygemtin>,
  <thermalfoundation:ore:1>, <netherendingores:ore_nether_modded_1:8>, <netherendingores:ore_end_modded_1:8>,
  <ic2:crushed:5>, <ic2:purified:5>,
  <mysticalagriculture:tin_seeds>, <mysticalagriculture:tin_essence>,
  <aspect:metallum>, <aspect:vitreus>);

// Silver
addMetallurgicAspects
(1, 1, 3,
  <thermalfoundation:material:130>, <thermalfoundation:material:194>, <thermalfoundation:storage:2>, <thermalfoundation:material:66>,
  <thermalfoundation:material:322>, null, <immersiveengineering:sheetmetal:3>, null, <thermalfoundation:material:258>,
  <thaumcraft:cluster:4>, <jaopca:item_crystalshardsilver>, <jaopca:item_crystalabysssilver>, <jaopca:item_rockychunksilver>,
  <jaopca:item_chunksilver>, <jaopca:item_dustalchsilver>, <jaopca:item_dirtygemsilver>,
  <thermalfoundation:ore:2>, <netherendingores:ore_nether_modded_1:7>, <netherendingores:ore_end_modded_1:7>,
  <ic2:crushed:4>, <ic2:purified:4>,
  <mysticalagriculture:silver_seeds>, <mysticalagriculture:silver_essence>,
  <aspect:metallum>, <aspect:mythus>);

// Lead
addMetallurgicAspects
(1, 1, 3,
  <thermalfoundation:material:131>, <thermalfoundation:material:195>, <thermalfoundation:storage:3>, <thermalfoundation:material:67>,
  <thermalfoundation:material:323>, <ic2:plate:14>, <immersiveengineering:sheetmetal:2>, <ic2:casing:4>, <thermalfoundation:material:259>,
  <thaumcraft:cluster:5>, <jaopca:item_crystalshardlead>, <jaopca:item_crystalabysslead>, <jaopca:item_rockychunklead>,
  <jaopca:item_chunklead>, <jaopca:item_dustalchlead>, <jaopca:item_dirtygemlead>,
  <thermalfoundation:ore:3>, <netherendingores:ore_nether_modded_1:3>, <netherendingores:ore_end_modded_1:3>,
  <ic2:crushed:3>, <ic2:purified:3>,
  <mysticalagriculture:lead_seeds>, <mysticalagriculture:lead_essence>,
  <aspect:metallum>, <aspect:ordo>);

// Aluminium
addMetallurgicAspects
(1, 1, 3,
  <thermalfoundation:material:132>, <thermalfoundation:material:196>, <thermalfoundation:storage:4>, <thermalfoundation:material:68>,
  <thermalfoundation:material:324>, null, <immersiveengineering:sheetmetal:1>, null, <thermalfoundation:material:260>,
  <jaopca:item_clusteraluminium>, <jaopca:item_crystalshardaluminium>, <jaopca:item_crystalabyssaluminium>, <jaopca:item_rockychunkaluminium>,
  <jaopca:item_chunkaluminium>, <jaopca:item_dustalchaluminium>, <jaopca:item_dirtygemaluminium>,
  <thermalfoundation:ore:4>, <netherendingores:ore_nether_modded_1>, <netherendingores:ore_end_modded_1>,
  <jaopca:item_crushedaluminium>, <jaopca:item_crushedpurifiedaluminium>,
  <mysticalagriculture:aluminum_seeds>, <mysticalagriculture:aluminum_essence>,
  <aspect:metallum>, <aspect:aer>);

// Nickiel
addMetallurgicAspects
(1, 1, 4,
  <thermalfoundation:material:133>, <thermalfoundation:material:197>, <thermalfoundation:storage:5>, <thermalfoundation:material:69>,
  <thermalfoundation:material:325>, null, <immersiveengineering:sheetmetal:4>, null, <thermalfoundation:material:261>,
  <jaopca:item_clusternickel>, <jaopca:item_crystalshardnickel>, <jaopca:item_crystalabyssnickel>, <jaopca:item_rockychunknickel>,
  <jaopca:item_chunknickel>, <jaopca:item_dustalchnickel>, <jaopca:item_dirtygemnickel>,
  <thermalfoundation:ore:5>, <netherendingores:ore_nether_modded_1:5>, <netherendingores:ore_end_modded_1:5>,
  <jaopca:item_crushednickel>, <jaopca:item_crushedpurifiednickel>,
  <mysticalagriculture:nickel_seeds>, <mysticalagriculture:nickel_essence>,
  <aspect:metallum>, Aspect.imperium);

// Platinum
addMetallurgicAspects
(2, 1, 5,
  <thermalfoundation:material:134>, <thermalfoundation:material:198>, <thermalfoundation:storage:6>, <thermalfoundation:material:70>,
  <thermalfoundation:material:326>, null, null, null, <thermalfoundation:material:262>,
  <jaopca:item_clusterplatinum>, <jaopca:item_crystalshardplatinum>, <jaopca:item_crystalabyssplatinum>, <jaopca:item_rockychunkplatinum>,
  <jaopca:item_chunkplatinum>, <jaopca:item_dustalchplatinum>, <jaopca:item_dirtygemplatinum>,
  <thermalfoundation:ore:6>, <netherendingores:ore_nether_modded_1:6>, <netherendingores:ore_end_modded_1:6>,
  <jaopca:item_crushedplatinum>, <jaopca:item_crushedpurifiedplatinum>,
  <mysticalagriculture:platinum_seeds>, <mysticalagriculture:platinum_essence>,
  <aspect:metallum>, <aspect:sensus>);

// Iridium
addMetallurgicAspects
(2, 2, 6,
  <thermalfoundation:material:135>, <thermalfoundation:material:199>, <thermalfoundation:storage:7>, <thermalfoundation:material:71>,
  <thermalfoundation:material:327>, null, null, null, <thermalfoundation:material:263>,
  <jaopca:item_clusteriridium>, <jaopca:item_crystalshardiridium>, <jaopca:item_crystalabyssiridium>, <jaopca:item_rockychunkiridium>,
  <jaopca:item_chunkiridium>, <jaopca:item_dustalchiridium>, <jaopca:item_dirtygemiridium>,
  <thermalfoundation:ore:7>, null, null,
  <jaopca:item_crushediridium>, <jaopca:item_crushedpurifiediridium>,
  <mysticalagriculture:iridium_seeds>, <mysticalagriculture:iridium_essence>,
  <aspect:metallum>, Aspect.fluctus);

// ManaInfused
addMetallurgicAspects
(2, 1, 0,
  <thermalfoundation:material:136>, <thermalfoundation:material:200>, <thermalfoundation:storage:8>, <thermalfoundation:material:72>,
  <thermalfoundation:material:328>, null, null, null, <thermalfoundation:material:264>,
  <jaopca:item_clustermithril>, <jaopca:item_crystalshardmithril>, <jaopca:item_crystalabyssmithril>, <jaopca:item_rockychunkmithril>,
  <jaopca:item_chunkmithril>, <jaopca:item_dustalchmithril>, <jaopca:item_dirtygemmithril>,
  <thermalfoundation:ore:8>, null, <netherendingores:ore_end_modded_1:4>,
  <jaopca:item_crushedmithril>, <jaopca:item_crushedpurifiedmithril>,
  null, null,
  <aspect:metallum>, <aspect:auram>);

// Steel
addMetallurgicAspects
(1.5, 1, 0,
  <thermalfoundation:material:160>, <thermalfoundation:material:224>, <thermalfoundation:storage_alloy>, <thermalfoundation:material:96>,
  <thermalfoundation:material:352>, <ic2:plate:16>, <immersiveengineering:sheetmetal:8>, <ic2:casing:5>, <thermalfoundation:material:288>,
  null, null, null, null,
  null, null, null,
  null, null, null,
  null, null,
  null, null,
  <aspect:metallum>, <aspect:ordo>);

// Electrum
addMetallurgicAspects
(1, 1, 0,
  <thermalfoundation:material:161>, <thermalfoundation:material:225>, <thermalfoundation:storage_alloy:1>, <thermalfoundation:material:97>,
  <thermalfoundation:material:353>, null, <immersiveengineering:sheetmetal:7>, null, <thermalfoundation:material:289>,
  null, null, null, null,
  null, null, null,
  null, null, null,
  null, null,
  null, null,
  <aspect:metallum>, <aspect:motus>);

// Invar
addMetallurgicAspects
(1, 1, 0,
  <thermalfoundation:material:162>, <thermalfoundation:material:226>, <thermalfoundation:storage_alloy:2>, <thermalfoundation:material:98>,
  <thermalfoundation:material:354>, null, null, null, <thermalfoundation:material:290>,
  null, null, null, null,
  null, null, null,
  null, null, null,
  null, null,
  null, null,
  <aspect:metallum>, <aspect:fabrico>);

// Bronze
addMetallurgicAspects
(1, 1, 0,
  <thermalfoundation:material:163>, <thermalfoundation:material:227>, <thermalfoundation:storage_alloy:3>, <thermalfoundation:material:99>,
  <thermalfoundation:material:355>, <ic2:plate:9>, null, <ic2:casing>, <thermalfoundation:material:291>,
  null, null, null, null,
  null, null, null,
  null, null, null,
  null, null,
  null, null,
  <aspect:metallum>, <aspect:vinculum>);

// Constantant
addMetallurgicAspects
(1, 1, 0,
  <thermalfoundation:material:164>, <thermalfoundation:material:228>, <thermalfoundation:storage_alloy:4>, <thermalfoundation:material:100>,
  <thermalfoundation:material:356>, null, null, null, <thermalfoundation:material:292>,
  null, null, null, null,
  null, null, null,
  null, null, null,
  null, null,
  null, null,
  <aspect:metallum>, Aspect.sonus);

// Signalum
addMetallurgicAspects
(1, 1, 0,
  <thermalfoundation:material:165>, <thermalfoundation:material:229>, <thermalfoundation:storage_alloy:5>, <thermalfoundation:material:101>,
  <thermalfoundation:material:357>, null, null, null, <thermalfoundation:material:293>,
  null, null, null, null,
  null, null, null,
  null, null, null,
  null, null,
  null, null,
  <aspect:metallum>, <aspect:machina>);

// Lumium
addMetallurgicAspects
(1, 1, 0,
  <thermalfoundation:material:166>, <thermalfoundation:material:230>, <thermalfoundation:storage_alloy:6>, <thermalfoundation:material:102>,
  <thermalfoundation:material:358>, null, null, null, <thermalfoundation:material:294>,
  null, null, null, null,
  null, null, null,
  null, null, null,
  null, null,
  null, null,
  <aspect:metallum>, <aspect:lux>);

// Ednerium
addMetallurgicAspects
(2, 2, 6,
  <thermalfoundation:material:167>, <thermalfoundation:material:231>, <thermalfoundation:storage_alloy:7>, <thermalfoundation:material:103>,
  <thermalfoundation:material:359>, null, null, null, <thermalfoundation:material:295>,
  null, null, null, null,
  null, null, null,
  null, null, null,
  null, null,
  <mysticalagriculture:enderium_seeds>,
  <mysticalagriculture:enderium_essence>,
  <aspect:metallum>, <aspect:alienis>);

// Coal
addMetallurgicAspects
(1, 2, 2,
  <minecraft:coal>, <actuallyadditions:item_misc:10>, <minecraft:coal_block>, <thermalfoundation:material:768>,
  null, null, null, null, null,
  <jaopca:item_clustercoal>, <jaopca:item_crystalshardcoal>, <jaopca:item_crystalabysscoal>, <jaopca:item_rockychunkcoal>,
  <jaopca:item_chunkcoal>, <jaopca:item_dustalchcoal>, <jaopca:item_dirtygemcoal>,
  <minecraft:coal_ore>, <netherendingores:ore_nether_vanilla>, <netherendingores:ore_end_vanilla>,
  null, null,
  <mysticalagriculture:coal_seeds>, <mysticalagriculture:coal_essence>,
  <aspect:ignis>, <aspect:potentia>);

// Lapis
addMetallurgicAspects
(0.5, 0.4, 4,
  <minecraft:dye:4>, <jaopca:item_nuggetlapis>, <minecraft:lapis_block>, <ic2:dust:9>,
  <ic2:plate:4>, <ic2:plate:13>, null, null, null,
  <jaopca:item_clusterlapis>, <jaopca:item_crystalshardlapis>, <jaopca:item_crystalabysslapis>, <jaopca:item_rockychunklapis>,
  <jaopca:item_chunklapis>, <jaopca:item_dustalchlapis>, <jaopca:item_dirtygemlapis>,
  <minecraft:lapis_ore>, <netherendingores:ore_nether_vanilla:5>, <netherendingores:ore_end_vanilla:5>,
  null, null,
  <mysticalagriculture:lapis_lazuli_seeds>, <mysticalagriculture:lapis_lazuli_essence>,
  <aspect:sensus>, <aspect:desiderium>);

// Redstone
addMetallurgicAspects
(1.0, 0.0, 4,
  <minecraft:redstone>, <jaopca:item_dusttinyredstone>, <minecraft:redstone_block>, null,
  null, null, null, null, null,
  <jaopca:item_clusterredstone>, <jaopca:item_crystalshardredstone>, <jaopca:item_crystalabyssredstone>, <jaopca:item_rockychunkredstone>,
  <jaopca:item_chunkredstone>, <jaopca:item_dustalchredstone>, <jaopca:item_dirtygemredstone>,
  <minecraft:redstone_ore>, <netherendingores:ore_nether_vanilla:6>, <netherendingores:ore_end_vanilla:6>,
  null, null,
  <mysticalagriculture:redstone_seeds>, <mysticalagriculture:redstone_essence>,
  <aspect:potentia>, <aspect:terra>);

// Titanium
addMetallurgicAspects
(1.0, 1.0, 0,
  <libvulpes:productingot:7>, <libvulpes:productnugget:7>, <libvulpes:metal0:7>, <libvulpes:productdust:7>,
  <libvulpes:productplate:7>, null, null, null, <libvulpes:productgear:7>,
  <jaopca:item_clustertitanium>, <jaopca:item_crystalshardtitanium>, <jaopca:item_crystalabysstitanium>, <jaopca:item_rockychunktitanium>,
  <jaopca:item_chunktitanium>, <jaopca:item_dustalchtitanium>, <jaopca:item_dirtygemtitanium>,
  <libvulpes:ore0:8>, null, null,
  null, null,
  null, null,
  <aspect:metallum>, <aspect:gelum>);

// Knightslime
addMetallurgicAspects
(1.0, 1.0, 3,
  <tconstruct:ingots:3>, <tconstruct:nuggets:3>, <tconstruct:metal:3>, null,
  null, null, null, null, null,
  null, null, null, null,
  null, null, null,
  null, null, null,
  null, null,
  <mysticalagriculture:knightslime_seeds>, <mysticalagriculture:knightslime_essence>,
  <aspect:metallum>, <aspect:aqua>);

// Cobalt
addMetallurgicAspects
(1.0, 1.0, 4,
  <tconstruct:ingots>, <tconstruct:nuggets>, <tconstruct:metal>, <exnihilocreatio:item_ore_cobalt:2>,
  null, null, null, null, null,
  <jaopca:item_clustercobalt>, <jaopca:item_crystalshardcobalt>, <jaopca:item_crystalabysscobalt>, <jaopca:item_rockychunkcobalt>,
  <jaopca:item_chunkcobalt>, <jaopca:item_dustalchcobalt>, <jaopca:item_dirtygemcobalt>,
  <netherendingores:ore_other_1:4>, <tconstruct:ore>, <netherendingores:ore_other_1:5>,
  <jaopca:item_crushedcobalt>, <jaopca:item_crushedpurifiedcobalt>,
  <mysticalagriculture:cobalt_seeds>, <mysticalagriculture:cobalt_essence>,
  <aspect:metallum>, <aspect:volatus>);

// Ardite
addMetallurgicAspects
(1.0, 1.0, 4,
  <tconstruct:ingots:1>, <tconstruct:nuggets:1>, <tconstruct:metal:1>, <exnihilocreatio:item_ore_ardite:2>,
  null, null, null, null, null,
  <jaopca:item_clusterardite>, <jaopca:item_crystalshardardite>, <jaopca:item_crystalabyssardite>, <jaopca:item_rockychunkardite>,
  <jaopca:item_chunkardite>, <jaopca:item_dustalchardite>, <jaopca:item_dirtygemardite>,
  <netherendingores:ore_other_1:2>, <tconstruct:ore:1>, <netherendingores:ore_other_1:3>,
  <jaopca:item_crushedardite>, <jaopca:item_crushedpurifiedardite>,
  <mysticalagriculture:ardite_seeds>, <mysticalagriculture:ardite_essence>,
  <aspect:metallum>, Aspect.exitium);

// Uranium
addMetallurgicAspects
(1.0, 1.0, 4,
  <immersiveengineering:metal:5>, <immersiveengineering:metal:25>, <immersiveengineering:storage:5>, <immersiveengineering:metal:14>,
  <immersiveengineering:metal:35>, null, <immersiveengineering:sheetmetal:5>, null, null,
  <jaopca:item_clusteruranium>, <jaopca:item_crystalsharduranium>, <jaopca:item_crystalabyssuranium>, <jaopca:item_rockychunkuranium>,
  <jaopca:item_chunkuranium>, <jaopca:item_dustalchuranium>, <jaopca:item_dirtygemuranium>,
  <immersiveengineering:ore:5>, <netherendingores:ore_nether_modded_1:12>, <netherendingores:ore_end_modded_1:12>,
  <ic2:crushed:6>, <ic2:purified:6>,
  <mysticalagriculture:uranium_seeds>, <mysticalagriculture:uranium_essence>,
  <aspect:metallum>, <aspect:mortuus>);

// Starmetal
addMetallurgicAspects
(1.0, 1.0, 3,
  <astralsorcery:itemcraftingcomponent:1>, <jaopca:item_nuggetastralstarmetal>, <jaopca:block_blockastralstarmetal>, <astralsorcery:itemcraftingcomponent:2>,
  null, null, null, null, null,
  <jaopca:item_clusterastralstarmetal>, <jaopca:item_crystalshardastralstarmetal>, <jaopca:item_crystalabyssastralstarmetal>, <jaopca:item_rockychunkastralstarmetal>,
  <jaopca:item_chunkastralstarmetal>, <jaopca:item_dustalchastralstarmetal>, <jaopca:item_dirtygemastralstarmetal>,
  <astralsorcery:blockcustomore:1>, null, null,
  <jaopca:item_crushedastralstarmetal>, <jaopca:item_crushedpurifiedastralstarmetal>,
  <mysticalagriculture:starmetal_seeds>, <mysticalagriculture:starmetal_essence>,
  <aspect:metallum>, <aspect:praecantatio>, <aspect:tenebrae>);

// Black quartz
addMetallurgicAspects
(1.0, 1.0, 3,
  <actuallyadditions:item_misc:5>, <jaopca:item_nuggetquartzblack>, <actuallyadditions:block_misc:2>, <actuallyadditions:item_dust:7>,
  null, null, null, null, null,
  <jaopca:item_clusterquartzblack>, <jaopca:item_crystalshardquartzblack>, <jaopca:item_crystalabyssquartzblack>, <jaopca:item_rockychunkquartzblack>,
  <jaopca:item_chunkquartzblack>, <jaopca:item_dustalchquartzblack>, <jaopca:item_dirtygemquartzblack>,
  <actuallyadditions:block_misc:3>, null, null,
  null, null,
  <mysticalagriculture:black_quartz_seeds>, <mysticalagriculture:black_quartz_essence>,
  <aspect:vitreus>, <aspect:tenebrae>);

// Certus quartz
addMetallurgicAspects
(1.0, 1.0, 2,
  <appliedenergistics2:material>, <jaopca:item_nuggetcertusquartz>, null, <appliedenergistics2:material:2>,
  null, null, null, null, null,
  <jaopca:item_clustercertusquartz>, <jaopca:item_crystalshardcertusquartz>, <jaopca:item_crystalabysscertusquartz>, <jaopca:item_rockychunkcertusquartz>,
  <jaopca:item_chunkcertusquartz>, <jaopca:item_dustalchcertusquartz>, <jaopca:item_dirtygemcertusquartz>,
  <appliedenergistics2:quartz_ore>, <netherendingores:ore_nether_modded_1:9>, <netherendingores:ore_end_modded_1:9>,
  null, null,
  <mysticalagriculture:certus_quartz_seeds>, <mysticalagriculture:certus_quartz_essence>,
  <aspect:vitreus>, <aspect:potentia>);

// Charged certus quartz
addMetallurgicAspects
(1.0, 4.0, 0,
  <appliedenergistics2:material:1>, <jaopca:item_nuggetchargedcertusquartz>, null, null,
  null, null, null, null, null,
  <jaopca:item_clusterchargedcertusquartz>, <jaopca:item_crystalshardchargedcertusquartz>, <jaopca:item_crystalabysschargedcertusquartz>, <jaopca:item_rockychunkchargedcertusquartz>,
  <jaopca:item_chunkchargedcertusquartz>, <jaopca:item_dustalchchargedcertusquartz>, <jaopca:item_dirtygemchargedcertusquartz>,
  <appliedenergistics2:charged_quartz_ore>, <netherendingores:ore_nether_modded_1:10>, null,
  null, null,
  null, null,
  <aspect:vitreus>, <aspect:potentia>);

// Aquamarine
addMetallurgicAspects
(1.0, 1.0, 3,
  <astralsorcery:itemcraftingcomponent>, <jaopca:item_nuggetaquamarine>, <jaopca:block_blockaquamarine>, <jaopca:item_dustaquamarine>,
  null, null, null, null, null,
  <jaopca:item_clusteraquamarine>, <jaopca:item_crystalshardaquamarine>, <jaopca:item_crystalabyssaquamarine>, <jaopca:item_rockychunkaquamarine>,
  <jaopca:item_chunkaquamarine>, <jaopca:item_dustalchaquamarine>, <jaopca:item_dirtygemaquamarine>,
  <astralsorcery:blockcustomsandore>, null, null,
  null, null,
  <mysticalagriculture:aquamarine_seeds>, <mysticalagriculture:aquamarine_essence>,
  <aspect:vitreus>, <aspect:aqua>);

// Tungsten
addMetallurgicAspects
(1.0, 1.0, 0,
  <endreborn:item_ingot_wolframium>, <endreborn:wolframium_nugget>, <endreborn:block_wolframium>, <jaopca:item_dustdirtytungsten>,
  null, null, null, null, null,
  <jaopca:item_clustertungsten>, <jaopca:item_crystalshardtungsten>, <jaopca:item_crystalabysstungsten>, <jaopca:item_rockychunktungsten>,
  <jaopca:item_chunktungsten>, <jaopca:item_dustalchtungsten>, <jaopca:item_dirtygemtungsten>,
  <endreborn:block_wolframium_ore>, null, null,
  <jaopca:item_crushedtungsten>, <jaopca:item_crushedpurifiedtungsten>,
  null, null,
  <aspect:metallum>, <aspect:vacuos>);

// Apatite
addMetallurgicAspects
(1.0, 1.0, 2,
  <forestry:apatite>, <jaopca:item_nuggetapatite>, <forestry:resource_storage>, <jaopca:item_dustapatite>,
  null, null, null, null, null,
  <jaopca:item_clusterapatite>, <jaopca:item_crystalshardapatite>, <jaopca:item_crystalabyssapatite>, <jaopca:item_rockychunkapatite>,
  <jaopca:item_chunkapatite>, <jaopca:item_dustalchapatite>, <jaopca:item_dirtygemapatite>,
  <forestry:resources>, null, null,
  null, null,
  <mysticalagriculture:apatite_seeds>, <mysticalagriculture:apatite_essence>,
  <aspect:vitreus>, <aspect:herba>);

// Osmium
addMetallurgicAspects
(1.0, 1.0, 4,
  <mekanism:ingot:1>, <mekanism:nugget:1>, <mekanism:basicblock>, <mekanism:dust:2>,
  null, null, null, null, null,
  <jaopca:item_clusterosmium>, <jaopca:item_crystalshardosmium>, <jaopca:item_crystalabyssosmium>, <jaopca:item_rockychunkosmium>,
  <jaopca:item_chunkosmium>, <jaopca:item_dustalchosmium>, <jaopca:item_dirtygemosmium>,
  <mekanism:oreblock>, <netherendingores:ore_nether_modded_1:11>, <netherendingores:ore_end_modded_1:11>,
  <jaopca:item_crushedosmium>, <jaopca:item_crushedpurifiedosmium>,
  <mysticalagriculture:osmium_seeds>, <mysticalagriculture:osmium_essence>,
  <aspect:metallum>, <aspect:terra>);

// Boron
addMetallurgicAspects
(1.0, 1.0, 4,
  <nuclearcraft:ingot:5>, <jaopca:item_nuggetboron>, <nuclearcraft:ingot_block:5>, <nuclearcraft:dust:5>,
  null, null, null, null, null,
  <jaopca:item_clusterboron>, <jaopca:item_crystalshardboron>, <jaopca:item_crystalabyssboron>, <jaopca:item_rockychunkboron>,
  <jaopca:item_chunkboron>, <jaopca:item_dustalchboron>, <jaopca:item_dirtygemboron>,
  <nuclearcraft:ore:5>, null, null,
  <jaopca:item_crushedboron>, <jaopca:item_crushedpurifiedboron>,
  <mysticalagriculture:boron_seeds>, <mysticalagriculture:boron_essence>,
  <aspect:metallum>, <aspect:humanus>);

// Lithium
addMetallurgicAspects
(1.0, 1.0, 4,
  <nuclearcraft:ingot:6>, <jaopca:item_nuggetlithium>, <nuclearcraft:ingot_block:6>, <ic2:dust:11>,
  null, null, null, null, null,
  <jaopca:item_clusterlithium>, <jaopca:item_crystalshardlithium>, <jaopca:item_crystalabysslithium>, <jaopca:item_rockychunklithium>,
  <jaopca:item_chunklithium>, <jaopca:item_dustalchlithium>, <jaopca:item_dirtygemlithium>,
  <nuclearcraft:ore:6>, null, <netherendingores:ore_end_modded_1:14>,
  <jaopca:item_crushedlithium>, <jaopca:item_crushedpurifiedlithium>,
  <mysticalagriculture:lithium_seeds>, <mysticalagriculture:lithium_essence>,
  <aspect:metallum>, Aspect.ventus);

// Magnesium
addMetallurgicAspects
(1.0, 1.0, 4,
  <nuclearcraft:ingot:7>, <jaopca:item_nuggetmagnesium>, <nuclearcraft:ingot_block:7>, <nuclearcraft:dust:7>,
  null, null, null, null, null,
  <jaopca:item_clustermagnesium>, <jaopca:item_crystalshardmagnesium>, <jaopca:item_crystalabyssmagnesium>, <jaopca:item_rockychunkmagnesium>,
  <jaopca:item_chunkmagnesium>, <jaopca:item_dustalchmagnesium>, <jaopca:item_dirtygemmagnesium>,
  <nuclearcraft:ore:7>, null, null,
  <jaopca:item_crushedmagnesium>, <jaopca:item_crushedpurifiedmagnesium>,
  <mysticalagriculture:magnesium_seeds>, <mysticalagriculture:magnesium_essence>,
  <aspect:metallum>, <aspect:auram>);

// Thorium
addMetallurgicAspects
(1.0, 1.0, 4,
  <nuclearcraft:ingot:3>, <jaopca:item_nuggetthorium>, <nuclearcraft:ingot_block:3>, <nuclearcraft:dust:3>,
  null, null, null, null, null,
  <jaopca:item_clusterthorium>, <jaopca:item_crystalshardthorium>, <jaopca:item_crystalabyssthorium>, <jaopca:item_rockychunkthorium>,
  <jaopca:item_chunkthorium>, <jaopca:item_dustalchthorium>, <jaopca:item_dirtygemthorium>,
  <nuclearcraft:ore:3>, null, null,
  <jaopca:item_crushedthorium>, <jaopca:item_crushedpurifiedthorium>,
  <mysticalagriculture:thorium_seeds>, <mysticalagriculture:thorium_essence>,
  <aspect:metallum>, <aspect:tenebrae>);

// Draconium
addMetallurgicAspects
(2.0, 2.0, 5,
  <draconicevolution:draconium_ingot>, <draconicevolution:nugget>, <draconicevolution:draconium_block>, <draconicevolution:draconium_dust>,
  null, null, null, null, null,
  <jaopca:item_clusterdraconium>, <jaopca:item_crystalsharddraconium>, <jaopca:item_crystalabyssdraconium>, <jaopca:item_rockychunkdraconium>,
  <jaopca:item_chunkdraconium>, <jaopca:item_dustalchdraconium>, <jaopca:item_dirtygemdraconium>,
  <draconicevolution:draconium_ore>, <draconicevolution:draconium_ore:1>, <draconicevolution:draconium_ore:2>,
  <jaopca:item_crusheddraconium>, <jaopca:item_crushedpurifieddraconium>,
  <mysticalagriculture:draconium_seeds>, <mysticalagriculture:draconium_essence>,
  <aspect:metallum>, <aspect:draco>);

// Amber
addMetallurgicAspects
(1.0, 2.0, 4,
  <thaumcraft:amber>, <jaopca:item_nuggetamber>, <thaumcraft:amber_brick>, <jaopca:item_dustamber>,
  null, null, null, null, null,
  <jaopca:item_clusteramber>, <jaopca:item_crystalshardamber>, <jaopca:item_crystalabyssamber>, <jaopca:item_rockychunkamber>,
  <jaopca:item_chunkamber>, <jaopca:item_dustalchamber>, <jaopca:item_dirtygemamber>,
  <thaumcraft:ore_amber>, null, null,
  null, null,
  <mysticalagriculture:amber_seeds>, <mysticalagriculture:amber_essence>,
  <aspect:vitreus>, <aspect:vinculum>);

// Amethyst
addMetallurgicAspects
(2.0, 4.0, 4,
  <biomesoplenty:gem>, <jaopca:item_nuggetamethyst>, <biomesoplenty:gem_block>, <jaopca:item_dustamethyst>,
  null, null, null, null, null,
  <jaopca:item_clusteramethyst>, <jaopca:item_crystalshardamethyst>, <jaopca:item_crystalabyssamethyst>, <jaopca:item_rockychunkamethyst>,
  <jaopca:item_chunkamethyst>, <jaopca:item_dustalchamethyst>, <jaopca:item_dirtygemamethyst>,
  null, null, <biomesoplenty:gem_ore>,
  null, null,
  <mysticalagriculture:ender_amethyst_seeds>, <mysticalagriculture:ender_amethyst_essence>,
  <aspect:vitreus>, <aspect:alienis>, <aspect:desiderium>);

// Dilithium
addMetallurgicAspects
(2.0, 4.0, 0,
  <libvulpes:productgem>, <jaopca:item_nuggetdilithium>, <jaopca:block_blockdilithium>, <libvulpes:productdust>,
  null, null, null, null, null,
  <jaopca:item_clusterdilithium>, <jaopca:item_crystalsharddilithium>, <jaopca:item_crystalabyssdilithium>, <jaopca:item_rockychunkdilithium>,
  <jaopca:item_chunkdilithium>, <jaopca:item_dustalchdilithium>, <jaopca:item_dirtygemdilithium>,
  <libvulpes:ore0>, null, <netherendingores:ore_end_modded_1:14>,
  null, null,
  null, null,
  <aspect:vitreus>, Aspect.fluctus);

// Dimensional shard
addMetallurgicAspects
(2.0, 4.0, 0,
  <rftools:dimensional_shard>, <jaopca:item_nuggetdimensionalshard>, <jaopca:block_blockdimensionalshard>, <jaopca:item_dustdimensionalshard>,
  null, null, null, null, null,
  <jaopca:item_clusterdimensionalshard>, <jaopca:item_crystalsharddimensionalshard>, <jaopca:item_crystalabyssdimensionalshard>, <jaopca:item_rockychunkdimensionalshard>,
  <jaopca:item_chunkdimensionalshard>, <jaopca:item_dustalchdimensionalshard>, <jaopca:item_dirtygemdimensionalshard>,
  <rftools:dimensional_shard_ore>, null, null,
  null, null,
  null, null,
  <aspect:vitreus>, <aspect:motus>);

// Malachite
addMetallurgicAspects
(1.0, 2.0, 4,
  <biomesoplenty:gem:5>, <jaopca:item_nuggetmalachite>, <biomesoplenty:gem_block:5>, <jaopca:item_dustmalachite>,
  null, null, null, null, null,
  <jaopca:item_clustermalachite>, <jaopca:item_crystalshardmalachite>, <jaopca:item_crystalabyssmalachite>, <jaopca:item_rockychunkmalachite>,
  <jaopca:item_chunkmalachite>, <jaopca:item_dustalchmalachite>, <jaopca:item_dirtygemmalachite>,
  <biomesoplenty:gem_ore:5>, null, null,
  null, null,
  <mysticalagriculture:malachite_seeds>, <mysticalagriculture:malachite_essence>,
  <aspect:vitreus>, <aspect:fabrico>, <aspect:desiderium>);

// Peridot
addMetallurgicAspects
(1.0, 2.0, 4,
  <biomesoplenty:gem:2>, <jaopca:item_nuggetperidot>, <biomesoplenty:gem_block:2>, <jaopca:item_dustperidot>,
  null, null, null, null, null,
  <jaopca:item_clusterperidot>, <jaopca:item_crystalshardperidot>, <jaopca:item_crystalabyssperidot>, <jaopca:item_rockychunkperidot>,
  <jaopca:item_chunkperidot>, <jaopca:item_dustalchperidot>, <jaopca:item_dirtygemperidot>,
  <biomesoplenty:gem_ore:2>, null, null,
  null, null,
  <mysticalagriculture:peridot_seeds>, <mysticalagriculture:peridot_essence>,
  <aspect:vitreus>, <aspect:terra>, <aspect:desiderium>);

// Quartz
addMetallurgicAspects
(0.5, 0.0, 3,
  <minecraft:quartz>, null, null, <appliedenergistics2:material:3>,
  null, null, null, null, null,
  <thaumcraft:cluster:7>, <jaopca:item_crystalshardquartz>, <jaopca:item_crystalabyssquartz>, <jaopca:item_rockychunkquartz>,
  <jaopca:item_chunkquartz>, <jaopca:item_dustalchquartz>, <jaopca:item_dirtygemquartz>,
  <netherendingores:ore_other_1>, <minecraft:quartz_ore>, <netherendingores:ore_other_1:1>,
  null, null,
  <mysticalagriculture:nether_quartz_seeds>, <mysticalagriculture:nether_quartz_essence>,
  <aspect:vitreus>, <aspect:terra>);

// Ruby
addMetallurgicAspects
(1.0, 2.0, 4,
  <biomesoplenty:gem:1>, <jaopca:item_nuggetruby>, <biomesoplenty:gem_block:1>, <jaopca:item_dustruby>,
  null, null, null, null, null,
  <jaopca:item_clusterruby>, <jaopca:item_crystalshardruby>, <jaopca:item_crystalabyssruby>, <jaopca:item_rockychunkruby>,
  <jaopca:item_chunkruby>, <jaopca:item_dustalchruby>, <jaopca:item_dirtygemruby>,
  <biomesoplenty:gem_ore:1>, null, null,
  null, null,
  <mysticalagriculture:ruby_seeds>, <mysticalagriculture:ruby_essence>,
  <aspect:vitreus>, <aspect:victus>, <aspect:desiderium>);

// Sapphire
addMetallurgicAspects
(1.0, 2.0, 4,
  <biomesoplenty:gem:6>, <jaopca:item_nuggetsapphire>, <biomesoplenty:gem_block:6>, <jaopca:item_dustsapphire>,
  null, null, null, null, null,
  <jaopca:item_clustersapphire>, <jaopca:item_crystalshardsapphire>, <jaopca:item_crystalabysssapphire>, <jaopca:item_rockychunksapphire>,
  <jaopca:item_chunksapphire>, <jaopca:item_dustalchsapphire>, <jaopca:item_dirtygemsapphire>,
  <biomesoplenty:gem_ore:6>, null, <netherendingores:ore_end_modded_2:2>,
  null, null,
  <mysticalagriculture:sapphire_seeds>, <mysticalagriculture:sapphire_essence>,
  <aspect:vitreus>, <aspect:gelum>, <aspect:desiderium>);

// Tanzanite
addMetallurgicAspects
(1.0, 2.0, 4,
  <biomesoplenty:gem:4>, <jaopca:item_nuggettanzanite>, <biomesoplenty:gem_block:4>, <jaopca:item_dusttanzanite>,
  null, null, null, null, null,
  <jaopca:item_clustertanzanite>, <jaopca:item_crystalshardtanzanite>, <jaopca:item_crystalabysstanzanite>, <jaopca:item_rockychunktanzanite>,
  <jaopca:item_chunktanzanite>, <jaopca:item_dustalchtanzanite>, <jaopca:item_dirtygemtanzanite>,
  <biomesoplenty:gem_ore:4>, null, null,
  null, null,
  <mysticalagriculture:tanzanite_seeds>, <mysticalagriculture:tanzanite_essence>,
  <aspect:vitreus>, <aspect:vitium>, <aspect:desiderium>);

// Topaz
addMetallurgicAspects
(1.0, 2.0, 4,
  <biomesoplenty:gem:3>, <jaopca:item_nuggettopaz>, <biomesoplenty:gem_block:3>, <jaopca:item_dusttopaz>,
  null, null, null, null, null,
  <jaopca:item_clustertopaz>, <jaopca:item_crystalshardtopaz>, <jaopca:item_crystalabysstopaz>, <jaopca:item_rockychunktopaz>,
  <jaopca:item_chunktopaz>, <jaopca:item_dustalchtopaz>, <jaopca:item_dirtygemtopaz>,
  <biomesoplenty:gem_ore:3>, null, null,
  null, null,
  <mysticalagriculture:topaz_seeds>, <mysticalagriculture:topaz_essence>,
  <aspect:vitreus>, Aspect.imperium, <aspect:desiderium>);

// Trinitite
addMetallurgicAspects
(1.0, 2.0, 0,
  <trinity:trinitite_shard>, <jaopca:item_nuggettrinitite>, <trinity:solid_trinitite>, <jaopca:item_dusttrinitite>,
  null, null, null, null, null,
  <jaopca:item_clustertrinitite>, <jaopca:item_crystalshardtrinitite>, <jaopca:item_crystalabysstrinitite>, <jaopca:item_rockychunktrinitite>,
  <jaopca:item_chunktrinitite>, <jaopca:item_dustalchtrinitite>, <jaopca:item_dirtygemtrinitite>,
  <trinity:trinitite>, null, null,
  null, null,
  null, null,
  <aspect:vitreus>, Aspect.exitium, <aspect:desiderium>);

/*
 ██████╗ ████████╗██╗  ██╗███████╗██████╗
██╔═══██╗╚══██╔══╝██║  ██║██╔════╝██╔══██╗
██║   ██║   ██║   ███████║█████╗  ██████╔╝
██║   ██║   ██║   ██╔══██║██╔══╝  ██╔══██╗
╚██████╔╝   ██║   ██║  ██║███████╗██║  ██║
 ╚═════╝    ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
*/

// [Sanguis aspect] source
mods.bloodmagic.BloodAltar.addRecipe(
  <thaumcraft:phial:1>.withTag({Aspects: [{amount: 10, key: 'sanguis'}]}), // output
  <thaumcraft:phial>, // input
  1, // tier
  1000, // blood_essence_drain (how much essence crafting recipe require)
  20, // consume_rate (how fast it will take essence from altar)
  0); // drain_rate (how fast crafting process will decay if there is no blood in altar, 0 means no loss)

// [Mana aspect] source
mods.botania.ManaInfusion.addAlchemy(<thaumcraft:phial:1>.withTag({Aspects: [{amount: 10, key: 'mana'}]}), <thaumcraft:phial>, 5000);
