import { createWriteStream } from 'node:fs'
import { pipeline } from 'node:stream/promises'

// eslint-disable-next-line antfu/no-import-dist, antfu/no-import-node-modules-by-path
import { ConventionalChangelog } from '../../../node_modules/conventional-changelog/dist/ConventionalChangelog.js'
import config from './config'

export async function generateChangelog(outputPath: string) {
  const generator = new ConventionalChangelog()

  generator.commits(config.commits, config.parser)
  generator.writer(config.writer)

  const changelogStream = generator.write()
  const outputStream = createWriteStream(outputPath, 'utf8')
  await pipeline(
    changelogStream,
    outputStream
  )
}
