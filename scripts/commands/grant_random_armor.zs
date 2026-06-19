#modloaded zenutils zentoolforge
#priority -100
#reloadable

import crafttweaker.util.Math.max;
import crafttweaker.util.Math.min;
import modtweaker.tconstruct.ITICMaterial;
import mods.zenutils.command.CommandUtils;
import mods.zenutils.command.ZenCommand;
import scripts.equipment.equipData;

val grantCmd as ZenCommand = ZenCommand.create('grant_random_armor');
grantCmd.getCommandUsage = function (sender) {
  return '/grant_random_armor [<player|@p>] [<difficulty 0.0..1.0>]';
};

grantCmd.requiredPermissionLevel = 2;
grantCmd.execute = function (command, server, sender, args) {
  val online = server.players;
  if (isNull(online) || online.length == 0) {
    CommandUtils.notifyWrongUsage(command, sender);
    return;
  }

  // `/grant_random_armor dump` -> log every modifier with its effective points
  if (args.length == 1 && args[0] == 'dump') {
    scripts.equipment.modifierGen.dumpModifierPoints();
    sender.sendMessage('Dumped modifier points to log (search [modifierGen]).');
    return;
  }

  // Default to first online player (works from console in singleplayer)
  var targetPlayer = online[0];
  var difficulty = 0.0;

  // `/grant_random_armor mat <material> <difficulty>` -> force a single material
  // (handy for testing Draconic-Evolution gating, e.g. mat wyvern_metal 1.0)
  var forcedMat as string = null;
  if (args.length >= 1 && args[0] == 'mat') {
    forcedMat = args[1];
    difficulty = args.length >= 3 ? min(1.0, max(0.0, args[2] as double)) : 1.0;
  } else if (args.length >= 2) {
    val playerArg = args[0];
    if (!playerArg.startsWith('@')) {
      val named = server.getPlayerByUsername(playerArg);
      if (!isNull(named)) targetPlayer = named;
    }
    difficulty = min(1.0, max(0.0, args[1] as double));
  } else if (args.length == 1) {
    difficulty = min(1.0, max(0.0, args[0] as double));
  }

  val world = targetPlayer.world;
  var forcedMatList as ITICMaterial[] = null;
  if (!isNull(forcedMat)) {
    val m = mods.zentoolforge.Toolforge.getMaterialFromID(forcedMat);
    forcedMatList = [m, m, m, m] as ITICMaterial[];
  }
  val armorMats = isNull(forcedMatList)
    ? scripts.equipment.equipGeneration.getFourRandomTicMats(null, difficulty, false, world)
    : forcedMatList;

  print('[grant_random_armor] difficulty=' ~ difficulty);

  // ---- Armor pieces ----
  for i in 0 .. 4 {
    val defId = equipData.armDefinitions[i][0];
    val equipDef = itemUtils.getItem(defId);
    if (isNull(equipDef)) continue;

    var equip = scripts.equipment.equipGeneration.buildTiCTool(armorMats, equipDef.definition);
    if (isNull(equip)) continue;

    equip = scripts.equipment.modifierGen.generateModifiers(equip, true, difficulty, world);

    if (equip.isDamageable) {
      val rndDamage = (0.35 + world.random.nextDouble() / 2.0) * equip.maxDamage;
      val dmg = min(32766, max(1, rndDamage as int));
      equip = equip.withDamage(dmg);
    }

    print('[grant_random_armor] ' ~ defId ~ ': ' ~ equip.displayName ~ ' :: ' ~ scripts.equipment.modifierGen.describeItem(equip));
    targetPlayer.give(equip);
  }

  // ---- Random tool / weapon  [#8] ----
  val weapons = equipData.armDefinitions[4];
  val weaponId = weapons[(world.random.nextDouble() * weapons.length) as int];
  val weaponDef = itemUtils.getItem(weaponId);
  if (!isNull(weaponDef)) {
    val weaponMats = isNull(forcedMatList)
      ? scripts.equipment.equipGeneration.getFourRandomTicMats(null, difficulty, true, world)
      : forcedMatList;
    var weapon = scripts.equipment.equipGeneration.buildTiCTool(weaponMats, weaponDef.definition);
    if (!isNull(weapon)) {
      weapon = scripts.equipment.modifierGen.generateModifiers(weapon, false, difficulty, world);
      if (weapon.isDamageable) {
        val rndDamage = (0.35 + world.random.nextDouble() / 2.0) * weapon.maxDamage;
        weapon = weapon.withDamage(min(32766, max(1, rndDamage as int)));
      }
      print('[grant_random_armor] ' ~ weaponId ~ ': ' ~ weapon.displayName ~ ' :: ' ~ scripts.equipment.modifierGen.describeItem(weapon));
      targetPlayer.give(weapon);
    }
  }

  targetPlayer.sendMessage('Granted armor + weapon (difficulty=' ~ difficulty ~ ')');
};
grantCmd.register();
