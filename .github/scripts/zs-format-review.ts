/**
 * @file Prepare gentle ZenScript auto-format suggestions for a pull request.
 *
 * Formats only the `.zs` files the pull request touches, keeps only the
 * suggestions that land on lines the contributor actually wrote, throws away
 * anything the formatter cannot reproduce twice in a row, drops everything
 * already turned down, and leaves a unified diff on disk for `reviewdog` to
 * publish as one-click review suggestions.
 *
 * Usage: `tsx .github/scripts/zs-format-review.ts <prepare|summary>`
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

import type { Run } from './zs-format-diff.ts'

import { execFileSync } from 'node:child_process'
import { appendFileSync, existsSync, readFileSync, rmSync, writeFileSync } from 'node:fs'
import process from 'node:process'
import { addedLines, collectRuns, parseDiff, rebuildFile, runHash } from './zs-format-diff.ts'

/** Above this many separate suggestions the pull request gets one patch instead of a comment storm. */
const MAX_INLINE_SUGGESTIONS = 25
/** Never format more files than this in a single run. */
const MAX_FILES = 80

const DIFF_FILE = 'zs-format.diff'
const REPORT_FILE = 'zs-format-report.json'
const SUMMARY_MARKER = '<!-- zs-format-summary -->'
/**
 * Declined suggestions are remembered in the summary comment itself. They
 * cannot simply be re-read from the review threads: once a suggestion stops
 * being offered, reviewdog treats its comment as outdated and deletes it,
 * which would erase the very record of the refusal.
 */
const LEDGER_RE = /<!-- zs-format-declined:([\w,]*) -->/

const token = requireEnv('GITHUB_TOKEN')
const [owner, repo] = requireEnv('GITHUB_REPOSITORY').split('/')
const prNumber = Number(requireEnv('PR_NUMBER'))
const dryRun = process.env.DRY_RUN === 'true'

interface Report {
  mode      : 'none' | 'inline' | 'summary'
  files     : string[]
  unstable  : string[]
  suggested : number
  /** Dropped because they fall outside the lines this pull request touched. */
  untouched : number
  /** Dropped because the contributor already said no to them. */
  declined  : number
  /** Everything ever turned down here, carried forward into the next run. */
  ledger    : string[]
  patch     : string
}

const command = process.argv[2] ?? 'prepare'
if (command === 'prepare') await prepare()
else if (command === 'summary') await summary()
else fail(`Unknown command: ${command}`)

async function prepare(): Promise<void> {
  // Read the ledger first: even with nothing to suggest this run, the record of
  // what was turned down has to survive into the next one.
  const declined = new Set([...await ledgerHashes(), ...await declinedHashes()])
  const touched = await changedZsFiles()
  const files = [...touched.keys()].slice(0, MAX_FILES)
  const empty = {
    mode     : 'none',
    files,
    unstable : [],
    suggested: 0,
    untouched: 0,
    declined : 0,
    ledger   : [...declined],
    patch    : '',
  } as const
  if (files.length === 0) return finish({ ...empty, files: [] })

  log(`Formatting ${files.length} changed .zs file(s)`)
  format(files)

  // Gate: a formatter that cannot settle on an answer is a formatter with a
  // bug. Run it twice and drop any file whose second pass moves again.
  const afterFirstPass = new Map(files.map(f => [f, read(f)]))
  format(files)
  const unstable = files.filter(f => read(f) !== afterFirstPass.get(f))
  if (unstable.length > 0) {
    log(`Not idempotent, leaving alone: ${unstable.join(', ')}`)
    git(['checkout', '--', ...unstable])
  }
  cleanStrayTs(files)

  const stable = files.filter(f => !unstable.includes(f))
  const all = diffRuns(stable)
  if (all.length === 0) return finish({ ...empty, unstable })

  const isOnTouchedLine = (run: Run): boolean => {
    const lines = touched.get(run.path)
    if (!lines) return false
    for (let n = run.oldStart; n <= run.oldEnd; n++) if (lines.has(n)) return true
    return false
  }
  const keep = (run: Run): boolean => !declined.has(run.hash) && isOnTouchedLine(run)

  const untouched = all.filter(run => !isOnTouchedLine(run)).length
  const rejected = all.filter(run => declined.has(run.hash) && isOnTouchedLine(run)).length
  log(`${all.length} formatter change(s): ${untouched} outside this PR, ${rejected} previously declined`)

  if (all.length !== all.filter(keep).length) restrictTo(stable, keep)
  const runs = diffRuns(stable)
  if (runs.length === 0) {
    return finish({ ...empty, unstable, untouched, declined: rejected })
  }

  const patch = git(['diff', '--', ...stable])
  const mode = runs.length > MAX_INLINE_SUGGESTIONS ? 'summary' : 'inline'
  if (mode === 'summary') log(`${runs.length} suggestions is too many to leave inline — falling back to a patch`)

  finish({
    mode,
    files,
    unstable,
    suggested: runs.length,
    untouched,
    declined : rejected,
    ledger   : [...declined],
    patch,
  })
}

/** Re-read the working tree as the exact set of suggestions we would publish. */
function diffRuns(files: string[]): Run[] {
  if (files.length === 0) return []
  return parseDiff(git(['diff', '--', ...files])).flatMap(collectRuns)
}

/**
 * Put back the pre-format text of every run `keep` rejects, so the working tree
 * ends up holding exactly the suggestions that will be offered — no more.
 */
function restrictTo(files: string[], keep: (run: Run) => boolean): void {
  for (const file of parseDiff(git(['diff', '--', ...files]))) {
    const before = git(['show', `HEAD:${file.path}`])
    const rebuilt = rebuildFile(file, splitLines(before), keep)
    const eol = before.endsWith('\n') || read(file.path).endsWith('\n')
    writeFileSync(file.path, rebuilt.join('\n') + (eol ? '\n' : ''))
  }

  // Self-check: if a rejected suggestion survived the rebuild, the safe move is
  // to drop that file from the review entirely rather than nag about it again.
  for (const file of parseDiff(git(['diff', '--', ...files]))) {
    if (!collectRuns(file).every(keep)) {
      log(`Rebuild of ${file.path} did not settle — leaving the file alone`)
      git(['checkout', '--', file.path])
    }
  }
}

function format(files: string[]): void {
  try {
    execFileSync('pnpm', ['exec', 'mctools-format', ...files], {
      stdio: ['ignore', 'inherit', 'inherit'],
      env  : { ...process.env, npm_config_reporter: 'default' },
      // `pnpm` is a `.CMD` shim on Windows, which needs a shell to launch.
      shell: process.platform === 'win32',
    })
  }
  catch (error) {
    // The CLI reports unparsable files and leaves them untouched, so a non-zero
    // exit must never take the whole review down — but say so out loud.
    log(`Formatter exited non-zero, continuing with whatever it changed: ${String(error)}`)
  }
}

/** The CLI writes `<file>.ts` next to each source and removes it — unless it crashed. */
function cleanStrayTs(files: string[]): void {
  for (const f of files) rmSync(`${f}.ts`, { force: true })
}

async function summary(): Promise<void> {
  const report = JSON.parse(read(REPORT_FILE)) as Report
  const existing = await findSummaryComment()

  // Nothing to say and nothing to remember — take the comment away entirely.
  if (report.mode === 'none' && report.ledger.length === 0) {
    if (existing !== undefined && !dryRun) {
      await api(`/repos/${owner}/${repo}/issues/comments/${existing.id}`, { method: 'DELETE' })
      log('Removed the stale summary comment — nothing left to suggest')
    }
    return
  }

  const body = buildSummary(report)
  if (dryRun) return log(`[dry-run] summary comment:\n${body}`)

  if (existing !== undefined) {
    await api(`/repos/${owner}/${repo}/issues/comments/${existing.id}`, {
      method: 'PATCH',
      body  : JSON.stringify({ body }),
    })
  }
  else {
    await api(`/repos/${owner}/${repo}/issues/${prNumber}/comments`, {
      method: 'POST',
      body  : JSON.stringify({ body }),
    })
  }
}

function buildSummary(report: Report): string {
  const ledger = `<!-- zs-format-declined:${report.ledger.join(',')} -->`
  if (report.mode === 'none') {
    return [
      SUMMARY_MARKER,
      '### 🧹 ZenScript auto-format',
      '',
      'Nothing to suggest — the changed `.zs` lines already match the project style.',
      '',
      `<sub>${plural(report.ledger.length, 'earlier suggestion')} declined here, and will not be raised again.</sub>`,
      ledger,
    ].join('\n')
  }

  const lines = [
    SUMMARY_MARKER,
    '### 🧹 ZenScript auto-format',
    '',
    'The project runs an automatic formatter over `.zs` scripts, and it has a few ideas about the lines',
    'changed here. **This is only a suggestion — nothing on this list blocks the pull request.**',
    '',
  ]

  if (report.mode === 'inline') {
    lines.push(
      `I left ${plural(report.suggested, 'suggestion')} as review comments so you can apply one with a single click,`,
      'or press *Add suggestion to batch* and commit several at once.',
    )
  }
  else {
    lines.push(
      `There are ${plural(report.suggested, 'suggestion')} here — too many to leave as individual comments,`,
      'so here is the whole thing as a patch instead:',
      '',
      '<details><summary>Apply everything at once</summary>',
      '',
      '```sh',
      'git apply <<\'PATCH\'',
      report.patch.trimEnd(),
      'PATCH',
      '```',
      '',
      '</details>',
    )
  }

  lines.push(
    '',
    'If a suggestion looks wrong, resolve the thread or give it a 👎 — it will not come back on later pushes.',
    'The formatter is a helper, not a reviewer; your judgement wins.',
  )

  if (report.untouched > 0) {
    lines.push(
      '',
      `<sub>${plural(report.untouched, 'further change')} would restyle lines this pull request never touched — left alone on purpose.</sub>`,
    )
  }
  if (report.unstable.length > 0) {
    lines.push(
      '',
      `⚠️ The formatter could not produce a stable result for ${report.unstable.map(f => `\`${f}\``).join(', ')}, `
      + 'so those files were skipped. That is a bug in the formatter, not in your code.',
    )
  }

  if (report.declined > 0) {
    lines.push(
      '',
      `<sub>${plural(report.declined, 'suggestion')} you already turned down stayed out of this list.</sub>`,
    )
  }

  lines.push(
    '',
    '<sub>Add the <code>skip-format</code> label to silence this check on this pull request.</sub>',
    ledger,
  )
  return lines.join('\n')
}

async function findSummaryComment(): Promise<{ id: number, body: string } | undefined> {
  const comments = await api<Array<{ id: number, body?: string }>>(
    `/repos/${owner}/${repo}/issues/${prNumber}/comments?per_page=100`
  )
  const found = comments.find(c => c.body?.includes(SUMMARY_MARKER))
  return found && { id: found.id, body: found.body ?? '' }
}

/** Suggestions turned down on an earlier run, as recorded in the summary comment. */
async function ledgerHashes(): Promise<string[]> {
  const existing = await findSummaryComment()
  const recorded = LEDGER_RE.exec(existing?.body ?? '')?.[1]
  return recorded ? recorded.split(',').filter(Boolean) : []
}

/** Changed `.zs` files mapped to the line numbers this pull request added. */
async function changedZsFiles(): Promise<Map<string, Set<number>>> {
  const found = new Map<string, Set<number>>()
  for (let page = 1; page <= 30; page++) {
    const batch = await api<Array<{ filename: string, status: string, patch?: string }>>(
      `/repos/${owner}/${repo}/pulls/${prNumber}/files?per_page=100&page=${page}`
    )
    for (const f of batch) {
      if (f.status === 'removed' || !f.filename.endsWith('.zs')) continue
      // `scripts/craft` is a submodule — its contents are not ours to restyle.
      if (f.filename.startsWith('scripts/craft/')) continue
      if (existsSync(f.filename)) found.set(f.filename, addedLines(f.patch ?? ''))
    }
    if (batch.length < 100) break
  }
  return found
}

/**
 * Suggestions the contributor has already answered: a resolved thread, a 👎,
 * or any human reply all mean "leave it alone".
 */
async function declinedHashes(): Promise<Set<string>> {
  const hashes = new Set<string>()
  const query = `
    query($owner:String!,$name:String!,$number:Int!,$cursor:String){
      repository(owner:$owner,name:$name){
        pullRequest(number:$number){
          reviewThreads(first:100,after:$cursor){
            pageInfo{ hasNextPage endCursor }
            nodes{
              isResolved
              path
              comments(first:50){
                nodes{
                  body
                  author{ login }
                  reactions(content:THUMBS_DOWN){ totalCount }
                }
              }
            }
          }
        }
      }
    }`

  let cursor: string | undefined
  for (let page = 0; page < 10; page++) {
    const data = await graphql<GraphqlThreads>(query, { owner, name: repo, number: prNumber, cursor })
    const threads = data.repository?.pullRequest?.reviewThreads
    if (!threads) break

    for (const thread of threads.nodes) {
      const [first, ...replies] = thread.comments.nodes
      if (!first || !isBot(first.author?.login)) continue

      const thumbsDown = first.reactions.totalCount > 0
      const humanReply = replies.some(c => !isBot(c.author?.login))
      if (!thread.isResolved && !thumbsDown && !humanReply) continue

      const suggestion = extractSuggestion(first.body)
      if (suggestion !== undefined) hashes.add(runHash(thread.path, suggestion))
    }

    if (!threads.pageInfo.hasNextPage) break
    cursor = threads.pageInfo.endCursor
  }
  if (hashes.size > 0) log(`${hashes.size} suggestion(s) were previously declined`)
  return hashes
}

function isBot(login: string | undefined): boolean {
  return login === 'github-actions' || login === 'github-actions[bot]'
}

/** Pull the replacement text back out of a posted ```suggestion block. */
function extractSuggestion(body: string): string[] | undefined {
  const match = /(`{3,})suggestion\r?\n([\s\S]*?)\r?\n?\1/.exec(body)
  if (!match) return undefined
  // GitHub hands the body back with CRLF line endings.
  return match[2].split('\n').map(line => line.replace(/\r$/, ''))
}

interface GraphqlThreads {
  repository?: {
    pullRequest?: {
      reviewThreads: {
        pageInfo: { hasNextPage: boolean, endCursor: string }
        nodes   : Array<{
          isResolved: boolean
          path      : string
          comments  : { nodes: Array<{
            body     : string
            author?  : { login: string }
            reactions: { totalCount: number }
          }> }
        }>
      }
    }
  }
}

async function api<T = unknown>(path: string, init: RequestInit = {}): Promise<T> {
  const res = await fetch(`https://api.github.com${path}`, {
    ...init,
    headers: {
      'accept'              : 'application/vnd.github+json',
      'authorization'       : `Bearer ${token}`,
      'x-github-api-version': '2022-11-28',
      ...init.headers,
    },
  })
  if (!res.ok) fail(`${init.method ?? 'GET'} ${path} → ${res.status} ${await res.text()}`)
  return res.status === 204 ? (undefined as T) : await res.json() as T
}

async function graphql<T>(query: string, variables: Record<string, unknown>): Promise<T> {
  const res = await api<{ data?: T, errors?: Array<{ message: string }> }>('/graphql', {
    method: 'POST',
    body  : JSON.stringify({ query, variables }),
  })
  if (res.errors?.length) fail(`GraphQL: ${res.errors.map(e => e.message).join('; ')}`)
  return res.data as T
}

function finish(report: Report): void {
  writeFileSync(REPORT_FILE, JSON.stringify(report, null, 2))
  // Always leave a diff behind, empty ones included: reviewdog reads it to work
  // out which of its earlier comments no longer apply and should be taken down.
  writeFileSync(DIFF_FILE, report.mode === 'inline' ? report.patch : '')
  const out = process.env.GITHUB_OUTPUT
  if (out) appendFileSync(out, `mode=${report.mode}\ncount=${report.suggested}\n`)
  log(`mode=${report.mode} suggestions=${report.suggested} untouched=${report.untouched} `
    + `declined=${report.declined} unstable=${report.unstable.length}`)
}

function git(args: string[]): string {
  return execFileSync('git', args, { encoding: 'utf8', maxBuffer: 64 * 1024 * 1024 })
}

function read(file: string): string {
  return readFileSync(file, 'utf8')
}

function splitLines(content: string): string[] {
  const lines = content.split('\n')
  if (lines.at(-1) === '') lines.pop()
  return lines
}

function plural(n: number, word: string): string {
  return `${n} ${word}${n === 1 ? '' : 's'}`
}

function requireEnv(name: string): string {
  const value = process.env[name]
  if (!value) fail(`Missing required environment variable ${name}`)
  return value
}

function log(message: string): void {
  process.stdout.write(`${message}\n`)
}

function fail(message: string): never {
  process.stderr.write(`${message}\n`)
  process.exit(1)
}
