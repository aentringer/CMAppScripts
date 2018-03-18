Stop-Process -Name iTunes -Force -Confirm:$false
Stop-Process -Name iTunesHelper -Force -Confirm:$false
Stop-Process -Name iPodService -Force -Confirm:$false
Stop-Process -Name iTunesHelper -Force -Confirm:$false
Stop-Process -Name AppleMobileDeviceService -Force -Confirm:$false

# Uninstall iTunes
$iTunesArgs = '/X', '{D7D4465C-B3B6-4BC1-B336-2803FB57BFAF}', '/qn', 'REBOOT=ReallySuppress'
Start-Process -FilePath 'msiexec.exe' -ArgumentList $iTunesArgs -Wait

# Uninstall Apple Mobile Device Support
$AMDSArgs = '/X', '{BD6778C5-6FA5-492A-ADD6-E706339C2A7B}', '/qn', 'REBOOT=ReallySuppress'
Start-Process -FilePath 'msiexec.exe' -ArgumentList $AMDSArgs -Wait

# Uninstall Apple Application Support
$ASUWArgs = '/X', '{F0C4B709-8BF4-4A72-B527-12E7BF5482F8}', '/qn', 'REBOOT=ReallySuppress'
Start-Process -FilePath 'msiexec.exe' -ArgumentList $ASUWArgs -Wait
