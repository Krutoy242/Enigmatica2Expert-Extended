#modloaded zenutils
#reloadable

import scripts.do.portal_spread.config.Config;

///////////////////////////////////////////////////////////
// Default Modifiers
///////////////////////////////////////////////////////////

// Very first item of first modifier here will be proposed to stop portal from spreading
Config.setModifier(<minecraft:coal_block> | <ore:blockCoal>, ['slow', 'weak', 'small'], false);

var empowerBlock = itemUtils.getItem('contenttweaker:conglomerate_of_coal');
if (isNull(empowerBlock)) empowerBlock = <minecraft:glowstone>;
Config.setModifier(empowerBlock, ['fast', 'potent', 'large'], true);
