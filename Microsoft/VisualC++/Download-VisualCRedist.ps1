<#
.SYNOPSIS
Downloads the latest Visual C++ Installers from versions 2008 - 2017

.DESCRIPTION
Downloads the latest Visual C++ Installers from versions 2008 - 2017
The folder structure is intended to be used with 'Install-VisualCRedist.ps1'

.EXAMPLE
PS> .\Download-VisualCRedist.ps1
Downloads the installers to a 'Files' directory in the same location as the Download-VisualCRedist.ps1 file

.EXAMPLE
PS> .\Download-VisualCRedist.ps1 -Path $env:USERPROFILE\Downloads
Downloads the installers to a 'Files' directory in the $env:USERPROFILE\Downloads directory

.NOTES
Links obtained from: https://support.microsoft.com/en-us/help/2977003/the-latest-supported-visual-c-downloads
Links obtained on: 7 Apr 2018

Author: Alex Entringer
Date: 7 Apr 2018
#>
param (
    [Parameter(Position=0, ValueFromPipeline=$true)]
    [ValidateScript({Test-Path $_ -PathType 'Container'})]
    $Path = $PSScriptRoot
)

$Date = Get-Date -Format ('yyyy-MM-dd')

# Create Root Directory
if (-not (Test-Path "$Path\VisualC++\$Date\Files")) {
    New-Item "$Path\VisualC++\$Date\Files" -ItemType Directory | Out-Null
}

#region Download Visual C++ 2008 Redist (x86 and x64)
if (-not (Test-Path "$Path\VisualC++\$Date\Files\2008")) {
    New-Item "$Path\VisualC++\$Date\Files\2008" -ItemType Directory | Out-Null
}

# Download Visual C++ 2008 Service Pack 1 x86 9.0.30729.6161
Start-BitsTransfer -Source 'https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x86.exe' -Destination "$Path\VisualC++\$Date\Files\2008\vcredist_x86.exe"
# Download Visual C++ 2008 Service Pack 1 x64 9.0.30729.6161
Start-BitsTransfer -Source 'https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x64.exe' -Destination "$Path\VisualC++\$Date\Files\2008\vcredist_x64.exe"
#endregion

#region Download Visual C++ 2010 Redist (x86 and x64)
if (-not (Test-Path "$Path\VisualC++\$Date\Files\2010")) {
    New-Item "$Path\VisualC++\$Date\Files\2010" -ItemType Directory | Out-Null
}

# Download Visual C++ 2010 Service Pack 1 x86 10.0.40219
Start-BitsTransfer -Source 'https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x86.exe' -Destination "$Path\VisualC++\$Date\Files\2010\vcredist_x86.exe"
# Download Visual C++ 2010 Service Pack 1 x64 10.0.40219
Start-BitsTransfer -Source 'https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x64.exe' -Destination "$Path\VisualC++\$Date\Files\2010\vcredist_x64.exe"
#endregion

#region Visual C++ Redistributable for Visual Studio 2012 Update 4 (x86 and x64)
if (-not (Test-Path "$Path\VisualC++\$Date\Files\2012")) {
    New-Item "$Path\VisualC++\$Date\Files\2012" -ItemType Directory | Out-Null
}

# Download Visual C++ Redistributable for Visual Studio 2012 Update 4 x86 11.0.61030
Start-BitsTransfer -Source 'https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x86.exe' -Destination "$Path\VisualC++\$Date\Files\2012\vcredist_x86.exe"
# Download Visual C++ Redistributable for Visual Studio 2012 Update 4 x64 11.0.61030
Start-BitsTransfer -Source 'https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x64.exe' -Destination "$Path\VisualC++\$Date\Files\2012\vcredist_x64.exe"
#endregion

#region Visual C++ 2013 Update 5 Redistributable (x86 and x64)
if (-not (Test-Path "$Path\VisualC++\$Date\Files\2013")) {
    New-Item "$Path\VisualC++\$Date\Files\2013" -ItemType Directory | Out-Null
}

# Download Visual C++ 2013 Update 5 Redistributable x86 12.0.40660
Start-BitsTransfer -Source 'http://download.microsoft.com/download/0/5/6/056dcda9-d667-4e27-8001-8a0c6971d6b1/vcredist_x86.exe' -Destination "$Path\VisualC++\$Date\Files\2013\vcredist_x86.exe"
# Download Visual C++ 2013 Update 5 Redistributable x64 12.0.40660
Start-BitsTransfer -Source 'http://download.microsoft.com/download/0/5/6/056dcda9-d667-4e27-8001-8a0c6971d6b1/vcredist_x64.exe' -Destination "$Path\VisualC++\$Date\Files\2013\vcredist_x64.exe"
#endregion

#region Visual C++ 2017 Redistributable (x86 and x64)
if (-not (Test-Path "$Path\VisualC++\$Date\Files\2017")) {
    New-Item "$Path\VisualC++\$Date\Files\2017" -ItemType Directory | Out-Null
}

# Download Visual C++ 2017 Redistributable x86 14.13.26020
Start-BitsTransfer -Source 'https://aka.ms/vs/15/release/vc_redist.x86.exe' -Destination "$Path\VisualC++\$Date\Files\2017\vc_redist.x86.exe"
# Download Visual C++ 2017 Redistributable x64 14.13.26020
Start-BitsTransfer -Source 'https://aka.ms/vs/15/release/vc_redist.x64.exe' -Destination "$Path\VisualC++\$Date\Files\2017\vc_redist.x64.exe"
#endregion
