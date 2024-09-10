#loader mixin

#mixin Mixin
#{targets: "com.github.sokyranthedragon.mia.integrations.botania.subtile.SubTileOrechidVacuam"}
zenClass MixinSubTileOrechidVacuam {
    #mixin Overwrite
    function canOperate() as bool {
        // remove the dimension lock
        return true;
    }
}
