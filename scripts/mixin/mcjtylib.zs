#loader mixin

#mixin Mixin
#{targets: "mcjty.lib.thirteen.ConfigSpec$IntValue"}
zenClass MixinConfigSpecIntValue {
    #mixin Shadow
    var value as int;

    function toString() as string {
        return "" ~ value;
    }
}
