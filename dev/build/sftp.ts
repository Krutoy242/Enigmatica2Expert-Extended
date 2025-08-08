import { join, parse } from 'node:path'
import process from 'node:process'

import fse from 'fs-extra'
import git_describe from 'git-describe'
import { replaceInFileSync } from 'replace-in-file'
import Client from 'ssh2-sftp-client'

import {
  end,
  loadJson,
} from '../lib/utils.js'
import { getBoxForLabel, globs, pressEnterOrEsc, style } from './build_utils'

const { readFileSync, writeFileSync } = fse

const { gitDescribeSync } = git_describe
export async function manageSFTP(serverSetupConfig: string = 'server/server-setup-config.yaml') {
  const sftpConfigs = globs('secrets/sftp_servers/*/sftp.json').map((filename) => {
    const dir = parse(filename).dir
    return {
      dir,
      label : dir.split('/').pop(),
      config: loadJson(filename) as { [key: string]: string },
    }
  })

  const currentVersion = gitDescribeSync().tag

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
    if (!await pressEnterOrEsc(
      `To upload SFTP ${style.string(conf.label)} press ENTER. Press ESC to skip.`
    )) {
      continue
    }

    const sftp = new Client()
    const updateBox = getBoxForLabel(conf.label)

    updateBox('Establishing connection')
    try {
      await sftp.connect(conf.config)
    }
    catch (error) {
      end(`Cant connect to SFTP: ${error}`)
      continue
    }

    updateBox(`Copy ${serverConfigTmp}`)
    await sftp.fastPut(serverConfigTmp, 'server-setup-config.yaml')

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
}

// Launch file
if (import.meta.url === (await import('node:url')).pathToFileURL(process.argv[1]).href) {
  await manageSFTP()
  process.exit(0)
}
