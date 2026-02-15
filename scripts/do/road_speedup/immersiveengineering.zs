#sideonly client
#modloaded immersiveengineering
#reloadable

import crafttweaker.block.IBlockState;
import scripts.do.road_speedup.init.op;

op.addSpeedupBlock(<immersiveengineering:stone_decoration>, function (state as IBlockState) as double {
    val type = state.getPropertyValue('type');
    return type == 'CONCRETE' || type == 'CONCRETE_TILE' || type == 'CONCRETE_LEADED' ? 1.45
      : type == 'HEMPCRETE' ? 1.40
      : 0.0;
  });
op.addSpeedupBlock(<immersiveengineering:stone_decoration_slab>, function (state as IBlockState) as double {
    val type = state.getPropertyValue('type');
    return type == 'CONCRETE' || type == 'CONCRETE_TILE' || type == 'CONCRETE_LEADED' ? 1.45
      : type == 'HEMPCRETE' ? 1.40
      : 0.0;
  });
op.addSpeedupBlock(<immersiveengineering:stone_device>, function (state as IBlockState) as double {
    val type = state.getPropertyValue('type');
    return type == 'CONCRETE_SHEET' || type == 'CONCRETE_QUARTER' || type == 'CONCRETE_THREEQUARTER'? 1.45 : 0.0;
  });
op.addSpeedupBlock(<immersiveengineering:stone_decoration_stairs_hempcrete>, 1.40);
op.addSpeedupBlock(<immersiveengineering:stone_decoration_stairs_concrete>, 1.45);
op.addSpeedupBlock(<immersiveengineering:stone_decoration_stairs_concrete_tile>, 1.45);
op.addSpeedupBlock(<immersiveengineering:stone_decoration_stairs_concrete_leaded>, 1.45);
