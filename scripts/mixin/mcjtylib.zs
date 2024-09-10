#loader mixin

/*
Fix xnet not displaying rf/t for energy channels
*/
#mixin Mixin
#{targets: "mcjty.lib.thirteen.ConfigSpec$IntValue"}
zenClass MixinConfigSpecIntValue {
    #mixin Shadow
    var value as int;

    function toString() as string {
        return "" ~ value;
    }
}
