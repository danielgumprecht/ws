Write-Output "Starting Windows upgrade process. This may take some time, please be patient." -ForegroundColor Cyan
.\setup.exe /auto upgrade /showoobe none /dynamicupdate disable /eula accept

Write-Output "Upgrade process initiated. Please follow any on-screen prompts and do not interrupt the process." -ForegroundColor Green
cd 'C:\$WINDOWS.~BT\Sources\Panther\'
Get-Content .\setupact.log -tail 50 -wait