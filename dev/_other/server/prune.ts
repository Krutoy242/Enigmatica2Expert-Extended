/* eslint-disable antfu/no-top-level-await */
/**
 * Find too far regions on server using SFTP and remove them
 *
 * Also show players positions
 */

import * as p from '@clack/prompts'
import chalk from 'chalk'
import Client from 'ssh2-sftp-client'

import { getBoxForLabel } from '../../build/build_utils'
import {
  loadJson,
} from '../../lib/utils.js'
import { filterForPrunning, pruneWorld, removeFilesOnServer } from './world'

let updateBox = getBoxForLabel('sftp')

const sftp = new Client()

const sftpConfig = loadJson('~secrets/sftp_servers/2. Guncolony/sftp.json') as { [key: string]: string }

/************************************************
* Getting info
************************************************/
updateBox('Connecting')
await sftp.connect(sftpConfig)

await pruneWorld(sftp, {
  title               : 'Overworld',
  region              : 'region',
  maxDistanceFromSpawn: 20000,
  obsoleteMonths      : 6,
})

await pruneWorld(sftp, {
  title               : 'The Nether',
  region              : 'DIM-1/region',
  maxDistanceFromSpawn: 5000,
  obsoleteMonths      : 6,
})

await pruneWorld(sftp, {
  title               : 'The End',
  region              : 'DIM1/region',
  maxDistanceFromSpawn: 5000,
  obsoleteMonths      : 6,
})

await pruneWorld(sftp, {
  title               : 'Twilight Forest',
  region              : 'DIM7/region',
  maxDistanceFromSpawn: 10000,
  obsoleteMonths      : 6,
})

await pruneWorld(sftp, {
  title               : 'Deep Dark',
  region              : 'DIM-11325/region',
  maxDistanceFromSpawn: 1000,
  obsoleteMonths      : 3,
})

await pruneWorld(sftp, {
  title               : 'Ratlantis',
  region              : 'DIM-8/region',
  maxDistanceFromSpawn: 3000,
  obsoleteMonths      : 3,
})

/************************************************
* Remove useless dimensions
************************************************/
updateBox = getBoxForLabel('Prune dimensions')
updateBox('Getting list')
const advRocketryDims = filterForPrunning(await sftp.list('/BBOP-Extended/advRocketry'), f => f.name.startsWith('DIM') && f.name !== 'DIM-2')

updateBox(
  'AR dimension to remove: ',
  advRocketryDims.list.map(f => chalk.green(f.substring(3))).join(chalk.gray(', '))
)

if (await p.confirm({message: 'Press ENTER to remove ALL AdvRock dimensions except Space Stations. Press ESC to skip.'})) {
  updateBox = getBoxForLabel(`Task: ${chalk.yellow`Remove Adv. Rocketry worlds`}`)
  await removeFilesOnServer(
    sftp,
    advRocketryDims.list.map(f => `/BBOP-Extended/advRocketry/${f}`),
    fileCounter => updateBox('Removing files', fileCounter, '/', advRocketryDims.list.length),
    updateBox
  )
}

/************************************************
* Done
************************************************/
updateBox = getBoxForLabel('sftp')
updateBox('Done!')
await sftp.end()
process.exit(0)
