# Stop all other PowerShell Instances to prevent issues where dbatools is in use during installation
Get-Process -Name powershell | Where-Object { $_.Id -ne $pid } | Stop-Process -Force -Confirm:$false

#region Install dbatools module
if (-not (Get-PackageProvider -Name NuGet -ListAvailable -ErrorAction SilentlyContinue)) {
	Install-PackageProvider NuGet -Force
}
elseif ((Get-PackageProvider -Name NuGet).Version -lt [version]2.8.5.201) {
    Remove-Item -Path 'C:\Program Files\PackageManagement\ProviderAssemblies\nuget' -Recurse -Force -Confirm:$false
    Install-PackageProvider NuGet -MinimumVersion '2.8.5.201' -Force
}

if (-not (Get-ChildItem -Path "$env:ProgramFiles\WindowsPowerShell\Modules\dbatools")) {
    Install-Module -Name dbatools -Force -Confirm:$false -AllowClobber -Scope AllUsers
}
#endregion

#region Create Scheduled Task for updates
$ActionParams = @{
    Id = 'Update dbatools PS Module'
    Execute = 'powershell.exe -Command "Update-Module -Name dbatools"'
}

$TaskParams = @{
    Action = New-ScheduledTaskAction @ActionParams
    Setting = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -RunOnlyIfNetworkAvailable -DontStopIfGoingOnBatteries -DontStopOnIdleEnd -StartWhenAvailable -ExecutionTimeLimit (New-TimeSpan -Minutes 10) -RestartCount 3 -RestartInterval (New-TimeSpan -Minutes 30)
    Principal = New-ScheduledTaskPrincipal -UserId 'SYSTEM' -RunLevel Highest
    Description = 'Update dbatools Module'
}

$triggers = @()
$triggers += New-ScheduledTaskTrigger -Daily -DaysInterval 3 -At 5am -RandomDelay (New-TimeSpan -Hours 1)
$triggers += New-ScheduledTaskTrigger -AtStartup -RandomDelay (New-TimeSpan -Minutes 15)

# Re-compile Task Scheduler MOF file to ensure command completes successfully
mofcomp C:\Windows\System32\wbem\SchedProv.mof
Start-Sleep -Seconds 3
Register-ScheduledTask -TaskName 'Update dbatools PS Module' @TaskParams -Trigger $triggers
Start-Sleep -Seconds 3
#endregion
