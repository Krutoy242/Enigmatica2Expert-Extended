import { globSync } from 'tinyglobby'

import { config, getCSV, loadText, naturalSort } from './utils.js'

let isBlocks: Set<string> | undefined
export function isBlock(itemID: string): boolean {
  return (isBlocks ??= new Set(
    (getCSV(globSync('config/tellme/blocks-csv*.csv')[0]) as Record<string, string>[]).map(o => o['Registry name'])
  )).has(itemID)
}

let existOreDicts: Set<string> | undefined
export function isODExist(oreName: string): boolean {
  return (existOreDicts ??= new Set(
    (getCSV(globSync('config/tellme/items-csv*.csv')[0]) as Record<string, string>[])
      .map(o => o['Ore Dict keys'].split(','))
      .flat()
  )).has(oreName)
}

let existItems: Set<string> | undefined
export function isItemExist(id: string): boolean {
  return (existItems ??= new Set(
    (getCSV(globSync('config/tellme/items-csv*.csv')[0]) as Record<string, string>[]).map(o => o['Registry name'])
  )).has(id.split(':').slice(0, 2).join(':'))
}

let existFluids: Set<string> | undefined
export function isFluidExist(id: string): boolean {
  return (existFluids ??= new Set(
    (getCSV(globSync('config/tellme/fluids-csv*.csv')[0]) as Record<string, string>[]).map(o => o.Name)
  )).has(id)
}

let jeiBlacklist: Set<string> | undefined
export function isJEIBlacklisted(def: string, meta?: string): boolean {
  return (
    (jeiBlacklist ??= new Set(
      (config('config/jei/itemBlacklist.cfg')?.advanced as Record<string, any>).itemBlacklist as string[]
    )).has(def) || jeiBlacklist.has(`${def}:${meta ?? '0'}`)
  )
}

const amountRgx = / \* \d+/
export function isPurged(ctCapture: string): boolean {
  const capNoAmount = ctCapture.replace(amountRgx, '')
  return getPurged().has(capNoAmount) || getPurged().has(capNoAmount.replace(':0>', '>'))
}

let purgedSet: Set<string> | undefined
const purgeRgx = /^\[INITIALIZATION\]\[CLIENT\]\[INFO\] purged: (.*)$/gm
const purgeMatchRgx = /(<[^>]+>(?:\.withTag\(.*\))?)/
export function getPurged(): Set<string> {
  return purgedSet ??= new Set(
    Array.from(loadText('crafttweaker.log').matchAll(purgeRgx), m => m[1])
      .map(s => s.match(purgeMatchRgx)?.[1])
      .filter((s): s is string => Boolean(s))
  )
}

let itemsTree: Record<string, Record<string, Set<string>>> | undefined

export function getItemsTree() {
  return itemsTree ??= (getCSV(globSync('config/tellme/items-csv*.csv')[0]) as Record<string, string>[]).reduce(
    (result, o) => {
      (result[o['Registry name']] ??= {})[o['Meta/dmg']] = new Set(
        o['Ore Dict keys'].split(',')
      )
      return result
    },
    {} as Record<string, Record<string, Set<string>>>
  )
}

export function getItemOredictSet(id: string, meta = '0'): Set<string> {
  return (getItemsTree()[id] ??= {})[meta === '*' ? '0' : meta] ??= new Set()
}

export function getSubMetas(definition: string): number[] {
  return Object.keys(getItemsTree()[definition] ??= {}).map(s => Number(s))
}

export interface TMStack {
  mod          : string
  id           : string
  itemId       : number
  damage       : number
  hasSubtypes  : boolean
  display      : string
  ores         : string[]
  owner        : string
  commandString: string
  withAmount   : (multiplier: number) => string
}

const getByOredict_memo: Record<string, TMStack[]> = {}

export function getByOredict(ore: string): TMStack[] {
  return getByOredict_memo[ore] ??= getOresByRegex(new RegExp(`^${ore}$`, 'i'))
}

export function getByOreBase(oreBase: string): Record<string, TMStack> {
  return getByOreRgx(new RegExp(`^(\\w+)${oreBase}$`))
}

export function getByOreKind(kindKey: string): Record<string, TMStack> {
  return getByOreRgx(new RegExp(`^${kindKey}([A-Z]\\w+)$`))
}

export function getOreBases_byKinds(kindKeys: string[]): string[] {
  let entries = Object.entries(getByOreKind(kindKeys[0]))
  kindKeys.slice(1).forEach((kindKey) => {
    entries = entries.filter(([oreBase]) => isODExist(kindKey + oreBase))
  })

  return entries.map(([b]) => b)
}

function getByOreRgx(rgx: RegExp): Record<string, TMStack> {
  const result: Record<string, TMStack[]> = {}
  getOresByRegex(rgx).forEach((tm) => {
    const oreKinds = tm.ores
      .filter(s => rgx.test(s))
      .map(s => s.replace(rgx, '$1'))
    for (const oreKind of oreKinds)
      (result[oreKind] ??= []).push(tm)
  })

  return Object.fromEntries(Object.entries(result).map(([k, v]) => [k, v.sort(prefferedModSort)[0]]))
}

let oresMap: Map<string, TMStack[]> | undefined

const getOresByRegexHash: Record<string, TMStack[]> = {}

function getOresByRegex(rgx: RegExp): TMStack[] {
  if (!oresMap) {
    oresMap = new Map()
    ;(getCSV(globSync('config/tellme/items-csv*.csv')[0]) as Record<string, string>[])
      .filter(o => o['Ore Dict keys'])
      .map(tellmeToObj)
      .forEach((o) => {
        o.ores.forEach((ore) => {
          oresMap!.set(ore, (oresMap!.has(ore) ? oresMap!.get(ore)! : []).concat(o))
        })
      })
  }

  const old = getOresByRegexHash[rgx.source]
  if (old) return old

  const list = new Set<TMStack>()
  for (const [key, ores] of oresMap) {
    if (rgx.test(key)) ores.forEach(it => list.add(it))
  }

  const result = [...list]
  getOresByRegexHash[rgx.source] = result
  return result
}

function tellmeToObj(o: Record<string, string>): TMStack {
  return {
    mod          : o['Mod name'],
    owner        : o['Registry name'].split(':')[0],
    id           : o['Registry name'],
    itemId       : Number(o['Item ID']),
    damage       : Number(o['Meta/dmg']),
    hasSubtypes  : o.Subtypes === 'true',
    display      : o['Display name'],
    ores         : o['Ore Dict keys'].split(','),
    commandString: `<${o['Registry name']}${o['Meta/dmg'] === '0' ? '' : `:${o['Meta/dmg']}`
    }>`,
    withAmount(this: TMStack, amount: number) {
      return this.commandString + (amount > 1 ? ` * ${amount}` : '')
    },
  }
}

export function getByOredict_first(ore: string): TMStack {
  return getByOredict(ore).sort(prefferedModSort)[0]
}

const modWeights: Record<string, number> = `
  minecraft
  thermalfoundation
  immersiveengineering
  ic2
  mekanism
  appliedenergistics2
  actuallyadditions
  tconstruct
  chisel
  biomesoplenty
  nuclearcraft
  draconicevolution
  libvulpes
  astralsorcery
  rftools
  extrautils2
  forestry
  bigreactors
  enderio
  exnihilocreatio
`
  .trim()
  .split('\n')
  .map(l => l.trim())
  .reverse()
  .reduce((map, v, i) => {
    map[v] = i
    return map
  }, {} as Record<string, number>)

export function prefferedModSort(a: TMStack | string | undefined, b: TMStack | string | undefined): number {
  const ownerA = typeof a === 'string' ? a : a?.owner
  const ownerB = typeof b === 'string' ? b : b?.owner
  const va = ownerB ? (modWeights[ownerB] ?? 0) : 0
  const vb = ownerA ? (modWeights[ownerA] ?? 0) : 0
  return va > vb ? 1 : va < vb ? -1 : 0
}

export interface FurnaceRecipe {
  output    : string
  out_id    : string
  out_meta  : string
  out_tail  : string
  out_tag   : string
  out_amount: string
  input     : string
  in_id     : string
  in_meta   : string
  in_tail   : string
  in_tag    : string
  in_amount : string
}

const furnaceRecipeRgx = /^furnace\.addRecipe\((?<output><(?<out_id>[^>]+?)(?::(?<out_meta>\*|\d+))?>(?<out_tail>(?:\.withTag\((?<out_tag>\{.*?\})\))?(?: \* (?<out_amount>\d+))?)), (?<input><(?<in_id>[^>]+?)(?::(?<in_meta>\*|\d+))?>(?<in_tail>(?:\.withTag\((?<in_tag>\{.*?\})\))?(?: \* (?<in_amount>\d+))?)), .+\)$/gm

function matchFurnaceRecipes(text: string): FurnaceRecipe[] | undefined {
  if (!text) return undefined
  return Array.from(text.matchAll(furnaceRecipeRgx), m => m.groups as unknown as FurnaceRecipe)
    .sort((a, b) => naturalSort(a.input, b.input))
}

export function getCrtLogBlock(from: string, to: string): string {
  const text = loadText('crafttweaker.log')
  const startIndex = text.lastIndexOf(from)
  if (startIndex === -1) return ''

  const sub = text.substring(startIndex + from.length)
  const endIndex = sub.indexOf(to)

  return endIndex === -1 ? sub : sub.substring(0, endIndex)
}

let furnaceRecipesHashed: FurnaceRecipe[] | undefined
export function getFurnaceRecipes(): FurnaceRecipe[] | undefined {
  return furnaceRecipesHashed ??= matchFurnaceRecipes(
    getCrtLogBlock('\nFurnace Recipes:', '\nRecipes:')
  )
}

let furnaceRecipesUnchangedHashed: FurnaceRecipe[] | undefined
const initClientFurnaceRgx = /\[INITIALIZATION\]\[CLIENT\]\[INFO\] (furnace\.addRecipe\(.+)/
export function getUnchangedFurnaceRecipes(): FurnaceRecipe[] | undefined {
  if (furnaceRecipesUnchangedHashed) return furnaceRecipesUnchangedHashed

  const subSub = getCrtLogBlock(
    '#         Unchanged furnace recipes dump         #',
    '##################################################'
  )
  if (!subSub) return undefined

  return furnaceRecipesUnchangedHashed = matchFurnaceRecipes(
    subSub
      .split('\n')
      .map(
        s =>
          s.match(initClientFurnaceRgx)?.[1]
      )
      .filter((s): s is string => Boolean(s))
      .join('\n')
  )
}

export function smelt(tm: TMStack): TMStack | undefined {
  const r = getFurnaceRecipes()?.find(
    r => r.input.replace(':*', '') === tm.commandString
  )
  if (!r) return undefined

  const item = (getCSV(globSync('config/tellme/items-csv*.csv')[0]) as Record<string, string>[])
    .find(o => o['Registry name'] === r.out_id && o['Meta/dmg'] === (r.out_meta ?? '0'))
  return item ? tellmeToObj(item) : undefined
}

export function smeltOre(ore: string): TMStack | undefined {
  for (const tm of getByOredict(ore)) {
    const smelted = smelt(tm)
    if (smelted) return smelted
  }
}

const baseMultiplier: Record<string, number> = {
  Amber              : 2,
  Amethyst           : 2,
  Apatite            : 10,
  Aquamarine         : 4,
  CertusQuartz       : 3,
  ChargedCertusQuartz: 2,
  Coal               : 5,
  Diamond            : 2,
  DimensionalShard   : 3,
  Emerald            : 2,
  Glowstone          : 4,
  Lapis              : 10,
  Malachite          : 2,
  Peridot            : 2,
  Quartz             : 3,
  QuartzBlack        : 2,
  quicksilver        : 2,
  Redstone           : 10,
  Ruby               : 2,
  Sapphire           : 2,
  Tanzanite          : 2,
  Topaz              : 2,
}

export function countBaseOutput(oreBase: string, multiplier: number): number {
  const d = baseMultiplier[oreBase]
  if (d) return Math.min(64, d * multiplier)

  return multiplier
}

export function getSomething(ore_base: string, kindKeys: string[], blacklist: string[] = []): TMStack | undefined {
  const dict = getByOreBase(ore_base)
  blacklist.forEach(key => delete dict[key])
  for (const kind of kindKeys) {
    if (dict[kind]) return dict[kind]
  }

  for (const kind of ['ore', 'ingot', 'dust']) {
    const smelted = smeltOre(kind + ore_base)
    if (smelted) return smelted
  }

  if (kindKeys.includes('any')) return Object.values(dict)[0]
}

export interface TableRecipe {
  shape     : string
  name      : string
  output    : string
  out_id    : string
  out_meta  : string
  out_tail  : string
  out_tag   : string
  out_amount: string
  input     : string
}

const tableRecipeRgx = /^recipes\.(?<shape>addShape(?:d|less))\("(?<name>[^"]+)", (?<output><(?<out_id>[^>]+?)(?::(?<out_meta>\*|\d+))?>(?<out_tail>(?:\.withTag\((?<out_tag>\{.*?\})\))?(?: \* (?<out_amount>\d+))?)), (?<input>\[.*\])\);$/gm

function matchTableRecipes(text: string): TableRecipe[] | undefined {
  if (!text) return undefined
  return Array.from(text.matchAll(tableRecipeRgx), m => m.groups as unknown as TableRecipe)
    .sort(({ output: a }, { output: b }) => naturalSort(a, b))
}

let tableRecipesCache: TableRecipe[] | undefined
export function getTableRecipes(): TableRecipe[] | undefined {
  return tableRecipesCache ??= matchTableRecipes(
    getCrtLogBlock('\nRecipes:', '\n[SERVER_STARTED]')
  )
}

let tableUnchangedRecipes: TableRecipe[] | undefined
const subRgx = /\[INITIALIZATION\]\[CLIENT\]\[INFO\] (recipes\.addShape.+)/
export function getUnchangedTableRecipes(): TableRecipe[] | undefined {
  if (tableUnchangedRecipes) return tableUnchangedRecipes

  const subSub = getCrtLogBlock(
    '#       Unchanged Crafting Table recipes         #',
    '##################################################'
  )
  if (!subSub) return undefined

  return tableUnchangedRecipes = matchTableRecipes(
    subSub
      .split('\n')
      .map(s => s.match(subRgx)?.[1])
      .filter((s): s is string => Boolean(s))
      .join('\n')
  )
}

let cachedRemovedRecipes: TableRecipe[] | undefined
export function getRemovedRecipes(): TableRecipe[] | undefined {
  if (cachedRemovedRecipes) return cachedRemovedRecipes

  const tblSet = new Set(getTableRecipes()?.map(r => r.name))
  return cachedRemovedRecipes = getUnchangedTableRecipes()?.filter(
    r => !tblSet.has(r.name)
  )
}
