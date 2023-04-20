param(
    [string] $Target = "build"
)

$InstallDir = $env:INSTALL_DIR 
if (-not $InstallDir) {
  $InstallDir = "C:\Program Files (x86)\Steam\steamapps\common\Dead Cells"
}

function UnpackAll {
    param(
        [Parameter(Mandatory)][string] $Destination
    )

    PAKTool.exe -Expand -OutDir "$(pwd)\$Destination\unpacked" -RefPak "$InstallDir\res.pak"
    CDBTool.exe -Expand -OutDir "$(pwd)\$Destination\castledb" -RefCdb "$(pwd)\$Destination\unpacked\data.cdb"
    TmxTool.exe -Expand -TmxBin "$(pwd)\$Destination\unpacked\tiled" -TmxXml "$(pwd)\$Destination\tiled"
}

function PatchAll {
    Copy-Item -Path "patches\Normal.json" -Destination "build\castledb\difficulty\0---Normal.json" -Force
    Copy-Item -Path "patches\Hard.json" -Destination "build\castledb\difficulty\1---Hard.json" -Force
    Copy-Item -Path "patches\VeryHard.json" -Destination "build\castledb\difficulty\2---VeryHard.json" -Force
    Copy-Item -Path "patches\Expert.json" -Destination "build\castledb\difficulty\3---Expert.json" -Force
    Copy-Item -Path "patches\Nightmare.json" -Destination "build\castledb\difficulty\4---Nightmare.json" -Force
    Copy-Item -Path "patches\Hell.json" -Destination "build\castledb\difficulty\5---Hell.json" -Force
    CDBTool.exe -Collapse -Indir "$(pwd)\build\castledb" -OutCdb "$(pwd)\build\unpacked\data.cdb"
}

function CreateModRes {
    PAKTool.exe -CreateDiffPak -RefPak "$InstallDir\res.pak" -InDir "$(pwd)\build\unpacked" -OutPak "$(pwd)\res.pak"
}

function CheckModContents {
    PAKTool.exe -Expand -OutDir "$(pwd)\check" -RefPak "$(pwd)\res.pak"
}

function LivePatch {
    PAKTool.exe -Collapse -Indir "$(pwd)\build\unpacked" -OutPak "$InstallDir\res.pak"
}

function PrePublish {
    New-Item -ItemType Directory -Path publish -Force >$null
    Copy-Item -Path "metadata\settings.json" -Destination "publish" -Force
    Copy-Item -Path "metadata\preview.jpg" -Destination "publish" -Force
    Copy-Item -Path "res.pak" -Destination "publish" -Force
}

switch($Target) {
    "build" {
        UnpackAll -Destination build
        PatchAll
        CreateModRes
    }
    "check" {
        CheckModContents
    }
    "ref" {
        UnpackAll -Destination reference
    }
    "live" {
        UnpackAll -Destination build
        PatchAll
        LivePatch
    }
    "pub" {
        PrePublish
    }
    "clean" {
        if (Test-Path "build") { Remove-Item -Path "build" -Force -Recurse }
        if (Test-Path "check") { Remove-Item -Path "check" -Force -Recurse }
        if (Test-Path "publish") { Remove-Item -Path "publish" -Force -Recurse }
        if (Test-Path "reference") { Remove-Item -Path "reference" -Force -Recurse }
        if (Test-Path "res.pak") { Remove-Item -Path "res.pak" -Force }
    }
}
