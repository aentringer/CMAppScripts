$fontFiles = Get-ChildItem -Path $PSScriptRoot -Filter *.otf

foreach ($font in $fontFiles) {
  .\Add-Font.ps1 $font.FullName
}

if(-not (Test-Path 'HKLM:\SOFTWARE\FiraCode' -ErrorAction SilentlyContinue)) {
    mkdir 'HKLM:\SOFTWARE\FiraCode' | Out-Null
}
Set-ItemProperty -Path 'HKLM:\SOFTWARE\FiraCode' -Name FiraCodeVersion -Value '1.205' -Type String