$srv = Read-Host "enter SRV IP"

# Copy User Data
robocopy "\\$srv\RedirectedFolders\$env:USERNAME\Desktop" "\Users\$env:USERNAME\Desktop" /E /W:0 /V
robocopy "\\$srv\RedirectedFolders\$env:USERNAME\Eigene Dateien" "\Users\$env:USERNAME\Eigene Dateien" /E /W:0 /V
robocopy "\\$srv\profile$\$env:USERNAME.V6\Downloads" "\Users\$env:USERNAME\Downloads" /E /W:0 /V

# Copy Edge
Get-Process -Name msedge -ErrorAction SilentlyContinue | Stop-Process -Force
robocopy "\\$srv\clientapps$\_Backups\$env:USERNAME\Local\Microsoft\Edge" "\Users\$env:USERNAME\AppData\Local\Microsoft\Edge" /E /MIR /W:0 /V

# Copy Chrome
Get-Process -Name chrome -ErrorAction SilentlyContinue | Stop-Process -Force
robocopy "\\$srv\clientapps$\_Backups\$env:USERNAME\Local\Google" "\Users\$env:USERNAME\AppData\Local\Google" /E /MIR /W:0 /V

# Copy Firefox
Get-Process -Name firefox -ErrorAction SilentlyContinue | Stop-Process -Force
robocopy "\\$srv\clientapps$\_Backups\$env:USERNAME\Local\Mozilla" "\Users\$env:USERNAME\AppData\Local\Mozilla" /E /MIR /W:0 /V
