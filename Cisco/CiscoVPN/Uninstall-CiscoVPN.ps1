
Start-Process -FilePath "msiexec.exe" -ArgumentList '/X', '{467D5E81-8349-4892-9E81-C3674ED8E451}', '/qn', 'REBOOT=ReallySuppress' -Wait

Start-Sleep -Seconds 3

Start-Process -FilePath "msiexec.exe" -ArgumentList '/X', '{5FDC06BF-3D3D-4367-8FFB-4FAFCB61972D}', '/qn', 'REBOOT=ReallySuppress' -Wait

Start-Sleep -Seconds 3

Remove-Item -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\CVirtA' -Recurse

Start-Sleep -Seconds 3

Remove-Item -Path 'C:\Program Files (x86)\Cisco Systems\VPN Client' -Recurse
