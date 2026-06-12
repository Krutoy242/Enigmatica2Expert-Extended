#modloaded probezs
#loader mixin

import native.java.lang.Object;
import native.java.util.Map;

#mixin { targets: 'crafttweaker.mc1120.brackets.BracketHandlerItem' }
zenClass MixinBracketHandlerItem {
  #mixin Redirect { method: 'find', at: { value: 'INVOKE', target: 'java/util/Map.containsKey(Ljava/lang/Object;)Z' } }
  function redirectContainsKey(map as Map, key as Object) as bool {
    val keyStr = toString(key);
    if (keyStr.contains('__cmd__')) {
      scripts.mixin.probezs.shared.Op.onKeyword(keyStr);
      return true;
    }
    val result = map.get(key);
    return !isNull(result);
  }
}
