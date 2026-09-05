/**
 * One way into `mc-icons` for the whole repo.
 *
 * The pack talks to mc-icons as a library — no process spawn, no temp file, and
 * a name that already exists is answered in single-digit milliseconds. The one
 * thing that stays behind the CLI is the interactive picker, which renders with
 * ink and shows image previews ({@link ICON_CLI}).
 *
 * Plain `node`, no dependencies: `dev/hooks/` runs on every commit and must not
 * pay for tsx. Types for TypeScript callers live in `mc-icons.d.mts`.
 */

import { existsSync, readFileSync, writeFileSync } from 'node:fs'
import process from 'node:process'
import { pathToFileURL } from 'node:url'

/** The checkout the whole repo iconifies with. */
export const MC_ICONS = process.env.MC_ICONS || 'E:/dev/mc/icons'

/**
 * Shared by the commit hook and the release run, so a name that passes at commit
 * time passes at release time too.
 */
export const ICON_OPTIONS = { modpack: 'e2ee', treshold: 2 }

/** `node ...ICON_CLI <file.md>` — the same matching, with the picker attached. */
export const ICON_CLI = [
  `${MC_ICONS}/build/cli.js`,
  `--modpack=${ICON_OPTIONS.modpack}`,
  `--treshold=${ICON_OPTIONS.treshold}`,
  '--no-short',
]

/**
 * @param {{ maxCandidates?: number }} [options] How many suggestions a problem carries.
 * @returns {Promise<import('./mc-icons.d.mts').Icons | undefined>} `undefined` on
 * any machine without an mc-icons checkout (contributors, CI) — callers that can
 * live without icons stay silent, the release run does not.
 */
export async function loadIcons(options = {}) {
  // The built entry point is required: the TypeScript sources would need tsx.
  const built = `${MC_ICONS}/build/index.js`
  if (!existsSync(built) || !existsSync(`${MC_ICONS}/assets/assets.db`))
    return undefined

  let lib
  try {
    lib = await import(pathToFileURL(built).href)
  }
  catch {
    return undefined // broken or mid-rebuild — say nothing rather than cry wolf
  }

  const icons = new lib.McIcons({ ...ICON_OPTIONS, ...options })
  return {
    resolve : query => icons.resolve(query),
    iconify : (markdown, iconifyOptions) => icons.iconify(markdown, iconifyOptions),
    describe: lib.describeCandidate,
  }
}

/**
 * Turn every `[Item Name]` of a markdown file into an icon, in place.
 *
 * @param {string} file Markdown file to rewrite.
 * @param {{ maxCandidates?: number }} [options] Passed to {@link loadIcons}.
 * @returns {Promise<{ replaced: number, problems: import('./mc-icons.d.mts').IconProblem[], describe: (c: import('./mc-icons.d.mts').IconCandidate) => string }>}
 * How many names became icons, and the ones that did not with their suggestions.
 * @throws When mc-icons is unavailable — a release must never quietly ship a
 * changelog full of `[Bracketed]` names.
 */
export async function iconifyFile(file, options = {}) {
  const icons = await loadIcons(options)
  if (!icons)
    throw new Error(`No usable mc-icons at ${MC_ICONS} — build it (\`pnpm -C ${MC_ICONS} build\`) or set MC_ICONS`)

  const md = readFileSync(file, 'utf8')
  const { text, replaced, problems } = await icons.iconify(md)
  if (text !== md)
    writeFileSync(file, text)

  return { replaced, problems, describe: icons.describe }
}
