import type Client from 'ssh2-sftp-client'

import * as p from '@clack/prompts'
import chalk from 'chalk'

import { getBoxForLabel } from '../../build/build_utils'

export async function pruneWorld(
  sftp: Client,
  config: {
    maxDistanceFromSpawn: number
    obsoleteMonths      : number
    region              : string
    title               : string
  }
) {
  let updateBox = getBoxForLabel(`Prunning ${config.title}`)
  updateBox('Getting list')
  const regions = await sftp.list(`/BBOP-Extended/${config.region}`)
  updateBox('Connected!')

  function fileSizeText(size:number) {
    return `${(size / 1048576) | 0}mb`
  }

  async function pruneTask(taskName:string, predicate: (f:Client.FileInfo)=>boolean) {
    const pruneData = filterForPrunning(regions, predicate)

    updateBox = getBoxForLabel(taskName)
    updateBox(
      chalk.gray`Filtering / Total:`,
      chalk.green(pruneData.list.length),
      chalk.gray`/`,
      `${chalk.green(regions.length)}\n`,
      chalk.gray`Total size: `,
      `${chalk.green(fileSizeText(pruneData.size))}`
    )

    if (await p.confirm({message: 'Press ENTER to remove filtered regions. Press ESC to skip.'})) {
      updateBox = getBoxForLabel(`Task: ${chalk.yellow`Remove Overworld regions`}`)
      await removeFilesOnServer(
        sftp,
        pruneData.list.map(f => `/BBOP-Extended/${config.region}/${f}`),
        fileCounter => updateBox('Removing files', fileCounter, '/', pruneData.list.length),
        updateBox
      )
      return pruneData.list
    }
  }

  /************************************************
  * Remove distant regions
  ************************************************/
  const removed = await pruneTask(`Prune by distance >${config.maxDistanceFromSpawn}`, (f) => {
    const [x, z] = f.name.split('.').slice(1, 3).map(Number)
    return Math.sqrt(x * x + z * z) > config.maxDistanceFromSpawn / 512
  })

  /************************************************
  * Remove unupdated regions
  ************************************************/
  const currentDate = new Date().valueOf()
  await pruneTask(`Prune if older ${config.obsoleteMonths} month`, (f) => {
    if (removed?.includes(f.name)) return false
    const monthsPast = new Date(currentDate - f.modifyTime).getMonth()
    return monthsPast >= config.obsoleteMonths
  })
}

export function filterForPrunning(list: Client.FileInfo[], predicate: (f:Client.FileInfo)=>boolean) {
  let pruneTotalSize = 0
  const filtered = list
    .filter((f) => {
      const toRemoval = predicate(f)
      if (toRemoval) pruneTotalSize += f.size
      return toRemoval
    })
    .map(f => f.name)
    .sort()
  return {
    list: filtered,
    size: pruneTotalSize,
  }
}

export async function removeFilesOnServer(
  sftp:Client,
  list: string[],
  onRemove: (fileCounter: number)=>void,
  log:(...args: any[]) => void
) {
  log('Removing files: ', '0', '/', list.length)

  let fileCounter = 0
  await Promise.all(list.map(async (f) => {
    const p = sftp.delete(f)
    p.then(() => onRemove(++fileCounter))
    return p
  }))

  log('Removed files: ', fileCounter)
}
