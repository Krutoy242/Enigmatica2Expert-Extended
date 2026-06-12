#modloaded probezs zenutils
#reloadable
#priority 2000

# ── Capturing command sender ───────────────────────────────
# A custom ICommandSender that BUFFERS every feedback message instead of
# broadcasting it. Running a command through this sender lets us read back
# exactly what the command printed, and return it to the RMI caller directly
# (replacing the old debug.log scraping).
#
# Notes:
# - ZenUtils class inheriting does NOT inherit Java interface `default` methods —
#   they stay abstract and throw AbstractMethodError when a command calls them.
#   Therefore EVERY ICommandSender method is overridden here.
# - Overrides must use SRG names (MCP name kept in a comment for readability).
# - Lives in its own (non-#reloadable) file so the generated class is created
#   once; reloadable.zs only references it.

import native.net.minecraft.command.ICommandSender;
import native.net.minecraft.util.text.ITextComponent;
import native.net.minecraft.util.text.TextComponentString;
import native.net.minecraft.world.World;
import native.net.minecraft.util.math.BlockPos;
import native.net.minecraft.util.math.Vec3d;
import native.net.minecraft.server.MinecraftServer;
import native.net.minecraft.entity.Entity;
import native.net.minecraft.command.CommandResultStats.Type as ResultStatsType;

zenClass CmdCapture extends ICommandSender {
  var buffer as string = "";
  var srv as MinecraftServer = null;

  zenConstructor(server as MinecraftServer) {
    this.srv = server;
  }

  // getName
  function func_70005_c_() as string { return "ProbeRMI"; }

  // getDisplayName
  function func_145748_c_() as ITextComponent {
    val c as ITextComponent = TextComponentString("ProbeRMI");
    return c;
  }

  // sendMessage — capture instead of broadcast
  function func_145747_a(component as ITextComponent) as void {
    this.buffer = this.buffer ~ component.getUnformattedText() ~ "\n";
  }

  // canUseCommand — allow everything (run as the server does)
  function func_70003_b(permLevel as int, commandName as string) as bool { return true; }

  // getPosition
  function func_180425_c() as BlockPos { return BlockPos(0, 0, 0); }

  // getPositionVector
  function func_174791_d() as Vec3d { return Vec3d(0.0, 0.0, 0.0); }

  // getEntityWorld
  function func_130014_f_() as World {
    val w as World = this.srv.worlds[0];
    return w;
  }

  // getCommandSenderEntity
  function func_174793_f() as Entity { return null; }

  // sendCommandFeedback — true so notifyCommandListener routes feedback to us
  function func_174792_t_() as bool { return true; }

  // setCommandStat — no-op
  function func_174794_a(statType as ResultStatsType, amount as int) as void {}

  // getServer
  function func_184102_h() as MinecraftServer { return this.srv; }
}
