import type { Options } from 'fast-glob'
import type ignore from 'ignore'

import { relative } from 'node:path'
import process from 'node:process'

import * as p from '@clack/prompts'
import boxen from 'boxen'
import chalk from 'chalk'
import fast_glob from 'fast-glob'
import fse from 'fs-extra'
import logUpdate from 'log-update'
import { $ } from 'zx'

const { rmSync } = fse
const $$ = $({ stdio: 'inherit', verbose: true })

export async function confirm(msg: string) {
  const result = await p.confirm({ message: msg })
  if (p.isCancel(result)) {
    p.cancel('Operation cancelled.')
    process.exit(0)
  }
  return result
}

/**
 * Globs with default options `dot: true, onlyFiles: false`
 */
export function globs(source: string | string[], options?: Options) {
  return fast_glob.sync(source, { dot: true, onlyFiles: false, ...options })
}

export function getIgnoredFiles(ignored: ignore.Ignore, options?: Options) {
  return globs(
    getIgnorePositives(ignored as PrivateIgnored),
    { ignore: getIgnoreNegative(ignored as PrivateIgnored), ...options }
  )
}

interface PartialRule {
  negative: boolean
  pattern : string
}

interface PrivateIgnored extends ignore.Ignore {
  _rules: {
    _rules: PartialRule[]
  }
}

function getIgnorePositives(ignored: PrivateIgnored) {
  return ignored._rules._rules
    .filter(p => !p.negative)
    .map(p => p.pattern)
}

function getIgnoreNegative(ignored: PrivateIgnored) {
  return ignored._rules._rules
    .filter(p => p.negative)
    .map(p => p.pattern)
}

/**
 * @param {string | readonly string[]} fileArg list of globs of files to remove
 */
export function removeFiles(fileArg: readonly string[] | string) {
  const files = [fileArg].flat(2)
  const removed: string[] = []
  files.forEach((file) => {
    try {
      rmSync(file, { recursive: true, force: true })
      removed.push(file)
    }
    catch (error) {
      process.stdout.write(`\n${chalk.red(`Cannot remove: ${chalk.blue(file)}`)}\n\n${error}\n`)
    }
  })
  return `removed: ${removed.length}\n${removed.map(s => chalk.gray(relative(process.cwd(), s))).join('\n')
  }`
}

export const style = {
  trace : chalk.hex('#7b4618'),
  info  : chalk.hex('#915c27'),
  log   : chalk.hex('#ad8042'),
  label : chalk.hex('#bfab67'),
  string: chalk.hex('#bfc882'),
  number: chalk.hex('#a4b75c'),
  status: chalk.hex('#647332'),
  chose : chalk.hex('#3e4c22'),
  end   : chalk.hex('#2e401c'),
}

export function getBoxForLabel(label: string) {
  logUpdate.done()
  return function updateBox(...args: any[]) {
    return logUpdate(
      boxen(
        args.map((v, i) => Object.values(style)[i](String(v))).join(' '),
        {
          borderStyle: 'round',
          borderColor: '#22577a',
          width      : 50,
          padding    : { left: 1, right: 1 },
          title      : style.info(label),
        }
      )
    )
  }
}

export async function commitOrFixup(fileName: string, commitMsg: string) {
  // Check for staged files
  const hasStagedFilesProc = await $`git diff --cached --quiet`.nothrow()
  if (hasStagedFilesProc.exitCode !== 0) {
    return 'There are staged files. Please unstage them before proceeding.'
  }

  // Add file to staging
  await $$`git add ${fileName}`

  // Check if a commit with the same message already exists
  const logProc = await $`git log --grep=${`^${commitMsg}$`} --format=%H -n 1`.nothrow()
  const similarCommitSha = logProc.stdout.trim()

  if (similarCommitSha) {
    await $$`git commit --fixup=${similarCommitSha}`
  }
  else {
    await $$`git commit -m ${commitMsg}`.nothrow()
  }
}

export async function commitAmend(commitMsg: string) {
  // Get the last commit message
  const lastCommitMsg = (await $`git log -1 --pretty=%B`.text()).trim()

  if (lastCommitMsg === commitMsg) {
    // Amend the last commit
    await $$`git commit --amend --no-edit`
  }
  else {
    // Create a new commit
    await $$`git commit -m ${commitMsg}`
  }
}
