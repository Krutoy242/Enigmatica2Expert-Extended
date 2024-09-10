#loader mixin

#mixin Mixin
#{targets: "cofh.thermalfoundation.init.TFEquipment"}
zenClass MixinTFEquipment {
    #mixin Static
    #mixin Overwrite
    function preInit() as void {
        //NO-OP: remove thermal tools
    }
}
