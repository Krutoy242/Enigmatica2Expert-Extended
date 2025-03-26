/*

Add icons to rewards with >1 amount.

The problem is when FTBQuest reward table have many item in one slot, it
wont show the amount of those items, only icon of a single.

This will explicitely add icons with correct amounts.

*/

import FastGlob from 'fast-glob'
import fse from 'fs-extra'

import { parseFtbqSNbt, stringifyFTBQSNbt } from '../../mc-tools/packages/utils/src/mods/ftbquests'

const { readFileSync, writeFileSync } = fse

async function matchCountOfRewards() {
  (await FastGlob('config/ftbquests/normal/reward_tables/*.snbt')).forEach((f) => {
    const table = parseFtbqSNbt(readFileSync(f, 'utf8')) as any

    let hasChanges = false
    if (!table?.rewards) return
    for (const reward of table?.rewards) {
      if (
        !reward?.item?.id
        || !reward?.count
        || reward?.count <= 1
        || reward?.icon?.Count?.value === reward?.count?.value
      ) {
        continue
      }
      reward.icon = {...reward.item}
      reward.icon.Count = reward.count
      hasChanges = true
    }

    if (hasChanges) {
      writeFileSync(f, stringifyFTBQSNbt(table))
    }
  })
}

await matchCountOfRewards()
