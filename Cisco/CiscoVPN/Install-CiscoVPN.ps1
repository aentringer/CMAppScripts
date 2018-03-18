# Install Dell SonicWall to add DNE Lightweight Filter
$dellArgs = @(
    '/i'
    "`"$PSScriptRoot\GVCInstall64.msi`""
    "/qn"
    "REBOOT=ReallySuppress"
)
Start-Process -FilePath "msiexec.exe" -ArgumentList $dellArgs -Wait

Start-Sleep -Seconds 1

# Install Cisco VPN Client
$ciscoArgs = @(
    '/i'
    "`"$PSScriptRoot\vpnclient_setup.msi`""
    '/qn'
    'REBOOT=ReallySuppress'
)
Start-Process -FilePath "msiexec.exe" -ArgumentList $ciscoArgs -Wait

Start-Sleep -Seconds 1

# Fix Registry Key from VPN Client Installation
if (Test-Path 'HKLM:\SYSTEM\CurrentControlSet\Services\CVirtA') {
	Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\CVirtA' -Name 'DisplayName' -Value 'Cisco Systems VPN Adapter for 64-bit Windows'
}
else {
	New-Item -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\CVirtA' | Out-Null
	Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\CVirtA' -Name 'DisplayName' -Value 'Cisco Systems VPN Adapter for 64-bit Windows'
}

Start-Sleep -Seconds 2

# Mitigate Security Vulnerability in Cisco VPN Client (CVE-2015-7600)
Get-Acl -Path 'C:\Program Files (x86)\Cisco Systems\VPN Client\vpnclient.exe' | Set-Acl -Path 'C:\Program Files (x86)\Cisco Systems\VPN Client\vpnclient.ini'

Start-Sleep -Seconds 2

# Remove Dell SonicWall Start Menu Shortcut to reduce User Confusion
if (Test-Path -Path 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Global VPN Client.lnk') {
    Remove-Item -Path 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Global VPN Client.lnk'
    Start-Sleep -Seconds 1
}
