setup.exe /auto upgrade /showoobe none /dynamicupdate disable /eula accept

cd 'C:\$WINDOWS.~BT\Sources\Panther\'
Get-Content .\setupact.log -tail 50 -waitWrite-Output "System check complete. Please review the results above for any issues."