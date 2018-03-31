$UninstallArgs = @(
    '/SP-',
    '/VERYSILENT',
    '/SUPPRESSMSGBOXES',
    '/NORESTART',
    "/LOG=C:\Windows\Temp\GitUninstall-$(Get-Date -format 'yyyyMMdd-HHmmss').log",
    '/CLOSEAPPLICATIONS'
)

Start-Process -FilePath "C:\Program Files\Git\unins000.exe" -ArgumentList $UninstallArgs -Wait
