setup.exe /auto upgrade /showoobe none /dynamicupdate disable /eula accept

cd 'C:\$WINDOWS.~BT\Sources\Panther\'
Get-Content .\setupact.log -tail 50 -wait