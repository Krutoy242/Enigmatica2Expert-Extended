#modloaded hole_filler_mod

# [Throwable Hole Filler] from [Slime in a Bucket][+2]
craft.remake(<hole_filler_mod:throwable_hole_filler> * 16, ["pretty",
  "M M M",
  "M   M",
  "M M M"], {
  "M": <ore:ballMud>,                    # Mud Ball
});

// Remove since causing render crashes
/*
java.lang.NullPointerException: Rendering Block Entity
    at com.dannyboythomas.hole_filler_mod.renderers.TERHoleFiller.render(TERHoleFiller.java:51)
    at net.minecraft.client.renderer.tileentity.TileEntityRendererDispatcher.render(TileEntityRendererDispatcher.java:201)
    at net.minecraft.client.renderer.tileentity.TileEntityRendererDispatcher.render(TileEntityRendererDispatcher.java:157)
    at meldexun.renderlib.renderer.tileentity.TileEntityRenderer.renderTileEntities(TileEntityRenderer.java:67)
*/
utils.rh(<hole_filler_mod:throwable_hole_filler_smart>);
