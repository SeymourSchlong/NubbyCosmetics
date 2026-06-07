# NubbyCosmetics
A mod for Nubby's Number Factory for use with [g3man](https://github.com/skirlez/g3man/) that allows the addition of custom Nubby cosmetics.

## Features
Currently, this mod only allows you to add custom cosmetic skins to Nubby.  
This mod may be expanded in the future to include item skins, as well as potentially pegs, Tony, or whatever else.

## How to Add Custom Nubby Skins
After installing the mod, to add a custom skin you've either made or downloaded you must create a folder in the game's directory named `Skins`.
After, drag any folder that has the skins inside into that folder.
(It should look something like this)
```
Nubby's Number Factory
  ┗━ Skins
	    ┗━ custom_skin
			    ┗━┳━	info.json
                  ┣━	launcher.png
                  ┗━	nubby.png
```
When you launch the game, the Warehouse should have those new custom skins added to the end of its list.

## For Mod Developers
To include a custom skin with the download of your mod, simply make a folder named `skins` in your mod directory (the same place that `patches` or `trans` exists).  
Every skin that's inside there will be loaded like normal.

## How to Make Custom Nubby Skins
1. Download the template skin here: 
2. Rename the folder to whatever you want yours to be.
    * It should be unique, so put an identifier at the start if you want. Players will not see this in-game.
3. Inside that folder, open the `info.json` file and change all the data to be appropriate to your skin.
    * Make sure the ID is unique. If it's the same as any other existing one, it will use the first one it finds (which may not be yours!)
4. Edit or include your custom Nubby image files in the folder.
    * They must be named `launcher.png` for the launcher, and `nubby.png` for the active Nubby.
    * The sprites can be any size.
    * Make sure each frame is centered. The mod will automatically set the origin to the midpoint of the sprites.
    * `nubby.png` needs 36 frames.
    * `launcher.png` needs 20 frames.
If all is done correct, then it should appear in-game! If any of the files are missing, the skin will not be added on load.
