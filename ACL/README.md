# ACL for Windows - Version 12.5.1.534 - ConfigMgr

The scripts on this page are designed to install [ACL Services Ltd's ACL Analytics for Windows](https://www.acl.com/products/acl-analytics/) using ConfigMgr Current Branch. This installer leverages the [PowerShell App Deployment Toolkit](http://psappdeploytoolkit.com/).

## Installation

1. Download the ACL for Windows installer from the ACL website (requires active support account).
1. Download the [latest 32-bit Access Database Engine](https://www.microsoft.com/en-us/download/details.aspx?id=13255 "AccessDatabaseEngine.exe")
    * *must be 32-bit, ACL does not use 64-bit version*
    * *If using 64-bit MS Office, must be installed **LAST***
1. Download the [latest 64-bit Visual C++ 2012 Redistributable](https://www.microsoft.com/en-us/download/details.aspx?id=30679)
1. Download the [latest 32-bit Visual C++ 2013 Redistributable](http://download.microsoft.com/download/0/5/6/056dcda9-d667-4e27-8001-8a0c6971d6b1/vcredist_x86.exe)
1. Download the [latest 32-bit Visual C++ 2017 Redistributable](https://aka.ms/vs/15/release/vc_redist.x86.exe)
    * *Technically, 2015 is required, but 2017 superseded*
1. Download the [latest 64-bit Visual C++ 2017 Redistributable](https://aka.ms/vs/15/release/vc_redist.x64.exe)
    * *Technically, 2015 is required, but 2017 superseded*
1. Download the [OpenXML SDK v2.5](https://www.microsoft.com/en-us/download/details.aspx?id=30425 "OpenXMLSDKV25.msi")
1. Download the [latest release](https://github.com/PSAppDeployToolkit/PSAppDeployToolkit/releases/latest) of PowerShell App Deployment Toolkit.
1. Download the [Deploy-Application.ps1](https://github.com/aentringer/CMAppScripts/raw/master/ACL/Deploy-Application.ps1) script from this repository.
1. Extract the 'Toolkit' directory from the PowerShell App Deployment Toolkit
1. Place the various installers from #1-7 in the 'Files' directory
    * Extract the AccessDatabaseEngine.exe to obtain the AceRedist.msi, as that is what is referenced by this installer.
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

    * I would recommend referencing the 'ACL for Windows.msi', 'AceRedist.msi', and 'OpenXMLSDKV25.msi' files, as those are the files which are specified for uninstallation.
    * The Visual C++ are not part of uninstallation, as they may be needed by other software on the system.
