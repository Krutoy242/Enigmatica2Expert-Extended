/* eslint-disable antfu/no-top-level-await */
import process from 'node:process'

import { consola } from 'consola'
import logUpdate from 'log-update'
import { join, parse } from 'pathe'
import { replaceInFileSync } from 'replace-in-file'
import Client from 'ssh2-sftp-client'
import { $, fs, glob } from 'zx'

import { confirm, getBoxForLabel } from './build_utils'

const { readFileSync, writeFileSync, unlinkSync, existsSync} = fs

export async function manageSFTP(serverSetupConfig: string = 'server/server-setup-config.yaml') {
  const sftpList = await glob('~secrets/sftp_servers/*/sftp.json')
  if (!sftpList.length) consola.warn('No SFTP servers found')

  const sftpConfigs = sftpList.map((filename) => {
    const dir = parse(filename).dir
    return {
      dir,
      label : dir.split('/').pop(),
      config: JSON.parse(readFileSync(filename, 'utf8')) as { [key: string]: string },
    }
  })

  const currentVersion = await $`git describe --tags --abbrev=0`.text()

  const serverConfigTmp = '~tmp-server-setup-config.yaml'
  const confText = readFileSync(serverSetupConfig, 'utf8')
    .replace(
      /(additionalFiles:\s*)\n {4}\S.*\n {4}\S.*$/m,
      `$1
    - url: https://mediafilez.forgecdn.net/files/5370/660/mc2discord-forge-1.12.2-3.3.2.jar
      destination: mods/mc2discord-forge-1.12.2-3.3.2.jar`
    )
    .replace(
      /(localFiles:\s*)\n +\S.*\n +\S.*$/m,
      `$1
    - from: overrides/
      to: .`
    )
  writeFileSync(serverConfigTmp, confText)

  for (const conf of sftpConfigs) {
    if (!await confirm(`Upload SFTP ${conf.label}?`)) continue

    const sftp = new Client()
    const updateBox = getBoxForLabel(conf.label || '')

    updateBox('Establishing connection')
    try {
      await sftp.connect(conf.config)
    }
    catch (error) {
      logUpdate.done()
      consola.error(`Cant connect to SFTP: ${error}`)
      continue
    }

    if (conf.config.offline) {
      const offlineConfigTmp = `~${serverConfigTmp}`
      const zipRgx = `https:\/\/github.com\/Krutoy242\/Enigmatica2Expert-Extended\/releases\/download\/[^/]+\/`
      const zipName = confText.match(new RegExp(`${zipRgx}(.+)`))?.[1]
      const zipPath = join('dist', zipName || '')
      if (!zipName || !existsSync(zipPath)) {
        logUpdate.done()
        consola.warn('Cannot find modpack zip path:', zipPath)
      }
      else {
        writeFileSync(offlineConfigTmp, confText.replace(
          new RegExp(zipRgx),
          'file://'
        ))
        updateBox(`[Upload Offline mode]`, `\n${offlineConfigTmp}\n${zipPath}`)
        await Promise.all([
          sftp.fastPut(offlineConfigTmp, 'server-setup-config.yaml'),
          sftp.fastPut(zipPath, zipName),
        ])
        unlinkSync(offlineConfigTmp)
      }
    }
    else {
      updateBox(`Copy ${serverConfigTmp}`)
      await sftp.fastPut(serverConfigTmp, 'server-setup-config.yaml')
    }

    updateBox('Change and copy server overrides')
    const title = `+ Server Started! +`
    const spaces = ' '.repeat(Math.max(1, (title.length - currentVersion.length) / 2) | 0)
    const replaceResult = replaceInFileSync({
      files       : join(conf.dir, 'overrides/config/mc2discord.toml'),
      from        : /(start\s*=\s*")[^"]+"/,
      to          : `$1\`\`\`diff\\n${title}\\n${spaces}${currentVersion}\\n\`\`\`"`,
      countMatches: true,
      disableGlobs: true,
    })

    updateBox('Remove', 'serverstarter.lock')
    await sftp.delete('serverstarter.lock', true)

    if (replaceResult.length === 0)
      throw new Error('Nothing replaced! Code failure')

    let fileCounter = 0
    sftp.on('upload', () => updateBox('Copy overrides', ++fileCounter))
    await sftp.uploadDir(join(conf.dir, 'overrides'), 'overrides/')

    await sftp.end()
  }

  unlinkSync(serverConfigTmp)
}

// Launch file
if (import.meta.url === (await import('node:url')).pathToFileURL(process.argv[1]).href) {
  await manageSFTP()
  process.exit(0)
}
