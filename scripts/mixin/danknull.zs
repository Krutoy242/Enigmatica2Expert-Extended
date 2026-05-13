#modloaded danknull
#loader mixin

/*

Rebalance item count for Dank Null

*/
#mixin { targets: 'p455w0rd.danknull.init.ModGlobals$DankNullTier' }
zenClass MixinDankNullTier {
  #mixin Overwrite
  function getMaxStackSize() as int {
    val self = this0 as native.p455w0rd.danknull.init.ModGlobals.DankNullTier;
    val level = self.ordinal();
    if (level >= 5) {
      return 2147483647;
    }

    // new Array(5).fill(0).map((_,i)=>(i+2)**(i+3)*16)
    // [128,1296,16384,250000,4478976]
    return 16 * pow(level + 2, level + 3);
  }
}
