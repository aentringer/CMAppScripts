# WinSCP Installer - Version 5.13.1 - ConfigMgr

The scripts on this page are designed to install [WinSCP](https://winscp.net/eng/index.php) using ConfigMgr Current Branch Application Deployment. This installer leverages the [PowerShell App Deployment Toolkit](http://psappdeploytoolkit.com/).

## Installation

1. Download the [WinSCP Installer](https://winscp.net/download/WinSCP-5.13.1-Setup.exe) from the WinSCP website.
1. Download the [latest release](https://github.com/PSAppDeployToolkit/PSAppDeployToolkit/releases/latest) of PowerShell App Deployment Toolkit.
1. Download the [Deploy-Application.ps1](https://github.com/aentringer/CMAppScripts/raw/master/WinSCP/Deploy-Application.ps1) script from this repository.
1. Download the [WinSCP.inf](https://github.com/aentringer/CMAppScripts/raw/master/WinSCP/Files/WinSCP.inf) file from this repository.
1. Download the [AppDeployToolkitConfig.xml](https://github.com/aentringer/CMAppScripts/raw/master/WinSCP/AppDeployToolkit/AppDeployToolkitConfig.xml) script from this repository.
    * This file only changes the InstallUI_Timeout value. You may alter by hand if you wish.
      * <InstallationUI_Timeout>13200</InstallationUI_Timeout>
1. Extract the 'Toolkit' directory from the PowerShell App Deployment Toolkit
1. Place the WinSCP installer in the 'Files' directory
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

* File System
  * Type: File
  * Path: %ProgramFiles(x86)%\WinSCP
  * File or folder name: WinSCP.exe
    * [X] This file or folder is associated with a 32-bit application on 64-bit systems
  * [X] The file system setting must satisfy the following rule to indicate the presence of this application
    * Property: Version
    * Operator: Equals
    * Value: 5.13.1.8265
