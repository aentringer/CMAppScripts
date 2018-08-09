# FileZilla Installer - Version 3.35.2 - ConfigMgr

The scripts on this page are designed to install [FileZilla](https://filezilla-project.org/) using ConfigMgr Current Branch Application Deployment. This installer leverages the [PowerShell App Deployment Toolkit](http://psappdeploytoolkit.com/).

## Installation

1. Download the [FileZilla Installer](https://dl3.cdn.filezilla-project.org/client/FileZilla_3.35.2_win64-setup.exe) from the FileZilla website.
1. Download the [latest release](https://github.com/PSAppDeployToolkit/PSAppDeployToolkit/releases/latest) of PowerShell App Deployment Toolkit.
1. Download the [Deploy-Application.ps1](https://github.com/aentringer/CMAppScripts/raw/master/FileZilla/Deploy-Application.ps1) script from this repository.
1. Download the [fzdefaults.xml](https://github.com/aentringer/CMAppScripts/raw/master/FileZilla/Files/fzdefaults.xml) script from this repository.
1. Download the [AppDeployToolkitConfig.xml](https://github.com/aentringer/CMAppScripts/raw/master/FileZilla/AppDeployToolkit/AppDeployToolkitConfig.xml) script from this repository.
    * This file only changes the InstallUI_Timeout and InstallPrompt_PersistInterval values. You may alter by hand if you wish.
      * <InstallationUI_Timeout>13200</InstallationUI_Timeout>
      * <InstallationPrompt_PersistInterval>3600</InstallationPrompt_PersistInterval>
1. Extract the 'Toolkit' directory from the PowerShell App Deployment Toolkit
1. Place the FileZilla installer and fzdefaults.xml in the 'Files' directory
1. Overwrite the toolkit's 'Deploy-Application.ps1' and 'AppDeployToolkitConfig.xml' with this repository's files.
1. Rename 'Toolkit' directory to follow your organization's naming scheme (*version number, perhaps*)
1. Place the directory on your ConfigMgr Package Source
1. Build ConfigMgr Application according to your organization's procedures
1. Specify the Deploy-Application.exe installer in the the ConfigMgr Application Deployment Installation Program field:
    * Deploy-Application.exe -DeploymentType Install

## Uninstallation

1. Specify the Deploy-Application.exe uninstaller in the the ConfigMgr Application Deployment Installation Program field:
    * Deploy-Application.exe -DeploymentType Uninstall

## Detection Method

* Registry
  * Hive: HKEY_LOCAL_MACHINE
  * Key: SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FileZilla Client
  * Value: DisplayVersion
    * [X] This registry key is associated with a 32-bit application on 64-bit systems
  * Data Type: Version
  * [X] This registry setting must satisfy the following rule to indicate the presence of the application
    * Operator: Equals
    * Value: 3.35.2
