/**
 * @file Gather information about 'purged' items from crafttweaker.log
 * to add them into `jei/itemBlacklist.cfg`
 * Also, sorts and cleanup jei blacklist
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

import { consola } from 'consola'
import fse from 'fs-extra'
import { globSync } from 'tinyglobby'

import { getPurged, getSubMetas } from '../lib/tellme.js'
import {
  config,
  getCSV,
} from '../lib/utils.js'

const { readFileSync, writeFileSync } = fse

const ITEM_REGEX = /<([^:]+:[^:]+)(:(\d+|\*))?>/
const WILDCARD_REGEX = /([^:;]+:[^:;]+)[:;].+/

interface ModListItem {
  ModID: string
}

interface ItemCsvItem {
  'Registry name': string
}

export async function init() {
  consola.start('Get files')
  const jeiConfigPath = 'config/jei/itemBlacklist.cfg'
  const purged = new Set(Array.from(getPurged(), (s) => {
    let [, source, meta] = s?.match(ITEM_REGEX) ?? []
    if (meta === ':*') meta = ''
    return source + (meta ?? ':0')
  }))

  const pure: string[] = []

  const modList = getCSV(globSync('config/tellme/mod-list-csv*.csv')[0]) as ModListItem[]
  const itemsCsv = getCSV(globSync('config/tellme/items-csv*.csv')[0]) as ItemCsvItem[]
  const definitions: Record<string, boolean> = Object.fromEntries(itemsCsv.map(o => [o['Registry name'], true]))

  const cfg = config(jeiConfigPath)
  // eslint-disable-next-line ts/no-unsafe-assignment, ts/no-unsafe-member-access
  const merged: string[] = [...cfg?.advanced?.itemBlacklist ?? [], ...purged]

  consola.start('Looking for wildcarable')
  merged.forEach((s, i) => {
    const [source, name, meta, ...rest] = s.split(':')
    if (!meta || rest.length || meta !== '0') return
    const id = `${source}:${name}`
    // eslint-disable-next-line ts/no-unsafe-call
    if (((getSubMetas as any)(id) as unknown[]).length > 1) return
    merged[i] = id
  })

  consola.start(`Fixing blacklist with ${merged.length} entries`)
  merged.forEach((s, i) => {
    // If duplicate
    const next = merged.slice(i + 1)
    if (next.includes(s)) return

    // If wildcarded
    const defMetaed = s.match(WILDCARD_REGEX)?.[1]
    if (defMetaed && merged.includes(defMetaed)) return

    // If definition doesnt exist
    const splitted = s.split(':')
    const mod = splitted[0]
    const def = splitted.slice(0, 2).join(':')
    if (mod !== 'fluid' && mod !== 'gas') {
      // If mod not exist
      if (!modList.some(m => m.ModID === mod)) return

      // Item not exist
      if (!definitions[def]) return
    }

    pure.push(s)
  })

  const table = pure.map(s => `        ${s}`)
  const configLines = readFileSync(jeiConfigPath, 'utf-8').split('\n')
  const headerHeight = 12
  configLines.splice(headerHeight, configLines.length - headerHeight - 3, ...table)
  try {
    writeFileSync(jeiConfigPath, configLines.join('\n'))
  }
  catch (error) {
    consola.error(error instanceof Error ? error : new Error(String(error)))
  }

  consola.success(
    `Purged / Manually Blacklisted: ${purged.size} / ${
      pure.length - purged.size
    }`
  )
}

if (import.meta.main) void init()
