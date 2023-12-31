## Installation

1) **Download** the server pack zip file.
    > Available on CurseForge under `Additional Files` or on GitHub in `Releases` -> `Assets`.

2) **Extract** the contents into an empty folder.

3) To customize world generation:
    > - ⛺ For **Biomes O' Plenty**: Set `level-type=BIOMESOP` in `server.properties`.
    > - 🌌 For **Skyblock**: Adjust `level-type` as above and modify `initialSpawnDimensionId` to `3` in [justenoughdimensions.cfg](config/justenoughdimensions/justenoughdimensions.cfg).

4) Launch the server with "**start-server.bat**".
    > On Linux, use "start-server.sh" (you cannot run the script via sh directly).

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

3) **Delete** the following folders: `bansoukou`, `config`, `mods`, `patchouli_books`, `scripts`, `structures`.
    > This prevents conflicts from old files that were removed in the new version.

4) **Delete** the `serverstarter.lock` file.
    > This signals the *serverstarter* script to reinstall the modpack.

5) **Extract** the new `.zip` into the server folder, allowing files to be overwritten.

6) **Restore** your custom configurations.
    > Keep a separate archive of your changes to simplify reapplication after updates.
