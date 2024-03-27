# Copy User Data
robocopy "\\192.168.16.99\RedirectedFolders\$env:USERNAME\Desktop" "\Users\$env:USERNAME\Desktop" /E /W:0 /V
robocopy "\\192.168.16.99\RedirectedFolders\$env:USERNAME\Eigene Dateien" "\Users\$env:USERNAME\Eigene Dateien" /E /W:0 /V
robocopy "\\192.168.16.99\profile$\$env:USERNAME.V6\Downloads" "\Users\$env:USERNAME\Downloads" /E /W:0 /V

# Copy Edge
Get-Process -Name msedge -ErrorAction SilentlyContinue | Stop-Process -Force
robocopy "\\192.168.16.99\clientapps$\_Backups\$env:USERNAME\Local\Microsoft\Edge" "\Users\$env:USERNAME\AppData\Local\Microsoft\Edge" /E /MIR /W:0 /V

# Copy Chrome
Get-Process -Name chrome -ErrorAction SilentlyContinue | Stop-Process -Force
robocopy "\\192.168.16.99\clientapps$\_Backups\$env:USERNAME\Local\Google" "\Users\$env:USERNAME\AppData\Local\Google" /E /MIR /W:0 /V

# Copy Firefox
Get-Process -Name firefox -ErrorAction SilentlyContinue | Stop-Process -Force
robocopy "\\192.168.16.99\clientapps$\_Backups\$env:USERNAME\Local\Mozilla" "\Users\$env:USERNAME\AppData\Local\Mozilla" /E /MIR /W:0 /V