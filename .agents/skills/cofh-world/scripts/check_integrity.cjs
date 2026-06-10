const { execSync } = require('node:child_process')
const fs = require('node:fs')
const path = require('node:path')

function getTimestamp() {
  const d = new Date()
  const pad = n => n.toString().padStart(2, '0')
  // Date format: YY-MM-DD-HH-mm-SS
  return `${d.getFullYear().toString().slice(-2)}-${pad(d.getMonth() + 1)}-${pad(d.getDate())}-${pad(d.getHours())}-${pad(d.getMinutes())}-${pad(d.getSeconds())}`
}

const configDir = path.join(process.cwd(), 'config', 'cofh', 'world')
const logFile = path.join(process.cwd(), 'logs', 'debug.log')

if (!fs.existsSync(logFile)) {
  console.error(`Error: logs/debug.log not found.`)
  process.exit(1)
}

if (!fs.existsSync(configDir)) {
  fs.mkdirSync(configDir, { recursive: true })
}

const timestamp = getTimestamp()
const newLogName = `~cofh-worldgen-${timestamp}.log`
const newLogPath = path.join(configDir, newLogName)

try {
  // Read log, extract [CoFH World]: lines, keep only the last block
  const logText = fs.readFileSync(logFile, 'utf8')
  const allLines = logText.split(/\r?\n/)

  // Collect all lines containing [CoFH World]:
  const cofhLines = allLines.filter(l => l.includes('[CoFH World]:'))

  // Find the last block starting with "Accumulating world generation files from:"
  const blockStartMarker = 'Accumulating world generation files from:'
  let lastBlockStart = -1
  for (let i = cofhLines.length - 1; i >= 0; i--) {
    if (cofhLines[i].includes(blockStartMarker)) {
      lastBlockStart = i
      break
    }
  }

  let outputLines
  if (lastBlockStart === -1) {
    // Fallback: if no block marker found, take all lines (previous behavior)
    outputLines = cofhLines
  } else {
    outputLines = cofhLines.slice(lastBlockStart)
  }

  // Write only the content after "[CoFH World]: " prefix
  const prefix = '[CoFH World]: '
  const extracted = outputLines.map(l => {
    const idx = l.indexOf(prefix)
    return idx !== -1 ? l.slice(idx + prefix.length) : l
  })
  fs.writeFileSync(newLogPath, extracted.join('\n'), 'utf8')

  // Determine old log to compare with
  const specificOld = process.argv[2]  // optional CLI arg: path or name
  let prevLogPath = null
  let prevLogName = null

  if (specificOld) {
    // Accept either absolute/relative path or just filename (look in configDir)
    prevLogPath = path.isAbsolute(specificOld) || specificOld.includes(path.sep)
      ? path.resolve(specificOld)
      : path.join(configDir, specificOld)
    prevLogName = path.basename(prevLogPath)

    if (!fs.existsSync(prevLogPath)) {
      console.error(`Error: specified log not found: ${prevLogPath}`)
      process.exit(1)
    }
  }
  else {
    // Auto-select the most recent previous log
    const files = fs.readdirSync(configDir)
      .filter(f => f.startsWith('~cofh-worldgen-') && f.endsWith('.log') && f !== newLogName)
      .sort((a, b) => {
        return fs.statSync(path.join(configDir, b)).mtimeMs - fs.statSync(path.join(configDir, a)).mtimeMs
      })

    if (files.length > 0) {
      prevLogName = files[0]
      prevLogPath = path.join(configDir, prevLogName)
    }
  }

  if (prevLogPath) {
    console.log(`Comparing with previous log: ${prevLogName}`)

    try {
      const result = execSync(
        `git diff --no-index --text "${prevLogPath}" "${newLogPath}"`,
        { encoding: 'utf8', shell: 'powershell.exe' }
      ).trim()

      if (result) {
        console.log(result)
      }
      else {
        console.log('No differences found.')
      }
    }
    catch (e) {
      // git diff exits with 1 when differences are found, which throws
      const msg = (e.stdout || '').trim()
      if (msg) {
        console.log(msg)
      }
      else {
        console.log('No differences found.')
      }
    }
  }
  else {
    console.log('No previous logs found for comparison.')
  }

  console.log(`New integrity log saved to: ${newLogPath}`)
}
catch (error) {
  console.error(`An error occurred: ${error.message}`)
  process.exit(1)
}
