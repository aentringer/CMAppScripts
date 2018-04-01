$uninstallArgs = @(
    '/X'
    "`"$PSScriptRoot\AceRedist.msi`""
    '/qn'
    'REBOOT=ReallySuppress'
)

# Uninstall Access 2010 Redistributable
Start-Process -FilePath 'msiexec.exe' -ArgumentList $uninstallArgs -Wait

Start-Sleep -Seconds 5