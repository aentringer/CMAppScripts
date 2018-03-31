# Mail Merge Toolkit Installer - Version 2.12.3.3 - ConfigMgr

The scripts on this page are designed to install [Mail Merge Toolkit](https://www.mapilab.com/outlook/mail_merge/) using ConfigMgr Current Branch Application Deployment. This installer leverages the [PowerShell App Deployment Toolkit](http://psappdeploytoolkit.com/).

## Installation

1. Download the [Mail Merge Toolkit Installer](https://www.mapilab.com/files/mail_merge_toolkit.zip "mail_merge_toolkit.zip") from the MAPILab website.
1. Download the [latest release](https://github.com/PSAppDeployToolkit/PSAppDeployToolkit/releases/latest) of PowerShell App Deployment Toolkit.
1. Download the [Deploy-Application.ps1](https://github.com/aentringer/CMAppScripts/raw/master/MAPILab/Mail-Merge-Toolkit/Deploy-Application.ps1) script from this repository.
1. Extract the 'Toolkit' directory from the PowerShell App Deployment Toolkit
1. Extract the two Mail Merge Toolkit installers to the 'Files' directory
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
  * MSI GUID: {B008D66F-B796-4C06-B707-932F0B225531}
  * Version (Equals): 2.12.3
