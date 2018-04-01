$uninstallArgs = @(
    '/X'
    "`"$PSScriptRoot\AceRedist.msi`""
    '/qn'
    'REBOOT=ReallySuppress'
)
$installArgs = @(
    '/i'
    "`"$PSScriptRoot\AceRedist.msi`""
    '/qn'
    'REBOOT=ReallySuppress'
)

# Uninstall old Access 2010 Redistributable, if present
Start-Process -FilePath 'msiexec.exe' -ArgumentList $uninstallArgs -Wait

Start-Sleep -Seconds 5

# Install Access 2010 Redistributable
Start-Process -FilePath 'msiexec.exe' -ArgumentList $installArgs -Wait

Start-Sleep -Seconds 5