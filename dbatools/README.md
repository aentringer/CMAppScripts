# dbatools PowerShell Module - ConfigMgr

The scripts on this page are designed to install [dbatools](https://dbatools.io/) using ConfigMgr Current Branch.

## Installation

1. Specify the [Install-dbatools.ps1](https://github.com/aentringer/CMAppScripts/raw/master/dbatools/Install-dbatools.ps1 "Install-dbatools.ps1") file in the ConfigMgr Deployment Method Installation Box.
    * powershell.exe -ExecutionPolicy Bypass -File ".\Install-dbatools.ps1"

## Uninstallation

1. Specify the [Uninstall-dbatools.ps1](https://github.com/aentringer/CMAppScripts/raw/master/dbatools/Uninstall-dbatools.ps1 "Uninstall-dbatools.ps") file in the ConfigMgr Deployment Method Uninstallation Box.
    * powershell.exe -ExecutionPolicy Bypass -File ".\Uninstall-dbatools.ps1"

## Detection Method

* Script Detection

```PowerShell
if (Get-InstalledModule dbatools -ErrorAction SilentlyContinue) {
    $true
}
```