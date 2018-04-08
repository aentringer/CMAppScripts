# Stop all other PowerShell Instances to prevent issues where MSOnline is in use during installation
Get-Process -Name powershell | Where-Object { $_.Id -ne $pid } | Stop-Process -Force -Confirm:$false

if (Get-InstalledModule MSOnline -AllVersions -ErrorAction SilentlyContinue) {
    Get-InstalledModule MSOnline -AllVersions | Uninstall-Module -Force -Confirm:$false
}

# Remove Scheduled Task Here
Unregister-ScheduledTask -TaskName 'Update MSOnline PS Module' -Confirm:$false 
