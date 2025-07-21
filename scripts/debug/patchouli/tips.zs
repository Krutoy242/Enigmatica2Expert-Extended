#modloaded patchouli
#reloadable
#sideonly client
#priority -1000

zenClass Op {
  var chunks as [string] = [
    '{\n',
    '  "name": "Tips",\n',
    '  "icon": "thaumicaugmentation:research_notes",\n',
    '  "category": "World",\n',
    '  "pages": [\n',
    '    {\n',
  ] as [string];

  var i as int = 0;
  var height as int = 0;

  val WIDTH as int = 28;
  val HEIGHT as int = 15;
  val DOT as int = 3;

  zenConstructor() {
    nextPage();

    while true {
      val tip = getSingleTip();
      if (isNull(tip)) break;
      val tipHeight = (tip.length + (height == 0 ? DOT : 0)) / WIDTH + 1 + (i == 0 ? 1 : 0);
      if (height != 0 && height + tipHeight > HEIGHT) {
        nextPage();
        height = 0;
      }
      height += tipHeight;
      chunks += '$(li)' ~ tip;
      i += 1;
    }

    chunks += '"\n';

    chunks += '    }\n  ]\n}\n';
    print('Save this into file "patchouli_books/e2e_e/en_us/entries/world/tips.json"\n'
      + mods.zenutils.StaticString.join(chunks as string[], ''));
  }

  function nextPage() as void {
    if (i != 0) chunks += '"\n    },\n    {\n';
    chunks += '      "item": "thaumicaugmentation:research_notes",\n';
    chunks += '      "type": "text",\n';
    chunks += '      "title": "Tips",\n';
    chunks += '      "text": "';
  }

  function getSingleTip() as string {
    val key = 'e2ee.tips.' ~ i;
    val tipText = mods.zenutils.I18n.format(key);
    print('~~~ '~tipText);
    if (tipText == key) return null;
    return tipText
      .replaceAll('§e', '§6') // Yellow too bright to read with default Patchouli background texture
      .replaceAll('\\\\', '\\\\\\\\')
      .replaceAll('§r', '\\$()')
      .replaceAll('§(.)', '\\$($1)')
      .replaceAll('\n', '')
      .replaceAll('"', '\\\\"');
  }
}

Op();
