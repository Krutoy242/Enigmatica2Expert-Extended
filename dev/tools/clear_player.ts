#!/usr/bin/env node

/**
 * Backup and clear player data from a Minecraft server.
 */

import type { Buffer } from 'node:buffer'
import type { Compound, NBT } from 'prismarine-nbt'

import type { ConnectOptions } from 'ssh2-sftp-client'
import process from 'node:process'

import * as p from '@clack/prompts'
import chalk from 'chalk'
import { dirname, join as pathJoin } from 'pathe'
import * as nbt from 'prismarine-nbt'
import Client from 'ssh2-sftp-client'
import yargs from 'yargs'
import { hideBin } from 'yargs/helpers'
import { fs } from 'zx'

function loadJson(path: string): any {
  try {
    return fs.readJsonSync(path)
  }
  catch (error) {
    p.log.error(`Failed to load JSON from ${path}`)
    throw error
  }
}

interface TeamModification {
  newTeamNbt: NBT
  teamId    : string
}

interface TeamDataResult {
  filesToRemove             : string[]
  modifications             : TeamModification[]
  preModificationBackupPaths: string[]
}

async function handleTeamData(sftp: Client, mcRoot: string, worldName: string, playerName: string): Promise<TeamDataResult> {
  const s = p.spinner()
  s.start('Checking team data...')

  const initialResult = { filesToRemove: [], modifications: [], preModificationBackupPaths: [] }

  const playerDataPath = `data/ftb_lib/players/${playerName.toLowerCase()}.dat`
  let playerNbt: NBT | undefined
  try {
    // Try reading from original location
    const playerDataBuffer = await sftp.get(pathJoin(mcRoot, worldName, playerDataPath)) as Buffer
    const parsed = await nbt.parse(playerDataBuffer)
    playerNbt = parsed.parsed
  }
  catch {
    try {
      // If not found, try reading from backup location
      const backupPath = pathJoin(mcRoot, 'backups', playerName, playerDataPath)
      if (await sftp.exists(backupPath)) {
        s.message('Player .dat not in original location, reading from backup...')
        const backupDataBuffer = await sftp.get(backupPath) as Buffer
        const parsed = await nbt.parse(backupDataBuffer)
        playerNbt = parsed.parsed
      }
    }
    catch {
      s.stop(`Could not read player data at ${playerDataPath} or its backup. Skipping team removal.`)
      return initialResult
    }
  }

  if (!playerNbt) {
    s.stop('Could not find player .dat file. Skipping team removal.')
    return initialResult
  }

  const simplifiedPlayer = nbt.simplify(playerNbt) as Record<string, string | undefined>
  const teamId = simplifiedPlayer.TeamID
  if (!teamId) {
    s.stop('Player does not belong to a team.')
    return initialResult
  }
  s.message(`Player is in team: ${chalk.cyan(teamId)}`)

  const teamFilePath = `data/ftb_lib/teams/${teamId}.dat`
  const teamFileFullPath = pathJoin(mcRoot, worldName, teamFilePath)

  if (!await sftp.exists(teamFileFullPath)) {
    s.stop(`Team file for ${teamId} does not exist.`)
    return initialResult
  }

  const teamDataBuffer = await sftp.get(teamFileFullPath) as Buffer
  const { parsed: teamNbt } = await nbt.parse(teamDataBuffer)
  const simplifiedTeam = nbt.simplify(teamNbt) as Record<string, string | undefined>

  if (simplifiedTeam.Owner === playerName) {
    s.message(`Player is the ${chalk.yellow('owner')} of team ${chalk.cyan(teamId)}.`)
    s.stop(`Marking team ${chalk.cyan(teamId)} and its quest data for removal.`)
    return {
      ...initialResult,
      filesToRemove: [teamFilePath, `data/ftb_lib/teams/ftbquests/${teamId}.dat`],
    }
  }
  else {
    s.message(`Player is a member of team ${chalk.cyan(teamId)}.`)
    const playersCompound = teamNbt.value.Players as Compound
    // Check for player name case-insensitively
    const playerKey = Object.keys(playersCompound?.value ?? {}).find(k => k.toLowerCase() === playerName.toLowerCase())

    if (playerKey && playersCompound?.value) {
      delete playersCompound.value[playerKey]
      s.stop(`Marking team ${chalk.cyan(teamId)} for player removal.`)
      return {
        ...initialResult,
        modifications             : [{ teamId, newTeamNbt: teamNbt }],
        preModificationBackupPaths: [teamFilePath],
      }
    }
    s.stop(`Player not found in team ${chalk.cyan(teamId)}'s member list.`)
  }

  return initialResult
}

async function main() {
  const argv = await yargs(hideBin(process.argv))
    .scriptName('clear-player')
    .usage('$0 <name> <uuid>')
    .demandCommand(2, 2, 'Player name and UUID are required.', 'Too many arguments.')
    .strict()
    .help()
    .parse()

  const [name, uuid] = argv._ as [string, string]

  p.intro(`Processing player: ${chalk.yellow(name)} (${chalk.gray(uuid)})`)

  const sftp = new Client()
  let isConnected = false
  const config = loadJson('~secrets/sftp_servers/3. Saqult/sftp.json') as Record<string, unknown>
  const { mc_root: mcRoot, ...sftpConfig } = config as unknown as ConnectOptions & { mc_root: string }

  try {
    const s = p.spinner()
    s.start('Connecting to SFTP server...')
    await sftp.connect(sftpConfig)
    isConnected = true
    s.stop('SFTP connection established.')

    s.start('Reading server.properties to find world name...')
    const propsContentBuffer = await sftp.get(pathJoin(mcRoot, 'server.properties'))
    const propsContent = propsContentBuffer.toString('utf-8')

    const levelNameMatch = propsContent.match(/^level-name=(.*)$/m)
    if (!levelNameMatch || !levelNameMatch[1]) {
      throw new Error('Could not find a valid level-name in server.properties')
    }
    const worldName = levelNameMatch[1].trim()
    s.stop(`World folder identified: ${chalk.green(worldName)}`)

    const getFilePaths = (playerName: string, playerUUID: string) => [
      `advancements/${playerUUID}.json`,
      `data/ApiaristTracker.${playerUUID}.dat`,
      `data/ArboristTracker.${playerUUID}.dat`,
      `data/ftb_lib/players/${playerName.toLowerCase()}.dat`,
      `data/LepidopteristTracker.${playerUUID}.dat`,
      `data/POBox_player-${playerName}-${playerUUID}.dat`,
      `playerdata/${playerUUID}.astral`,
      `playerdata/${playerUUID}.astralback`,
      `playerdata/${playerUUID}.cosarmor`,
      `playerdata/${playerUUID}.cyclicinvo`,
      `playerdata/${playerUUID}.dat`,
      `playerdata/${playerUUID}.ocnm`,
      `playerdata/gamestages/${playerUUID}.dat`,
      `stats/${playerUUID}.json`,
    ]

    const { filesToRemove: teamFilesToRemove, modifications: teamModifications, preModificationBackupPaths }
      = await handleTeamData(sftp, mcRoot, worldName, name)

    let relativePaths = getFilePaths(name, uuid)
    relativePaths.push(...teamFilesToRemove)
    relativePaths = [...new Set(relativePaths)] // Ensure unique paths

    s.start('Locating player files...')
    const foundFiles: string[] = []
    const notFoundFiles: string[] = []
    for (const relativePath of relativePaths) {
      const fullPath = pathJoin(mcRoot, worldName, relativePath)
      if (await sftp.exists(fullPath)) {
        foundFiles.push(relativePath)
      }
      else {
        notFoundFiles.push(relativePath)
      }
    }
    s.stop('File search complete.')

    const filesToModifyList = teamModifications.map(m => `${chalk.yellow('~')} ${chalk.gray(`data/ftb_lib/teams/${m.teamId}.dat (removing player)`)}`).join('\n')
    const filesToRemoveList = foundFiles.map(f => `${chalk.green('✔')} ${chalk.gray(f)}`).join('\n')
    const notFoundList = notFoundFiles.map(f => `${chalk.red('✖')} ${chalk.gray(f)}`).join('\n')

    p.note(
      [filesToModifyList, filesToRemoveList, notFoundList].filter(Boolean).join('\n\n'),
      'File Actions Summary'
    )

    if (foundFiles.length === 0 && teamModifications.length === 0) {
      p.log.warn(`No data files found for player ${name}. Nothing to do.`)
      return
    }

    const shouldProceed = await p.confirm({
      message: 'Proceed with modifications, backups, and removals?',
    })

    if (!shouldProceed) {
      p.cancel('Operation cancelled.')
      return
    }

    const backupRoot = `backups/${name}`
    const filesToBackup = [...new Set([...foundFiles, ...preModificationBackupPaths])]

    if (filesToBackup.length > 0) {
      s.start(`Backing up ${filesToBackup.length} files to ${backupRoot}...`)
      for (const relativePath of filesToBackup) {
        const sourceFile = pathJoin(mcRoot, worldName, relativePath)
        const backupPath = pathJoin(backupRoot, relativePath)

        if (!await sftp.exists(sourceFile)) continue

        await sftp.mkdir(pathJoin(mcRoot, dirname(backupPath)), true)

        const fileContent = await sftp.get(sourceFile) as Buffer
        await sftp.put(fileContent, pathJoin(mcRoot, backupPath))
        s.message(`Backing up... ${chalk.green(relativePath)}`)
      }
      s.stop(`Backup complete. ${filesToBackup.length} files backed up.`)
    }

    if (teamModifications.length > 0) {
      s.start('Applying team modifications...')
      for (const mod of teamModifications) {
        const teamFilePath = pathJoin(mcRoot, worldName, 'data/ftb_lib/teams', `${mod.teamId}.dat`)
        const modifiedBuffer = nbt.writeUncompressed(mod.newTeamNbt)
        await sftp.put(modifiedBuffer, teamFilePath)
        s.message(`Modified team: ${chalk.cyan(mod.teamId)}`)
      }
      s.stop('Team modifications complete.')
    }

    if (foundFiles.length > 0) {
      s.start('Removing original files...')
      for (const relativePath of foundFiles) {
        const sourceFile = pathJoin(mcRoot, worldName, relativePath)
        await sftp.delete(sourceFile)
        s.message(`Removing... ${chalk.red(relativePath)}`)
      }
      s.stop(`Removal complete. ${foundFiles.length} files removed.`)
    }

    p.outro(chalk.green('All player data has been backed up and cleared successfully.'))
  }
  catch (err) {
    p.log.error((err as Error).message)
    process.exit(1)
  }
  finally {
    if (isConnected) {
      await sftp.end()
      p.log.info('SFTP connection closed.')
    }
  }
}

main().catch((err) => {
  p.log.error((err as Error).message)
  process.exit(1)
})
