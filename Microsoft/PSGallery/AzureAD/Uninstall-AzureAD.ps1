# Stop all other PowerShell Instances to prevent issues where AzureAD is in use during installation
Get-Process -Name powershell | Where-Object { $_.Id -ne $pid } | Stop-Process -Force -Confirm:$false

if (Get-InstalledModule AzureAD -AllVersions -ErrorAction SilentlyContinue) {
    Get-InstalledModule AzureAD -AllVersions | Uninstall-Module -Force -Confirm:$false
}

# Remove Scheduled Task Here
Unregister-ScheduledTask -TaskName 'Update AzureAD PS Module' -Confirm:$false 
