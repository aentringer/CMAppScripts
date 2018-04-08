# Stop all other PowerShell Instances to prevent issues where MicrosoftTeams is in use during installation
Get-Process -Name powershell | Where-Object { $_.Id -ne $pid } | Stop-Process -Force -Confirm:$false

if (Get-InstalledModule MicrosoftTeams -AllVersions -ErrorAction SilentlyContinue) {
    Get-InstalledModule MicrosoftTeams -AllVersions | Uninstall-Module -Force -Confirm:$false
}

# Remove Scheduled Task Here
Unregister-ScheduledTask -TaskName 'Update MicrosoftTeams PS Module' -Confirm:$false 
