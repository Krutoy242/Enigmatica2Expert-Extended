## Installation

1) **Download** the server pack zip file.
    > Available on CurseForge under `Additional Files` or on GitHub in `Releases` -> `Assets`.

2) **Extract** the contents into an empty folder.

3) To customize world generation:
    > `OTG Biome Bundle O' Plenty` is configured as default generator.
    > - ⛺ For non-OTG **Biomes O' Plenty**: Set `level-type=BIOMESOP` in `server.properties`.
    > - 🌌 For **Skyblock**: Adjust `level-type` as above and modify `initialSpawnDimensionId` to `3` in [justenoughdimensions.cfg](config/justenoughdimensions/justenoughdimensions.cfg).

4) Launch the server with "**start-server.bat**".
    > On Linux, use "start-server.sh" (you cannot run the script via sh directly).

> [!NOTE]  
> The `serverstarter` script fetches the modpack directly from GitHub. If this isn't possible, you can manually modify the source by changing the `modpackUrl` value in the `server-setup-config.yaml` file.

> [!TIP]  
> You can run the server on Java 21+. See more info [here](https://cleanroommc.com/wiki/end-user-guide/installation/install-server) or [here](https://github.com/Krutoy242/Enigmatica2Expert-Extended/issues/500).

## Hosting

For hosting services with control panels like `Pterodactyl`:

1. Upload and **unzip** the **server pack** on your server.
2. Download [serverstarter-2.4.0.jar](https://github.com/EnigmaticaModpacks/ServerStarter/releases/tag/v2.4.0) and upload it.
3. Configure `serverstarter-2.4.0.jar` as the startup file.
  > ![Configuration Example](https://i.imgur.com/zP8gAUk.png)

## Updating

1) **Backup** your world.
    > While updates typically don't affect the world, it's best to play it safe.

2) **Backup** any custom configuration changes.

3) **Delete** the `serverstarter.lock` file.
    > This signals the *serverstarter* script to reinstall the modpack.

4) **Extract** the new `.zip` into the server folder, allowing files to be overwritten.

5) **Restore** your custom configurations.
    > Keep a separate archive of your changes to simplify reapplication after updates.

## Mc2Discord (Discord-Chat Bridge)

This pack includes [Mc2Discord](https://github.com/DenisD3D/Mc2Discord) — links Minecraft chat with a Discord channel.

1. **Create a Discord bot** at https://discord.com/developers/applications and copy its token.
2. Open `config/mc2discord.toml`, set `token` under `[General]` and the channel `id` under `[[Channels.Channel]]`.
3. Run `/mc2discord restart` in-game, then `/mc2discord invite` to add the bot to your server.

> Full guide: https://github.com/DenisD3D/Mc2Discord/wiki
