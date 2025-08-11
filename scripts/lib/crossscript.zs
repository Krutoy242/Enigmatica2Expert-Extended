/*

Tools to communicate between any #loader and #reloadable state

*/

#loader contenttweaker
#modloaded crafttweakerutils zenutils
#priority 10000
#reloadable

static PREFIX as string = '__cross_loader.';

function set(key as string, value as string) as void {
  game.setLocalization(PREFIX ~ key, value);
}

function setList(key as string, values as string[]) as void {
  var s = values[0];
  if (values.length > 1) {
    for i in 1 .. values.length {
      s ~= ' ' ~ values[i];
    }
  }
  return set(key, s);
}

function get(key as string) as string {
  return game.localize(PREFIX ~ key);
}

function getList(key as string) as string[] {
  return get(key).split(' ');
}
