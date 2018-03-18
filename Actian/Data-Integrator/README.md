# Pervasive Data Integrator - Version 9.2.7.31 - ConfigMgr

The scripts on this page are designed to install [Actian Data Integrator 9](https://www.actian.com/data-integration/dataconnect-integration/) using ConfigMgr Current Branch.

## Installation

1. Download the [Data Integrator 9 Installer](http://esd.actian.com/product/DataConnect/9.2/Windows_64-Bit/Data_Integrator/DataIntegrator9.exe/http) from the Actian website (requires login).
1. Specify the [Install-ActianDataIntegrator.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Actian/Data-Integrator/Install-ActianDataIntegrator.ps1 "Install-ActianDataIntegrator.ps1") file in the ConfigMgr Deployment Method Installation Box.

## Uninstallation

1. Specify the [Uninstall-ActianDataIntegrator.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Actian/Data-Integrator/Uninstall-ActianDataIntegrator.ps1 "Uninstall-ActianDataIntegrator.ps1") file in the ConfigMgr Deployment Method Uninstallation Box.

## Detection Method

* File System
  * Path: 'C:\Program Files (x86)\Investintech.com Inc\Able2Extract Professional 12.0'
  * File or folder name: 'Able2ExtractPro.exe'
  * Version (Equals): '12.0.3'
