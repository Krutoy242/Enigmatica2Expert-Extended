#modloaded storagedrawers framedcompactdrawers
#ignoreBracketErrors

// Hand Framing Tool — recipes, tooltips, and JEI description.
// Adapted from Eutro's Nomifactory implementation (LGPL-3.0)
// via Divine Journey 2's port. Sticks/refill mechanic intentionally omitted.

import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;
import crafttweaker.item.ITooltipFunction;
import crafttweaker.recipes.IRecipeFunction;
import crafttweaker.recipes.ICraftingInfo;
import crafttweaker.data.IData;

val HFT as IItemStack = <contenttweaker:hand_framing_tool>;

// Match any opaque-cube ItemBlock — the only valid frame material.
static framingMaterial as IIngredient = <*>.only(function (stack as IItemStack) as bool {
  if (stack.isItemBlock) return stack.asBlock().definition.getStateFromMeta(stack.metadata).opaqueCube;
  return false;
});

// JEI preview ingredients: shown as the recipe's exemplar but ANY opaque block works.
function previewIngredient(item as IItemStack, type as string) as IIngredient {
  return (item.withDisplayName('§r§6Framing Template — block not consumed.') | framingMaterial).marked(type).reuse();
}

val sideIngredient = previewIngredient(<enderio:block_alloy:6>, 'MatS');
val trimIngredient = previewIngredient(<minecraft:planks:1>, 'MatT');
val frontIngredient = previewIngredient(<chisel:antiblock:7>, 'MatF');

// Tag: "drawers that take three frames (side/front/trim)" vs "trim-only".
<ore:handFramedThree>.add([
  <storagedrawers:customdrawers:*>,
  <framedcompactdrawers:framed_drawer_controller>,
  <framedcompactdrawers:framed_compact_drawer>,
  <framedcompactdrawers:framed_slave>,
  HFT,
]);

if (!isNull(loadedMods['fluiddrawers'])) {
  <ore:handFramedThree>.add(<fluiddrawers:tank_custom>);
}

<ore:handFramed>.addAll(<ore:handFramedThree>);
<ore:handFramed>.add(<storagedrawers:customtrim>);

function addInfo(stack as IItemStack) as IItemStack {
  return stack.withDisplayName('Frame your drawers by hand!')
    .withLore([
      'Top left: sides',
      'Top right: trim',
      'Middle left: front',
    ]);
}

function asData(stack as IItemStack) as IData {
  return {
    id: stack.definition.id,
    Count: 1 as byte,
    Damage: stack.metadata,
  };
}

static matKeys as string[] = ['MatS', 'MatF', 'MatT'] as string[];

// Build the output drawer with framing NBT copied from input slots.
// Special-cases the "tile" key so taped drawers re-frame correctly.
function getRecipeOutput(out as IItemStack, ins as IItemStack[string], cInfo as ICraftingInfo) as IItemStack {
  val fromTag as IData[string]
    = isNull(ins.drawer.tag) ? {} as IData[string] : ins.drawer.tag.asMap();

  val tag = {} as IData[string];
  for key, value in fromTag {
    if (!(matKeys has key)) {
      if (key == 'tile') {
        val tileTag = {} as IData[string];
        for tileKey, tileVal in value.asMap() {
          if (!(matKeys has tileKey)) tileTag[tileKey] = tileVal;
        }
        for matKey in matKeys {
          if (ins has matKey) tileTag[matKey] = asData(ins[matKey]);
        }
        val tileData as any[any] = tileTag;
        tag[key] = tileData as IData;
      }
      else {
        tag[key] = value;
      }
    }
  }
  for key in matKeys {
    if (ins has key) tag[key] = asData(ins[key]);
  }

  val ret as any[any] = tag;
  return ins.drawer.withTag(ret as IData) * 1;
}

val recipeFunction = function (out, ins, cinfo) {
  return getRecipeOutput(out, ins, cinfo);
} as IRecipeFunction;

for front in [true, false] as bool[] {
  for trim in [true, false] as bool[] {
    val ingredients as IIngredient[][] = [
      [sideIngredient, trim ? trimIngredient : null],
      [
        front ? frontIngredient : null,
        (front ? <ore:handFramedThree> : <ore:handFramed>).marked('drawer'),
      ],
    ];

    val ins as IItemStack[string] = {
      MatS: sideIngredient.items[0],
      drawer: <framedcompactdrawers:framed_compact_drawer>,
    };
    if (front) ins['MatF'] = frontIngredient.items[0];
    if (trim) ins['MatT'] = trimIngredient.items[0];

    recipes.addShaped(
      'hand_framing_' ~ (trim ? 'trim_' : '') ~ (front ? 'front_' : '') ~ 'side',
      addInfo(getRecipeOutput(null, ins, null)),
      ingredients,
      recipeFunction
    );
  }
}

// Tooltip: read-back of currently stored Side/Front/Trim materials.
function getNested(inTag as IData, keys as string[], alt as IData) as IData {
  var tag = inTag;
  for key in keys {
    if (isNull(tag)) return alt;
    tag = tag.memberGet(key);
  }
  return isNull(tag) ? alt : tag;
}

function makeTagFunc(name as string) as ITooltipFunction {
  val matTag = 'Mat' ~ name[0];
  return function (stack as IItemStack) as string {
    val item as IItemStack
      = isNull(stack)
        ? null
        : itemUtils.getItem(getNested(stack.tag, [matTag, 'id'], '-'),
            getNested(stack.tag, [matTag, 'Damage'], 0));
    return '§e' ~ name ~ ': §r' ~ (isNull(item) ? '§c-§r' : item.displayName);
  };
}

HFT.addAdvancedTooltip(makeTagFunc('Side'));
HFT.addAdvancedTooltip(makeTagFunc('Front'));
HFT.addAdvancedTooltip(makeTagFunc('Trim'));

// Tool craft: drawer trim + 2 sticks (DJ2-style, no leather/framing-table gate).
recipes.addShaped(
  'hand_framing_tool',
  HFT,
  [
    [null, null, <storagedrawers:trim>],
    [null, <ore:stickWood>, null],
    [<ore:stickWood>, null, null],
  ]
);

scripts.lib.tooltip.desc.jei(HFT, 'hand_framing_tool');
