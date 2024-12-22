/**
 * Collect top player stats from a server
 */

import { parse } from 'node:path'

import fast_glob from 'fast-glob'

import { getBoxForLabel } from '../build/build_utils'
import {
  loadJson,
  saveText,
} from '../lib/utils.js'

const updateBox = getBoxForLabel('sftp')

const uuidName = loadJson('E:/mc/usernamecache.json') as { [uuid: string]: string }

const list = fast_glob.sync(['E:/mc/stats/*.json'])

const bestStats = {} as { [key: string]: [string, number][] }

let k = 0
for (const f of list) {
  const stat = loadJson(f) as { [key: string]: number }
  updateBox('Loaded: ', ++k, '/', list.length)
  const uuid = parse(f).name
  const playerName = uuidName[uuid] ?? uuid.split('-').shift()

  for (const [key, value] of Object.entries(stat)) {
    // if (bestStats[key]?.[1] >= value) continue
    // bestStats[key] = [playerName, value]
    (bestStats[key] ??= []).push([playerName, value])
  }
}

const sortedStats = Object.entries(bestStats)
  .map(([k, v]) => [
    k.replace(/stat\./, ''),
    v.sort(([,a], [,b]) => b - a)
      .slice(0, 3),
  ] as [string, [string, number][]])
  .filter(([,[[,v]]]) => v > 0)
  .filter(([k]) => !['pickup', 'useItem', 'mineBlock', 'craftItem', 'drop', 'killEntity', 'entityKilledBy'].some(s => k.startsWith(s)))
  .sort(([,[[,a]]], [,[[,b]]]) => b - a)

saveText(
  `Key,Player1,Player2,Player3
${
  sortedStats
  .map(([k, arr]) => `${k},${arr.map(([p, v]) => `[${p}] ${v}`).join(',')}`)
  .join('\n')}`,
  '~stats.csv'
)

updateBox('Done!')
process.exit(0)
