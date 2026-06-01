Write-Host "Executing system checks. This may take some time..." -ForegroundColor Cyan
chkdsk /scan /perf
Write-Host "Running chkdsk completed. Now running SFC and DISM to check for system integrity issues." -ForegroundColor Cyan
sfc /scannow
Write-Host "SFC scan completed. Now running DISM to check for component store corruption." -ForegroundColor Cyan
dism /online /cleanup-image /restorehealth
Write-Host "DISM scan completed. Now running SFC again to ensure all issues are resolved." -ForegroundColor Cyan
sfc /scannow
Write-Host "System check complete. Please review the results above for any issues." -ForegroundColor Green