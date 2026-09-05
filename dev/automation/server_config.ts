/* eslint-disable antfu/no-top-level-await */
/**
 * @file Keep `server/server-setup-config.yaml` in step with the Cleanroom build
 * the client launches.
 *
 * The release script rewrites this file too, but only while cutting a release.
 * Bumping `config/relauncher.json` on any other day used to leave the dedicated
 * server pinned to the previous loader until the next `pnpm build` — running the
 * same sync from `pnpm dev` closes that window.
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

import { readFileSync } from 'node:fs'
import { readFile, writeFile } from 'node:fs/promises'
import process from 'node:process'

import { consola } from 'consola'

import { formatError } from '../build/build_utils.js'

export const SERVER_SETUP_CONFIG = 'server/server-setup-config.yaml'
export const RELAUNCHER_CONFIG = 'config/relauncher.json'

/** Cleanroom tags its releases `<ver>` and names the assets `cleanroom-<ver>[-installer].jar`. */
const CLEANROOM_RELEASES = 'https://github.com/CleanroomMC/Cleanroom/releases/download'

export interface ScalarPatch {
  key    : string
  value  : string
  /** Leave the value alone unless it already is the kind of value we are about to write. */
  expect?: string
}

/** Matches one `key: value` line of a YAML mapping. Groups: the `key:` prefix, the value, an optional CR. */
function yamlScalar(key: string): RegExp {
  return new RegExp(String.raw`^([ \t]*${key}[ \t]*:[ \t]*)([^\r\n]*)(\r?)$`, 'm')
}

export interface PatchResult {
  /** `key: value` lines that are different now. */
  changed : string[]
  /** Keys that were skipped, with the reason. */
  warnings: string[]
}

/**
 * Rewrite scalar keys of the dedicated-server setup config.
 *
 * One read-modify-write for the whole file: two `replaceInFile` calls on the same
 * path run concurrently would lose one of the two edits.
 */
export async function patchServerSetupConfig(patches: ScalarPatch[]): Promise<PatchResult> {
  const source = await readFile(SERVER_SETUP_CONFIG, 'utf8')
  const result: PatchResult = { changed: [], warnings: [] }

  let patched = source
  for (const { key, value, expect } of patches) {
    const re = yamlScalar(key)
    const match = re.exec(patched)

    if (!match) {
      result.warnings.push(`"${key}:" not found in ${SERVER_SETUP_CONFIG} — left untouched.`)
      continue
    }
    if (expect && !match[2].toLowerCase().includes(expect)) {
      result.warnings.push(`"${key}: ${match[2].trim()}" in ${SERVER_SETUP_CONFIG} is not a ${expect} value — left untouched.`)
      continue
    }
    if (match[2] === value) continue

    result.changed.push(`${key}: ${match[2].trim()} → ${value}`)
    patched = patched.replace(re, (_full, prefix: string, _old: string, cr: string) => `${prefix}${value}${cr}`)
  }

  if (patched !== source) await writeFile(SERVER_SETUP_CONFIG, patched)
  return result
}

/**
 * Cleanroom build the client launches with.
 *
 * `config/relauncher.json` is the single source of truth: if the server installs
 * a different build, everyone joins a server running another loader version.
 */
export function readCleanroomVersion(): string {
  let relauncher: { selectedVersion?: unknown }
  try {
    relauncher = JSON.parse(readFileSync(RELAUNCHER_CONFIG, 'utf8')) as { selectedVersion?: unknown }
  }
  catch (error) {
    throw new Error(`Cannot read the Cleanroom version from "${RELAUNCHER_CONFIG}": ${formatError(error)}`)
  }

  const version = relauncher.selectedVersion
  if (typeof version !== 'string' || !version.trim()) {
    throw new Error(`"selectedVersion" is missing or not a string in ${RELAUNCHER_CONFIG}.\n`
      + '  The server setup config takes its Cleanroom version from there.')
  }
  return version.trim()
}

/**
 * Everything in the setup config that names the loader build.
 *
 * `startCommand` needs no entry — it refers to the jar through `{{@startFile@}}`,
 * which ServerStarter substitutes at launch.
 */
export function cleanroomPatches(): ScalarPatch[] {
  const cleanroom = readCleanroomVersion()
  return [
    {
      key   : 'installerUrl',
      value : `'${CLEANROOM_RELEASES}/${cleanroom}/cleanroom-${cleanroom}-installer.jar'`,
      expect: 'cleanroom',
    },
    {
      // The jar the installer above produces — a stale name here starts nothing.
      key   : 'startFile',
      value : `cleanroom-${cleanroom}.jar`,
      expect: 'cleanroom',
    },
  ]
}

// Launch file
if (import.meta.url === (await import('node:url')).pathToFileURL(process.argv[1]).href) {
  const { changed, warnings } = await patchServerSetupConfig(cleanroomPatches())

  for (const warning of warnings) consola.warn(warning)
  if (changed.length) consola.success(`${SERVER_SETUP_CONFIG} synced to Cleanroom ${readCleanroomVersion()}:\n  ${changed.join('\n  ')}`)
  else consola.info(`${SERVER_SETUP_CONFIG} already on Cleanroom ${readCleanroomVersion()}`)

  if (warnings.length) process.exit(1)
}
