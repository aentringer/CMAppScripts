# Google Chrome Enterprise Installer - Version 68.0.3440.75 - ConfigMgr

The scripts on this page are designed to install [Google Chrome Enterprise](https://enterprise.google.com/chrome/chrome-browser/) using ConfigMgr Current Branch Application Deployment. This installer leverages the [PowerShell App Deployment Toolkit](http://psappdeploytoolkit.com/).

## Installation

1. Download the [Google Chrome Installer](https://enterprise.google.com/chrome/chrome-browser/thankyou.html?platform=win64bundle&usagestats=1) from the Google Chrome website.
1. Download the [latest release](https://github.com/PSAppDeployToolkit/PSAppDeployToolkit/releases/latest) of PowerShell App Deployment Toolkit.
1. Download the [Deploy-Application.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Google/Chrome/Deploy-Application.ps1) script from this repository.
1. Download the [master_preferences](https://github.com/aentringer/CMAppScripts/raw/master/Google/Chrome/Files/master_preferences) script from this repository.
1. Download the [AppDeployToolkitConfig.xml](https://github.com/aentringer/CMAppScripts/raw/master/Google/Chrome/AppDeployToolkit/AppDeployToolkitConfig.xml) script from this repository.
    * This file only changes the InstallUI_Timeout and InstallPrompt_PersistInterval values. You may alter by hand if you wish.
      * <InstallationUI_Timeout>13200</InstallationUI_Timeout>
      * <InstallationPrompt_PersistInterval>2700</InstallationPrompt_PersistInterval>
1. Extract the 'Toolkit' directory from the PowerShell App Deployment Toolkit
1. Place the Google Chrome installer and master_preferences in the 'Files' directory
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

* Windows Installer
  * googlechromestandaloneenterprise64.msi
    * MSI GUID: {3504AEE9-2997-371B-BA00-55BCB4760193}
    * Exists

AND

* File System
  * Type: File
  * Path: %ProgramFiles(x86)%\Google\Chrome\Application
  * File or folder name: chrome.exe
    * [X] This file or folder is associated with a 32-bit application on 64-bit systems
  * [X] The file system setting must satisfy the following rule to indicate the presence of this application
    * Property: Version
    * Operator: Equals
    * Value: 68.0.3440.75
