# Stop all other PowerShell Instances to prevent issues where MicrosoftTeams is in use during installation
Get-Process -Name powershell | Where-Object { $_.Id -ne $pid } | Stop-Process -Force -Confirm:$false

#region Update NuGet
if (-not (Get-PackageProvider -Name NuGet -ListAvailable -ErrorAction SilentlyContinue)) {
	Install-PackageProvider NuGet -Force
}
elseif ((Get-PackageProvider -Name NuGet).Version -lt [version]2.8.5.201) {
    Remove-Item -Path 'C:\Program Files\PackageManagement\ProviderAssemblies\nuget' -Recurse -Force -Confirm:$false
    Install-PackageProvider NuGet -MinimumVersion '2.8.5.201' -Force
}
#endregion

#region Adjust InstallationPolicy for future updates
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
#endregion

#region Install MicrosoftTeams module
if (-not (Get-InstalledModule MicrosoftTeams -AllVersions -ErrorAction SilentlyContinue)) {
    Install-Module -Name MicrosoftTeams -Force -Confirm:$false -AllowClobber -Scope AllUsers
}
#endregion

#region Create Scheduled Task for updates
$ActionParams = @{
    Id = 'Update MicrosoftTeams PS Module'
    Execute = 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe'
    Argument = '-Command "Update-Module -Name MicrosoftTeams"'
}

$TaskParams = @{
    Action = New-ScheduledTaskAction @ActionParams
    Setting = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -RunOnlyIfNetworkAvailable -DontStopIfGoingOnBatteries -DontStopOnIdleEnd -StartWhenAvailable -ExecutionTimeLimit (New-TimeSpan -Minutes 10) -RestartCount 3 -RestartInterval (New-TimeSpan -Minutes 30)
    Principal = New-ScheduledTaskPrincipal -UserId 'SYSTEM' -RunLevel Highest
    Description = 'Update MicrosoftTeams Module'
}

$triggers = @()
$triggers += New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday -At 5am -RandomDelay (New-TimeSpan -Hours 1)

# Re-compile Task Scheduler MOF file to ensure command completes successfully
mofcomp C:\Windows\System32\wbem\SchedProv.mof
Start-Sleep -Seconds 3
Register-ScheduledTask -TaskName 'Update MicrosoftTeams PS Module' @TaskParams -Trigger $triggers
Start-Sleep -Seconds 3
#endregion
