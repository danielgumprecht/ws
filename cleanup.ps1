Write-Host "Starting system cleanup..." -ForegroundColor Cyan

$Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches"

Get-ChildItem $Path | ForEach-Object {
    New-ItemProperty `
        -Path $_.PsPath `
        -Name "StateFlags0001" `
        -Value 2 `
        -PropertyType DWord `
        -Force | Out-Null
}

cleanmgr /sagerun:1

DISM /Online /Cleanup-Image /StartComponentCleanup /ResetBase

Write-Host "Stopping services for Windows Update and cleaning up temporary files..." -ForegroundColor Cyan

Stop-Service -Name "CryptSvc" -Force
Stop-Service -Name "bits" -Force

Remove-Item -Path "C:\Windows\SoftwareDistribution\Download\*" -Recurse -Force -Verbose -ErrorAction SilentlyContinue

Write-Host "Starting services for Windows Update..." -ForegroundColor Cyan

Start-Service -Name "CryptSvc"
Start-Service -Name "bits"

Write-Host "Cleaning up additional temporary files and caches..." -ForegroundColor Cyan

Remove-Item -Path "C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Cache\*" -Recurse -Force -Verbose -ErrorAction SilentlyContinue

Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -Verbose -ErrorAction SilentlyContinue
Remove-Item -Path "$env:temp\*" -Recurse -Force -Verbose -ErrorAction SilentlyContinue
Remove-Item -Path "C:\$Recycle.Bin\*" -Recurse -Force -Verbose -ErrorAction SilentlyContinue

Write-Host "Cleaning up browser caches..." -ForegroundColor Cyan

Remove-Item -Path "$env:localappdata\Google\Chrome\User Data\Default\Cache\*" -Recurse -Force -Verbose -ErrorAction SilentlyContinue
Remove-Item -Path "$env:localappdata\Microsoft\Edge\User Data\Default\Cache\*" -Recurse -Force -Verbose -ErrorAction SilentlyContinue

Write-Host "Cleaning up temporary files..." -ForegroundColor Cyan

Remove-Item -Path "C:\temp" -Recurse -Force -Verbose -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Log Files" -Recurse -Force -Verbose -ErrorAction SilentlyContinue
Remove-Item -Path "C:\system.sav" -Recurse -Force -Verbose -ErrorAction SilentlyContinue
Remove-Item -Path "C:\OneDriveTemp" -Recurse -Force -Verbose -ErrorAction SilentlyContinue
Remove-Item -Path "C:\ProgramDataLogs" -Recurse -Force -Verbose -ErrorAction SilentlyContinue

Remove-Item 'C:\$WINDOWS.~BT' -Recurse -Force -Verbose -ErrorAction SilentlyContinue
Remove-Item 'C:\W11' -Recurse -Force -Verbose -ErrorAction SilentlyContinue

Write-Host "Cleaning up vendor-specific temporary files..." -ForegroundColor Cyan

Remove-Item -Path "C:\hpswsetup" -Recurse -Force -Verbose -ErrorAction SilentlyContinue
Remove-Item -Path "C:\nabletemp" -Recurse -Force -Verbose -ErrorAction SilentlyContinue
Remove-Item -Path "C:\SWSetup" -Recurse -Force -Verbose -ErrorAction SilentlyContinue
Remove-Item -Path "C:\compaq" -Recurse -Force -Verbose -ErrorAction SilentlyContinue
Remove-Item -Path "C:\hp" -Recurse -Force -Verbose -ErrorAction SilentlyContinue

Write-Host "System cleanup completed!" -ForegroundColor Green