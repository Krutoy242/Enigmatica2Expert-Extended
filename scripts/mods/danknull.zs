#modloaded danknull

recipes.remove(<danknull:danknull_dock>);

// Removing non-chained recipes
for i in 1 .. 6 {
  recipes.removeByRecipeName('danknull:dank_null_' ~ i);
}

craft.remake(<danknull:dank_null_panel_1>, ['pretty',
  '□ © □',
  '© G ©',
  '□ © □'], {
  '□': <ore:plateLapis>,
  '©': <ore:blockCoal>,
  'G': <minecraft:stained_glass_pane:11>,
});
craft.remake(<danknull:dank_null_panel_2>, ['pretty',
  '□ © □',
  '© I ©',
  '□ © □'], {
  '□': <ore:plateDenseIron>,
  '©': <ore:blockCoal>,
  'I': <ic2:te:112>,
});
craft.remake(<danknull:dank_null_panel_3>, ['pretty',
  '□ © □',
  '© B ©',
  '□ © □'], {
  '□': <ore:plateDenseGold>,
  '©': <ore:blockCoal>,
  'B': <ic2:te:113>,
});
craft.remake(<danknull:dank_null_panel_4>, ['pretty',
  '* © *',
  '© S ©',
  '* © *'], {
  '*': <actuallyadditions:block_crystal:2>,
  '©': <ore:blockCoal>,
  'S': <ic2:te:114>,
});
craft.remake(<danknull:dank_null_panel_5>, ['pretty',
  '* © *',
  '© I ©',
  '* © *'], {
  '*': <actuallyadditions:block_crystal:4>,
  '©': <ore:blockCoal>,
  'I': <ic2:te:115>,
});

// [/dank/null Docking Station] from [Sky Stone Block][+2]
craft.remake(<danknull:danknull_dock>, ['pretty',
  'P ♥ P',
  '♥ ■ ♥',
  'P ♥ P'], {
  'P': <enderio:item_material:69>,
  '♥': <compactmachines3:redstonetunneltool>, // Redstone Tunnel
  '■': <appliedenergistics2:smooth_sky_stone_block>, // Sky Stone Block
});
