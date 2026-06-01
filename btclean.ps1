takeown /F 'C:\$WINDOWS.~BT\' /R
icacls 'C:\$WINDOWS.~BT\' /grant administrators:F /t
Remove-Item /s /q 'C:\$WINDOWS.~BT\'
