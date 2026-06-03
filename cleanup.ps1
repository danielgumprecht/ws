Write-Host "Starting system cleanup..." -ForegroundColor Cyan

cleanmgr /verylowdisk
cleanmgr /autoclean

DISM /Online /Cleanup-Image /StartComponentCleanup /ResetBase

Write-Host "Stopping services for Windows Update and cleaning up temporary files..." -ForegroundColor Cyan

Stop-Service -Name "CryptSvc" -Force
Stop-Service -Name "bits" -Force

Remove-Item -Path "C:\Windows\SoftwareDistribution\Download\*" -Recurse -Force -Verbose

Write-Host "Starting services for Windows Update..." -ForegroundColor Cyan

Start-Service -Name "CryptSvc"
Start-Service -Name "bits"

Write-Host "Cleaning up additional temporary files and caches..." -ForegroundColor Cyan

Remove-Item -Path "C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Cache\*" -Recurse -Force -Verbose

Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -Verbose
Remove-Item -Path "$env:temp\*" -Recurse -Force -Verbose
Remove-Item -Path "C:\$Recycle.Bin\*" -Recurse -Force -Verbose

Write-Host "Cleaning up browser caches..." -ForegroundColor Cyan

Remove-Item -Path "$env:localappdata\Google\Chrome\User Data\Default\Cache\*" -Recurse -Force -Verbose
Remove-Item -Path "$env:localappdata\Microsoft\Edge\User Data\Default\Cache\*" -Recurse -Force -Verbose

Write-Host "Cleaning up Windows Update and installation files..." -ForegroundColor Cyan

Remove-Item -Path "C:\$WINDOWS.~BT" -Recurse -Force -Verbose
Remove-Item -Path "C:\$WINDOWS.~WS" -Recurse -Force -Verbose
Remove-Item -Path "C:\Windows.old" -Recurse -Force -Verbose

Write-Host "System cleanup completed!" -ForegroundColor Green