
#priority 4500
#reloadable

/*
 ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗
██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝
██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗
██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║
╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝
 ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝
*/

zenClass Config {
  // Number of ticks between block spread event
  // Can be 0<x<1. In this case 1/spreadDelay blocks would be transformed for the same tick
  static spreadDelay as double = 1.0;

  // Number of blocks that would be checked for replacement
  static blockChecks as int = 50;

  // Debug mode to output all portal spread actions
  static debug as bool = false;

	zenConstructor() { }
}
static config as Config = Config();