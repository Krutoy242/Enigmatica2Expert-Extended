/**
 * @file Everything that answers "what actually ships in the release".
 *
 * The release is not `minecraftinstance.json` — it is that file minus whatever
 * `dev/.devonly.ignore` matches: `make_pack` deletes those paths from the clone
 * and `mctools-manifest` drops those mods from `manifest.json`.
 *
 * That list is edited between releases, so a mod can join the release without
 * `minecraftinstance.json` changing at all. Any comparison of two releases must
 * therefore filter each side with the list *that* release shipped with.
 */

import type { ModpackManifest } from '@mctools/manifest'

import type { InstalledAddon, Minecraftinstance } from '../../mc-tools/packages/curseforge/src/minecraftinstance.js'

import { readFileSync } from 'node:fs'
import process from 'node:process'

import { $ } from 'zx'

import { loadMCInstanceFiltered } from '../../mc-tools/packages/curseforge/src/diff.js'

/** Quiet: a missing file in an old tag is a normal answer here, not console noise. */
const $q = $({ quiet: true })

export const DEVONLY_IGNORE = 'dev/.devonly.ignore'
export const MCINSTANCE = 'minecraftinstance.json'

/** Reported instead of thrown — a degraded comparison is still worth running. */
export type OnWarn = (message: string) => void

const warnToStderr: OnWarn = message => void process.stderr.write(`${message}\n`)

/** Current dev-only list. Fails loudly: an empty list would silently ship dev files. */
export function readDevonlyIgnore(): string {
  try {
    return readFileSync(DEVONLY_IGNORE, 'utf8')
  }
  catch (error) {
    throw new Error(`Cannot read the dev-only ignore list "${DEVONLY_IGNORE}": ${error instanceof Error ? error.message : String(error)}`)
  }
}

/**
 * The dev-only list as of `ref` — the filter that release was actually built with.
 *
 * Falls back to the current list when the ref predates the file: the honest
 * answer there would be "nothing was ignored", which would report every dev-only
 * mod as removed and bury the real changes.
 */
export async function readDevonlyIgnoreAt(ref: string, onWarn: OnWarn = warnToStderr): Promise<string> {
  const shown = await $q`git show ${`${ref}:${DEVONLY_IGNORE}`}`.nothrow()
  if (shown.exitCode === 0) return shown.stdout

  onWarn(`No ${DEVONLY_IGNORE} at ${ref} — comparing against the current list instead. `
    + 'Mods un-ignored since then will not show up as added.')
  return readDevonlyIgnore()
}

/** Mods of one snapshot that reach players: on CurseForge and not dev-only. */
export function releaseAddons(mci: Minecraftinstance, ignore: string): InstalledAddon[] {
  return loadMCInstanceFiltered(mci, ignore).installedAddons
}

/** Both sides of a release-to-release comparison, each with its own dev-only list. */
export interface ReleaseSnapshots {
  fresh    : Minecraftinstance
  ignore   : string
  old      : Minecraftinstance
  oldIgnore: string
}

/**
 * Load the working tree and `ref` as two comparable snapshots.
 *
 * @param ref anything `git show` accepts, e.g. `tags/v1.86.0-beta`.
 */
export async function loadReleaseSnapshots(ref: string, onWarn: OnWarn = warnToStderr): Promise<ReleaseSnapshots> {
  const [fresh, old, ignore, oldIgnore] = await Promise.all([
    Promise.resolve().then(() => JSON.parse(readFileSync(MCINSTANCE, 'utf8')) as Minecraftinstance),
    // `.stdout`, not `String(res)`: the latter appends stderr, so any git warning
    // would make `JSON.parse` choke.
    (async () => {
      const res = await $q`git show ${`${ref}:${MCINSTANCE}`}`
      return JSON.parse(res.stdout) as Minecraftinstance
    })(),
    Promise.resolve().then(readDevonlyIgnore),
    readDevonlyIgnoreAt(ref, onWarn),
  ])

  return { fresh, old, ignore, oldIgnore }
}

/**
 * Mods that ship now but were dev-only at the old snapshot — the changes that
 * no other signal reports, since nothing about the mod itself changed.
 */
export function unignoredMods({ fresh, old, ignore, oldIgnore }: ReleaseSnapshots): string[] {
  const shippedThen = new Set(releaseAddons(old, oldIgnore).map(a => a.addonID))
  const knownThen = new Map(old.installedAddons.map(a => [a.addonID, a]))

  return releaseAddons(fresh, ignore)
    .filter(a => knownThen.has(a.addonID) && !shippedThen.has(a.addonID))
    .map(a => a.name || a.installedFile.fileName)
    .sort((a, b) => a.localeCompare(b))
}

/**
 * Ways `manifest.json` disagrees with `minecraftinstance.json` + the dev-only list.
 *
 * The manifest is what the launcher downloads, and a separate step generates it —
 * edit the ignore list without re-running that step and the mods the changelog
 * promises never reach anyone.
 *
 * @param manifestPath the manifest as it will ship — read it from the clone.
 */
export async function manifestMismatches(manifestPath: string): Promise<string[]> {
  const [manifest, mci] = await Promise.all([
    Promise.resolve().then(() => JSON.parse(readFileSync(manifestPath, 'utf8')) as ModpackManifest),
    Promise.resolve().then(() => JSON.parse(readFileSync(MCINSTANCE, 'utf8')) as Minecraftinstance),
  ])

  const expected = new Map(releaseAddons(mci, readDevonlyIgnore()).map(a => [Number(a.addonID), a]))
  const actual = new Map(manifest.files.map(f => [f.projectID, f]))
  const problems: string[] = []

  for (const [id, addon] of expected) {
    const file = actual.get(id)
    if (!file)
      problems.push(`missing from manifest.json: ${addon.name} (${addon.installedFile.fileName})`)
    else if (file.fileID !== Number(addon.installedFile.id))
      problems.push(`stale version in manifest.json: ${addon.name} — file ${file.fileID}, installed ${addon.installedFile.id}`)
  }

  for (const [id, file] of actual) {
    if (!expected.has(id)) problems.push(`ships but is not in the release mod list: ${file.___name ?? `project ${id}`}`)
  }

  return problems
}
