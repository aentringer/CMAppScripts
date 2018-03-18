# iTunes - Version 12.7.2 - ConfigMgr

The scripts on this page are designed to install [iTunes](https://www.apple.com/itunes/) using ConfigMgr Current Branch.

## Installation

1. Download the [iTunes 64-bit Installer](https://secure-appldnld.apple.com/itunes12/091-45357-20180123-72201840-FFEA-11E7-92F9-85B67CCC33A9/iTunes64Setup.exe) from the Apple website.
1. Extract the following MSI files from the .exe and store them with the install script:
    * AppleApplicationSupport64.msi
    * AppleMobileDeviceSupport6464.msi
    * iTunes64.msi
1. Specify the [Install-iTunes.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Apple/iTunes/Install-iTunes.ps1 "Install-iTunes.ps1") file in the ConfigMgr Deployment Method Installation Box.
    * powershell.exe -ExecutionPolicy Bypass -File ".\Install-iTunes.ps1"

## Uninstallation

1. Specify the [Uninstall-iTunes.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Apple/iTunes/Uninstall-iTunes.ps1 "Uninstall-iTunes.ps") file in the ConfigMgr Deployment Method Uninstallation Box.
    * powershell.exe -ExecutionPolicy Bypass -File ".\Uninstall-iTunes.ps1"

## Detection Method

* Windows Installer
  * AppleApplicationSupport64.msi
    * GUID: {F0C4B709-8BF4-4A72-B527-12E7BF5482F8}
    * Version (Equals): 6.2.1
  * AppleMobileDeviceSupport6464.msi
    * GUID: {BD6778C5-6FA5-492A-ADD6-E706339C2A7B}
    * Version (Equals): 11.0.2.4
  * iTunes64.msi
    * GUID: {D7D4465C-B3B6-4BC1-B336-2803FB57BFAF}
    * Version (Equals): 12.7.2.60
