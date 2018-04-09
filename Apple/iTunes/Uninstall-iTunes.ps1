Stop-Process -Name iTunes -Force -Confirm:$false
Stop-Process -Name iTunesHelper -Force -Confirm:$false
Stop-Process -Name iPodService -Force -Confirm:$false
Stop-Process -Name iTunesHelper -Force -Confirm:$false
Stop-Process -Name AppleMobileDeviceService -Force -Confirm:$false

# Uninstall iTunes
$iTunesArgs = @('/X'
                '{5581A594-89CB-4062-81C3-2E9F7A76FBE0}'
                '/qn'
                'REBOOT=ReallySuppress')
Start-Process -FilePath 'msiexec.exe' -ArgumentList $iTunesArgs -Wait

# Uninstall Apple Mobile Device Support
$AMDSArgs = @('/X'
              '{A05FDFEC-4377-49E0-82CB-B6D1386E89DA}'
              '/qn'
              'REBOOT=ReallySuppress')
Start-Process -FilePath 'msiexec.exe' -ArgumentList $AMDSArgs -Wait

# Uninstall Apple Application Support
$ASUWArgs = @('/X'
              '{0ECA3BB5-4410-414B-B226-241FF1C12CD0}'
              '/qn'
              'REBOOT=ReallySuppress')
Start-Process -FilePath 'msiexec.exe' -ArgumentList $ASUWArgs -Wait
