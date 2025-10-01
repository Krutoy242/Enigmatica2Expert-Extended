/**
 * @file Gather information about 'purged' items from crafttweaker.log
 * to add them into `jei/itemBlacklist.cfg`
 * Also, sorts and cleanup jei blacklist
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

// @ts-check

import process from 'node:process'

import fse from 'fs-extra'
import { globSync } from 'tinyglobby'

import { getPurged, getSubMetas } from '../lib/tellme.js'
import {
  config,
  defaultHelper,
  getCSV,
} from '../lib/utils.js'

const { readFileSync, writeFileSync} = fse

export async function init(h = defaultHelper) {
  await h.begin('Get files')
  const jeiConfigPath = 'config/jei/itemBlacklist.cfg'
  const purged = new Set([...getPurged()].map((s) => {
    let [, source, meta] = s?.match(/<([^:]+:[^:]+)(:(\d+|\*))?>/) ?? []
    if (meta === ':*') meta = ''
    return source + (meta ?? ':0')
  }))

  /** @type {string[]} */
  const pure = []

  const modList = getCSV(globSync('config/tellme/mod-list-csv*.csv')[0])
  const itemsCsv = getCSV(globSync('config/tellme/items-csv*.csv')[0])
  const definitions = Object.fromEntries(itemsCsv.map(o => [o['Registry name'], true]))

  /** @type {string[]} */
  const merged = [...config(jeiConfigPath).advanced.itemBlacklist, ...purged]

  await h.begin('Looking for wildcarable')
  merged.forEach((s, i) => {
    const [source, name, meta, ...rest] = s.split(':')
    if (!meta || rest.length || meta !== '0') return
    const id = `${source}:${name}`
    if (getSubMetas(id).length > 1) return
    merged[i] = id
  })

  await h.begin(`Fixing blacklist with ${merged.length} entries`)
  merged.forEach((s, i) => {
    // If duplicate
    const next = merged.slice(i + 1)
    if (next.includes(s)) return

    // If wildcarded
    /** @type {string} */
    // @ts-expect-error undef
    const defMetaed = s.match(/([^:]+:[^:]+)[:;].+/)?.[1]
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
  } catch (error) {
    h.error(error)
  }

  h.result(
    `Purged / Manually Blacklisted: ${purged.size} / ${
      pure.length - purged.size
    }`
  )
}

if (
  import.meta.url === (await import('node:url')).pathToFileURL(process.argv[1]).href
)
  init()
