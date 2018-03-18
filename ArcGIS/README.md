# ArcGIS Desktop - Version 10.5.1 - ConfigMgr

The scripts on this page are designed to install [ArcGIS Desktop](https://desktop.arcgis.com/en/) using ConfigMgr Current Branch.

## Installation

1. Download the [ArcGIS Installer](https://my.esri.com/#/downloads) from the myEsri Website (requires sign-in and license).
1. Extract contents of 'Desktop' folder from the downloaded .exe file
1. Download [Install-ArcGISDesktop.ps1](https://github.com/aentringer/CMAppScripts/raw/master/ArcGIS/Install-ArcGISDesktop.ps1 "Install-ArcGISDesktop.ps1") and place in same directory as 'Setup.exe'
1. Edit '$esriLicenceHost' variable with the server name of your ESRI License Host
1. Specify the [Install-ArcGISDesktop.ps1](https://github.com/aentringer/CMAppScripts/raw/master/ArcGIS/Install-ArcGISDesktop.ps1 "Install-ArcGISDesktop.ps1") file in the ConfigMgr Deployment Method Installation Box.
    * powershell.exe -ExecutionPolicy Bypass -File ".\Install-ArcGISDesktop.ps1"

## Uninstallation

1. Specify the [Uninstall-ArcGISDesktop.ps1](https://github.com/aentringer/CMAppScripts/raw/master/ArcGIS/Uninstall-ArcGISDesktop.ps1 "Uninstall-ArcGISDesktop.ps1") file in the ConfigMgr Deployment Method Uninstallation Box.
    * powershell.exe -ExecutionPolicy Bypass -File ".\Uninstall-ArcGISDesktop.ps1"

## Detection Method

    * Windows Installer
    * GUID: {4740FC57-60FE-45BB-B513-3309F6B73183}
    * Version (Equals): 10.5.7333
