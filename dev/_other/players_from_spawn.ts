import fse from 'fs-extra'
import { parse as parseNbt } from 'prismarine-nbt'

import { globs } from '../build/build_utils'

const { readFileSync } = fse

// Get player data
const playerDataList = globs('E:/mc/BBOP-Extended/playerdata/*.dat')
const players = await Promise.all(playerDataList.map((filename) => {
  const p = parseNbt(readFileSync(filename))
  p.then(() => process.stdout.write('.'))
  return p
}))
const fromSpawn = players.map((decoded, i) => {
  const [x, _y, z] = (decoded.parsed.value.Pos.value as any).value
  const dist = Math.sqrt(x ** 2 + z ** 2) | 0
  if (dist > 100000) console.log('\n>100k :>> ', playerDataList[i])
  return dist
})
fromSpawn.sort((a, b) => a - b)
console.log('\nfrom spawn :>> ', fromSpawn.reverse())
