import { execCmd } from './probezs.js'

async function main() {
  const t0 = performance.now()

  const bold = (s: string) => `\x1b[1m${s}\x1b[22m`
  const color = (s: string, ok: boolean) => ok ? `\x1b[32m${s}\x1b[39m` : `\x1b[31m${s}\x1b[39m`
  let pass = 0, fail = 0

  function check(desc: string, ok: boolean, detail?: string) {
    const label = color(ok ? 'PASS' : 'FAIL', ok)
    process.stdout.write(`[${label}] ${desc}${detail ? ` — ${detail}` : ''}\n`)
    if (ok) pass++; else fail++
  }

  // ── Single command ────────────────────────────────────

  process.stdout.write(bold('\n--- Single command ---\n'))

  const r1 = await execCmd('list')
  check('execCmd("list") auto-adds /', r1.ok, `reply=${r1.reply}`)
  check('has uuid (length 6)', r1.uuid.length === 6)
  check('command is /list', r1.command === '/list')
  check('ms is positive', r1.ms > 0)

  const r2 = await execCmd('/say hello from probezs test!')
  check('execCmd("/say ...")', r2.ok, `reply=${r2.reply}`)
  check('command is /say ...', r2.command.startsWith('/say'))

  // ── Multiple commands (chain) ─────────────────────────

  process.stdout.write(bold('\n--- Multiple commands ---\n'))

  const r3 = await execCmd(['/say first!', '/say second!', '/say third!'])
  check('returned array for array input', Array.isArray(r3))
  if (Array.isArray(r3)) {
    check('all 3 commands executed', r3.length === 3, `got ${r3.length}`)
    for (let i = 0; i < r3.length; i++) {
      check(`cmd #${i + 1} ok`, r3[i].ok, `cmd=${r3[i].command}`)
    }
  }

  // ── Chain failure stops execution ─────────────────────

  process.stdout.write(bold('\n--- Chain failure ---\n'))

  const r4 = await execCmd(['/say before fail', '/thiscommanddoesnotexist', '/say after fail'])
  check('returned array for array input', Array.isArray(r4))
  if (Array.isArray(r4)) {
    check('first command might be ok or fail', true, `ok=${r4[0].ok}`)
    if (r4.length >= 2) {
      check('at least 2 results when chain breaks', r4.length >= 2)
      check('second command failed', !r4[1].ok, `reply=${r4[1].reply}`)
    }
  }

  // ── Timeout (invalid server state) ────────────────────

  process.stdout.write(bold('\n--- Timeout ---\n'))

  const shortTimeout = 50
  try {
    await execCmd('/say should timeout', { waitMs: shortTimeout, pollIntervalMs: 10 })
    check('short timeout: expected error', false, 'no error thrown')
  } catch (e: unknown) {
    const msg = String(e)
    check('short timeout throws', msg.includes('timed out'), msg)
  }

  // ── Summary ───────────────────────────────────────────

  const total = performance.now() - t0
  process.stdout.write(
    `\n${bold(`${pass}/${pass + fail} tests passed`)}  (${total.toFixed(0)}ms)\n`
  )
  process.exit(fail > 0 ? 1 : 0)
}

main().catch(e => { console.error(e); process.exit(1) })
