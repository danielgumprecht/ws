Write-Host "Starting Windows upgrade process. This may take some time, please be patient." -ForegroundColor Cyan
.\setup.exe /auto upgrade /showoobe none /dynamicupdate disable /eula accept

Start-Sleep -Seconds 10

Write-Host "Upgrade process initiated. Please follow any on-screen prompts and do not interrupt the process." -ForegroundColor Green
cd 'C:\$WINDOWS.~BT\Sources\Panther\'
Get-Content .\setupact.log -tail 50 -wait
Start-Sleep -Seconds 10