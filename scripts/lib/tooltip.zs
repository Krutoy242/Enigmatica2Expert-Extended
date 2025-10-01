#modloaded jei
#priority 2
#reloadable

import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;
import crafttweaker.liquid.ILiquidStack;
import crafttweaker.oredict.IOreDictEntry;
import mods.jei.JEI.addDescription;
import mods.zenutils.I18n;

zenClass Descriptor {
	var langPrefix as string = "";
	zenConstructor(newPrefix as string) {
		langPrefix = newPrefix;
	}

	/*
		Add both: tooltip and description
	*/
	function both(item as IIngredient, lang as string = null, a1 as string = null, a2 as string = null) as void {
		if (isNull(lang)) return both(item, autoLang(item));
		if (isNull(a1)) { tooltip(item, lang); jei(item, lang); }
		else if (isNull(a2)) { tooltip(item, lang, a1); jei(item, lang, a1); }
		else { tooltip(item, lang, a1, a2); jei(item, lang, a1, a2); }
	}

	/*
		Add tooltip
	*/
	function tooltip(item as IIngredient, lang as string = null, a1 as string = null, a2 as string = null, a3 as string = null) as void {
		if (isNull(lang)) return tooltip(item, autoLang(item));
		tooltipRaw(item, I18n.format(local(lang), a1, a2, a3));
	}

	/*
		Add tooltip helper
	*/
	function tooltipRaw(item as IIngredient, localized as string) as void {
		if(localized.startsWith(langPrefix)) return;
		if(isNull(item)) return;
		for line in localized.split('\n|<br>') {
			item.addTooltip(line);
		}
	}

	/*
		Add JEI description tab
	*/
	function jei(item as IIngredient,
		lang as string,
		a1 as string = null,
		a2 as string = null,
		a3 as string = null,
		a4 as string = null,
		a5 as string = null
	) as void {
		if(isNull(item)) return;
		if(isNull(lang)) return jei(item, autoLang(item));
		if(isNull(a1)) return describe(item, local(lang));
		if(isNull(a2)) return describe(item, I18n.format(local(lang), a1));
		if(isNull(a3)) return describe(item, I18n.format(local(lang), a1, a2));
		if(isNull(a4)) return describe(item, I18n.format(local(lang), a1, a2, a3));
		if(isNull(a5)) return describe(item, I18n.format(local(lang), a1, a2, a3, a4));
		describe(item, I18n.format(local(lang), a1, a2, a3, a4, a5));
	}

	/*
		Add JEI description tab helper
	*/
	function describe(ingr as IIngredient, localized as string) as void {
		if(isNull(ingr)) return;
		if(localized.startsWith(langPrefix)) return;
		addDescription(ingr, localized.split("\n|<br>"));
	}

	/*
		Other functions
	*/
	function autoLang(ingr as IIngredient) as string {
		if(isNull(ingr)) return '';
		val isLiquid = ingr.liquids.length > 0 && !isNull(ingr.liquids[0]);
		val cmdString = isLiquid
			? ingr.liquids[0].commandString
			: ingr.commandString;
		val id = cmdString.replaceAll('<|>.*', '');

		if (isLiquid) return id;

		val item = ingr.items[0];
		val nbt = !item.hasTag ? ''
			: ':'~item.tag.toSNBT().replaceAll('"', "'");
		utils.log('autolocalizing: '~id~nbt);
		return id ~ nbt;
	}

	function local(lang as string) as string { return game.localize(prefix(lang)); }
	function local(item as IItemStack) as string { return local(autoLang(item)); }
	function prefix(lang as string) as string { return langPrefix ~ lang; }
}
static desc as Descriptor = Descriptor("tooltips.lang.");
