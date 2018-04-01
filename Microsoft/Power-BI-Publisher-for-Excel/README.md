# Power Bi Publisher for Excel Installer - Version 2.37.3272.33601 - ConfigMgr

The scripts on this page are designed to install [Power Bi Publisher For Excel](https://powerbi.microsoft.com/en-us/excel-dashboard-publisher/) using ConfigMgr Current Branch Application Deployment. This installer leverages the [PowerShell App Deployment Toolkit](http://psappdeploytoolkit.com/).

## Installation

1. Download the [Power Bi Publisher MSI Installer](https://go.microsoft.com/fwlink/?LinkId=722766&clcid=0x409) from the 7-Zip website.
1. Download the [latest release](https://github.com/PSAppDeployToolkit/PSAppDeployToolkit/releases/latest) of PowerShell App Deployment Toolkit.
1. Download the [Deploy-Application.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Microsoft/Power-BI-Publisher-for-Excel/Deploy-Application.ps1) script from this repository.
1. Extract the 'Toolkit' directory from the PowerShell App Deployment Toolkit
1. Rename the installer to 'PowerBIpublisher-x64.msi' (*those [ ] could be a minefield*)
1. Place the renamed MSI in the 'Files' directory
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
  * PowerBIpublisher-x64.msi
    * MSI GUID: {B831E2C2-9F12-4CC0-AA6A-376B62DB8D03}
    * Version (Equals): 2.37.3272.33601
