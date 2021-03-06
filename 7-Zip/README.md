# 7-Zip Installer - Version 18.05 - ConfigMgr

The scripts on this page are designed to install [7-Zip](https://www.7-zip.org/) using ConfigMgr Current Branch Application Deployment. This installer leverages the [PowerShell App Deployment Toolkit](http://psappdeploytoolkit.com/).

## Installation

1. Download the [7-Zip MSI Installer](https://www.7-zip.org/a/7z1805-x64.msi) from the 7-Zip website.
1. Download the [latest release](https://github.com/PSAppDeployToolkit/PSAppDeployToolkit/releases/latest) of PowerShell App Deployment Toolkit.
1. Download the [Deploy-Application.ps1](https://github.com/aentringer/CMAppScripts/raw/master/7-Zip/Deploy-Application.ps1) script from this repository.
1. Download the [Configure-7Zip.cmd](https://github.com/aentringer/CMAppScripts/raw/master/7-Zip/Files/Configure-7Zip.cmd) script from this repository.
1. Extract the 'Toolkit' directory from the PowerShell App Deployment Toolkit.
1. Place the 7-Zip MSI in the 'Files' directory.
1. Place the 'Configure-7Zip.cmd' script in the 'Files' directory.
1. Overwrite the toolkit's 'Deploy-Application.ps1' with this repository's script.
1. Rename 'Toolkit' directory to follow your organization's naming scheme (*version number, perhaps*)
1. Place the directory on your ConfigMgr Package Source
1. Build ConfigMgr Application according to your organization's procedures
1. Specify the Deploy-Application.exe installer in the the ConfigMgr Application Deployment Installation Program field:
    * Deploy-Application.exe -DeploymentType Install

## Uninstallation

1. Specify the Deploy-Application.exe uninstaller in the the ConfigMgr Application Deployment Installation Program field:
    * Deploy-Application.exe -DeploymentType Uninstall

## Detection Method

* Windows Installer
  * 7z1801-x64.msi
    * MSI GUID: {23170F69-40C1-2702-1805-000001000000}
    * Version (Equals): 18.05
