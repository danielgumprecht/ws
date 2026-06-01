takeown /f C:\$WINDOWS.~BT /r /d y
icacls C:\$WINDOWS.~BT /grant administrators:F /t
Remove-Item /s /q C:\$WINDOWS.~BT
