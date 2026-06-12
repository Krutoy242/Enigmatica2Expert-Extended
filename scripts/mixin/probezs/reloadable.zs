#modloaded probezs zenutils

import scripts.mixin.probezs.sender.CmdCapture;
import native.net.minecraft.command.ICommandSender;

// FIXME: This script should be reloadable, but
// When agents changing code and make syntax mistakes,
// /ct reload breaking all the reloadable scripts. So,
// after one unlucky reload, agent can't fix use commands anymore and
// forced to restart Minecraft.
// #reloadable

//
// ── Character limitations ──────────────────────────────────
// ZenTokener strips/modifies these characters in bracket expressions:
//
//   ' ' \t \r \n   → whitespace, STRIPPED (separates tokens)
//   '\\' (0x5C)    → NOT a token, causes ZenTokener exception
//   '@'  (0x40)    → NOT a token, causes ZenTokener exception
//   '#'  (0x23)    → starts line comment, eats rest of expression
//
// Characters that SURVIVE as tokens:
//   a-z A-Z 0-9 _ . , ; : ! ? ( ) [ ] { } < > = + - * / % & | ^ ~ $
//
// ── Encoding scheme ────────────────────────────────────────
// Forbidden chars → hex ASCII code prefixed with '%':
//   '%'  (0x25) → %25       ' '  (0x20) → %20
//   '\t' (0x09) → %09       '\r' (0x0D) → %0D
//   '\n' (0x0A) → %0A       '\\' (0x5C) → %5C
//   '@'  (0x40) → %40       '#'  (0x23) → %23
//   '$'  (0x24) → %24
//
// '%' is the encoding prefix; the Node side encodes a literal '%' as %25 so the
// wire only ever contains real %XX codes. Decode %25 → '%' LAST so the percent
// we emit cannot recombine with following digits into a spurious %XX.
// ──────────────────────────────────────────────────────────

function decode(s as string) as string {
  var result = s;
  result = result.replace('%20', ' ');
  result = result.replace('%09', '\t');
  result = result.replace('%0D', '\r');
  result = result.replace('%0A', '\n');
  result = result.replace('%40', '@');
  result = result.replace('%23', '#');
  result = result.replace('%5C', '\\');
  result = result.replace('%24', '$');
  result = result.replace('%A7', '§');
  result = result.replace('%25', '%'); // LAST
  return result;
}

// Encode captured command output for the reply so it stays a single line on the
// wire (RMI return value) and in crafttweaker.log. Only newline-relevant chars
// need escaping here (the reply is a plain return value, not a bracket token).
// Escape '%' FIRST so the %XX codes we add afterwards are not re-escaped; the
// Node side mirrors this by decoding %25 LAST.
function encode(s as string) as string {
  var result = s;
  result = result.replace('%', '%25'); // FIRST
  result = result.replace('\r', '%0D');
  result = result.replace('\n', '%0A');
  return result;
}

scripts.mixin.probezs.shared.Op.onKeyword
  = function (expr as string) as string {
    val start = expr.startsWith('<') ? 1 : 0;
    val end = expr.endsWith('>') ? expr.length() - 1 : expr.length();
    val inner = expr.substring(start, end);

    if (inner.startsWith('__cmd__:exec:')) {
      val raw = inner.substring('__cmd__:exec:'.length());
      val colonPos = raw.indexOf(':');
      val uuid = raw.substring(0, colonPos);
      val cmd = decode(raw.substring(colonPos + 1));

      // Feature 1: announce the action server-side (visible in the server log).
      server.sendMessage('[Server]: RMI Command uid:' ~ uuid ~ ' "' ~ cmd ~ '"');

      // Feature 2: run the command through a capturing sender so its output is
      // collected on the sender side instead of being scraped from debug.log.
      val capture = CmdCapture(server.native);
      val capSender as ICommandSender = capture;
      val result = server.commandManager.executeCommand(capSender.wrapper, cmd);
      val ok = result != 0;

      server.sendMessage('[Server]: RMI Command uid:' ~ uuid ~ ' ' ~ (ok ? '✓' : '✗'));

      val reply = (ok ? 'OK' : 'FAIL') ~ ':exec:' ~ uuid ~ ':' ~ encode(capture.buffer);
      print(reply);
      return reply;
    }

    val err = 'ERR:unknown:' ~ expr;
    print(err);
    return err;
  };
