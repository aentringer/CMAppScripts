.\Remove-Font.ps1 "FiraCode-Bold.otf"
.\Remove-Font.ps1 "FiraCode-Light.otf"
.\Remove-Font.ps1 "FiraCode-Medium.otf"
.\Remove-Font.ps1 "FiraCode-Regular.otf"
.\Remove-Font.ps1 "FiraCode-Retina.otf"

Start-Sleep -Seconds 3

if (Get-ItemProperty 'HKLM:\SOFTWARE\FiraCode' -Name FiraCodeVersion -ErrorAction SilentlyContinue) {
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\FiraCode' -Name FiraCodeVersion -ErrorAction SilentlyContinue
}
