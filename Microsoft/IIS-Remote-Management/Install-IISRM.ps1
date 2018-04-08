if (-not (Get-WindowsOptionalFeature -Online -FeatureName IIS-ManagementConsole).State -eq 'Enabled') {
	Enable-WindowsOptionalFeature -Online -FeatureName IIS-ManagementConsole,IIS-WebServerManagementTools,IIS-WebServerRole -NoRestart
	Disable-WindowsOptionalFeature -Online -FeatureName IIS-HttpCompressionStatic,IIS-DirectoryBrowsing,IIS-DefaultDocument,IIS-StaticContent,IIS-Performance,IIS-RequestFiltering,IIS-Security,IIS-HttpLogging,IIS-HealthAndDiagnostics,IIS-ApplicationDevelopment,IIS-HttpErrors,IIS-CommonHttpFeatures,IIS-WebServer,NetFx4Extended-ASPNET45 -NoRestart
}

$InstallArgs = @(
    '/i'
    "$PSScriptRoot\inetmgr_amd64_en-US.msi"
    '/qn'
    'REBOOT=ReallySuppress'
)

Start-Process -FilePath msiexec.exe -ArgumentList $InstallArgs -Wait
Start-Sleep -Seconds 3
