#modloaded hammercore
#loader mixin

import java.lang.Class;
import org.apache.logging.log4j.Logger;
import com.zeitheron.hammercore.utils.CommonMessages;
import com.zeitheron.hammercore.utils.CommonMessages.CheckResult;

#mixin {targets: ["com.zeitheron.hammercore.utils.CommonMessages"]}
zenClass MixinCommonMessages {

    #mixin static
    #mixin overwrite
    function printMessageOnIllegalRedistribution(modClass as Class, log as Logger, modName as String, downloadUrl as String) as CheckResult {
        // stopmodrepost.org have some troubles in Russia
        return CheckResult.OK;
    }
}
