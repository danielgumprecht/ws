Write-Output "Executing system checks. This may take some time..."
chkdsk /scan /perf
Write-Output "Running chkdsk completed. Now running SFC and DISM to check for system integrity issues."
sfc /scannow
Write-Output "SFC scan completed. Now running DISM to check for component store corruption."
dism /online /cleanup-image /restorehealth
Write-Output "DISM scan completed. Now running SFC again to ensure all issues are resolved."
sfc /scannow
Write-Output "System check complete. Please review the results above for any issues."