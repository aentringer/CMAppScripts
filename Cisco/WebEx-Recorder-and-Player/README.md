# Cisco WebEx Recorder and Player - Version 32.11.0.388 - ConfigMgr

The scripts on this page are designed to install [Cisco WebEx Recorder and Player](https://www.webex.com/play-webex-recording.html) using ConfigMgr Current Branch Application Deployment. This installer leverages the [PowerShell App Deployment Toolkit](http://psappdeploytoolkit.com/).

## Installation

**You may encounter issues when deploying with PS App Deployment Toolkit. If you do, just deploy the MSI directly. This is a rather low-risk app if it closes on users.**

1. Download the [Cisco WebEx Recorder and Player Installer](https://akamaicdn.webex.com/client/WBXclient-32.11.0-388/atrecply.msi "atrecply.msi") from the Cisco WebEx website.
    * *See [How Do I Download the WebEx Client?](https://collaborationhelp.cisco.com/article/en-us/WBX21270) for details on how to obtain these exact links.*
1. Download the [latest release](https://github.com/PSAppDeployToolkit/PSAppDeployToolkit/releases/latest) of PowerShell App Deployment Toolkit.
1. Download the [Deploy-Application.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Cisco/WebEx-Recorder-and-Player/Deploy-Application.ps1) script from this repository.
1. Download the [AppDeployToolkitConfig.xml](https://github.com/aentringer/CMAppScripts/raw/master/Cisco/WebEx-Recorder-and-Player/AppDeployToolkit/AppDeployToolkitConfig.xml) script from this repository.
    * This file only changes the InstallUI_Timeout and InstallPrompt_PersistInterval values. You may alter by hand if you wish.
      * <InstallationUI_Timeout>13800</InstallationUI_Timeout>
      * <InstallationPrompt_PersistInterval>1800</InstallationPrompt_PersistInterval>
1. Extract the 'Toolkit' directory from the PowerShell App Deployment Toolkit
1. Place the atrecply.msi in the 'Files' directory
1. Overwrite the toolkit's 'Deploy-Application.ps1' with this repository's script.
1. Overwrite the toolkit's 'AppDeployToolkitConfig.xml' with this repository's script.
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
  * atrecply.msi
    * MSI GUID: {CED00B01-A231-4A8F-8837-E6DD9AA679EE}
    * Version (Equals): 32.11.0.388
