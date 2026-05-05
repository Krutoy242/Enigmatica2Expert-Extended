/**
 * @file Runs every `dev:*` npm script in parallel through listr2.
 *
 * Replaces the previous `concurrently` invocation. Listr2 gives us:
 *  - a live, collapsing per-task status line (last stdout/stderr line)
 *  - guaranteed visibility of failures (full captured output is replayed
 *    at the end so it isn't drowned out by interleaved success logs)
 *  - one non-zero exit code if any task fails, all tasks always run
 */

import type { ListrTask } from 'listr2'
import { spawn } from 'node:child_process'
import { readFileSync } from 'node:fs'
import { resolve } from 'node:path'
import { Listr } from 'listr2'

interface Failure {
  name  : string
  code  : number
  output: string
}

interface Ctx {
  failures: Failure[]
}

const pkg = JSON.parse(
  readFileSync(resolve(process.cwd(), 'package.json'), 'utf8')
) as { scripts: Record<string, string> }

const devScripts = Object.keys(pkg.scripts)
  .filter(k => k.startsWith('dev:') && k !== 'dev')
  .sort()

if (devScripts.length === 0) {
  console.error('No `dev:*` scripts found in package.json')
  process.exit(1)
}

const tasks: ListrTask<Ctx>[] = devScripts.map((script) => {
  const title = script.slice('dev:'.length)
  return {
    title,
    task: async (ctx, task) => new Promise<void>((resolve, reject) => {
      const child = spawn(`npm run ${script} --silent`, {
        shell: true,
        stdio: ['ignore', 'pipe', 'pipe'],
        env  : { ...process.env, FORCE_COLOR: '1' },
      })

      const buffer: string[] = []
      const onChunk = (chunk: Buffer) => {
        const text = chunk.toString()
        buffer.push(text)
        const lastLine = text
          .split(/\r?\n/)
          .map(l => l.trim())
          .filter(Boolean)
          .pop()
        if (lastLine) task.output = lastLine
      }

      child.stdout?.on('data', onChunk)
      child.stderr?.on('data', onChunk)

      child.on('error', (err) => {
        ctx.failures.push({ name: title, code: -1, output: String(err) })
        reject(err)
      })

      child.on('close', (code) => {
        if (code !== 0) {
          ctx.failures.push({
            name  : title,
            code  : code ?? -1,
            output: buffer.join('').trim() || '(no output)',
          })
          reject(new Error(`exited with code ${code}`))
          return
        }
        resolve()
      })
    }),
  }
})

const runner = new Listr<Ctx>(tasks, {
  concurrent     : true,
  exitOnError    : false,
  ctx            : { failures: [] },
  rendererOptions: {
    collapseErrors  : true,
    showErrorMessage: false,
    suffixSkips     : false,
  },
})

const ctx = await runner.run()

if (ctx.failures.length > 0) {
  console.error('')
  for (const f of ctx.failures) {
    console.error(`\n──── ${f.name} (exit ${f.code}) ────`)
    console.error(f.output)
  }
  console.error(`\n${ctx.failures.length} of ${tasks.length} dev tasks failed.`)
  process.exit(1)
}
