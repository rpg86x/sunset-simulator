$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing
$out = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '../windows'))
[IO.Directory]::CreateDirectory($out) | Out-Null
$bmp = New-Object Drawing.Bitmap 64,64
$g = [Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = 'AntiAlias'
$g.Clear([Drawing.Color]::FromArgb(26,30,42))
$brush = New-Object Drawing.SolidBrush ([Drawing.Color]::FromArgb(255,112,40))
$g.FillEllipse($brush,9,10,46,46)
$g.FillRectangle((New-Object Drawing.SolidBrush ([Drawing.Color]::FromArgb(26,30,42))),0,37,64,27)
$pen = New-Object Drawing.Pen ([Drawing.Color]::FromArgb(255,174,70)),3
$g.DrawLine($pen,8,38,56,38)
$g.DrawLine($pen,15,46,49,46)
$g.DrawLine($pen,23,54,41,54)
$bmp.Save((Join-Path $out 'Sunset.png'))
$ico = [Drawing.Icon]::FromHandle($bmp.GetHicon())
$stream = [IO.File]::Create((Join-Path $out 'Sunset.ico'))
$ico.Save($stream)
$stream.Dispose()
$g.Dispose()
$bmp.Dispose()
$exe = Join-Path $out 'Sunset Simulator.exe'
$sourcePath = Join-Path $PSScriptRoot 'Sunset.cs'
$iconPath = Join-Path $out 'Sunset.ico'
& "$env:WINDIR/Microsoft.NET/Framework64/v4.0.30319/csc.exe" /nologo /target:winexe /optimize+ /r:System.Windows.Forms.dll /r:System.Drawing.dll "/win32icon:$iconPath" "/out:$exe" $sourcePath
if ($LASTEXITCODE -ne 0) { throw 'Build failed' }
$p = Start-Process $exe -ArgumentList '--self-test' -PassThru -WindowStyle Hidden
if (!$p.WaitForExit(30000)) { $p.Kill(); throw 'Test timeout' }
if ($p.ExitCode -ne 0) { throw 'Self-test failed' }
Get-Content "$out/self-test.txt"
$hash = (Get-FileHash $exe -Algorithm SHA256).Hash
@{app='Sunset Simulator';status='B';version='1.0-dev';sourceVersion='1.0-dev';windowsVersion='1.0-dev';buildId=$hash;approved=$false;runtime='Windows .NET Framework 4.x'} | ConvertTo-Json | Set-Content "$PSScriptRoot/../release.json"
Write-Output "Built $exe"
