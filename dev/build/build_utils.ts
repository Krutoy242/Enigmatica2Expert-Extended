import type { Options } from 'fast-glob'
import type ignore from 'ignore'
import type { InputFieldOptions } from 'terminal-kit/Terminal.js'

import { relative } from 'node:path'
import process from 'node:process'

import boxen from 'boxen'
import chalk from 'chalk'
import { consola } from 'consola'
import fast_glob from 'fast-glob'
import fse from 'fs-extra'
import logUpdate from 'log-update'
import terminal_kit from 'terminal-kit'

import {
  end,
  write,
} from '../lib/utils.js'

const { rmSync } = fse

const { terminal: term } = terminal_kit

export async function confirm(msg: string) {
  return consola.prompt(msg, { type: 'confirm' })
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

/**
 * Write task in log and execute it
 * @param s Name of the tast would be printed in Log
 * @param fn Function of task
 * @param cwd Optional working path where task is executed
 */
export function doTask(s: string, fn: () => void, cwd?: string) {
  const oldCwd = process.cwd()
  if (cwd) process.chdir(cwd)
  write(style.label(s))
  end(fn())
  if (cwd) process.chdir(oldCwd)
}

/*
 █████╗ ██╗   ██╗████████╗ ██████╗ ███╗   ███╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
██╔══██╗██║   ██║╚══██╔══╝██╔═══██╗████╗ ████║██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
███████║██║   ██║   ██║   ██║   ██║██╔████╔██║███████║   ██║   ██║██║   ██║██╔██╗ ██║
██╔══██║██║   ██║   ██║   ██║   ██║██║╚██╔╝██║██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
██║  ██║╚██████╔╝   ██║   ╚██████╔╝██║ ╚═╝ ██║██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
*/

let STEP = 1

/**
 * Prompt user to write something and press ENTER or ESC
 * @param message message to show
 * @param options message to show
 * @returns inputted string or undefined
 */
export async function enterString(message: string, options?: InputFieldOptions) {
  const msg = `[${STEP++}] ${message}`
  term(style.trace(msg.replace(/(ENTER|ESC)/g, style.info('$1'))))
  const result = await term.inputField({
    cancelable: true,
    ...options ?? {},
  }).promise
  term('\n')
  return result
}

/**
 * Prompt user to press ENTER or ESC
 * @param message message to show
 * @param condition repeat until true
 * @returns `true` if ENTER pressed, `false` otherwise
 */
export async function pressEnterOrEsc(message: string, condition?: () => Promise<boolean>) {
  let oneTime = 0
  while (condition ? !await condition() : !oneTime++) {
    if (await enterString(message) === undefined) return false
  }

  return true
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
