$UninstallArgs = '-s', '-runfromtemp', '-l0x0009', '-removeonly', "-f1`"$PSScriptRoot\remove.iss`"", "-f2`"C:\Windows\Temp\ActianDI9Uninstall.log`""

Start-Process -FilePath "C:\Program Files (x86)\InstallShield Installation Information\{902F0531-F2A5-4DBA-B5AE-7C1A9BE4A9F9}\setup.exe" -ArgumentList $UninstallArgs -Wait

Start-Sleep -Seconds 3

if (Test-Path -Path 'C:\Program Files (x86)\Actian') {
    Remove-Item -Path 'C:\Program Files (x86)\Actian' -Recurse -Force -Confirm:$false
}