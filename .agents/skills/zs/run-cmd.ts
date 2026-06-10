/**
 * @file Execute an arbitrary Minecraft command via ProbeZS RMI bridge.
 *
 * ## Usage
 * ```bash
 * npx tsx .agents/skills/zs/run-cmd.ts [command]
 * ```
 *
 * If no command is provided, defaults to `/list`.
 *
 * @example
 * npx tsx .agents/skills/zs/run-cmd.ts "/say Hello from CLI!"
 * npx tsx .agents/skills/zs/run-cmd.ts "/give @p minecraft:diamond 64"
 * npx tsx .agents/skills/zs/run-cmd.ts                 # defaults to /list
 */

import process from 'node:process'
import chalk from 'chalk'

import { execCmd } from '../../../dev/lib/probezs.js'

// Minecraft §X color / format codes → ANSI
const MC_CODE: Record<string, string> = {
  '0': '\x1b[30m', '1': '\x1b[34m', '2': '\x1b[32m', '3': '\x1b[36m',
  '4': '\x1b[31m', '5': '\x1b[35m', '6': '\x1b[33m', '7': '\x1b[37m',
  '8': '\x1b[90m', '9': '\x1b[94m', 'a': '\x1b[92m', 'b': '\x1b[96m',
  'c': '\x1b[91m', 'd': '\x1b[95m', 'e': '\x1b[93m', 'f': '\x1b[97m',
  'l': '\x1b[1m',  'm': '\x1b[9m',  'n': '\x1b[4m',  'o': '\x1b[3m',
  'r': '\x1b[0m',  'k': '',
}

function mcToAnsi(s: string): string {
  return s.replace(/§([0-9a-fk-or])/gi, (_, c) => MC_CODE[c.toLowerCase()] ?? '') + '\x1b[0m'
}

function report(result: Awaited<ReturnType<typeof execCmd>>): void {
  const mark = result.ok ? chalk.green('✓') : chalk.red('✗')
  const cmd  = chalk.cyan(result.command)
  const ms   = chalk.gray(`${result.ms.toFixed(0)}ms`)
  const uid  = chalk.gray(`uid=${result.uuid}`)
  const rep  = mcToAnsi((result.output || result.reply.replace(/^(?:OK|FAIL):exec:[^:]+:/, '')).replace(/\n+$/, ''))
  process.stdout.write(`${cmd} ${mark} (${ms}, ${uid}): ${rep}\n`)
}

async function main() {
  const raw = process.argv.slice(2) || ['list']
  const cmds = raw.map(s => s.startsWith('/') ? s : '/' + s)

  let exitCode = 0

  for (const cmd of cmds) {
    try {
      const result = await execCmd(cmd)
      report(result)
      if (!result.ok) {
        exitCode = 1
        break
      }
    } catch (e: any) {
      process.stderr.write(`${cmd} ✗ (${e.message})\n`)
      exitCode = 1
      break
    }
  }

  process.exit(exitCode)
}

main()
