#modloaded zenutils scalinghealth
#priority 2000
#reloadable

import native.net.silentchaos512.scalinghealth.config.Config;
import native.net.silentchaos512.scalinghealth.lib.SimpleExpression;

function getPlayerDimDifficulty(playerUUID as string, dim as int) as double {
  var dfclty = scripts.lib.offline.op.get(playerUUID, 'difficulty', 0, 1000) as double;

  val dimMap = Config.Difficulty.DIMENSION_VALUE_FACTOR as native.java.util.HashMap;
  val dimensionFactor = dimMap.get(dim) as SimpleExpression;
  if (!isNull(dimensionFactor)) dfclty = dimensionFactor.apply(dfclty);

  return dfclty;
}
