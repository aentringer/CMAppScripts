$UninstallArgs = @(
    '/X'
    '{2349E6AA-CFCA-4D17-B633-3ECDA92E38CD}'
    '/qn'
    'REBOOT=ReallySuppress'
)

Start-Process -FilePath msiexec.exe -ArgumentList $UninstallArgs -Wait

Start-Sleep -Seconds 3

if ((Get-WindowsOptionalFeature -Online -FeatureName IIS-ManagementConsole).State -eq 'Enabled') {
	Disable-WindowsOptionalFeature -Online -FeatureName IIS-ManagementConsole,IIS-WebServerManagementTools,IIS-WebServerRole -NoRestart
}

Start-Sleep -Seconds 3

