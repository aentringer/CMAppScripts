# Stop all other PowerShell Instances to prevent issues where sqlserver is in use during installation
Get-Process -Name powershell | Where-Object { $_.Id -ne $pid } | Stop-Process -Force -Confirm:$false

if (Get-InstalledModule sqlserver -AllVersions -ErrorAction SilentlyContinue) {
    Get-InstalledModule sqlserver -AllVersions | Uninstall-Module -Force -Confirm:$false
}

# Remove Scheduled Task Here
Unregister-ScheduledTask -TaskName 'Update sqlserver PS Module' -Confirm:$false
