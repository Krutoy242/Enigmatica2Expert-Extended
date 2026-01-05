/*
During normal class loading Forge strips optional interfaces from classes when the dependency is missing.
ZenUtils does not properly do this when loading the class.
This causes a crash during startup when Quark is not installed as GuiVase has a softdependency on it.
*/
#modloaded quark
#modloaded rustic
#loader mixin
#sideonly client

import scripts.mixin.rustic.shared as Constants;

import mixin.Operation;

import native.java.lang.Integer;

import native.net.minecraft.client.gui.FontRenderer;
import native.net.minecraft.client.gui.inventory.GuiContainer;
import native.rustic.client.gui.GuiVase;

#mixin {targets: "rustic.client.gui.GuiVase"}
zenClass MixinGuiVase extends GuiContainer {

    function drawPaddedRow(gui as GuiContainer, x as int, y as int, textureY as int, textureHeight as int, columns as int) as void {
        // Left Padding
        gui.drawTexturedModalRect(x, y, 0, textureY, Constants.PADDING_SIZE, textureHeight);

        for col in 0 to columns {
            // Center
            gui.drawTexturedModalRect(x + Constants.PADDING_SIZE + col * Constants.SLOT_SIZE, y, Constants.PADDING_SIZE, textureY, Constants.SLOT_SIZE, textureHeight);
        }

        // Right Padding
        gui.drawTexturedModalRect(x + Constants.PADDING_SIZE + columns * Constants.SLOT_SIZE, y, Constants.ORIGINAL_INVENTORY_WIDTH - Constants.PADDING_SIZE, textureY, Constants.PADDING_SIZE, textureHeight);
    }

    #mixin Expression
    #{
    #    value: "176"
    #}
    #mixin ModifyExpressionValue
    #{
    #    method: "<init>",
    #    at: {
    #       value: "MIXINEXTRAS:EXPRESSION"
    #    }
    #}
    function modifyGUIWidth(original as int) as int {
        return original + Constants.DIFF_INVENTORY_WIDTH;
    }

    #mixin Expression
    #{
    #    value: "166"
    #}
    #mixin ModifyExpressionValue
    #{
    #    method: "<init>",
    #    at: {
    #       value: "MIXINEXTRAS:EXPRESSION"
    #    }
    #}
    function modifyGUIHeight(original as int) as int {
        return original + Constants.DIFF_INVENTORY_HEIGHT;
    }

    #mixin WrapOperation
    #{
    #    method: "func_146976_a",
    #    at: {
    #        value: "INVOKE",
    #        target: "Lrustic/client/gui/GuiVase;func_73729_b(IIIIII)V"
    #    }
    #}
    function modifyGUI(instance as GuiVase, x as int, y as int, textureX as int, textureY as int, width as int, height as int, original as Operation) as void {
        val playerX as int = x + Constants.PLAYER_INVENTORY_OFFSET_X;
        val playerY as int = y + Constants.PLAYER_INVENTORY_OFFSET_Y;
        val containerX as int = x + Constants.CENTERED_CONTAINER_OFFSET_X;
        val gui as GuiContainer = this0;

        // The player inventory is "attached" to large containers. Skip drawing the container top padding
        if (Constants.IS_SMALL_CONTAINER) {
            // Draw player inventory top padding
            drawPaddedRow(gui, playerX, playerY, 0, Constants.PADDING_SIZE, Constants.PLAYER_INVENTORY_COLUMNS);
        }

        // Draw container top padding
        drawPaddedRow(gui, containerX, y, 0, Constants.CONTAINER_TOP_PADDING_SIZE, Constants.COLUMNS);

        for row in 0 to Constants.ROWS {
            // Draw container row (slots and padding)
            drawPaddedRow(gui, containerX, y + Constants.CONTAINER_TOP_PADDING_SIZE + row * Constants.SLOT_SIZE, Constants.CONTAINER_TOP_PADDING_SIZE, Constants.SLOT_SIZE, Constants.COLUMNS);
        }

        // Small inventories are "attached" to the player one. Skip drawing the container bottom padding
        if (!Constants.IS_SMALL_CONTAINER) {
            // Draw container bottom padding
            drawPaddedRow(gui, containerX, y + Constants.CONTAINER_TOP_PADDING_SIZE + Constants.ROWS * Constants.SLOT_SIZE, Constants.ORIGINAL_INVENTORY_HEIGHT - Constants.PADDING_SIZE, Constants.PADDING_SIZE, Constants.COLUMNS);
        }

        // Draw player inventory
        original.call(instance, playerX, playerY, textureX, textureY + Constants.PLAYER_INVENTORY_TEXTURE_OFFSET_Y, width - Constants.DIFF_INVENTORY_WIDTH, height - (Constants.DIFF_INVENTORY_HEIGHT + Constants.PLAYER_INVENTORY_TEXTURE_OFFSET_Y));
    }

    #mixin WrapOperation
    #{
    #    method: "func_146979_b",
    #    at: {
    #        value: "INVOKE",
    #        target: "Lnet/minecraft/client/gui/FontRenderer;func_78276_b(Ljava/lang/String;III)I",
    #        ordinal: 0
    #    }
    #}
    function repositionPotTitle(instance as FontRenderer, text as string, x as int, y as int, color as int, original as Operation) as int {
        return original.call(instance, text, x + Constants.CENTERED_CONTAINER_OFFSET_X, y, color) as Integer as int;
    }

    #mixin WrapOperation
    #{
    #    method: "func_146979_b",
    #    at: {
    #        value: "INVOKE",
    #        target: "Lnet/minecraft/client/gui/FontRenderer;func_78276_b(Ljava/lang/String;III)I",
    #        ordinal: 1
    #    }
    #}
    function repositionPlayerInventoryTitle(instance as FontRenderer, text as string, x as int, y as int, color as int, original as Operation) as int {
        if (!Constants.SHOW_PLAYER_INVENTORY_TITLE)
            return 0;
        
        return original.call(instance, text, x + Constants.PLAYER_INVENTORY_OFFSET_X, y + (Constants.INVENTORY_SEPARATOR_SIZE / 2), color) as Integer as int;
    }
}
