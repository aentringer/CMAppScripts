# iTunes - Version 12.7.4 - ConfigMgr

The scripts on this page are designed to install [iTunes](https://www.apple.com/itunes/) using ConfigMgr Current Branch.

## Installation

1. Download the [iTunes 64-bit Installer](https://secure-appldnld.apple.com/itunes12/091-76333-20180329-6D5B026C-32F7-11E8-A675-99BAB071F5CF/iTunes64Setup.exe) from the Apple website.
1. Extract the following MSI files from the .exe and store them with the install script:
    * AppleApplicationSupport64.msi
    * AppleMobileDeviceSupport6464.msi
    * iTunes64.msi
1. Specify the [Install-iTunes.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Apple/iTunes/Install-iTunes.ps1) file in the ConfigMgr Deployment Method Installation Box.
    * powershell.exe -ExecutionPolicy Bypass -File ".\Install-iTunes.ps1"

## Uninstallation

1. Specify the [Uninstall-iTunes.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Apple/iTunes/Uninstall-iTunes.ps1) file in the ConfigMgr Deployment Method Uninstallation Box.
    * powershell.exe -ExecutionPolicy Bypass -File ".\Uninstall-iTunes.ps1"

## Detection Method

* Windows Installer
  * AppleApplicationSupport64.msi
    * GUID: {0ECA3BB5-4410-414B-B226-241FF1C12CD0}
    * Version (Equals): 6.4
  * AppleMobileDeviceSupport6464.msi
    * GUID: {A05FDFEC-4377-49E0-82CB-B6D1386E89DA}
    * Version (Equals): 11.3.0.9
  * iTunes64.msi
    * GUID: {5581A594-89CB-4062-81C3-2E9F7A76FBE0}
    * Version (Equals): 12.7.4.76
