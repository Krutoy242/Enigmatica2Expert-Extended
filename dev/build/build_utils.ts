import type { Options } from 'fast-glob'
import type ignore from 'ignore'

import { tmpdir } from 'node:os'
import { relative } from 'node:path'
import process from 'node:process'

import * as p from '@clack/prompts'
import boxen from 'boxen'
import chalk from 'chalk'
import fast_glob from 'fast-glob'
import fse from 'fs-extra'
import logUpdate from 'log-update'
import { resolve } from 'pathe'
import { $ } from 'zx'

const { rmSync } = fse

/**
 * Scratch space for the release build. Lives in the OS temp folder — `%TEMP%`
 * on Windows, which Storage Sense empties on its own — so an aborted release
 * leaves nothing behind on a real drive and no path here can rot the way a
 * hardcoded `D:/mc_tmp` or a symlink to a moved cloud folder does.
 * Fixed names, not `mkdtemp`: the release is resumable and a second run has to
 * find the zips the first one already built.
 */
const TMP_ROOT = resolve(tmpdir(), 'e2e-e')

/** Shallow clone of the tag being packed. Wiped at the start of every build. */
export const BUILD_TMP = `${TMP_ROOT}/build/`

/** Where the finished `.zip` files land. Never inside {@link BUILD_TMP}, which gets wiped. */
export const DIST_DIR = `${TMP_ROOT}/dist`

/** Shape of the extra fields errors carry in practice — axios responses, Node syscalls, `AggregateError`. */
interface ErrorLike {
  cause?   : unknown
  code?    : string | number
  config?  : { method?: string, url?: string }
  errors?  : unknown[]
  message? : string
  name?    : string
  response?: { status?: number, statusText?: string }
  stack?   : string
  syscall? : string
}

/** `read ECONNRESET` alone says nothing — pull out everything that identifies *which* call died. */
function errorDetails(e: ErrorLike): string[] {
  const details: string[] = []
  if (e.code !== undefined) details.push(`code ${e.code}`)
  if (e.syscall) details.push(`syscall ${e.syscall}`)
  if (e.response?.status) details.push(`HTTP ${e.response.status}${e.response.statusText ? ` ${e.response.statusText}` : ''}`)
  if (e.config?.url) details.push(`${(e.config.method ?? 'get').toUpperCase()} ${e.config.url}`)
  return details
}

/**
 * Human-readable description of anything thrown: the message plus the request /
 * syscall that produced it, then the whole `cause` chain, then any nested
 * `AggregateError` members.
 *
 * Stack traces are hidden unless `DEBUG` or `VERBOSE` is set — they bury the one
 * line that matters in ten frames of Node internals.
 */
export function formatError(error: unknown, depth = 0): string {
  if (depth > 4) return '…'
  if (!(error instanceof Error)) return String(error)

  const e = error as Error & ErrorLike
  const details = errorDetails(e)
  const lines = [
    `${e.name && e.name !== 'Error' ? `${e.name}: ` : ''}${e.message}${details.length ? ` (${details.join(', ')})` : ''}`,
  ]

  for (const nested of e.errors ?? [])
    lines.push(indent(`• ${formatError(nested, depth + 1)}`))

  if (e.cause !== undefined && e.cause !== null)
    lines.push(indent(`caused by: ${formatError(e.cause, depth + 1)}`))

  if (showStacks() && e.stack)
    lines.push(indent(chalk.gray(e.stack.split('\n').slice(1).join('\n'))))

  return lines.join('\n')
}

export function showStacks(): boolean {
  return Boolean(process.env.DEBUG || process.env.VERBOSE)
}

function indent(text: string): string {
  return text.split('\n').map(line => `  ${line}`).join('\n')
}

/**
 * Run labelled jobs in parallel, then report *every* failure at once.
 *
 * `Promise.all` rejects with whichever job lost first and drops both the label
 * and the other failures — with seven concurrent file rewrites that leaves no
 * clue about which one broke.
 */
export async function runAllLabeled(jobs: Record<string, () => Promise<unknown>>) {
  const names = Object.keys(jobs)
  const results = await Promise.allSettled(names.map(async name => jobs[name]()))

  const failed = results.flatMap((result, i) =>
    result.status === 'rejected' ? [{ name: names[i], error: result.reason as unknown }] : [])

  if (!failed.length) return

  const details = failed.map(({ name, error }) => `${chalk.red(`✖ ${name}`)}: ${formatError(error)}`).join('\n')
  throw new Error(`${failed.length} of ${names.length} step(s) failed:\n${details}`)
}

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

/**
 * Files matched by the *positive* patterns of an `ignore` instance.
 *
 * `ignore` has no public API for reading back its rules, so this digs into its
 * internals — see {@link getRules} for the version guard.
 */
export function getIgnoredFiles(ignored: ignore.Ignore, options?: Options) {
  const rules = getRules(ignored)
  return globs(
    rules.filter(rule => !rule.negative).map(rule => rule.pattern),
    { ignore: rules.filter(rule => rule.negative).map(rule => rule.pattern), ...options }
  )
}

interface PartialRule {
  negative: boolean
  pattern : string
}

interface PrivateIgnored extends ignore.Ignore {
  _rules?: {
    _rules?: PartialRule[]
  }
}

/**
 * Reach into `ignore`'s private rule list.
 *
 * A silent `[]` here would mean "nothing to strip", so a release could quietly
 * ship dev-only files. Fail loudly instead if the internals ever move.
 */
function getRules(ignored: ignore.Ignore): PartialRule[] {
  const rules = (ignored as PrivateIgnored)._rules?._rules
  if (!Array.isArray(rules)) {
    throw new TypeError(
      'Cannot read rules from the "ignore" package: private field `_rules._rules` is gone.\n'
      + '  The installed "ignore" version changed its internals — update getRules() in dev/build/build_utils.ts.'
    )
  }
  return rules
}

export interface RemoveFilesResult {
  /** Paths that are gone now (or never existed — `rmSync` is forced). */
  removed: string[]
  /** Paths that survived, with the reason. */
  failed : { error: string, file: string }[]
}

/**
 * Delete every given path, keeping going when one of them fails.
 *
 * Returns what happened instead of printing it: callers own the output, and a
 * stray `process.stdout.write` corrupts any spinner running at the time.
 *
 * @param fileArg list of paths to remove
 */
export function removeFiles(fileArg: readonly string[] | string): RemoveFilesResult {
  const result: RemoveFilesResult = { removed: [], failed: [] }

  for (const file of [fileArg].flat()) {
    try {
      rmSync(file, { recursive: true, force: true })
      result.removed.push(file)
    }
    catch (error) {
      result.failed.push({ file, error: error instanceof Error ? error.message : String(error) })
    }
  }

  return result
}

/** Human-readable summary of {@link removeFiles}, relative to the cwd. */
export function formatRemoveResult({ removed, failed }: RemoveFilesResult): string {
  const rel = (file: string) => relative(process.cwd(), file)
  return [
    `removed: ${removed.length}`,
    ...removed.map(file => chalk.gray(rel(file))),
    ...failed.map(({ file, error }) => chalk.red(`cannot remove ${chalk.blue(rel(file))}: ${error}`)),
  ].join('\n')
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

/** Rewrites a single box in place; each argument is coloured one step further down {@link style}. */
export type UpdateBox = (...args: unknown[]) => void

export function getBoxForLabel(label: string): UpdateBox {
  const palette = Object.values(style)
  logUpdate.done()
  return function updateBox(...args: unknown[]) {
    return logUpdate(
      boxen(
        // More arguments than colours is fine — the extras keep the last one.
        args.map((v, i) => (palette[i] ?? palette[palette.length - 1])(String(v))).join(' '),
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

/**
 * Fold the staged changes into the previous commit when it is another run of
 * the same step, otherwise start a new commit.
 */
export async function commitAmend(commitMsg: string) {
  // `.stdout`, not `.text()`: the latter is stdout+stderr, so any git warning
  // would end up compared against the commit message.
  const lastCommitMsg = (await $`git log -1 --pretty=%B`.nothrow()).stdout.trim()

  if (lastCommitMsg === commitMsg)
    await $`git commit --amend --no-edit`
  else
    await $`git commit -m ${commitMsg}`
}
