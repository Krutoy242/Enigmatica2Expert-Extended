#modloaded openterraingenerator
#loader mixin

import native.com.pg85.otg.configuration.dimensions.DimensionsConfig;

/*
🌍 Fix: OTG worlds with the removed "Void" dimension preset can now be launched properly.

This is an E2EE-exclusive patch. In early versions of E2EE, the "Void" preset was added to test
OTG features for a future Skyblock dimension. Later, the Dimension 3 (Void Skyblock world) was
migrated to be handled by the JustEnoughDimensions mod. However, if a world was originally
created with OTG, OTG would still attempt to manage Dim3 using its own code.

This issue did not occur if the server or client created a non-OTG world. However, when both
Overworld and Skyblock players were hosted on the same server, OTG would claim Dim3 for itself,
preventing Nether portals from being lit properly.

More info: https://github.com/Krutoy242/Enigmatica2Expert-Extended/issues/425
*/

#mixin {targets: 'com.pg85.otg.worldsave.DimensionData'}
zenClass MixinDimensionData {
  #mixin Static
  #mixin Redirect 
  #{
  #  method: 'loadDimensionData',
  #  at    : {
  #    value : 'INVOKE',
  #    target: 'Ljava/lang/String;split(Ljava/lang/String;)[Ljava/lang/String;'
  #  }
  #}
  function removeVoidPresetData(str as string, separator as string) as string[] {
    // Remove void dimensions from "Dimensions.txt" file
    return str
      .replaceAll('\\d+,Void,(false|true),\\d+,\\d+,', '')
      .split(separator);
  }

  #mixin Static
  #mixin Definition {id: "exists", method: "Ljava/nio/file/Files;exists(Ljava/nio/file/Path;[Ljava/nio/file/LinkOption;)Z"}
  #mixin Expression {value: "exists(?, ?)"}
  #mixin ModifyExpressionValue {method: "deleteDimSavedData", at: {value: "MIXINEXTRAS:EXPRESSION", ordinal: 0}}
  function skipVanillaWorldDataDeletion(original as bool) as bool {
    /// target source code looks like this:
    /// ```java
    /// // delete vanilla world data. We skip this by making `Files.exists(...)` always return `false`
    /// Path dimensionSaveDir = ...;
    /// if (Files.exists(dimensionSaveDir, ...) && ...) {
    ///     ...
    /// }
    /// // delete OTG world data
    /// dimensionSaveDir = ...;
    /// if (Files.exists(dimensionSaveDir, ...) && ...) {
    ///     ...
    /// }
    /// ```
    return false;
  }
}

#mixin {targets: 'com.pg85.otg.configuration.dimensions.DimensionsConfig'}
zenClass MixinDimensionsConfig {
  #mixin Static
  #mixin ModifyVariable {method: 'loadFromFile', at: { value: 'STORE' }, name: 'presetsConfig'}
  function removeVoidConfigData(presetsConfig as DimensionsConfig) as DimensionsConfig {
    // Remove void dimensions from world-local "Config.yaml" file
    if (isNull(presetsConfig)) return null;
    for dim in presetsConfig.Dimensions {
      if (dim.PresetName == 'Void') {
        presetsConfig.Dimensions.remove(dim);
        break;
      }
    }
    return presetsConfig;
  }
}
