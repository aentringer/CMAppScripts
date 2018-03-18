# iTunes - Version 12.7.2 - ConfigMgr

The scripts on this page are designed to install [iTunes](https://www.apple.com/itunes/) using ConfigMgr Current Branch.

## Installation

1. Download the [iTunes 64-bit Installer](https://secure-appldnld.apple.com/itunes12/091-45357-20180123-72201840-FFEA-11E7-92F9-85B67CCC33A9/iTunes64Setup.exe) from the Apple website.
1. Extract the following MSI files from the .exe and store them with the install script:
    * AppleApplicationSupport64.msi
    * AppleMobileDeviceSupport6464.msi
    * iTunes64.msi
1. Specify the [Install-iTunes.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Apple/iTunes/Install-iTunes.ps1 "Install-iTunes.ps1") file in the ConfigMgr Deployment Method Installation Box.

## Uninstallation

1. Specify the [Uninstall-iTunes.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Apple/iTunes/Uninstall-iTunes.ps1 "Uninstall-iTunes.ps") file in the ConfigMgr Deployment Method Uninstallation Box.

## Detection Method

    * MSI-Based
    * I would recommend referencing the 'AppleApplicationSupport64.msi', 'AppleMobileDeviceSupport6464.msi', and 'iTunes64.msi' files
