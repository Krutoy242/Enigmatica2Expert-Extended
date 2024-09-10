#loader mixin

#mixin Mixin
#{targets: net.darkhax.oldjava.OldJavaWarning}
zenClass MixinOldJavaWarning {
    #mixin Static
    #mixin Redirect
    #{
    #    method: "checkJavaVersion",
    #    at: {
    #        value: "INVOKE",
    #        target: "Ljava/lang/String;compareTo(Ljava/lang/String;)I"
    #    }
    #}
    function fixJavaVersionCheck(min as string, current as string) as int {
        val currentSplit as string[] = current.split("_");
        val minSplit as string[] = min.split("_");
        if (currentSplit.length > 1 && minSplit.length > 1 && currentSplit[1].matches("[0-9]+") && minSplit[1].matches("[0-9]+")) {
            val currentVersion as int = currentSplit[1] as int;
            val minVersion as int = minSplit[1] as int;
            return minVersion > currentVersion;
        }
        return 0;
    }
}
