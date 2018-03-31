# PuTTY Installer - Version 0.70 - ConfigMgr

The scripts on this page are designed to install [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) using ConfigMgr Current Branch Application Deployment. This installer leverages the [PowerShell App Deployment Toolkit](http://psappdeploytoolkit.com/).

## Installation

1. Download the [PuTTY MSI Installer](https://the.earth.li/~sgtatham/putty/latest/w64/putty-64bit-0.70-installer.msi) from the PuTTY website.
1. Download the [latest release](https://github.com/PSAppDeployToolkit/PSAppDeployToolkit/releases/latest) of PowerShell App Deployment Toolkit.
1. Download the [Deploy-Application.ps1](https://github.com/aentringer/CMAppScripts/raw/master/PuTTY/Deploy-Application.ps1) script from this repository.
1. Extract the 'Toolkit' directory from the PowerShell App Deployment Toolkit
1. Place the PuTTY MSI in the 'Files' directory
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
  * putty-64bit-0.70-installer.msi
    * MSI GUID: {45B3032F-22CC-40CD-9E97-4DA7095FA5A2}
    * Version (Equals): 0.70.0.0
