$InstallArgs = @(
    '/SP-'
    '/VERYSILENT'
    '/SUPPRESSMSGBOXES'
    '/NORESTART'
    "/LOADINF=$PSScriptRoot\GitInstall.inf"
    "/LOG=C:\Windows\Temp\GitInstall-$(Get-Date -Format 'yyyyMMdd-HHmmss').log"
    '/CLOSEAPPLICATIONS'
)

Start-Process -FilePath "$PSScriptRoot\Git-2.16.2-64-bit.exe" -ArgumentList $InstallArgs -Wait
