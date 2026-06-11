#priority 100
#reloadable

import crafttweaker.item.IIngredient;

// Since its a lib, allow users of this lib to control flow of the iteration
static CB_RESULT as int[string] = {
  CONTINUE: 0,
  STOP_MOD: 1,
  STOP_FULL: 2,
};

// cb(inputs, outputs) -> CB_RESULT
static enuerators as [function(function(IIngredient[],IIngredient[])int)bool] = [];

// Pre-computed recipe pairs from all enumerators (built on first iterate() call)
static _cacheOut as [IIngredient[]] = [];
static _cacheIn  as [IIngredient[]] = [];
static _ready as bool = false;

function iterate(cb as function(IIngredient[],IIngredient[])int) as void {
  if (!_ready) {
    for i, fnc in enuerators {
      fnc(function(outputs as IIngredient[], inputs as IIngredient[]) as int {
        _cacheOut.add(outputs);
        _cacheIn.add(inputs);
        return CB_RESULT.CONTINUE;
      });
    }
    _ready = true;
  }

  for i in 0 .. _cacheOut.length {
    if (cb(_cacheOut[i], _cacheIn[i]) == CB_RESULT.STOP_FULL) return;
  }
}
