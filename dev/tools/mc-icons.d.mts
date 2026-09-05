/**
 * The slice of the `mc-icons` library this repo uses.
 *
 * mc-icons is a local checkout ({@link MC_ICONS}), not a dependency, so its own
 * types cannot be imported — this declares the surface `mc-icons.mjs` hands out.
 * Keep it in sync with `src/api.ts` there.
 */

export interface IconCandidate {
  /** Display name, e.g. `OD Scanner`. */
  name   : string
  /** Full id, `mod:entry:meta[:{nbt}]`. */
  id     : string
  /** Mod name, e.g. `Extra Utilities 2`. */
  modname: string
  /** Mod abbreviation, e.g. `EU2`. */
  mod    : string
  /** Markdown that resolves to exactly this item, e.g. `[Scanner] (EU2)`. */
  snippet: string
}

/** A reference mc-icons would not turn into an icon on its own. */
export type IconProblem
  = | {
    status    : 'ambiguous'
    /** The reference as written, e.g. `[Scanner]`. */
    query     : string
    /** Text inside the brackets. */
    capture   : string
    candidates: IconCandidate[]
    /** How many items the name could mean, `candidates` being the first few. */
    total     : number
    /** `fuzzy` means nothing matched and these are merely the nearest names. */
    via       : 'id' | 'name' | 'trie' | 'fuzzy'
  }
  | { status: 'unknown', query: string, capture: string }

export type IconResolution
  = | { status: 'resolved', query: string, capture: string, items: { name: string, id: string }[] }
    | IconProblem

export interface Icons {
  /** One reference: `Scanner`, `[Scanner] (EU2)` or `[<minecraft:coal:1>]`. */
  resolve: (query: string) => Promise<IconResolution>
  /** A whole markdown text; nothing is written and nothing is prompted for. */
  iconify: (markdown: string, options?: { repo?: string, short?: boolean }) => Promise<{
    text    : string
    replaced: number
    problems: IconProblem[]
  }>
  /** A candidate as one line of text: `[Scanner] (EU2)  — Extra Utilities 2`. */
  describe: (candidate: IconCandidate) => string
}

export declare const MC_ICONS: string
export declare const ICON_OPTIONS: { modpack: string, treshold: number }
export declare const ICON_CLI: string[]
export declare function loadIcons(options?: { maxCandidates?: number }): Promise<Icons | undefined>
export declare function iconifyFile(file: string, options?: { maxCandidates?: number }): Promise<{
  replaced: number
  problems: IconProblem[]
  describe: (candidate: IconCandidate) => string
}>
