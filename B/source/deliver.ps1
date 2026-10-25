$ErrorActionPreference = 'Stop'
$out = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '../windows'))
$shell = New-Object -ComObject WScript.Shell
$link = $shell.CreateShortcut((Join-Path ([Environment]::GetFolderPath('Desktop')) 'Sunset Simulator 1.0-dev B.lnk'))
$link.TargetPath = Join-Path $out 'Sunset Simulator.exe'
$link.WorkingDirectory = $out
$link.IconLocation = Join-Path $out 'Sunset.ico'
$link.Save()
Start-Process $link.TargetPath
Write-Output "Shortcut: $($link.FullName)"
