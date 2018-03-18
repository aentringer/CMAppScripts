# Stop all other PowerShell Instances to prevent issues where dbatools is in use during installation
Get-Process -Name powershell | Where-Object { $_.Id -ne $pid } | Stop-Process -Force -Confirm:$false

if (Get-ChildItem -Path "$env:ProgramFiles\WindowsPowerShell\Modules\dbatools") {
    Uninstall-Module -Name dbatools -Force -Confirm:$false
}

# Remove Scheduled Task Here
Unregister-ScheduledTask -TaskName 'Update dbatools PS Module' -Confirm:$false 
