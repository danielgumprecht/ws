takeown /F 'C:\$WINDOWS.~BT\' /R /D y
icacls 'C:\$WINDOWS.~BT\' /grant administrators:F /t
Remove-Item /s /q 'C:\$WINDOWS.~BT\'
