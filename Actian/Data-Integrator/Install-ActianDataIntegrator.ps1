$InstallArgs = '/s', "/f1`"$PSScriptRoot\setup.iss`"", "-f2`"C:\Windows\Temp\ActianDI9Install.log`""

Start-Process -FilePath "$PSScriptRoot\DataIntegrator9.exe" -ArgumentList $InstallArgs -Wait

Start-Sleep -Seconds 3

if (Test-Path -Path 'C:\Users\Public\Desktop\Repository Explorer 9.lnk') {
    Remove-Item -Path 'C:\Users\Public\Desktop\Repository Explorer 9.lnk' -Force -Confirm:$false
}