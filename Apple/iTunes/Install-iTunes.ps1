$AASArgs = '/i', "$PSScriptRoot\AppleApplicationSupport64.msi", '/qn', 'REBOOT=ReallySuppress'
Start-Process -FilePath "msiexec.exe" -ArgumentList $AASArgs -Wait
Start-Sleep -Seconds 5

$AMDArgs = '/i', "$PSScriptRoot\AppleMobileDeviceSupport6464.msi", '/qn', 'REBOOT=ReallySuppress'
Start-Process -FilePath "msiexec.exe" -ArgumentList $AMDArgs -Wait
Start-Sleep -Seconds 5

$iTunesArgs = '/i', "$PSScriptRoot\iTunes64.msi", '/qn', 'REBOOT=ReallySuppress', 'DESKTOP_SHORTCUTS=0', 'DISABLEADVTSHORTCUTS=0', 'SCHEDULE_ASUW=0', 'AMDS_IS_INSTALLED=1', 'BONJOUR_IS_INSTALLED=1', 'IAcceptLicense=Yes', 'NO_ASUW=0', 'NO_BONJOUR=0', 'REGSRCH_DESKTOP_SHORTCUTS=0'
Start-Process -FilePath "msiexec.exe" -ArgumentList $iTunesArgs -Wait
Start-Sleep -Seconds 5