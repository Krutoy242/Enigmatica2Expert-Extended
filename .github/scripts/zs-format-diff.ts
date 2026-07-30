/**
 * @file Unified-diff helpers shared by the ZenScript auto-format CI.
 *
 * The chunking here mirrors `reviewdog`'s own diff parser: a suggestion covers
 * every *maximal run* of changed lines inside a hunk, so a hunk holding two
 * edits separated by context becomes two independent one-click suggestions.
 * Keeping the two in step is what lets us count, filter and — above all —
 * recognise a suggestion the contributor already turned down.
 *
 * Every run is positioned by its **old-side** line numbers. The old side is
 * the pull request's own file, which never changes while we work, so those
 * numbers stay valid no matter how many suggestions get dropped along the way.
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

import { createHash } from 'node:crypto'

export interface Hunk {
  oldStart: number
  newStart: number
  /** Body lines, each still carrying its leading ` `, `-`, `+` or `\` marker. */
  body    : string[]
}

export interface FileDiff {
  path : string
  hunks: Hunk[]
}

export interface Run {
  path    : string
  oldLines: string[]
  newLines: string[]
  /** First old-side line this run replaces; the anchor line for a pure insertion. */
  oldStart: number
  /** Last old-side line this run replaces. */
  oldEnd  : number
  /** Stable identity of the proposed replacement, used to skip declined ones. */
  hash    : string
}

const HUNK_RE = /^@@ -(\d+)(?:,(\d+))? \+(\d+)(?:,(\d+))? @@/

/** Identity of a replacement: the file it lands in plus the exact new text. */
export function runHash(path: string, newLines: string[]): string {
  return createHash('sha256')
    .update(`${path} ${newLines.join('\n').replace(/\n+$/, '')}`)
    .digest('hex')
    .slice(0, 16)
}

export function parseDiff(diffText: string): FileDiff[] {
  const files: FileDiff[] = []
  let file: FileDiff | undefined
  let hunk: Hunk | undefined

  const lines = diffText.split('\n')
  if (lines.at(-1) === '') lines.pop() // artefact of the trailing newline

  for (const line of lines) {
    if (line.startsWith('diff --git ')) {
      file = { path: gitDiffPath(line), hunks: [] }
      hunk = undefined
      files.push(file)
      continue
    }

    const hunkMatch = HUNK_RE.exec(line)
    if (hunkMatch) {
      // A bare `@@` block with no `diff --git` header is what the GitHub API
      // hands back in a pull request's per-file `patch` field.
      if (!file) {
        file = { path: '', hunks: [] }
        files.push(file)
      }
      hunk = { oldStart: Number(hunkMatch[1]), newStart: Number(hunkMatch[3]), body: [] }
      file.hunks.push(hunk)
      continue
    }
    if (!file || !hunk) continue // preamble: `index`, `---`, `+++`, mode changes…

    // A blank context line is ` `, but tools that trim trailing whitespace
    // turn it into ``. Treat both as context.
    if (line === '') hunk.body.push(' ')
    else if (/^[ +\-\\]/.test(line)) hunk.body.push(line)
  }
  return files.filter(f => f.hunks.length > 0)
}

/** `diff --git a/scripts/x.zs b/scripts/x.zs` → `scripts/x.zs`. */
function gitDiffPath(line: string): string {
  const rest = line.slice('diff --git '.length)
  return rest.slice(Math.floor(rest.length / 2)).trim().replace(/^b\//, '')
}

interface Span {
  start   : number
  end     : number
  oldLines: string[]
  newLines: string[]
  oldStart: number
  oldEnd  : number
}

/** Walk a hunk, yielding one span per maximal run of changed lines. */
function hunkSpans(hunk: Hunk): Span[] {
  const spans: Span[] = []
  let oldLine = hunk.oldStart

  for (let i = 0; i < hunk.body.length;) {
    const mark = hunk.body[i][0]
    if (mark !== '-' && mark !== '+') {
      if (mark === ' ') oldLine++
      i++
      continue
    }

    let end = i
    while (end < hunk.body.length && '-+\\'.includes(hunk.body[end][0])) end++

    const slice = hunk.body.slice(i, end)
    const oldLines = slice.filter(l => l.startsWith('-')).map(l => l.slice(1))
    const newLines = slice.filter(l => l.startsWith('+')).map(l => l.slice(1))
    spans.push({
      start   : i,
      end,
      oldLines,
      newLines,
      oldStart: oldLine,
      // A pure insertion sits between two old lines; claim the line before it
      // so the run can still be matched against what the pull request touched.
      oldEnd  : oldLine + Math.max(oldLines.length, 1) - 1,
    })
    oldLine += oldLines.length
    i = end
  }
  return spans
}

function toRun(file: FileDiff, span: Span): Run {
  return {
    path    : file.path,
    oldLines: span.oldLines,
    newLines: span.newLines,
    oldStart: span.oldStart,
    oldEnd  : span.oldEnd,
    hash    : runHash(file.path, span.newLines),
  }
}

/** Every suggestion this file's diff would produce, in document order. */
export function collectRuns(file: FileDiff): Run[] {
  return file.hunks.flatMap(hunk => hunkSpans(hunk).map(span => toRun(file, span)))
}

/**
 * Rebuild a file from its pre-format content, taking the formatter's version
 * only for the runs `keep` accepts. Reconstructing beats reverse-applying a
 * patch: neighbouring suggestions often share context lines, which `git apply`
 * refuses to handle as overlapping hunks.
 */
export function rebuildFile(
  file    : FileDiff,
  original: string[],
  keep    : (run: Run) => boolean
): string[] {
  const out: string[] = []
  let cursor = 0 // 0-based index into `original`

  for (const hunk of file.hunks) {
    // Untouched stretch between the previous hunk and this one.
    out.push(...original.slice(cursor, hunk.oldStart - 1))
    cursor = hunk.oldStart - 1

    let index = 0
    for (const span of hunkSpans(hunk)) {
      for (; index < span.start; index++) {
        if (hunk.body[index].startsWith(' ')) out.push(original[cursor++])
      }
      out.push(...(keep(toRun(file, span)) ? span.newLines : span.oldLines))
      cursor += span.oldLines.length
      index = span.end
    }
    for (; index < hunk.body.length; index++) {
      if (hunk.body[index].startsWith(' ')) out.push(original[cursor++])
    }
  }

  out.push(...original.slice(cursor))
  return out
}

/**
 * New-side line numbers a pull request actually added or rewrote, read from the
 * `patch` field the GitHub API returns per file. Suggestions outside this set
 * would be restyling code the contributor never touched.
 */
export function addedLines(patch: string): Set<number> {
  const lines = new Set<number>()
  for (const file of parseDiff(patch)) {
    for (const hunk of file.hunks) {
      let newLine = hunk.newStart
      for (const line of hunk.body) {
        if (line.startsWith('+')) lines.add(newLine++)
        else if (line.startsWith(' ')) newLine++
      }
    }
  }
  return lines
}
