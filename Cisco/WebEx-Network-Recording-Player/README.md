# Cisco WebEx Network Recording Player - Version 32.12.5.2 - ConfigMgr

The scripts on this page are designed to install [Cisco WebEx Network Recording Player](https://www.webex.com/play-webex-recording.html) using ConfigMgr Current Branch Application Deployment. This installer leverages the [PowerShell App Deployment Toolkit](http://psappdeploytoolkit.com/).

## Installation

**You may encounter issues when deploying with PS App Deployment Toolkit. If you do, just deploy the MSI directly. This is a rather low-risk app if it closes on users.**

1. Download the [Cisco WebEx Network Recording Player Installer](https://akamaicdn.webex.com/client/WBXclient-32.12.5-2/nbr2player.msi) from the Cisco WebEx website.
    * *See [How Do I Download the WebEx Client?](https://collaborationhelp.cisco.com/article/en-us/WBX21270) for details on how to obtain these exact links.*
1. Download the [latest release](https://github.com/PSAppDeployToolkit/PSAppDeployToolkit/releases/latest) of PowerShell App Deployment Toolkit.
1. Download the [Deploy-Application.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Cisco/WebEx-Network-Recording-Player/Deploy-Application.ps1) script from this repository.
1. Download the [AppDeployToolkitConfig.xml](https://github.com/aentringer/CMAppScripts/raw/master/Cisco/WebEx-Network-Recording-Player/AppDeployToolkit/AppDeployToolkitConfig.xml) script from this repository.
    * This file only changes the InstallUI_Timeout and InstallPrompt_PersistInterval values. You may alter by hand if you wish.
      * <InstallationUI_Timeout>13800</InstallationUI_Timeout>
      * <InstallationPrompt_PersistInterval>1800</InstallationPrompt_PersistInterval>
1. Extract the 'Toolkit' directory from the PowerShell App Deployment Toolkit
1. Place the nbr2player.msi in the 'Files' directory
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
  * nbr2player.msi
    * MSI GUID: {68A02D43-A792-4C73-8D7F-0E74E0AF9BA9}
    * Version (Equals): 32.12.5.2
