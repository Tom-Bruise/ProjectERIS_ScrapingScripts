# Scraping scripts for Project ERIS + EmulationStation

## What is this?

I put together a couple of shell scripts to automate the scraping of game information (including preview videos!) for use with the EmulationStation in Project ERIS. This was mainly done because the internal scraper did not work for me.

The scripts use the excellent [SkyScraper](https://github.com/muldjord/skyscraper) as a backbone for doing their magic.

## Why would I use this?

* The internal scraper is not working for you, or you are not satified with the results.
* You want to create custom compositions for your game art.
* You want to download and use preview videos (**Note: The EmulationStation included in Project ERIS does not seem to support this at the moment.**).

## How does this work?

**Disclaimer: Before trying anything with these scripts, MAKE A BACKUP COPY OF YOUR INSTALLATION. I AM NOT RESPONSIBLE FOR ANY LOSS OF DATA.** Although, all you are doing is copying images and xml files in your roms folder. No existing files are altered, especially the ones related to Project ERIS.

1. Before running the scripts, you need to install [SkyScraper](https://github.com/muldjord/skyscraper).

2. Open config/scraper_config.cfg and edit it to suit your needs. At a minimum, you want to specify the path for your roms (you can even plug in your Project ERIS USB drive and specify the mount point for it).  The important thing to keep in mind is that the roms need to be organized in folder representing each system, exactly like the roms folder in the Project ERIS installation.

    You can also add credentials for [Screenscraper.fr](https://www.screenscraper.fr), this will make fetching the game data faster. There are different sunscription tiers that allow you to use different numbers of threads for scraping. If you feel the service is useful for you, support them through Patreon!

3. First, run **fetch_game_media.sh**. This will make SkyScraper fetch the game info for your roms from Screenscraper.fr, and cache them. Once you cached the information, you don't need to repeat this step unless you added/removed files in your roms folder.

    You can also limit the scraping to a subset of platforms. Use the _-h_ option for more information.

4. Then, run **export_game_media.sh**. This will create an export folder, which will contain a roms folder with all the game data and gamelist.xml files EmulationStation needs, with the appropriate paths for the Project ERIS installation.

    You can also limit the export to a subset of platforms. Use the _-h_ option for more information.

5. Merge the export/roms folder with the roms folder on your Project ERIS USB drive. On most OSes, this is as simple as dragging the exported roms folder on the root of your USB drive. Done!

6. If you can't see artwork or game data in EmulationStation, you might need to set Main Menu (Start button) > Other Settings > Parse Gamelidts Only.


# EmulationStation's video preview support

The EmulationStation install used in Project ERIS does not seem to support video previews for games at the moment.

In the event this support gets added, you will need a theme that supports video previews. Check the [RetroPie Wiki](https://github.com/RetroPie/RetroPie-Setup/wiki/Themes) for more information on this.

Hint: in Project ERIS, the theme folder is located at:

```
/project_eris/opt/emulationstation/.emulationstation/themes
```


# Creating your own compositions for game artwork

SkyScraper has a bunch of options to create custom composition for your game artwork. Check [this page](https://github.com/muldjord/skyscraper/blob/master/docs/ARTWORK.md) for more info.

The artwork.xml file used by the eport script is located inside the _config_ folder.

## License

Do whatever you want with this stuff.
