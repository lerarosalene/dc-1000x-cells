## Dead Cells Mod: 1000x cells

<img src="https://raw.githubusercontent.com/lerarosalene/dc-1000x-cells/06745eacee5161d132d189f3c15d4888dabaaa5f/metadata/preview.jpg" width="600" />

Download and install via [steam workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=2946989101).

This mod changes cell drop multiplier for all difficulties to 1000x 

Last compatibility check: 3.2

## Build it yourself

- `.\build.ps1 build` to create res.pak
- `.\build.ps1 pub` to prepare publish directory to upload fork to steam workshop (change name in metadata.json if you want to do this)
- `.\build.ps1 check` to unpak res.pak to `check` to check what files it contains
- `.\build.ps1 ref` to unpak res.pak of main game in `reference` directory to veiw what's originally inside (it unpacks CDB and TMX files too)
- `.\build.ps1 clean` to remove all files created by this script, including `publish/` and `res.pak`
- `.\build.ps1 live` to patch YOUR ORIGINAL res.pak with this mod (it will allow to use this mod and still have achievements). WARNING: before running any other command besides clean, restore your original res.pak in game folder (Steam can do it for you)
